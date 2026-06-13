-- 战员主界面 RoleDevelopMain
local RoleDevelopMainCtrl = BaseClass("RoleDevelopMainCtrl", BaseUICtrl)
local M = RoleDevelopMainCtrl
local EAttributeType = CS.GameBase.EAttributeType
local EQuality = EnumConst.EQuality
local tInsert = table.insert
local tRemove = table.remove
local tSort = table.sort
local MaskDissolveManager = CS.MaskDissolveManager
local EMaskType = EnumConst.EMaskType
local TaskType = TaskConst.TaskType

function M:Init()
    self.handlerTab = {self._OnClickLevel, -- 升级
    self._OnClickSkill, -- 技能
    self._OnClickCore, -- 核心
    self._OnClickGene, -- 基因
    self._OnClickProfile, -- 资料
    self._OnClickAwake, -- 觉醒
    self._OnClickSkin -- 皮肤
    }
    self:_InitConf()
    self.sortFunHandle = Bind(self, self._SortFunc)
    self._view.togglelst:Init(0, Bind(self, self.OnClickTab))
    ---从1 开始  1:升级 2:技能 3:核心 4:基因 5:资料 6:觉醒
    self.index = 0
    self._allCameraType = {DevelopCameraConfig.Type.Main, DevelopCameraConfig.Type.Skill, DevelopCameraConfig.Type.Core, DevelopCameraConfig.Type.Gene, DevelopCameraConfig.Type.Data, DevelopCameraConfig.Type.Main -- 觉醒使用属性坐标
    }
    self._refUIStateHandler = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_MAINUI_STATE, Bind(self, self._OnRefreshUIState))
    self._TempOnClickHero = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_CLICKHERO, Bind(self, self._OnSelect))
    self._TempRefHeroLevel = EventMgr:AddListener(UIMessageNames.ROLE_HERO_LVUP, Bind(self, self.RefHeroLevel))
    self._taskRefreshCallback = EventMgr:AddListener(UIMessageNames.TASK_TYPE_REFRESH, Bind(self, self.OnTaskRefresh))

    self.m_context = self:GetContext()
    self._view.RoleDevelopListCtrl:UpdateData(self)
end

function M:_InitConf()
    self.skillShowLv = ConfigHelper.GetSystemParams(347)
    self.geneShowLv = ConfigHelper.GetSystemParams(348)
    self.coreShowLv = ConfigHelper.GetSystemParams(349)
    self.awakeShowLv = ConfigHelper.GetSystemParams(350)
end

function M:OnEnter(jumpHeroId, index)
    self.model = ModuleMgr:GetInstance():GetCurrentModule()
    self.model:SetCoreEffectState(false)
    self:_OnSortTogChanged(self._sortType or 1)
    -- 步骤数据
    local heroId = self.m_context:GetSelectHeroId()

    if heroId > 0 then
        jumpHeroId = heroId
    end

    self:_GetAllShowHeroData(jumpHeroId)
    -- 这个地方会提前刷新 但是如果是基因或者其他页签会重复刷新列表 导致列表呗刷新两次 后期可以优化
    self:_RefHeroList()
    local selectHeroId = self.heroData:GetHeroId()

    if index <= 0 then
        index = nil
    end

    self.index = index or self.m_context:GetSelectTab() + 1

    local lv = self.heroData:GetLevel()
    local rare = self.heroData:GetHeroCfg().rare
    -- 选中英雄没有觉醒或者基因页签应该特殊处理
    if self.index == 3 then -- 核心
        local coreState = self:_getCoreState(rare, lv)
        if not coreState then
            self.index = 1
        end
    elseif self.index == 4 then -- 基因
        local geneState = self:_getGeneState(rare, lv)
        if not geneState then
            self.index = 1
        end
    elseif self.index == 6 then -- 觉醒
        local awakeState = self:_getAwakeState(rare, lv)
        if not awakeState then
            self.index = 1
        end
    end
    -- 时装会自己处理显示英雄
    -- if index ~= 7 then
    --     self:_OnSelect(selectHeroId)
    -- end

    if self.index and self.index > 0 then
        if self.index == 7 then
            self:_OnClickSkin()
        else
            self._view.togglelst:TabSelect(self.index - 1)
        end
    else
        self:_OnClickDevelop()
    end
    local faction = ConfigHelper.GetCfgPropByLua("role", selectHeroId, "faction")
    self.model:SetFaction(faction)
end

function M:SetTabSelect(idx)
    self._view.togglelst:TabSelect(idx)
    self:ToggleListState(idx ~= 4) -- 资料页签需要隐藏
end

function M:OnVisible()
    if not self.heroData or not self._showHeros then
        return
    end

    tSort(self._showHeros, self.sortFunHandle)

    if self.index == 6 then
        self:_FilterAwake()
    else
        self:_UpdateHeroList()
    end
    -- 从装扮跳转出来特殊处理
    if self.index == 7 then
        self.index = 0
        self:_OnClickDevelop()
    end
    if self.index == 1 then -- 升级界面
        local ctrl = UIContextMgr:GetInstance():GetCtrl(UIDefine.UIRoleLevelUp)
        if ctrl and ctrl.OnVisible then
            ctrl:OnVisible()
        end
    end
end

function M:OnClickTab(idx)
    self.index = idx + 1
    self.m_context:SelectTab(idx)
    DevelopHelper.CameraMove(self._allCameraType[self.index])
    self.handlerTab[self.index](self)
    -- 是否显示基因螺旋
    local module = ModuleMgr:GetInstance():GetCurrentModule()

    if module.SetGeneSpin then
        module:SetGeneSpin(self.index == 4)
    end
end

function M:OnBack()
    -- 觉醒
    if self.index == 6 then
        -- 关闭二级界面
        local UIAwakeCtrl = UIContextMgr:GetInstance():GetCtrl(UIDefine.UIAwake)

        if UIAwakeCtrl._openItem then
            UIAwakeCtrl:OnClickSelf()
            return false
        end
    end

    -- 基因
    if self.index == 4 then
        local UIGeneCtrl = UIContextMgr:GetInstance():GetCtrl(UIDefine.UIRoleGene)

        if UIGeneCtrl.m_CurPanel == UIGeneCtrl.m_PanelType.Detail then
            UIGeneCtrl:OnClose()
            return false
        end
    end

    -- 切换页签不是属性
    if self.index ~= 0 then
        self:_OnClickDevelop()
        return false
    end

    UIContextMgr:GetInstance():GetContext(UIDefine.RoleDevelopMain):Init()
    return true
end

---显示主页签内容
function M:_OnClickDevelop()
    self.index = 0
    DevelopHelper.CameraMove(DevelopCameraConfig.Type.Main)
    local heroId = self.heroData:GetHeroId()
    UIContextMgr:GetInstance():Show(UIDefine.UIRoleDevelop, self, heroId)
    self:CheckClosePriviousUI(UIDefine.UIRoleDevelop)
    self:SetBtnListState(false)
    self:SetListHeroState(true)
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    module:SetGeneSpin(false)
    self._view.RoleDevelopListCtrl:OnBtnCloseClick()
    self:SetRedPointState(2)
end

-- 升级
function M:_OnClickLevel()
    UIContextMgr:GetInstance():Show(UIDefine.UIRoleLevelUp, self.heroData:GetHeroId())
    self:CheckClosePriviousUI(UIDefine.UIRoleLevelUp)
    self:SetBtnListState(true)
    self:SetRedPointState(3)
end

-- 技能
function M:_OnClickSkill()
    UIContextMgr:GetInstance():Show("RoleSkillUI", self.heroData:GetHeroId())
    self:CheckClosePriviousUI("RoleSkillUI")
    self:SetBtnListState(true)
    self:_FilterSkill()
    self:SetRedPointState(3)
end

-- 核心
function M:_OnClickCore()
    UIContextMgr:GetInstance():Show(UIDefine.UIRoleCore, self.heroData:GetHeroId())
    self:CheckClosePriviousUI(UIDefine.UIRoleCore)
    self.model:SetCoreEffectState(true)
    self:_FilterCore()
    self:SetBtnListState(true)
    self:SetRedPointState(3)
end

-- 基因
function M:_OnClickGene()
    UIContextMgr:GetInstance():Show(UIDefine.UIRoleGene, self.heroData)
    self:CheckClosePriviousUI(UIDefine.UIRoleGene)
    self:_FilterGene()
    self:SetBtnListState(true)
    self:SetRedPointState(3)
end

-- 人设（资源）
function M:_OnClickProfile()
    UIContextMgr:GetInstance():Show("RoleProfileUI", self.heroData)
    self:CheckClosePriviousUI("RoleProfileUI")
    self:SetBtnListState(true)
    self:SetRedPointState(4)
end

-- 觉醒
function M:_OnClickAwake()
    UIContextMgr:GetInstance():Show(UIDefine.UIAwake, self.heroData:GetHeroId())
    self:CheckClosePriviousUI(UIDefine.UIAwake)
    self:_FilterAwake()
    self:SetBtnListState(true)
    self:SetRedPointState(3)
end

-- 皮肤
function M:_OnClickSkin()
    UIContextMgr:GetInstance():Show("RoleFashionUI", self.heroData:GetHeroId())
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    if module and module.SetGeneSpin then
        module:SetGeneSpin(false)
    end
end

--- 设置左侧Toggle是否显示
function M:SetBtnListState(state)
    self._view.tfBtnList:SetActive(state)
    if state then
        local selectHeroId = self.heroData:GetHeroId()
        self:_setHeroRedPoint(selectHeroId)
    end
end

--- 设置左侧Toggle和英雄item是否显示
function M:ToggleListState(state)
    self._view.togglelst:SetActive(state)
    if state then
        local selectHeroId = self.heroData:GetHeroId()
        self:_setHeroRedPoint(selectHeroId)
    end
end

-- 在养成主界面的时候展开或者关闭英雄列表修改相机位置
function M:SetMainPos(heroListNum)
    if self.index ~= 0 then
        return
    end
    if heroListNum == 1 then
        DevelopHelper.CameraMove(DevelopCameraConfig.Type.Main)
    elseif heroListNum == 2 then
        DevelopHelper.CameraMove(DevelopCameraConfig.Type.OpenHeroList)
    end
end

--- 设置英雄列表是否显示
function M:SetListHeroState(state)
    self._view.RoleDevelopListCtrl:SetActive(state)
end

function M:CheckClosePriviousUI(curUI)
    if self._curUIName and self._curUIName ~= curUI then
        UIContextMgr:GetInstance():Close(self._curUIName)

        if self._curUIName == UIDefine.UIRoleGene or self._curUIName == UIDefine.UIAwake or self._curUIName == UIDefine.UIRoleCore then
            self:_RefHeroList()
        end

        if self._curUIName == UIDefine.UIRoleCore then
            self.model:SetCoreEffectState(false)
        end
    end

    self._curUIName = curUI
    if curUI == UIDefine.UIAwake or curUI == UIDefine.UIRoleCore or curUI == UIDefine.UIRoleGene then
        self:HideHeroAndBg()
    else
        self:OpenHeroAndBg()
    end
    if self._curUIName ~= UIDefine.UIAwake then
        self._view.state:SetState(1)
        -- 由于养成主界面在初始化之后，立马关闭了左侧核心、技能等页签，导致它的自定义id被重置为-99，所以再次打开的时候，需要再次重置一下 xiaokun
        self:_RefrshItemData(true)
        MaskDissolveManager.Instance:Play(EMaskType.Light)
    else
        self._view.state:SetState(2)
        MaskDissolveManager.Instance:Play(EMaskType.Dark)
    end
end

-- 获取所有需要展示的英雄信息
function M:_GetAllShowHeroData(selectHeroId)
    -- 自己的所有英雄
    self._showHeros = {}
    local data = IHeroDataMgr:GetHerosByProfessinal(0)

    for i = 0, data.Count - 1 do
        local heroData = data[i]
        local heroId = heroData:GetHeroId()
        local skinId = heroData:GetSkinId()
        local profession = ConfigHelper.GetCfgPropByLua("role", heroId, "profession")
        local srcollViewData = {heroId=heroId, profession=profession, selectIndex=selectHeroId, skinId=skinId}
        -- 获取属性用来排序
        srcollViewData.level = heroData:GetLevel()
        srcollViewData.rare = heroData:GetHeroCfg().rare
        srcollViewData.friend = 0
        srcollViewData.attack = heroData:GetAttribute(EAttributeType.EAT_Damage) or 0
        srcollViewData.hp = heroData:GetAttribute(EAttributeType.EAT_MaxHP) or 0
        srcollViewData.sumon = heroData:GetAttribute(EAttributeType.EAT_Summon) or 0
        srcollViewData.redType = 2 -- 养成英雄item刷新红点
        tInsert(self._showHeros, srcollViewData)
    end

    tSort(self._showHeros, self.sortFunHandle)
    -- 排完序之后，如果没有选取当前英雄，则第一个
    -- 选择默认的
    if not selectHeroId or selectHeroId <= 0 then
        selectHeroId = self._showHeros[1].heroId

        for _, showHero in ipairs(self._showHeros) do
            -- 当前选中的
            showHero.selectIndex = selectHeroId
        end
    end

    self.heroData = IHeroDataMgr:GetMyHeroDataById(selectHeroId)
    self:_setHeroRedPoint(selectHeroId)
end

-- 设置红点
function M:_setHeroRedPoint(heroId)
    self._view.togglelst:SetRedPointParma(0, 0, heroId)
    self._view.togglelst:SetRedPointParma(2, 0, heroId)
    self._view.togglelst:SetRedPointParma(3, 0, heroId)
    self._view.togglelst:SetRedPointParma(3, 1, heroId)
    self._view.togglelst:SetRedPointParma(4, 0, heroId)
    self._view.togglelst:SetRedPointParma(5, 0, heroId)
    self._view.togglelst:SetRedPointCheck(0)
    self._view.togglelst:SetRedPointCheck(2)
    self._view.togglelst:SetRedPointCheck(3)
    self._view.togglelst:SetRedPointCheck(4)
    self._view.togglelst:SetRedPointCheck(5)
end

function M:_SortFunc(showHero1, showHero2)
    for i = 1, #self._allSortType do
        local prop = self._allSortType[i]

        if showHero1[prop] ~= showHero2[prop] then
            return showHero1[prop] > showHero2[prop]
        end
    end
    return showHero1.heroId < showHero2.heroId
end

function M:_RefHeroList(heroDatas, index)
    heroDatas = heroDatas or self._showHeros
    self._view.RoleDevelopListCtrl:RefHeroList(heroDatas, index)
end

function M:_UpdateHeroList()
    self._view.RoleDevelopListCtrl:UpdateList()
end

function M:_RefrshItemData(state)
    if not state then
        return
    end

    -- 这段代码啥意思看不懂
    self._view.RoleDevelopListCtrl:RefrehItem()
end

-- 排序条件改变
function M:_OnSortTogChanged(index)
    self._sortType = index
    self._allSortType = {[1]="level", -- 等级
    [2]="rare", -- 稀有度
    [3]="friend", -- 好感度
    [4]="attack", -- 攻击
    [5]="hp", -- 生命
    [6]="sumon" -- 部署费用
    }
    local removeData = self._allSortType[index]
    tRemove(self._allSortType, index)
    tInsert(self._allSortType, 1, removeData)
end

-- 切换英雄
function M:_OnSelect(heroId)
    local tempSelectHeroData
    for _, v in pairs(self._showHeros) do
        v.selectIndex = heroId
        if v.heroId == heroId then
            tempSelectHeroData = v
        end
    end
    self.heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    EventMgr:Broadcast(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, heroId)
    -- 不是基因和核心
    if self.index ~= 3 and self.index ~= 4 and self.index ~= 6 then
        DevelopHelper.ShowHeroModel(heroId, true, self.index == 0)
    end

    -- check 當切換到指定英雄的時候，左側菜單可能會有所不同
    self:_CheckToggleState()
    self.m_context:SelectHeroId(heroId)
    DevelopMgr:GetInstance():RemoveHeroId(heroId)
    RedPointMgr:ForceCheck(RedPointConst.HeroGetRedPointChecker)
    local faction = ConfigHelper.GetCfgPropByLua("role", heroId, "faction")
    self.model:SetFaction(faction)
end

-- 升级成功后刷新玩家等级
function M:RefHeroLevel(lv)
    local heroId = self.heroData:GetHeroId()
    local tempSelectHeroData
    for _, v in pairs(self._showHeros) do
        if v.heroId == heroId then
            tempSelectHeroData = v
            tempSelectHeroData.level = lv
            break
        end
    end
    self:_CheckToggleState(lv)
end

---任务变化用来刷新觉醒红点 qaq
function M:OnTaskRefresh(type)
    if type == TaskType.Awake then
        IRedPointMgr:ForceCheck(RedPointConst.RoleAwakeRedPointChecker)
    end
end

--- check 检查页签是否显示
function M:_CheckToggleState(lv)
    lv = lv or self.heroData:GetLevel()
    local rare = self.heroData:GetHeroCfg().rare
    -- 技能按钮是否显示
    local skillState = self:_getSkillState(rare, lv)
    self._view.togglelst:SetItemActive(1, skillState)
    -- 基因按钮是否显示
    local geneState = self:_getGeneState(rare, lv)
    self._view.togglelst:SetItemActive(3, geneState)
    -- 核心按钮是否显示
    local coreState = self:_getCoreState(rare, lv)
    self._view.togglelst:SetItemActive(2, coreState)
    -- 跃迁按钮是否显示
    local awakeState = self:_getAwakeState(rare, lv)
    self._view.togglelst:SetItemActive(5, awakeState)
    local selectHeroId = self.heroData:GetHeroId()
    self:_setHeroRedPoint(selectHeroId)
end

function M:_OnRefreshUIState(state)
    self:ToggleListState(state)
    self:SetListHeroState(state)
end

-- 关闭当前人物和背景
function M:HideHeroAndBg()
    self.model:HideHero()
    self.model:ClearSceneBg()
end

-- 打开当前人物和背景
function M:OpenHeroAndBg()
    local heroId = self.heroData:GetHeroId()
    DevelopHelper.ShowHeroModel(heroId, true, self.index == 0)
    self.model:SetSceneBg()
end

-- 技能筛选器
function M:_FilterSkill()
    local tempDatas = {}
    local isChange
    for i = 1, #self._showHeros do
        local rare = self._showHeros[i].rare
        local lv = self._showHeros[i].level

        if self:_getSkillState(rare, lv) then
            tInsert(tempDatas, self._showHeros[i])
        else
            isChange = true
        end
    end
    -- 没有改变 不需要刷新
    if not isChange then
        return
    end
    local index = self:GetHeroIndex(tempDatas)
    self:_RefHeroList(tempDatas, index)
end

-- 基因筛选器
function M:_FilterGene()
    local tempDatas = {}
    local isChange
    for i = 1, #self._showHeros do
        local rare = self._showHeros[i].rare
        local lv = self._showHeros[i].level

        if self:_getGeneState(rare, lv) then
            tInsert(tempDatas, self._showHeros[i])
        else
            isChange = true
        end
    end
    -- 没有改变 不需要刷新
    if not isChange then
        return
    end
    local index = self:GetHeroIndex(tempDatas)
    self:_RefHeroList(tempDatas, index)
end

-- 核心筛选器
function M:_FilterCore()
    local tempDatas = {}
    local isChange
    for i = 1, #self._showHeros do
        local rare = self._showHeros[i].rare
        local lv = self._showHeros[i].level

        if self:_getCoreState(rare, lv) then
            tInsert(tempDatas, self._showHeros[i])
        else
            isChange = true
        end
    end
    -- 没有改变 不需要刷新
    if not isChange then
        return
    end
    local index = self:GetHeroIndex(tempDatas)
    self:_RefHeroList(tempDatas, index)
end

-- 跃迁筛选器
function M:_FilterAwake()
    local tempDatas = {}
    local isChange
    for i = 1, #self._showHeros do
        local rare = self._showHeros[i].rare
        local lv = self._showHeros[i].level

        if self:_getAwakeState(rare, lv) then
            tInsert(tempDatas, self._showHeros[i])
        else
            isChange = true
        end
    end
    -- 没有改变 不需要刷新
    if not isChange then
        return
    end
    local index = self:GetHeroIndex(tempDatas)
    self:_RefHeroList(tempDatas, index)
end

---获取技能页签是否开放
function M:_getSkillState(rare, lv)
    return lv >= self.skillShowLv[rare - 1]
end

---获取基因页签是否开放
function M:_getGeneState(rare, lv)
    return lv >= self.geneShowLv[rare - 1]
end

---获取核心页签是否开放
function M:_getCoreState(rare, lv)
    return lv >= self.coreShowLv[rare - 1]
end

-- 获取跃迁页签是否开放
function M:_getAwakeState(rare, lv)
    if rare <= EQuality.R then
        return false
    end
    return lv >= self.awakeShowLv[rare - 3]
end

function M:SetRedPointState(redPointType)
    if self.redPointType == redPointType then
        return
    end
    for _, v in pairs(self._showHeros) do
        v.redType = redPointType
    end
    self.redPointType = redPointType
    self._view.RoleDevelopListCtrl:SetRedPointState(redPointType)
end

function M:GetHeroIndex(showHeros)
    for i, heroData in ipairs(showHeros) do
        if heroData.selectIndex == heroData.heroId then
            return i
        end
    end
end

function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_MAINUI_STATE, self._refUIStateHandler)
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_CLICKHERO, self._TempOnClickHero)
    EventMgr:RemoveListener(UIMessageNames.ROLE_HERO_LVUP, self._TempRefHeroLevel)
    EventMgr:RemoveListener(UIMessageNames.TASK_TYPE_REFRESH, self._taskRefreshCallback)
    M.super.OnDispose(self)
end

return RoleDevelopMainCtrl
