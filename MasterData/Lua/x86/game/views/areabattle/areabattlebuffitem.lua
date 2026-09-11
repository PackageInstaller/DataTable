local AreaBattleBuffItem = class("AreaBattleBuffItem", ReduxView)

function AreaBattleBuffItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AreaBattleBuffItem:Init()
	self:InitUI()
end

function AreaBattleBuffItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.btn_, nil, function()
		if self.cfg.name == self.nameTxt_.text and self.tipsGo_.activeSelf == true then
			SetActive(self.tipsGo_, false)
		else
			self.nameTxt_.text = GetI18NText(self.cfg.name)
			self.descTxt_.text = GetI18NText(self.cfg.desc)

			SetActive(self.tipsGo_, true)

			self.tipsGo_.transform.position = Vector3(self.transform_.position.x, self.transform_.position.y - 0.1, self.transform_.position.z)
		end
	end)
end

function AreaBattleBuffItem:SetData(arg_5_1)
	self.affixID = arg_5_1
	self.cfg = TalentTreeCfg[arg_5_1]
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BuffIcon/" .. PublicBuffCfg[self.cfg.affix_id].icon)
end

function AreaBattleBuffItem:OnExit()
	return
end

function AreaBattleBuffItem:Dispose()
	AreaBattleBuffItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AreaBattleBuffItem
