--[[ 
-----------------------------------------------------
@filename       : EliminateStageItem
@Description    : 消消乐关卡item
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateStageItem", Class.impl("lib.component.BaseItemRender"))

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mClick"), self.onClickHandler)
end

function onInit(self, go)
    super.onInit(self, go)
    
    self.mGroupGo = self:getChildGO("Group")
    self.mImgRedGo = self:getChildGO("mImgRed")
    self.mImgPassGo = self:getChildGO("mImgPass")
    self.mImgLockGo = self:getChildGO("mImgLock")
    self.mGroupTrans = self:getChildTrans("Group")
    self.mClickTrans = self:getChildTrans("mClick")
    self.mGroupOpenTip = self:getChildGO("GroupOpenTip")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgTips = self:getChildGO("mImgTips"):GetComponent(ty.Image)
    self.mTxtOpenTip = self:getChildGO("mTxtOpenTip"):GetComponent(ty.Text)
    self.mImgStageBg = self:getChildGO("mImgStageBg"):GetComponent(ty.AutoRefImage)
    self.mImgLockRef = self:getChildGO("mImgLock"):GetComponent(ty.AutoRefImage)
end

function active(self)
    super.active(self)
end

function setData(self, param)
    super.setData(self, param)
    local selectVo = self.data
    local stageConfigVo = selectVo:getDataVo()
    if(stageConfigVo)then
        self.mGroupGo:SetActive(true)
        if (stageConfigVo) then
            self.mTxtName.text = stageConfigVo.mapName
            if eliminate.EliminateManager:isStagePass(stageConfigVo.mapId) then
                GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
            end
            self.mImgPassGo:SetActive(eliminate.EliminateManager:isStagePass(stageConfigVo.mapId))
            self.mTxtName.color = stageConfigVo:isLock() and gs.ColorUtil.GetColor("C2C2C2FF") or gs.ColorUtil.GetColor("FFFFFFFF")
            self.mImgTips.color = stageConfigVo:isLock() and gs.ColorUtil.GetColor("C2C2C2FF") or gs.ColorUtil.GetColor("FFFFFFFF")
            self.mImgLockGo:SetActive(stageConfigVo:isLock())
            self.mTxtName.gameObject:SetActive(true)
            if(stageConfigVo:isOpen())then
                self.mTxtOpenTip.text = ""
                self.mGroupOpenTip:SetActive(false)
            else
                self.mTxtOpenTip.text = string.format("%02d/%02d %02d:%02d%s", stageConfigVo.beginTimeData.month, stageConfigVo.beginTimeData.day, stageConfigVo.beginTimeData.hour, stageConfigVo.beginTimeData.min, _TT(92026))
                self.mGroupOpenTip:SetActive(true)
                self.mTxtName.gameObject:SetActive(false)
            end
    
            local isOpen = not stageConfigVo:isLock() and stageConfigVo:isOpen()
            self.mImgRedGo:SetActive(isOpen and not StorageUtil:getBool1(eliminate.EliminateManager.StageNewOpenStorageKey .. stageConfigVo.mapId))
    
            if(stageConfigVo.mapId % 2 == 0)then
                gs.TransQuick:UIPos(self.mGroupTrans, 0, -95)--下
                gs.TransQuick:UIPos(self.mClickTrans, 0, -95)
            else
                gs.TransQuick:UIPos(self.mGroupTrans, 0, 66)--上
                gs.TransQuick:UIPos(self.mClickTrans, 0, 66)
            end
            self.mImgStageBg:SetImg(UrlManager:getPackPath("eliminate/eliminate_thing_"..(17+stageConfigVo.areaId)..".png"))
            self.mImgLockRef:SetImg(UrlManager:getPackPath("eliminate/eliminate_thing_"..(17+stageConfigVo.areaId)..".png"))
        else
            self:deActive()
        end
    else
        self.mGroupGo:SetActive(false)
        self:deActive()
    end
end

function onClickHandler(self)
    local selectVo = self.data
    local stageConfigVo = selectVo:getDataVo()
    if(stageConfigVo)then
        if(stageConfigVo:isLock())then
            gs.Message.Show(_TT(101008)) --"请先通过前关"
        else
            if(stageConfigVo:isOpen())then
                StorageUtil:saveBool1(eliminate.EliminateManager.StageNewOpenStorageKey .. stageConfigVo.mapId, true)
                GameDispatcher:dispatchEvent(EventName.SELECT_ELIMINATE_STAGE_PANEL, stageConfigVo)
                GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
            else
                local tip = string.format("%02d/%02d %02d:%02d%s", stageConfigVo.beginTimeData.month, stageConfigVo.beginTimeData.day, stageConfigVo.beginTimeData.hour, stageConfigVo.beginTimeData.min, _TT(92026))
                gs.Message.Show(tip)
            end
        end
    end
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M