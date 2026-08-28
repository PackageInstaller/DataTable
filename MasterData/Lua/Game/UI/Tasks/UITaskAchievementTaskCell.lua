-------------------------------------------------------------------------------
-- 任务界面 - 成就面板 - 任务列表项
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-02-18 15:50:09
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaTasksDialog.prefab
---@class UITaskAchievementTaskCell
---@field Env                           	UITaskAchievementTaskCell               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgIcon                       	UnityEngine.RectTransform               @ 任务图标节点
---@field RootNode                      	UnityEngine.RectTransform               @ 根位置节点
---@field Particle                      	UnityEngine.RectTransform               @ 完成状态粒子节点
---@field ImgDecorate2                  	UnityEngine.RectTransform               @ 装饰状态节点2
---@field ImgDecorate                   	UnityEngine.RectTransform               @ 装饰状态节点1
---@field AnimRoot                      	UnityEngine.RectTransform               @ 动画根节点
---@field Fill                          	UnityEngine.RectTransform               @ 任务进度条图片
---@field BtnReceive                    	UnityEngine.RectTransform               @ 领取奖励按钮
---@field ProgressNode                  	UnityEngine.RectTransform               @ 进行中状态节点
---@field HasDrawnNode                  	UnityEngine.RectTransform               @ 已领取状态节点
---@field CommonGoodsList               	UnityEngine.RectTransform               @ 通用奖励控件
---@field Slider                        	UnityEngine.UI.Slider                   @ 任务进度条
---@field TitleTxt                      	UnityEngine.RectTransform               @ 任务进度文本
---@field NameTxt                       	UnityEngine.RectTransform               @ 任务描述文本
local UITaskAchievementTaskCell = Class("UITaskAchievementTaskCell")


function UITaskAchievementTaskCell:__init()
    self.isInitComplete_ = false
    ---@type CommonGoodsList
    self.commonGoodsListEnv_ = nil
end


function UITaskAchievementTaskCell:__delete()
    self.isInitComplete_     = nil
    self.commonGoodsListEnv_ = nil
end


function UITaskAchievementTaskCell:Awake()
    self.commonGoodsListEnv_ = CfUtils.GetLuaScr(self.CommonGoodsList, 'Game.Behaviours.CommonGoodsListLight')
end


function UITaskAchievementTaskCell:Start()
    SetButtonAction(self.BtnReceive, Bind(self, self.OnClickFunctionButtonHandler_))

    self.isInitComplete_ = true
    self:UpdateAnimRoot_()
    if self.initCompleteCallback_ then
        self.initCompleteCallback_()
    end
end


function UITaskAchievementTaskCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UITaskAchievementTaskCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UITaskAchievementTaskCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UITaskAchievementTaskCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
---@param callback fun(cb:fun():void):void
function UITaskAchievementTaskCell:SetCellData(cellData, callback)
    self.cellData_ = checkTable(cellData)
    self.initCompleteCallback_ = callback
    self:RefreshData_()
end


---@return fun(luaIndex:number):void
function UITaskAchievementTaskCell:GetClickCB()
    return self.clickCallback_
end
---@param callback fun(luaIndex:number):void
function UITaskAchievementTaskCell:SetClickCB(callback)
    self.clickCallback_ = callback
end


-------------------------------------------------
-- public

function UITaskAchievementTaskCell:PlayCompleteAnim()
    CfUtils.PlayAnimation(self.RootNode, "OverseaTasksDialogCellCompleteGo_Active")
end


function UITaskAchievementTaskCell:ResetCompleteAnim()
    -- self.BtnReceive:Find("AnimRoot").localScale = Vector3(1, 1, 1)
    -- CfUtils.SetCanvasGroupAlpha(self.BtnReceive:Find("AnimRoot"), 1)
    CfUtils.PlayAnimation(self.RootNode, "OverseaTasksDialogCellCompleteGo_Idle")
end


-------------------------------------------------
-- private

function UITaskAchievementTaskCell:RefreshData_()
    local cellData = self:GetCellData()

    ---@type AchievementTaskVo
    local taskVo     = checkTable(cellData.taskVo)
    local taskData   = checkTable(cellData.taskData)
    local isDrawn    = cellData.isDrawn == true
    local targetNum  = checkInt(taskVo.taskContenNum)
    local currentNum = math.max(isDrawn and targetNum or 0, checkInt(taskData.progress))
    local isCanDraw  = not isDrawn and checkInt(taskData.status) == 1

    -- update infos
    CfUtils.FillImage(self.ImgIcon, taskVo.taskIcon)
    CfUtils.FillText(self.NameTxt, tostring(taskVo.desc))
    CfUtils.FillText(self.TitleTxt, string.format("<size=30><color=#545454>%d</color></size>/%d", currentNum, targetNum))
    self.Slider.value = currentNum / targetNum

    -- update rewards
    local rewardList = parse_rewards(taskVo.rewardId, taskVo.rewardNum)
    table.insert(rewardList, {
        goodsId  = Constants.Currency.AchievementPoint,
        goodsNum = checkInt(taskVo.point)
    })
    if not isNull(self.commonGoodsListEnv_) then
        self.commonGoodsListEnv_:FreshBaseUI(rewardList)
    end

    -- update status
    CfUtils.SetActive(self.Particle, false)
    CfUtils.SetActive(self.BtnReceive, isCanDraw)
    CfUtils.SetActive(self.HasDrawnNode, isDrawn)
    CfUtils.SetActive(self.ProgressNode, not isDrawn)

    if self.isInitComplete_ then
        self:UpdateAnimRoot_()
        if self.initCompleteCallback_ then
            self.initCompleteCallback_()
        end
    end
end


function UITaskAchievementTaskCell:UpdateAnimRoot_()
    local cellData  = self:GetCellData()
    local taskData  = checkTable(cellData.taskData)
    local isDrawn   = cellData.isDrawn == true
    local isCanDraw = not isDrawn and checkInt(taskData.status) == 1
    CfUtils.PlayAnimation(self.AnimRoot, isCanDraw and "OverseaTasksDialogCellCompleteGo" or "OverseaTasksDialogCellGo")
end


-------------------------------------------------
-- handler

function UITaskAchievementTaskCell:OnClickFunctionButtonHandler_()
    if self:GetClickCB() then
        self:GetClickCB()(self:GetLuaIndex())
    end
end


return UITaskAchievementTaskCell
