-------------------------------------------------------------------------------
-- 任务界面 - 成长任务面板
-- 
-- Author: zou hanjie <canglanxing@funtoygame.com>
-- 
-- Create: 2023-07-27 13:30:11
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaGrowUpTaskSecondTaskCell.prefab
---@class UITaskGrowUpTaskNode
---@field Env                           	UITaskGrowUpTaskNode                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtRightButton                	UnityEngine.UI.Text                     @ 最右侧按钮文本
---@field rightButton                   	UnityEngine.UI.Button                   @ 最右侧按钮
---@field CommonSmallHeadNode           	Engine.Modules.LuaBehaviour             @ 小头图  CardHeadNode 按钮
---@field GoodNode                      	Engine.Modules.LuaBehaviour             @ 中右部 奖励信息格: GoodNodeMB
---@field Particle                      	UnityEngine.ParticleSystem              @ 头像 粒子特效 
---@field ImgDecorate2                  	Game.Native.Common.UISwitchImage        @ 最左侧边条 可换颜色 
---@field ImgDecorate                   	Game.Native.Common.UISwitchImage        @ 最左侧边条 可换颜色 
---@field AnimRoot                      	UnityEngine.Animation                   @ 完成后播放动画
---@field SliderFill                    	Game.Native.Common.UISwitchImage        @ 进度条内条 颜色可切为粉红
---@field HasReceived                   	UnityEngine.RectTransform               @ 本组所有任务 都以领取
---@field TxtNotOwned                   	UnityEngine.RectTransform               @ "未拥有该战斗员", 替换掉 slider
---@field Slider                        	UnityEngine.UI.Slider                   @ 进度条本条
---@field SliderTxt                     	TMPro.TextMeshProUGUI                   @ 进度条txt  "5/5"
---@field SliderParent                  	UnityEngine.RectTransform               @ 进度条parent, 用来显示影藏
---@field NameImgLine                   	Game.Native.Common.UISwitchImage        @ 卡牌名字 底图 (一个长条)
---@field TxtCardName                   	UnityEngine.UI.Text                     @ 卡牌名字 
---@field TxtInfo                       	UnityEngine.UI.Text                     @ "玩家等级达到10级"
local UITaskGrowUpTaskNode = Class('UITaskGrowUpTaskNode')

-- ==============================================================

local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程

local UITaskGrowUpPanelUtils = import("Game.UI.Tasks.UITaskGrowUpPanelUtils")
local TaskState = UITaskGrowUpPanelUtils.TaskState


local AutoFixSizeListView = CS.Engine.UI.AutoFixSizeListView


local Transform = CS.UnityEngine.Transform
local Color = CS.UnityEngine.Color
local Vector3 = CS.UnityEngine.Vector3
local MeshRoundedImage = CS.Engine.UI.MeshRoundedImage
local Image = CS.UnityEngine.UI.Image
local Mathf = CS.UnityEngine.Mathf
local CanvasGroup = CS.UnityEngine.CanvasGroup

local KTool = CS.Engine.Lib.KTool
local Button = CS.UnityEngine.UI.Button


local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)


-- ==============================================================

local normalScale = Vector3.one
local smlScale = Vector3( 0.73, 0.73, 0.73 )


-- ==============================================================

function UITaskGrowUpTaskNode:__init()
    self.isInit = false
    self.secondPanelEnv = nil
end


function UITaskGrowUpTaskNode:__delete()
end


function UITaskGrowUpTaskNode:OnDestroy()
    if self.co_tasks ~= nil then 
        cs_coroutine.stop( self.co_tasks )
    end 
    self.co_tasks = nil
    ---
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end



function UITaskGrowUpTaskNode:SelfInit()

    assert(  
        self.TxtRightButton and 
        self.rightButton and 
        self.CommonSmallHeadNode and 
        self.GoodNode and 
        self.Particle and 
        self.ImgDecorate2 and 
        self.ImgDecorate and 
        self.AnimRoot and 
        self.SliderFill and 
        self.HasReceived and 
        self.TxtNotOwned and 
        self.Slider and 
        self.SliderTxt and 
        self.SliderParent and 
        self.NameImgLine and 
        self.TxtCardName and 
        self.TxtInfo
    )

    --self.CommonSmallHeadNodeEnv = self.CommonSmallHeadNode.Env 
    self.CommonSmallHeadNodeEnv = CfUtils.GetLuaScr(self.CommonSmallHeadNode.gameObject, "Game.Behaviours.CardHeadNode")
    assert( self.CommonSmallHeadNodeEnv )

    self.GoodNodeEnv = CfUtils.GetLuaScr(self.GoodNode, "Game.Behaviours.GoodNodeMB")
    assert( self.GoodNodeEnv ) 


    self.canvasGroup = KTool.GetComponent(self.AnimRoot.gameObject, typeof(CanvasGroup))
    self.canvasGroup.alpha = 1

    -- 绑定主按钮
    SetButtonAction(self.rightButton, Bind(self, self.OnClickRightButton))
    ---
    self.isInit = true
end


-- ============================================================================


---@param params table @
function UITaskGrowUpTaskNode:FreshUI( params )
    if self.isInit == false then 
        self:SelfInit()
    end 

    self.taskIdx = params.taskIdx -- 1-based
    self.taskDojo = params.taskDojo -- "task/growthTask".data.task[i]
    self.themeId = params.themeId
    self.secondPanelEnv = params.secondPanelEnv -- 二级页面本体

    -- =======================================
    -- 读配表:
    self.taskVO = UITaskGrowUpPanelUtils.ReadGrowUpVO( self.taskDojo.currentTaskId )   -- 成长任务表: UITaskGrowUpVO
    self.cardVO = UITaskGrowUpPanelUtils.ReadCardVO( self.taskVO.taskContentId )      -- 角色卡牌表, 本任务的, 不是本主题的
    self.cardGoodsVO = UITaskGrowUpPanelUtils.ReadCardGoodsVO( self.taskVO.taskContentId )     -- 10卡牌道具表 - GoodsVo

    -- 拿到 玩家卡牌数据:
    local cardDojo = cardComponent:GetCardByConfId( self.taskVO.taskContentId )
    local isHaveThisCard = isNotNull(cardDojo)

    local taskProgress   = checkInt( self.taskDojo.progress )
    local taskContentNum = checkInt( self.taskVO.taskContenNum )
    local isAllConditionsAchieve = (taskProgress >= taskContentNum) and (taskContentNum ~= 0) -- 是否所有调节已达成 (可以领任务奖励了)

    -- 确认 任务状态:
    self:RefreshTaskState( isHaveThisCard, isAllConditionsAchieve, self.taskDojo.status )


    -- 任务可领取时 slider 要为红色, 剩余情况都为 灰色:
    CfUtils.PlayAnimation(self.AnimRoot, (self.taskState == TaskState.WaitToGetRewards) and "OverseaTasksDialogCellCompleteGo" or "OverseaTasksDialogCellGo" )

    -- ======================================== 绘制 =================================================

    -- 延迟一两帧再绘制, 否则一些 text 的颜色无法被设置
    if self.co_tasks ~= nil then 
        cs_coroutine.stop( self.co_tasks )
    end 
    self.co_tasks = cs_coroutine.start(function()
        coroutine.yield(Yielders.EndOfFrame)        
        self:DrawUI( cardDojo, isHaveThisCard, taskProgress, taskContentNum, isAllConditionsAchieve )
    end)    
    
end


function UITaskGrowUpTaskNode:DrawUI( cardDojo, isHaveThisCard, taskProgress, taskContentNum, isAllConditionsAchieve )

    -- 绘制 左侧 卡牌 小头像:
    if isHaveThisCard == true then 
        ----- 说明 玩家已经持有这个卡了: -------
        self.CommonSmallHeadNodeEnv:FreshNode( cardDojo, true,  13, true )  -- CardHeadNode
    else 
        ----- 说明 玩家暂时没有这个卡: -------
        self.CommonSmallHeadNodeEnv:FreshNodeByCardVo( self.taskVO.taskContentId, 13, true )  -- CardHeadNode
        self.CommonSmallHeadNodeEnv:SetLockStatus( true ) -- 设置为锁定状态, 记得调下 prefab 里 lockGroup 的半透明度
        self.CommonSmallHeadNodeEnv:SetBottomImageStatus( false )
        -- todo: 需要把这个 头像变成灰色
    end

    -- 绘制中部的名字, 滑条: 
    self.TxtCardName.text = self.cardVO.descr .. "-" .. self.cardVO.name
    if isHaveThisCard == true then 
        ----- 说明 玩家已经持有这个卡了: -------
        self.TxtInfo.text = self.taskVO.desc -- "玩家等级达到10级"

        CfUtils.FillText(self.SliderTxt, string.format("<size=30><color=#545454>%s</color></size>/%s", taskProgress, taskContentNum)) -- "1/5"
        self.Slider.value = Mathf.Min( 1, taskProgress / taskContentNum ) -- 进度条值 
        CfUtils.SetActive(self.SliderParent.gameObject, true )
        CfUtils.SetActive(self.TxtNotOwned.gameObject, false )

    else 
        ----- 说明 玩家暂时没有这个卡: -------
        self.TxtInfo.text = ""        
        CfUtils.SetActive(self.TxtInfo.gameObject, false )
        CfUtils.SetActive(self.SliderParent.gameObject, false )
        CfUtils.SetActive(self.TxtNotOwned.gameObject, true )
    end

    -- todo: 让进度条 变红色, 好像和 动画冲突了...
    CfUtils.SetUISwitchImage(self.SliderFill.gameObject, 2 )
    self.SliderFill:Reset()


    -- 绘制 中右部 奖励信息:
    if self.GoodNodeEnv then
        if isHaveThisCard == true then 
            ----- 说明 玩家已经持有这个卡了: -------
            CfUtils.SetActive(self.GoodNode.gameObject, true )

            self.GoodNodeEnv:Reload({
                goodsId = self.taskVO.rewardIds[1],
                text = string.format( "x%s", checkInt(self.taskVO.rewardNums[1]) ), -- !!! 配表中可能存在多个奖励, 但此处只显示第一个
                isShowNo = true,
            })

            -- 奖励按钮:
            self.GoodNodeEnv:SetClickButtonAction(function()
                print( "koko 点击奖励预览" )
                --local pivot = self.GoodNodeEnv.Container.gameObject
                local pivot = self.GoodNode.gameObject
                local goodsId = self.taskVO.rewardIds[1]
                local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
                if isTable(vo) and isNotNull(pivot) then
                    --if isShowGoodsTips then
                        -- 有培养跳转
                        --GameUtils.ShowCommonGoodsTipsBoard( pivot, goodsId, true)
                    -- else
                        -- 无培养跳转
                        GameUtils.ShowCommonTipsBoard( pivot, vo.name, vo.desc, vo.quality, vo.id)
                    -- end
                end
            end)
            
        else 
            ----- 说明 玩家暂时没有这个卡: -------
            CfUtils.SetActive(self.GoodNode.gameObject, false )
        end
    end 

    -- 绘制 右侧按钮: "领取奖励" / "去养成" / "前往领取" / 无:
    if self.taskState == TaskState.NoCard then 
        ----- 玩家没有这张卡:
        CfUtils.SetActive(self.HasReceived.gameObject, false )
        CfUtils.SetActive(self.rightButton.gameObject, true )
        CfUtils.FillText( self.TxtRightButton,  localize("前往获取") )
        CfUtils.SetColor( self.rightButton, Color.black )
        CfUtils.SetColor( self.TxtRightButton, Color.white )

        CfUtils.SetUISwitchImage(self.NameImgLine.gameObject, 2 ) -- 卡排名: 黑底白字
        CfUtils.SetUISwitchText(self.TxtCardName.gameObject, 2 )

    elseif self.taskState == TaskState.NotAllAchieved then
        ----- 这个任务的领取条件 没有完全达成:
        CfUtils.SetActive(self.HasReceived.gameObject, false )
        CfUtils.SetActive(self.rightButton.gameObject, true )
        CfUtils.FillText( self.TxtRightButton,  localize("去养成") )
        CfUtils.SetColor( self.rightButton, Color.white )
        CfUtils.SetColor( self.TxtRightButton, Color.black )

        CfUtils.SetUISwitchImage(self.NameImgLine.gameObject, 1 ) -- 卡牌名: 白底黑字
        CfUtils.SetUISwitchText(self.TxtCardName.gameObject, 1 )

    elseif self.taskState == TaskState.WaitToGetRewards then
        ----- 领取条件全达成, 可以领取了:
        CfUtils.SetActive(self.HasReceived.gameObject, false )
        CfUtils.SetActive(self.rightButton.gameObject, true )
        CfUtils.FillText( self.TxtRightButton,  localize("领取奖励") )
        CfUtils.SetColor( self.rightButton, Color.black )
        CfUtils.SetColor( self.TxtRightButton, Color.white )

        CfUtils.SetUISwitchImage(self.NameImgLine.gameObject, 1 ) -- 卡牌名: 白底黑字
        CfUtils.SetUISwitchText(self.TxtCardName.gameObject, 1 )

    else 
        ----- 这个 任务组 的所有任务都领取完了:
        CfUtils.SetActive(self.HasReceived.gameObject, true )
        CfUtils.SetActive(self.rightButton.gameObject, false )

        CfUtils.SetUISwitchImage(self.NameImgLine.gameObject, 1 ) -- 卡牌名: 白底黑字
        CfUtils.SetUISwitchText(self.TxtCardName.gameObject, 1 )
    end
end



function UITaskGrowUpTaskNode:RefreshTaskState( isHaveThisCard_, isAllConditionsAchieve_, taskDojoStatus_ )

    if type(isHaveThisCard_)~="boolean" or type(isAllConditionsAchieve_)~="boolean" or type(taskDojoStatus_)~="number" then 
        printError( "参数异常" )
    end
    isHaveThisCard_ = checkBool(isHaveThisCard_)
    isAllConditionsAchieve_ = checkBool(isAllConditionsAchieve_)
    taskDojoStatus_ = checkInt( taskDojoStatus_ )
    -------

    self.taskState = TaskState.NoCard
    if isHaveThisCard_ == true then 
        if isAllConditionsAchieve_ == false then 
            self.taskState = TaskState.NotAllAchieved
            --print( "koko 任务状态: NotAllAchieved" )
            return

        else 
            if taskDojoStatus_ == 0 then -- 未领取
                self.taskState = TaskState.WaitToGetRewards
                --print( "koko 任务状态: WaitToGetRewards" )
                return
            elseif taskDojoStatus_ == 1 then -- 可领取
                self.taskState = TaskState.WaitToGetRewards
                --print( "koko 任务状态: WaitToGetRewards" )
                return

            elseif taskDojoStatus_ == 2 then -- 已领取 (说明整个 task group 都空了) 
                self.taskState = TaskState.AllTaskFinish
                --print( "koko 任务状态: AllTaskFinish" )
                return
            end 
        end 
    end
    --print( "koko 任务状态: NoCard" )
end 



function UITaskGrowUpTaskNode:OnClickRightButton()
    print( "按下 右侧按钮" )
    if self.taskState == TaskState.NoCard then  -- 前往获取
        ----- 玩家没有这张卡:
        -- 10卡牌道具表 里的 跳转配置: 如有多条跳转，则只调用第一条跳转数据
        if isNotNull(self.cardGoodsVO) and type(self.cardGoodsVO.jumpAway)=="table" and type(self.cardGoodsVO.jumpParameter)=="table" and 
            (checkInt(self.cardGoodsVO.jumpAway[1]) > 0)
        then 
            -- ---@type GoodsConfMgr
            local goodsConfMgr  = GoodsConfMgr:GetInstance()
            local jumpModuleRow = goodsConfMgr:GetJumpModuleRow(self.cardGoodsVO.jumpAway[1])            
            goodsConfMgr:ExecuteJump(jumpModuleRow, {}) -- todo: 未来可能会用到 jumpParameter[1] 数据...
        end

    elseif self.taskState == TaskState.NotAllAchieved then -- 去养成
        ----- 这个任务的领取条件 没有完全达成:    
        if isNotNull(self.taskVO) and (checkInt(self.taskVO.openType) > 0) then 
            print("koko  去养成: 任务id: " .. tostring(self.taskVO.taskAchId) )
            ---@type GoodsConfMgr
            local goodsConfMgr  = GoodsConfMgr:GetInstance()
            local jumpModuleRow = goodsConfMgr:GetJumpModuleRow(self.taskVO.openType)
            goodsConfMgr:ExecuteJump(jumpModuleRow, {}, 0, false, { cardId = self.taskVO.openParameter })
        end 

    elseif self.taskState == TaskState.WaitToGetRewards then -- 领取奖励
        ----- 领取条件全达成, 可以领取了:
        
        if self.secondPanelEnv then 
            print("koko  领取单个任务奖励: 任务id: " .. tostring(self.taskVO.taskAchId) )
            self.secondPanelEnv:CallServer_DrawGrowthTaskRewards( self.themeId, self.taskVO.taskAchId )
        else    
            printError( "数据异常" )
        end

    else 
        ----- 这个 任务组 的所有任务都领取完了:
        printError( "异常: 此时不该显示按钮" )
    end
end








return UITaskGrowUpTaskNode
