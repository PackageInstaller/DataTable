local SubtitleBubble = class("SubtitleBubble", import("game.extend.BaseView"))

function SubtitleBubble:UIName()
	return "Widget/BackHouseUI/Dorm/item/SubtitleBubbleView"
end

function SubtitleBubble:GetTopSubtitleView()
	self = self or Dorm.subtitleViewStack

	if self then
		return self[#self]
	end
end

function SubtitleBubble:PushSubtitleView(arg_3_1)
	arg_3_1 = arg_3_1 or Dorm.subtitleViewStack

	if arg_3_1 then
		if #arg_3_1 > 0 then
			arg_3_1[#arg_3_1]:OnDisable()
		end

		table.insert(arg_3_1, self)
	end
end

function SubtitleBubble:ReplaceSubtitleView(arg_4_1, arg_4_2)
	arg_4_1 = arg_4_1 or Dorm.subtitleViewStack
	arg_4_2 = arg_4_2 or 1

	if arg_4_1 then
		if arg_4_1[arg_4_2] then
			arg_4_1[arg_4_2]:OnDisable()
		end

		arg_4_1[arg_4_2] = self
	end
end

function SubtitleBubble:PopSubtitleView(arg_5_1)
	arg_5_1 = arg_5_1 or Dorm.subtitleViewStack

	if arg_5_1 and arg_5_1[#arg_5_1] == self then
		table.remove(arg_5_1)

		if #arg_5_1 > 0 then
			arg_5_1[#arg_5_1]:OnEnable()
		end
	end
end

function SubtitleBubble:Ctor(arg_6_1, arg_6_2, arg_6_3)
	SubtitleBubble.super.Ctor(self)

	if arg_6_1 == nil then
		self.gameObject_ = GameObject.Instantiate(Asset.Load(self:UIName()), manager.ui.uiMain.transform)
		self.needDisposeGo = true
		self.global = true
	else
		self.gameObject_ = arg_6_1
	end

	self.transform_ = nullable(self.gameObject_, "transform")

	self.transform_:SetAsFirstSibling()

	self.staticMode = arg_6_2
	self.bubbles = {}
	self.curPlaying = {}

	self:BindCfgUI()
end

function SubtitleBubble:OnEnter()
	if self.global then
		SubtitleBubble.ReplaceSubtitleView(self)
	else
		SubtitleBubble.PushSubtitleView(self)
	end

	self:OnEnable()
end

function SubtitleBubble:OnEnable()
	self:RegistEventListener(DORM_CHARACTER_PLAY_SUBTITLE_SEQ, self.OnPlaySubtitleSeq)
	self:RegistEventListener(DORM_CHARACTER_PLAY_SUBTITLE, self.OnPlaySubtitle)
	self:RegistEventListener(DORM_CHARACTER_DISPOSE, self.OnEntityDispose)
	self:RegistEventListener(DORM_VISIT_CHARACTER_FIRST_TALK, self.CustomPlayVisitSubtitleSeq)
end

function SubtitleBubble:OnExit()
	self:OnDisable()
	SubtitleBubble.PopSubtitleView(self)
end

function SubtitleBubble:OnDisable()
	for iter_10_0, iter_10_1 in pairs(self.curPlaying) do
		iter_10_1:Abort()
	end

	for iter_10_2, iter_10_3 in pairs(self.bubbles) do
		iter_10_3:Dispose()
	end

	self.bubbles = {}
	self.curPlaying = {}

	self:RemoveAllEventListener()
end

function SubtitleBubble:SetEntityFilter(arg_11_1)
	self.filter = arg_11_1
end

function SubtitleBubble:GetBubble(arg_12_1)
	local var_12_0 = self.bubbles[arg_12_1]

	if not self.bubbles[arg_12_1] and (self.filter == nil or self.filter[arg_12_1]) then
		local var_12_1 = GameObject.Instantiate(self.bubblePrefab, self.bubbleRoot)

		var_12_0 = BubbleItem.New(var_12_1)

		var_12_0.content:SetActive(false)

		self.bubbles[arg_12_1] = var_12_0

		var_12_1:SetActive(true)
	end

	return var_12_0
end

local function var_0_1(arg_13_0)
	return arg_13_0 == nil or arg_13_0 == "" or IsAllSpace(arg_13_0)
end

local var_0_2 = {
	{
		[1054] = 6148,
		[105401] = 614801
	}
}

local function var_0_3(arg_14_0, arg_14_1, arg_14_2)
	return nullable(DormHeroVoiceDescCfg, nullable(var_0_2, arg_14_1, arg_14_0) or arg_14_0, arg_14_2)
end

local function var_0_4(arg_15_0, arg_15_1)
	local var_15_0 = Dorm.storage:GetData(DormUtils.IdxNamespace(DormEnum.CharacterType.DormNormalHero), arg_15_0)
	local var_15_1 = DormUtils.GetEntityData(arg_15_0).skinVariant
	local var_15_2 = var_0_3(var_15_0, var_15_1, arg_15_1)

	if var_0_1(var_15_2) then
		local var_15_3 = nullable(BackHomeHeroSkinCfg, var_15_0, "hero_id")

		if var_15_3 ~= var_15_0 then
			var_15_2 = var_0_3(var_15_3, var_15_1, arg_15_1)
		end
	end

	return var_15_2
end

SubtitleBubble.UseDormHeroSubtitle = var_0_4

function SubtitleBubble:UseRawContent(arg_16_1)
	return arg_16_1
end

function SubtitleBubble:UseTips(arg_17_1)
	return GetTips(arg_17_1)
end

function SubtitleBubble:OnPlaySubtitleSeq(arg_18_1)
	local var_18_0 = SubtitleBubble.GetTopSubtitleView()

	if var_18_0 == nil then
		return
	end

	local var_18_1 = DormHeroTools:CheckIsVisitHero(self)
	local var_18_2 = DormCharacterActionManager.frameTaskRunner:NewTask()
	local var_18_3 = var_18_0:GetBubble(self)

	if var_18_3 == nil then
		return
	end

	if not var_18_0.staticMode then
		DormLuaBridge.SetUIFollow(var_18_3.transform_, self, "gua_Hp")
	end

	if var_18_0.curPlaying[self] then
		var_18_0.curPlaying[self]:Abort()
	end

	for iter_18_0 = 0, arg_18_1.Length - 1 do
		local var_18_4 = arg_18_1[iter_18_0]

		var_18_2:WaitForSec(arg_18_1[iter_18_0].time):Then(function()
			local var_19_1 = ""

			var_19_1 = var_18_1 and var_18_0:GetVisitContent() or (var_18_0.getContentFunc or Dorm.overrideSubtitleGetContentFunc or var_0_4)(self, var_18_4.subtitleID)

			var_18_3:ShowSubtitle(self)
			var_18_3:SetData(var_19_1)
		end)
	end

	var_18_0.curPlaying[self] = var_18_2

	var_18_2:Start()
end

function SubtitleBubble:CustomPlayVisitSubtitleSeq()
	local var_20_0 = SubtitleBubble.GetTopSubtitleView()

	if var_20_0 == nil then
		return
	end

	local var_20_1 = DormHeroTools:CheckIsVisitHero(self)
	local var_20_2 = DormCharacterActionManager.frameTaskRunner:NewTask()
	local var_20_3 = var_20_0:GetBubble(self)

	if var_20_3 == nil then
		return
	end

	if not var_20_0.staticMode then
		DormLuaBridge.SetUIFollow(var_20_3.transform_, self, "gua_Hp")
	end

	if var_20_0.curPlaying[self] then
		var_20_0.curPlaying[self]:Abort()
	end

	local var_20_4 = var_20_0:GetVisitContent()

	var_20_2:WaitForSec(1):Then(function()
		if not var_20_0.getContentFunc and not Dorm.overrideSubtitleGetContentFunc then
			-- block empty
		end

		local var_21_1 = var_20_4

		var_20_3:ShowSubtitle(self)
		var_20_3:SetData(var_21_1)
	end)

	var_20_0.curPlaying[self] = var_20_2

	var_20_2:Start()
end

function SubtitleBubble:OnPlaySubtitle(arg_22_1, arg_22_2)
	local var_22_0 = SubtitleBubble.GetTopSubtitleView()

	if var_22_0 == nil then
		return
	end

	local var_22_1 = var_22_0:GetBubble(self)

	if var_22_1 == nil or arg_22_2 and var_22_1:IsPlaying() then
		return
	end

	if not var_22_0.staticMode then
		DormLuaBridge.SetUIFollow(var_22_1.transform_, self, "gua_Hp")
	end

	if var_22_0.curPlaying[self] then
		var_22_0.curPlaying[self]:Abort()

		var_22_0.curPlaying[self] = nil
	end

	local var_22_2 = (var_22_0.getContentFunc or Dorm.overrideSubtitleGetContentFunc or var_0_4)(self, arg_22_1)

	var_22_1:ShowSubtitle(self)
	var_22_1:SetData(var_22_2)
end

function SubtitleBubble:GetVisitContent()
	if GameDisplayCfg.dorm_player_greetings then
		local var_23_0 = GameDisplayCfg.dorm_player_greetings.value or {}

		if #var_23_0 > 0 then
			return GetTips(TipsCfg[var_23_0[math.random(#var_23_0)]].define)
		else
			return ""
		end
	else
		return ""
	end
end

function SubtitleBubble:OnEntityDispose()
	local var_24_0 = SubtitleBubble.GetTopSubtitleView()

	if var_24_0 == nil then
		return
	end

	if var_24_0.bubbles[self] then
		var_24_0.bubbles[self]:Dispose()

		var_24_0.bubbles[self] = nil
	end
end

local var_0_5 = singletonClass("MuteBubbleSubView", SubtitleBubble)

function var_0_5.Ctor(arg_25_0)
	var_0_5.super.Ctor(arg_25_0, nil, true)

	arg_25_0.global = false
end

function var_0_5.GetBubble(arg_26_0)
	return nil
end

function SubtitleBubble:Dispose()
	if self.needDisposeGo then
		GameObject.Destroy(self.gameObject_)
	end
end

SubtitleBubble.MuteBubbleSubView = var_0_5

return SubtitleBubble
