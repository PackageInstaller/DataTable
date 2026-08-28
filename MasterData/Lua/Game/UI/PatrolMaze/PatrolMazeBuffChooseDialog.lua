-------------------------------------------------------------------------------
-- 夜寻迷宫 - 选择圣物弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-13 12:33:33
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()
local goodsConfMgr    = GoodsConfMgr:GetInstance()

local BuffNodePath = 'Game.UI.PatrolMaze.PatrolMazeBuffChooseBuffNode'


--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Patrol/BuffChooseDialog130201.prefab > name: BuffChooseDialog130201
---@class PatrolMazeBuffChooseDialog
---@field Env                           	PatrolMazeBuffChooseDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BuffNode                      	UnityEngine.RectTransform               	@ 0    buff子节点
---@field BuffNodeRoot                  	UnityEngine.RectTransform               	@ 1    buff根节点
---@field BgImg                         	UnityEngine.RectTransform               	@ 2    背景图
---@field BgClickNode                   	UnityEngine.RectTransform               	@ 3    背景点击区域
---@field GetRewardNode                 	UnityEngine.RectTransform               	@ 4    获得奖励节点
---@field ChooseBuffTitle               	UnityEngine.RectTransform               	@ 5    选择圣物标题
---@field RefreshAllBtn                 	UnityEngine.RectTransform               	@ 6    刷新 按钮
---@field RefreshTimesTxt               	UnityEngine.RectTransform               	@ 7    刷新 次数
---@field RefreshNoneTimes              	UnityEngine.RectTransform               	@ 8    刷新 无次数
---@field RefreshDanned                 	UnityEngine.RectTransform               	@ 9    刷新 禁用
---@field RefreshDoubleConsume          	UnityEngine.RectTransform               	@ 10   刷新 双倍消耗
---@field ConsumeNode                   	UnityEngine.RectTransform               	@ 11   消耗-节点
---@field ConsumeGoodsImg               	UnityEngine.RectTransform               	@ 12   消耗 道具图标
---@field ConsumeGoodsNum               	UnityEngine.RectTransform               	@ 13   消耗 道具数量
local PatrolMazeBuffChooseDialog = Class('PatrolMazeBuffChooseDialog')


function PatrolMazeBuffChooseDialog:__init()
    ---@type PatrolMazeAreaDojo @ 当前所在区域dojo
    self.mapAreaDojo_ = nil

    ---@type table @ 选择buff数据
    self.chooseRelicsMap_ = {}

    ---@type integer[] @ 显示的buffId列表
    self.showBuffIdList_ = {}

    ---@type PatrolMazeBuffChooseBuffNode[] @ 显示的buff节点列表
    self.showBuffNodeList_ = {}

    ---@type boolean @ 是否可以接受操作
    self.isControllable_ = true

    ---@type UnityEngine.Coroutine
    self.showRewardAnimCo_ = nil

    ---@type fun():void
    self.closeCallback_ = nil
end


function PatrolMazeBuffChooseDialog:__delete()
    self.mapAreaDojo_      = nil
    self.chooseRelicsMap_  = nil
    self.showBuffIdList_   = nil
    self.showBuffNodeList_ = nil
    self.isControllable_   = nil
    self.showRewardAnimCo_ = nil
    self.closeCallback_    = nil
end


function PatrolMazeBuffChooseDialog:Awake()
    SetButtonAction(self.BgClickNode, Bind(self, self.OnClickBgCloseAreaHandler_))
    SetButtonAction(self.RefreshAllBtn, Bind(self, self.OnClickRefreshButtonHandler_))
end


function PatrolMazeBuffChooseDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams    = self.controller.Argument.parameters or {}
        local rewardRelicId = checkInt(initParams.rewardRelicId)
        local rewardCurseId = checkInt(initParams.rewardCurseId)
        local chooseRelics  = checkTable(initParams.chooseRelics)
        local mapAreaId     = checkInt(initParams.mapAreaId)
        self.mapAreaDojo_   = patrolMazeComp:GetHomeDojo():GetAreaDojo(mapAreaId)
        self.closeCallback_ = initParams.closeCb

        -- 获得圣物
        if rewardRelicId > 0 then
            self.showBuffIdList_ = {rewardRelicId}
            self:ShowRewardRelicView_()
            
        -- 获得诅咒
        elseif rewardCurseId > 0 then
            self.showBuffIdList_ = {rewardCurseId}
            self:ShowRewardCurseView_()

        -- 选择圣物
        elseif next(chooseRelics) ~= nil then
            self.chooseRelicsMap_ = chooseRelics
            self:ShowChooseRelicList_()
        end
    end)
end


function PatrolMazeBuffChooseDialog:OnFinalize()
    return CoWaitDo(function()
        if self.showRewardAnimCo_ then
            CoStop(self.showRewardAnimCo_)
            self.showRewardAnimCo_ = nil
        end
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolMazeBuffChooseDialog:GetBuffSelectIndex()
    return checkInt(self.buffSelectIndex_)
end
function PatrolMazeBuffChooseDialog:SetBuffSelectIndex(selectIndex)
    local oldSelectIndex  = self:GetBuffSelectIndex()
    local newSelectIndex  = checkInt(selectIndex)
    self.buffSelectIndex_ = newSelectIndex
    self:SwitchBuffSelectIndex_(oldSelectIndex, newSelectIndex)
end


--- 是否 刷新禁用
---@return boolean
function PatrolMazeBuffChooseDialog:IsRefreshBanned()
    return self.mapAreaDojo_:HasMazeCurseByEffect(PatrolMazeUtils.CurseEffectType.RELIC_BANNED)
end


--- 是否 刷新消耗翻倍
---@return boolean
function PatrolMazeBuffChooseDialog:IsRefreshConsumeUp()
    return self.mapAreaDojo_:HasMazeCurseByEffect(PatrolMazeUtils.CurseEffectType.RELIC_CONSUME_UP)
end


-------------------------------------------------
-- public

function PatrolMazeBuffChooseDialog:Close()
    if self.closeCallback_ then
        self.closeCallback_()
    end
    CfUtils.DialogBack()
end


-------------------------------------------------
-- private

--- 展示 获得圣物表现
function PatrolMazeBuffChooseDialog:ShowRewardRelicView_()
    -- update view
    CfUtils.SetActive(self.GetRewardNode, true)
    CfUtils.SetActive(self.RefreshAllBtn, false)
    CfUtils.SetActive(self.ChooseBuffTitle, false)
    self:UpdateShowBuffList_(true)
    -- show anim
    self.showRewardAnimCo_ = CoStart(function()
        for luaIndex, buffNode in ipairs(self.showBuffNodeList_) do
            buffNode:PlayRewardShowAnim()
        end
        CoYield(0.5)
        self.showRewardAnimCo_ = nil
    end)
end


--- 展示 获得诅咒表现
function PatrolMazeBuffChooseDialog:ShowRewardCurseView_()
    -- update view
    CfUtils.SetActive(self.GetRewardNode, true)
    CfUtils.SetActive(self.RefreshAllBtn, false)
    CfUtils.SetActive(self.ChooseBuffTitle, false)
    self:UpdateShowBuffList_(false)
    -- show anim
    self.showRewardAnimCo_ = CoStart(function()
        for luaIndex, buffNode in ipairs(self.showBuffNodeList_) do
            buffNode:PlayRewardShowAnim()
        end
        CoYield(0.5)
        self.showRewardAnimCo_ = nil
    end)
end


--- 展示 选择buff列表
function PatrolMazeBuffChooseDialog:ShowChooseRelicList_()
    local goodIconPath = GoodsConfMgr:GetInstance():GetPhotoPathById(PatrolMazeUtils.GetCurrencyId())
    CfUtils.FillImage(self.ConsumeGoodsImg, goodIconPath)

    local consumeNum = PatrolMazeUtils.GetParamValue(PatrolMazeUtils.ParamsId.BUFF_REFRESH_CONSUME)
    if self:IsRefreshConsumeUp() then
        consumeNum = consumeNum * 2
    end
    CfUtils.FillText(self.ConsumeGoodsNum, tostring(consumeNum))
    CfUtils.SetUISwitchText(self.ConsumeGoodsNum, self.mapAreaDojo_.mazePoint >= consumeNum and 1 or 2)

    CfUtils.SetActive(self.GetRewardNode, false)
    CfUtils.SetActive(self.RefreshAllBtn, true)
    CfUtils.SetActive(self.ChooseBuffTitle, true)
    CfUtils.SetActive(self.ConsumeNode, not self:IsRefreshBanned())
    CfUtils.SetActive(self.RefreshAllBtn:Find("Desc"), not self:IsRefreshBanned())
    CfUtils.SetActive(self.RefreshDanned, self:IsRefreshBanned())
    CfUtils.SetActive(self.RefreshDoubleConsume, self:IsRefreshConsumeUp())

    self:UpdateChooseRefreshInfo_()
    self:UpdateChooseRelicList_()
end


function PatrolMazeBuffChooseDialog:UpdateChooseRefreshInfo_()
    local refreshLeftTimes = checkInt(self.chooseRelicsMap_.refreshLeftTimes)
    local refreshAllTimes  = checkInt(self.chooseRelicsMap_.refreshAllTimes)
    CfUtils.FillText(self.RefreshTimesTxt, string.fmt('%1/%2', refreshLeftTimes, refreshAllTimes))
    CfUtils.SetActive(self.RefreshNoneTimes, refreshLeftTimes <= 0)
end


function PatrolMazeBuffChooseDialog:UpdateChooseRelicList_()
    -- clear select
    self:SetBuffSelectIndex(0)
    -- init buffs
    self.showBuffIdList_ = self.chooseRelicsMap_.relicList
    self:UpdateShowBuffList_(true)
    -- init cells
    for luaIndex, buffNode in ipairs(self.showBuffNodeList_) do
        buffNode:SetBuffIndex(luaIndex)
        buffNode:SetClickNodeCb(Bind(self, self.OnClickBuffNodeFrameHandler_))
        buffNode:SetSelectNodeCb(Bind(self, self.OnClickBuffNodeSelectButtonHandler_))
    end
end


--- 刷新 展示buff列表
---@param isRelic boolean @ 是否为圣物
function PatrolMazeBuffChooseDialog:UpdateShowBuffList_(isRelic)
    self.showBuffNodeList_ = {}

    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.BuffNodeRoot, self.BuffNode, #self.showBuffIdList_, function(luaIndex, childNode)
        childNode.name = 'BuffNode'..luaIndex

        ---@type PatrolMazeBuffChooseBuffNode
        local buffNodeEnv = CfUtils.GetLuaScr(childNode, BuffNodePath)
        buffNodeEnv:SetBuffIndex(0) -- reset
        buffNodeEnv:SetRelicBuff(isRelic)
        buffNodeEnv:SetMapAreaDojo(self.mapAreaDojo_)
        buffNodeEnv:SetShowBuffId(self.showBuffIdList_[luaIndex])

        self.showBuffNodeList_[luaIndex] = buffNodeEnv
    end)
end


--- 更新 buff节点选中位置
---@param oldSelectIndex integer
---@param newSelectIndex integer
function PatrolMazeBuffChooseDialog:SwitchBuffSelectIndex_(oldSelectIndex, newSelectIndex)
    local oldSelectBuffNode = self.showBuffNodeList_[oldSelectIndex]
    local newSelectBuffNode = self.showBuffNodeList_[newSelectIndex]
    if oldSelectBuffNode then
        oldSelectBuffNode:UpdateSelectState(false)
    end
    if newSelectBuffNode then
        newSelectBuffNode:UpdateSelectState(true)
    end
end


-------------------------------------------------
-- handler

function PatrolMazeBuffChooseDialog:OnClickBgCloseAreaHandler_()
    if not self.isControllable_ then return end

    if #self.showBuffIdList_ > 1 then

        if self:GetBuffSelectIndex() == 0 then
            GameUtils.Toast(localize('请选择一个效果'))
            return
        end

        return
    end

    -- 等待表现结束
    if self.showRewardAnimCo_ then
        return
    end

    -- 是否还有下一轮选择
    if self.chooseRelicsMap_ ~= nil and checkInt(self.chooseRelicsMap_.chooseLeftTimes) > 0 then
        -- 展示 选择buff列表
        self:ShowChooseRelicList_()
    else
        self:Close()
    end
end


function PatrolMazeBuffChooseDialog:OnClickBuffNodeFrameHandler_(clickIndex)
    if not self.isControllable_ then return end
    if checkInt(clickIndex) == 0 then return end
    self:SetBuffSelectIndex(clickIndex)
end


function PatrolMazeBuffChooseDialog:OnClickBuffNodeSelectButtonHandler_(clickIndex)
    if not self.isControllable_ then return end
    if checkInt(clickIndex) == 0 then return end

    local cliclRelicId = checkInt(self.showBuffIdList_[clickIndex])
    patrolMazeComp:MoveMazeByQuestRelic(self.mapAreaDojo_.areaId, cliclRelicId, function(nextBuffList)
        -- 锁定操作控制
        self.isControllable_ = false

        -- 扣除选择次数
        self.chooseRelicsMap_.chooseLeftTimes = self.chooseRelicsMap_.chooseLeftTimes - 1

        if #nextBuffList > 0 then
            self.chooseRelicsMap_.relicList = nextBuffList
        end

        -- 播放退场动画
        local exitAnimTime = 0
        for luaIndex, buffNode in ipairs(self.showBuffNodeList_) do
            local isSelect = luaIndex == self:GetBuffSelectIndex()
            local animTime = buffNode:PlaySelectExitAnim(isSelect)
            exitAnimTime   = math.max(exitAnimTime, animTime)
        end
    
        -- 播放获得动画
        self.showRewardAnimCo_ = CoStart(function()
            CoYield(exitAnimTime)
            self.isControllable_ = true
            self.showBuffIdList_ = {cliclRelicId}
            self:ShowRewardRelicView_()
        end)
    end)
end


function PatrolMazeBuffChooseDialog:OnClickRefreshButtonHandler_()
    if self:IsRefreshBanned() then
        GameUtils.Toast(localize('受到诅咒影响，处于封印状态'))
        return
    end
    
    local refreshLeftTimes = checkInt(self.chooseRelicsMap_.refreshLeftTimes)
    if refreshLeftTimes <= 0 then
        GameUtils.Toast(localize('刷新次数已用光'))
        return
    end

    local consumeNum = PatrolMazeUtils.GetParamValue(PatrolMazeUtils.ParamsId.BUFF_REFRESH_CONSUME)
    if self:IsRefreshConsumeUp() then
        consumeNum = consumeNum * 2
    end

    local pointGoodsVo = goodsConfMgr:GetGoodsVoById(PatrolMazeUtils.GetCurrencyId())
    local consumeList  = { {goodsId = PatrolMazeUtils.GetCurrencyId(), num = string.fmt('x%1', consumeNum)} }
    GameUtils.SecondConfirm(localize('是否消耗以下道具刷新圣物？'), function()
        -- check enough
        if self.mapAreaDojo_.mazePoint >= consumeNum then
            local requestData = {areaId = self.mapAreaDojo_.areaId}
            GameUtils.Request(Interfaces.OverseaMazeRefreshRelic, requestData, function(request, response)
                if checkInt(response.errCode) == 0 then
                    local responseData = checkTable(response.data)

                    -- 扣除：点数消耗
                    self.mapAreaDojo_:AddMazePoint(-consumeNum)

                    -- 刷新：消耗刷新次数
                    self.chooseRelicsMap_.refreshLeftTimes = refreshLeftTimes - 1
                    self:UpdateChooseRefreshInfo_()

                    -- 刷新：圣物选择列表
                    self.chooseRelicsMap_.relicList = responseData.relicList
                    self:UpdateChooseRelicList_()
                end
            end) 
        else
            GameUtils.Toast(localize('_name_不足', {_name_ = tostring(pointGoodsVo.name)}))
        end
    end, nil, nil, 6, consumeList, nil, self:IsRefreshConsumeUp() and localize('诅咒效果：消耗双倍道具刷新圣物') or '')
end


return PatrolMazeBuffChooseDialog
