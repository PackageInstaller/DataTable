--[[ 
-----------------------------------------------------
@filename       : EliminateAreaItem
@Description    : 消消乐章节区域item
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateAreaItem", Class.impl("lib.component.BaseItemRender"))

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mClick"), self.onClickHandler)
end

function onInit(self, go)
    super.onInit(self, go)

    self.mGroupTrans = self:getChildTrans("Group")
    self.mImgNotLock = self:getChildGO("mImgNotLock")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgOpenTipGo = self:getChildGO("mImgOpenTip")
    self.mImgRedGo = self:getChildGO("mImgRed")
    self.mImgSelectGo = self:getChildGO("mImgSelect")

    self.mGroupLock = self:getChildGO("GroupLock")
    self.mTxtOpenTip = self:getChildGO("mTxtOpenTip"):GetComponent(ty.Text)    
end

function active(self)
    super.active(self)
end

function setData(self, param)
    super.setData(self, param)
    local selectVo = self.data
    local areaConfigVo = selectVo:getDataVo()
    local isSelect = selectVo:getSelect()
    if (areaConfigVo) then
        self.mTxtName.text = _TT(areaConfigVo.areaName) -- eliminate.EliminateManager:isAreaPass(areaConfigVo)
        self.mTxtName.color = areaConfigVo:isOpen() and gs.ColorUtil.GetColor("ffffffff") or gs.ColorUtil.GetColor("C2C2C2ff")
        self.mImgSelectGo:SetActive(isSelect)
        self.mImgNotLock:SetActive(areaConfigVo:isOpen())
        self.mGroupLock:SetActive(not areaConfigVo:isOpen())
        self.mImgOpenTipGo:SetActive(not areaConfigVo:isOpen())
        self.mTxtName.gameObject:SetActive(areaConfigVo:isOpen())
        if(not areaConfigVo:isOpen())then
            self.mTxtOpenTip.text = string.format("%02d/%02d %02d:%02d%s", areaConfigVo.beginTimeData.month, areaConfigVo.beginTimeData.day, areaConfigVo.beginTimeData.hour, areaConfigVo.beginTimeData.min, _TT(92026))
        end

        if(eliminate.EliminateManager:hasStageOpenRed(areaConfigVo))then
            self.mImgRedGo:SetActive(true)
        else
            self.mImgRedGo:SetActive(false)
        end
    else
        self:deActive()
    end
end

function onClickHandler(self)
    local selectVo = self.data
    local areaConfigVo = selectVo:getDataVo()
    if(areaConfigVo:isOpen())then
        GameDispatcher:dispatchEvent(EventName.SELECT_ELIMINATE_AREA_PANEL, areaConfigVo)
        GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
    else
        local tip = string.format("%02d/%02d %02d:%02d%s", areaConfigVo.beginTimeData.month, areaConfigVo.beginTimeData.day, areaConfigVo.beginTimeData.hour, areaConfigVo.beginTimeData.min, _TT(92026))
        gs.Message.Show(tip)
    end
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M