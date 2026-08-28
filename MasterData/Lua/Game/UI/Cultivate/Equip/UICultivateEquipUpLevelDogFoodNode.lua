------------ import ------------
local KTool        = CS.Engine.Lib.KTool
local Yielders     = CS.Engine.Lib.Yielders
local UIEventProxy = CS.Engine.UI.UIEventProxy
------------ import ------------

---@class UICultivateEquipUpLevelDogFoodNode
---@field BtnReduce                     	UnityEngine.RectTransform               
---@field TxtPlusNumber                 	TMPro.TextMeshProUGUI                   
---@field ImgSelect                     	UnityEngine.RectTransform               
---@field GoodNode                      	UnityEngine.RectTransform               
local UICultivateEquipUpLevelDogFoodNode = Class("UICultivateEquipUpLevelDogFoodNode")

------------ define ------------
local GoodNodeMBPath         = "Game.Behaviours.GoodNodeMB"
local DelayTime    = Yielders.GetWaitForSeconds(0.3)
local DelayTime1   = Yielders.GetWaitForSeconds(0.06)
------------ define ------------

function UICultivateEquipUpLevelDogFoodNode:__init()
    self.selectNum = 0
end


function UICultivateEquipUpLevelDogFoodNode:__delete()

end


function UICultivateEquipUpLevelDogFoodNode:Awake()
    -- SetButtonAction(self.BtnReduce, Bind(self, self.OnClickBtnReduceAction))

    ---@type GoodNodeMB
    local env = CfUtils.GetLuaScr(self.GoodNode.gameObject, GoodNodeMBPath)
    if not isNull(env) then 
        env:InitPointerUp(Bind(self,    self.OnGoodNodeUpAction))
        env:InitPointerDown(Bind(self,  self.OnGoodNodeDownAction))
    end

    UIEventProxy.Create(self.BtnReduce.gameObject).onPointerDown = Bind(self, self.OnBtnReduceDownAction)
    UIEventProxy.Create(self.BtnReduce.gameObject).onPointerUp   = Bind(self, self.OnBtnReduceUpAction)
end

function UICultivateEquipUpLevelDogFoodNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

--- FreshUI
---@param dogFoodData table{ownNum:number, selectNum: numbre, dogFoodVo: EquipmentDogFoodVo}
function UICultivateEquipUpLevelDogFoodNode:FreshUI(dogFoodData, index)
    self.dogFoodData = dogFoodData
    self.index = index
    self:FreshGoodNode(dogFoodData)
    self:FreshSelectState(dogFoodData.selectNum)

end

function UICultivateEquipUpLevelDogFoodNode:FreshGoodNode(dogFoodData)
    ---@type GoodNodeMB
    local env = CfUtils.GetLuaScr(self.GoodNode.gameObject, GoodNodeMBPath)
    if isNull(env) then return end
    env:Reload({
        goodsId = dogFoodData.dogFoodVo.id,
        isShowNo = true,
        text = dogFoodData.ownNum
    })
    env:SetClickCallback(Bind(self, self.OnClickGoodNodeAction))
    
end

function UICultivateEquipUpLevelDogFoodNode:FreshSelectState(selectNum)
    local isShow = selectNum > 0
    GameUtils.UpdateUIShowState(self.ImgSelect.gameObject, isShow)

    if isShow then
        self.TxtPlusNumber.text = selectNum
    end

end

---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin --
---------------------------------------------------

function UICultivateEquipUpLevelDogFoodNode:OnClickGoodNodeAction()
    local dogFoodData = self.dogFoodData
    if dogFoodData.ownNum == 0 then
        GameUtils.ShowCommonGoodsTipsBoard(self.GoodNode.gameObject, dogFoodData.dogFoodVo.id, true)
    end
end

function UICultivateEquipUpLevelDogFoodNode:SetGoodNodeUpAction(cb)
    self.goodNodeUpAction = cb
end

function UICultivateEquipUpLevelDogFoodNode:SetGoodNodeDownAction(cb)
    self.goodNodeDownAction = cb
end

function UICultivateEquipUpLevelDogFoodNode:SetBtnReduceDownAction(cb)
    self.btnReduceDownAction = cb
end

function UICultivateEquipUpLevelDogFoodNode:SetBtnReduceUpAction(cb)
    self.btnReduceUpAction = cb
end

---------------------------------------------------
--- get/set end --
---------------------------------------------------


---------------------------------------------------
--- handler begin --
---------------------------------------------------

function UICultivateEquipUpLevelDogFoodNode:OnGoodNodeUpAction()
    if self.goodNodeUpAction then
        self.goodNodeUpAction(self.dogFoodData, self.index)
    end
end

function UICultivateEquipUpLevelDogFoodNode:OnGoodNodeDownAction()
    if self.goodNodeDownAction then
        self.goodNodeDownAction(self.dogFoodData, self.index)
    end
end

function UICultivateEquipUpLevelDogFoodNode:OnBtnReduceDownAction()
    if self.btnReduceDownAction then
        self.btnReduceDownAction(self.dogFoodData, self.index)
    end
end

function UICultivateEquipUpLevelDogFoodNode:OnBtnReduceUpAction()
    if self.btnReduceUpAction then
        self.btnReduceUpAction(self.dogFoodData, self.index)
    end
end

---------------------------------------------------
--- handler end --
---------------------------------------------------

return UICultivateEquipUpLevelDogFoodNode
