
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type GoodsConfMgr
local goodsConfMgr = GoodsConfMgr:GetInstance()
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Activity/ActivityLimitFlashSaleDIalog140001.prefab > name: StickerNode
---@class ActivityLimitFlashSaleStickerNode
---@field Env                           	ActivityLimitFlashSaleStickerNode       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextNumber                    	CustomText                              
---@field ImgSticker                    	Engine.UI.ImageAlterable                
local ActivityLimitFlashSaleStickerNode = Class('ActivityLimitFlashSaleStickerNode')

function ActivityLimitFlashSaleStickerNode:__init()

end


function ActivityLimitFlashSaleStickerNode:__delete()

end


-- function ActivityLimitFlashSaleStickerNode:Awake()
-- end


-- function ActivityLimitFlashSaleStickerNode:Start()
-- end


function ActivityLimitFlashSaleStickerNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ActivityLimitFlashSaleStickerNode:FreshUI(goodsId)
    -- local goodsId  = data.goodsId
    ---@type GoodsVo
    local vo = goodsConfMgr:GetGoodsVoById(goodsId)
    self.ImgSticker:LoadSprite(vo.photoPath)

    local num = GoodsUtils.GetThingNo(goodsId)
    self.TextNumber.text = num
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return ActivityLimitFlashSaleStickerNode
