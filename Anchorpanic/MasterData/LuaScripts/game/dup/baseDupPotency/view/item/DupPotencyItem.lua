--[[ 
-----------------------------------------------------
@filename       : DupPotencyItem
@Description    : 潜能副本item
@Author         : Shuai
@copyright      : (LY) 2023雷焰网络
-----------------------------------------------------
]]
module('dup.DupPotencyItem', Class.impl(dup.DupDailyBaseItem))

function updateSelectState(self)
    self.mImgSelect:SetActive(dup.DupDailyBaseManager:getSelectDupId() == self.mData.dupId)
    local color = (dup.DupDailyBaseManager:getSelectDupId() == self.mData.dupId) and gs.ColorUtil.GetColor("202226ff") or gs.ColorUtil.GetColor("c6d4e1ff")
    self.mTxtNoUnlock.color = color
    self.mImgTitleArrow.color = color
    self.mTxtCurDifficulty.color = color
    self.mImgNoUnlockIcon:GetComponent(ty.Image).color = color
end

function onClick(self)
    self.mData.state = self:getDupState()
    dup.DupDailyBaseManager:setSelectDupId(self.mData.dupId)
    GameDispatcher:dispatchEvent(EventName.UPDATE_DUP_LEVEL_INFO, self.mData)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]