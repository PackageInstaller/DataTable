
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaSpecialWeapon.prefab > name: Cell
---@class CardProgressionExclusiveWeaponCell
---@field Env                           	CardProgressionExclusiveWeaponCell      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextDescSwitch                	Game.Native.Common.UISwitchText         
---@field TextDesc                      	CustomText                              
---@field TextNumber                    	Game.Native.Common.UISwitchTextMeshPro  
---@field TextLv                        	Game.Native.Common.UISwitchTextMeshPro  
---@field ImgHook                       	Game.Native.Common.UISwitchImage        
local CardProgressionExclusiveWeaponCell = Class('CardProgressionExclusiveWeaponCell')

function CardProgressionExclusiveWeaponCell:__init()

end


function CardProgressionExclusiveWeaponCell:__delete()

end


function CardProgressionExclusiveWeaponCell:Awake()
end


function CardProgressionExclusiveWeaponCell:Start()
end


function CardProgressionExclusiveWeaponCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function CardProgressionExclusiveWeaponCell:FreshUI(lvDesc, weaponLv)
    self._lvDesc = lvDesc
    local level  = lvDesc.level
    local desc   = lvDesc.desc
    local isLock = weaponLv < level
    local status = isLock and 1 or 2
    self.ImgHook.Status        = status
    self.TextLv.Status         = status
    self.TextNumber.text       = level
    self.TextNumber.Status     = status
    self.TextDesc.text         = desc
    self.TextDescSwitch.Status = status

    if self.BtnCheck then
        CfUtils.SetActive(self.BtnCheck, isLock)
    end
end

--endregion 


--region get/set 

function CardProgressionExclusiveWeaponCell:SetCallback(callback)
    if self._callback then
        return
    end
    self._callback = callback
    if self.BtnCheck then
        SetButtonAction(self.BtnCheck, Bind(self, self.OnClickBtnCheckAction))
    end
end

---endregion 


--region handler 

function CardProgressionExclusiveWeaponCell:OnClickBtnCheckAction()
    if self._callback then
        self._callback(self._lvDesc)
    end

end

---endregion 


return CardProgressionExclusiveWeaponCell
