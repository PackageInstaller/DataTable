
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type CatBallUtils
local CatBallUtils                = import("Game.CatBall.CatBallUtils")
--endregion

--region define

local CellName    = "DescNode"
local CellEnvPath = "Game.CatBall.CatBallAttributeIconPreviewDescNode"

--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballAttributeIconPreview.prefab
---@class CatBallAttributeIconPreview
---@field Env                           	CatBallAttributeIconPreview             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field DescNode                      	UnityEngine.RectTransform               
---@field ScrollView                    	SuperScrollView.LoopGridView            
local CatBallAttributeIconPreview = Class('CatBallAttributeIconPreview')


function CatBallAttributeIconPreview:__init()
end


function CatBallAttributeIconPreview:__delete()
    self.controller = nil
end


function CatBallAttributeIconPreview:Awake()
end


function CatBallAttributeIconPreview:OnFocus(focus)

end


function CatBallAttributeIconPreview:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
    end))
    return coWait
end


function CatBallAttributeIconPreview:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FreshScrollView()
    end))
    return coWait
end


function CatBallAttributeIconPreview:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CatBallAttributeIconPreview:OnInit()
    self:InitData()
end

function CatBallAttributeIconPreview:InitData()
    local dataList = CatBallUtils.GetAllCatBallAttributeFlagData()
    self._dataList = dataList
end

--endregion 


--region logic 


--- FreshTabs
--- 刷新所有标签
function CatBallAttributeIconPreview:FreshScrollView()
    local ScrollView = self.ScrollView
    local count = #self._dataList
    if not ScrollView.IsListViewInit then
        ScrollView:InitGridView(count, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end

    self._isPlayFadeIn = false
end

function CatBallAttributeIconPreview:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(CellName)
    local node = GetLuaBehaviour(cell.gameObject, CellEnvPath)
    
    ---@type CatBallAttributeIconPreviewDescNode
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end

    if nodeEnv then
        local position = index + 1
        local data = self._dataList[position]
        nodeEnv:FreshUI(data, position)
    end

    return cell
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CatBallAttributeIconPreview
