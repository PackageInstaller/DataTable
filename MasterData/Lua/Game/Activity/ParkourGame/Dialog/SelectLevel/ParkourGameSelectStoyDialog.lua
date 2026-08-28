
-- 跑酷选关页面, 选择 剧情关卡后, 弹出的信息页面

--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourMainlineDetailsStoryNormalPopup12001801.prefab > name: OverseaParkourMainlineDetailsStoryNormalPopup12001801
---@class ParkourGameSelectStoyDialog
---@field Env                           	ParkourGameSelectStoyDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Title                         	UnityEngine.RectTransform               	@ 0    左上角: "0-0 紧急大门"
---@field ImageDisplay                  	UnityEngine.RectTransform               	@ 1    左侧大配图
---@field TextDesc                      	UnityEngine.RectTransform               	@ 2    右侧上部描述
---@field CommonGoodsListLight          	UnityEngine.RectTransform               	@ 3    右侧下方奖励
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 4    进入按钮
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               	@ 5    进入按钮 右上角信息框
---@field BtnClose                      	UnityEngine.RectTransform               	@ 6    
local ParkourGameSelectStoyDialog = Class("ParkourGameSelectStoyDialog")


-- =========================================================

---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
---@type ParkourGameUtil
local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")
local ResourceModule = CS.Engine.Modules.ResourceModule
local UIModule = CS.Engine.UI.UIModule

--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程

local GameUtils = import('Game.Utils.GameUtils')
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Random = CS.UnityEngine.Random
local Canvas = CS.UnityEngine.Canvas
local Physics = CS.UnityEngine.Physics
local KTool = CS.Engine.Lib.KTool

local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local UINavigationBarRoot = CS.UINavigationBarRoot
local ChapterUtils = import('Game.Chapter.ChapterUtils')


---@class ParkourGameSelectStoyDialog.InputData
---@field mainlineDialog table 
---@field homeDojo table @ 单个关卡的
---@field vo       table @ 单个关卡的 主线关卡表

-- =========================================================


function ParkourGameSelectStoyDialog:__init()
    self.controller = nil
end

function ParkourGameSelectStoyDialog:__delete()
    self.controller = nil
end


function ParkourGameSelectStoyDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        ---@type ParkourGameSelectStoyDialog.InputData
        self.inputData = self.controller.Argument.parameters

        self.levelId = checkInt(self.inputData.homeDojo.questId)

        self.Root = self.controller.gameObject.transform:Find("Root")
        self.imgGO = self.ImageDisplay:Find("ImgIcon").gameObject -- 左侧大图
        self.titles = {
            TextNumber = self.Title:Find("TextNumber"),
            TextDesc   = self.Title:Find("TextDesc"),
        }

        CfUtils.SetActive( self.CommonBtnConsumePop.gameObject, false ) -- 剧情不消耗资源

        SetButtonAction(self.FontStyleButton.gameObject,    Bind(self,self._OnClickBtnEnter) )
        SetButtonAction(self.BtnClose.gameObject,           Bind(self,self._OnClickBtnClose) )
        self:RefreshUI()
    end))
    return coWait
end



function ParkourGameSelectStoyDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        ---
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end




function ParkourGameSelectStoyDialog:RefreshUI()
    local mainlineVO = self.inputData.vo -- 主线关卡表vo raw
    -- title:
    --print("name = " .. tostring(mainlineVO.name))
    --local titleDatas = string.split( mainlineVO.name, " " )
    CfUtils.FillText( self.titles.TextNumber.gameObject, tostring(mainlineVO.title) )
    CfUtils.FillText( self.titles.TextDesc.gameObject, tostring(mainlineVO.name) )


    CfUtils.FillImage( self.imgGO, mainlineVO.picture )

    CfUtils.SetActive( self.CommonBtnConsumePop.gameObject, false ) -- 剧情不消耗资源
    --UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, mainlineVO.costItem, mainlineVO.costNum) -- 剧情不消耗资源

    CfUtils.FillText( self.TextDesc.gameObject, mainlineVO.desc ) -- 主描述

    -- 奖励
    local rewardData = RewardConfMgr:GetInstance():GetTeamShowRewardData(self.levelId)
    ---@type CommonGoodsListLight
    local goodsLua = CfUtils.GetLuaScr(self.CommonGoodsListLight, "Game.Behaviours.CommonGoodsListLight")
    if goodsLua then
        goodsLua:FreshBaseUI(rewardData)
    end
end


function ParkourGameSelectStoyDialog:_OnClickBtnClose()
    --printError( "close" )
    UIModule.BackDialog()
end


function ParkourGameSelectStoyDialog:_OnClickBtnEnter()


    local mainlineVO = self.inputData.vo -- 主线关卡表vo raw
    local goodsId = mainlineVO.costItem
    local costNum = mainlineVO.costNum -- 成功时消耗的道具,  目前为0
    if ParkourGameUtil.IsHaveEnoughGoods(goodsId, costNum) == false then 
        return
    end 


    --printError( "enter" )
    CfUtils.SetActive( self.Root.gameObject, false )

    CoStop(self.co_1)
    self.co_1 = CoStart(function()

        --- 播放剧情
        local isChapterFinish = false
        local vo = ParkourGameUtil.GetMiniWorldMainChapterVo( self.levelId )
        local chapterId = checkNumber(vo.plotIdStory)
        ChapterUtils.ProcessChapter(chapterId, function(go)
            --printError("==1== 开播剧情")
            self.controller.gameObject.transform.localPosition = Vector3(9999, 9999, 9999)
            URPCameraController:SetMainCameraActive(false)
            UINavigationBarRoot.Instance:SetActive(false)
            self._plotGo = go
        end, function()
            self.controller.gameObject.transform.localPosition = Vector3(0, 0, 0)
            URPCameraController:SetMainCameraActive(true)
            UINavigationBarRoot.Instance:SetActive(true)
            CfUtils.SafeDelete(self._plotGo)
            isChapterFinish = true
        end)

        --- 调用后端: plot:
        local responseData = nil
        local isServerRet = false
        local isPass = ParkourGameUtil.IsLevelPassed( self.levelId )
        if isPass == false then
            --printError("==1== 调用 plot")
            GameUtils.Request("activityTinyWorld/plot", { activityUuid = Mgr.activityUuid, questId = self.levelId }, function(request, response)
                if checkNumber(response.errCode) == 0 then
                    responseData = checkTable(response.data)
                end
                isServerRet = true
            end)
        end
        --- 等待:
        while isChapterFinish == false do
            coroutine.yield(Yielders.EndOfFrame)
        end
        if isPass == false then
            while isServerRet == false do
                coroutine.yield(Yielders.EndOfFrame)
            end
        end
        coroutine.yield(Yielders.EndOfFrame)
        -- printError("==1== 结束等待")

        --- 存储 后端接口返回的数据:
        if responseData ~= nil then
            Mgr.homeDojo.mainQuestId = responseData.newMainQuestId 
            Mgr.homeDojo.mainQuestMap = responseData.mainQuestMap
            Mgr:StartTimer()
            if #responseData.rewards > 0 then 
                Mgr.rewards = responseData.rewards
            end 
        else
            Mgr.homeDojo.mainQuestId = self.levelId
        end 

        --- 调用后端: home:
        -- local homeRet = {}
        -- cs_coroutine.yield_return( ParkourGameUtil.CallHome(Mgr.activityUuid, homeRet ) )
        -- Mgr:SetHomeDojoData(homeRet.responseData)
        --- 返回
        UIModule.BackDialog() 
    end)
end




return ParkourGameSelectStoyDialog