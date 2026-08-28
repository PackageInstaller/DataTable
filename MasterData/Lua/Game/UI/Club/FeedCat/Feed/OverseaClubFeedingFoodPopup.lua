---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

local FoodNodeLuaPath = "Game.UI.Club.FeedCat.Feed.OverseaClubFeedingFoodNode"

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingFoodPopup.prefab > name: OverseaClubFeedingFoodPopup
---@class OverseaClubFeedingFoodPopup
---@field Env                            OverseaClubFeedingFoodPopup
---@field controller                        Engine.UI.UILuaDialog
---@field ClickClose                        UnityEngine.RectTransform                @ 0    
---@field BtnClose                        UnityEngine.RectTransform                @ 1    
---@field BtnConfirm                        UnityEngine.RectTransform                @ 2    
---@field TextDesc2                        UnityEngine.RectTransform                @ 3    
---@field Empty                            UnityEngine.RectTransform                @ 4    
---@field ScrollView                        SuperScrollView.LoopGridView                @ 5    
local OverseaClubFeedingFoodPopup = Class("OverseaClubFeedingFoodPopup")

---@class OverseaClubFeedingFoodPopup.InputData

function OverseaClubFeedingFoodPopup:__init()
    self.controller = nil
    self.selectIndex = -1
end

function OverseaClubFeedingFoodPopup:__delete()
    self.controller = nil
end

function OverseaClubFeedingFoodPopup:Awake()
    SetButtonAction(self.ClickClose, function()
        self.controller:Close()
    end)
    SetButtonAction(self.BtnClose, function()
        self.controller:Close()
    end)
    SetButtonAction(self.BtnConfirm, function()
        self.controller:Close()
        local selectFood = self.allFood[self.selectIndex + 1]
        if selectFood then
            local ownNum = GoodsUtils.GetThingNo(selectFood.foodData.id)
            if ownNum > 0 then
                Events.Broadcast(ClubUtils.EventName.FeedCat_ChooseFood, selectFood.foodData.id)    
            end
        end
    end)
end

function OverseaClubFeedingFoodPopup:OnInitialize()
    return CoWaitDo(function()
        --local initParams = self.controller.Argument.parameters or {}
        self:InitData()
        self:RefreshUI()
    end)
end

function OverseaClubFeedingFoodPopup:InitData()
    self.foodData = {}
    local likeFood = {}
    local normalFood = {}
    local specialFood = nil
    local specialFoodId = Utils.GetParamValue(Utils.ParamsId.SpecialFoodId)
    local foodList = Utils.GetFoodList()

    for i, v in ipairs(foodList) do
        if v.id == specialFoodId then
            specialFood = { foodData = v, isLike = true, isSpecial = true }
        else
            if table.isContain(Mgr.Server.dojo.petsLikeFood, v.id) then
                table.insert(likeFood, { foodData = v, isLike = true })
            else
                table.insert(normalFood, { foodData = v, isLike = false })
            end
        end
    end
    local function sortFunc(a, b)
        return a.foodData.quality > b.foodData.quality
    end
    if #likeFood > 1 then
        table.sort(likeFood, sortFunc)
    end

    if #normalFood > 1 then
        table.sort(normalFood, sortFunc)
    end

    ---@type OverseaClubFeedingFoodNode.InputData[]
    self.allFood = {}
    if specialFood then
        table.insert(self.allFood, specialFood)
    end
    table.insertto(self.allFood, likeFood)
    table.insertto(self.allFood, normalFood)
end

function OverseaClubFeedingFoodPopup:RefreshUI()
    if #self.allFood == 0 then
        CfUtils.SetActive(self.Empty, true)
        CfUtils.SetActive(self.ScrollView, false)
        return
    end

    self:RefreshSelect()
    self:RefreshList()
end

function OverseaClubFeedingFoodPopup:RefreshSelect()
    local selectFood = self.allFood[self.selectIndex + 1]
    if selectFood then
        CfUtils.SetActive(self.TextDesc2, true)
        CfUtils.FillText(self.TextDesc2, localize("每份_foodName_增加_num1_饱食度,_num2_神兽经验", { _foodName_ = selectFood.foodData.name, _num1_ = selectFood.foodData.catSatiety, _num2_ = selectFood.foodData.catExp }))
    else
        CfUtils.SetActive(self.TextDesc2, false)
    end
end

function OverseaClubFeedingFoodPopup:RefreshList()
    if not self.ScrollView.IsListViewInit then
        self.ScrollView:InitGridView(#self.allFood, Bind(self, self.OnGetGridItemByIndex))
    else
        GameUtils.ReloadData(self.ScrollView, #self.allFood)
    end
end

function OverseaClubFeedingFoodPopup:OnGetGridItemByIndex(listView, index, row, column)
    local food = self.allFood[index + 1]
    food.select = index == self.selectIndex
    local cell = listView:NewListViewItem("Cell")
    if cell then
        ---@type OverseaClubFeedingFoodNode
        local lua = CfUtils.GetLuaScr(cell, FoodNodeLuaPath)
        lua:RefreshData(food, function()
            local oldCell = self.ScrollView:GetShownItemByItemIndex(self.selectIndex)
            if oldCell then
                ---@type OverseaClubFeedingFoodNode
                local preLua = CfUtils.GetLuaScr(oldCell, FoodNodeLuaPath)
                preLua:Select(false)
            end
            lua:Select(true)
            self.selectIndex = index
            self:RefreshSelect()
        end)
    end
    return cell
end

return OverseaClubFeedingFoodPopup