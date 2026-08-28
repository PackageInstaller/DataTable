
--region global define

--endregion

--region import
---@type CatBallUtils
local CatBallUtils =  import("Game.CatBall.CatBallUtils")
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define

--endregion

--- from: 
---@class CommonSmallCatBallNode
---@field Env                           	CommonSmallCatBallNode                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field UIFX_Covert                   	UnityEngine.RectTransform               
---@field AnimationNode                 	UnityEngine.Animation                   
---@field TextNumber                    	TMPro.TextMeshProUGUI                   
---@field TxtName                       	UnityEngine.UI.Text                     
---@field ImgAttribute                  	Engine.UI.ImageAlterable                
---@field StarGroup                     	StarProgressNode                        
---@field ImgGoodsIcon                  	Engine.UI.ImageAlterable                
---@field HeadImage2                    	Engine.UI.ImageAlterable                
---@field HeadImage                     	Engine.UI.ImageAlterable                
---@field ImgQuality                    	Game.Native.Common.UISwitchImage        
local CommonSmallCatBallNode = Class('CommonSmallCatBallNode')

function CommonSmallCatBallNode:__init()

end


function CommonSmallCatBallNode:__delete()

end


function CommonSmallCatBallNode:Awake()
end


function CommonSmallCatBallNode:Start()
    SetButtonAction(self.controller.gameObject, Bind(self, self.OnClickNodeAction))
end


function CommonSmallCatBallNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param catBallEntity CatBallEntity
function CommonSmallCatBallNode:FreshUI(catBallEntity, callback)
    KTool.SetActive(self.UIFX_Covert.gameObject, false)

    self._catBallEntity = catBallEntity
    
    local isFragment = catBallEntity.isFragment
    ---@type CatBallVo
    local vo = catBallEntity.vo

    self:FreshBaseUI(vo)

    KTool.SetActive(self.StarGroup.gameObject, not isFragment)
    KTool.SetActive(self.HeadImage.gameObject, not isFragment)    
    KTool.SetActive(self.HeadImage2.gameObject,   false)    
    KTool.SetActive(self.ImgGoodsIcon.gameObject, isFragment)  
    KTool.SetActive(self.TextNumber.gameObject, isFragment)  

    if isFragment then
        self.ImgGoodsIcon:LoadSprite(catBallEntity.goodsVo.photoPath)
        self.TextNumber.text = string.format("%s/%s", catBallEntity.fragmentNum, catBallEntity.needNum)
    else
        self.HeadImage:LoadSprite(vo.picture)
        self.HeadImage2:LoadSprite(vo.picture)
        ---@type CatEggDojo
        local catEggDojo = catBallEntity.dojo
        self.StarGroup:SetStarNo(vo.starMax, checkNumber(catEggDojo.star))
    end

    self:SetCallback(callback)

end

---FreshBaseUI
---@param vo CatBallVo
function CommonSmallCatBallNode:FreshBaseUI(vo)
    self.ImgQuality.Status = vo.rare
    self.ImgAttribute:LoadSprite(CatBallUtils.GetAttributeIcon(vo.types, vo.subtype))
    self.TxtName.text = vo.name
end

---FreshGoodUI
---@param catBallEntity CatBallEntity
function CommonSmallCatBallNode:FreshGoodUI(catBallEntity)
    KTool.SetActive(self.UIFX_Covert.gameObject, false)

    local isFragment = catBallEntity.isFragment
    ---@type CatBallVo
    local vo = catBallEntity.vo
    self:FreshBaseUI(vo)

    ---道具形式  不显示该节点
    KTool.SetActive(self.StarGroup.gameObject, false)
    --- 默认显示 猫球会先展示该节点 然后再显示碎片
    KTool.SetActive(self.HeadImage.gameObject, true)    
    KTool.SetActive(self.HeadImage2.gameObject,   false)    
    KTool.SetActive(self.ImgGoodsIcon.gameObject, false)  
    KTool.SetActive(self.TextNumber.gameObject, true)  

    self.HeadImage:LoadSprite(vo.picture)
    self.HeadImage2:LoadSprite(vo.picture)
    if isFragment then
        self.ImgGoodsIcon:LoadSprite(catBallEntity.goodsVo.photoPath)
    end

    local text = isFragment and catBallEntity.fragmentNum or 1
    self.TextNumber.text = string.format("x%s", text)
end

function CommonSmallCatBallNode:PlayAnimationCompose()
    KTool.SetActive(self.UIFX_Covert.gameObject, true)
    KTool.SetActive(self.HeadImage.gameObject, true)    
    KTool.SetActive(self.HeadImage2.gameObject, true)    
    KTool.SetActive(self.ImgGoodsIcon.gameObject, false)
    self.AnimationNode:Play("CommonSmallCatballNode_Covert_Compount")
end

function CommonSmallCatBallNode:PlayAnimationSplit()
    KTool.SetActive(self.UIFX_Covert.gameObject, true)
    KTool.SetActive(self.HeadImage.gameObject, false)   
    KTool.SetActive(self.ImgGoodsIcon.gameObject, true)  
    -- self.AnimationNode.enabled = true
    self.AnimationNode:Play("CommonSmallCatballNode_Covert_Split")
end


--endregion 


--region get/set 

function CommonSmallCatBallNode:SetCallback(callback)
    self._callback = callback
end

---endregion 


--region handler 

function CommonSmallCatBallNode:OnClickNodeAction()
    if self._callback then
        self._callback(self._catBallEntity)
    end
end

---endregion 


return CommonSmallCatBallNode
