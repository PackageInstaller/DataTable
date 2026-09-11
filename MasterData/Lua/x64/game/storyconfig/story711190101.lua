local var_0_0 = {
	Play711190101 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 711190101
		arg_1_1.duration_ = 1.03

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play711190102(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D999 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D999")
				var_4_0.name = "D999"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D999 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D999

				arg_1_1.bgs_.D999.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D999" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				SetActive(arg_1_1.hideBtn_, false)
				SetActive(arg_1_1.narrativeGo_, true)
				SetActive(arg_1_1.lastBtn_.gameObject, false)
				SetActive(arg_1_1.bgmBtn_.gameObject, false)

				arg_1_0.narr_chapter_text.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(101).content)
				arg_1_0.narr_time_text.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(100012006).content)
				arg_1_1.narrativeListGo_.movementType = ScrollRect.MovementType.Clamped

				local var_4_4 = arg_1_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_4_4 then
					var_4_4.raycastTarget = false
				end

				SetActive(arg_1_1.narrativeContinueBtn_.gameObject, false)
			end

			local var_4_5 = 0.0334

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			if 0.0333999999989999 < arg_1_1.time_ and arg_1_1.time_ <= 0.0333999999989999 + arg_4_0 then
				local var_4_6 = Object.Instantiate(arg_1_1.narrativeItemGo_)
				local var_4_7 = var_4_6:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_1_0, var_4_6)

				arg_1_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")
				arg_1_0.narr_item_content.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(711190101).content)

				var_4_6.transform:SetParent(arg_1_1.narrativeItemGo_.transform.parent)

				var_4_6.transform.localPosition = Vector3(0, 0, 0)
				var_4_6.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_4_6, true)
			end

			local var_4_8 = 1

			if 0.0333999999989999 <= arg_1_1.time_ and arg_1_1.time_ < 0.0333999999989999 + var_4_8 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= 0.0333999999989999 + var_4_8 and arg_1_1.time_ < 0.0333999999989999 + var_4_8 + arg_4_0 then
				-- block empty
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play711190102 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 711190102
		arg_5_1.duration_ = 1

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play711190103(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_1.narrativeGo_)

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				local var_8_0 = Object.Instantiate(arg_5_1.narrativeItemGo_)
				local var_8_1 = var_8_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_5_0, var_8_0)

				arg_5_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1119")
				arg_5_0.narr_item_content.text = arg_5_1:FormatText(arg_5_1:GetWordFromCfg(711190102).content)

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
	Play711190103 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 711190103
		arg_9_1.duration_ = 1

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play711190104(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_9_0, arg_9_1.narrativeGo_)

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_0 = Object.Instantiate(arg_9_1.narrativeItemGo_)
				local var_12_1 = var_12_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_9_0, var_12_0)

				arg_9_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")
				arg_9_0.narr_item_content.text = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(711190103).content)

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
	Play711190104 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 711190104
		arg_13_1.duration_ = 1

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play711190105(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_13_0, arg_13_1.narrativeGo_)

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_0 = Object.Instantiate(arg_13_1.narrativeItemGo_)
				local var_16_1 = var_16_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_13_0, var_16_0)

				arg_13_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1119")
				arg_13_0.narr_item_content.text = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(711190104).content)

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
	Play711190105 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 711190105
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play711190106(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_17_0, arg_17_1.narrativeGo_)

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_0 = Object.Instantiate(arg_17_1.narrativeItemGo_)
				local var_20_1 = var_20_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_17_0, var_20_0)

				arg_17_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")
				arg_17_0.narr_item_content.text = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(711190105).content)

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
	Play711190106 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 711190106
		arg_21_1.duration_ = 1

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play711190107(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_21_0, arg_21_1.narrativeGo_)

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_0 = Object.Instantiate(arg_21_1.narrativeItemGo_)
				local var_24_1 = var_24_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_21_0, var_24_0)

				arg_21_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1119")
				arg_21_0.narr_item_content.text = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(711190106).content)

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
	Play711190107 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 711190107
		arg_25_1.duration_ = 1

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play711190108(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_25_0, arg_25_1.narrativeGo_)

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_0 = Object.Instantiate(arg_25_1.narrativeItemGo_)
				local var_28_1 = var_28_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_25_0, var_28_0)

				arg_25_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")
				arg_25_0.narr_item_content.text = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(711190107).content)

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
	Play711190108 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 711190108
		arg_29_1.duration_ = 1

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play711190109(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_29_0, arg_29_1.narrativeGo_)

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_0 = Object.Instantiate(arg_29_1.narrativeItemGo_)
				local var_32_1 = var_32_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_29_0, var_32_0)

				arg_29_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")
				arg_29_0.narr_item_content.text = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(711190108).content)

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
	Play711190109 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 711190109
		arg_33_1.duration_ = 1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play711190110(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_33_0, arg_33_1.narrativeGo_)

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_0 = Object.Instantiate(arg_33_1.narrativeItemGo_)
				local var_36_1 = var_36_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_33_0, var_36_0)

				arg_33_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1119")
				arg_33_0.narr_item_content.text = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(711190109).content)

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
	Play711190110 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 711190110
		arg_37_1.duration_ = 1

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play711190111(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_37_0, arg_37_1.narrativeGo_)

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_0 = Object.Instantiate(arg_37_1.narrativeItemGo_)
				local var_40_1 = var_40_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_37_0, var_40_0)

				arg_37_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")
				arg_37_0.narr_item_content.text = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(711190110).content)

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
	Play711190111 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 711190111
		arg_41_1.duration_ = 1

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play711190112(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_41_0, arg_41_1.narrativeGo_)

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_0 = Object.Instantiate(arg_41_1.narrativeItemGo_)
				local var_44_1 = var_44_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_41_0, var_44_0)

				arg_41_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")
				arg_41_0.narr_item_content.text = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(711190111).content)

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
	Play711190112 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 711190112
		arg_45_1.duration_ = 1.03

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
			arg_45_1.auto_ = false
		end

		function arg_45_1.playNext_(arg_47_0)
			arg_45_1.onStoryFinished_()
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_45_0, arg_45_1.narrativeGo_)

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_0 = Object.Instantiate(arg_45_1.narrativeItemGo_)
				local var_48_1 = var_48_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_45_0, var_48_0)

				arg_45_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1119")
				arg_45_0.narr_item_content.text = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(711190112).content)

				var_48_0.transform:SetParent(arg_45_1.narrativeItemGo_.transform.parent)

				var_48_0.transform.localPosition = Vector3(0, 0, 0)
				var_48_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_48_0, true)
			end

			local var_48_2 = 1

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and arg_45_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_45_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_45_0, arg_45_1.narrativeGo_)

			if 1 < arg_45_1.time_ and arg_45_1.time_ <= 1 + arg_48_0 then
				-- block empty
			end

			local var_48_3 = 0.0334

			if 1 <= arg_45_1.time_ and arg_45_1.time_ < 1 + var_48_3 and arg_45_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_45_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_45_1.time_ >= 1 + var_48_3 and arg_45_1.time_ < 1 + var_48_3 + arg_48_0 then
				arg_45_1.narrativeListGo_.movementType = ScrollRect.MovementType.Elastic

				local var_48_4 = arg_45_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_48_4 then
					var_48_4.raycastTarget = true
				end

				SetActive(arg_45_1.narrativeContinueBtn_.gameObject, true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
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
		"story_1015",
		711190101
	},
	{
		"story_1119",
		711190102
	},
	{
		"story_1015",
		711190103
	},
	{
		"story_1119",
		711190104
	},
	{
		"story_1015",
		711190105
	},
	{
		"story_1119",
		711190106
	},
	{
		"story_1015",
		711190107
	},
	{
		"story_1015",
		711190108
	},
	{
		"story_1119",
		711190109
	},
	{
		"story_1015",
		711190110
	},
	{
		"story_1015",
		711190111
	},
	{
		"story_1119",
		711190112
	}
}

return var_0_0
