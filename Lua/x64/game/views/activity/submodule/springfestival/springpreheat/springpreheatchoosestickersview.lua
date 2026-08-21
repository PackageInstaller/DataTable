local var_0_0 = require("game.views.Sticker.ChooseStickersView")
local var_0_1 = class("SpringPreheatChooseStickersView", var_0_0)

function var_0_1.AddUIListeners(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.sizeTgl_) do
		arg_1_0:AddBtnListener(iter_1_1, nil, function()
			arg_1_0.curSize_ = iter_1_0

			arg_1_0:RefreshIcon()
			arg_1_0:RefreshBtn()
			arg_1_0:RefreshSize()

			if arg_1_0.curID_ == arg_1_0.oldStickerID_ then
				if arg_1_0.params_.onChangeStickerSize then
					arg_1_0.params_.onChangeStickerSize(arg_1_0.curIndex_, arg_1_0.curID_, arg_1_0.curSize_)
				end

				arg_1_0:Back()
			end
		end)
	end

	arg_1_0:AddBtnListener(arg_1_0.useBtn_, nil, function()
		if arg_1_0.curID_ == arg_1_0.oldStickerID_ and arg_1_0.curSize_ == arg_1_0.info_.size then
			arg_1_0.curID_ = 0
		end

		if arg_1_0.params_.onChangeSticker then
			arg_1_0.params_.onChangeSticker(arg_1_0.curIndex_, arg_1_0.curID_, arg_1_0.curSize_)
		end

		arg_1_0:Back()
	end)
	arg_1_0:AddBtnListener(arg_1_0.bgBtn_, nil, function()
		arg_1_0:Back()
	end)
end

return var_0_1
