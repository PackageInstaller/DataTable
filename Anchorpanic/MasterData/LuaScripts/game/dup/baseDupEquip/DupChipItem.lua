--[[ 
-----------------------------------------------------
@filename       : DupChipItem
@Description    : 副本item
@Author         : Shuai
@copyright      : (LY) 2022雷焰网络
-----------------------------------------------------
]]
module('dup.DupChipItem', Class.impl("lib.component.BaseItemRender"))
-- 是否异步
IsAsyn = false
--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupEquip/DupChipItem.prefab")
function initData(self)
    self.mDupData = nil
    self.mData = nil
end

--初始化
function onInit(self, go)
    super.onInit(self, go)
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgNoUnlockIcon = self:getChildGO("mImgNoUnlockIcon")
    self.mTxtNoUnlock = self:getChildGO("mTxtNoUnlock"):GetComponent(ty.Text)
    self.mImgTitleArrow = self:getChildGO("mImgTitleArrow"):GetComponent(ty.Image)
    self.mTxtCurDifficulty = self:getChildGO("mTxtCurDifficulty"):GetComponent(ty.Text)
    self:initData()
    GameDispatcher:addEventListener(EventName.UPDATE_DUP_LEVEL_INFO, self.updateSelectState, self)
    GameDispatcher:addEventListener(EventName.UPDATE_DUP_CHIP_SELECT_SUIT, self.updateLevelInfo, self)
    self:addOnClick(self:getChildGO("mGroup"), self.onClick)
end

function setData(self, parms)
    super.setData(self, parms)
    self.mData = parms
    self.mTxtCurDifficulty.text = _TT(4530, self.mData.name)
    self.mDupData = dup.DupMainManager:getDupInfoData(self.mData.type)
    self.mImgNoUnlockIcon:SetActive(true)
    self.mImgSelect:SetActive(false)
    self.mData.state = self:getDupState()
    if self:getDupState() == 3 then
        self.mTxtNoUnlock.text = _TT(53608)
    elseif self:getDupState() == 4 then
        self.mTxtNoUnlock.text = _TT(53612, self.mData.enterLv)
    elseif battleMap.MainMapManager:isStagePass(self.mData.enterDup) == nil then
        local stageVo = battleMap.MainMapManager:getStageVo(self.mData.enterDup)
        self.mTxtNoUnlock.text = _TT(53609, stageVo.indexName)
    else
        self.mTxtNoUnlock.text = self.mData:getUnlockTxt()
        self.mImgNoUnlockIcon:SetActive(false)
    end
    self.mImgTitleArrow.gameObject:SetActive(self.mImgNoUnlockIcon.activeSelf == false)
    self:updateSelectState()
    self:updateLevelInfo()
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DUP_LEVEL_INFO, self.updateSelectState, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DUP_CHIP_SELECT_SUIT, self.updateLevelInfo, self)
end

-- 副本状态
function getDupState(self)
    if self.mDupData.curId == 0 or self.mDupData.curId > self.mData.dupId then
        -- 已通关
        return 2
    elseif self.mDupData.curId < self.mData.dupId or self.mData.enterLv > role.RoleManager:getRoleVo():getPlayerLvl() then
        if self.mData.enterLv > role.RoleManager:getRoleVo():getPlayerLvl() then
            return 4
        end
        -- 未开放
        return 3
    else
        -- 正在进行
        return 1
    end
end

function onClick(self)
    if self:getDupState() == 3 then
        gs.Message.Show(_TT(53608))
        return
    elseif self:getDupState() == 4 then
        gs.Message.Show(_TT(53612, self.mData.enterLv))
        return
    elseif battleMap.MainMapManager:isStagePass(self.mData.enterDup) == nil then
        local stageVo = battleMap.MainMapManager:getStageVo(self.mData.enterDup)
        gs.Message.Show(_TT(53609, stageVo.indexName))
        return
    else
        self.mData.state = self:getDupState()
        dup.DupDailyBaseManager:setSelectDupId(self.mData.dupId)
        GameDispatcher:dispatchEvent(EventName.UPDATE_DUP_LEVEL_INFO, self.mData)
    end
end

function updateSelectState(self)
    self.mImgSelect:SetActive(dup.DupDailyBaseManager:getSelectDupId() == self.mData.dupId)
    local color = (dup.DupDailyBaseManager:getSelectDupId() == self.mData.dupId) and gs.ColorUtil.GetColor("ffffffff") or gs.ColorUtil.GetColor("202226ff")
    color = self.mImgNoUnlockIcon.activeSelf == true and gs.ColorUtil.GetColor("82898cff") or color
    self.mTxtNoUnlock.color = color
    self.mImgTitleArrow.color = color
    self.mTxtCurDifficulty.color = color
end

function updateLevelInfo(self)
    if dup.DupDailyBaseManager:getSelectDupId() == self.mData.dupId then
        GameDispatcher:dispatchEvent(EventName.UPDATE_DUP_LEVEL_INFO, self.mData)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]