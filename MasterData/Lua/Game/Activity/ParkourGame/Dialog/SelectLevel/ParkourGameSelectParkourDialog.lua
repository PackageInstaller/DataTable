
-- 跑酷选关页面, 选择跑酷关卡后, 弹出的信息页面

--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourMainlineDetailsStoryStarLevelPopup12001801.prefab > name: OverseaParkourMainlineDetailsStoryStarLevelPopup12001801
---@class ParkourGameSelectParkourDialog
---@field Env                           	ParkourGameSelectParkourDialog          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               	@ 0    
---@field BtnEnter                      	UnityEngine.RectTransform               	@ 1    进入按钮
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               	@ 2    进入按钮 右上角信息框
---@field taskNode1                     	UnityEngine.RectTransform               	@ 3    star1 节点
---@field taskNode2                     	UnityEngine.RectTransform               	@ 4    star2 节点
---@field taskNode3                     	UnityEngine.RectTransform               	@ 5    star3 节点
---@field Title                         	UnityEngine.RectTransform               	@ 6    左上角: "0-0 紧急大门"
---@field ImgIcon                       	UnityEngine.RectTransform               	@ 7    左中 大图
---@field Debuff                        	UnityEngine.RectTransform               	@ 8    陷阱组
---@field Buff                          	UnityEngine.RectTransform               	@ 9    增益组
---@field TextDesc                      	UnityEngine.RectTransform               	@ 10   右侧中部描述
---@field CommonGoodsListLight          	UnityEngine.RectTransform               	@ 11   右侧下方奖励
---@field debuffNode                    	UnityEngine.RectTransform               	@ 12   陷阱组 基础节点
---@field buffNode                      	UnityEngine.RectTransform               	@ 13   增益组 基础节点
local ParkourGameSelectParkourDialog = Class("ParkourGameSelectParkourDialog")


-- =========================================================

---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
---@type ParkourGameUtil
local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")
local ResourceModule = CS.Engine.Modules.ResourceModule
local UIModule = CS.Engine.UI.UIModule
local UINavigationBarRoot = CS.UINavigationBarRoot

--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程

--local GameUtils = import('Game.Utils.GameUtils')
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Random = CS.UnityEngine.Random
local Canvas = CS.UnityEngine.Canvas
local Physics = CS.UnityEngine.Physics
local KTool = CS.Engine.Lib.KTool



---@class ParkourGameSelectParkourDialog.InputData
---@field homeDojo table @ 单个关卡的
---@field vo       table @ 单个关卡的 主线关卡表


-- =========================================================


function ParkourGameSelectParkourDialog:__init()
    self.controller = nil
end

function ParkourGameSelectParkourDialog:__delete()
    self.controller = nil
end


function ParkourGameSelectParkourDialog:Awake()
    self.topGoods = { Constants.Currency.MiniWorldConsume, Constants.Currency.MiniWorldHp }
end

function ParkourGameSelectParkourDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        ---@type ParkourGameSelectParkourDialog.InputData
        self.inputData = self.controller.Argument.parameters
        assert( isNotNull(self.inputData) )
        ---
        self.levelId = checkInt(self.inputData.homeDojo.questId)
        self.threeStarsConditionVOs = ParkourGameUtil.GetNeededMiniWorldThreeStarsConditionVOs( self.levelId ) -- MiniWorldThreeStarsConditionVO[]        

        ----- 
        self.titles = {
            TextNumber = self.Title:Find("TextNumber"),
            TextDesc   = self.Title:Find("TextDesc"),
        }
        self.imgGO = self.ImgIcon.gameObject -- 左侧大图
        self.taskNodes = { self.taskNode1, self.taskNode2, self.taskNode3 }

        ---
        SetButtonAction(self.BtnEnter.gameObject,           Bind(self,self._OnClickBtnEnter) )
        SetButtonAction(self.BtnClose.gameObject,           Bind(self,self._OnClickBtnClose) )
        self:RefreshUI()
    end))
    return coWait
end



function ParkourGameSelectParkourDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        ---
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end


function ParkourGameSelectParkourDialog:OnFocus(focus)

    if focus then 
        --- 右上角货币
        if self.topGoods then
            CfUtils.RefreshTopGoods(self.topGoods)
        end
    end 
end


function ParkourGameSelectParkourDialog:RefreshUI()

    local mainlineVO = self.inputData.vo -- 主线关卡表vo raw

    -- title:
    --print("name = " .. tostring(mainlineVO.name))
    --local titleDatas = string.split( mainlineVO.name, " " )
    CfUtils.FillText( self.titles.TextNumber.gameObject, tostring(mainlineVO.title) )
    CfUtils.FillText( self.titles.TextDesc.gameObject, tostring(mainlineVO.name) )


    CfUtils.FillText( self.TextDesc.gameObject, mainlineVO.desc ) -- 主描述

    CfUtils.FillImage( self.imgGO, mainlineVO.picture )
    UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, mainlineVO.costItem, mainlineVO.costNum)

    --- tasks:
    for i=1,3 do 
        local vo = self.threeStarsConditionVOs[i]
        local node = self.taskNodes[i]
        if isNotNull(vo) then 
            local isFinish_ = (self.inputData.homeDojo.starTask[i].status > 0)
            ParkourGameUtil.DawTaskLine( node, isFinish_, vo.taskTitle )
        else 
            printError("微缩世界三星条件表 条目丢失, i = "..tostring(i)  )
        end
    end 

    -- 增益组
    local buffIds = string.split(mainlineVO.gainId, ";")
    for k,id in pairs(buffIds) do 
        local gainVO = ParkourGameUtil.GetMiniWorldBuffItemVo( checkInt(id) )
        self:DrawBuffNode( self.buffNode, gainVO.icon, gainVO.name, gainVO.desc )
    end 
    -- 陷阱组
    local debuffIds = string.split(mainlineVO.trapId, ";")
    for k,id in pairs(debuffIds) do 
        local trapVO = ParkourGameUtil.GetMiniWorldTrapVo( checkInt(id) )
        self:DrawBuffNode( self.debuffNode, trapVO.icon, trapVO.name, trapVO.desc )
    end 

    -- 奖励
    local rewardData = RewardConfMgr:GetInstance():GetTeamShowRewardData(self.levelId)
    ---@type CommonGoodsListLight
    local goodsLua = CfUtils.GetLuaScr(self.CommonGoodsListLight, "Game.Behaviours.CommonGoodsListLight")
    if goodsLua then
        goodsLua:FreshBaseUI(rewardData )
    end
end




function ParkourGameSelectParkourDialog:DrawBuffNode( baseNode_, imgPath_, title_, desc_ )
    local newTF = GameObject.Instantiate( baseNode_, baseNode_.parent )
    local ImgIcon = newTF:Find("ImgIcon")
    CfUtils.FillImage( ImgIcon, imgPath_ )
    CfUtils.SetActive( newTF.gameObject, true )

    SetButtonAction(newTF.gameObject, function()
        GameUtils.ShowCommonTipsBoardAttribute(newTF.gameObject, title_, desc_ )
    end)
end



function ParkourGameSelectParkourDialog:_OnClickBtnEnter()
    --printError( "enter" )

    local mainlineVO = self.inputData.vo -- 主线关卡表vo raw
    local goodsId = mainlineVO.costItem
    local costNumLose = checkInt(mainlineVO.costNumLose)  -- 进入时消耗的道具, 目前为 0
    local costNum = checkInt(mainlineVO.costNum)          -- 成功时消耗的道具
    if ParkourGameUtil.IsHaveEnoughGoods(goodsId, costNum) == false then 
        return
    end 

    -- 进入时消耗道具:
    GoodsUtils.ConsumeGoods({
        { goodsId = checkInt(mainlineVO.costItem), num = costNumLose }
    }, false)

    GameUtils.ShowBlackOverlay(nil,function()
        UIModule.BackDialog() -- !!! 先关掉自己这个 小窗口
        UIModule.OpenDialog(
            { 
                id = Constants.UITypeIds.ParkourGameMainDialog, 
                parameters = 
                {
                    gameType = ParkourGameUtil.GameType.Normal, 
                    levelId = self.levelId,
                }
            },
            { {id = Constants.UITypeIds.OverseaParkourMainlineDialog } }
        )
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 1 )) -- !!!! 粗暴的方式, 确保黑幕足够长
    end)
end


function ParkourGameSelectParkourDialog:_OnClickBtnClose()
    --printError( "close" )
    UIModule.BackDialog()
end









return ParkourGameSelectParkourDialog