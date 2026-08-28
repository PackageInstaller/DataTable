
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CatBallUtils
local CatBallUtils               = import("Game.CatBall.CatBallUtils")
local UISwitchParticleSystemType = typeof(CS.Game.Native.Common.UISwitchParticleSystem)
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballDrawResultCell.prefab > name: OverseaManageCatballDrawResultCell
---@class CatBallDrawResultCell
---@field Env                           	CatBallDrawResultCell                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Anim                          	UnityEngine.Animation                   
---@field Effect                        	UnityEngine.RectTransform               
---@field Area                          	UnityEngine.RectTransform               
---@field TextName                      	CustomText                              
---@field ImgNew                        	UnityEngine.RectTransform               
---@field ImgTypeIcon                   	Engine.UI.ImageAlterable                
---@field ImgRareIcon                   	Game.Native.Common.UISwitchImage        
---@field ImgRareBg                     	Game.Native.Common.UISwitchImage        
---@field ImgIconNormal                 	Engine.UI.ImageAlterable                
---@field ImgRare                       	Game.Native.Common.UISwitchImage        
local CatBallDrawResultCell = Class('CatBallDrawResultCell')

function CatBallDrawResultCell:__init()

end


function CatBallDrawResultCell:__delete()

end


function CatBallDrawResultCell:Start()
    SetButtonAction(self.controller.gameObject, Bind(self, self.OnClickCellAction))
end


function CatBallDrawResultCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param entity CatBallEntity
function CatBallDrawResultCell:FreshUI(entity, isDisableEnter)
    self._entity = entity
    ---@type CatBallVo
    local vo = entity.vo
    local rare = vo.rare
    self.ImgRare.Status = rare
    self.ImgRareBg.Status = rare
    self.ImgRareIcon.Status = rare

    self.ImgIconNormal:LoadSprite(vo.picture)
    self.ImgTypeIcon:LoadSprite(CatBallUtils.GetAttributeIcon(vo.types, vo.subtype))
    self.TextName.text = vo.name

    KTool.SetActive(self.ImgNew.gameObject, checkBool(entity.isNew))

    self:FreshEffect(vo.rare, isDisableEnter)

    if not isDisableEnter then
        self.Anim:Play("OverseaManageCatballDrawResultDialog_Cell_Entry")
    end
end

function CatBallDrawResultCell:FreshEffect(rare)
    local uiSwitchArr = self.Effect.gameObject:GetComponentsInChildren(UISwitchParticleSystemType, true)
    for i = 0, uiSwitchArr.Length - 1 do 
        local uiSwitch = uiSwitchArr[i]
        if isNotNull(uiSwitch) then
            uiSwitch.Status = rare
        end
    end
end


--endregion 


--region get/set 


function CatBallDrawResultCell:SetCallback(callBack)
    self._callback = callBack
end

---endregion 


--region handler 

function CatBallDrawResultCell:OnClickCellAction()
    if self._callback then
        self._callback(self._entity)
    end
end

---endregion 


return CatBallDrawResultCell
