---
--- Created by zou hanjie
--- DateTime: 2023/11/09 5:03 PM 
---

local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local PlayerInfoUtils = import('Game.UI.Player.PlayerInfoUtils')
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local Player2DHeadChangeTab = import('Game.UI.Player.Player2DHeadChangeTab')

local GridCellPath = 'Game.UI.Player.Player2DHeadChangeHeadNode'

---@type PlayerComponent
local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)

local BehaviourAction = CS.Engine.Lib.BehaviourAction

local Player2DChangeSexCountDown = import('Game.UI.Player.Player2DChangeSexCountDown')


--- from: Assets/BundleResources/Prefabs/PlayerNew/Player2DHeadChooseDialog.prefab > name: Player2DHeadChooseDialog
---@class Player2DHeadChangeDialog
---@field Env                           	Player2DHeadChangeDialog                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ContentTxt                    	UnityEngine.RectTransform               @ 描述-正文
---@field TitleTxt                      	UnityEngine.RectTransform               @ 描述-标题
---@field ShowNode                      	UnityEngine.RectTransform               @ "展示中" 标记
---@field TxtName                       	UnityEngine.UI.Text                     @ 头像/头像框 名字
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               @ 头像节点
---@field ListView                      	Engine.UI.AutoFixSizeListView           
---@field CancelBtn                     	Game.Native.Common.FontStyleButton      @ 编辑 - 取消按钮       -- 暂时无用
---@field SaveBtn                       	Game.Native.Common.FontStyleButton      @ 编辑 - 确认按钮
---@field Root                          	UnityEngine.RectTransform               @ 
---@field CommonTabToggleUp             	Engine.Modules.LuaBehaviour             @ 头像/头像框 切换栏
local Player2DHeadChangeDialog = Class("Player2DHeadChangeDialog")
---------------------------------------------


---------------------------------------------
function Player2DHeadChangeDialog:__init()
    ---@type Player2DHeadChangeTab
    self.avatarTab = nil
    ---@type Player2DHeadChangeTab
    self.avatarFrameTab = nil
    ---@type Player2DHeadChangeTab
    self.genderTab = nil
    ---@type Player2DHeadChangeTab
    self.currentTab = nil
    ---@type Constants.PlayerAvatarItemType
    self.currentTabType = nil
end


function Player2DHeadChangeDialog:__delete()
    self.avatarTab      = nil
    self.avatarFrameTab = nil
    self.genderTab      = nil
    self.currentTab     = nil
    self.currentTabType = nil
end


function Player2DHeadChangeDialog:Awake()
    SetButtonAction(self.SaveBtn, Bind(self, self._OnClickBtn_Save))
end


function Player2DHeadChangeDialog:OnFocus(focus)
end


function Player2DHeadChangeDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        xTry(function()

            -- 绑定 Update() 函数:
            local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
            if behaviourAction then
                behaviourAction.UpdateAction = function(behaviourAction)
                    self:Update()
                end
            end
            -- ==============================

            -- 倒计时节点:
            self.countDownTF = self.SaveBtn.transform.parent:Find("ImgBgTime")
            self.countDownTxtTF = self.countDownTF:Find("TxtTime")
            assert( self.countDownTF and self.countDownTxtTF )
            self.countDownEnv = Player2DChangeSexCountDown.New( self, self.countDownTF, self.countDownTxtTF )

            -- ==============================
            self.avatarTab      = Player2DHeadChangeTab.New( self, Constants.PlayerAvatarItemType.Avatar   )
            self.avatarFrameTab = Player2DHeadChangeTab.New( self, Constants.PlayerAvatarItemType.AvatarFrame  )
            self.genderTab      = Player2DHeadChangeTab.New( self, Constants.PlayerAvatarItemType.Gender   )

            self.EventsHeadDateExpired = Events.AddListener(Constants.EventNames.PlayerHeadDateExpired, function(event)
                local goodsId  = checkInt(event.goodsId)
                local headKind = checkInt(event.headKind)
                if headKind == Constants.PlayerAvatarItemType.Avatar then
                    -- 清已拥有的缓存
                    self.avatarTab:ClearItemIdIsOwned(goodsId)
                    if goodsId == self.avatarTab:GetLastSelectedOrSavedId() then
                        -- 如果是正在使用中的头像、头像框，则恢复默认
                        self.avatarTab:SetLastSelectedOrSavedId(playerComponent.playerDojo.playerAvatar)
                        self.avatarTab:FindShowIdx()
                        self.avatarTab:SetSelectedIndex(self.avatarTab:GetShowIndex(), nil, nil)
                    end
                elseif headKind == Constants.PlayerAvatarItemType.AvatarFrame then
                    -- 清已拥有的缓存
                    self.avatarFrameTab:ClearItemIdIsOwned(goodsId)
                    if goodsId == self.avatarFrameTab:GetLastSelectedOrSavedId() then
                        -- 如果是正在使用中的头像、头像框，则恢复默认
                        self.avatarFrameTab:SetLastSelectedOrSavedId(playerComponent.playerDojo.playerAvatarFrame)
                        self.avatarFrameTab:FindShowIdx()
                        self.avatarFrameTab:SetSelectedIndex(self.avatarFrameTab:GetShowIndex(), nil, nil)
                    end
                elseif headKind == Constants.PlayerAvatarItemType.Gender then
                    printError("性别: 暂未处理...")

                else 
                    printError("undo...")
                end
                if self.currentTabType == headKind then
                    self:_RefreshListView()
                    self:UpdateLeftView()
                end
            end)

            self.EventPlayerInfoChange = Events.AddListener(Constants.EventNames.PlayerInfoChange, function()
                if self:IsShowMySelf() then
                    self.avatarTab:SetLastSelectedOrSavedId(playerComponent.playerDojo.playerAvatar)
                    self.avatarFrameTab:SetLastSelectedOrSavedId(playerComponent.playerDojo.playerAvatarFrame)
                    --self.genderTab:SetLastSelectedOrSavedId(playerComponent.playerDojo.)
                end
            end)


            self.Player2DSwitchChangeSexCD = Events.AddListener(Constants.EventNames.Player2DSwitchChangeSexCD, function(isEnterCD_)
                if self.currentTabType == Constants.PlayerAvatarItemType.Gender then 
                    self:UpdateLeftView()
                end
            end)

        end)
    end))
    return coWait
end

function Player2DHeadChangeDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        if self.EventsHeadDateExpired then
            Events.RemoveListener(Constants.EventNames.PlayerHeadDateExpired, self.EventsHeadDateExpired)
            self.EventsHeadDateExpired = nil
        end

        if self.EventPlayerInfoChange then
            Events.RemoveListener(Constants.EventNames.PlayerInfoChange, self.EventPlayerInfoChange)
            self.EventPlayerInfoChange = nil
        end

        if self.Player2DSwitchChangeSexCD then
            Events.RemoveListener(Constants.EventNames.PlayerInfoChange, self.Player2DSwitchChangeSexCD)
            self.Player2DSwitchChangeSexCD = nil
        end

        if isNotNull(self.countDownEnv) then 
            self.countDownEnv:Delete()
        end

        self.controller = nil --删除lua层引⽤用到的c#对象,否则不不会产⽣生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要 

    end))
    return coWait
end

function Player2DHeadChangeDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self:InitView()

    end))
    return coWait
end

-------------------------------------------------------------------- update


function Player2DHeadChangeDialog:Update()

    if self.currentTabType == Constants.PlayerAvatarItemType.Gender then 
        self.countDownEnv:SelfUpdate()
    else 
        self.countDownEnv:Show(false)
    end
end


-------------------------------------------------------------------- get/set

function Player2DHeadChangeDialog:IsShowMySelf()
    return checkBool(KCookie.Get("PersonalInfoDisplayIsMyself"))
end


function Player2DHeadChangeDialog:GetPlayerData()
    return checkTable(KCookie.Get("PersonalInfoDisplayDt"))
end


----------------------------------------------------------------------- handler

function Player2DHeadChangeDialog:_OnClickBtn_Save()

    if self.currentTabType == Constants.PlayerAvatarItemType.Gender then

        local isShow = self.currentTab:GetShowItemId() == self.currentTab:GetSelectedItemId()
        if isShow then 
            GameUtils.Toast(localize("正在展示"))
            return
        end 
        ------
        -- -- !!! debug:
        -- self.countDownEnv:OnSetNewTime()

        if self.countDownEnv.isNeedCountDown == true then 
            GameUtils.Toast(localize("冷却中"))
            return
        end

        ------
        local genderVal = PlayerInfoUtils.GenderId2Type(self.genderTab:GetLastSelectedOrSavedId()) -- int
        print("存储性别: " .. tostring(genderVal))

        GameUtils.Request("OverseaPlayer/changeSex", {gender = genderVal}, function(request, response)
            if checkInt(response.errCode) == 0 then
                self.currentTab:SetShowIndex( self.currentTab:GetSelectedIndex() )
                
                playerComponent.playerDojo.gender = genderVal
                self.countDownEnv:OnSetNewTime()
                
                PlayerInfoUtils.ChangePlayerInfo()
                GameUtils.Toast(localize("设置成功"))
            end
        end)
        return
    end

    -- ==================================
    local tgtAvatarId          = self.avatarTab:GetLastSelectedOrSavedId()
    local tgtAvatarFrameId     = self.avatarFrameTab:GetLastSelectedOrSavedId()

    if self.avatarTab:CheckItemIdIsOwned(tgtAvatarId) == false then 
        GameUtils.Toast(localize("选择的头像未解锁"))
        return
    end 
    if self.avatarFrameTab:CheckItemIdIsOwned(tgtAvatarFrameId) == false then 
        GameUtils.Toast(localize("选择的头像框未解锁"))
        return
    end 

    GameUtils.Request(Interfaces.Player2DSetAvatarAndFrame, {avatar = tgtAvatarId, avatarFrame = tgtAvatarFrameId}, function(request, response)
        if checkInt(response.errCode) == 0 then
            -- print("save: tgtAvatarId = " .. tostring(tgtAvatarId) .. "; tgtAvatarFrameId = " .. tostring(tgtAvatarFrameId) .. 
            --     "; currentSlect = " .. tostring(self.currentTab:GetSelectedIndex())
            -- )
            self.currentTab:SetShowIndex( self.currentTab:GetSelectedIndex() )

            playerComponent.playerDojo.playerAvatar = tgtAvatarId
            playerComponent.playerDojo.playerAvatarFrame = tgtAvatarFrameId

            PlayerInfoUtils.ChangePlayerInfo()
            GameUtils.Toast(localize("设置成功"))
        end
    end)
end


----------------------------------------------------------------------- public

function Player2DHeadChangeDialog:InitView()
    self.avatarTab:InitData()
    self.avatarFrameTab:InitData()
    self.genderTab:InitData()

    self.toggleData = {
        {
            text = localize("头像"),
            func = function()
                self:SetCurrentTab( self.avatarTab, Constants.PlayerAvatarItemType.Avatar )
                self:_RefreshListView()
            end,
            type = Constants.PlayerAvatarItemType.Avatar
        },
        {
            text = localize("头像框"),
            func = function()
                self:SetCurrentTab( self.avatarFrameTab, Constants.PlayerAvatarItemType.AvatarFrame )
                self:_RefreshListView()
            end,
            type = Constants.PlayerAvatarItemType.AvatarFrame
        },
        {
            text = localize("形象"), -- 性别
            func = function()
                self:SetCurrentTab( self.genderTab, Constants.PlayerAvatarItemType.Gender )
                self:_RefreshListView()
            end,
            type = Constants.PlayerAvatarItemType.Gender
        },
    }

    ---@type CommonTabToggleUp
    local env = CfUtils.GetLuaScr(self.CommonTabToggleUp, Constants.UILuaTablePath.ComUpToggle)
    env:FillToggles(self.toggleData)

    self:SetCurrentTab( self.avatarTab, Constants.PlayerAvatarItemType.Avatar )
    self:_RefreshListView()


    self.avatarTab:UpdateTitleNew()
    self.avatarFrameTab:UpdateTitleNew()
    self.genderTab:UpdateTitleNew()
end

-----------------------------------------------------------------
function Player2DHeadChangeDialog:_RefreshListView()
    local num = self.currentTab:GetItemIdListNum()
    if not self.ListView.mLoopListView.IsListViewInit then
        self.ListView:InitListView(num, Bind(self, self.OnGetGridItem))
    else
        GameUtils.ReloadData(self.ListView, num )
    end
end


function Player2DHeadChangeDialog:OnGetGridItem(cell, index)
    if index < 0 then
        return nil
    end

    local luaIndex = index + 1
    local itemId   = self.currentTab:GetItemIdByIndex(luaIndex)
    ---@type Player2DHeadChangeHeadNode
    local cellEnv = CfUtils.GetLuaScr(cell, GridCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData({
            itemId    = itemId ,
            itemType  = self.currentTab:GetDisplayType(),
            isCurrent = self.currentTab:GetShowItemId() == itemId,
            isSelect  = self.currentTab:GetSelectedItemId() == itemId,
            isLocked  = not self.currentTab:CheckItemIdIsOwned(itemId),
            isMySelf  = self:IsShowMySelf(),
        })
        cellEnv:SetClickHeadCB(function(clickIndex)
            self.currentTab:SetSelectedIndex(clickIndex, nil, nil)
            print("点击 --- id " .. tostring( self.currentTab:GetSelectedItemId() .. "; clickIndex = " .. tostring(clickIndex) .. "; type = " .. type(clickIndex) ) )
        end)
    end
    return cell
end

-----------------------------------------------------------------
---@param newTab_ Player2DHeadChangeTab
---@param playerAvatarItemType_ Constants.PlayerAvatarItemType
function Player2DHeadChangeDialog:SetCurrentTab(newTab_, playerAvatarItemType_)
    self.currentTabType = playerAvatarItemType_
    self.currentTab = newTab_
    self.currentTab:WhenSwitchToThisTap()
end


---@param playerAvatarItemType_ Constants.PlayerAvatarItemType | nil
function Player2DHeadChangeDialog:UpdateLeftView( playerAvatarItemType_ )
    local isShow = self.currentTab:GetShowItemId() == self.currentTab:GetSelectedItemId()

    if isShow then
        self.SaveBtn:ResetFontStyle("B18", localize("展示中"))
    elseif self.currentTab:CheckItemIdIsOwned(self.currentTab:GetSelectedItemId()) then

        if self.currentTabType == Constants.PlayerAvatarItemType.Gender and self.countDownEnv.isNeedCountDown == true then 
            self.SaveBtn:ResetFontStyle("B18", localize("冷却中"))
        else 
            self.SaveBtn:ResetFontStyle("B6", localize("确认更换"))
        end 
    else
        self.SaveBtn:ResetFontStyle("B18", localize("未解锁"))
    end
    ---
    local itemId = self.currentTab:GetSelectedItemId()
    ---
    self:RefreshTipsView(itemId)
    ---
    ---@type CommonPlayerHeadNode
    local headEnv = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    if headEnv then
        if playerAvatarItemType_ == Constants.PlayerAvatarItemType.Gender then 
            -- 性别特殊展示:
            local gender = self.genderTab:GetLastSelectedOrSavedId() -- string id
            headEnv:FreshHeadIcon(gender, true) -- 不用显示 头像框
        else
            local avatar = self.avatarTab:GetLastSelectedOrSavedId() 
            local frame = self.avatarFrameTab:GetLastSelectedOrSavedId() 
            headEnv:FreshAvatarFrame(avatar, frame)
        end
    end
end



function Player2DHeadChangeDialog:RefreshTipsView(itemId)
    --printError("RefreshTipsView")
    local itemVo   = GoodsConfMgr:GetInstance():GetGoodsVoById(itemId)
    if not itemVo or next(itemVo) == nil then 
        return 
    end

    --printError("itemVo.name = " .. tostring(itemVo.name))

    local isShow   = PlayerInfoUtils.IsCurrentAvatar(itemId)
    CfUtils.FillText(self.TxtName, itemVo.name)
    CfUtils.FillText(self.TitleTxt, itemVo.description)
    CfUtils.FillText(self.ContentTxt, itemVo.desc)
    KTool.SetActive( self.ShowNode.gameObject, isShow )
end



return Player2DHeadChangeDialog