local var_0_0 = {
	Play710240301 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 710240301
		arg_1_1.duration_ = 1.03

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play710240302(arg_1_1)
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

				arg_1_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_1_0.narr_item_content.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(710240301).content)

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
	Play710240302 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 710240302
		arg_5_1.duration_ = 1

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play710240303(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_1.narrativeGo_)

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				local var_8_0 = Object.Instantiate(arg_5_1.narrativeItemGo_)
				local var_8_1 = var_8_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_5_0, var_8_0)

				arg_5_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_5_0.narr_item_content.text = arg_5_1:FormatText(arg_5_1:GetWordFromCfg(710240302).content)

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
	Play710240303 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 710240303
		arg_9_1.duration_ = 1

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play710240304(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_9_0, arg_9_1.narrativeGo_)

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_0 = Object.Instantiate(arg_9_1.narrativeItemGo_)
				local var_12_1 = var_12_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_9_0, var_12_0)
				SetActive(arg_9_0.narr_item_head.transform.parent.gameObject, false)

				local var_12_2 = var_12_0.transform:Find("container/a")
				local var_12_3 = var_12_0.transform:Find("container/b")
				local var_12_4 = var_12_0.transform:Find("container/text")

				if var_12_2 and var_12_3 and var_12_4 then
					SetActive(var_12_2.gameObject, false)
					SetActive(var_12_3.gameObject, false)
					SetActive(var_12_4.gameObject, false)
				end

				arg_9_0.narr_item_content.text = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(710240303).content)

				var_12_0.transform:SetParent(arg_9_1.narrativeItemGo_.transform.parent)

				var_12_0.transform.localPosition = Vector3(0, 0, 0)
				var_12_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_12_0, true)
			end

			local var_12_5 = 1

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_5 and arg_9_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_9_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_9_1.time_ >= 0 + var_12_5 and arg_9_1.time_ < 0 + var_12_5 + arg_12_0 then
				-- block empty
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play710240304 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 710240304
		arg_13_1.duration_ = 1

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play710240305(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_13_0, arg_13_1.narrativeGo_)

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_0 = Object.Instantiate(arg_13_1.narrativeItemGo_)
				local var_16_1 = var_16_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_13_0, var_16_0)
				SetActive(arg_13_0.narr_item_head.transform.parent.gameObject, false)

				local var_16_2 = var_16_0.transform:Find("container/a")
				local var_16_3 = var_16_0.transform:Find("container/b")
				local var_16_4 = var_16_0.transform:Find("container/text")

				if var_16_2 and var_16_3 and var_16_4 then
					SetActive(var_16_2.gameObject, false)
					SetActive(var_16_3.gameObject, false)
					SetActive(var_16_4.gameObject, false)
				end

				arg_13_0.narr_item_content.text = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(710240304).content)

				var_16_0.transform:SetParent(arg_13_1.narrativeItemGo_.transform.parent)

				var_16_0.transform.localPosition = Vector3(0, 0, 0)
				var_16_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_16_0, true)
			end

			local var_16_5 = 1

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 and arg_13_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_13_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 then
				-- block empty
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play710240305 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 710240305
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play710240306(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_17_0, arg_17_1.narrativeGo_)

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_0 = Object.Instantiate(arg_17_1.narrativeItemGo_)
				local var_20_1 = var_20_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_17_0, var_20_0)

				arg_17_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_17_0.narr_item_content.text = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(710240305).content)

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
	Play710240306 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 710240306
		arg_21_1.duration_ = 1

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play710240307(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_21_0, arg_21_1.narrativeGo_)

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_0 = Object.Instantiate(arg_21_1.narrativeItemGo_)
				local var_24_1 = var_24_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_21_0, var_24_0)

				arg_21_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")
				arg_21_0.narr_item_content.text = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(710240306).content)

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
	Play710240307 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 710240307
		arg_25_1.duration_ = 1

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play710240308(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_25_0, arg_25_1.narrativeGo_)

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_0 = Object.Instantiate(arg_25_1.narrativeItemGo_)
				local var_28_1 = var_28_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_25_0, var_28_0)

				arg_25_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_25_0.narr_item_content.text = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(710240307).content)

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
	Play710240308 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 710240308
		arg_29_1.duration_ = 1

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play710240309(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_29_0, arg_29_1.narrativeGo_)

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_0 = Object.Instantiate(arg_29_1.narrativeItemGo_)
				local var_32_1 = var_32_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_29_0, var_32_0)

				arg_29_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_29_0.narr_item_content.text = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(710240308).content)

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
	Play710240309 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 710240309
		arg_33_1.duration_ = 1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play710240310(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_33_0, arg_33_1.narrativeGo_)

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_0 = Object.Instantiate(arg_33_1.narrativeItemGo_)
				local var_36_1 = var_36_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_33_0, var_36_0)

				arg_33_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")
				arg_33_0.narr_item_content.text = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(710240309).content)

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
	Play710240310 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 710240310
		arg_37_1.duration_ = 1

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play710240311(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_37_0, arg_37_1.narrativeGo_)

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_0 = Object.Instantiate(arg_37_1.narrativeItemGo_)
				local var_40_1 = var_40_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_37_0, var_40_0)

				arg_37_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_37_0.narr_item_content.text = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(710240310).content)

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
	Play710240311 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 710240311
		arg_41_1.duration_ = 1

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play710240312(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_41_0, arg_41_1.narrativeGo_)

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_0 = Object.Instantiate(arg_41_1.narrativeItemGo_)
				local var_44_1 = var_44_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_41_0, var_44_0)

				arg_41_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")
				arg_41_0.narr_item_content.text = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(710240311).content)

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
	Play710240312 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 710240312
		arg_45_1.duration_ = 1

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play710240313(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_45_0, arg_45_1.narrativeGo_)

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_0 = Object.Instantiate(arg_45_1.narrativeItemGo_)
				local var_48_1 = var_48_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_45_0, var_48_0)

				arg_45_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_45_0.narr_item_content.text = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(710240312).content)

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
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play710240313 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 710240313
		arg_49_1.duration_ = 1

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play710240314(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_49_0, arg_49_1.narrativeGo_)

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				local var_52_0 = Object.Instantiate(arg_49_1.narrativeItemGo_)
				local var_52_1 = var_52_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_49_0, var_52_0)
				SetActive(arg_49_0.narr_item_head.transform.parent.gameObject, false)

				local var_52_2 = var_52_0.transform:Find("container/a")
				local var_52_3 = var_52_0.transform:Find("container/b")
				local var_52_4 = var_52_0.transform:Find("container/text")

				if var_52_2 and var_52_3 and var_52_4 then
					SetActive(var_52_2.gameObject, false)
					SetActive(var_52_3.gameObject, false)
					SetActive(var_52_4.gameObject, false)
				end

				arg_49_0.narr_item_content.text = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(710240313).content)

				var_52_0.transform:SetParent(arg_49_1.narrativeItemGo_.transform.parent)

				var_52_0.transform.localPosition = Vector3(0, 0, 0)
				var_52_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_52_0, true)
			end

			local var_52_5 = 1

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and arg_49_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_49_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 then
				-- block empty
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play710240314 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 710240314
		arg_53_1.duration_ = 1

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play710240315(arg_53_1)
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

				arg_53_0.narr_item_content.text = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(710240314).content)

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
	Play710240315 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 710240315
		arg_57_1.duration_ = 1

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play710240316(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_57_0, arg_57_1.narrativeGo_)

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				local var_60_0 = Object.Instantiate(arg_57_1.narrativeItemGo_)
				local var_60_1 = var_60_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_57_0, var_60_0)

				arg_57_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")
				arg_57_0.narr_item_content.text = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(710240315).content)

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
	Play710240316 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 710240316
		arg_61_1.duration_ = 1

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play710240317(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_61_0, arg_61_1.narrativeGo_)

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_0 = Object.Instantiate(arg_61_1.narrativeItemGo_)
				local var_64_1 = var_64_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_61_0, var_64_0)

				arg_61_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_61_0.narr_item_content.text = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(710240316).content)

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
	Play710240317 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 710240317
		arg_65_1.duration_ = 1

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play710240318(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_65_0, arg_65_1.narrativeGo_)

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				local var_68_0 = Object.Instantiate(arg_65_1.narrativeItemGo_)
				local var_68_1 = var_68_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_65_0, var_68_0)

				arg_65_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")
				arg_65_0.narr_item_content.text = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(710240317).content)

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
	Play710240318 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 710240318
		arg_69_1.duration_ = 1

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play710240319(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_69_0, arg_69_1.narrativeGo_)

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_0 = Object.Instantiate(arg_69_1.narrativeItemGo_)
				local var_72_1 = var_72_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_69_0, var_72_0)

				arg_69_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_69_0.narr_item_content.text = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(710240318).content)

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
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play710240319 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 710240319
		arg_73_1.duration_ = 1

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play710240320(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_73_0, arg_73_1.narrativeGo_)

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				local var_76_0 = Object.Instantiate(arg_73_1.narrativeItemGo_)
				local var_76_1 = var_76_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_73_0, var_76_0)
				SetActive(arg_73_0.narr_item_head.transform.parent.gameObject, false)

				local var_76_2 = var_76_0.transform:Find("container/a")
				local var_76_3 = var_76_0.transform:Find("container/b")
				local var_76_4 = var_76_0.transform:Find("container/text")

				if var_76_2 and var_76_3 and var_76_4 then
					SetActive(var_76_2.gameObject, false)
					SetActive(var_76_3.gameObject, false)
					SetActive(var_76_4.gameObject, false)
				end

				arg_73_0.narr_item_content.text = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(710240319).content)

				var_76_0.transform:SetParent(arg_73_1.narrativeItemGo_.transform.parent)

				var_76_0.transform.localPosition = Vector3(0, 0, 0)
				var_76_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_76_0, true)
			end

			local var_76_5 = 1

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 and arg_73_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_73_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 then
				-- block empty
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play710240320 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 710240320
		arg_77_1.duration_ = 1

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play710240321(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_77_0, arg_77_1.narrativeGo_)

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				local var_80_0 = Object.Instantiate(arg_77_1.narrativeItemGo_)
				local var_80_1 = var_80_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_77_0, var_80_0)

				arg_77_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_77_0.narr_item_content.text = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(710240320).content)

				var_80_0.transform:SetParent(arg_77_1.narrativeItemGo_.transform.parent)

				var_80_0.transform.localPosition = Vector3(0, 0, 0)
				var_80_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_80_0, true)
			end

			local var_80_2 = 1

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and arg_77_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_77_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 then
				-- block empty
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play710240321 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 710240321
		arg_81_1.duration_ = 1

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play710240322(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_81_0, arg_81_1.narrativeGo_)

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				local var_84_0 = Object.Instantiate(arg_81_1.narrativeItemGo_)
				local var_84_1 = var_84_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_81_0, var_84_0)

				arg_81_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")
				arg_81_0.narr_item_content.text = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(710240321).content)

				var_84_0.transform:SetParent(arg_81_1.narrativeItemGo_.transform.parent)

				var_84_0.transform.localPosition = Vector3(0, 0, 0)
				var_84_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_84_0, true)
			end

			local var_84_2 = 1

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and arg_81_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_81_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 then
				-- block empty
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play710240322 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 710240322
		arg_85_1.duration_ = 1

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play710240323(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_85_0, arg_85_1.narrativeGo_)

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				local var_88_0 = Object.Instantiate(arg_85_1.narrativeItemGo_)
				local var_88_1 = var_88_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_85_0, var_88_0)

				arg_85_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_85_0.narr_item_content.text = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(710240322).content)

				var_88_0.transform:SetParent(arg_85_1.narrativeItemGo_.transform.parent)

				var_88_0.transform.localPosition = Vector3(0, 0, 0)
				var_88_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_88_0, true)
			end

			local var_88_2 = 1

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and arg_85_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_85_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 then
				-- block empty
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play710240323 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 710240323
		arg_89_1.duration_ = 1

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play710240324(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_89_0, arg_89_1.narrativeGo_)

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				local var_92_0 = Object.Instantiate(arg_89_1.narrativeItemGo_)
				local var_92_1 = var_92_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_89_0, var_92_0)

				arg_89_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_89_0.narr_item_content.text = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(710240323).content)

				var_92_0.transform:SetParent(arg_89_1.narrativeItemGo_.transform.parent)

				var_92_0.transform.localPosition = Vector3(0, 0, 0)
				var_92_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_92_0, true)
			end

			local var_92_2 = 1

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and arg_89_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_89_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 then
				-- block empty
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play710240324 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 710240324
		arg_93_1.duration_ = 1

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play710240325(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_93_0, arg_93_1.narrativeGo_)

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				local var_96_0 = Object.Instantiate(arg_93_1.narrativeItemGo_)
				local var_96_1 = var_96_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_93_0, var_96_0)

				arg_93_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")
				arg_93_0.narr_item_content.text = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(710240324).content)

				var_96_0.transform:SetParent(arg_93_1.narrativeItemGo_.transform.parent)

				var_96_0.transform.localPosition = Vector3(0, 0, 0)
				var_96_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_96_0, true)
			end

			local var_96_2 = 1

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and arg_93_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_93_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 then
				-- block empty
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play710240325 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 710240325
		arg_97_1.duration_ = 1.03

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
			arg_97_1.auto_ = false
		end

		function arg_97_1.playNext_(arg_99_0)
			arg_97_1.onStoryFinished_()
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_97_0, arg_97_1.narrativeGo_)

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				local var_100_0 = Object.Instantiate(arg_97_1.narrativeItemGo_)
				local var_100_1 = var_100_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_97_0, var_100_0)
				SetActive(arg_97_0.narr_item_head.transform.parent.gameObject, false)

				local var_100_2 = var_100_0.transform:Find("container/a")
				local var_100_3 = var_100_0.transform:Find("container/b")
				local var_100_4 = var_100_0.transform:Find("container/text")

				if var_100_2 and var_100_3 and var_100_4 then
					SetActive(var_100_2.gameObject, false)
					SetActive(var_100_3.gameObject, false)
					SetActive(var_100_4.gameObject, false)
				end

				arg_97_0.narr_item_content.text = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(710240325).content)

				var_100_0.transform:SetParent(arg_97_1.narrativeItemGo_.transform.parent)

				var_100_0.transform.localPosition = Vector3(0, 0, 0)
				var_100_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_100_0, true)
			end

			local var_100_5 = 1

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 and arg_97_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_97_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_97_0, arg_97_1.narrativeGo_)

			if 1 < arg_97_1.time_ and arg_97_1.time_ <= 1 + arg_100_0 then
				-- block empty
			end

			local var_100_6 = 0.0334

			if 1 <= arg_97_1.time_ and arg_97_1.time_ < 1 + var_100_6 and arg_97_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_97_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_97_1.time_ >= 1 + var_100_6 and arg_97_1.time_ < 1 + var_100_6 + arg_100_0 then
				arg_97_1.narrativeListGo_.movementType = ScrollRect.MovementType.Elastic

				local var_100_7 = arg_97_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_100_7 then
					var_100_7.raycastTarget = true
				end

				SetActive(arg_97_1.narrativeContinueBtn_.gameObject, true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
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
		"story_1024",
		710240301
	},
	{
		"story_1024",
		710240302
	},
	{
		"",
		710240303
	},
	{
		"",
		710240304
	},
	{
		"story_1024",
		710240305
	},
	{
		"story_1035",
		710240306
	},
	{
		"story_1024",
		710240307
	},
	{
		"story_1024",
		710240308
	},
	{
		"story_1035",
		710240309
	},
	{
		"story_1024",
		710240310
	},
	{
		"story_1035",
		710240311
	},
	{
		"story_1024",
		710240312
	},
	{
		"",
		710240313
	},
	{
		"",
		710240314
	},
	{
		"story_1035",
		710240315
	},
	{
		"story_1024",
		710240316
	},
	{
		"story_1035",
		710240317
	},
	{
		"story_1024",
		710240318
	},
	{
		"",
		710240319
	},
	{
		"story_1024",
		710240320
	},
	{
		"story_1035",
		710240321
	},
	{
		"story_1024",
		710240322
	},
	{
		"story_1024",
		710240323
	},
	{
		"story_1024",
		710240324
	},
	{
		"",
		710240325
	}
}

return var_0_0
