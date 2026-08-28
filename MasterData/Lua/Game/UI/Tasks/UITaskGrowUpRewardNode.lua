-------------------------------------------------------------------------------
-- 成长任务 二级页面 左下角 每个宝箱元素
-- 
-- Author: zou hanjie <canglanxing@funtoygame.com>
-- 
-- Create: 2023-07-21 13:30:11
-------------------------------------------------------------------------------
        
--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaGrowUpTaskRewardNode.prefab
---@class UITaskGrowUpRewardNode
---@field Env                           	UITaskGrowUpRewardNode                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field InfoPivot                     	UnityEngine.RectTransform               @ 奖励预览窗口 对齐坐标点
---@field BtnReward                     	UnityEngine.UI.Button                   @ 宝箱 大按钮
---@field saog                          	UnityEngine.RectTransform               @ 扫光 特效
---@field TxtNumClaimed                 	UnityEngine.UI.Text                     @ 头像右下 "X3" 小字, 灰色
---@field TxtNum                        	UnityEngine.UI.Text                     @ 头像右下 "X3" 小字, 高亮
---@field Imgbg                         	Game.Native.Common.UISwitchImage        @ 头像底图
---@field ImgCardIcon                   	Engine.UI.ImageAlterable                @ 头像
---@field HeadItem                      	UnityEngine.RectTransform               @ 整个头像, 用来缩放
---@field ImgDrawDown                   	UnityEngine.RectTransform               @ "领取"
---@field ImgIcon                       	Game.Native.Common.UISwitchImage        @ 宝箱, 有3种状态
---@field UIFX_BoxGlow                  	UnityEngine.RectTransform               @ 发光特效
---@field ImgLine                       	Game.Native.Common.UISwitchImage        @ 虚线,
local UITaskGrowUpRewardNode = Class('UITaskGrowUpRewardNode')


-- ==============================================================

local UITaskGrowUpPanelUtils = import("Game.UI.Tasks.UITaskGrowUpPanelUtils")
local ChestState = UITaskGrowUpPanelUtils.ChestState

local AutoFixSizeListView = CS.Engine.UI.AutoFixSizeListView

local Transform = CS.UnityEngine.Transform
local Color = CS.UnityEngine.Color
local Vector3 = CS.UnityEngine.Vector3
local MeshRoundedImage = CS.Engine.UI.MeshRoundedImage

local KTool = CS.Engine.Lib.KTool

-- ==============================================================

local normalScale = Vector3.one
local smlScale = Vector3( 0.73, 0.73, 0.73 )
local grayColor = Color( 0.5, 0.5, 0.5, 1.0 ) 

-- ==============================================================

function UITaskGrowUpRewardNode:__init()
    self.isInit = false
    self.chestParams = {} -- 等待被 二级界面填入各种必须的参数

    -- secondPanelEnv.{ 
    --  themeVO,    -- 成长任务主题表
    --  cardVO,     -- 角色卡牌表
    --  cardGoodsVO -- 卡牌道具表
    -- }
    self.secondPanelEnv = nil  
end


function UITaskGrowUpRewardNode:__delete()
end


function UITaskGrowUpRewardNode:Start()
    if self.isInit == false then 
        self:Init_()
    end 
end


function UITaskGrowUpRewardNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-- ============================================================================


function UITaskGrowUpRewardNode:SetShowOrHide( isShow_ )
    CfUtils.SetActive( self.ImgLine.gameObject, isShow_ )
    CfUtils.SetActive( self.BtnReward.gameObject, isShow_ )
end 


-- 在最初阶段, 初始化 ui数据, 此时可能 二级页面尚未拿到 后端接口, 但没关系, 先初始化:
function UITaskGrowUpRewardNode:Init_()

    assert( 
        self.InfoPivot and
        self.BtnReward and 
        self.saog and 
        self.TxtNumClaimed and 
        self.TxtNum and 
        self.Imgbg and 
        self.ImgCardIcon and 
        self.HeadItem and 
        self.ImgDrawDown and 
        self.ImgIcon and 
        self.UIFX_BoxGlow and 
        self.ImgLine
    )

    self.rowMeshRoundedImage = KTool.GetComponent(self.ImgCardIcon.gameObject, typeof(MeshRoundedImage))
    assert( self.rowMeshRoundedImage )
    
    -- 绑定主按钮
    SetButtonAction(self.BtnReward, Bind(self, self.OnClickButton)) 

    -- 初始化 宝箱当前状态:
    self.chestState = ChestState.Locked -- 此宝箱未解锁    
    ---
    self.isInit = true
end


-- 刷新数据的同时, 彻底重绘 本宝箱
---@param params table @
function UITaskGrowUpRewardNode:FreshUI( params_, secondPanelEnv_ )
    if self.isInit == false then 
        self:Init_()
    end 

    -------
    self.chestParams = params_
    self.secondPanelEnv = secondPanelEnv_

    -- 判断 宝箱当前状态:
    if self.chestParams.chestIdx < self.secondPanelEnv.currentChestIdx then  -- 当前宝箱 左侧的, 都是 已领取的
        self.chestState = ChestState.Finshed

    elseif self.chestParams.chestIdx == self.secondPanelEnv.currentChestIdx then -- 当前宝箱本箱
        self.chestState = ChestState.CanNotReceive

        if self.chestParams.boxDojo then 
            local finishTaskIds = self.chestParams.boxDojo.finishTaskIds
            if table.count(finishTaskIds) == 4 then 
                self.chestState = ChestState.WaitReceive
            end 
        end 
        
    else -- 当前宝箱 右侧的, 都是未解锁的
        self.chestState = ChestState.Locked
    end 
    
    -- ==================================== 绘制 =========================================
    self:DrawUI()
end



-- 仅绘制, 不关心数据, 没相关数据就不绘制:
function UITaskGrowUpRewardNode:DrawUI()
    if self.isInit == false then 
        self:Init_()
    end 

    -- 绘制宝箱之间的绳子
    if type(self.chestParams.isLast) == "boolean" then
        CfUtils.SetActive(self.ImgLine.gameObject, (self.chestParams.isLast ~= true))
    end

    -- 设置 宝箱 左上角 小头图:
    if isNotNull(self.secondPanelEnv) and  type(self.secondPanelEnv.cardGoodsVO) == "table" and self.secondPanelEnv.cardGoodsVO.photoPath then
        self.ImgCardIcon:LoadSprite( self.secondPanelEnv.cardGoodsVO.photoPath )
    end
        
    -- 左上角小头图下方的 "X3" 的文本:
    local rewardNum = 0
    if self.chestParams.chestVO then 
        rewardNum = self.chestParams.chestVO.rewardNums[1] -- "X3" 里的数字
    end 
    local rewardNumStr = "x" .. tostring(rewardNum)
    self.TxtNum.text        = rewardNumStr
    self.TxtNumClaimed.text = rewardNumStr
    

    -- 从左到右 3种状态:
    if self.chestState == ChestState.Finshed then
        -- 此宝箱已被领取
        CfUtils.SetUISwitchImage(self.ImgIcon.gameObject,   1)
        self.HeadItem.localScale = smlScale -- 头像变小
        self.rowMeshRoundedImage.color = grayColor -- 头像变灰
        CfUtils.SetUISwitchImage(self.Imgbg.gameObject,   1)    -- 头像底图 变灰
        CfUtils.SetUISwitchImage(self.ImgLine.gameObject,   2) -- 虚线 变成 红色

        CfUtils.SetActive(self.TxtNum.gameObject, false)        -- 灰色的 "x3"
        CfUtils.SetActive(self.TxtNumClaimed.gameObject, true)

        CfUtils.SetActive(self.UIFX_BoxGlow.gameObject, false) -- 发光特效: 关闭
        CfUtils.SetActive(self.ImgDrawDown.gameObject, false) -- "领取": 关闭
        CfUtils.SetActive(self.saog.gameObject, false) -- 扫光: 关闭

        CfUtils.StopAnimation(self.controller.gameObject) -- 停止 宝箱跳跃 动画

    elseif self.chestState == ChestState.WaitReceive then
        -- 此宝箱可被领取
        CfUtils.SetUISwitchImage(self.ImgIcon.gameObject,   2)
        self.HeadItem.localScale = normalScale
        self.rowMeshRoundedImage.color = Color.white -- 头像变彩色
        CfUtils.SetUISwitchImage(self.Imgbg.gameObject,   2)    -- 头像底图 亮色
        CfUtils.SetUISwitchImage(self.ImgLine.gameObject,   1) -- 虚线 变成 白色

        CfUtils.SetActive(self.TxtNum.gameObject, true)         -- 亮色的 "x3"
        CfUtils.SetActive(self.TxtNumClaimed.gameObject, false)

        CfUtils.SetActive(self.UIFX_BoxGlow.gameObject, true) -- 发光特效: 开启
        CfUtils.SetActive(self.ImgDrawDown.gameObject, true) -- "领取": 开启
        CfUtils.SetActive(self.saog.gameObject, true) -- 扫光: 开启

        CfUtils.PlayAnimation(self.controller.gameObject, "OverseaGrowUpTasksOverviewDialog_RewardNodeLoop" ) -- 播放 宝箱跳动 动画:

    elseif self.chestState == ChestState.CanNotReceive then
        -- 此宝箱解锁但不可领
        CfUtils.SetUISwitchImage(self.ImgIcon.gameObject,   2)
        self.HeadItem.localScale = normalScale
        self.rowMeshRoundedImage.color = Color.white -- 头像变彩色
        CfUtils.SetUISwitchImage(self.Imgbg.gameObject,   2)    -- 头像底图 亮色
        CfUtils.SetUISwitchImage(self.ImgLine.gameObject,   1) -- 虚线 变成 白色

        CfUtils.SetActive(self.TxtNum.gameObject, true)         -- 亮色的 "x3"
        CfUtils.SetActive(self.TxtNumClaimed.gameObject, false)

        CfUtils.SetActive(self.UIFX_BoxGlow.gameObject, false) -- 发光特效: 关闭
        CfUtils.SetActive(self.ImgDrawDown.gameObject, false) -- "领取": 关闭
        CfUtils.SetActive(self.saog.gameObject, false) -- 扫光: 关闭

        CfUtils.StopAnimation(self.controller.gameObject) -- 停止 宝箱跳跃 动画
    
    elseif self.chestState == ChestState.Locked then 
        -- 此宝箱未解锁
        CfUtils.SetUISwitchImage(self.ImgIcon.gameObject,   3)
        self.HeadItem.localScale = smlScale -- 头像变小
        self.rowMeshRoundedImage.color = Color.white -- 头像变彩色
        CfUtils.SetUISwitchImage(self.Imgbg.gameObject,   2)    -- 头像底图 亮色
        CfUtils.SetUISwitchImage(self.ImgLine.gameObject,   1) -- 虚线 变成 白色

        CfUtils.SetActive(self.TxtNum.gameObject, true)         -- 亮色的 "x3"
        CfUtils.SetActive(self.TxtNumClaimed.gameObject, false)

        CfUtils.SetActive(self.UIFX_BoxGlow.gameObject, false) -- 发光特效: 关闭
        CfUtils.SetActive(self.ImgDrawDown.gameObject, false) -- "领取": 关闭
        CfUtils.SetActive(self.saog.gameObject, false) -- 扫光: 关闭

        CfUtils.StopAnimation(self.controller.gameObject) -- 停止 宝箱跳跃 动画
    end
end



function UITaskGrowUpRewardNode:OnClickButton()
    if self.isInit == false then 
        self:Init_()
    end 

    print( "点击 宝箱" )
    if self.chestState == ChestState.Locked then 
        self:ShowRewardPreview() -- 宝箱奖励预览

    elseif self.chestState == ChestState.CanNotReceive then
        self:ShowRewardPreview() -- 宝箱奖励预览

    elseif self.chestState == ChestState.WaitReceive then
        -- 正式领取宝箱:
        self.secondPanelEnv:CallServer_DrawGrowthBoxRewards()

    elseif self.chestState == ChestState.Finshed then
        self:ShowRewardPreview() -- 宝箱奖励预览
    end        
end


function UITaskGrowUpRewardNode:ShowRewardPreview()
    if self.chestParams and self.chestParams.chestVO and type(self.chestParams.chestVO.rewardDatas)=="table" then 

        GameUtils.ShowCommonTipsBoardRewardPreview(
            self.InfoPivot.transform, -- 坐标
            self.chestParams.chestVO.rewardDatas,  -- 配表数据
            localize('奖励预览'), 
            self.chestState == ChestState.Finshed,  -- 是否已领取过
            true    -- 是否显示箭头
        )
    else 
        printError( "宝箱奖励预览失败" )
    end
end



return UITaskGrowUpRewardNode
