local var_0_0 = {
	Play710810201 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 710810201
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play710810202(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				SetActive(arg_1_1.hideBtn_, false)
				SetActive(arg_1_1.narrativeGo_, true)
				SetActive(arg_1_1.lastBtn_.gameObject, false)
				SetActive(arg_1_1.bgmBtn_.gameObject, false)

				arg_1_0.narr_chapter_text.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(101).content)
				arg_1_0.narr_time_text.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(100012006).content)
				arg_1_1.narrativeListGo_.movementType = ScrollRect.MovementType.Clamped

				local var_4_0 = arg_1_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_4_0 then
					var_4_0.raycastTarget = false
				end

				SetActive(arg_1_1.narrativeContinueBtn_.gameObject, false)
			end

			local var_4_1 = 0.0666666666666667

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_1 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= 0 + var_4_1 and arg_1_1.time_ < 0 + var_4_1 + arg_4_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			if 0.0666666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.0666666666666667 + arg_4_0 then
				local var_4_2 = Object.Instantiate(arg_1_1.narrativeItemGo_)
				local var_4_3 = var_4_2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_1_0, var_4_2)
				SetActive(arg_1_0.narr_item_head.transform.parent.gameObject, false)

				local var_4_4 = var_4_2.transform:Find("container/a")
				local var_4_5 = var_4_2.transform:Find("container/b")
				local var_4_6 = var_4_2.transform:Find("container/text")

				if var_4_4 and var_4_5 and var_4_6 then
					SetActive(var_4_4.gameObject, false)
					SetActive(var_4_5.gameObject, false)
					SetActive(var_4_6.gameObject, false)
				end

				arg_1_0.narr_item_content.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(710810201).content)

				var_4_2.transform:SetParent(arg_1_1.narrativeItemGo_.transform.parent)

				var_4_2.transform.localPosition = Vector3(0, 0, 0)
				var_4_2.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_4_2, true)
			end

			local var_4_7 = 1

			if 0.0666666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 0.0666666666666667 + var_4_7 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= 0.0666666666666667 + var_4_7 and arg_1_1.time_ < 0.0666666666666667 + var_4_7 + arg_4_0 then
				-- block empty
			end

			local var_4_8 = "D999"

			if arg_1_1.bgs_.D999 == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.bgs_.D999

				arg_1_1.bgs_.D999.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_11 = var_4_10:GetComponent("SpriteRenderer")

				if var_4_11 and var_4_11.sprite then
					local var_4_12 = 2 * (var_4_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_10.transform.localScale = Vector3.New(var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D999" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play710810202 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 710810202
		arg_5_1.duration_ = 1

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play710810203(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_1.narrativeGo_)

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				local var_8_0 = Object.Instantiate(arg_5_1.narrativeItemGo_)
				local var_8_1 = var_8_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_5_0, var_8_0)

				arg_5_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_5_0.narr_item_content.text = arg_5_1:FormatText(arg_5_1:GetWordFromCfg(710810202).content)

				var_8_0.transform:SetParent(arg_5_1.narrativeItemGo_.transform.parent)

				var_8_0.transform.localPosition = Vector3(0, 0, 0)
				var_8_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_8_0, true)
			end

			local var_8_2 = 1

			if 0 <= arg_5_1.time_ and arg_5_1.time_ < 0 + var_8_2 and arg_5_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_5_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_5_1.time_ >= 0 + var_8_2 and arg_5_1.time_ < 0 + var_8_2 + arg_8_0 then
				-- block empty
			end
		end

		arg_5_1.nodeConfigList_ = {}

		arg_5_1:InitPlayNodeList()
	end,
	Play710810203 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 710810203
		arg_9_1.duration_ = 1

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play710810204(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_9_0, arg_9_1.narrativeGo_)

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_0 = Object.Instantiate(arg_9_1.narrativeItemGo_)
				local var_12_1 = var_12_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_9_0, var_12_0)

				arg_9_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				arg_9_0.narr_item_content.text = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(710810203).content)

				var_12_0.transform:SetParent(arg_9_1.narrativeItemGo_.transform.parent)

				var_12_0.transform.localPosition = Vector3(0, 0, 0)
				var_12_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_12_0, true)
			end

			local var_12_2 = 1

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and arg_9_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_9_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 then
				-- block empty
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play710810204 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 710810204
		arg_13_1.duration_ = 1

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play710810205(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_13_0, arg_13_1.narrativeGo_)

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_0 = Object.Instantiate(arg_13_1.narrativeItemGo_)
				local var_16_1 = var_16_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_13_0, var_16_0)

				arg_13_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_13_0.narr_item_content.text = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(710810204).content)

				var_16_0.transform:SetParent(arg_13_1.narrativeItemGo_.transform.parent)

				var_16_0.transform.localPosition = Vector3(0, 0, 0)
				var_16_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_16_0, true)
			end

			local var_16_2 = 1

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and arg_13_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_13_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 then
				-- block empty
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play710810205 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 710810205
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play710810206(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_17_0, arg_17_1.narrativeGo_)

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_0 = Object.Instantiate(arg_17_1.narrativeItemGo_)
				local var_20_1 = var_20_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_17_0, var_20_0)

				arg_17_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				arg_17_0.narr_item_content.text = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(710810205).content)

				var_20_0.transform:SetParent(arg_17_1.narrativeItemGo_.transform.parent)

				var_20_0.transform.localPosition = Vector3(0, 0, 0)
				var_20_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_20_0, true)
			end

			local var_20_2 = 1

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and arg_17_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_17_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 then
				-- block empty
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play710810206 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 710810206
		arg_21_1.duration_ = 1

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play710810207(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_21_0, arg_21_1.narrativeGo_)

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_0 = Object.Instantiate(arg_21_1.narrativeItemGo_)
				local var_24_1 = var_24_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_21_0, var_24_0)

				arg_21_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				arg_21_0.narr_item_content.text = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(710810206).content)

				var_24_0.transform:SetParent(arg_21_1.narrativeItemGo_.transform.parent)

				var_24_0.transform.localPosition = Vector3(0, 0, 0)
				var_24_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_24_0, true)
			end

			local var_24_2 = 1

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and arg_21_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_21_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 then
				-- block empty
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play710810207 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 710810207
		arg_25_1.duration_ = 1

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play710810208(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_25_0, arg_25_1.narrativeGo_)

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_0 = Object.Instantiate(arg_25_1.narrativeItemGo_)
				local var_28_1 = var_28_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_25_0, var_28_0)

				arg_25_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_25_0.narr_item_content.text = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(710810207).content)

				var_28_0.transform:SetParent(arg_25_1.narrativeItemGo_.transform.parent)

				var_28_0.transform.localPosition = Vector3(0, 0, 0)
				var_28_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_28_0, true)
			end

			local var_28_2 = 1

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and arg_25_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_25_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 then
				-- block empty
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play710810208 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 710810208
		arg_29_1.duration_ = 1

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play710810209(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_29_0, arg_29_1.narrativeGo_)

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_0 = Object.Instantiate(arg_29_1.narrativeItemGo_)
				local var_32_1 = var_32_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_29_0, var_32_0)

				arg_29_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				arg_29_0.narr_item_content.text = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(710810208).content)

				var_32_0.transform:SetParent(arg_29_1.narrativeItemGo_.transform.parent)

				var_32_0.transform.localPosition = Vector3(0, 0, 0)
				var_32_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_32_0, true)
			end

			local var_32_2 = 1

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and arg_29_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_29_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 then
				-- block empty
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play710810209 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 710810209
		arg_33_1.duration_ = 1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play710810210(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_33_0, arg_33_1.narrativeGo_)

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_0 = Object.Instantiate(arg_33_1.narrativeItemGo_)
				local var_36_1 = var_36_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_33_0, var_36_0)

				arg_33_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				arg_33_0.narr_item_content.text = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(710810209).content)

				var_36_0.transform:SetParent(arg_33_1.narrativeItemGo_.transform.parent)

				var_36_0.transform.localPosition = Vector3(0, 0, 0)
				var_36_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_36_0, true)
			end

			local var_36_2 = 1

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and arg_33_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_33_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 then
				-- block empty
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play710810210 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 710810210
		arg_37_1.duration_ = 1

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play710810211(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_37_0, arg_37_1.narrativeGo_)

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_0 = Object.Instantiate(arg_37_1.narrativeItemGo_)
				local var_40_1 = var_40_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_37_0, var_40_0)

				arg_37_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_37_0.narr_item_content.text = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(710810210).content)

				var_40_0.transform:SetParent(arg_37_1.narrativeItemGo_.transform.parent)

				var_40_0.transform.localPosition = Vector3(0, 0, 0)
				var_40_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_40_0, true)
			end

			local var_40_2 = 1

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and arg_37_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_37_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 then
				-- block empty
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play710810211 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 710810211
		arg_41_1.duration_ = 1

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play710810212(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_41_0, arg_41_1.narrativeGo_)

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_0 = Object.Instantiate(arg_41_1.narrativeItemGo_)
				local var_44_1 = var_44_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_41_0, var_44_0)

				arg_41_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				arg_41_0.narr_item_content.text = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(710810211).content)

				var_44_0.transform:SetParent(arg_41_1.narrativeItemGo_.transform.parent)

				var_44_0.transform.localPosition = Vector3(0, 0, 0)
				var_44_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_44_0, true)
			end

			local var_44_2 = 1

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and arg_41_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_41_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 then
				-- block empty
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play710810212 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 710810212
		arg_45_1.duration_ = 1

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play710810213(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_45_0, arg_45_1.narrativeGo_)

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_0 = Object.Instantiate(arg_45_1.narrativeItemGo_)
				local var_48_1 = var_48_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_45_0, var_48_0)
				SetActive(arg_45_0.narr_item_head.transform.parent.gameObject, false)

				local var_48_2 = var_48_0.transform:Find("container/a")
				local var_48_3 = var_48_0.transform:Find("container/b")
				local var_48_4 = var_48_0.transform:Find("container/text")

				if var_48_2 and var_48_3 and var_48_4 then
					SetActive(var_48_2.gameObject, false)
					SetActive(var_48_3.gameObject, false)
					SetActive(var_48_4.gameObject, false)
				end

				arg_45_0.narr_item_content.text = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(710810212).content)

				var_48_0.transform:SetParent(arg_45_1.narrativeItemGo_.transform.parent)

				var_48_0.transform.localPosition = Vector3(0, 0, 0)
				var_48_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_48_0, true)
			end

			local var_48_5 = 1

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and arg_45_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_45_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 then
				-- block empty
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play710810213 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 710810213
		arg_49_1.duration_ = 1

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play710810214(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_49_0, arg_49_1.narrativeGo_)

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				local var_52_0 = Object.Instantiate(arg_49_1.narrativeItemGo_)
				local var_52_1 = var_52_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_49_0, var_52_0)

				arg_49_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				arg_49_0.narr_item_content.text = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(710810213).content)

				var_52_0.transform:SetParent(arg_49_1.narrativeItemGo_.transform.parent)

				var_52_0.transform.localPosition = Vector3(0, 0, 0)
				var_52_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_52_0, true)
			end

			local var_52_2 = 1

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and arg_49_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_49_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 then
				-- block empty
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play710810214 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 710810214
		arg_53_1.duration_ = 1

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play710810215(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_53_0, arg_53_1.narrativeGo_)

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				local var_56_0 = Object.Instantiate(arg_53_1.narrativeItemGo_)
				local var_56_1 = var_56_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_53_0, var_56_0)
				SetActive(arg_53_0.narr_item_head.transform.parent.gameObject, false)

				local var_56_2 = var_56_0.transform:Find("container/a")
				local var_56_3 = var_56_0.transform:Find("container/b")
				local var_56_4 = var_56_0.transform:Find("container/text")

				if var_56_2 and var_56_3 and var_56_4 then
					SetActive(var_56_2.gameObject, false)
					SetActive(var_56_3.gameObject, false)
					SetActive(var_56_4.gameObject, false)
				end

				arg_53_0.narr_item_content.text = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(710810214).content)

				var_56_0.transform:SetParent(arg_53_1.narrativeItemGo_.transform.parent)

				var_56_0.transform.localPosition = Vector3(0, 0, 0)
				var_56_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_56_0, true)
			end

			local var_56_5 = 1

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 and arg_53_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_53_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 then
				-- block empty
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play710810215 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 710810215
		arg_57_1.duration_ = 1

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play710810216(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_57_0, arg_57_1.narrativeGo_)

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				local var_60_0 = Object.Instantiate(arg_57_1.narrativeItemGo_)
				local var_60_1 = var_60_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_57_0, var_60_0)

				arg_57_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_57_0.narr_item_content.text = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(710810215).content)

				var_60_0.transform:SetParent(arg_57_1.narrativeItemGo_.transform.parent)

				var_60_0.transform.localPosition = Vector3(0, 0, 0)
				var_60_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_60_0, true)
			end

			local var_60_2 = 1

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and arg_57_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_57_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				-- block empty
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play710810216 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 710810216
		arg_61_1.duration_ = 1

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play710810217(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_61_0, arg_61_1.narrativeGo_)

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_0 = Object.Instantiate(arg_61_1.narrativeItemGo_)
				local var_64_1 = var_64_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_61_0, var_64_0)

				arg_61_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				arg_61_0.narr_item_content.text = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(710810216).content)

				var_64_0.transform:SetParent(arg_61_1.narrativeItemGo_.transform.parent)

				var_64_0.transform.localPosition = Vector3(0, 0, 0)
				var_64_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_64_0, true)
			end

			local var_64_2 = 1

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and arg_61_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_61_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 then
				-- block empty
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play710810217 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 710810217
		arg_65_1.duration_ = 1

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play710810218(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_65_0, arg_65_1.narrativeGo_)

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				local var_68_0 = Object.Instantiate(arg_65_1.narrativeItemGo_)
				local var_68_1 = var_68_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_65_0, var_68_0)

				arg_65_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_65_0.narr_item_content.text = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(710810217).content)

				var_68_0.transform:SetParent(arg_65_1.narrativeItemGo_.transform.parent)

				var_68_0.transform.localPosition = Vector3(0, 0, 0)
				var_68_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_68_0, true)
			end

			local var_68_2 = 1

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and arg_65_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_65_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 then
				-- block empty
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play710810218 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 710810218
		arg_69_1.duration_ = 1.03

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
			arg_69_1.auto_ = false
		end

		function arg_69_1.playNext_(arg_71_0)
			arg_69_1.onStoryFinished_()
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_69_0, arg_69_1.narrativeGo_)

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_0 = Object.Instantiate(arg_69_1.narrativeItemGo_)
				local var_72_1 = var_72_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_69_0, var_72_0)

				arg_69_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				arg_69_0.narr_item_content.text = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(710810218).content)

				var_72_0.transform:SetParent(arg_69_1.narrativeItemGo_.transform.parent)

				var_72_0.transform.localPosition = Vector3(0, 0, 0)
				var_72_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_72_0, true)
			end

			local var_72_2 = 1

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and arg_69_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_69_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_69_0, arg_69_1.narrativeGo_)

			if 1 < arg_69_1.time_ and arg_69_1.time_ <= 1 + arg_72_0 then
				-- block empty
			end

			local var_72_3 = 0.0334

			if 1 <= arg_69_1.time_ and arg_69_1.time_ < 1 + var_72_3 and arg_69_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_69_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_69_1.time_ >= 1 + var_72_3 and arg_69_1.time_ < 1 + var_72_3 + arg_72_0 then
				arg_69_1.narrativeListGo_.movementType = ScrollRect.MovementType.Elastic

				local var_72_4 = arg_69_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_72_4 then
					var_72_4.raycastTarget = true
				end

				SetActive(arg_69_1.narrativeContinueBtn_.gameObject, true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D999"
	},
	voices = {}
}

var_0_0.narrativeChapter = 101
var_0_0.narrativeTime = 100012006
var_0_0.narrativeData = {
	{
		"",
		710810201
	},
	{
		"story_1039",
		710810202
	},
	{
		"story_1081",
		710810203
	},
	{
		"story_1039",
		710810204
	},
	{
		"story_1081",
		710810205
	},
	{
		"story_1081",
		710810206
	},
	{
		"story_1039",
		710810207
	},
	{
		"story_1081",
		710810208
	},
	{
		"story_1081",
		710810209
	},
	{
		"story_1039",
		710810210
	},
	{
		"story_1081",
		710810211
	},
	{
		"",
		710810212
	},
	{
		"story_1081",
		710810213
	},
	{
		"",
		710810214
	},
	{
		"story_1039",
		710810215
	},
	{
		"story_1081",
		710810216
	},
	{
		"story_1039",
		710810217
	},
	{
		"story_1081",
		710810218
	}
}

return var_0_0
