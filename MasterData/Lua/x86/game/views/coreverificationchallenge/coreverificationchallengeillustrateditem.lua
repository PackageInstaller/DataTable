local CoreVerificationChallengeIllustratedItem = class("CoreVerificationChallengeIllustratedItem", ReduxView)

function CoreVerificationChallengeIllustratedItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.sort = arg_1_2

	self:Init()
end

function CoreVerificationChallengeIllustratedItem:Init()
	self:InitUI()
	self:AddUIListener()

	for iter_2_0, iter_2_1 in ipairs(CoreVerificationClBadgeCfg.get_id_list_by_activity_id[CoreVerificationChallengeTools.GetActivityId()]) do
		if self.sort == CoreVerificationClBadgeCfg[iter_2_1].sort then
			self.bagdeCfg = CoreVerificationClBadgeCfg[iter_2_1]

			break
		elseif self.sort == 4 and CoreVerificationClBadgeCfg[iter_2_1].level == 1 then
			self.bagdeCfg = CoreVerificationClBadgeCfg[iter_2_1]

			break
		end
	end
end

function CoreVerificationChallengeIllustratedItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controller_:GetController("lock")
end

function CoreVerificationChallengeIllustratedItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		OperationRecorder.RecordButtonTouch("challenge_attribute_achie_touch_" .. self.bagdeCfg.id .. "_" .. self.bagdeCfg.level)
		JumpTools.OpenPageByJump("coreVerificationChallengeIllustratedPopView", {
			bagdeCfg = self.bagdeCfg,
			cfg = self.cfg
		})
	end)
	self:AddBtnListener(self.btn2_, nil, function()
		OperationRecorder.RecordButtonTouch("challenge_attribute_achie_touch_" .. self.bagdeCfg.id .. "_" .. self.bagdeCfg.level)
		JumpTools.OpenPageByJump("coreVerificationChallengeIllustratedPopView", {
			bagdeCfg = self.bagdeCfg,
			cfg = self.cfg
		})
	end)
end

function CoreVerificationChallengeIllustratedItem:RefreshUI(arg_7_1, arg_7_2)
	if arg_7_1 then
		self.cfg = arg_7_1
		self.bagdeCfg = CoreVerificationClBadgeCfg[arg_7_1.illustrated_id]

		self.stateController_:SetSelectedIndex(0)

		self.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", self.bagdeCfg.id))
	elseif self.stateController_:GetSelectedIndex() ~= 0 then
		for iter_7_0, iter_7_1 in ipairs(CoreVerificationClBadgeCfg.all) do
			if self.sort == CoreVerificationClBadgeCfg[iter_7_1].sort and arg_7_2 == CoreVerificationClBadgeCfg[iter_7_1].set_id then
				self.bagdeCfg = CoreVerificationClBadgeCfg[iter_7_1]

				break
			elseif self.sort == 4 and CoreVerificationClBadgeCfg[iter_7_1].level >= 1 and arg_7_2 == CoreVerificationClBadgeCfg[iter_7_1].set_id then
				self.bagdeCfg = CoreVerificationClBadgeCfg[iter_7_1]

				break
			end
		end

		self.stateController_:SetSelectedIndex(1)
	end
end

function CoreVerificationChallengeIllustratedItem:Dispose()
	CoreVerificationChallengeIllustratedItem.super.Dispose(self)
end

return CoreVerificationChallengeIllustratedItem
