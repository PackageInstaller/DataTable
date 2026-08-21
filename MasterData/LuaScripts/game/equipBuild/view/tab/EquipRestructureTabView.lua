module("equipBuild.EquipRestructureTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("equipBuild/tab/EquipRestructureTab.prefab")
destroyTime = -1 -- 自动销毁时间-1默认

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    -- 当前装备数据vo
    self.m_equipVo = nil

    -- 当前是否打开材料背包
    self.m_isOpenMaterialBag = false
    -- 当前在背包选择的临时消耗材料列表
    self.m_tempSelectMaterialList = {}
    -- 当前选择的消耗材料列表
    self.m_selectMaterialList = {}
    -- 当前选择的消耗材料格子列表
    self.m_equipMaterialGridList = {}
end

function configUI(self)
    self.m_groupContent = self:getChildGO('GroupContent')
    self.m_groupEmpty = self:getChildGO('GroupEmptyTip')
    self.m_textTip = self:getChildGO('TextTip'):GetComponent(ty.Text)
    self.m_textTipEnglish = self:getChildGO('TextTipEnglish'):GetComponent(ty.Text)

    self.m_goShowEquip = self:getChildGO("ImgShowEquip")
    self.m_imgShowEquip = self.m_goShowEquip:GetComponent(ty.AutoRefImage)
    self.m_rectShowEquip = self.m_goShowEquip:GetComponent(ty.RectTransform)

    -- 核能技
    self.m_goNuclearSkill = self:getChildGO('ImgNuclearSkill')
    self.m_imgNuclearSkill = self.m_goNuclearSkill:GetComponent(ty.AutoRefImage)
    self.m_textNuclearSkillLvl = self:getChildTrans('TextNuclearSkillLvl'):GetComponent(ty.Text)
    self.m_textNuclearSkillName = self:getChildTrans('TextNuclearSkillName'):GetComponent(ty.Text)

    -- 属性
    self.m_groupAttr = self:getChildTrans("GroupAttr")

    -- 详细信息
    self.m_btnDetail = self:getChildGO("TextDetail")
    self.m_textDetail = self:getChildGO("TextDetail"):GetComponent(ty.Text)

    -- 材料
    self.m_textRestructureCostTip = self:getChildGO('TextRestructureCostTip'):GetComponent(ty.Text)
    self.m_scrollMaterial = self:getChildGO('ScrollMaterialBag'):GetComponent(ty.LyScroller)
    self.m_scrollMaterial:SetItemRender(equipBuild.EquipRestructureSelectItem)
    self.m_btnConfirm = self:getChildGO("BtnConfirm")
    -- 材料列表空物品提示
    self.m_goEquipEmpty = self:getChildGO('EquipEmptyTip')
    self.m_textEmptyTip = self:getChildGO('TextEmptyTip'):GetComponent(ty.Text)
    self.m_textEmptyTipEng = self:getChildGO('TextEmptyTipEnglish'):GetComponent(ty.Text)

    self.m_btnRestructure = self:getChildGO("BtnRestructure")
    self.m_textRestructure = self:getChildGO("TextRestructure"):GetComponent(ty.Text)
    self.m_imgCostIcon = self:getChildGO("ImgCostIcon"):GetComponent(ty.AutoRefImage)
    self.m_textCostTitle = self:getChildGO("TextCostTitle"):GetComponent(ty.Text)
    self.m_textCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
end

function active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_EQUIP_RESTRUCTURE, self.__onUpdateRestructureHandler, self)
    equipBuild.EquipRestructureManager:addEventListener(equipBuild.EquipRestructureManager.EQUIP_RESTRUCTURE_MATERIAL_SELECT, self.__onRestructureMaterialSelectHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
    self:__updateView()
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_EQUIP_RESTRUCTURE, self.__onUpdateRestructureHandler, self)
    equipBuild.EquipRestructureManager:removeEventListener(equipBuild.EquipRestructureManager.EQUIP_RESTRUCTURE_MATERIAL_SELECT, self.__onRestructureMaterialSelectHandler, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)

    self.m_isOpenMaterialBag = false
    self.m_tempSelectMaterialList = {}
    self.m_selectMaterialList = {}
end

function initViewText(self)
    self.m_textTip.text = _TT(71406)
    self.m_textTipEnglish.text = "THE  CHIP  CAN  NOT  BE  RESTRUCTURE"
    self.m_textDetail.text = _TT(71407)
    self.m_textRestructureCostTip.text = _TT(71408)
    self.m_textCostTitle.text = _TT(71409)
    self.m_textRestructure.text = _TT(1)
    self.m_textEmptyTip.text = _TT(71410)
    self.m_textEmptyTipEng.text = "NO CHIPS"
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_goNuclearSkill, self.__onClickNuclearSkillHandler)
    self:addUIEvent(self.m_btnRestructure, self.__onClickRestructureHandler)
    self:addUIEvent(self.m_goShowEquip, self.__onClickEquipTipHandler)
    self:addUIEvent(self.m_btnDetail, self.__onClickDetailHandler)
    self:addUIEvent(self.m_btnConfirm, self.__onClickConfirmMaterialHandler)
end

-- 是否可以关闭，由父面板触发
function __isCanSubViewClose__(self)
    if (self.m_isOpenMaterialBag) then
        self.m_isOpenMaterialBag = false

        self.m_tempSelectMaterialList = {}
        for i = 1, #self.m_selectMaterialList do
            table.insert(self.m_tempSelectMaterialList, self.m_selectMaterialList[i])
        end
        self:__updateView()
        return false
    else
        return true
    end
end

function __onClickEquipTipHandler(self)
    TipsFactory:equipTips(self.m_equipVo, nil, { rectTransform = self.m_rectShowEquip },false)
end

-- 点击查看核能技tip
function __onClickNuclearSkillHandler(self)
    -- 更新技能相关描述显示
    local skillEffectList, skillEffectDic = self.m_equipVo:getSkillEffect()
    if (skillEffectList and #skillEffectList > 0) then
        tips.NuclearSkillTips:showTips(skillEffectList, skillEffectList[1])
    end
end

-- 点击查看详细信息
function __onClickDetailHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_RESTRUCTURE_DETAIL_PANEL, { equipVo = self.m_equipVo })
end

-- 点击重构
function __onClickRestructureHandler(self)
    if (#self.m_selectMaterialList <= 0) then
        gs.Message.Show(_TT(71411))
    else
        local restructureVo = equipBuild.EquipRestructureManager:getRestructureVo(self.m_equipVo.tid)
        local costMoneyTid = restructureVo:getPayId()
        local costMoneyCount = restructureVo:getPayNum()
        if (MoneyUtil.judgeNeedMoneyCountByTid(costMoneyTid, costMoneyCount)) then

            local function onReqRestructureHandler()        
                GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_RESTRUCTURE, { heroId = self.m_equipVo.heroId, equipId = self.m_equipVo.id, costId = self.m_selectMaterialList[1].id })
            end
            UIFactory:alertMessge(_TT(71412),
        true, function() onReqRestructureHandler() end, _TT(1), nil,
        true, function() end, _TT(2),
            _TT(71413), nil, RemindConst.EQUIP_RESTRUCTURE)
            -- local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.EQUIP_RESTRUCTURE)
            --     if (isNotRemind) then
            --         onReqRestructureHandler()
            --     else
            --     local isNeedPopTip = true
            --     if (isNeedPopTip) then
                    
            --     else
            --         onReqRestructureHandler()
            --     end
            -- end
        end
    end
end

-- 背包更新
function __onBagUpdateHandler(self, args)
    local addList = args.addList
    local updateList = args.updateList
    local delList = args.delList
    if (#delList > 0) then
        self.m_tempSelectMaterialList = {}
        self.m_selectMaterialList = {}
    end
    self:__updateMaterialView(false)
end

-- 重构材料选择改变
function __onRestructureMaterialSelectHandler(self, args)
    local clickPropsVo = args
    local equipId = self.m_equipVo.id
    local isAdd = true
    local len = #self.m_tempSelectMaterialList
    for i = 1, len do
        if (self.m_tempSelectMaterialList[i].id == clickPropsVo.id) then
            table.remove(self.m_tempSelectMaterialList, i)
            isAdd = false
            break
        end
    end

    if (isAdd) then
        if (len == 1) then
            self.m_tempSelectMaterialList = {}
        end
        table.insert(self.m_tempSelectMaterialList, clickPropsVo)
    end

    self:__updateMaterialView(false)
end

-- 重构成功返回更新
function __onUpdateRestructureHandler(self, args)
    local heroId = args.heroId
    local equipId = args.equipId
    if (heroId == self.m_equipVo.heroId and equipId == self.m_equipVo.id) then
        self.m_tempSelectMaterialList = {}
        self.m_selectMaterialList = {}
        self:__updateView()
    end
end

-- 更新重构界面
function __updateView(self)
    self:__recoverAttrItemGoDic()
    self.m_equipVo = equipBuild.EquipBuildManager:getEquipVo()
    -- 检测装备是否可重构
    if (equipBuild.EquipRestructureManager:isEquipCanRestructure(self.m_equipVo.tid)) then
        self.m_imgShowEquip:SetImg(UrlManager:getPropsIconUrl(self.m_equipVo.tid), true)

        self.m_groupContent:SetActive(true)
        self.m_groupEmpty:SetActive(false)
        -- 更新核能属性相关描述显示
        local nuclearAttrList, nuclearAttrDic = self.m_equipVo:getNuclearAttr()
        if (nuclearAttrList and #nuclearAttrList > 0) then
            local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
            for i = 1, #nuclearAttrList do
                local nuclearAttrVo = nuclearAttrList[i]
                local nuclearAttrData = equipConfigVo.nuclearAttrDic[nuclearAttrVo.key]
                self:__addAttrItem(nuclearAttrVo.key, nuclearAttrVo.value, (nuclearAttrVo.value - nuclearAttrData.minValue) / (nuclearAttrData.maxValue - nuclearAttrData.minValue) * 100)
            end
        end

        self:__updateNuclearSkill()
        self:__updateMaterialView(true)
    else
        self.m_groupContent:SetActive(false)
        self.m_groupEmpty:SetActive(true)
    end
end

function __updateNuclearSkill(self)
    -- 更新技能相关描述显示
    local skillEffectList, skillEffectDic = self.m_equipVo:getSkillEffect()
    if (skillEffectList and #skillEffectList > 0) then
        for i = 1, #skillEffectList do
            local nuclearSkillData = skillEffectList[i]
            local des = equip.EquipSkillManager:getSkillDes(self.m_equipVo, nuclearSkillData)
            local skillVo = fight.SkillManager:getSkillRo(nuclearSkillData.skillId)
            local url = UrlManager:getSkillIconPath(skillVo:getIcon())
            self.m_imgNuclearSkill:SetImg(url, true)
            self.m_textNuclearSkillName.text = skillVo:getName()
            self.m_textNuclearSkillLvl.text = equip.EquipSkillManager:getSkillLvl(nuclearSkillData)
        end
    end
end

-- 更新材料相关显示
function __updateMaterialView(self, isInit)
    -- 更新材料背包
    self:setMaterialBagVisible(isInit, self.m_isOpenMaterialBag)
end

function setMaterialBagVisible(self, isInit, isShow)
    local restructureVo = equipBuild.EquipRestructureManager:getRestructureVo(self.m_equipVo.tid)
    if (not restructureVo) then
        Debug:log_error("EquipRestructureTabView", "找不到装备" .. self.m_equipVo.tid .. "的重构配置")
        return
    end
    isInit = isInit or self.m_scrollMaterial.Count <= 0
    self.m_isOpenMaterialBag = isShow
    self:getChildGO('GroupMaterialCost'):SetActive(not self.m_isOpenMaterialBag)
    self:getChildGO('GroupMaterialBag'):SetActive(self.m_isOpenMaterialBag)

    if (self:getMaterialBagVisible()) then
        -- 更新材料背包列表
        local scrollList = {}
        local list = restructureVo:getCostList()
        for i = 1, #list do
            local materialList = bag.BagManager:getPropsListByTid(list[i], self.m_equipVo.id, bag.BagType.Bag, true)
            for j = 1, #materialList do
                local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
                scrollVo:setDataVo(materialList[j])
                table.insert(scrollList, scrollVo)
            end
        end

        for i = 1, #scrollList do
            local propsScrollVo = scrollList[i]
            propsScrollVo:setSelect(false)
            local propsVo = propsScrollVo:getDataVo()
            for j = 1, #self.m_tempSelectMaterialList do
                if (propsVo.id == self.m_tempSelectMaterialList[j].id) then
                    propsScrollVo:setSelect(true)
                    break
                end
            end
        end

        self:recoverListData(self.m_scrollMaterial.DataProvider)
        if isInit then
            self.m_scrollMaterial.DataProvider = scrollList
        else
            self.m_scrollMaterial:ReplaceAllDataProvider(scrollList)
        end
        self.m_goEquipEmpty:SetActive(#scrollList <= 0)
    else
        -- 更新材料消耗
        for i = 1, #self.m_equipMaterialGridList do
            self.m_equipMaterialGridList[i]:poolRecover()
        end
        self.m_equipMaterialGridList = {}

        if (#self.m_selectMaterialList > 0) then
            for i = 1, #self.m_selectMaterialList do
                local equipMaterialVo = self.m_selectMaterialList[i]
                local grid = PropsSelectGrid:create(self:getChildTrans('MaterialCostContent'), equipMaterialVo)
                table.insert(self.m_equipMaterialGridList, grid)
                local function callFun()
                    self:setMaterialBagVisible(true, true)
                end
                grid:setCallBack(self, callFun)
            end
        else
            local grid = PropsAddGrid:create(self:getChildTrans('MaterialCostContent'), nil)
            table.insert(self.m_equipMaterialGridList, grid)
            local function callFun()
                self:setMaterialBagVisible(true, true)
            end
            grid:setCallBack(self, callFun)
        end

        -- 更新货币消耗显示
        local costMoneyTid = restructureVo:getPayId()
        local costMoneyCount = restructureVo:getPayNum()
        self.m_imgCostIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(costMoneyTid), true)
        self.m_textCost.text = costMoneyCount
    end
end

function recoverListData(self, list)
    if(list and #list > 0)then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function getMaterialBagVisible(self)
    return self.m_isOpenMaterialBag
end

function __onClickConfirmMaterialHandler(self)
    self.m_selectMaterialList = {}
    for i = 1, #self.m_tempSelectMaterialList do
        table.insert(self.m_selectMaterialList, self.m_tempSelectMaterialList[i])
    end

    self.m_isOpenMaterialBag = false
    self:__updateView()
end

function __addAttrItem(self, attrKey, attrValue, proportion)
    local attrItem = self:__getAttrItemGo("ItemAttr")
    attrItem.transform:SetParent(self.m_groupAttr, false)
    attrItem.transform:Find("TextAttrName"):GetComponent(ty.Text).text = AttConst.getName(attrKey) .. "+"
    attrItem.transform:Find("TextAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(attrKey, attrValue)

    -- -90°~90°
    local angle = proportion * 180 / 100
    angle = -(angle - 90)
    local imgPointer = attrItem.transform:Find("ImgPointer").gameObject.transform
    imgPointer.localEulerAngles = gs.Vector3(0, 0, angle)
    -- gs.TransQuick:Rotate(imgPointer, 0, 0, angle)
end

function __getGoUniqueName(self, goName)
    return self.__cname .. "_" .. goName
end

function __getAttrItemGo(self, goName)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        if (self.m_childGos and self.m_childGos[goName]) then
            go = gs.GameObject.Instantiate(self.m_childGos[goName])
        end
    end
    go:SetActive(true)
    self.m_AttrItemGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName }
    return go
end

function __recoverAttrItemGoDic(self)
    if (self.m_AttrItemGoDic) then
        for hashCode, data in pairs(self.m_AttrItemGoDic) do
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.m_AttrItemGoDic = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71413):	"重构提示"
	语言包: _TT(71412):	"重构会随机生成核能属性数值，是否继续？"
	语言包: _TT(71411):	"请选择消耗芯片材料"
	语言包: _TT(71410):	"暂无符合条件的芯片"
	语言包: _TT(71409):	"消耗"
	语言包: _TT(71408):	"添加芯片"
	语言包: _TT(71407):	"详细信息"
	语言包: _TT(71406):	"该芯片无法进行重构"
	语言包: _TT(2):	"取消"
	语言包: _TT(1):	"确定"
	语言包: _TT(1):	"确定"
]]
