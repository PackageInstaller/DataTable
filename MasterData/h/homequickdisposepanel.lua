---@class HomeQuickDisposePanel : HomeQuickDisposePanel_Generate
---##################### 【HomeQuickDisposePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HomeQuickDisposePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HomeQuickDisposePanel = require "HomeQuickDisposePanel_Generate"

local AreaClipTime = 0.5
local AreaBase = {

    Init = function(self)
        self.iconPos_n = self.iconImg_n.transform.localPosition
        self.iconScale_n = self.iconImg_n.transform.localScale
        self.iconPos_s = self.iconImg_s.transform.localPosition
        self.iconScale_s = self.iconImg_s.transform.localScale

        self.namePos_n = self.nameImg_n.transform.localPosition
        self.nameScale_n = self.nameImg_n.transform.localScale
        self.namePos_s = self.nameImg_s.transform.localPosition
        self.nameScale_s = self.nameImg_s.transform.localScale

        self.iconImg_s:SetActive(false)
        self.nameImg_s:SetActive(false)
    end,

    FadeIn = function(self)
        local img = self.image
        img:DOKill(false)
        img:DOFade(1, AreaClipTime)

        local iconTrs = self.iconImg_n.transform
        iconTrs:DOKill(false)
        iconTrs.localPosition = self.iconPos_n
        iconTrs.localScale = self.iconScale_n
        iconTrs:DOLocalMove(self.iconPos_s, AreaClipTime):SetEase(DG.Tweening.Ease.InOutCubic)
        iconTrs:DOScale(self.iconScale_s, AreaClipTime):SetEase(DG.Tweening.Ease.InOutCubic)

        local nameTrs = self.nameImg_n.transform
        nameTrs:DOKill(false)
        nameTrs.localPosition = self.namePos_n
        nameTrs.localScale = self.nameScale_n
        nameTrs:DOLocalMove(self.namePos_s, AreaClipTime):SetEase(DG.Tweening.Ease.InOutCubic)
        nameTrs:DOScale(self.nameScale_s, AreaClipTime):SetEase(DG.Tweening.Ease.InOutCubic)
    end,

    FadeOut = function(self)
        local img = self.image
        img:DOKill(false)
        img:DOFade(0, AreaClipTime)
        local iconTrs = self.iconImg_n.transform
        iconTrs:DOKill(false)
        iconTrs.localPosition = self.iconPos_s
        iconTrs.localScale = self.iconScale_s
        iconTrs:DOLocalMove(self.iconPos_n, AreaClipTime):SetEase(DG.Tweening.Ease.InOutCubic)
        iconTrs:DOScale(self.iconScale_n, AreaClipTime):SetEase(DG.Tweening.Ease.InOutCubic)

        local nameTrs = self.nameImg_n.transform
        nameTrs:DOKill(false)
        nameTrs.localPosition = self.namePos_s
        nameTrs.localScale = self.nameScale_s
        nameTrs:DOLocalMove(self.namePos_n, AreaClipTime):SetEase(DG.Tweening.Ease.InOutCubic)
        nameTrs:DOScale(self.nameScale_n, AreaClipTime):SetEase(DG.Tweening.Ease.InOutCubic)

        self.heroPoint:SetActive(false)
    end,

    HeroPointEffect = function(transform)
        local defScale = 0.35
        local scaleUpDuration = 0.1
        local elasticDuration = 0.2

        local startScale = defScale * 0.8
        local endScale = defScale * 1.2
        local norScale = defScale * 1
        transform.localScale = Vector3.one * startScale

        local seq = DOTween.Sequence()
        local canvasGroup = transform:GetComponent(TypeInfo.CanvasGroup)
        canvasGroup.alpha = 0

        ---@type ScaleButton
        local scaleBtn = transform:GetComponent(TypeInfo.ScaleButton)
        scaleBtn.interactable = false
        seq:Append(
            canvasGroup:DOFade(1, 0.2)
                :SetEase(DG.Tweening.Ease.InQuint)
        )
        seq:Append(
            transform:DOScale(endScale, scaleUpDuration)
                :SetEase(DG.Tweening.Ease.Linear)
        )
        seq:Append(
            transform:DOScale(norScale, elasticDuration)
                :SetEase(DG.Tweening.Ease.Linear)
        )
        seq:AppendCallback(function()
            scaleBtn.interactable = true
        end)
        seq:SetAutoKill()
        seq:Play()
        return seq
    end,

    Destroy = function(self)
        local img = self.image
        img:DOKill(false)
        local iconTrs = self.iconImg_n.transform
        iconTrs:DOKill(false)

        local nameTrs = self.nameImg_n.transform
        nameTrs:DOKill(false)
    end

}
AreaBase.__index = AreaBase

local scale = 2.857
local areaCfg = {
    [0] = {
        constId = 0,
        pos = Vector3.zero
    },
    [1] = {
        pos = Vector3.New(1183.486, 298.7143),
        constId = GE.CoustructionEnum.CommandRoom,
    },
    [2] = {
        pos = Vector3.New(444.4286, 637.8572),
        constId = GE.CoustructionEnum.Armory,
    },
    [3] = {
        pos = Vector3.New(-366.4286, -944.2857),
        constId = GE.CoustructionEnum.WS2,
    },
    [4] = {
        pos = Vector3.New(-366.4286, -944.2857),
        constId = GE.CoustructionEnum.Aluminum,
    },
    [5] = {
        pos = Vector3.New(-366.4286, -944.2857),
        constId = GE.CoustructionEnum.Steel,
    },
    --[[[6] = {
        pos = Vector3.New(-1369.286, -868.1428),
        constId = GE.CoustructionEnum.OilWell,
    },]]
}

--房间区域index
local homeIndex = {
    Main = 0,
    CommandRoom = 1,
    Armory = 2,
    WS2 = 3,
    Aluminum = 4,			--铝厂
	Steel = 5,				--钢场
	OilWell = 6,			--油井
    Max = 6,
}

function HomeQuickDisposePanel:InitLogic(data)
    self.curSelIndex = homeIndex.Main  --当前选中的区域index
    self.curConstId  = 0  --当前建筑id
    self.disposeRoleList = {} --当前建筑部署的角色
    self.maxRoleNum = 0  --当前建筑最大部署角色数
    self.curRoleNum = {}  --当前建筑当前部署角色数
    self.curSelPos = 1  --当期区域选中的角色部署位置
    self.curSelRoleId = 0

    self.homeSignalTypeList = {}  --房间能用的词条类型

    ---@type RoleHeadBoxData[]
    self.showRoleList = {} --展示的角色列表
    self.homeBoxList = {}  --家园区域格子列表
    self.areas = {}
    for i = 1, homeIndex.Max do
        local area = self["area" .. i]
        local area = {
            image = area.image,
            iconImg_n = area.iconImg_n,
            nameImg_n = area.nameImg_n,
            iconImg_s = area.iconImg_s,
            nameImg_s = area.nameImg_s,
            heroPoint = area.heroPoint,
        }
        area = setmetatable(area, AreaBase)
        area:Init()
        table.insert(self.areas, area)
    end
end

--function HomeQuickDisposePanel:StartCreating(time)
--
--end

--function HomeQuickDisposePanel:StartEnter(time)
--
--end

--function HomeQuickDisposePanel:StartRemoving(time)
--
--end

--function HomeQuickDisposePanel:StartExit(time)
--
--end

function HomeQuickDisposePanel:OnOpen(data, initiative)
    --CoveManager.instance()._buildingMgr:changeBtnState(false)

    local height = self.transform.rect.height;
    local defHeight = 1080
    local scale = height / defHeight
    local v3Scale = Vector3.New(scale, scale, scale)
    self.mapObj.transform.localScale = v3Scale
    if initiative then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.HomeQuickDispose, self)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            --self.animator:SetTrigger("out")
            --self.animOverCallBack:SetCallBack(function()
            UIMgr:closeSpecificUI(self)
            self.customBackPanel.customBackPanel:ClearBackFunc()

            --end)
        end)
    end
    self:ShowAreaEffect(homeIndex.Main, homeIndex.Main)
    self:refreshHomeList()
    DLuaTimer:DoAfter(0.01, function()
        self:takeHomelandShot()
    end)
    local walkOpen = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomeWalk) ~= GE.FunctionOpenState.Lock and true or false
    local patrolOpen = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomePatrol) ~= GE.FunctionOpenState.Lock and true or false
    self.walkBtn.open:SetActive(walkOpen)
    self.walkBtn.lock:SetActive(not walkOpen)
    self.patrolBtn.open:SetActive(patrolOpen)
    self.patrolBtn.lock:SetActive(not patrolOpen)
end

---右家园列表刷新
function HomeQuickDisposePanel:refreshHomeList()
    self.homeBoxList = {}

    self:FillTemplateContent(self.homeBox, self.content, #areaCfg + 1, function(index, homeBox)

        local cfg = areaCfg[index]
        if not cfg or cfg.constId == 0 then
            homeBox.main:SetActive(false)
            homeBox.lock:SetActive(true)
            return
        end
        homeBox.main:SetActive(true)
        homeBox.lock:SetActive(false)

        self:LoadSpriteAsync(string.format("Sprite/HomeIcon/img_deploy_icon_%d.png", cfg.constId), homeBox.icon.image)

        local constructCfg = Config.GetConstructionInfo(cfg.constId)
        homeBox.homeName.text.text = constructCfg.name

        local maxRole = 0
        local openLocation = self:GetConstOpenLocationIndex(cfg.constId)
        if openLocation ~= nil then
            maxRole = #openLocation
        end

        homeBox.haveRole:SetActive(maxRole == 0 or Me:getDisposeRoleNum(cfg.constId) < maxRole )

        homeBox.maxRole:SetActive(maxRole ~= 0 and Me:getDisposeRoleNum(cfg.constId) == maxRole)
        homeBox.num.text.text = string.format("%d/%d", Me:getDisposeRoleNum(cfg.constId), maxRole)
        homeBox.btn.scaleButton.onClick:RemoveAllListeners()
        homeBox.btn.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            self:gotoArea(index)
        end)
        self.homeBoxList[index] = homeBox
    end)
end

---前往区域动画
function HomeQuickDisposePanel:gotoArea(index)
    if index == self.curSelIndex then
        return
    end
    local beforeIndex = self.curSelIndex
    self.curSelIndex = index
    self.mask:SetActive(true)
    local cfg = areaCfg[index]
    self.curConstId = cfg.constId
    for key, homeBox in pairs(self.homeBoxList) do
        homeBox.isSelect:SetActive(index == key)
    end

    if index ~= homeIndex.Main then
        self:refreshHomeDetail()
    end
    self:FocusOnLocation(index, function()
        self:onGotoEnd(beforeIndex, index)
    end)
    self:ShowAreaEffect(beforeIndex, index)
   
end

---前往区域动画结束后处理刷新
function HomeQuickDisposePanel:onGotoEnd(beforeIndex, index)
    if index == homeIndex.Main then
        --self.functionArea:SetActive(true)
        --self.buttomBg.animation:Play("ButtomOut")
        self.buttomBg.rectTransform:DOAnchorPosY(-360, 0.3):SetEase(DG.Tweening.Ease.OutQuart)
        self.walkBtn:SetActive(true)
        self.patrolBtn:SetActive(true)
        self.quickDisposeBtn:SetActive(true)
        --self.homeDeatil:SetActive(false)
    else
        if beforeIndex == homeIndex.Main then
            --self.buttomBg.animation:Play("ButtomIn")
            self.buttomBg.rectTransform:DOAnchorPosY(0, 0.3):SetEase(DG.Tweening.Ease.OutQuart)
            self.walkBtn:SetActive(false)
            self.patrolBtn:SetActive(false)
        end
        --self.homeDeatil:SetActive(true)
        self.quickDisposeBtn:SetActive(false)
        --self.functionArea:SetActive(false)
    end
    self.mask:SetActive(false)

end

function HomeQuickDisposePanel:refreshHomeDetail(playeffect, index)
    -- for i = 1, 6 do
    --   self["home"..i]:SetActive(index == i)
    -- end
    if playeffect == nil then
       playeffect = true 
    end
    if index == nil then
       index = 1 
    end
    self.maxRoleNum = 0
    local cfg = Config.GetConstructionInfo(self.curConstId);
    if cfg ~= nil then  
        self.maxRoleNum = cfg.workChara
    end
    
    self.curRoleNum = {}
    local serverData = Me:getConstructionDataById(self.curConstId)
    if serverData ~= nil then
        ---@type ConstructionLevelTable
        local levelCfg = Config.GetConstructionLevelInfoByTypeLevel(self.curConstId, serverData.level)

        local effect = levelCfg.effect
        if effect ~= nil then
            for _, v in pairs(effect) do
                if v[1] == 2 then 
                    tablex.move(v, 2, #v, 1, self.curRoleNum)
                    break
                end
            end
        end
    end
    self.curSelPos = index
   
    self.disposeRoleList = Me:getDisposeRole(self.curConstId)
    --self:refreshRoleList(true)
    self:fillTagData()
    
    --head data
    self.showRoleList = {}
    local roleList = ClientData:GetRoleList()
    for _, role in pairs(roleList) do
        local roleCfg = Config.GetCharacterInfo(role.id)
        if roleCfg and roleCfg.isSpecial == 0 then
            ---@type RoleHeadBoxData
            local temp = {
                roleId = role.id,
                showTag = true,
                tagData = self:getRoleCanUseSignal(role.id),
                isPure = true,
            }
            table.insert(self.showRoleList, temp)
        end
    end
    self:onPosSelChange(playeffect)
end

function HomeQuickDisposePanel:fillTagData()
    ---can use signal type
    ---@type ConstructionTable
    self.constructCfg = Config.GetConstructionInfo(self.curConstId)
    if not self.constructCfg then
        return
    end
    self.homeSignalTypeList = Config.GetConstructionInfoTagType(self.curConstId)
    -- if tablex.size(self.constructCfg.signalType) == 1 then
    --     self.homeSignalTypeList = self.constructCfg.signalType[1]
    -- else
    --     for _, typeList in pairs(self.constructCfg.signalType) do
    --         self.homeSignalTypeList = tablex.combine(self.homeSignalTypeList, typeList)
    --     end
    -- end
end

function HomeQuickDisposePanel:refreshRoleList(playRoleEffect)

    self.heroPointSeqs = self.heroPointSeqs or {}
    for i = 1, #self.heroPointSeqs do
        local seq = self.heroPointSeqs[i]
        if seq:IsActive() then
            seq:Kill(true)
        end
    end
    self.heroPointSeqs = {}

    self:FillTemplateContent(self.roleHead, self.headList, self.maxRoleNum, function(index, roleHead)
        if self.curConstId == GE.CoustructionEnum.CommandRoom then
            roleHead.pos.text.text = LocalStrEnum["ConstructionJobName_1000" .. index]
        else
            roleHead.pos.text.text = LocalStrEnum["VarietyDescribe_10009"..(index - 1)]
        end

        local isOpen = tablex.find(self.curRoleNum, index)
        if isOpen then
             roleHead.lock:SetActive(false)
            local roleId = self.disposeRoleList[index]
            if roleId == 0 or roleId == nil then
                roleHead.roleImg:SetActive(false)
                roleHead.add:SetActive(true)
            else
                roleHead.roleImg:SetActive(true)
                roleHead.add:SetActive(false)

                local roleData = Me:getPlayerHero(roleId)
                if not roleData then
                    return
                end
                local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
                local function is_numeric(str)
                    return tonumber(str) ~= nil
                end
                local resourceFolder = nil
                if is_numeric(skinConfig.resourceFolder) then
                    resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
                else
                    resourceFolder = skinConfig.resourceFolder
                end
            
                local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
                self:LoadSpriteAsync(iconPath, roleHead.roleImg.image)
            end
        else
            roleHead.roleImg:SetActive(false)
            roleHead.add:SetActive(false)
            roleHead.lock:SetActive(true)
        end
       
        roleHead.sel:SetActive(self.curSelPos == index)
        roleHead.scaleButton:SetBaseScale(Vector3.New(0.35, 0.35, 0.35))
        roleHead.scaleButton:SetScalePercent(1/7)
        roleHead.scaleButton.onClick:RemoveAllListeners()
        roleHead.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            self.curSelPos = index
            roleHead.sel:SetActive(true)
            self:refreshHomeDetail(false, index)
        end)

        local jg = 140
        --local index = self.curSelIndex
        local trs = self["area" .. self.curSelIndex].heroPoint.transform
        ---@type UnityEngine.Transform
        local heroPointTrs = trs:Find("point_" .. index)
        local scale = self["area" .. self.curSelIndex].rectTransform.localScale
        local pos = heroPointTrs.localPosition
        pos = Vector3.New(pos.x * (1/scale.x), pos.y * (1/scale.y))
        local pos1 = trs:TransformPoint(pos)

        --local pos2 = self.headList.transform:InverseTransformPoint(pos1)

       
        roleHead.transform.position = pos1

        roleHead.transform.localScale = Vector3.one * 0.35
        local canvasGroup = roleHead.transform:GetComponent(TypeInfo.CanvasGroup)
        canvasGroup.alpha = 1
        if playRoleEffect then
            local seq = AreaBase.HeroPointEffect(roleHead.transform)
            table.insert(self.heroPointSeqs, seq)
        end
    end)
end

--角色填充位置选择改变
function HomeQuickDisposePanel:onPosSelChange(playRoleEffect)
    self.curSelRoleId = self.disposeRoleList[self.curSelPos] or 0
    self:refreshRoleList(playRoleEffect)
    self:sortShowRole()
    -- self:fillTagData()
    self:fillHeadData()
    self:refreshIconList()
end

function HomeQuickDisposePanel:sortShowRole()
    table.sort(self.showRoleList, function (a, b)
        return a.roleId < b.roleId
    end)
end

function HomeQuickDisposePanel:fillHeadData()
    local homeDisposeRoleList = Me:getInHomeDisposeRole()
    for _, v in pairs(self.showRoleList) do
        v.isSel = tablex.find(homeDisposeRoleList, v.roleId)
        if self.curSelRoleId == 0 or self.curSelRoleId == nil then
            v.isGray = false
        else
            v.isGray = v.roleId ~= self.curSelRoleId
        end
        v.clickFunc = function()
            -- if v.isGray then
            --     --TODO 提示
            --     return
            -- end
            --在部署中就进行提示
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            if tablex.find(homeDisposeRoleList, v.roleId) and v.roleId ~= self.curSelRoleId then
                UICommonUtils.PopOkCancelBox(LocalStrEnum.ChangeCharacterJobTitle, LocalStrEnum.ChangeCharacterJob, function()
                    self:changeDispose(v.roleId)
                end)
            else
                self:changeDispose(v.roleId)
            end
        end
    end
end

function HomeQuickDisposePanel:changeDispose(roleId)
    local roleIdList = self.disposeRoleList
    for i = 1, self.maxRoleNum do
        roleIdList[i] = self.disposeRoleList[i]
        if roleIdList[i] == roleId then
            roleIdList[i] = 0
        end
    end

    if roleId == self.curSelRoleId then
        --取消选择
        roleIdList[self.curSelPos] = 0
    else
        --选择
        roleIdList[self.curSelPos] = roleId
    end
    local data = {
        constructionId = self.curConstId,
        heroIdList = roleIdList
    }
    Me:setHomeDisposeHeroReq(data, function()
        self.curSelRoleId = roleId
        self.disposeRoleList = roleIdList
        --self:refreshRoleList()
        self:refreshHomeDetail(false)
        self:onPosSelChange()
        self:refreshHomeList()
    end)
end

--刷新角色头像列表
function HomeQuickDisposePanel:refreshIconList()

    local isOpen = tablex.find(self.curRoleNum, self.curSelPos)
    self.roleIconList:SetActive(isOpen)
    if not isOpen then
       return
    end
    self:FillTemplateContent(self.roleHeadBox, self.roleIconList, tablex.size(self.showRoleList), function (index, itemObj)
        --itemObj.transform.localScale = Vector3.New(0.9, 0.9, 1)
        ---@type RoleHeadBox
        local roleHeadBox = itemObj.roleHeadBox
        roleHeadBox:setMono(self)
        roleHeadBox:refreshUI(self.showRoleList[index])
        --roleHeadBox.tagBg.rectTransform.anchoredPosition = Vector2.New(0, -128)
        --roleHeadBox.noTag.rectTransform.anchoredPosition = Vector2.New(-10, -135)
    end)
end

function HomeQuickDisposePanel:OnClose(initiative)
    --self.minimap:SetActive(false)
    --CoveManager.instance():ChangeVCam(self.cameraObj, false, false)
    -- CoveManager.instance().homeQuickVcamObj:SetActive(false)
end

function HomeQuickDisposePanel:OnDestroy()
    if self.heroPointSeqs ~= nil then
        for i = 1, #self.heroPointSeqs do
            local seq = self.heroPointSeqs[i]
            if seq:IsActive() then
                seq:Kill()
            end
        end
        self.heroPointSeqs = nil
    end
    self.super:OnDestroy(self)
end

function HomeQuickDisposePanel:getRoleCanUseSignal(roleId)
    local roleTagList = Me:getHeroTagList(roleId)
    if not roleTagList then
        return nil
    end
    for _,v in pairs(roleTagList) do
        ---@type SignalTable
        local tagData = Config.SignalInfo(v)
        if tagData.type == GE.TagType.dwelling and self:canUseSignal(tagData) then
            return tagData
        end
    end
    return nil
end

---该房间能否使用该类型的词条,非词条表的词条类型
function HomeQuickDisposePanel:canUseSignal(tagData)
    if not tagData or not tagData.effect then
        return false
    end

    if self.curConstId ~= GE.CoustructionEnum.CommandRoom then
        local signalType = tagData.useType
        for _,v in pairs(self.homeSignalTypeList) do
            if v == signalType then
                return true
            end
        end
    else
        local type = self.homeSignalTypeList[self.curSelPos]
        local signalType = tagData.useType
        if signalType == type then
        return true
        end
    end

    return false
end

function HomeQuickDisposePanel:takeHomelandShot()
    UIMgr:hideClickEffect()
    --self.minimap:SetActive(true)
end

--function HomeQuickDisposePanel:OnRefresh(data)
--
--end

--[[
/Bg onClick 
--]]
function HomeQuickDisposePanel:bg_Button_onClick(bg)
    self:gotoArea(homeIndex.Main)
end

--[[
/QuickDisposeBtn onClick 
--]]
function HomeQuickDisposePanel:quickDisposeBtn_ScaleButton_onClick(quickDisposeBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    UICommonUtils.PopToast(LocalStrEnum.VarietyDescribe_100089)
    local roleList = self:getRoleList()
    local roleNum = tablex.size(roleList)
    if roleNum == 0 then
        return
    end
    local roleIndex = 1
    local constructionMap = Me:getConstructionMapData()
    local homeDisposesHero = {}
    for constructId, homeBulidInfo in pairs(constructionMap) do
        local constructCfg = Config.GetConstructionInfo(constructId)
		if constructCfg.workChara > 0 and homeBulidInfo.disposeHeroList and roleIndex <= roleNum then
            local tempRoleList = homeBulidInfo.disposeHeroList

            local curRoleNum = {}
            local serverData = Me:getConstructionDataById(constructId)
            ---@type ConstructionLevelTable
            local levelCfg = Config.GetConstructionLevelInfoByTypeLevel(constructId, homeBulidInfo.level)
            if levelCfg == nil then
                LuaLogger.es("家园建筑配置错误 id:" .. constructId .. "  lv:" .. homeBulidInfo.level)
                goto continue
            end
            if homeBulidInfo.level <= 0 then
               goto continue 
            end
            local effect = levelCfg.effect
            if effect ~= nil then
                for _, v in pairs(effect) do
                    if v[1] == 2 then 
                        tablex.move(v, 2, #v, #curRoleNum + 1, curRoleNum)
                        break
                    end
                end
            end

            for i=1, #curRoleNum do
                local index = curRoleNum[i]
                if tempRoleList[index] == 0 then
                    tempRoleList[index] = roleList[roleIndex]
                    roleIndex = roleIndex + 1
                    if roleIndex > roleNum then
                        break
                    end
                end
            end

            local data = {
                constructionId = constructId,
                heroIdList = tempRoleList
            }
            table.insert(homeDisposesHero, data)
            ::continue::
        end
    end
    if #homeDisposesHero == 0 then
       return 
    end
    Me:setHomeDisposesHeroReq(homeDisposesHero, function()
        self:refreshHomeList()
    end)

    -- DLuaTimer:DoAfter(0.5, function()
    --     self:refreshHomeList()
    -- end)
end

function HomeQuickDisposePanel:getRoleList()
    local tempList = {}
    local heroList = ClientData:GetRoleList()
    local homeDisposeRoleList = Me:getInHomeDisposeRole()
	for k, v in pairs(heroList) do
		if tablex.find(homeDisposeRoleList, v.id) == false then
            local cfg = Config.GetCharacterInfo(v.id)
            if cfg and cfg.isSpecial == 0 then
                table.insert(tempList, v.id)
            end
		end
	end
    return tempList
end

--[[
/WalkBtn onClick 
--]]
function HomeQuickDisposePanel:walkBtn_ScaleButton_onClick(walkBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomeWalk)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
        return
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.HomeWalk})
    end
    UIMgr:popUI("HomeWalkPanel", {})
end

--[[
/HomeListBg/HomeList/Viewport/Content/HomeBox/Btn onClick 
--]]
function HomeQuickDisposePanel:btn_ScaleButton_onClick(btn)

end

--[[
/HomeDeatil/HeadList/RoleHead onClick 
--]]
function HomeQuickDisposePanel:roleHead_ScaleButton_onClick(roleHead)

end

--[[
/FunctionArea/Area1 onClick 
--]]
function HomeQuickDisposePanel:area1_ScaleButton_onClick(area1)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:gotoArea(homeIndex.CommandRoom)
end

--[[
/FunctionArea/Area2 onClick 
--]]
function HomeQuickDisposePanel:area2_ScaleButton_onClick(area2)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:gotoArea(homeIndex.Armory)
end

--[[
/FunctionArea/Area3 onClick 
--]]
function HomeQuickDisposePanel:area3_ScaleButton_onClick(area3)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:gotoArea(homeIndex.WS2)
end

--[[
/FunctionArea/Area4 onClick 
--]]
function HomeQuickDisposePanel:area4_ScaleButton_onClick(area4)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:gotoArea(homeIndex.Aluminum)
end

--[[
/FunctionArea/Area5 onClick 
--]]
function HomeQuickDisposePanel:area5_ScaleButton_onClick(area5)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:gotoArea(homeIndex.Steel)
end

--[[
/FunctionArea/Area6 onClick 
--]]
function HomeQuickDisposePanel:area6_ScaleButton_onClick(area6)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self:gotoArea(homeIndex.OilWell)
end

---获得当前建筑开发栏位信息
---@param constId integer
---@return table?
function HomeQuickDisposePanel:GetConstOpenLocationIndex(constId)

    local serverData = Me:getConstructionDataById(constId)

    local openLocationTab = nil
    if serverData == nil then
        return nil
    end
    ---@type ConstructionLevelTable
    local levelCfg = Config.GetConstructionLevelInfoByTypeLevel(constId, serverData.level)
    if levelCfg == nil then
        LuaLogger.es("获取建筑等级信息错误 id:" .. constId .. "  level:" .. serverData.level)
        return nil
    end
    local effect = levelCfg.effect
    if effect ~= nil then
        for _, v in pairs(effect) do
            if v[1] == 2 then 
                openLocationTab = {}
                tablex.move(v, 2, #v, 1, openLocationTab)
                break
            end
        end
    end
    return openLocationTab
end

--[[
/AdjustRoot/PatrolBtn onClick 
--]]
function HomeQuickDisposePanel:patrolBtn_ScaleButton_onClick(patrolBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomePatrol)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
        return
    end
    if state == GE.FunctionOpenState.Open then
        Me:readFunctionReq({functionId = GE.FunctionOpenModule.HomePatrol})
    end
    UIMgr:popUI("HomePatrolPanel", {})
end

function HomeQuickDisposePanel:FocusOnLocation(index, callback)

    ---@type UnityEngine.RectTransform
    local mapTrs = self.mapObj.rectTransform
    if index == nil or index == homeIndex.Main then
        mapTrs:DOScale(1, 0.5):OnComplete(function()
            callback()
        end)
        mapTrs:DOLocalMove(Vector3.zero, 0.5)
        return
    end

    local cpos = mapTrs.localPosition
    local toPos = areaCfg[index].pos
    local dis = Vector3.Distance(cpos, toPos)
    local time = (dis / 1000) * 0.5
    time = math.max(time, 0.5)
    
    mapTrs:DOLocalMove(toPos, time):OnComplete(function()
        callback()
    end)
    mapTrs:DOScale(scale, time)
end

function HomeQuickDisposePanel:ShowAreaEffect(beforeIndex, index)

    local area_b = self.areas[beforeIndex]
    if area_b ~= nil then
        area_b:FadeOut()    
    end

    local area_in = self.areas[index]
    if area_in ~= nil then
        area_in:FadeIn()    
    end

    if index == homeIndex.Main then
        self.heroPointSeqs = self.heroPointSeqs or {}
        for i = 1, #self.heroPointSeqs do
            local seq = self.heroPointSeqs[i]
            if seq:IsActive() then
                seq:Kill()
            end
        end
        self.heroPointSeqs = {}
    end
    self.headList:SetActive(index ~= homeIndex.Main)
end

return HomeQuickDisposePanel
