--[[ 
-----------------------------------------------------
@filename       : GmFightPostItem
@Description    : GM
@date           : 2022-2-22 20:22:07
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("gm.GmFightPostItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
	self.mTypeTxt = self:getChildGO("Label"):GetComponent(ty.Text)
    self.mToggle = self:getChildGO("ToggleTrun"):GetComponent(ty.Toggle)

    local function _toggleNorCall(bVal)
        self.mPostData.val = bVal
        fight.FightManager:postGmDebugSetup(self.mPostData)
	end
    self.mToggle.onValueChanged:AddListener(_toggleNorCall)
end


function setData(self, param)
    super.setData(self, param)
    self.mPostData = param
    self.mTypeTxt.text = param.txt
    if self.mPostData.val then
        self.mToggle.isOn = self.mPostData.val
    else
        self.mToggle.isOn = false
    end
    -- fight.FightManager:postGmDebugSetup(self.mPostData)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
