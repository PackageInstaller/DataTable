-- 锚驴面板
module("formationLV.FormationLVPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("pet/PetPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShow3DBg = 1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("锚驴")
end

-- 初始化数据
function initData(self)
    self.mNowSelectPetId = 1
    self.mAllLVConfigVo = formationLV.FormationLVManager:getAllLVConfigVo()
    self.mPetItemList = {}
    self.mUnlockItemList = {}
end

function configUI(self)
    self.mContent = self:getChildTrans("mContent")
    self.mPetitemNode = self:getChildGO("PetItemNode")
    self.mTxtPetName = self:getChildGO("mTxtPetName"):GetComponent(ty.Text)
    self.mBtnUnlock = self:getChildGO("mBtnUnlock")
    -- self.mTxtUnlock = self:getChildGO("mTxtUnlock"):GetComponent(ty.Text)
    self.mBtnUse = self:getChildGO("mBtnUse")
    -- self.mTxtUse = self:getChildGO("mTxtUse"):GetComponent(ty.Text)
    self.mBtnUninstall = self:getChildGO("mBtnUninstall")
    -- self.mTxtUninstall = self:getChildGO("mTxtUninstall"):GetComponent(ty.Text)

    self.mImgPetIcon = self:getChildGO("mImgPetIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtPetDesc = self:getChildGO("mTxtPetDesc"):GetComponent(ty.Text)
    self.mTxtSkillTitle = self:getChildGO("mTxtSkillTitle"):GetComponent(ty.Text)
    self.mTxtSkillDesc = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.Text)
    self.mTxtUnlockTitle = self:getChildGO("mTxtUnlockTitle"):GetComponent(ty.Text)
    self.mGroupUnlock = self:getChildTrans("mGroupUnlock")
    self.mUnlockItem = self:getChildGO("mUnlckItem")
    self.mAni = self.UIObject:GetComponent(ty.Animator)

    local nodeGO = gs.GameObject.Find("[3D_PRESET]")
    local nodeUICommonGO = nodeGO.transform:Find("UI_COMMON_BG")
    self.nodeTrans = nodeUICommonGO.transform:Find("ROLE_NODE")
    self.DesScroll = self:getChildGO("DesScroll"):GetComponent(ty.ScrollRect)
    self.mUnlockTitle = self:getChildGO("mUnlockTitle")

    self:setGuideTrans("guide_petPanel_unLock", self.mBtnUnlock.transform)
    self:setGuideTrans("guide_petPanel_Use", self.mBtnUse.transform)
    self:setGuideTrans("guide_petPanel_Tips_1", self.DesScroll.transform)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnUnlock, 1080, "解锁")
    self:setBtnLabel(self.mBtnUse, 4029, "使用")
    self:setBtnLabel(self.mBtnUninstall, 4327, "卸载")
    self.mTxtSkillTitle.text = _TT(120127) --"技能效果"
    self.mTxtUnlockTitle.text = _TT(120128) --"解锁条件"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnUnlock, self.onClickUnlockHandler)
    self:addUIEvent(self.mBtnUse, self.onClickUseHandler)
    self:addUIEvent(self.mBtnUninstall, self.onClickUninstallHandler)
end

function active(self, args)
    super.active(self)
    MoneyManager:setMoneyTidList()
    self.formationMgr = args.manager
    self.teamId = args.teamId
    if args.petId and args.petId ~= 0 then
        self.mNowSelectPetId = args.petId
    end

    if not self.mModelLive then
        self.mModelLive = model.modelLive.new()
    end

    GameDispatcher:addEventListener(EventName.REFLASH_FORMATION_PANEL, self.updateView, self)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.REFLASH_FORMATION_PANEL, self.updateView, self)
    self:recoverPetItem()
    self:recoverUnlockItem()
    RedPointManager:remove(self.mBtnUnlock.transform)

    if self.mModelLive then
        self.mModelLive:destroy()
        self.mModelLive = nil
    end
end

function onClickUnlockHandler(self)
    local cusRoleLv = role.RoleManager:getRoleVo():getPlayerLvl()
    local nowSelectPetVo = self.mAllLVConfigVo[self.mNowSelectPetId]
    if nowSelectPetVo.mLevel > cusRoleLv then
        gs.Message.Show(_TT(120133))
    elseif not battleMap.MainMapManager:isStagePass(nowSelectPetVo.mStage) then
        local dupVo = battleMap.MainMapManager:getStageVo(nowSelectPetVo.mStage)
        gs.Message.Show(_TT(120134, dupVo.chapter .. "-" .. dupVo.sort))
    else
        GameDispatcher:dispatchEvent(EventName.REQ_UNLOCKLV, self.mNowSelectPetId)
    end
end

function onClickUseHandler(self)
    -- GameDispatcher:dispatchEvent(EventName.REQ_CHANGELV, { teamId = self.teamId, petId = self.mNowSelectPetId })
    if self.formationMgr.getPetUseTeamIds then
        local teamIdList = self.formationMgr:getPetUseTeamIds(self.mNowSelectPetId)
        for i, teamId in ipairs(teamIdList) do
            if teamId ~= 0 and teamId ~= self.teamId and math.floor(teamId / 1000) == math.floor(self.teamId / 1000) then
                local index = string.sub(teamId, 5, -1)
                gs.Message.Show(string.format("已经在队伍%s使用", index))
                return
            end
        end
    end
    self.formationMgr:setUsePetByTeamId(self.teamId, self.mNowSelectPetId)
    GameDispatcher:dispatchEvent(EventName.REFLASH_FORMATION_PANEL)
end

function onClickUninstallHandler(self)
    -- GameDispatcher:dispatchEvent(EventName.REQ_CHANGELV, { teamId = self.teamId, petId = 0 })
    self.formationMgr:setUsePetByTeamId(self.teamId, 0)
    GameDispatcher:dispatchEvent(EventName.REFLASH_FORMATION_PANEL)
end

function updateView(self)
    self:recoverPetItem()

    for k, v in pairs(self.mAllLVConfigVo) do
        local item = SimpleInsItem:create(self.mPetitemNode, self.mContent, "FormationLVPanelPetNode")
        local petItem = formationLV.FormationLVItem:poolGet()
        petItem:setData(item:getTrans(), v)
        petItem:setSelect(v.mId == self.mNowSelectPetId)
        petItem:setInUse(self.formationMgr:getPetIdByTeamId(self.teamId) == v.mId, self:getUseInTeamIndex(v.mId))
        petItem:addOnClick("", function() self:setSelect(v.mId) end)
        table.insert(self.mPetItemList, { item = item, petItem = petItem })
    end
    self:updateInfoView()
end

function getUseInTeamIndex(self, petId)
    local index = 0
    if self.formationMgr.getPetUseTeamIds then
        local teamIdList = self.formationMgr:getPetUseTeamIds(petId)
        for i, teamId in ipairs(teamIdList) do
            if teamId > 0 and math.floor(teamId / 1000) == math.floor(self.teamId / 1000) then
                index = string.sub(teamId, 5, -1)
                return tonumber(index)
            end
        end
    end
    return 0
end

function setSelect(self, id)
    for k, v in pairs(self.mPetItemList) do
        v.petItem:setSelect(v.petItem.mPetConfig.mId == id)
        if v.petItem.mPetConfig.mId == id then
            self.mNowSelectPetId = id
        end
    end
    if self.mAni then
        self.mAni:SetTrigger("show")
    end
    self:updateInfoView()
end

function updateInfoView(self)
    self:recoverUnlockItem()
    self.DesScroll.verticalNormalizedPosition = 1
    local LVConfigVo = self.mAllLVConfigVo[self.mNowSelectPetId]
    -- self.mImgPetIcon:SetImg(UrlManager:getIconPath(LVConfigVo.mPetPic))
    self.mImgPetIcon.gameObject:SetActive(false) -- 显示模型

    self.mTxtPetName.text = LVConfigVo:getName()
    self.mTxtPetDesc.text = LVConfigVo:getStory()
    self.mTxtSkillDesc.text = LVConfigVo:getEffect(1)

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtPetDesc.transform) --立即刷新
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mContent) --立即刷新

    local cusRoleLv = role.RoleManager:getRoleVo():getPlayerLvl()
    -- for k, v in pairs(LVConfigVo.mEffect) do 

    local hasLockCondi = false
    if LVConfigVo.mLevel > 0 then
        local item = SimpleInsItem:create(self.mUnlockItem, self.mGroupUnlock, "FormationLVPanelUnlockItem")
        local txtTarget = item:getChildGO("mTxtTarget"):GetComponent(ty.Text)
        local imgFinish = item:getChildGO("mImgFinish"):GetComponent(ty.AutoRefImage)
        txtTarget.text = _TT(121, LVConfigVo.mLevel)
        local color = cusRoleLv >= LVConfigVo.mLevel and "ffffffff" or "c6d4e1ff"
        local path = cusRoleLv >= LVConfigVo.mLevel and "common_0145.png" or "ml_icon_3.png"
        imgFinish:SetImg(UrlManager:getCommon5Path(path), false)
        imgFinish.color = gs.ColorUtil.GetColor(color)
        txtTarget.color = gs.ColorUtil.GetColor(color)
        -- imgFinish:SetActive()
        table.insert(self.mUnlockItemList, item)
        hasLockCondi = true
    end

    if LVConfigVo.mStage > 0 then
        local dupVo = battleMap.MainMapManager:getStageVo(LVConfigVo.mStage)
        local item = SimpleInsItem:create(self.mUnlockItem, self.mGroupUnlock, "FormationLVPanelUnlockItem")
        local txtTarget = item:getChildGO("mTxtTarget"):GetComponent(ty.Text)
        local imgFinish = item:getChildGO("mImgFinish"):GetComponent(ty.AutoRefImage)
        txtTarget.text = _TT(57, dupVo.chapter .. "-" .. dupVo.sort)
        local color = battleMap.MainMapManager:isStagePass(LVConfigVo.mStage) and "ffffffff" or "c6d4e1ff"
        local path = battleMap.MainMapManager:isStagePass(LVConfigVo.mStage) and "common_0145.png" or "ml_icon_3.png"
        imgFinish:SetImg(UrlManager:getCommon5Path(path), false)
        imgFinish.color = gs.ColorUtil.GetColor(color)
        txtTarget.color = gs.ColorUtil.GetColor(color)
        -- imgFinish:SetActive()
        table.insert(self.mUnlockItemList, item)
        hasLockCondi = true
    end
    self.mUnlockTitle:SetActive(hasLockCondi)

    -- end
    local unlock = formationLV.FormationLVManager:getIsUnlock(LVConfigVo.mId)
    local isInUse = self.formationMgr:getPetIdByTeamId(LVConfigVo.mId)
    local isNowTeam = self.formationMgr:getPetIdByTeamId(self.teamId) == LVConfigVo.mId
    if not unlock then
        self.mBtnUnlock:SetActive(true)
        self.mBtnUse:SetActive(false)
        self.mBtnUninstall:SetActive(false)
    elseif isInUse and isNowTeam then
        self.mBtnUnlock:SetActive(false)
        self.mBtnUse:SetActive(false)
        self.mBtnUninstall:SetActive(true)
    else
        self.mBtnUnlock:SetActive(false)
        self.mBtnUse:SetActive(true)
        self.mBtnUninstall:SetActive(false)
    end
    self:updateRed()
    self:showPetModel(LVConfigVo.petModel)
end

function showPetModel(self, modelId)
    modelId = modelId and modelId or 7501
    self.mModelLive:setupPrefab(UrlManager:getPetPath(modelId), nil, function()

        self.mModelLive:setToParent(self.nodeTrans)
        self.mModelLive:playAction(DormitoryCost.ACT_SHOW_STAND)
    end)
end

function updateRed(self)
    local nowSelectPetVo = self.mAllLVConfigVo[self.mNowSelectPetId]
    local unlock = formationLV.FormationLVManager:getIsUnlock(nowSelectPetVo.mId)
    if (not unlock and nowSelectPetVo.mLevel <= role.RoleManager:getRoleVo():getPlayerLvl() and battleMap.MainMapManager:isStagePass(nowSelectPetVo.mStage)) then
        RedPointManager:add(self.mBtnUnlock.transform, nil, 115, 27)
    else
        RedPointManager:remove(self.mBtnUnlock.transform)
    end
end

function recoverPetItem(self)
    for k, v in pairs(self.mPetItemList) do
        v.petItem:poolRecover()
        v.item:poolRecover()
    end
    self.mPetItemList = {}
end

function recoverUnlockItem(self)
    for k, v in pairs(self.mUnlockItemList) do
        v:poolRecover()
    end
    self.mUnlockItemList = {}
end

return _M