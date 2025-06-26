module("tips.NoMaskEquipTips", Class.impl(tips.EquipTipsMin))

-- 设置全屏透明遮罩
-- 设置全屏透明遮罩
function setMask(self)
    super.setMask(self)
    local trigger = self.mask:GetComponent(ty.LongPressOrClickEventTrigger)
    trigger:SetIsPassEvent(true)
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
