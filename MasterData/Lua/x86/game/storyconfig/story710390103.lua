local var_0_0 = {
	Play710390301 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 710390301
		arg_1_1.duration_ = 1.03

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play710390302(arg_1_1)
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

			if 0.0334 < arg_1_1.time_ and arg_1_1.time_ <= 0.0334 + arg_4_0 then
				local var_4_6 = Object.Instantiate(arg_1_1.narrativeItemGo_)
				local var_4_7 = var_4_6:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_1_0, var_4_6)

				arg_1_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_1_0.narr_item_content.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(710390301).content)

				var_4_6.transform:SetParent(arg_1_1.narrativeItemGo_.transform.parent)

				var_4_6.transform.localPosition = Vector3(0, 0, 0)
				var_4_6.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_4_6, true)
			end

			local var_4_8 = 1

			if 0.0334 <= arg_1_1.time_ and arg_1_1.time_ < 0.0334 + var_4_8 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= 0.0334 + var_4_8 and arg_1_1.time_ < 0.0334 + var_4_8 + arg_4_0 then
				-- block empty
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play710390302 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 710390302
		arg_5_1.duration_ = 1

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play710390303(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_1.narrativeGo_)

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				local var_8_0 = Object.Instantiate(arg_5_1.narrativeItemGo_)
				local var_8_1 = var_8_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_5_0, var_8_0)

				arg_5_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				arg_5_0.narr_item_content.text = arg_5_1:FormatText(arg_5_1:GetWordFromCfg(710390302).content)

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
	Play710390303 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 710390303
		arg_9_1.duration_ = 1

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play710390304(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_9_0, arg_9_1.narrativeGo_)

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_0 = Object.Instantiate(arg_9_1.narrativeItemGo_)
				local var_12_1 = var_12_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_9_0, var_12_0)

				arg_9_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_9_0.narr_item_content.text = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(710390303).content)

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
	Play710390304 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 710390304
		arg_13_1.duration_ = 1

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play710390305(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_13_0, arg_13_1.narrativeGo_)

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_0 = Object.Instantiate(arg_13_1.narrativeItemGo_)
				local var_16_1 = var_16_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_13_0, var_16_0)

				arg_13_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_13_0.narr_item_content.text = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(710390304).content)

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
	Play710390305 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 710390305
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play710390306(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_17_0, arg_17_1.narrativeGo_)

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_0 = Object.Instantiate(arg_17_1.narrativeItemGo_)
				local var_20_1 = var_20_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_17_0, var_20_0)

				arg_17_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_17_0.narr_item_content.text = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(710390305).content)

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
	Play710390306 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 710390306
		arg_21_1.duration_ = 1

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play710390307(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_21_0, arg_21_1.narrativeGo_)

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_0 = Object.Instantiate(arg_21_1.narrativeItemGo_)
				local var_24_1 = var_24_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_21_0, var_24_0)
				SetActive(arg_21_0.narr_item_head.transform.parent.gameObject, false)

				local var_24_2 = var_24_0.transform:Find("container/a")
				local var_24_3 = var_24_0.transform:Find("container/b")
				local var_24_4 = var_24_0.transform:Find("container/text")

				if var_24_2 and var_24_3 and var_24_4 then
					SetActive(var_24_2.gameObject, false)
					SetActive(var_24_3.gameObject, false)
					SetActive(var_24_4.gameObject, false)
				end

				arg_21_0.narr_item_content.text = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(710390306).content)

				var_24_0.transform:SetParent(arg_21_1.narrativeItemGo_.transform.parent)

				var_24_0.transform.localPosition = Vector3(0, 0, 0)
				var_24_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_24_0, true)
			end

			local var_24_5 = 1

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and arg_21_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_21_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 then
				-- block empty
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play710390307 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 710390307
		arg_25_1.duration_ = 1

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play710390308(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_25_0, arg_25_1.narrativeGo_)

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_0 = Object.Instantiate(arg_25_1.narrativeItemGo_)
				local var_28_1 = var_28_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_25_0, var_28_0)

				arg_25_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				arg_25_0.narr_item_content.text = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(710390307).content)

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
	Play710390308 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 710390308
		arg_29_1.duration_ = 1

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play710390309(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_29_0, arg_29_1.narrativeGo_)

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_0 = Object.Instantiate(arg_29_1.narrativeItemGo_)
				local var_32_1 = var_32_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_29_0, var_32_0)

				arg_29_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				arg_29_0.narr_item_content.text = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(710390308).content)

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
	Play710390309 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 710390309
		arg_33_1.duration_ = 1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play710390310(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_33_0, arg_33_1.narrativeGo_)

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_0 = Object.Instantiate(arg_33_1.narrativeItemGo_)
				local var_36_1 = var_36_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_33_0, var_36_0)

				arg_33_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				arg_33_0.narr_item_content.text = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(710390309).content)

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
	Play710390310 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 710390310
		arg_37_1.duration_ = 1

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play710390311(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_37_0, arg_37_1.narrativeGo_)

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_0 = Object.Instantiate(arg_37_1.narrativeItemGo_)
				local var_40_1 = var_40_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_37_0, var_40_0)

				arg_37_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_37_0.narr_item_content.text = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(710390310).content)

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
	Play710390311 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 710390311
		arg_41_1.duration_ = 1

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play710390312(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_41_0, arg_41_1.narrativeGo_)

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_0 = Object.Instantiate(arg_41_1.narrativeItemGo_)
				local var_44_1 = var_44_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_41_0, var_44_0)

				arg_41_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				arg_41_0.narr_item_content.text = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(710390311).content)

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
	Play710390312 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 710390312
		arg_45_1.duration_ = 1

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play710390313(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_45_0, arg_45_1.narrativeGo_)

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_0 = Object.Instantiate(arg_45_1.narrativeItemGo_)
				local var_48_1 = var_48_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_45_0, var_48_0)

				arg_45_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_45_0.narr_item_content.text = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(710390312).content)

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
	Play710390313 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 710390313
		arg_49_1.duration_ = 1

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play710390314(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_49_0, arg_49_1.narrativeGo_)

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				local var_52_0 = Object.Instantiate(arg_49_1.narrativeItemGo_)
				local var_52_1 = var_52_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_49_0, var_52_0)

				arg_49_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				arg_49_0.narr_item_content.text = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(710390313).content)

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
	Play710390314 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 710390314
		arg_53_1.duration_ = 1

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play710390315(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_53_0, arg_53_1.narrativeGo_)

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				local var_56_0 = Object.Instantiate(arg_53_1.narrativeItemGo_)
				local var_56_1 = var_56_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_53_0, var_56_0)

				arg_53_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				arg_53_0.narr_item_content.text = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(710390314).content)

				var_56_0.transform:SetParent(arg_53_1.narrativeItemGo_.transform.parent)

				var_56_0.transform.localPosition = Vector3(0, 0, 0)
				var_56_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_56_0, true)
			end

			local var_56_2 = 1

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and arg_53_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_53_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 then
				-- block empty
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play710390315 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 710390315
		arg_57_1.duration_ = 1

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play710390316(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_57_0, arg_57_1.narrativeGo_)

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				local var_60_0 = Object.Instantiate(arg_57_1.narrativeItemGo_)
				local var_60_1 = var_60_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_57_0, var_60_0)

				arg_57_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_57_0.narr_item_content.text = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(710390315).content)

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
	Play710390316 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 710390316
		arg_61_1.duration_ = 1

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play710390317(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_61_0, arg_61_1.narrativeGo_)

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_0 = Object.Instantiate(arg_61_1.narrativeItemGo_)
				local var_64_1 = var_64_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_61_0, var_64_0)

				arg_61_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				arg_61_0.narr_item_content.text = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(710390316).content)

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
	Play710390317 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 710390317
		arg_65_1.duration_ = 1

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play710390318(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_65_0, arg_65_1.narrativeGo_)

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				local var_68_0 = Object.Instantiate(arg_65_1.narrativeItemGo_)
				local var_68_1 = var_68_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_65_0, var_68_0)

				arg_65_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				arg_65_0.narr_item_content.text = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(710390317).content)

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
	Play710390318 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 710390318
		arg_69_1.duration_ = 1

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play710390319(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_69_0, arg_69_1.narrativeGo_)

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_0 = Object.Instantiate(arg_69_1.narrativeItemGo_)
				local var_72_1 = var_72_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_69_0, var_72_0)

				arg_69_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")
				arg_69_0.narr_item_content.text = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(710390318).content)

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
	Play710390319 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 710390319
		arg_73_1.duration_ = 1

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play710390320(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_73_0, arg_73_1.narrativeGo_)

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				local var_76_0 = Object.Instantiate(arg_73_1.narrativeItemGo_)
				local var_76_1 = var_76_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_73_0, var_76_0)

				arg_73_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				arg_73_0.narr_item_content.text = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(710390319).content)

				var_76_0.transform:SetParent(arg_73_1.narrativeItemGo_.transform.parent)

				var_76_0.transform.localPosition = Vector3(0, 0, 0)
				var_76_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_76_0, true)
			end

			local var_76_2 = 1

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and arg_73_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_73_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 then
				-- block empty
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play710390320 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 710390320
		arg_77_1.duration_ = 1.03

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
			arg_77_1.auto_ = false
		end

		function arg_77_1.playNext_(arg_79_0)
			arg_77_1.onStoryFinished_()
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_77_0, arg_77_1.narrativeGo_)

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				local var_80_0 = Object.Instantiate(arg_77_1.narrativeItemGo_)
				local var_80_1 = var_80_0:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_77_0, var_80_0)
				SetActive(arg_77_0.narr_item_head.transform.parent.gameObject, false)

				local var_80_2 = var_80_0.transform:Find("container/a")
				local var_80_3 = var_80_0.transform:Find("container/b")
				local var_80_4 = var_80_0.transform:Find("container/text")

				if var_80_2 and var_80_3 and var_80_4 then
					SetActive(var_80_2.gameObject, false)
					SetActive(var_80_3.gameObject, false)
					SetActive(var_80_4.gameObject, false)
				end

				arg_77_0.narr_item_content.text = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(710390320).content)

				var_80_0.transform:SetParent(arg_77_1.narrativeItemGo_.transform.parent)

				var_80_0.transform.localPosition = Vector3(0, 0, 0)
				var_80_0.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_80_0, true)
			end

			local var_80_5 = 1

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 and arg_77_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_77_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_77_0, arg_77_1.narrativeGo_)

			if 1 < arg_77_1.time_ and arg_77_1.time_ <= 1 + arg_80_0 then
				-- block empty
			end

			local var_80_6 = 0.0334

			if 1 <= arg_77_1.time_ and arg_77_1.time_ < 1 + var_80_6 and arg_77_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_77_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_77_1.time_ >= 1 + var_80_6 and arg_77_1.time_ < 1 + var_80_6 + arg_80_0 then
				arg_77_1.narrativeListGo_.movementType = ScrollRect.MovementType.Elastic

				local var_80_7 = arg_77_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_80_7 then
					var_80_7.raycastTarget = true
				end

				SetActive(arg_77_1.narrativeContinueBtn_.gameObject, true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
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
		"story_1039",
		710390301
	},
	{
		"story_1019",
		710390302
	},
	{
		"story_1039",
		710390303
	},
	{
		"story_1039",
		710390304
	},
	{
		"story_1039",
		710390305
	},
	{
		"",
		710390306
	},
	{
		"story_1019",
		710390307
	},
	{
		"story_1019",
		710390308
	},
	{
		"story_1019",
		710390309
	},
	{
		"story_1039",
		710390310
	},
	{
		"story_1019",
		710390311
	},
	{
		"story_1039",
		710390312
	},
	{
		"story_1019",
		710390313
	},
	{
		"story_1019",
		710390314
	},
	{
		"story_1039",
		710390315
	},
	{
		"story_1019",
		710390316
	},
	{
		"story_1019",
		710390317
	},
	{
		"story_1039",
		710390318
	},
	{
		"story_1019",
		710390319
	},
	{
		"",
		710390320
	}
}

return var_0_0
