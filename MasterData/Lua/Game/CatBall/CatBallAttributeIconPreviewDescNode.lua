
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type CatBallUtils
local CatBallUtils                = import("Game.CatBall.CatBallUtils")
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballAttributeIconPreview.prefab
---@class CatBallAttributeIconPreviewDescNode
---@field Env                           	CatBallAttributeIconPreviewDescNode     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextDesc                      	CustomText                              
---@field TextName                      	CustomText                              
---@field ImgIcon                       	Engine.UI.ImageAlterable                
---@field ImgIconShadow                 	Engine.UI.ImageAlterable                
local CatBallAttributeIconPreviewDescNode = Class('CatBallAttributeIconPreviewDescNode')

function CatBallAttributeIconPreviewDescNode:__init()

end


function CatBallAttributeIconPreviewDescNode:__delete()

end


function CatBallAttributeIconPreviewDescNode:Awake()
end


function CatBallAttributeIconPreviewDescNode:Start()
end


function CatBallAttributeIconPreviewDescNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function CatBallAttributeIconPreviewDescNode:FreshUI(data)
    local iconPath = CatBallUtils.GetAttributeIcon(data.types, data.subtype)
    self.ImgIcon:LoadSprite(iconPath)
    self.ImgIconShadow:LoadSprite(iconPath)

    self.TextName.text = data.title
    self.TextDesc.text = data.expound
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CatBallAttributeIconPreviewDescNode
