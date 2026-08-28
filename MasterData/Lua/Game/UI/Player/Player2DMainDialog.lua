---
--- Created by zou hanjie
--- DateTime: 2023/11/09 3:01 PM 
---

-- 个人信息界面 2D版 


local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
---@type PlayerComponent
local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
local friendComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FriendComponent)
local GameObject = CS.UnityEngine.GameObject
local Animation = CS.UnityEngine.Animation
local KCookie = CS.Engine.Lib.KCookie
---@type Game.Native.URP.URPCameraController
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
---@type CriWareUtils
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
local GachaponUtils = import('Game.Gachapon.GachaponUtils')
local cs_coroutine = require 'XLua.cs_coroutine'
local NamedAnimancerComponent = CS.Animancer.NamedAnimancerComponent
local ResourceModule = CS.Engine.Modules.ResourceModule
local LuaOutlet = CS.Engine.Modules.LuaOutlet
---@type Engine.Lib.Yielders
local Yielders = CS.Engine.Lib.Yielders
---@type PlayerInfoUtils
local PlayerInfoUtils = import('Game.UI.Player.PlayerInfoUtils')


--- from: Assets/BundleResources/Prefabs/PlayerNew/Player2DMainDialog.prefab > name: Player2DMainDialog
---@class Player2DMainDialog
---@field Env                           	Player2DMainDialog                      
---@field controller                    	Engine.UI.UILuaDialog                   
---@field LeftNode                      	UnityEngine.RectTransform               	@ 0    进出 徽章编辑 模式时, 需要播放动画
---@field BadgeLua                      	Engine.Modules.LuaBehaviour             	@ 1    徽章 脚本
---@field PrincipalLine                 	UnityEngine.RectTransform               	@ 2    
---@field TrainingCenter                	UnityEngine.RectTransform               	@ 3    
---@field Restaurant                    	UnityEngine.RectTransform               	@ 4    
---@field BadgeEditBtn                  	UnityEngine.UI.Button                   	@ 5    玩家-右侧 徽章 edit 按钮
---@field BadgeExitBtn                  	UnityEngine.UI.Button                   	@ 6    玩家-右侧 徽章 exit 按钮
---@field BadgeSaveBtn                  	UnityEngine.UI.Button                   	@ 7    玩家-右侧 徽章 save 按钮
---@field PlayerLayoutBtn               	UnityEngine.RectTransform               	@ 8    玩家-右侧 3按钮组 (查看他人时出现)
---@field BossDrawingNode               	Game.Native.Common.DrawingNode          	@ 9    玩家-右侧 卡牌大图
---@field cardCell                      	UnityEngine.RectTransform               	@ 10   玩家-右侧 4张卡牌 - 卡牌原件, 用来被复制黏贴 
---@field Root                          	UnityEngine.RectTransform               	@ 11   一级界面 root
---@field LeftHeadBtn                   	UnityEngine.UI.Button                   	@ 12   玩家-左侧 头像按钮
---@field ChooseCardsRoot               	UnityEngine.UI.GridLayoutGroup          	@ 13   玩家-右侧 卡牌列表 - 根节点
---@field CardNum                       	UnityEngine.UI.Text                     	@ 14   玩家-右侧 卡牌列表 卡牌数量 "战斗员收集"
---@field BtnRight                      	UnityEngine.UI.Button                   	@ 15   玩家-右侧 切换卡牌大图
---@field BtnLeft                       	UnityEngine.UI.Button                   	@ 16   玩家-右侧 切换卡牌大图
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               	@ 17   玩家-左侧 主角头像
---@field BtnCopyUID                    	UnityEngine.UI.Button                   	@ 18   玩家-左侧 uid 复制按钮
---@field BtnReName                     	UnityEngine.UI.Button                   	@ 19   玩家-左侧 名字 重命名按钮
---@field PlayerName                    	UnityEngine.UI.Text                     	@ 20   玩家-左侧 名字
---@field LvlSlider                     	UnityEngine.UI.Slider                   	@ 21   玩家-左侧 等级 进度条
---@field TxtExpNum                     	UnityEngine.UI.Text                     	@ 22   玩家-左侧 经验值
---@field TxtLvNum                      	UnityEngine.UI.Text                     	@ 23   玩家-左侧 等级
---@field TxtClub                       	UnityEngine.UI.Text                     	@ 24   玩家-左侧 社团 
---@field TxtTime                       	UnityEngine.UI.Text                     	@ 25   玩家-左侧 入职时间
---@field TxtUID                        	UnityEngine.UI.Text                     	@ 26   玩家-左侧 uid
---@field CommonTabToggleUp             	UnityEngine.RectTransform               	@ 27   顶部页签          
---@field BtnMore                       	UnityEngine.UI.Button                   	@ 28   玩家-右侧 未来拓展按钮 (好友) 暂不管
---@field BtnClose                      	UnityEngine.UI.Button                   	@ 29   退出按钮
---@field Right                         	UnityEngine.RectTransform               	@ 30   
---@field BtnSaveEditing                	UnityEngine.UI.Button                   	@ 31   玩家-右侧 主题 save 按钮
---@field FrameLocktxt                  	UnityEngine.RectTransform               	@ 32   玩家-右侧 主题 获取信息介绍区
local Player2DMainDialog = Class("Player2DMainDialog")
 

-- ==========================================

local OverseaTowerUtils = import('Game.UI.FightReady.OverseaTower.OverseaTowerUtils')

---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)

---@type CardComponent
local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)

---@type FriendComponent
local friendComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.FriendComponent)

local Player2DOptionBtns = import('Game.UI.Player.Player2DOptionBtns')

local UIRootCanvas = CS.Engine.UI.UIRootCanvas
local Vector3 = CS.UnityEngine.Vector3
local Button = CS.UnityEngine.UI.Button
local Text = CS.UnityEngine.UI.Text

-- ========================================
local OpenType = {
    Own = 1,
    Other = 2,
}

local TEAM_CARDS = 4



local AnimLeft_Go = "Player2DMainDialog_LeftNode_Go"
--local AnimLeft_ToBadge      = "Player2DMainDialog_LeftNode_Back"

local AnimRight_Right_Entry   = "Player2DMainDialog_Right_Entry"

local Anim_RoleChange = "Player2DMainDialog_RoleChange"




-- ========================================
function Player2DMainDialog:__init()
    self.displayableCards = {} -- cardIdx[]
    self._catAniRandomTime = os.time()
end

function Player2DMainDialog:__delete()
    self.controller = nil
end

function Player2DMainDialog:Awake()

    SetButtonAction(self.BtnClose, Bind(self, self._OnClickBtnClose))
    SetButtonAction(self.BtnMore, Bind(self, self._OnClickBtnMore))
    SetButtonAction(self.BtnReName, Bind(self, self._OnClickBtnReName))
    SetButtonAction(self.BtnCopyUID, Bind(self, self._OnClickBtnCopyUID))
    SetButtonAction(self.BtnLeft, Bind(self, self._OnClickBtnLeft))
    SetButtonAction(self.BtnRight, Bind(self, self._OnClickBtnRight))

    do
        local TxtNum = self.PrincipalLine:Find("TxtNum")
        self.PrincipalLineData =  KTool.GetComponent(TxtNum.gameObject, typeof(Text))
    end

    do
        local TxtNum = self.TrainingCenter:Find("TxtNum")
        self.TrainingCenterData =  KTool.GetComponent(TxtNum.gameObject, typeof(Text))
        self.TrainingCenterNodeTF =  self.TrainingCenter:Find("TxtNone")
    end

    do
        local TxtNum = self.Restaurant:Find("TxtNum")
        self.RestaurantData =  KTool.GetComponent(TxtNum.gameObject, typeof(Text))
    end
end


function Player2DMainDialog:OnFocus(focus)
    if focus then
        --printError("koko - OnFocus " .. tostring(focus) )
        self:RefreshTeamView() 
    end
end




function Player2DMainDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        print(" ~~~~~~~~~~~ 进入 个人信息界面 ~~~~~~~~~~~~~~ ")
        local argument = self.controller.Argument
        if not isNull(argument.parameters) then
            self.openType = argument.parameters.openType
            self.playerDt = argument.parameters.data
            self.exParameter = argument.parameters.exParameter
        end
        KCookie.Set("PersonalInfoDisplayIsMyself",  self:IsShowMySelf())
        KCookie.Set("PersonalInfoDisplayDt",        self:GetPlayerData())
        KCookie.Set("Player2DIsNeedRefreshCardList",  true )

        self.displayedCardIdx = 1 -- 1-based, [1,4]
        
        ---
        self.FrameLuaTF = self.Root:Find("Container/FrameLua")
        self.ImgBgTF = self.Root:Find("Container/ImgBg")
        assert( isNotNull(self.FrameLuaTF) and isNotNull(self.ImgBgTF) )

        self.RightRoleNode  = self.Right:Find("RightRoleNode")
        self.RightBadgeNode = self.Right:Find("RightBadgeNode")
        self.RightFrameNode = self.Right:Find("RightFrameNode")
        assert( isNotNull(self.RightRoleNode) and isNotNull(self.RightBadgeNode) and isNotNull(self.RightFrameNode) )

        self.LeftPlayerInformation = self.LeftNode:Find("Root/PlayerInformation")
        self.LeftBadge = self.LeftNode:Find("Root/Badge")
        self.LeftFrame = self.LeftNode:Find("Root/Frame")
        assert( isNotNull(self.LeftPlayerInformation) and isNotNull(self.LeftBadge) and isNotNull(self.LeftFrame) )

        ---
        self.EventShowMainDialog  = Events.AddListener(Constants.EventNames.Player2DShowMainDialog, function(isOpen_)
            self:ShowMainDialog(isOpen_)
        end)

        self.EventRefreshPlayerData  = Events.AddListener(Constants.EventNames.Player2DRefreshPlayerData, function()
            KCookie.Set("PersonalInfoDisplayDt",        self:GetPlayerData())
        end)

        self.EventsHeadDateExpired = Events.AddListener(Constants.EventNames.PlayerHeadDateExpired, function(event)
            local goodsId  = checkInt(event.goodsId)
            local headKind = checkInt(event.headKind)
            local playerData = self:GetPlayerData()
            -- 查看他人信息时不更新
            if not self:IsShowMySelf() then
                return
            end
            -- 清已拥有的缓存
            playerData.playerOtherInfo[tostring(headKind)][tostring(goodsId)] = nil
            if headKind == Constants.PlayerAvatarItemType.Avatar then
                if goodsId == checkInt(playerData.playerAvatar) then
                    -- 如果是正在使用中的头像、头像框，则恢复默认
                    playerData.playerAvatar = playerComponent.playerDojo.playerAvatar
                    self:RefreshPlayerHead()
                end
            elseif headKind == Constants.PlayerAvatarItemType.AvatarFrame then
                if goodsId == checkInt(playerData.playerAvatarFrame) then
                    -- 如果是正在使用中的头像、头像框，则恢复默认
                    playerData.playerAvatarFrame = playerComponent.playerDojo.playerAvatarFrame
                    self:RefreshPlayerHead()
                end
            elseif headKind == Constants.PlayerAvatarItemType.Paster then
                playerData.medals[tostring(goodsId)] = nil
                self.badgeLuaEnv:RemoveBadge(goodsId)
            end
        end)

        self.EventRefreshLeftPanel  = Events.AddListener(Constants.EventNames.Player2DMainRefreshLeftPanel, Bind(self, self.DrawLeftPanelPlayerData))
        self.EventRefreshTile       = Events.AddListener(Constants.EventNames.Player2DMainRefreshTitle,     Bind(self, self.UpdateTitleNew))
       
        self.player2DOptionBtns = Player2DOptionBtns.New( self, self.PlayerLayoutBtn )

        
        self:RefreshView()
        self:_InitForBadge()
        self:_InitForFrame()
        self:RefreshShareBtn()
        
        -- 透视
        self.cachedIsOrthographic = GameUtils.IsUICameraOrthographic()
        --printError("-- 入口 正交 " .. tostring(self.cachedIsOrthographic) )
        CfUtils.SetUICameraProjection(false, 26) -- 设为正交
    end))
    return coWait
end




function Player2DMainDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        print(" ~~~~~~~~~~~ 离开 个人信息界面 ~~~~~~~~~~~~~~ ")

        if self.EventShowMainDialog then
            Events.RemoveListener(Constants.EventNames.Player2DShowMainDialog, self.EventShowMainDialog)
            self.EventShowMainDialog = nil
        end

        if self.EventRefreshPlayerData then
            Events.RemoveListener(Constants.EventNames.Player2DRefreshPlayerData, self.EventRefreshPlayerData)
            self.EventRefreshPlayerData = nil
        end

        if self.EventsHeadDateExpired then
            Events.RemoveListener(Constants.EventNames.PlayerHeadDateExpired, self.EventsHeadDateExpired)
            self.EventsHeadDateExpired = nil
        end

        if self.EventRefreshLeftPanel then
            Events.RemoveListener(Constants.EventNames.Player2DMainRefreshLeftPanel, self.EventRefreshLeftPanel)
            self.EventRefreshLeftPanel = nil
        end

        if self.EventRefreshTile then
            Events.RemoveListener(Constants.EventNames.Player2DMainRefreshTitle, self.EventRefreshTile)
            self.EventRefreshTile = nil
        end

        -- 恢复透视
        CfUtils.SetUICameraProjection( self.cachedIsOrthographic )
        --printError("-- 出口 正交 " .. tostring(GameUtils.IsUICameraOrthographic()) )
        ---
        self.controller = nil --删除lua层引⽤用到的c#对象,否则不不会产⽣生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end


function Player2DMainDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:InitView()
        if not self:GetExParameter().panelMode then
            Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false) -- 主场景 3d物体 隐藏
            Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false }) -- 主场景 角色 失活
        end
        -- 延迟到 OnShow() 中, 确保一定能覆盖 UI Localized 组件里翻译表的信息
        do
            local title = self.PrincipalLine:Find("TxtTitle")
            CfUtils.FillCfText( title.gameObject, localize("主线进度") )
        end
        do
            local title = self.TrainingCenter:Find("TxtTitle")
            CfUtils.FillCfText( title.gameObject, localize("训练中枢") )
        end
        do
            local title = self.Restaurant:Find("TxtTitle")
            CfUtils.FillCfText( title.gameObject, localize("餐厅") )
        end
    end))
    return coWait
end


function Player2DMainDialog:OnHide()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        --printError("OnHide")
    end))
    return coWait
end




-- ======================================= 玩家 / 徽章 页签切换 =============================================

function Player2DMainDialog:InitView()
    self.toggleData = {
        {
            text = localize("个人信息"),
            func = function()
                local lastType = self:GetDisplayType() -- 可能值为 0
                self:SetDisplayType(Constants.Player2DMainTabType.PlayerInfo, true)
                self:OnClickBtn_badgeExitBtn()
                self:ShowOrHideBtns( Constants.Player2DMainTabType.PlayerInfo )

                --- 切换页面
                KTool.SetActive( self.RightRoleNode,            true )
                KTool.SetActive( self.RightBadgeNode,           false )
                KTool.SetActive( self.RightFrameNode,           false )
                CfUtils.PlayAnimation(self.Right, AnimRight_Right_Entry)--淡入

                if lastType == Constants.Player2DMainTabType.Frame then 
                    self:SwitchLeftPanel( Constants.Player2DMainTabType.PlayerInfo )
                    if isNotNull(self.frameLuaEnv) then 
                        self.frameLuaEnv:RefreshAll()
                    end
                end 
                
            end,
            type = Constants.Player2DMainTabType.PlayerInfo,
        },
        {
            text = localize("徽章"),
            func = function()
                local lastType = self:GetDisplayType() -- 可能值为 0
                self:SetDisplayType(Constants.Player2DMainTabType.Badge, true)
                self:ShowOrHideBtns( Constants.Player2DMainTabType.Badge )
                
                --- 切换页面
                KTool.SetActive( self.RightRoleNode,            false )
                KTool.SetActive( self.RightBadgeNode,           true )
                KTool.SetActive( self.RightFrameNode,           false )
                CfUtils.PlayAnimation(self.Right, AnimRight_Right_Entry)--淡入

                if lastType == Constants.Player2DMainTabType.Frame then 
                    self:SwitchLeftPanel( Constants.Player2DMainTabType.PlayerInfo )
                    if isNotNull(self.frameLuaEnv) then 
                        self.frameLuaEnv:RefreshAll()
                    end
                end
            end,
            type = Constants.Player2DMainTabType.Badge,
        },
    }

    if self:IsShowMySelf() then 
        table.insert( self.toggleData, 
        {
            text = localize("更换主题"),
            func = function()
                local lastType = self:GetDisplayType() -- 可能值为 0
                ----- 
                self:SetDisplayType(Constants.Player2DMainTabType.Frame, true)
                --self:OnClickBtn_badgeExitBtn()
                self:ShowOrHideBtns( Constants.Player2DMainTabType.Frame )

                --- 切换 右侧页面:
                KTool.SetActive( self.RightRoleNode,            false )
                KTool.SetActive( self.RightBadgeNode,           false )
                KTool.SetActive( self.RightFrameNode,           true )
                CfUtils.PlayAnimation(self.Right, AnimRight_Right_Entry)--淡入

                self:SwitchLeftPanel( Constants.Player2DMainTabType.Frame )
            end,
            type = Constants.Player2DMainTabType.Frame,
        })
    end


    ---@type CommonTabToggleUp
    local env = CfUtils.GetLuaScr(self.CommonTabToggleUp, Constants.UILuaTablePath.ComUpToggle)
    env:FillToggles(self.toggleData)

    local initType = Constants.Player2DMainTabType.PlayerInfo

    self:SetDisplayType(initType)
    self:ShowOrHideBtns( initType )


    self:UpdateTitleNew()
end


-- 如果有了 新徽章, 徽章页签 上会出现红色的 "New"
-- 目前, "个人信息" 页签上不会出现 "New"
function Player2DMainDialog:UpdateTitleNew()
    if self:IsShowMySelf() ~= true then
        return
    end
    ---
    local type = Constants.Player2DMainTabType.Badge

    ---@type CommonTabToggleUp
    local env = CfUtils.GetLuaScr(self.CommonTabToggleUp, Constants.UILuaTablePath.ComUpToggle)
    for index, dt in ipairs(self.toggleData or {}) do
        if dt.type == checkInt(type) then
            local node = env:GetTabNodeByIndex(index)
            if node then
                local newImg = node.transform:Find("ImgNew")

                local needShowNew = PlayerInfoUtils.CheckAvatarsHasNew(Constants.PlayerAvatarItemType.Paster)
                KTool.SetActive(newImg, needShowNew )
                self:Refresh_BadgeEditBtnNew(needShowNew)
            end
        end
    end
end



function Player2DMainDialog:SetDisplayType(type, isShowTip)
    self.displayType_ = checkInt(type)
end


function Player2DMainDialog:GetDisplayType()
    return checkInt(self.displayType_)
end


function Player2DMainDialog:ShowOrHideBtns( type_ )
    if type_ == Constants.Player2DMainTabType.PlayerInfo then 
        KTool.SetActive(self.PlayerLayoutBtn.gameObject, true)
    elseif type_ == Constants.Player2DMainTabType.Badge then
        KTool.SetActive(self.PlayerLayoutBtn.gameObject, false)
    else 
        KTool.SetActive(self.PlayerLayoutBtn.gameObject, false)
    end
end



-- ======================================== 绘制整个主界面 =============================================
function Player2DMainDialog:RefreshView()  

    -- 绘制 玩家/他人 信息:
    self:DrawLeftPanelPlayerData()

    KTool.SetActive( self.BtnReName.gameObject, self:IsShowMySelf() )
    --KTool.SetActive( self.BtnReName.gameObject, false ) -- todo 此按钮暂未被启用
    --KTool.SetActive( self.BtnMore.gameObject, self:IsShowMySelf() ~= true )
    KTool.SetActive( self.BtnMore.gameObject, false ) -- todo 此按钮暂未被启用

    -- 右下角一组按钮的刷新
    self.player2DOptionBtns:Refresh()
    -- 绘制 4张 卡牌
    self:RefreshTeamView()
end


-- ======================================== 玩家/他人 的信息 =============================================
function Player2DMainDialog:DrawLeftPanelPlayerData()    
    local playerData = self:GetPlayerData()


    --printError("playerData: " .. table.dump( playerData ) ) -- !!! debug
    -- playerData.playerThemeId 


    CfUtils.FillCfText( self.TxtUID, playerData.playerId )
    CfUtils.FillCfText( self.TxtTime, playerData.playerCreateTime )
    CfUtils.FillCfText( self.PlayerName, playerData.playerName )

    -- 玩家 等级:
    CfUtils.FillCfText( self.TxtLvNum, playerData.level )

    -- 玩家  经验值, 经验值进度条:
    if self:IsShowMySelf() then
        local playerExp = CardConfMgr:GetInstance():GetPlayerExpByLevelId(checkInt( playerData.level ))
        local nextExp   = CardConfMgr:GetInstance():GetPlayerExpByLevelId(checkInt( playerData.level ) + 1)
        local curExp    = tonumber(playerData.mainExp) - tonumber(playerExp.totalExp)
        CfUtils.FillText(self.TxtExpNum, string.format("%s/%s", curExp, nextExp.exp))
        self.LvlSlider.value = curExp / checkInt(nextExp.exp)
    end

    -- 主线进度:
    do 
        --local curQuestId = self:IsShowMySelf() and QuestConfMgr:GetInstance():GetCurNeedQuestId() or playerData.newQuestId
        local curQuestId = 0 
        if self:IsShowMySelf() then 
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.QuestComponent)
            curQuestId = comp:GetCurQuestId()
        else 
            curQuestId = playerData.newQuestId
        end 
        print( "koko 主线进度: id: " .. tostring(curQuestId) .. ",  type:" .. type(curQuestId) )
        local vo = QuestConfMgr:GetInstance():GetQuestVoById(curQuestId)
        if vo then
            CfUtils.FillText(self.PrincipalLineData, vo.label)
        end
    end

    -- 训练中枢:
    do  

        local isTowerUnPlay = false -- 爬塔 是否还没开始玩
        if self:IsShowMySelf() then 
            ---@type TowerQuestComponent
            local towerQuestComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TowerQuestComponent)
            local id = towerQuestComponent:GetCurrentQuestId(Constants.TowerType.Main)
            if checkNumber(id) <= 0 then
                isTowerUnPlay = true
            end
        else 
            isTowerUnPlay = (checkInt(playerData.overseaClimbingTowerId) == 0)
        end 

        ---
        if isTowerUnPlay then 
            KTool.SetActive( self.TrainingCenterNodeTF, true ) -- 灰色 "未开启"
            KTool.SetActive( self.TrainingCenterData, false )
            --CfUtils.FillText(self.TrainingCenterNodeTF, localize("未开启") )
            --CfUtils.SetUISwitchText(self.TrainingCenterData, 2)
        else 

            -- 爬塔 已经通关的 ID, 比如 610003, 
            -- 数据可能为 0, 表示此人没爬过塔
            local towerId = self:IsShowMySelf() and OverseaTowerUtils.GetPassedQuestId(Constants.TowerType.Main) or playerData.overseaClimbingTowerId 
            local towerVO = OverseaTowerUtils.GetTowerQuestVo(towerId) -- !!! 可能为 nil
            local towerLvl = isNull(towerVO) and 0 or towerVO.storey
            -- printError("towerId = " .. tostring(towerId) )
            -- printError("towerVO = " .. tostring(towerVO) )
            -- printError("towerLvl = " .. tostring(towerLvl) )

            KTool.SetActive( self.TrainingCenterNodeTF, false )
            KTool.SetActive( self.TrainingCenterData, true )    -- 黑色字

            CfUtils.FillText(self.TrainingCenterData, localize("_levelNum_层", {_levelNum_ = towerLvl }) )
            --CfUtils.SetUISwitchText(self.TrainingCenterData, 1)
        end         
    end

    -- 餐厅级数:
    do 
        local maidCoffeePlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.MaidCoffeePlayerComponent)
        local cafeLevel = self:IsShowMySelf() and maidCoffeePlayerComponent:GetCafeLevel() or playerData.cafeLevel
        CfUtils.FillText(self.RestaurantData, localize("_levelNum_级", {_levelNum_ = cafeLevel}) )
    end


    -- 绘制头像:
    self:RefreshPlayerHead()
    if self:IsShowMySelf() then
        SetButtonAction(self.LeftHeadBtn, Bind(self, self._OnClickBtnLeftHeadBtn))
    end


    -- 社团名字:
    do 
        local clubName = self:IsShowMySelf() and ClubUtils.GetClubComp():GetHomeDojo().name or playerData.clubName
        clubName = (clubName == "" or isNull(clubName)) and "-" or clubName
        CfUtils.FillText(self.TxtClub, string.format("[%s]", clubName ))
    end 
    

    -- "战斗员收集": 卡牌数量 
    do 
        local roleTypeDojo = illustratedHandbookComp:GetHandbookCollectDojo(Constants.HandbookCollectionType.ROLE)
        local cardHasCount = playerData.playerCardsNum
        if self:IsShowMySelf() then
            cardHasCount = cardComp:GetCardOwnCount()
        end
        local cardCount = table.count(roleTypeDojo.totalMap)
        CfUtils.FillText(self.CardNum, string.format("%s/%s", cardHasCount, cardCount))
    end

end


function Player2DMainDialog:RefreshPlayerHead()
    local playerData = self:GetPlayerData()

    ---@type CommonPlayerHeadNode
    local headEnv    = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    local headImgNew = self.CommonPlayerHeadNode.parent:Find("ImgNew")
    KTool.SetActive(headImgNew, self:IsShowMySelf() and 
        (PlayerInfoUtils.CheckAvatarsHasNew(Constants.PlayerAvatarItemType.Avatar) or PlayerInfoUtils.CheckAvatarsHasNew(Constants.PlayerAvatarItemType.AvatarFrame)) 
    )
    if headEnv then
        headEnv:FreshAvatarFrame( playerData.playerAvatar, playerData.playerAvatarFrame)
    end
end
 

-- ======================================== 分享按钮 =============================================
function Player2DMainDialog:RefreshShareBtn() 
    local BtnShare = self.Root:Find("Container/BtnShare")
    if isNotNull(BtnShare) then 
        if self:IsShowMySelf() and (checkInt(KCookie.Get("Player2DBadgeMode")) ~= Constants.Player2DBadgeType.Edit) then 
            KTool.SetActive( BtnShare.gameObject, true )
            GameUtils.InstallShareButton(BtnShare, Constants.ShareType.PLAYER_NEW, 'Prefabs/Share/GachaponResultShareShowDialog.prefab')
        else
            KTool.SetActive( BtnShare.gameObject, false )
        end 
    end 
end


-- ======================================== 4张 卡牌列表 =============================================
function Player2DMainDialog:RefreshTeamView()
    if checkBool(KCookie.Get("Player2DIsNeedRefreshCardList")) == false then 
        return
    end 
    KCookie.Set("Player2DIsNeedRefreshCardList",  false )

    local parent = self.ChooseCardsRoot.transform
    KTool.DestroyGameObjectChildren(self.ChooseCardsRoot.gameObject, false)

    self.displayedCardIdx = 1
    self.displayableCards = {}
    
    for index = 1, TEAM_CARDS do
        local go = CfUtils.InstantiateGo(self.cardCell.gameObject, self.ChooseCardsRoot)
        go.name = "CardNode" .. index
        KTool.SetActive(go, true)
        local cardId = self:GetCurrentCardId(index)
        local isCardExist = checkInt(cardId) > 0 -- 本槽是否要放置卡牌
        if isCardExist then 
            table.insert( self.displayableCards, cardId )
        end 
        self:RefreshCardHeadNode(go.transform, cardId, index)
    end
    -- 绘制卡牌大图:
    self:DrawBigCard()
end



function Player2DMainDialog:DrawBigCard() 
    -- check idx: 
    local displayableCardsLen = table.count(self.displayableCards)
    if self.displayedCardIdx < 1 then 
        self.displayedCardIdx = 1
    end
    if self.displayedCardIdx > displayableCardsLen then 
        self.displayedCardIdx = displayableCardsLen
    end
    ---
    local cardId = self.displayableCards[self.displayedCardIdx]
    if checkInt(cardId) == 0 then
        return
    end
    local cardDojo = self:IsShowMySelf() and cardComp:GetCardById(cardId) or self:GetCurrentCardDt(self.displayedCardIdx)
    ---@type CardVo
    local cardVo = CardConfMgr:GetInstance():GetCardBySkinRefId(cardDojo.cardSkin)
    --self.BossDrawingNode:Execute( cardVo.defaultSkin )
    self.BossDrawingNode:Execute( cardDojo.cardSkin ) -- 展示 当前时装
    print( "大图: default = " .. tostring(cardVo.defaultSkin) .. "; current = " .. tostring(cardDojo.cardSkin) )
end



function Player2DMainDialog:RefreshCardHeadNode(node, cardId, index)
    local isCardExist = checkInt(cardId) > 0 -- 本槽是否要放置卡牌

    local parent = node.transform
    local emptyBtnTF = parent:Find("NoRoleNode/ButtonAdd") -- 空卡 加号 按钮
    local card = parent:Find("card")
    ---@type CardHeadNode
    local cardHeadNodeEnv = CfUtils.GetLuaScr(card, Constants.UILuaTablePath.CardHeadNode)

    local cardBtnGO = (isCardExist and card.gameObject or emptyBtnTF.gameObject)

    assert( parent and card and cardHeadNodeEnv and emptyBtnTF and card and emptyBtnTF )

    KTool.SetActive( emptyBtnTF.gameObject, (isCardExist == false) and self:IsShowMySelf() )
    KTool.SetActive( card.gameObject,       isCardExist == true )    

    if self:IsShowMySelf() then 
        SetButtonAction(cardBtnGO, function()
            -- 显示 卡牌选择界面:
            self:ShowMainDialog( false )
            UIModule.OpenDialog({ id = Constants.UITypeIds.Player2DMemberChooseDialog })
        end)
    end 

    if isCardExist then 
        local cardDojo = self:IsShowMySelf() and cardComp:GetCardById(cardId) or self:GetCurrentCardDt(index)
        cardHeadNodeEnv:FreshNode( cardDojo, true,  13, true )  -- CardHeadNode
    end 
end



function Player2DMainDialog:GetCurrentCardId(index)
    local revealTeamDt = self:GetPlayerData().revealTeam[index]
    if self:IsShowMySelf() then
        return checkInt(revealTeamDt)
    else
        return checkInt(checkTable(revealTeamDt).id)
    end
end


function Player2DMainDialog:ShowMainDialog( isOpen )
    KTool.SetActive( self.Root, isOpen == true )
end


function Player2DMainDialog:GetCurrentCardDt(index)
    if self:IsShowMySelf() then
        return cardComp:GetCardById(self:GetCurrentCardId(index))
    else
        return self:GetPlayerData().revealTeam[index]
    end
end

------------------------------------------------- handler
function Player2DMainDialog:_OnClickBtnClose()
    print("koko - 按下 BtnClose")
    UIModule.BackDialog()
end


function Player2DMainDialog:_OnClickBtnMore()
    print("koko - 按下 BtnMore")
end


function Player2DMainDialog:_OnClickBtnReName()
    print("koko - 按下 BtnReName")
    local uiCanvas = UIRootCanvas.main.canvas
    local reNameDialogLoader = ResourceModule.LoadBundleSync("Prefabs/PlayerNew/Player2DReNameDialog.prefab", nil, true)
    self.reNameDialog = reNameDialogLoader:Instantiate( true, uiCanvas.transform )
    reNameDialogLoader:Release()
end


function Player2DMainDialog:_OnClickBtnCopyUID()
    print("koko - 按下 BtnCopyUID")
    CS.Engine.Http.DeviceID.CopyToClipboard(self:GetPlayerData().playerId)
    GameUtils.Toast(localize("复制成功")) -- 飘字
end


function Player2DMainDialog:_OnClickBtnLeft()
    print("koko - 按下 Btn Left")
    CfUtils.PlayAnimation(self.Root, Anim_RoleChange)
    self.displayedCardIdx = self.displayedCardIdx - 1 
    if self.displayedCardIdx < 1 then 
        self.displayedCardIdx = table.count(self.displayableCards)
    end 
    self:DrawBigCard()
end


function Player2DMainDialog:_OnClickBtnRight()
    print("koko - 按下 Btn Right")
    CfUtils.PlayAnimation(self.Root, Anim_RoleChange)
    self.displayedCardIdx = self.displayedCardIdx + 1 
    if self.displayedCardIdx > table.count(self.displayableCards) then 
        self.displayedCardIdx = 1
    end 
    self:DrawBigCard()
end


function Player2DMainDialog:_OnClickBtnLeftHeadBtn()
    print("koko - 按下 Btn LeftHeadBtn")
    UIModule.OpenDialog(
        { 
            id = Constants.UITypeIds.Player2DHeadChooseDialog, 
            parameters = 
            {
                --themeId = self.themeDojo.id
            }
        },
        {
            {id = Constants.UITypeIds.Player2DMainDialog}
        }
    )
end


-- 得到 玩家/他人 数据:
function Player2DMainDialog:GetPlayerData()
    if self:IsShowMySelf() then
        return self:_GetMySelfData()
    else
        return checkTable(self.playerDt)    -- GameUtils.ShowPlayerInfo() 装配了传进来的
    end
end
function Player2DMainDialog:_GetMySelfData()
    return {
        playerId            = playerComponent.playerDojo.playerId, --UID
        playerCreateTime    = playerComponent.playerDojo.playerCreateTime, --入职时间
        playerName          = playerComponent.playerDojo.playerName, --玩家角色名
        playerAvatar        = playerComponent.playerDojo.playerAvatar,
        playerAvatarFrame   = playerComponent.playerDojo.playerAvatarFrame,
        level               = playerComponent.playerDojo.level, --玩家等级
        mainExp             = playerComponent.playerDojo.mainExp, --玩家经验    -- !! 他人模式时 此值为 nil
        birthday            = playerComponent.playerDojo.birthday, --个人信息生日
        revealCard          = playerComponent.playerDojo.revealCard, --个人信息首页卡牌Id
        revealTeam          = playerComponent.playerDojo.revealTeam, --列表卡牌的服务器Id
        medal               = playerComponent.playerDojo.medal, --徽章位置信息 -- 旧 
        medals              = playerComponent.playerDojo.medals, --徽章位置信息 -- 新 {}
        playerOtherInfo     = playerComponent.playerDojo.playerOtherInfo, --玩家其他信息（1头像，2头像框，3徽章） key类型 value list
        ratingId            = cardComponent:GetRatingId(),
        playerThemeId       = playerComponent.playerDojo.playerPanel,
        gender              = playerComponent.playerDojo.gender -- 性别 int, 女0男1
    }
end


function Player2DMainDialog:IsShowMySelf()
    return checkInt(self.openType) == OpenType.Own
end

function Player2DMainDialog:GetExParameter()
    return checkTable(self.exParameter)
end

-- -- 本界面 是否从 好友聊天系统而来
-- function Player2DMainDialog:IsFromFriendChat()
--     return isNotNull(self.exParameter) and self.exParameter.chatEnter == true
-- end


function Player2DMainDialog:GetBadgeShowMap()
    local playerDara = self:GetPlayerData()
    if type(playerDara.medals) ~= "table" then 
        printError("koko - 数据异常, 没能拿到 madels 数据")
        return {}
    end 

    local ret = {}
    -- 将旧数据 转换为通用格式的
    for k,v in pairs(playerDara.medals) do 
        if isNull(v) or next(v) == nil or isNull(v.pos)
        then 
            ret[k] = { pos = {0.0,0.0} }
        else 
            ret[k] = v
        end 
    end 
    return ret
end


-- ======================================= 徽章 页签内容 =============================================

function Player2DMainDialog:_InitForBadge()
    KCookie.Set("Player2DBadgeMode", Constants.Player2DBadgeType.Show )

    self.BadgeShowRootTF = self.RightBadgeNode:Find("BadgeShow")
    self.baseBadgeMovableTF = self.RightBadgeNode:Find("Cell")
    KTool.SetActive( self.baseBadgeMovableTF.gameObject, false ) -- must hide

    ---@type Player2DBadgePanel
    self.badgeLuaEnv = CfUtils.GetLuaScr(self.BadgeLua, "Game.UI.Player.Player2DBadgePanel")
    if isNotNull(self.badgeLuaEnv) then 
        self.badgeLuaEnv:Init( self )
    else
        printError("koko - 异常, 没绑定 BadgeLua")
    end 

    ---
    if self:IsShowMySelf() then
        KTool.SetActive( self.BadgeEditBtn.gameObject, true )
        KTool.SetActive( self.BadgeExitBtn.gameObject, false )
        KTool.SetActive( self.BadgeSaveBtn.gameObject, false )
        SetButtonAction(self.BadgeEditBtn.gameObject, Bind(self, self._OnClickBtn_BadgeEditBtn))
    else 
        KTool.SetActive( self.BadgeEditBtn.gameObject, false )
        KTool.SetActive( self.BadgeExitBtn.gameObject, false )
        KTool.SetActive( self.BadgeSaveBtn.gameObject, false )
    end
end



function Player2DMainDialog:_OnClickBtn_BadgeEditBtn()
    print( "badge edit" )
    KCookie.Set("Player2DBadgeMode", Constants.Player2DBadgeType.Edit )

    self:SwitchLeftPanel( Constants.Player2DMainTabType.Badge )

    KTool.SetActive( self.BadgeEditBtn.gameObject, false )
    KTool.SetActive( self.BadgeExitBtn.gameObject, true )
    KTool.SetActive( self.BadgeSaveBtn.gameObject, true )

    SetButtonAction(self.BadgeSaveBtn.gameObject, Bind(self, self._OnClickBtn_badgeSaveBtn))
    SetButtonAction(self.BadgeExitBtn.gameObject, Bind(self, self.OnClickBtn_badgeExitBtn))

    self:RefreshShareBtn()

    if isNotNull( self.badgeLuaEnv ) then 
        self.badgeLuaEnv:WhenClickBtn_Edit()
    end 
end


function Player2DMainDialog:_OnClickBtn_badgeSaveBtn()
    print( "badge save" )
    if isNotNull( self.badgeLuaEnv ) then 
        self.badgeLuaEnv:WhenClickBtn_Save()
    end 

end


function Player2DMainDialog:OnClickBtn_badgeExitBtn()
    print( "badge exit" )

    if (checkInt(KCookie.Get("Player2DBadgeMode")) == Constants.Player2DBadgeType.Edit) then 
        self:SwitchLeftPanel( Constants.Player2DMainTabType.PlayerInfo )
    end 

    KCookie.Set("Player2DBadgeMode", Constants.Player2DBadgeType.Show )

    KTool.SetActive( self.BadgeEditBtn.gameObject, self:IsShowMySelf() )
    KTool.SetActive( self.BadgeExitBtn.gameObject, false )
    KTool.SetActive( self.BadgeSaveBtn.gameObject, false )

    self:RefreshShareBtn()

    if isNotNull( self.badgeLuaEnv ) then 
        self.badgeLuaEnv:WhenClickBtn_Exit()
    end 
end


-- 徽章 编辑按钮 也需显示 "New"
function Player2DMainDialog:Refresh_BadgeEditBtnNew( isActive_ )
    local newTF = self.BadgeEditBtn.transform:Find("ImgNew")
    KTool.SetActive( newTF.gameObject, isActive_ )
end


-- ======================================= 主题 页签内容 =============================================

function Player2DMainDialog:_InitForFrame()
    --KCookie.Set("Player2DBadgeMode", Constants.Player2DBadgeType.Show )

    -- self.BadgeShowRootTF = self.RightBadgeNode:Find("BadgeShow")
    -- self.baseBadgeMovableTF = self.RightBadgeNode:Find("Cell")
    -- KTool.SetActive( self.baseBadgeMovableTF.gameObject, false ) -- must hide

    self.frameLuaEnv = CfUtils.GetLuaScr(self.FrameLuaTF, "Game.UI.Player.Player2DFramePanel")
    if isNotNull(self.frameLuaEnv) then 
        self.frameLuaEnv:Init( self, self.ImgBgTF )
    else
        printError("koko - 异常, 没绑定 FrameLua")
    end 

    SetButtonAction(self.BtnSaveEditing.gameObject, Bind(self, self._OnClickBtn_SaveFrame))

    -- ---@type Player2DBadgePanel
    -- self.badgeLuaEnv = CfUtils.GetLuaScr(self.BadgeLua, "Game.UI.Player.Player2DBadgePanel")
    -- if isNotNull(self.badgeLuaEnv) then 
    --     self.badgeLuaEnv:Init( self )
    -- else
    --     printError("koko - 异常, 没绑定 BadgeLua")
    -- end 

    -- ---
    -- if self:IsShowMySelf() then
    --     KTool.SetActive( self.BadgeEditBtn.gameObject, true )
    --     KTool.SetActive( self.BadgeExitBtn.gameObject, false )
    --     KTool.SetActive( self.BadgeSaveBtn.gameObject, false )
    --     SetButtonAction(self.BadgeEditBtn.gameObject, Bind(self, self._OnClickBtn_BadgeEditBtn))
    -- else 
    --     KTool.SetActive( self.BadgeEditBtn.gameObject, false )
    --     KTool.SetActive( self.BadgeExitBtn.gameObject, false )
    --     KTool.SetActive( self.BadgeSaveBtn.gameObject, false )
    -- end

end


function Player2DMainDialog:_OnClickBtn_SaveFrame()
    print( "frame save" )
    if isNotNull( self.frameLuaEnv ) then 
        self.frameLuaEnv:WhenClickBtn_Save()
    end 
end



-- ==========================================================

function Player2DMainDialog:SwitchLeftPanel( type )
    if type == Constants.Player2DMainTabType.PlayerInfo then 
        KTool.SetActive( self.LeftPlayerInformation.gameObject, true )
        KTool.SetActive( self.LeftBadge.gameObject, false )
        KTool.SetActive( self.LeftFrame.gameObject, false )
        CfUtils.PlayAnimation(self.LeftNode, AnimLeft_Go )

    elseif type == Constants.Player2DMainTabType.Badge then 
        KTool.SetActive( self.LeftPlayerInformation.gameObject, false )
        KTool.SetActive( self.LeftBadge.gameObject, true )
        KTool.SetActive( self.LeftFrame.gameObject, false )
        CfUtils.PlayAnimation(self.LeftNode, AnimLeft_Go )

    elseif type == Constants.Player2DMainTabType.Frame then 
        KTool.SetActive( self.LeftPlayerInformation.gameObject, false )
        KTool.SetActive( self.LeftBadge.gameObject, false )
        KTool.SetActive( self.LeftFrame.gameObject, true )
        CfUtils.PlayAnimation(self.LeftNode, AnimLeft_Go )
    else
        printError("参数异常: " .. tostring(type))
    end
end



return Player2DMainDialog