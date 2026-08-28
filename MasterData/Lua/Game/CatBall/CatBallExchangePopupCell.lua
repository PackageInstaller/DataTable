
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local Bind      = Bind

--endregion

--region import
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballExchangePopup.prefab
---@class CatBallExchangePopupCell
---@field Env                           	CatBallExchangePopupCell                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnReduceAnimation            	UnityEngine.Animation                   
---@field BtnReduce                     	Engine.UI.ButtonLongPress               
---@field TextNumber                    	TMPro.TextMeshProUGUI                   
---@field ChooseQuantityNode            	UnityEngine.CanvasGroup               
---@field CannotSelect                  	UnityEngine.RectTransform               
---@field Select                        	UnityEngine.RectTransform               
---@field GoodNode                      	UnityEngine.RectTransform               
---@field BtnNode                       	Engine.UI.ButtonLongPress               
local CatBallExchangePopupCell = Class('CatBallExchangePopupCell')

function CatBallExchangePopupCell:__init()

end


function CatBallExchangePopupCell:__delete()

end

function CatBallExchangePopupCell:Awake()
    KTool.SetActive(self.ChooseQuantityNode.gameObject, true)
    GameUtils.UpdateUIShowStateByCanvasGroup(self.ChooseQuantityNode, false)
end

function CatBallExchangePopupCell:Start()
    self.BtnNode.onClick          = Bind(self, self.OnClickBtnNodeAction)
    self.BtnNode.onLongPress      = Bind(self, self.OnClickBtnNodePressAction)
    
    self.BtnReduce.onClick        = Bind(self, self.OnClickBtnReduceAction)
    self.BtnReduce.onFixLongPress = Bind(self, self.OnClickBtnReducePressAction)

end


function CatBallExchangePopupCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function CatBallExchangePopupCell:FreshUI(goodsData, position)
    self._goodsData = goodsData
    self._position  = position
    self:FreshGoodsNode(goodsData.goodsId, goodsData.num)
end

function CatBallExchangePopupCell:FreshGoodsNode(goodsId, num)
    CfUtils.RefeshGoodGo2(self.GoodNode, goodsId, num)
end

function CatBallExchangePopupCell:FreshSelectState(selectNum, isCannotSelect, isSingleMode)
    local isSelect = selectNum > 0
    KTool.SetActive(self.Select.gameObject, isSelect and isSingleMode)
    KTool.SetActive(self.CannotSelect.gameObject, not isSelect and isCannotSelect)
    local isShowQuantity = isSelect and not isSingleMode
    GameUtils.UpdateUIShowStateByCanvasGroup(self.ChooseQuantityNode, isShowQuantity)
    if isShowQuantity then
        self:FreshSelectNum(selectNum)
    end
end

function CatBallExchangePopupCell:FreshSelectNum(selectNum)
    self.TextNumber.text = selectNum

end

--endregion 


--region get/set 

function CatBallExchangePopupCell:SetBtnClickCallback(callback)
    self._btnClickCallback = callback
end

function CatBallExchangePopupCell:SetBtnReduceClickCallback(callback)
    self._btnReduceClickCallback = callback
end

function CatBallExchangePopupCell:SetBtnReducePressCallback(callback)
    self._btnReducePressCallback = callback
end

---endregion 


--region handler 

function CatBallExchangePopupCell:OnClickBtnNodeAction()
    if self._btnClickCallback then
        self._btnClickCallback(self._goodsData, self._position, self)
    end

end

function CatBallExchangePopupCell:OnClickBtnNodePressAction()
    GameUtils.ShowCommonGoodsTipsBoard(self.GoodNode, self._goodsData.goodsId, true)
    
end

function CatBallExchangePopupCell:OnClickBtnReduceAction()
    if self._btnReduceClickCallback then
        self._btnReduceClickCallback(self._goodsData, self._position, self)
    end

end

function CatBallExchangePopupCell:OnClickBtnReducePressAction(num)
    if self._btnReducePressCallback then
        self._btnReducePressCallback(self._goodsData, self._position, num, self)
    end

end

---endregion 


return CatBallExchangePopupCell
