local var_0_0 = {
	Play710220201 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 710220201
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play710220202(arg_1_1)
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

			local var_4_1 = 0.0334

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_1 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= 0 + var_4_1 and arg_1_1.time_ < 0 + var_4_1 + arg_4_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			if 0.0334 < arg_1_1.time_ and arg_1_1.time_ <= 0.0334 + arg_4_0 then
				local var_4_2 = Object.Instantiate(arg_1_1.narrativeItemGo_)
				local var_4_3 = var_4_2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_1_0, var_4_2)

				arg_1_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")
				arg_1_0.narr_item_content.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(710220201).content)

				var_4_2.transform:SetParent(arg_1_1.narrativeItemGo_.transform.parent)

				var_4_2.transform.localPosition = Vector3(0, 0, 0)
				var_4_2.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_4_2, true)
			end

			local var_4_4 = 1

			if 0.0334 <= arg_1_1.time_ and arg_1_1.time_ < 0.0334 + var_4_4 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= 0.0334 + var_4_4 and arg_1_1.time_ < 0.0334 + var_4_4 + arg_4_0 then
				-- block empty
			end

			local var_4_5 = "D999"

			if arg_1_1.bgs_.D999 == nil then
				local var_4_6 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_5)
				var_4_6.name = var_4_5
				var_4_6.transform.parent = arg_1_1.stage_.transform
				var_4_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_5] = var_4_6
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.D999

				arg_1_1.bgs_.D999.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = 2 * (var_4_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_7.transform.localScale = Vector3.New(var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, 0)
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
	Play710220202 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 710220202
		arg_5_1.duration_ = 1

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play710220203(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_1.narrativeGo_)

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				local var_8_0 = Object.Instantiate(arg_5_1.narrativeItemGo_)
				local var_8_1 = var_8_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_5_0, var_8_0)

				arg_5_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1022")
				arg_5_0.narr_item_content.text = arg_5_1:FormatText(arg_5_1:GetWordFromCfg(710220202).content)

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
	Play710220203 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 710220203
		arg_9_1.duration_ = 1

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play710220204(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_9_0, arg_9_1.narrativeGo_)

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_0 = Object.Instantiate(arg_9_1.narrativeItemGo_)
				local var_12_1 = var_12_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_9_0, var_12_0)

				arg_9_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")
				arg_9_0.narr_item_content.text = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(710220203).content)

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
	Play710220204 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 710220204
		arg_13_1.duration_ = 1

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play710220205(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_13_0, arg_13_1.narrativeGo_)

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_0 = Object.Instantiate(arg_13_1.narrativeItemGo_)
				local var_16_1 = var_16_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_13_0, var_16_0)

				arg_13_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1022")
				arg_13_0.narr_item_content.text = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(710220204).content)

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
	Play710220205 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 710220205
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play710220206(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_17_0, arg_17_1.narrativeGo_)

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_0 = Object.Instantiate(arg_17_1.narrativeItemGo_)
				local var_20_1 = var_20_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_17_0, var_20_0)

				arg_17_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")
				arg_17_0.narr_item_content.text = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(710220205).content)

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
	Play710220206 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 710220206
		arg_21_1.duration_ = 1

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play710220207(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_21_0, arg_21_1.narrativeGo_)

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_0 = Object.Instantiate(arg_21_1.narrativeItemGo_)
				local var_24_1 = var_24_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_21_0, var_24_0)

				arg_21_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1022")
				arg_21_0.narr_item_content.text = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(710220206).content)

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
	Play710220207 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 710220207
		arg_25_1.duration_ = 1

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play710220208(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_25_0, arg_25_1.narrativeGo_)

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_0 = Object.Instantiate(arg_25_1.narrativeItemGo_)
				local var_28_1 = var_28_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_25_0, var_28_0)

				arg_25_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")
				arg_25_0.narr_item_content.text = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(710220207).content)

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
	Play710220208 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 710220208
		arg_29_1.duration_ = 1

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play710220209(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_29_0, arg_29_1.narrativeGo_)

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_0 = Object.Instantiate(arg_29_1.narrativeItemGo_)
				local var_32_1 = var_32_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_29_0, var_32_0)

				arg_29_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1022")
				arg_29_0.narr_item_content.text = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(710220208).content)

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
	Play710220209 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 710220209
		arg_33_1.duration_ = 1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play710220210(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_33_0, arg_33_1.narrativeGo_)

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_0 = Object.Instantiate(arg_33_1.narrativeItemGo_)
				local var_36_1 = var_36_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_33_0, var_36_0)

				arg_33_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")
				arg_33_0.narr_item_content.text = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(710220209).content)

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
	Play710220210 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 710220210
		arg_37_1.duration_ = 1.03

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
			arg_37_1.auto_ = false
		end

		function arg_37_1.playNext_(arg_39_0)
			arg_37_1.onStoryFinished_()
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_37_0, arg_37_1.narrativeGo_)

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_0 = Object.Instantiate(arg_37_1.narrativeItemGo_)
				local var_40_1 = var_40_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_37_0, var_40_0)

				arg_37_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1022")
				arg_37_0.narr_item_content.text = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(710220210).content)

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

			ComponentBinder.GetInstance():BindCfgUI(arg_37_0, arg_37_1.narrativeGo_)

			if 1 < arg_37_1.time_ and arg_37_1.time_ <= 1 + arg_40_0 then
				-- block empty
			end

			local var_40_3 = 0.0334

			if 1 <= arg_37_1.time_ and arg_37_1.time_ < 1 + var_40_3 and arg_37_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_37_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_37_1.time_ >= 1 + var_40_3 and arg_37_1.time_ < 1 + var_40_3 + arg_40_0 then
				arg_37_1.narrativeListGo_.movementType = ScrollRect.MovementType.Elastic

				local var_40_4 = arg_37_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_40_4 then
					var_40_4.raycastTarget = true
				end

				SetActive(arg_37_1.narrativeContinueBtn_.gameObject, true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
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
		"story_1042",
		710220201
	},
	{
		"story_1022",
		710220202
	},
	{
		"story_1042",
		710220203
	},
	{
		"story_1022",
		710220204
	},
	{
		"story_1042",
		710220205
	},
	{
		"story_1022",
		710220206
	},
	{
		"story_1042",
		710220207
	},
	{
		"story_1022",
		710220208
	},
	{
		"story_1042",
		710220209
	},
	{
		"story_1022",
		710220210
	}
}

return var_0_0
