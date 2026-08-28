---
--- Created by zou hanjie
--- DateTime: 2019-08-30 17:42
---
--[[
		个人信息界面 2D版:  绘制信息提示 tips 小窗口
--]]

------------ import ------------
local ContentSizeFitter = CS.UnityEngine.UI.ContentSizeFitter
---@type CardConfMgr
local cardConfMgr      = CardConfMgr:GetInstance()
------------ import ------------

------------ define ------------
local KTool = CS.Engine.Lib.KTool
local _ContentSizeFitter = typeof(ContentSizeFitter)
local CanvasGroup = CS.UnityEngine.CanvasGroup

------------ define ------------

--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')


--- from: Assets/BundleResources/Prefabs/PlayerNew/Player2DTipPopup.prefab > name: Player2DTipPopup
---@class Player2DBadgeTipPopup
---@field Env                           	Player2DBadgeTipPopup                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field timeTitle                     	UnityEngine.RectTransform               @ "获得时间"
---@field Icon                          	Engine.UI.RawImageAlterable             @ 徽章图像
---@field TextTimeNum                   	UnityEngine.UI.Text                     @ 获取时间
---@field Bg                            	UnityEngine.RectTransform               @ 基类要用
---@field BigTitle                      	UnityEngine.UI.Text                     @ 大标题: 如 "皮卡猫"
---@field GoodItem                      	UnityEngine.RectTransform               @ 下面一层放 徽章
---@field GoodGroup                     	UnityEngine.RectTransform               @ 
---@field Root                          	UnityEngine.RectTransform               @
---@field TitleTxt                      	UnityEngine.RectTransform               @ 文本标题: 
---@field Arrow                         	UnityEngine.RectTransform               @ 小箭头
---@field ContentTxt                    	UnityEngine.UI.Text                     @ 文本正文: 
local Player2DBadgeTipPopup = Class('Player2DBadgeTipPopup', CommonTipsBoard)

function Player2DBadgeTipPopup:__init()
	CommonTipsBoard.__init(self)
end

function Player2DBadgeTipPopup:__delete()
	CommonTipsBoard.__delete(self)
end

function Player2DBadgeTipPopup:Awake()
	CommonTipsBoard.Awake(self)


    self.rootCanvasGroup = KTool.GetComponent(self.Root.gameObject, typeof(CanvasGroup))
    self.rootCanvasGroup.alpha = 0


	self:Init()
end

function Player2DBadgeTipPopup:Start()
	CommonTipsBoard.Start(self)
end

function Player2DBadgeTipPopup:OnDestroy()
	if self:GetCloseCallBack() then
		self:GetCloseCallBack()()
	end
	CommonTipsBoard.OnDestroy(self)
	self.controller = nil    --luabehaviour 中CSharp对象 self:Delete()
	self = nil
end

---------------------------------------------------
-- init begin --
---------------------------------------------------

---InitView 初始化界面
function Player2DBadgeTipPopup:InitView()
	CommonTipsBoard.InitView(self)

	-- 初始化界面
	self.ContentTxt.text = ''
end

---------------------------------------------------
-- init end --
---------------------------------------------------


---------------------------------------------------
-- content fix begin --
---------------------------------------------------




function Player2DBadgeTipPopup:Fill(bigTile, titleText, contentText, timeText, photoPath )


    CfUtils.FillCfText( self.BigTitle, bigTile )
    CfUtils.FillCfText( self.TitleTxt, titleText )
    CfUtils.FillCfText( self.ContentTxt, contentText )

	if type(timeText)~="string" or timeText=="" then
		KTool.SetActive( self.timeTitle, false )
	else
		KTool.SetActive( self.timeTitle, true )
    	CfUtils.FillCfText( self.TextTimeNum, timeText )
	end

    CfUtils.FillImage(self.Icon, photoPath)  -- 绘制 徽章图像

end


function Player2DBadgeTipPopup:Show()
    KTool.SetActive( self.Root, true )
    self.rootCanvasGroup.alpha = 1
end



function CommonTipsBoard:SetCloseCallBack(handler)
	self.closeCallBack_ = handler
end
function CommonTipsBoard:GetCloseCallBack()
	return self.closeCallBack_
end

---------------------------------------------------
-- content fix end --
---------------------------------------------------

return Player2DBadgeTipPopup