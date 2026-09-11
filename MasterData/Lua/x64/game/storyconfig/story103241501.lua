return {
	Play324151001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324151001
		arg_1_1.duration_ = 3.9

		local var_1_0 = {
			zh = 3.5,
			ja = 3.9
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324151002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9001
			local var_4_9000

			if arg_1_1.bgs_.ST31 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_4_0.name = "ST31"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST31 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST31

				arg_1_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST31" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_9 = arg_1_1.var_.effect2323

				if not arg_1_1.var_.effect2323 then
					var_4_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_soundonly_keep"), manager.ui.mainCamera.transform)
					var_4_9.name = "2323"
					arg_1_1.var_.effect2323 = var_4_9
				else
					var_4_9.transform:SetParent(var_4_9001)
				end

				var_4_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_11 = arg_1_1.var_.effect3242

				if not arg_1_1.var_.effect3242 then
					var_4_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), manager.ui.mainCamera.transform)
					var_4_11.name = "3242"
					arg_1_1.var_.effect3242 = var_4_11
				else
					var_4_11.transform:SetParent(var_4_9000)
				end

				var_4_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_4_11.transform.localScale = Vector3.New(var_4_11.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_4_11.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_4_11.transform.localScale.z)
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_wind", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 1.3
			local var_4_16 = 0.2

			if 1.3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:GetWordFromCfg(324151001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 8 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 8)

				if (8 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 8)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151001", "story_v_out_324151.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_324151", "324151001", "story_v_out_324151.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_324151", "324151001", "story_v_out_324151.awb")

						arg_1_1:RecordAudio("324151001", var_4_23)
						arg_1_1:RecordAudio("324151001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324151", "324151001", "story_v_out_324151.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324151", "324151001", "story_v_out_324151.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324151002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 324151002
		arg_7_1.duration_ = 3.07

		local var_7_0 = {
			zh = 2.63333333333333,
			ja = 3.06633333333333
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play324151003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.bgs_.ST47 == nil then
				local var_10_0 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST47")
				var_10_0.name = "ST47"
				var_10_0.transform.parent = arg_7_1.stage_.transform
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_.ST47 = var_10_0
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_1 = arg_7_1.bgs_.ST47

				arg_7_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_10_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_2 = var_10_1:GetComponent("SpriteRenderer")

				if var_10_2 and var_10_2.sprite then
					local var_10_3 = 2 * (var_10_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_10_1.transform.localScale = Vector3.New(var_10_3 / var_10_2.sprite.bounds.size.y < var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x and var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x or var_10_3 / var_10_2.sprite.bounds.size.y, var_10_3 / var_10_2.sprite.bounds.size.y < var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x and var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x or var_10_3 / var_10_2.sprite.bounds.size.y, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "ST47" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_4 = 0

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_4 + arg_10_0 then
				arg_7_1.allBtn_.enabled = false
			end

			if arg_7_1.time_ >= var_10_4 + 0.3 and arg_7_1.time_ < var_10_4 + 0.3 + arg_10_0 then
				arg_7_1.allBtn_.enabled = true
			end

			local var_10_5 = 0

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_5 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_6 = 1

			if var_10_5 <= arg_7_1.time_ and arg_7_1.time_ < var_10_5 + var_10_6 then
				local var_10_7 = Color.New(0, 0, 0)

				var_10_7.a = Mathf.Lerp(1, 0, (arg_7_1.time_ - var_10_5) / var_10_6)
				arg_7_1.mask_.color = var_10_7
			end

			if arg_7_1.time_ >= var_10_5 + var_10_6 and arg_7_1.time_ < var_10_5 + var_10_6 + arg_10_0 then
				local var_10_8 = Color.New(0, 0, 0)

				arg_7_1.mask_.enabled = false
				var_10_8.a = 0
				arg_7_1.mask_.color = var_10_8
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_9 = 0.433333333333333
			local var_10_10 = 0.2

			if 0.433333333333333 < arg_7_1.time_ and arg_7_1.time_ <= var_10_9 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_11 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_11:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_12 = arg_7_1:GetWordFromCfg(324151002)
				local var_10_13 = arg_7_1:FormatText(var_10_12.content)

				arg_7_1.text_.text = var_10_13

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_15 = 8 <= 0 and var_10_10 or var_10_10 * (utf8.len(var_10_13) / 8)

				if (8 <= 0 and var_10_10 or var_10_10 * (utf8.len(var_10_13) / 8)) > 0 and var_10_10 < var_10_15 then
					arg_7_1.talkMaxDuration = var_10_15
					var_10_9 = var_10_9 + 0.3

					if var_10_15 + var_10_9 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_15 + var_10_9
					end
				end

				arg_7_1.text_.text = var_10_13
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151002", "story_v_out_324151.awb") ~= 0 then
					local var_10_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151002", "story_v_out_324151.awb") / 1000

					if var_10_16 + var_10_9 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_16 + var_10_9
					end

					if var_10_12.prefab_name ~= "" and arg_7_1.actors_[var_10_12.prefab_name] ~= nil then
						local var_10_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_12.prefab_name].transform, "story_v_out_324151", "324151002", "story_v_out_324151.awb")

						arg_7_1:RecordAudio("324151002", var_10_17)
						arg_7_1:RecordAudio("324151002", var_10_17)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_324151", "324151002", "story_v_out_324151.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_324151", "324151002", "story_v_out_324151.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_18 = var_10_9 + 0.3
			local var_10_19 = math.max(var_10_10, arg_7_1.talkMaxDuration)

			if var_10_9 + 0.3 <= arg_7_1.time_ and arg_7_1.time_ < var_10_18 + var_10_19 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_18) / var_10_19

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_18 + var_10_19 and arg_7_1.time_ < var_10_18 + var_10_19 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play324151003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 324151003
		arg_13_1.duration_ = 3.63

		local var_13_0 = {
			zh = 3.2,
			ja = 3.633
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play324151004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.bgs_.J02 == nil then
				local var_16_0 = Object.Instantiate(arg_13_1.paintGo_)

				var_16_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J02")
				var_16_0.name = "J02"
				var_16_0.transform.parent = arg_13_1.stage_.transform
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.bgs_.J02 = var_16_0
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_1 = arg_13_1.bgs_.J02

				arg_13_1.bgs_.J02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_16_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_16_2 = var_16_1:GetComponent("SpriteRenderer")

				if var_16_2 and var_16_2.sprite then
					local var_16_3 = 2 * (var_16_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_16_1.transform.localScale = Vector3.New(var_16_3 / var_16_2.sprite.bounds.size.y < var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x and var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x or var_16_3 / var_16_2.sprite.bounds.size.y, var_16_3 / var_16_2.sprite.bounds.size.y < var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x and var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x or var_16_3 / var_16_2.sprite.bounds.size.y, 0)
				end

				for iter_16_0, iter_16_1 in pairs(arg_13_1.bgs_) do
					if iter_16_0 ~= "J02" then
						iter_16_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_16_4 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			if arg_13_1.time_ >= var_16_4 + 0.3 and arg_13_1.time_ < var_16_4 + 0.3 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_5 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_6 = 2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 then
				local var_16_7 = Color.New(0, 0, 0)

				var_16_7.a = Mathf.Lerp(1, 0, (arg_13_1.time_ - var_16_5) / var_16_6)
				arg_13_1.mask_.color = var_16_7
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 then
				local var_16_8 = Color.New(0, 0, 0)

				arg_13_1.mask_.enabled = false
				var_16_8.a = 0
				arg_13_1.mask_.color = var_16_8
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_9 = 1
			local var_16_10 = 0.2

			if 1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_11 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_11:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(324151003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 8 <= 0 and var_16_10 or var_16_10 * (utf8.len(var_16_13) / 8)

				if (8 <= 0 and var_16_10 or var_16_10 * (utf8.len(var_16_13) / 8)) > 0 and var_16_10 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15
					var_16_9 = var_16_9 + 0.3

					if var_16_15 + var_16_9 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_9
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151003", "story_v_out_324151.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151003", "story_v_out_324151.awb") / 1000

					if var_16_16 + var_16_9 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_9
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_324151", "324151003", "story_v_out_324151.awb")

						arg_13_1:RecordAudio("324151003", var_16_17)
						arg_13_1:RecordAudio("324151003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_324151", "324151003", "story_v_out_324151.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_324151", "324151003", "story_v_out_324151.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = var_16_9 + 0.3
			local var_16_19 = math.max(var_16_10, arg_13_1.talkMaxDuration)

			if var_16_9 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_18 + var_16_19 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_18) / var_16_19

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_18 + var_16_19 and arg_13_1.time_ < var_16_18 + var_16_19 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play324151004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 324151004
		arg_19_1.duration_ = 3.03

		local var_19_0 = {
			zh = 2.5,
			ja = 3.033
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play324151005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.bgs_.ST42 == nil then
				local var_22_0 = Object.Instantiate(arg_19_1.paintGo_)

				var_22_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST42")
				var_22_0.name = "ST42"
				var_22_0.transform.parent = arg_19_1.stage_.transform
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.bgs_.ST42 = var_22_0
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				local var_22_1 = arg_19_1.bgs_.ST42

				arg_19_1.bgs_.ST42.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_22_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_22_2 = var_22_1:GetComponent("SpriteRenderer")

				if var_22_2 and var_22_2.sprite then
					local var_22_3 = 2 * (var_22_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_22_1.transform.localScale = Vector3.New(var_22_3 / var_22_2.sprite.bounds.size.y < var_22_3 * manager.ui.mainCameraCom_.aspect / var_22_2.sprite.bounds.size.x and var_22_3 * manager.ui.mainCameraCom_.aspect / var_22_2.sprite.bounds.size.x or var_22_3 / var_22_2.sprite.bounds.size.y, var_22_3 / var_22_2.sprite.bounds.size.y < var_22_3 * manager.ui.mainCameraCom_.aspect / var_22_2.sprite.bounds.size.x and var_22_3 * manager.ui.mainCameraCom_.aspect / var_22_2.sprite.bounds.size.x or var_22_3 / var_22_2.sprite.bounds.size.y, 0)
				end

				for iter_22_0, iter_22_1 in pairs(arg_19_1.bgs_) do
					if iter_22_0 ~= "ST42" then
						iter_22_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_22_4 = 0

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				arg_19_1.allBtn_.enabled = false
			end

			if arg_19_1.time_ >= var_22_4 + 0.3 and arg_19_1.time_ < var_22_4 + 0.3 + arg_22_0 then
				arg_19_1.allBtn_.enabled = true
			end

			local var_22_5 = 0

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_6 = 1

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_6 then
				local var_22_7 = Color.New(0, 0, 0)

				var_22_7.a = Mathf.Lerp(1, 0, (arg_19_1.time_ - var_22_5) / var_22_6)
				arg_19_1.mask_.color = var_22_7
			end

			if arg_19_1.time_ >= var_22_5 + var_22_6 and arg_19_1.time_ < var_22_5 + var_22_6 + arg_22_0 then
				local var_22_8 = Color.New(0, 0, 0)

				arg_19_1.mask_.enabled = false
				var_22_8.a = 0
				arg_19_1.mask_.color = var_22_8
			end

			if arg_19_1.frameCnt_ <= 1 then
				arg_19_1.dialog_:SetActive(false)
			end

			local var_22_9 = 0.3
			local var_22_10 = 0.2

			if 0.3 < arg_19_1.time_ and arg_19_1.time_ <= var_22_9 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				arg_19_1.dialog_:SetActive(true)

				arg_19_1.dialogCg_.alpha = 0

				local var_22_11 = LeanTween.value(arg_19_1.dialog_, 0, 1, 0.3)

				var_22_11:setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
					arg_19_1.dialogCg_.alpha = arg_23_0
				end))
				var_22_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_19_1.dialog_)
					var_22_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_19_1.duration_ = arg_19_1.duration_ + 0.3

				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_12 = arg_19_1:GetWordFromCfg(324151004)
				local var_22_13 = arg_19_1:FormatText(var_22_12.content)

				arg_19_1.text_.text = var_22_13

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_15 = 8 <= 0 and var_22_10 or var_22_10 * (utf8.len(var_22_13) / 8)

				if (8 <= 0 and var_22_10 or var_22_10 * (utf8.len(var_22_13) / 8)) > 0 and var_22_10 < var_22_15 then
					arg_19_1.talkMaxDuration = var_22_15
					var_22_9 = var_22_9 + 0.3

					if var_22_15 + var_22_9 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_15 + var_22_9
					end
				end

				arg_19_1.text_.text = var_22_13
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151004", "story_v_out_324151.awb") ~= 0 then
					local var_22_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151004", "story_v_out_324151.awb") / 1000

					if var_22_16 + var_22_9 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_16 + var_22_9
					end

					if var_22_12.prefab_name ~= "" and arg_19_1.actors_[var_22_12.prefab_name] ~= nil then
						local var_22_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_12.prefab_name].transform, "story_v_out_324151", "324151004", "story_v_out_324151.awb")

						arg_19_1:RecordAudio("324151004", var_22_17)
						arg_19_1:RecordAudio("324151004", var_22_17)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_324151", "324151004", "story_v_out_324151.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_324151", "324151004", "story_v_out_324151.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_18 = var_22_9 + 0.3
			local var_22_19 = math.max(var_22_10, arg_19_1.talkMaxDuration)

			if var_22_9 + 0.3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_18 + var_22_19 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_18) / var_22_19

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_18 + var_22_19 and arg_19_1.time_ < var_22_18 + var_22_19 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play324151005 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 324151005
		arg_25_1.duration_ = 3.37

		local var_25_0 = {
			zh = 2.6,
			ja = 3.366
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play324151006(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.bgs_.J05f == nil then
				local var_28_0 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J05f")
				var_28_0.name = "J05f"
				var_28_0.transform.parent = arg_25_1.stage_.transform
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_.J05f = var_28_0
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_1 = arg_25_1.bgs_.J05f

				arg_25_1.bgs_.J05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_2 = var_28_1:GetComponent("SpriteRenderer")

				if var_28_2 and var_28_2.sprite then
					local var_28_3 = 2 * (var_28_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_1.transform.localScale = Vector3.New(var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "J05f" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_4 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_4 + 0.3 and arg_25_1.time_ < var_28_4 + 0.3 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_5 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_6 = 1.16666666666667

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_6 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_5) / var_28_6)
				arg_25_1.mask_.color = var_28_7
			end

			if arg_25_1.time_ >= var_28_5 + var_28_6 and arg_25_1.time_ < var_28_5 + var_28_6 + arg_28_0 then
				local var_28_8 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_8.a = 0
				arg_25_1.mask_.color = var_28_8
			end

			local var_28_9 = 0
			local var_28_10 = 0.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_11 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_11:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_12 = arg_25_1:GetWordFromCfg(324151005)
				local var_28_13 = arg_25_1:FormatText(var_28_12.content)

				arg_25_1.text_.text = var_28_13

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 9 <= 0 and var_28_10 or var_28_10 * (utf8.len(var_28_13) / 9)

				if (9 <= 0 and var_28_10 or var_28_10 * (utf8.len(var_28_13) / 9)) > 0 and var_28_10 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15
					var_28_9 = var_28_9 + 0.3

					if var_28_15 + var_28_9 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_9
					end
				end

				arg_25_1.text_.text = var_28_13
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151005", "story_v_out_324151.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151005", "story_v_out_324151.awb") / 1000

					if var_28_16 + var_28_9 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_9
					end

					if var_28_12.prefab_name ~= "" and arg_25_1.actors_[var_28_12.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_12.prefab_name].transform, "story_v_out_324151", "324151005", "story_v_out_324151.awb")

						arg_25_1:RecordAudio("324151005", var_28_17)
						arg_25_1:RecordAudio("324151005", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_324151", "324151005", "story_v_out_324151.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_324151", "324151005", "story_v_out_324151.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = var_28_9 + 0.3
			local var_28_19 = math.max(var_28_10, arg_25_1.talkMaxDuration)

			if var_28_9 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_18 + var_28_19 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_18) / var_28_19

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_18 + var_28_19 and arg_25_1.time_ < var_28_18 + var_28_19 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play324151006 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 324151006
		arg_31_1.duration_ = 4.28

		local var_31_0 = {
			zh = 3.841,
			ja = 4.275
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play324151007(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.bgs_.ST2002 == nil then
				local var_34_0 = Object.Instantiate(arg_31_1.paintGo_)

				var_34_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2002")
				var_34_0.name = "ST2002"
				var_34_0.transform.parent = arg_31_1.stage_.transform
				var_34_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.bgs_.ST2002 = var_34_0
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				local var_34_1 = arg_31_1.bgs_.ST2002

				arg_31_1.bgs_.ST2002.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_34_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_34_2 = var_34_1:GetComponent("SpriteRenderer")

				if var_34_2 and var_34_2.sprite then
					local var_34_3 = 2 * (var_34_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_34_1.transform.localScale = Vector3.New(var_34_3 / var_34_2.sprite.bounds.size.y < var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x and var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x or var_34_3 / var_34_2.sprite.bounds.size.y, var_34_3 / var_34_2.sprite.bounds.size.y < var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x and var_34_3 * manager.ui.mainCameraCom_.aspect / var_34_2.sprite.bounds.size.x or var_34_3 / var_34_2.sprite.bounds.size.y, 0)
				end

				for iter_34_0, iter_34_1 in pairs(arg_31_1.bgs_) do
					if iter_34_0 ~= "ST2002" then
						iter_34_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_34_4 = 0

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.allBtn_.enabled = false
			end

			if arg_31_1.time_ >= var_34_4 + 0.3 and arg_31_1.time_ < var_34_4 + 0.3 + arg_34_0 then
				arg_31_1.allBtn_.enabled = true
			end

			local var_34_5 = 0

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_6 = 2

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_6 then
				local var_34_7 = Color.New(0, 0, 0)

				var_34_7.a = Mathf.Lerp(1, 0, (arg_31_1.time_ - var_34_5) / var_34_6)
				arg_31_1.mask_.color = var_34_7
			end

			if arg_31_1.time_ >= var_34_5 + var_34_6 and arg_31_1.time_ < var_34_5 + var_34_6 + arg_34_0 then
				local var_34_8 = Color.New(0, 0, 0)

				arg_31_1.mask_.enabled = false
				var_34_8.a = 0
				arg_31_1.mask_.color = var_34_8
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_9 = 0.775
			local var_34_10 = 0.225

			if 0.775 < arg_31_1.time_ and arg_31_1.time_ <= var_34_9 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_11 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_11:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_12 = arg_31_1:GetWordFromCfg(324151006)
				local var_34_13 = arg_31_1:FormatText(var_34_12.content)

				arg_31_1.text_.text = var_34_13

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_15 = 9 <= 0 and var_34_10 or var_34_10 * (utf8.len(var_34_13) / 9)

				if (9 <= 0 and var_34_10 or var_34_10 * (utf8.len(var_34_13) / 9)) > 0 and var_34_10 < var_34_15 then
					arg_31_1.talkMaxDuration = var_34_15
					var_34_9 = var_34_9 + 0.3

					if var_34_15 + var_34_9 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_15 + var_34_9
					end
				end

				arg_31_1.text_.text = var_34_13
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151006", "story_v_out_324151.awb") ~= 0 then
					local var_34_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151006", "story_v_out_324151.awb") / 1000

					if var_34_16 + var_34_9 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_16 + var_34_9
					end

					if var_34_12.prefab_name ~= "" and arg_31_1.actors_[var_34_12.prefab_name] ~= nil then
						local var_34_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_12.prefab_name].transform, "story_v_out_324151", "324151006", "story_v_out_324151.awb")

						arg_31_1:RecordAudio("324151006", var_34_17)
						arg_31_1:RecordAudio("324151006", var_34_17)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_324151", "324151006", "story_v_out_324151.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_324151", "324151006", "story_v_out_324151.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_18 = var_34_9 + 0.3
			local var_34_19 = math.max(var_34_10, arg_31_1.talkMaxDuration)

			if var_34_9 + 0.3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_18 + var_34_19 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_18) / var_34_19

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_18 + var_34_19 and arg_31_1.time_ < var_34_18 + var_34_19 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play324151007 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 324151007
		arg_37_1.duration_ = 3.61

		local var_37_0 = {
			zh = 3.241,
			ja = 3.608
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play324151008(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.bgs_.ST39 == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST39")
				var_40_0.name = "ST39"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.ST39 = var_40_0
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.ST39

				arg_37_1.bgs_.ST39.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "ST39" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_4 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_4 + 0.3 and arg_37_1.time_ < var_40_4 + 0.3 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			local var_40_5 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_6 = 1.3

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 then
				local var_40_7 = Color.New(0, 0, 0)

				var_40_7.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_5) / var_40_6)
				arg_37_1.mask_.color = var_40_7
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 then
				local var_40_8 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_8.a = 0
				arg_37_1.mask_.color = var_40_8
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_9 = 0.775
			local var_40_10 = 0.225

			if 0.775 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_11 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_11:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_12 = arg_37_1:GetWordFromCfg(324151007)
				local var_40_13 = arg_37_1:FormatText(var_40_12.content)

				arg_37_1.text_.text = var_40_13

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_15 = 9 <= 0 and var_40_10 or var_40_10 * (utf8.len(var_40_13) / 9)

				if (9 <= 0 and var_40_10 or var_40_10 * (utf8.len(var_40_13) / 9)) > 0 and var_40_10 < var_40_15 then
					arg_37_1.talkMaxDuration = var_40_15
					var_40_9 = var_40_9 + 0.3

					if var_40_15 + var_40_9 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_9
					end
				end

				arg_37_1.text_.text = var_40_13
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151007", "story_v_out_324151.awb") ~= 0 then
					local var_40_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151007", "story_v_out_324151.awb") / 1000

					if var_40_16 + var_40_9 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_9
					end

					if var_40_12.prefab_name ~= "" and arg_37_1.actors_[var_40_12.prefab_name] ~= nil then
						local var_40_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_12.prefab_name].transform, "story_v_out_324151", "324151007", "story_v_out_324151.awb")

						arg_37_1:RecordAudio("324151007", var_40_17)
						arg_37_1:RecordAudio("324151007", var_40_17)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_324151", "324151007", "story_v_out_324151.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_324151", "324151007", "story_v_out_324151.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_18 = var_40_9 + 0.3
			local var_40_19 = math.max(var_40_10, arg_37_1.talkMaxDuration)

			if var_40_9 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_18 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_18) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_18 + var_40_19 and arg_37_1.time_ < var_40_18 + var_40_19 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play324151008 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 324151008
		arg_43_1.duration_ = 3.27

		local var_43_0 = {
			zh = 2.99966666666667,
			ja = 3.26666666666667
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play324151009(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.bgs_.J22f == nil then
				local var_46_0 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J22f")
				var_46_0.name = "J22f"
				var_46_0.transform.parent = arg_43_1.stage_.transform
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_.J22f = var_46_0
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_1 = arg_43_1.bgs_.J22f

				arg_43_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_46_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_2 = var_46_1:GetComponent("SpriteRenderer")

				if var_46_2 and var_46_2.sprite then
					local var_46_3 = 2 * (var_46_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_46_1.transform.localScale = Vector3.New(var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "J22f" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_4 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			if arg_43_1.time_ >= var_46_4 + 0.3 and arg_43_1.time_ < var_46_4 + 0.3 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_5 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_6 = 1.1

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_6 then
				local var_46_7 = Color.New(0, 0, 0)

				var_46_7.a = Mathf.Lerp(1, 0, (arg_43_1.time_ - var_46_5) / var_46_6)
				arg_43_1.mask_.color = var_46_7
			end

			if arg_43_1.time_ >= var_46_5 + var_46_6 and arg_43_1.time_ < var_46_5 + var_46_6 + arg_46_0 then
				local var_46_8 = Color.New(0, 0, 0)

				arg_43_1.mask_.enabled = false
				var_46_8.a = 0
				arg_43_1.mask_.color = var_46_8
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_9 = 0.666666666666667
			local var_46_10 = 0.175

			if 0.666666666666667 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_11 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_11:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_12 = arg_43_1:GetWordFromCfg(324151008)
				local var_46_13 = arg_43_1:FormatText(var_46_12.content)

				arg_43_1.text_.text = var_46_13

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_15 = 7 <= 0 and var_46_10 or var_46_10 * (utf8.len(var_46_13) / 7)

				if (7 <= 0 and var_46_10 or var_46_10 * (utf8.len(var_46_13) / 7)) > 0 and var_46_10 < var_46_15 then
					arg_43_1.talkMaxDuration = var_46_15
					var_46_9 = var_46_9 + 0.3

					if var_46_15 + var_46_9 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_15 + var_46_9
					end
				end

				arg_43_1.text_.text = var_46_13
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151008", "story_v_out_324151.awb") ~= 0 then
					local var_46_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151008", "story_v_out_324151.awb") / 1000

					if var_46_16 + var_46_9 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_16 + var_46_9
					end

					if var_46_12.prefab_name ~= "" and arg_43_1.actors_[var_46_12.prefab_name] ~= nil then
						local var_46_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_12.prefab_name].transform, "story_v_out_324151", "324151008", "story_v_out_324151.awb")

						arg_43_1:RecordAudio("324151008", var_46_17)
						arg_43_1:RecordAudio("324151008", var_46_17)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_324151", "324151008", "story_v_out_324151.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_324151", "324151008", "story_v_out_324151.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_18 = var_46_9 + 0.3
			local var_46_19 = math.max(var_46_10, arg_43_1.talkMaxDuration)

			if var_46_9 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_18 + var_46_19 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_18) / var_46_19

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_18 + var_46_19 and arg_43_1.time_ < var_46_18 + var_46_19 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play324151009 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 324151009
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play324151010(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.05

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(324151009).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 2 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 2)

				if (2 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 2)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play324151010 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 324151010
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play324151011(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("play", "music", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_56_2 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

				if "" ~= "" then
					if arg_53_1.bgmTxt_.text ~= var_56_2 and arg_53_1.bgmTxt_.text ~= "" then
						if arg_53_1.bgmTxt2_.text ~= "" then
							arg_53_1.bgmTxt_.text = arg_53_1.bgmTxt2_.text
						end

						arg_53_1.bgmTxt2_.text = var_56_2

						arg_53_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_53_1.bgmTxt_.text = var_56_2
						arg_53_1.bgmTxt2_.text = var_56_2
					end

					if arg_53_1.bgmTimer then
						arg_53_1.bgmTimer:Stop()

						arg_53_1.bgmTimer = nil
					end

					if arg_53_1.settingData.show_music_name == 1 then
						arg_53_1.musicController:SetSelectedState("show")
						arg_53_1.musicAnimator_:Play("open", 0, 0)

						if arg_53_1.settingData.music_time ~= 0 then
							arg_53_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_53_1.settingData.music_time), function()
								if arg_53_1 == nil or isNil(arg_53_1.bgmTxt_) then
									return
								end

								arg_53_1.musicController:SetSelectedState("hide")
								arg_53_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_56_3 = 0
			local var_56_4 = 1.375

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_5 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(324151010).content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 55 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 55)

				if (55 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 55)) > 0 and var_56_4 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_3
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_4, arg_53_1.talkMaxDuration)

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_3) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_3 + var_56_8 and arg_53_1.time_ < var_56_3 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play324151011 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324151011
		arg_58_1.duration_ = 5.8

		local var_58_0 = {
			zh = 4.433,
			ja = 5.8
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324151012(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if arg_58_1.actors_["10171ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10171ui_story"))) then
				local var_61_0 = Object.Instantiate(Asset.Load("Char/" .. "10171ui_story"), arg_58_1.stage_.transform)

				var_61_0.name = "10171ui_story"
				var_61_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.actors_["10171ui_story"] = var_61_0

				local var_61_1 = var_61_0:GetComponentInChildren(typeof(CharacterEffect))

				var_61_1.enabled = true

				local var_61_2 = GameObjectTools.GetOrAddComponent(var_61_0, typeof(DynamicBoneHelper))

				if var_61_2 then
					var_61_2:EnableDynamicBone(false)
				end

				arg_58_1:ShowWeapon(var_61_1.transform, false)

				arg_58_1.var_["10171ui_story" .. "Animator"] = var_61_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_58_1.var_["10171ui_story" .. "Animator"].applyRootMotion = true
				arg_58_1.var_["10171ui_story" .. "LipSync"] = var_61_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_61_3 = arg_58_1.actors_["10171ui_story"].transform

			if 2.33333333333333 < arg_58_1.time_ and arg_58_1.time_ <= 2.33333333333333 + arg_61_0 then
				arg_58_1.var_.moveOldPos10171ui_story = var_61_3.localPosition

				local var_61_4 = GameObjectTools.GetOrAddComponent(var_61_3.gameObject, typeof(DynamicBoneHelper))

				if var_61_4 then
					var_61_4:EnableDynamicBone(false)
				end
			end

			local var_61_5 = 0.001

			if 2.33333333333333 <= arg_58_1.time_ and arg_58_1.time_ < 2.33333333333333 + var_61_5 then
				var_61_3.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_58_1.time_ - 2.33333333333333) / var_61_5)
				var_61_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_3.position).x, (manager.ui.mainCamera.transform.position - var_61_3.position).y, (manager.ui.mainCamera.transform.position - var_61_3.position).z)
				var_61_3.localEulerAngles.z = 0
				var_61_3.localEulerAngles.x = 0
				var_61_3.localEulerAngles = var_61_3.localEulerAngles
			end

			if arg_58_1.time_ >= 2.33333333333333 + var_61_5 and arg_58_1.time_ < 2.33333333333333 + var_61_5 + arg_61_0 then
				var_61_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_61_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_3.position).x, (manager.ui.mainCamera.transform.position - var_61_3.position).y, (manager.ui.mainCamera.transform.position - var_61_3.position).z)
				var_61_3.localEulerAngles.z = 0
				var_61_3.localEulerAngles.x = 0
				var_61_3.localEulerAngles = var_61_3.localEulerAngles

				local var_61_6 = GameObjectTools.GetOrAddComponent(var_61_3.gameObject, typeof(DynamicBoneHelper))

				if var_61_6 then
					var_61_6:EnableDynamicBone(true)
				end
			end

			local var_61_7 = arg_58_1.actors_["10171ui_story"]

			if 2.33333333333333 < arg_58_1.time_ and arg_58_1.time_ <= 2.33333333333333 + arg_61_0 and not isNil(var_61_7) and arg_58_1.var_.characterEffect10171ui_story == nil then
				arg_58_1.var_.characterEffect10171ui_story = var_61_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_8 = 0.200000002980232

			if 2.33333333333333 <= arg_58_1.time_ and arg_58_1.time_ < 2.33333333333333 + var_61_8 and not isNil(var_61_7) then
				if arg_58_1.var_.characterEffect10171ui_story and not isNil(var_61_7) then
					arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 2.33333333333333 + var_61_8 and arg_58_1.time_ < 2.33333333333333 + var_61_8 + arg_61_0 and not isNil(var_61_7) and arg_58_1.var_.characterEffect10171ui_story then
				arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 2.33333333333333 < arg_58_1.time_ and arg_58_1.time_ <= 2.33333333333333 + arg_61_0 then
				arg_58_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 2.33333333333333 < arg_58_1.time_ and arg_58_1.time_ <= 2.33333333333333 + arg_61_0 then
				arg_58_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_61_10 = 0

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_11 = 0.933333333333333

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_11 then
				local var_61_12 = Color.New(0, 0, 0)

				var_61_12.a = Mathf.Lerp(0, 1, (arg_58_1.time_ - var_61_10) / var_61_11)
				arg_58_1.mask_.color = var_61_12
			end

			if arg_58_1.time_ >= var_61_10 + var_61_11 and arg_58_1.time_ < var_61_10 + var_61_11 + arg_61_0 then
				local var_61_13 = Color.New(0, 0, 0)

				var_61_13.a = 1
				arg_58_1.mask_.color = var_61_13
			end

			local var_61_14 = 0.933333333333333

			if 0.933333333333333 < arg_58_1.time_ and arg_58_1.time_ <= var_61_14 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_15 = 1.76666666666667

			if var_61_14 <= arg_58_1.time_ and arg_58_1.time_ < var_61_14 + var_61_15 then
				local var_61_16 = Color.New(0, 0, 0)

				var_61_16.a = Mathf.Lerp(1, 0, (arg_58_1.time_ - var_61_14) / var_61_15)
				arg_58_1.mask_.color = var_61_16
			end

			if arg_58_1.time_ >= var_61_14 + var_61_15 and arg_58_1.time_ < var_61_14 + var_61_15 + arg_61_0 then
				local var_61_17 = Color.New(0, 0, 0)

				arg_58_1.mask_.enabled = false
				var_61_17.a = 0
				arg_58_1.mask_.color = var_61_17
			end

			if 0.933333333333333 < arg_58_1.time_ and arg_58_1.time_ <= 0.933333333333333 + arg_61_0 then
				if arg_58_1.var_.effect2323 then
					Object.Destroy(arg_58_1.var_.effect2323)

					arg_58_1.var_.effect2323 = nil
				end
			end

			if 0.933333333333333 < arg_58_1.time_ and arg_58_1.time_ <= 0.933333333333333 + arg_61_0 then
				if arg_58_1.var_.effect3242 then
					Object.Destroy(arg_58_1.var_.effect3242)

					arg_58_1.var_.effect3242 = nil
				end
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_20 = 2.7
			local var_61_21 = 0.2

			if 2.7 < arg_58_1.time_ and arg_58_1.time_ <= var_61_20 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_22 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_22:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_23 = arg_58_1:GetWordFromCfg(324151011)
				local var_61_24 = arg_58_1:FormatText(var_61_23.content)

				arg_58_1.text_.text = var_61_24

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_26 = 8 <= 0 and var_61_21 or var_61_21 * (utf8.len(var_61_24) / 8)

				if (8 <= 0 and var_61_21 or var_61_21 * (utf8.len(var_61_24) / 8)) > 0 and var_61_21 < var_61_26 then
					arg_58_1.talkMaxDuration = var_61_26
					var_61_20 = var_61_20 + 0.3

					if var_61_26 + var_61_20 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_26 + var_61_20
					end
				end

				arg_58_1.text_.text = var_61_24
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151011", "story_v_out_324151.awb") ~= 0 then
					local var_61_27 = manager.audio:GetVoiceLength("story_v_out_324151", "324151011", "story_v_out_324151.awb") / 1000

					if var_61_27 + var_61_20 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_27 + var_61_20
					end

					if var_61_23.prefab_name ~= "" and arg_58_1.actors_[var_61_23.prefab_name] ~= nil then
						local var_61_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_23.prefab_name].transform, "story_v_out_324151", "324151011", "story_v_out_324151.awb")

						arg_58_1:RecordAudio("324151011", var_61_28)
						arg_58_1:RecordAudio("324151011", var_61_28)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_324151", "324151011", "story_v_out_324151.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_324151", "324151011", "story_v_out_324151.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_29 = var_61_20 + 0.3
			local var_61_30 = math.max(var_61_21, arg_58_1.talkMaxDuration)

			if var_61_20 + 0.3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_29 + var_61_30 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_29) / var_61_30

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_29 + var_61_30 and arg_58_1.time_ < var_61_29 + var_61_30 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play324151012 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324151012
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324151013(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10171ui_story = arg_64_1.actors_["10171ui_story"].transform.localPosition

				local var_67_0 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_0 then
					var_67_0:EnableDynamicBone(false)
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_1)
				arg_64_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10171ui_story"].transform.position).z)
				arg_64_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["10171ui_story"].transform.localEulerAngles = arg_64_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10171ui_story"].transform.position).z)
				arg_64_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["10171ui_story"].transform.localEulerAngles = arg_64_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_67_2 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(true)
				end
			end

			local var_67_3 = arg_64_1.actors_["10171ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_3) and arg_64_1.var_.characterEffect10171ui_story == nil then
				arg_64_1.var_.characterEffect10171ui_story = var_67_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_4 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 and not isNil(var_67_3) then
				if arg_64_1.var_.characterEffect10171ui_story and not isNil(var_67_3) then
					arg_64_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_4)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 and not isNil(var_67_3) and arg_64_1.var_.characterEffect10171ui_story then
				arg_64_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_67_5 = 0
			local var_67_6 = 1.55

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_7 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(324151012).content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 62 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_7) / 62)

				if (62 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_7) / 62)) > 0 and var_67_6 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_5 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_5
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_6, arg_64_1.talkMaxDuration)

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_5) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_5 + var_67_10 and arg_64_1.time_ < var_67_5 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play324151013 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324151013
		arg_68_1.duration_ = 3.8

		local var_68_0 = {
			zh = 2.833,
			ja = 3.8
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324151014(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.4

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(324151013)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 16 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 16)

				if (16 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 16)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151013", "story_v_out_324151.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151013", "story_v_out_324151.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_324151", "324151013", "story_v_out_324151.awb")

						arg_68_1:RecordAudio("324151013", var_71_6)
						arg_68_1:RecordAudio("324151013", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324151", "324151013", "story_v_out_324151.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324151", "324151013", "story_v_out_324151.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play324151014 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324151014
		arg_72_1.duration_ = 3.7

		local var_72_0 = {
			zh = 1.999999999999,
			ja = 3.7
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324151015(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10171ui_story = arg_72_1.actors_["10171ui_story"].transform.localPosition

				local var_75_0 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_0 then
					var_75_0:EnableDynamicBone(false)
				end
			end

			local var_75_1 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_1 then
				arg_72_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_72_1.time_ - 0) / var_75_1)
				arg_72_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10171ui_story"].transform.position).z)
				arg_72_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["10171ui_story"].transform.localEulerAngles = arg_72_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_1 and arg_72_1.time_ < 0 + var_75_1 + arg_75_0 then
				arg_72_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_72_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10171ui_story"].transform.position).z)
				arg_72_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["10171ui_story"].transform.localEulerAngles = arg_72_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_75_2 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(true)
				end
			end

			local var_75_3 = arg_72_1.actors_["10171ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect10171ui_story == nil then
				arg_72_1.var_.characterEffect10171ui_story = var_75_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_4 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 and not isNil(var_75_3) then
				if arg_72_1.var_.characterEffect10171ui_story and not isNil(var_75_3) then
					arg_72_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect10171ui_story then
				arg_72_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_75_6 = 0
			local var_75_7 = 0.225

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:GetWordFromCfg(324151014)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 9 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 9)

				if (9 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 9)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151014", "story_v_out_324151.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151014", "story_v_out_324151.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_324151", "324151014", "story_v_out_324151.awb")

						arg_72_1:RecordAudio("324151014", var_75_13)
						arg_72_1:RecordAudio("324151014", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324151", "324151014", "story_v_out_324151.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324151", "324151014", "story_v_out_324151.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play324151015 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324151015
		arg_76_1.duration_ = 11.9

		local var_76_0 = {
			zh = 4.433,
			ja = 11.9
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324151016(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10171ui_story"]) and arg_76_1.var_.characterEffect10171ui_story == nil then
				arg_76_1.var_.characterEffect10171ui_story = arg_76_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10171ui_story"]) then
				if arg_76_1.var_.characterEffect10171ui_story and not isNil(arg_76_1.actors_["10171ui_story"]) then
					arg_76_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_76_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10171ui_story"]) and arg_76_1.var_.characterEffect10171ui_story then
				arg_76_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_76_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.6

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(324151015)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 24 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 24)

				if (24 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 24)) > 0 and var_79_2 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151015", "story_v_out_324151.awb") ~= 0 then
					local var_79_7 = manager.audio:GetVoiceLength("story_v_out_324151", "324151015", "story_v_out_324151.awb") / 1000

					if var_79_7 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_1
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_324151", "324151015", "story_v_out_324151.awb")

						arg_76_1:RecordAudio("324151015", var_79_8)
						arg_76_1:RecordAudio("324151015", var_79_8)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_324151", "324151015", "story_v_out_324151.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_324151", "324151015", "story_v_out_324151.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_9 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_9 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_9

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_9 and arg_76_1.time_ < var_79_1 + var_79_9 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324151016 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324151016
		arg_80_1.duration_ = 6.4

		local var_80_0 = {
			zh = 4.166,
			ja = 6.4
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play324151017(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["10171ui_story"]) and arg_80_1.var_.characterEffect10171ui_story == nil then
				arg_80_1.var_.characterEffect10171ui_story = arg_80_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["10171ui_story"]) then
				if arg_80_1.var_.characterEffect10171ui_story and not isNil(arg_80_1.actors_["10171ui_story"]) then
					arg_80_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["10171ui_story"]) and arg_80_1.var_.characterEffect10171ui_story then
				arg_80_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_83_2 = 0
			local var_83_3 = 0.5

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_4 = arg_80_1:GetWordFromCfg(324151016)
				local var_83_5 = arg_80_1:FormatText(var_83_4.content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 20 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 20)

				if (20 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 20)) > 0 and var_83_3 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_2
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151016", "story_v_out_324151.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151016", "story_v_out_324151.awb") / 1000

					if var_83_8 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_2
					end

					if var_83_4.prefab_name ~= "" and arg_80_1.actors_[var_83_4.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_4.prefab_name].transform, "story_v_out_324151", "324151016", "story_v_out_324151.awb")

						arg_80_1:RecordAudio("324151016", var_83_9)
						arg_80_1:RecordAudio("324151016", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_324151", "324151016", "story_v_out_324151.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_324151", "324151016", "story_v_out_324151.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_3, arg_80_1.talkMaxDuration)

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_2) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_2 + var_83_10 and arg_80_1.time_ < var_83_2 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play324151017 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324151017
		arg_84_1.duration_ = 11.97

		local var_84_0 = {
			zh = 6.866,
			ja = 11.966
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play324151018(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10171ui_story"]) and arg_84_1.var_.characterEffect10171ui_story == nil then
				arg_84_1.var_.characterEffect10171ui_story = arg_84_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10171ui_story"]) then
				if arg_84_1.var_.characterEffect10171ui_story and not isNil(arg_84_1.actors_["10171ui_story"]) then
					arg_84_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10171ui_story"]) and arg_84_1.var_.characterEffect10171ui_story then
				arg_84_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.875

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(324151017)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 35 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_4) / 35)

				if (35 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_4) / 35)) > 0 and var_87_2 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151017", "story_v_out_324151.awb") ~= 0 then
					local var_87_7 = manager.audio:GetVoiceLength("story_v_out_324151", "324151017", "story_v_out_324151.awb") / 1000

					if var_87_7 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_1
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_324151", "324151017", "story_v_out_324151.awb")

						arg_84_1:RecordAudio("324151017", var_87_8)
						arg_84_1:RecordAudio("324151017", var_87_8)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324151", "324151017", "story_v_out_324151.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324151", "324151017", "story_v_out_324151.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_9 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_9 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_9

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_9 and arg_84_1.time_ < var_87_1 + var_87_9 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324151018 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324151018
		arg_88_1.duration_ = 14.2

		local var_88_0 = {
			zh = 6.9,
			ja = 14.2
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324151019(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10171ui_story"]) and arg_88_1.var_.characterEffect10171ui_story == nil then
				arg_88_1.var_.characterEffect10171ui_story = arg_88_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10171ui_story"]) then
				if arg_88_1.var_.characterEffect10171ui_story and not isNil(arg_88_1.actors_["10171ui_story"]) then
					arg_88_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10171ui_story"]) and arg_88_1.var_.characterEffect10171ui_story then
				arg_88_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_2")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_91_2 = 0
			local var_91_3 = 0.875

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(324151018)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 35 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 35)

				if (35 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 35)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151018", "story_v_out_324151.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151018", "story_v_out_324151.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_324151", "324151018", "story_v_out_324151.awb")

						arg_88_1:RecordAudio("324151018", var_91_9)
						arg_88_1:RecordAudio("324151018", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_324151", "324151018", "story_v_out_324151.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_324151", "324151018", "story_v_out_324151.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_10 and arg_88_1.time_ < var_91_2 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play324151019 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324151019
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play324151020(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10171ui_story = arg_92_1.actors_["10171ui_story"].transform.localPosition

				local var_95_0 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_0 then
					var_95_0:EnableDynamicBone(false)
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_1)
				arg_92_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10171ui_story"].transform.position).z)
				arg_92_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10171ui_story"].transform.localEulerAngles = arg_92_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10171ui_story"].transform.position).z)
				arg_92_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10171ui_story"].transform.localEulerAngles = arg_92_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_95_2 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(true)
				end
			end

			local var_95_3 = arg_92_1.actors_["10171ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect10171ui_story == nil then
				arg_92_1.var_.characterEffect10171ui_story = var_95_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_4 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 and not isNil(var_95_3) then
				if arg_92_1.var_.characterEffect10171ui_story and not isNil(var_95_3) then
					arg_92_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_4)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect10171ui_story then
				arg_92_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_92_1.time_ and arg_92_1.time_ <= 0.1 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_142", "se_story_142_chopper01", "")
			end

			local var_95_6 = 0
			local var_95_7 = 0.825

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(324151019).content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 33 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_8) / 33)

				if (33 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_8) / 33)) > 0 and var_95_7 < var_95_10 then
					arg_92_1.talkMaxDuration = var_95_10

					if var_95_10 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_11 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_11 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_11

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_11 and arg_92_1.time_ < var_95_6 + var_95_11 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play324151020 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324151020
		arg_96_1.duration_ = 7.37

		local var_96_0 = {
			zh = 5.366,
			ja = 7.366
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play324151021(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.45

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_1 = arg_96_1:GetWordFromCfg(324151020)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 18 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 18)

				if (18 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 18)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151020", "story_v_out_324151.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151020", "story_v_out_324151.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_324151", "324151020", "story_v_out_324151.awb")

						arg_96_1:RecordAudio("324151020", var_99_6)
						arg_96_1:RecordAudio("324151020", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_324151", "324151020", "story_v_out_324151.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_324151", "324151020", "story_v_out_324151.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play324151021 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324151021
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324151022(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 1.025

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(324151021).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 41 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 41)

				if (41 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 41)) > 0 and var_103_0 < var_103_3 then
					arg_100_1.talkMaxDuration = var_103_3

					if var_103_3 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_3 + 0
					end
				end

				arg_100_1.text_.text = var_103_1
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_4 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_4

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play324151022 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324151022
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play324151023(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 1.675

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(324151022).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 67 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 67)

				if (67 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 67)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play324151023 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324151023
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play324151024(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 1.275

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(324151023).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 51 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 51)

				if (51 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 51)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play324151024 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324151024
		arg_112_1.duration_ = 3.4

		local var_112_0 = {
			zh = 1.9,
			ja = 3.4
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324151025(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["10171ui_story"]) and arg_112_1.var_.characterEffect10171ui_story == nil then
				arg_112_1.var_.characterEffect10171ui_story = arg_112_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["10171ui_story"]) then
				if arg_112_1.var_.characterEffect10171ui_story and not isNil(arg_112_1.actors_["10171ui_story"]) then
					arg_112_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["10171ui_story"]) and arg_112_1.var_.characterEffect10171ui_story then
				arg_112_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_115_2 = 0
			local var_115_3 = 0.2

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10171")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_4 = arg_112_1:GetWordFromCfg(324151024)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 8 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 8)

				if (8 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 8)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151024", "story_v_out_324151.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151024", "story_v_out_324151.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_324151", "324151024", "story_v_out_324151.awb")

						arg_112_1:RecordAudio("324151024", var_115_9)
						arg_112_1:RecordAudio("324151024", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_324151", "324151024", "story_v_out_324151.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_324151", "324151024", "story_v_out_324151.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play324151025 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324151025
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play324151026(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["10171ui_story"]) and arg_116_1.var_.characterEffect10171ui_story == nil then
				arg_116_1.var_.characterEffect10171ui_story = arg_116_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["10171ui_story"]) then
				if arg_116_1.var_.characterEffect10171ui_story and not isNil(arg_116_1.actors_["10171ui_story"]) then
					arg_116_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_116_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["10171ui_story"]) and arg_116_1.var_.characterEffect10171ui_story then
				arg_116_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_116_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 0.9

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(324151025).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 36 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 36)

				if (36 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 36)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play324151026 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324151026
		arg_120_1.duration_ = 9.7

		local var_120_0 = {
			zh = 6.566,
			ja = 9.7
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play324151027(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["10171ui_story"]) and arg_120_1.var_.characterEffect10171ui_story == nil then
				arg_120_1.var_.characterEffect10171ui_story = arg_120_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["10171ui_story"]) then
				if arg_120_1.var_.characterEffect10171ui_story and not isNil(arg_120_1.actors_["10171ui_story"]) then
					arg_120_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["10171ui_story"]) and arg_120_1.var_.characterEffect10171ui_story then
				arg_120_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_123_2 = 0
			local var_123_3 = 0.6

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10171")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_4 = arg_120_1:GetWordFromCfg(324151026)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 24 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 24)

				if (24 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 24)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151026", "story_v_out_324151.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151026", "story_v_out_324151.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_out_324151", "324151026", "story_v_out_324151.awb")

						arg_120_1:RecordAudio("324151026", var_123_9)
						arg_120_1:RecordAudio("324151026", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_324151", "324151026", "story_v_out_324151.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_324151", "324151026", "story_v_out_324151.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play324151027 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324151027
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play324151028(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["10171ui_story"]) and arg_124_1.var_.characterEffect10171ui_story == nil then
				arg_124_1.var_.characterEffect10171ui_story = arg_124_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["10171ui_story"]) then
				if arg_124_1.var_.characterEffect10171ui_story and not isNil(arg_124_1.actors_["10171ui_story"]) then
					arg_124_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10171ui_story"]) and arg_124_1.var_.characterEffect10171ui_story then
				arg_124_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0.5 < arg_124_1.time_ and arg_124_1.time_ <= 0.5 + arg_127_0 then
				arg_124_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword04", "")
			end

			local var_127_2 = 0
			local var_127_3 = 1.725

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(324151027).content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_6 = 69 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_4) / 69)

				if (69 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_4) / 69)) > 0 and var_127_3 < var_127_6 then
					arg_124_1.talkMaxDuration = var_127_6

					if var_127_6 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_7 and arg_124_1.time_ < var_127_2 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play324151028 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324151028
		arg_128_1.duration_ = 10.23

		local var_128_0 = {
			zh = 6.433,
			ja = 10.233
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play324151029(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["10171ui_story"]) and arg_128_1.var_.characterEffect10171ui_story == nil then
				arg_128_1.var_.characterEffect10171ui_story = arg_128_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["10171ui_story"]) then
				if arg_128_1.var_.characterEffect10171ui_story and not isNil(arg_128_1.actors_["10171ui_story"]) then
					arg_128_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["10171ui_story"]) and arg_128_1.var_.characterEffect10171ui_story then
				arg_128_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_131_2 = 0
			local var_131_3 = 0.675

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10171")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_4 = arg_128_1:GetWordFromCfg(324151028)
				local var_131_5 = arg_128_1:FormatText(var_131_4.content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 27 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 27)

				if (27 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 27)) > 0 and var_131_3 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_2
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151028", "story_v_out_324151.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151028", "story_v_out_324151.awb") / 1000

					if var_131_8 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_2
					end

					if var_131_4.prefab_name ~= "" and arg_128_1.actors_[var_131_4.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_4.prefab_name].transform, "story_v_out_324151", "324151028", "story_v_out_324151.awb")

						arg_128_1:RecordAudio("324151028", var_131_9)
						arg_128_1:RecordAudio("324151028", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324151", "324151028", "story_v_out_324151.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324151", "324151028", "story_v_out_324151.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_3, arg_128_1.talkMaxDuration)

			if var_131_2 <= arg_128_1.time_ and arg_128_1.time_ < var_131_2 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_2) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_2 + var_131_10 and arg_128_1.time_ < var_131_2 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play324151029 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324151029
		arg_132_1.duration_ = 11.2

		local var_132_0 = {
			zh = 10.4356329760669,
			ja = 11.2016329760669
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324151030(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if arg_132_1.bgs_.ST41 == nil then
				local var_135_0 = Object.Instantiate(arg_132_1.paintGo_)

				var_135_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST41")
				var_135_0.name = "ST41"
				var_135_0.transform.parent = arg_132_1.stage_.transform
				var_135_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.bgs_.ST41 = var_135_0
			end

			if 1.20163297123897 < arg_132_1.time_ and arg_132_1.time_ <= 1.20163297123897 + arg_135_0 then
				local var_135_1 = arg_132_1.bgs_.ST41

				arg_132_1.bgs_.ST41.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_135_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_135_2 = var_135_1:GetComponent("SpriteRenderer")

				if var_135_2 and var_135_2.sprite then
					local var_135_3 = 2 * (var_135_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_135_1.transform.localScale = Vector3.New(var_135_3 / var_135_2.sprite.bounds.size.y < var_135_3 * manager.ui.mainCameraCom_.aspect / var_135_2.sprite.bounds.size.x and var_135_3 * manager.ui.mainCameraCom_.aspect / var_135_2.sprite.bounds.size.x or var_135_3 / var_135_2.sprite.bounds.size.y, var_135_3 / var_135_2.sprite.bounds.size.y < var_135_3 * manager.ui.mainCameraCom_.aspect / var_135_2.sprite.bounds.size.x and var_135_3 * manager.ui.mainCameraCom_.aspect / var_135_2.sprite.bounds.size.x or var_135_3 / var_135_2.sprite.bounds.size.y, 0)
				end

				for iter_135_0, iter_135_1 in pairs(arg_132_1.bgs_) do
					if iter_135_0 ~= "ST41" then
						iter_135_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_135_4 = 3.33333333333333

			if 3.33333333333333 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.allBtn_.enabled = false
			end

			if arg_132_1.time_ >= var_135_4 + 0.3 and arg_132_1.time_ < var_135_4 + 0.3 + arg_135_0 then
				arg_132_1.allBtn_.enabled = true
			end

			local var_135_5 = 0

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_6 = 1.20163297123897

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_6 then
				local var_135_7 = Color.New(0, 0, 0)

				var_135_7.a = Mathf.Lerp(0, 1, (arg_132_1.time_ - var_135_5) / var_135_6)
				arg_132_1.mask_.color = var_135_7
			end

			if arg_132_1.time_ >= var_135_5 + var_135_6 and arg_132_1.time_ < var_135_5 + var_135_6 + arg_135_0 then
				local var_135_8 = Color.New(0, 0, 0)

				var_135_8.a = 1
				arg_132_1.mask_.color = var_135_8
			end

			local var_135_9 = 1.20163297123897

			if 1.20163297123897 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_10 = 1.46733333518108

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_10 then
				local var_135_11 = Color.New(0, 0, 0)

				var_135_11.a = Mathf.Lerp(1, 0, (arg_132_1.time_ - var_135_9) / var_135_10)
				arg_132_1.mask_.color = var_135_11
			end

			if arg_132_1.time_ >= var_135_9 + var_135_10 and arg_132_1.time_ < var_135_9 + var_135_10 + arg_135_0 then
				local var_135_12 = Color.New(0, 0, 0)

				arg_132_1.mask_.enabled = false
				var_135_12.a = 0
				arg_132_1.mask_.color = var_135_12
			end

			local var_135_13 = "1061ui_story"

			if arg_132_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_135_14 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_132_1.stage_.transform)

				var_135_14.name = var_135_13
				var_135_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_[var_135_13] = var_135_14

				local var_135_15 = var_135_14:GetComponentInChildren(typeof(CharacterEffect))

				var_135_15.enabled = true

				local var_135_16 = GameObjectTools.GetOrAddComponent(var_135_14, typeof(DynamicBoneHelper))

				if var_135_16 then
					var_135_16:EnableDynamicBone(false)
				end

				arg_132_1:ShowWeapon(var_135_15.transform, false)

				arg_132_1.var_[var_135_13 .. "Animator"] = var_135_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_132_1.var_[var_135_13 .. "Animator"].applyRootMotion = true
				arg_132_1.var_[var_135_13 .. "LipSync"] = var_135_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_135_17 = arg_132_1.actors_["1061ui_story"].transform

			if 6.43563297308671 < arg_132_1.time_ and arg_132_1.time_ <= 6.43563297308671 + arg_135_0 then
				arg_132_1.var_.moveOldPos1061ui_story = var_135_17.localPosition
			end

			local var_135_18 = 0.001

			if 6.43563297308671 <= arg_132_1.time_ and arg_132_1.time_ < 6.43563297308671 + var_135_18 then
				var_135_17.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_132_1.time_ - 6.43563297308671) / var_135_18)
				var_135_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_17.position).x, (manager.ui.mainCamera.transform.position - var_135_17.position).y, (manager.ui.mainCamera.transform.position - var_135_17.position).z)
				var_135_17.localEulerAngles.z = 0
				var_135_17.localEulerAngles.x = 0
				var_135_17.localEulerAngles = var_135_17.localEulerAngles
			end

			if arg_132_1.time_ >= 6.43563297308671 + var_135_18 and arg_132_1.time_ < 6.43563297308671 + var_135_18 + arg_135_0 then
				var_135_17.localPosition = Vector3.New(0, -1.18, -6.15)
				var_135_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_17.position).x, (manager.ui.mainCamera.transform.position - var_135_17.position).y, (manager.ui.mainCamera.transform.position - var_135_17.position).z)
				var_135_17.localEulerAngles.z = 0
				var_135_17.localEulerAngles.x = 0
				var_135_17.localEulerAngles = var_135_17.localEulerAngles
			end

			local var_135_19 = arg_132_1.actors_["1061ui_story"]

			if 6.43563297308671 < arg_132_1.time_ and arg_132_1.time_ <= 6.43563297308671 + arg_135_0 and not isNil(var_135_19) and arg_132_1.var_.characterEffect1061ui_story == nil then
				arg_132_1.var_.characterEffect1061ui_story = var_135_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_20 = 0.200000002980232

			if 6.43563297308671 <= arg_132_1.time_ and arg_132_1.time_ < 6.43563297308671 + var_135_20 and not isNil(var_135_19) then
				if arg_132_1.var_.characterEffect1061ui_story and not isNil(var_135_19) then
					arg_132_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 6.43563297308671 + var_135_20 and arg_132_1.time_ < 6.43563297308671 + var_135_20 + arg_135_0 and not isNil(var_135_19) and arg_132_1.var_.characterEffect1061ui_story then
				arg_132_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_135_22 = arg_132_1.actors_["10171ui_story"]

			if 6.43563297308671 < arg_132_1.time_ and arg_132_1.time_ <= 6.43563297308671 + arg_135_0 and not isNil(var_135_22) and arg_132_1.var_.characterEffect10171ui_story == nil then
				arg_132_1.var_.characterEffect10171ui_story = var_135_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_23 = 0.200000002980232

			if 6.43563297308671 <= arg_132_1.time_ and arg_132_1.time_ < 6.43563297308671 + var_135_23 and not isNil(var_135_22) then
				if arg_132_1.var_.characterEffect10171ui_story and not isNil(var_135_22) then
					arg_132_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 6.43563297308671) / var_135_23)
				end
			end

			if arg_132_1.time_ >= 6.43563297308671 + var_135_23 and arg_132_1.time_ < 6.43563297308671 + var_135_23 + arg_135_0 and not isNil(var_135_22) and arg_132_1.var_.characterEffect10171ui_story then
				arg_132_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 6.43563297308671 < arg_132_1.time_ and arg_132_1.time_ <= 6.43563297308671 + arg_135_0 then
				arg_132_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 6.43563297308671 < arg_132_1.time_ and arg_132_1.time_ <= 6.43563297308671 + arg_135_0 then
				arg_132_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 5.43563297308671 < arg_132_1.time_ and arg_132_1.time_ <= 5.43563297308671 + arg_135_0 then
				arg_132_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_wind", "")
			end

			local var_135_26 = 5.40163297123897

			arg_132_1.isInRecall_ = false

			if var_135_26 < arg_132_1.time_ and arg_132_1.time_ <= var_135_26 + arg_135_0 then
				arg_132_1.screenFilterGo_:SetActive(true)

				arg_132_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_135_2, iter_135_3 in pairs(arg_132_1.actors_) do
					for iter_135_4, iter_135_5 in ipairs((iter_135_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_135_5.color = iter_135_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_135_27 = 0.034000001847744

			if var_135_26 <= arg_132_1.time_ and arg_132_1.time_ < var_135_26 + var_135_27 then
				arg_132_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_132_1.time_ - var_135_26) / var_135_27)
			end

			if arg_132_1.time_ >= var_135_26 + var_135_27 and arg_132_1.time_ < var_135_26 + var_135_27 + arg_135_0 then
				arg_132_1.screenFilterEffect_.weight = 1
			end

			local var_135_28 = 1.20163297123897

			if 1.20163297123897 < arg_132_1.time_ and arg_132_1.time_ <= var_135_28 + arg_135_0 then
				arg_132_1.timestampController_:SetSelectedState("show")
				arg_132_1.timestampAni_:Play("in")

				arg_132_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST41")

				arg_132_1.timestampColorController_:SetSelectedState("hot")
				arg_132_1.timeColdImg_:SetAlpha(0.031)

				arg_132_1.text_timeText_.text = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(501128).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_timeText_)

				arg_132_1.text_siteText_.text = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(501129).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_siteText_)
			end

			if arg_132_1.time_ >= var_135_28 + 3 and arg_132_1.time_ < var_135_28 + 3 + arg_135_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_132_1.timestampAni_, "out", function()
					arg_132_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_135_29 = 4.20163297123897

			if 4.20163297123897 < arg_132_1.time_ and arg_132_1.time_ <= var_135_29 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_30 = 1.2

			if var_135_29 <= arg_132_1.time_ and arg_132_1.time_ < var_135_29 + var_135_30 then
				local var_135_31 = Color.New(0, 0, 0)

				var_135_31.a = Mathf.Lerp(0, 1, (arg_132_1.time_ - var_135_29) / var_135_30)
				arg_132_1.mask_.color = var_135_31
			end

			if arg_132_1.time_ >= var_135_29 + var_135_30 and arg_132_1.time_ < var_135_29 + var_135_30 + arg_135_0 then
				local var_135_32 = Color.New(0, 0, 0)

				var_135_32.a = 1
				arg_132_1.mask_.color = var_135_32
			end

			local var_135_33 = 5.40163297123897

			if 5.40163297123897 < arg_132_1.time_ and arg_132_1.time_ <= var_135_33 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_34 = 1.2

			if var_135_33 <= arg_132_1.time_ and arg_132_1.time_ < var_135_33 + var_135_34 then
				local var_135_35 = Color.New(0, 0, 0)

				var_135_35.a = Mathf.Lerp(1, 0, (arg_132_1.time_ - var_135_33) / var_135_34)
				arg_132_1.mask_.color = var_135_35
			end

			if arg_132_1.time_ >= var_135_33 + var_135_34 and arg_132_1.time_ < var_135_33 + var_135_34 + arg_135_0 then
				local var_135_36 = Color.New(0, 0, 0)

				arg_132_1.mask_.enabled = false
				var_135_36.a = 0
				arg_132_1.mask_.color = var_135_36
			end

			local var_135_37 = 1.33333333333333

			if 1.33333333333333 < arg_132_1.time_ and arg_132_1.time_ <= var_135_37 + arg_135_0 then
				arg_132_1.allBtn_.enabled = false
			end

			if arg_132_1.time_ >= var_135_37 + 5 and arg_132_1.time_ < var_135_37 + 5 + arg_135_0 then
				arg_132_1.allBtn_.enabled = true
			end

			if arg_132_1.frameCnt_ <= 1 then
				arg_132_1.dialog_:SetActive(false)
			end

			local var_135_38 = 6.63563297606694
			local var_135_39 = 0.35

			if 6.63563297606694 < arg_132_1.time_ and arg_132_1.time_ <= var_135_38 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0

				arg_132_1.dialog_:SetActive(true)

				arg_132_1.dialogCg_.alpha = 0

				local var_135_40 = LeanTween.value(arg_132_1.dialog_, 0, 1, 0.3)

				var_135_40:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_132_1.dialogCg_.alpha = arg_137_0
				end))
				var_135_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_132_1.dialog_)
					var_135_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_132_1.duration_ = arg_132_1.duration_ + 0.3

				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_41 = arg_132_1:GetWordFromCfg(324151029)
				local var_135_42 = arg_132_1:FormatText(var_135_41.content)

				arg_132_1.text_.text = var_135_42

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_44 = 14 <= 0 and var_135_39 or var_135_39 * (utf8.len(var_135_42) / 14)

				if (14 <= 0 and var_135_39 or var_135_39 * (utf8.len(var_135_42) / 14)) > 0 and var_135_39 < var_135_44 then
					arg_132_1.talkMaxDuration = var_135_44
					var_135_38 = var_135_38 + 0.3

					if var_135_44 + var_135_38 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_44 + var_135_38
					end
				end

				arg_132_1.text_.text = var_135_42
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151029", "story_v_out_324151.awb") ~= 0 then
					local var_135_45 = manager.audio:GetVoiceLength("story_v_out_324151", "324151029", "story_v_out_324151.awb") / 1000

					if var_135_45 + var_135_38 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_45 + var_135_38
					end

					if var_135_41.prefab_name ~= "" and arg_132_1.actors_[var_135_41.prefab_name] ~= nil then
						local var_135_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_41.prefab_name].transform, "story_v_out_324151", "324151029", "story_v_out_324151.awb")

						arg_132_1:RecordAudio("324151029", var_135_46)
						arg_132_1:RecordAudio("324151029", var_135_46)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_324151", "324151029", "story_v_out_324151.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_324151", "324151029", "story_v_out_324151.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_47 = var_135_38 + 0.3
			local var_135_48 = math.max(var_135_39, arg_132_1.talkMaxDuration)

			if var_135_38 + 0.3 <= arg_132_1.time_ and arg_132_1.time_ < var_135_47 + var_135_48 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_47) / var_135_48

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_47 + var_135_48 and arg_132_1.time_ < var_135_47 + var_135_48 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 6.43563297308671,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play324151030 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 324151030
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play324151031(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1061ui_story"]) and arg_139_1.var_.characterEffect1061ui_story == nil then
				arg_139_1.var_.characterEffect1061ui_story = arg_139_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1061ui_story"]) then
				if arg_139_1.var_.characterEffect1061ui_story and not isNil(arg_139_1.actors_["1061ui_story"]) then
					arg_139_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1061ui_story"]) and arg_139_1.var_.characterEffect1061ui_story then
				arg_139_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0.2 < arg_139_1.time_ and arg_139_1.time_ <= 0.2 + arg_142_0 then
				arg_139_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword05", "")
			end

			local var_142_2 = 0
			local var_142_3 = 1.6

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(324151030).content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 64 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 64)

				if (64 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 64)) > 0 and var_142_3 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_7 and arg_139_1.time_ < var_142_2 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play324151031 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 324151031
		arg_143_1.duration_ = 1.8

		local var_143_0 = {
			zh = 1.6,
			ja = 1.8
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play324151032(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1061ui_story"]) and arg_143_1.var_.characterEffect1061ui_story == nil then
				arg_143_1.var_.characterEffect1061ui_story = arg_143_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1061ui_story"]) then
				if arg_143_1.var_.characterEffect1061ui_story and not isNil(arg_143_1.actors_["1061ui_story"]) then
					arg_143_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1061ui_story"]) and arg_143_1.var_.characterEffect1061ui_story then
				arg_143_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_146_2 = 0
			local var_146_3 = 0.2

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(324151031)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 8 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 8)

				if (8 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 8)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151031", "story_v_out_324151.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151031", "story_v_out_324151.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_324151", "324151031", "story_v_out_324151.awb")

						arg_143_1:RecordAudio("324151031", var_146_9)
						arg_143_1:RecordAudio("324151031", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_324151", "324151031", "story_v_out_324151.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_324151", "324151031", "story_v_out_324151.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play324151032 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 324151032
		arg_147_1.duration_ = 2.7

		local var_147_0 = {
			zh = 2.7,
			ja = 1.999999999999
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play324151033(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10171ui_story = arg_147_1.actors_["10171ui_story"].transform.localPosition

				local var_150_0 = GameObjectTools.GetOrAddComponent(arg_147_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_150_0 then
					var_150_0:EnableDynamicBone(false)
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10171ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_147_1.time_ - 0) / var_150_1)
				arg_147_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10171ui_story"].transform.position).z)
				arg_147_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["10171ui_story"].transform.localEulerAngles = arg_147_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_147_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10171ui_story"].transform.position).z)
				arg_147_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["10171ui_story"].transform.localEulerAngles = arg_147_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_150_2 = GameObjectTools.GetOrAddComponent(arg_147_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_150_2 then
					var_150_2:EnableDynamicBone(true)
				end
			end

			local var_150_3 = arg_147_1.actors_["1061ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061ui_story = var_150_3.localPosition
			end

			local var_150_4 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				var_150_3.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_147_1.time_ - 0) / var_150_4)
				var_150_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_3.position).x, (manager.ui.mainCamera.transform.position - var_150_3.position).y, (manager.ui.mainCamera.transform.position - var_150_3.position).z)
				var_150_3.localEulerAngles.z = 0
				var_150_3.localEulerAngles.x = 0
				var_150_3.localEulerAngles = var_150_3.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				var_150_3.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_150_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_3.position).x, (manager.ui.mainCamera.transform.position - var_150_3.position).y, (manager.ui.mainCamera.transform.position - var_150_3.position).z)
				var_150_3.localEulerAngles.z = 0
				var_150_3.localEulerAngles.x = 0
				var_150_3.localEulerAngles = var_150_3.localEulerAngles
			end

			local var_150_5 = arg_147_1.actors_["10171ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.characterEffect10171ui_story == nil then
				arg_147_1.var_.characterEffect10171ui_story = var_150_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_6 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_6 and not isNil(var_150_5) then
				if arg_147_1.var_.characterEffect10171ui_story and not isNil(var_150_5) then
					arg_147_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_6 and arg_147_1.time_ < 0 + var_150_6 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.characterEffect10171ui_story then
				arg_147_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_150_8 = arg_147_1.actors_["1061ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.characterEffect1061ui_story == nil then
				arg_147_1.var_.characterEffect1061ui_story = var_150_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_9 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_9 and not isNil(var_150_8) then
				if arg_147_1.var_.characterEffect1061ui_story and not isNil(var_150_8) then
					arg_147_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_9)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_9 and arg_147_1.time_ < 0 + var_150_9 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.characterEffect1061ui_story then
				arg_147_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_150_10 = 0
			local var_150_11 = 0.175

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_12 = arg_147_1:GetWordFromCfg(324151032)
				local var_150_13 = arg_147_1:FormatText(var_150_12.content)

				arg_147_1.text_.text = var_150_13

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_15 = 7 <= 0 and var_150_11 or var_150_11 * (utf8.len(var_150_13) / 7)

				if (7 <= 0 and var_150_11 or var_150_11 * (utf8.len(var_150_13) / 7)) > 0 and var_150_11 < var_150_15 then
					arg_147_1.talkMaxDuration = var_150_15

					if var_150_15 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_15 + var_150_10
					end
				end

				arg_147_1.text_.text = var_150_13
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151032", "story_v_out_324151.awb") ~= 0 then
					local var_150_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151032", "story_v_out_324151.awb") / 1000

					if var_150_16 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_10
					end

					if var_150_12.prefab_name ~= "" and arg_147_1.actors_[var_150_12.prefab_name] ~= nil then
						local var_150_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_12.prefab_name].transform, "story_v_out_324151", "324151032", "story_v_out_324151.awb")

						arg_147_1:RecordAudio("324151032", var_150_17)
						arg_147_1:RecordAudio("324151032", var_150_17)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_324151", "324151032", "story_v_out_324151.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_324151", "324151032", "story_v_out_324151.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_18 = math.max(var_150_11, arg_147_1.talkMaxDuration)

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_18 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_10) / var_150_18

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_10 + var_150_18 and arg_147_1.time_ < var_150_10 + var_150_18 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play324151033 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 324151033
		arg_151_1.duration_ = 2.4

		local var_151_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play324151034(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1061ui_story"]) and arg_151_1.var_.characterEffect1061ui_story == nil then
				arg_151_1.var_.characterEffect1061ui_story = arg_151_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1061ui_story"]) then
				if arg_151_1.var_.characterEffect1061ui_story and not isNil(arg_151_1.actors_["1061ui_story"]) then
					arg_151_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1061ui_story"]) and arg_151_1.var_.characterEffect1061ui_story then
				arg_151_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_154_2 = arg_151_1.actors_["10171ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect10171ui_story == nil then
				arg_151_1.var_.characterEffect10171ui_story = var_154_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_3 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.characterEffect10171ui_story and not isNil(var_154_2) then
					arg_151_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_3)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect10171ui_story then
				arg_151_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_154_4 = 0
			local var_154_5 = 0.225

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(324151033)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 9 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 9)

				if (9 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 9)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151033", "story_v_out_324151.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151033", "story_v_out_324151.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_out_324151", "324151033", "story_v_out_324151.awb")

						arg_151_1:RecordAudio("324151033", var_154_11)
						arg_151_1:RecordAudio("324151033", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_324151", "324151033", "story_v_out_324151.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_324151", "324151033", "story_v_out_324151.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play324151034 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 324151034
		arg_155_1.duration_ = 7

		local var_155_0 = {
			zh = 4.2,
			ja = 7
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play324151035(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10171ui_story"]) and arg_155_1.var_.characterEffect10171ui_story == nil then
				arg_155_1.var_.characterEffect10171ui_story = arg_155_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10171ui_story"]) then
				if arg_155_1.var_.characterEffect10171ui_story and not isNil(arg_155_1.actors_["10171ui_story"]) then
					arg_155_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10171ui_story"]) and arg_155_1.var_.characterEffect10171ui_story then
				arg_155_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_158_2 = arg_155_1.actors_["1061ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect1061ui_story == nil then
				arg_155_1.var_.characterEffect1061ui_story = var_158_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_3 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.characterEffect1061ui_story and not isNil(var_158_2) then
					arg_155_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_3)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect1061ui_story then
				arg_155_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_158_4 = 0
			local var_158_5 = 0.475

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(324151034)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 19 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 19)

				if (19 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 19)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151034", "story_v_out_324151.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151034", "story_v_out_324151.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_out_324151", "324151034", "story_v_out_324151.awb")

						arg_155_1:RecordAudio("324151034", var_158_11)
						arg_155_1:RecordAudio("324151034", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_324151", "324151034", "story_v_out_324151.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_324151", "324151034", "story_v_out_324151.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_12 and arg_155_1.time_ < var_158_4 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play324151035 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 324151035
		arg_159_1.duration_ = 4.9

		local var_159_0 = {
			zh = 2.6,
			ja = 4.9
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play324151036(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1061ui_story"]) and arg_159_1.var_.characterEffect1061ui_story == nil then
				arg_159_1.var_.characterEffect1061ui_story = arg_159_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1061ui_story"]) then
				if arg_159_1.var_.characterEffect1061ui_story and not isNil(arg_159_1.actors_["1061ui_story"]) then
					arg_159_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1061ui_story"]) and arg_159_1.var_.characterEffect1061ui_story then
				arg_159_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_162_2 = arg_159_1.actors_["10171ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect10171ui_story == nil then
				arg_159_1.var_.characterEffect10171ui_story = var_162_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_3 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.characterEffect10171ui_story and not isNil(var_162_2) then
					arg_159_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_3)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect10171ui_story then
				arg_159_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_162_4 = 0
			local var_162_5 = 0.375

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(324151035)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 15 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 15)

				if (15 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 15)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151035", "story_v_out_324151.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151035", "story_v_out_324151.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_324151", "324151035", "story_v_out_324151.awb")

						arg_159_1:RecordAudio("324151035", var_162_11)
						arg_159_1:RecordAudio("324151035", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_324151", "324151035", "story_v_out_324151.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_324151", "324151035", "story_v_out_324151.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play324151036 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 324151036
		arg_163_1.duration_ = 9.57

		local var_163_0 = {
			zh = 6.866,
			ja = 9.566
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play324151037(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10171ui_story"]) and arg_163_1.var_.characterEffect10171ui_story == nil then
				arg_163_1.var_.characterEffect10171ui_story = arg_163_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10171ui_story"]) then
				if arg_163_1.var_.characterEffect10171ui_story and not isNil(arg_163_1.actors_["10171ui_story"]) then
					arg_163_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10171ui_story"]) and arg_163_1.var_.characterEffect10171ui_story then
				arg_163_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_166_2 = arg_163_1.actors_["1061ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1061ui_story == nil then
				arg_163_1.var_.characterEffect1061ui_story = var_166_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_3 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.characterEffect1061ui_story and not isNil(var_166_2) then
					arg_163_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_3)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1061ui_story then
				arg_163_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_2")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_166_4 = 0
			local var_166_5 = 0.85

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(324151036)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 34 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 34)

				if (34 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 34)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151036", "story_v_out_324151.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151036", "story_v_out_324151.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_324151", "324151036", "story_v_out_324151.awb")

						arg_163_1:RecordAudio("324151036", var_166_11)
						arg_163_1:RecordAudio("324151036", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_324151", "324151036", "story_v_out_324151.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_324151", "324151036", "story_v_out_324151.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play324151037 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 324151037
		arg_167_1.duration_ = 9

		local var_167_0 = {
			zh = 5.466,
			ja = 9
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play324151038(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.575

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(324151037)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 23 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 23)

				if (23 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 23)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151037", "story_v_out_324151.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151037", "story_v_out_324151.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_324151", "324151037", "story_v_out_324151.awb")

						arg_167_1:RecordAudio("324151037", var_170_6)
						arg_167_1:RecordAudio("324151037", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_324151", "324151037", "story_v_out_324151.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_324151", "324151037", "story_v_out_324151.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play324151038 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 324151038
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play324151039(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10171ui_story = arg_171_1.actors_["10171ui_story"].transform.localPosition

				local var_174_0 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_174_0 then
					var_174_0:EnableDynamicBone(false)
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_1)
				arg_171_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10171ui_story"].transform.position).z)
				arg_171_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10171ui_story"].transform.localEulerAngles = arg_171_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10171ui_story"].transform.position).z)
				arg_171_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10171ui_story"].transform.localEulerAngles = arg_171_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_174_2 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(true)
				end
			end

			local var_174_3 = arg_171_1.actors_["1061ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1061ui_story = var_174_3.localPosition
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_3.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_4)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_3.localPosition = Vector3.New(0, 100, 0)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			local var_174_5 = arg_171_1.actors_["10171ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect10171ui_story == nil then
				arg_171_1.var_.characterEffect10171ui_story = var_174_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_6 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_6 and not isNil(var_174_5) then
				if arg_171_1.var_.characterEffect10171ui_story and not isNil(var_174_5) then
					arg_171_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_6)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_6 and arg_171_1.time_ < 0 + var_174_6 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect10171ui_story then
				arg_171_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_174_7 = 0
			local var_174_8 = 0.925

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_7 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_9 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(324151038).content)

				arg_171_1.text_.text = var_174_9

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_11 = 37 <= 0 and var_174_8 or var_174_8 * (utf8.len(var_174_9) / 37)

				if (37 <= 0 and var_174_8 or var_174_8 * (utf8.len(var_174_9) / 37)) > 0 and var_174_8 < var_174_11 then
					arg_171_1.talkMaxDuration = var_174_11

					if var_174_11 + var_174_7 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_7
					end
				end

				arg_171_1.text_.text = var_174_9
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_8, arg_171_1.talkMaxDuration)

			if var_174_7 <= arg_171_1.time_ and arg_171_1.time_ < var_174_7 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_7) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_7 + var_174_12 and arg_171_1.time_ < var_174_7 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play324151039 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 324151039
		arg_175_1.duration_ = 5.2

		local var_175_0 = {
			zh = 2.1,
			ja = 5.2
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play324151040(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1061ui_story = arg_175_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).z)
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles = arg_175_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_175_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).z)
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles = arg_175_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1061ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1061ui_story == nil then
				arg_175_1.var_.characterEffect1061ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1061ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1061ui_story then
				arg_175_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_4 = 0
			local var_178_5 = 0.375

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(324151039)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 15 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 15)

				if (15 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 15)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151039", "story_v_out_324151.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151039", "story_v_out_324151.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_324151", "324151039", "story_v_out_324151.awb")

						arg_175_1:RecordAudio("324151039", var_178_11)
						arg_175_1:RecordAudio("324151039", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_324151", "324151039", "story_v_out_324151.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_324151", "324151039", "story_v_out_324151.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play324151040 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 324151040
		arg_179_1.duration_ = 14.03

		local var_179_0 = {
			zh = 11.266,
			ja = 14.033
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play324151041(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10171ui_story = arg_179_1.actors_["10171ui_story"].transform.localPosition

				local var_182_0 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_0 then
					var_182_0:EnableDynamicBone(false)
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10171ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_179_1.time_ - 0) / var_182_1)
				arg_179_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10171ui_story"].transform.position).z)
				arg_179_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10171ui_story"].transform.localEulerAngles = arg_179_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_179_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10171ui_story"].transform.position).z)
				arg_179_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10171ui_story"].transform.localEulerAngles = arg_179_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_182_2 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(true)
				end
			end

			local var_182_3 = arg_179_1.actors_["10171ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect10171ui_story == nil then
				arg_179_1.var_.characterEffect10171ui_story = var_182_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_4 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 and not isNil(var_182_3) then
				if arg_179_1.var_.characterEffect10171ui_story and not isNil(var_182_3) then
					arg_179_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect10171ui_story then
				arg_179_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_182_6 = arg_179_1.actors_["1061ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect1061ui_story == nil then
				arg_179_1.var_.characterEffect1061ui_story = var_182_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_7 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 and not isNil(var_182_6) then
				if arg_179_1.var_.characterEffect1061ui_story and not isNil(var_182_6) then
					arg_179_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_7)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect1061ui_story then
				arg_179_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_182_8 = 0
			local var_182_9 = 1.4

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(324151040)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 56 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 56)

				if (56 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 56)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151040", "story_v_out_324151.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151040", "story_v_out_324151.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_324151", "324151040", "story_v_out_324151.awb")

						arg_179_1:RecordAudio("324151040", var_182_15)
						arg_179_1:RecordAudio("324151040", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_324151", "324151040", "story_v_out_324151.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_324151", "324151040", "story_v_out_324151.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_16 and arg_179_1.time_ < var_182_8 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play324151041 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 324151041
		arg_183_1.duration_ = 6.5

		local var_183_0 = {
			zh = 4.333,
			ja = 6.5
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play324151042(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.55

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(324151041)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 22 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 22)

				if (22 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 22)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151041", "story_v_out_324151.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151041", "story_v_out_324151.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_324151", "324151041", "story_v_out_324151.awb")

						arg_183_1:RecordAudio("324151041", var_186_6)
						arg_183_1:RecordAudio("324151041", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_324151", "324151041", "story_v_out_324151.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_324151", "324151041", "story_v_out_324151.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play324151042 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 324151042
		arg_187_1.duration_ = 5.17

		local var_187_0 = {
			zh = 4.166,
			ja = 5.166
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play324151043(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1061ui_story"]) and arg_187_1.var_.characterEffect1061ui_story == nil then
				arg_187_1.var_.characterEffect1061ui_story = arg_187_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1061ui_story"]) then
				if arg_187_1.var_.characterEffect1061ui_story and not isNil(arg_187_1.actors_["1061ui_story"]) then
					arg_187_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1061ui_story"]) and arg_187_1.var_.characterEffect1061ui_story then
				arg_187_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_190_2 = arg_187_1.actors_["10171ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect10171ui_story == nil then
				arg_187_1.var_.characterEffect10171ui_story = var_190_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_3 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.characterEffect10171ui_story and not isNil(var_190_2) then
					arg_187_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_3)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect10171ui_story then
				arg_187_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_190_4 = 0
			local var_190_5 = 0.525

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(324151042)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 21 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 21)

				if (21 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 21)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151042", "story_v_out_324151.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151042", "story_v_out_324151.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_324151", "324151042", "story_v_out_324151.awb")

						arg_187_1:RecordAudio("324151042", var_190_11)
						arg_187_1:RecordAudio("324151042", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_324151", "324151042", "story_v_out_324151.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_324151", "324151042", "story_v_out_324151.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play324151043 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 324151043
		arg_191_1.duration_ = 17.8

		local var_191_0 = {
			zh = 11.833,
			ja = 17.8
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play324151044(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_194_0 = 0
			local var_194_1 = 1.25

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(324151043)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 50 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 50)

				if (50 <= 0 and var_194_1 or var_194_1 * (utf8.len(var_194_3) / 50)) > 0 and var_194_1 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151043", "story_v_out_324151.awb") ~= 0 then
					local var_194_6 = manager.audio:GetVoiceLength("story_v_out_324151", "324151043", "story_v_out_324151.awb") / 1000

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end

					if var_194_2.prefab_name ~= "" and arg_191_1.actors_[var_194_2.prefab_name] ~= nil then
						local var_194_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_2.prefab_name].transform, "story_v_out_324151", "324151043", "story_v_out_324151.awb")

						arg_191_1:RecordAudio("324151043", var_194_7)
						arg_191_1:RecordAudio("324151043", var_194_7)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_324151", "324151043", "story_v_out_324151.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_324151", "324151043", "story_v_out_324151.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play324151044 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 324151044
		arg_195_1.duration_ = 16.5

		local var_195_0 = {
			zh = 5.233,
			ja = 16.5
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play324151045(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.6

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(324151044)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 24 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 24)

				if (24 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 24)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151044", "story_v_out_324151.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151044", "story_v_out_324151.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_324151", "324151044", "story_v_out_324151.awb")

						arg_195_1:RecordAudio("324151044", var_198_6)
						arg_195_1:RecordAudio("324151044", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_324151", "324151044", "story_v_out_324151.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_324151", "324151044", "story_v_out_324151.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play324151045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 324151045
		arg_199_1.duration_ = 7.43

		local var_199_0 = {
			zh = 3.166,
			ja = 7.433
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play324151046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10171ui_story"]) and arg_199_1.var_.characterEffect10171ui_story == nil then
				arg_199_1.var_.characterEffect10171ui_story = arg_199_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10171ui_story"]) then
				if arg_199_1.var_.characterEffect10171ui_story and not isNil(arg_199_1.actors_["10171ui_story"]) then
					arg_199_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10171ui_story"]) and arg_199_1.var_.characterEffect10171ui_story then
				arg_199_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_202_2 = arg_199_1.actors_["1061ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1061ui_story == nil then
				arg_199_1.var_.characterEffect1061ui_story = var_202_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_3 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.characterEffect1061ui_story and not isNil(var_202_2) then
					arg_199_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_3)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1061ui_story then
				arg_199_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_202_4 = 0
			local var_202_5 = 0.375

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(324151045)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 15 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 15)

				if (15 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 15)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151045", "story_v_out_324151.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151045", "story_v_out_324151.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_324151", "324151045", "story_v_out_324151.awb")

						arg_199_1:RecordAudio("324151045", var_202_11)
						arg_199_1:RecordAudio("324151045", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_324151", "324151045", "story_v_out_324151.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_324151", "324151045", "story_v_out_324151.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play324151046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 324151046
		arg_203_1.duration_ = 8.4

		local var_203_0 = {
			zh = 3.866,
			ja = 8.4
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play324151047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1061ui_story"]) and arg_203_1.var_.characterEffect1061ui_story == nil then
				arg_203_1.var_.characterEffect1061ui_story = arg_203_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1061ui_story"]) then
				if arg_203_1.var_.characterEffect1061ui_story and not isNil(arg_203_1.actors_["1061ui_story"]) then
					arg_203_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1061ui_story"]) and arg_203_1.var_.characterEffect1061ui_story then
				arg_203_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_206_2 = arg_203_1.actors_["10171ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.characterEffect10171ui_story == nil then
				arg_203_1.var_.characterEffect10171ui_story = var_206_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_3 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.characterEffect10171ui_story and not isNil(var_206_2) then
					arg_203_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_3)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.characterEffect10171ui_story then
				arg_203_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_206_4 = 0
			local var_206_5 = 0.475

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(324151046)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 19 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 19)

				if (19 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 19)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151046", "story_v_out_324151.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151046", "story_v_out_324151.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_324151", "324151046", "story_v_out_324151.awb")

						arg_203_1:RecordAudio("324151046", var_206_11)
						arg_203_1:RecordAudio("324151046", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_324151", "324151046", "story_v_out_324151.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_324151", "324151046", "story_v_out_324151.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play324151047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 324151047
		arg_207_1.duration_ = 7.4

		local var_207_0 = {
			zh = 6.9,
			ja = 7.4
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play324151048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10171ui_story"]) and arg_207_1.var_.characterEffect10171ui_story == nil then
				arg_207_1.var_.characterEffect10171ui_story = arg_207_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10171ui_story"]) then
				if arg_207_1.var_.characterEffect10171ui_story and not isNil(arg_207_1.actors_["10171ui_story"]) then
					arg_207_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10171ui_story"]) and arg_207_1.var_.characterEffect10171ui_story then
				arg_207_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_210_2 = arg_207_1.actors_["1061ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect1061ui_story == nil then
				arg_207_1.var_.characterEffect1061ui_story = var_210_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_3 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.characterEffect1061ui_story and not isNil(var_210_2) then
					arg_207_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_3)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect1061ui_story then
				arg_207_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action43034")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_210_4 = 0
			local var_210_5 = 0.9

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(324151047)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 36 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 36)

				if (36 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 36)) > 0 and var_210_5 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151047", "story_v_out_324151.awb") ~= 0 then
					local var_210_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151047", "story_v_out_324151.awb") / 1000

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end

					if var_210_6.prefab_name ~= "" and arg_207_1.actors_[var_210_6.prefab_name] ~= nil then
						local var_210_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_6.prefab_name].transform, "story_v_out_324151", "324151047", "story_v_out_324151.awb")

						arg_207_1:RecordAudio("324151047", var_210_11)
						arg_207_1:RecordAudio("324151047", var_210_11)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_324151", "324151047", "story_v_out_324151.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_324151", "324151047", "story_v_out_324151.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_12 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_12

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_12 and arg_207_1.time_ < var_210_4 + var_210_12 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play324151048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 324151048
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play324151049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10171ui_story = arg_211_1.actors_["10171ui_story"].transform.localPosition

				local var_214_0 = GameObjectTools.GetOrAddComponent(arg_211_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_214_0 then
					var_214_0:EnableDynamicBone(false)
				end
			end

			local var_214_1 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 then
				arg_211_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_1)
				arg_211_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10171ui_story"].transform.position).z)
				arg_211_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["10171ui_story"].transform.localEulerAngles = arg_211_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["10171ui_story"].transform.position).z)
				arg_211_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["10171ui_story"].transform.localEulerAngles = arg_211_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_214_2 = GameObjectTools.GetOrAddComponent(arg_211_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(true)
				end
			end

			local var_214_3 = arg_211_1.actors_["1061ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1061ui_story = var_214_3.localPosition
			end

			local var_214_4 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				var_214_3.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_4)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_3.localPosition = Vector3.New(0, 100, 0)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			local var_214_5 = arg_211_1.actors_["10171ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.characterEffect10171ui_story == nil then
				arg_211_1.var_.characterEffect10171ui_story = var_214_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_6 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_6 and not isNil(var_214_5) then
				if arg_211_1.var_.characterEffect10171ui_story and not isNil(var_214_5) then
					arg_211_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_211_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_6)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_6 and arg_211_1.time_ < 0 + var_214_6 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.characterEffect10171ui_story then
				arg_211_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_211_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_214_7 = 0
			local var_214_8 = 1.575

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_9 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(324151048).content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 63 <= 0 and var_214_8 or var_214_8 * (utf8.len(var_214_9) / 63)

				if (63 <= 0 and var_214_8 or var_214_8 * (utf8.len(var_214_9) / 63)) > 0 and var_214_8 < var_214_11 then
					arg_211_1.talkMaxDuration = var_214_11

					if var_214_11 + var_214_7 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_7
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_8, arg_211_1.talkMaxDuration)

			if var_214_7 <= arg_211_1.time_ and arg_211_1.time_ < var_214_7 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_7) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_7 + var_214_12 and arg_211_1.time_ < var_214_7 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play324151049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 324151049
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play324151050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.25

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(324151049).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 50 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 50)

				if (50 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 50)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play324151050 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 324151050
		arg_219_1.duration_ = 2.4

		local var_219_0 = {
			zh = 1.566,
			ja = 2.4
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play324151051(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1061ui_story = arg_219_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).z)
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles = arg_219_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_219_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1061ui_story"].transform.position).z)
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1061ui_story"].transform.localEulerAngles = arg_219_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1061ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1061ui_story == nil then
				arg_219_1.var_.characterEffect1061ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1061ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1061ui_story then
				arg_219_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_222_4 = 0
			local var_222_5 = 0.175

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(324151050)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 7 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 7)

				if (7 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 7)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151050", "story_v_out_324151.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151050", "story_v_out_324151.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_out_324151", "324151050", "story_v_out_324151.awb")

						arg_219_1:RecordAudio("324151050", var_222_11)
						arg_219_1:RecordAudio("324151050", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_324151", "324151050", "story_v_out_324151.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_324151", "324151050", "story_v_out_324151.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_5, arg_219_1.talkMaxDuration)

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_4) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_4 + var_222_12 and arg_219_1.time_ < var_222_4 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play324151051 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 324151051
		arg_223_1.duration_ = 9.5

		local var_223_0 = {
			zh = 8.333,
			ja = 9.5
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play324151052(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10171ui_story = arg_223_1.actors_["10171ui_story"].transform.localPosition

				local var_226_0 = GameObjectTools.GetOrAddComponent(arg_223_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_226_0 then
					var_226_0:EnableDynamicBone(false)
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10171ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_223_1.time_ - 0) / var_226_1)
				arg_223_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10171ui_story"].transform.position).z)
				arg_223_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10171ui_story"].transform.localEulerAngles = arg_223_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_223_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10171ui_story"].transform.position).z)
				arg_223_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10171ui_story"].transform.localEulerAngles = arg_223_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_226_2 = GameObjectTools.GetOrAddComponent(arg_223_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_226_2 then
					var_226_2:EnableDynamicBone(true)
				end
			end

			local var_226_3 = arg_223_1.actors_["10171ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_3) and arg_223_1.var_.characterEffect10171ui_story == nil then
				arg_223_1.var_.characterEffect10171ui_story = var_226_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_4 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 and not isNil(var_226_3) then
				if arg_223_1.var_.characterEffect10171ui_story and not isNil(var_226_3) then
					arg_223_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 and not isNil(var_226_3) and arg_223_1.var_.characterEffect10171ui_story then
				arg_223_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_226_6 = arg_223_1.actors_["1061ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect1061ui_story == nil then
				arg_223_1.var_.characterEffect1061ui_story = var_226_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_7 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 and not isNil(var_226_6) then
				if arg_223_1.var_.characterEffect1061ui_story and not isNil(var_226_6) then
					arg_223_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_7)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect1061ui_story then
				arg_223_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_226_8 = 0
			local var_226_9 = 0.975

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_10 = arg_223_1:GetWordFromCfg(324151051)
				local var_226_11 = arg_223_1:FormatText(var_226_10.content)

				arg_223_1.text_.text = var_226_11

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_13 = 39 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 39)

				if (39 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 39)) > 0 and var_226_9 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_8
					end
				end

				arg_223_1.text_.text = var_226_11
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151051", "story_v_out_324151.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151051", "story_v_out_324151.awb") / 1000

					if var_226_14 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_8
					end

					if var_226_10.prefab_name ~= "" and arg_223_1.actors_[var_226_10.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_10.prefab_name].transform, "story_v_out_324151", "324151051", "story_v_out_324151.awb")

						arg_223_1:RecordAudio("324151051", var_226_15)
						arg_223_1:RecordAudio("324151051", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_324151", "324151051", "story_v_out_324151.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_324151", "324151051", "story_v_out_324151.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_9, arg_223_1.talkMaxDuration)

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_8) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_8 + var_226_16 and arg_223_1.time_ < var_226_8 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play324151052 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 324151052
		arg_227_1.duration_ = 11

		local var_227_0 = {
			zh = 11,
			ja = 10.9
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play324151053(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 1.3

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(324151052)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 52 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 52)

				if (52 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 52)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151052", "story_v_out_324151.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151052", "story_v_out_324151.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_324151", "324151052", "story_v_out_324151.awb")

						arg_227_1:RecordAudio("324151052", var_230_6)
						arg_227_1:RecordAudio("324151052", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_324151", "324151052", "story_v_out_324151.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_324151", "324151052", "story_v_out_324151.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play324151053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 324151053
		arg_231_1.duration_ = 14.33

		local var_231_0 = {
			zh = 9.566,
			ja = 14.333
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play324151054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1061ui_story"]) and arg_231_1.var_.characterEffect1061ui_story == nil then
				arg_231_1.var_.characterEffect1061ui_story = arg_231_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1061ui_story"]) then
				if arg_231_1.var_.characterEffect1061ui_story and not isNil(arg_231_1.actors_["1061ui_story"]) then
					arg_231_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1061ui_story"]) and arg_231_1.var_.characterEffect1061ui_story then
				arg_231_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_234_2 = arg_231_1.actors_["10171ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.characterEffect10171ui_story == nil then
				arg_231_1.var_.characterEffect10171ui_story = var_234_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_3 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.characterEffect10171ui_story and not isNil(var_234_2) then
					arg_231_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_3)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.characterEffect10171ui_story then
				arg_231_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_234_4 = 0
			local var_234_5 = 0.975

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(324151053)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 39 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 39)

				if (39 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 39)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151053", "story_v_out_324151.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151053", "story_v_out_324151.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_324151", "324151053", "story_v_out_324151.awb")

						arg_231_1:RecordAudio("324151053", var_234_11)
						arg_231_1:RecordAudio("324151053", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_324151", "324151053", "story_v_out_324151.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_324151", "324151053", "story_v_out_324151.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play324151054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 324151054
		arg_235_1.duration_ = 4.5

		local var_235_0 = {
			zh = 2.666,
			ja = 4.5
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play324151055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10171ui_story"]) and arg_235_1.var_.characterEffect10171ui_story == nil then
				arg_235_1.var_.characterEffect10171ui_story = arg_235_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10171ui_story"]) then
				if arg_235_1.var_.characterEffect10171ui_story and not isNil(arg_235_1.actors_["10171ui_story"]) then
					arg_235_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10171ui_story"]) and arg_235_1.var_.characterEffect10171ui_story then
				arg_235_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_238_2 = arg_235_1.actors_["1061ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.characterEffect1061ui_story == nil then
				arg_235_1.var_.characterEffect1061ui_story = var_238_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_3 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.characterEffect1061ui_story and not isNil(var_238_2) then
					arg_235_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_3)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.characterEffect1061ui_story then
				arg_235_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_238_4 = 0
			local var_238_5 = 0.3

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(324151054)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 12 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 12)

				if (12 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 12)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151054", "story_v_out_324151.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151054", "story_v_out_324151.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_out_324151", "324151054", "story_v_out_324151.awb")

						arg_235_1:RecordAudio("324151054", var_238_11)
						arg_235_1:RecordAudio("324151054", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_324151", "324151054", "story_v_out_324151.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_324151", "324151054", "story_v_out_324151.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_12 and arg_235_1.time_ < var_238_4 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play324151055 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 324151055
		arg_239_1.duration_ = 11.63

		local var_239_0 = {
			zh = 9.533,
			ja = 11.633
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play324151056(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1061ui_story"]) and arg_239_1.var_.characterEffect1061ui_story == nil then
				arg_239_1.var_.characterEffect1061ui_story = arg_239_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1061ui_story"]) then
				if arg_239_1.var_.characterEffect1061ui_story and not isNil(arg_239_1.actors_["1061ui_story"]) then
					arg_239_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1061ui_story"]) and arg_239_1.var_.characterEffect1061ui_story then
				arg_239_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_242_2 = arg_239_1.actors_["10171ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.characterEffect10171ui_story == nil then
				arg_239_1.var_.characterEffect10171ui_story = var_242_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_3 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.characterEffect10171ui_story and not isNil(var_242_2) then
					arg_239_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_3)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.characterEffect10171ui_story then
				arg_239_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_242_4 = 0
			local var_242_5 = 1.025

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(324151055)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 41 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 41)

				if (41 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 41)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151055", "story_v_out_324151.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151055", "story_v_out_324151.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_324151", "324151055", "story_v_out_324151.awb")

						arg_239_1:RecordAudio("324151055", var_242_11)
						arg_239_1:RecordAudio("324151055", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_324151", "324151055", "story_v_out_324151.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_324151", "324151055", "story_v_out_324151.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play324151056 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 324151056
		arg_243_1.duration_ = 8.8

		local var_243_0 = {
			zh = 7.533,
			ja = 8.8
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play324151057(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_246_0 = 0
			local var_246_1 = 0.85

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(324151056)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 34 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_3) / 34)

				if (34 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_3) / 34)) > 0 and var_246_1 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151056", "story_v_out_324151.awb") ~= 0 then
					local var_246_6 = manager.audio:GetVoiceLength("story_v_out_324151", "324151056", "story_v_out_324151.awb") / 1000

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end

					if var_246_2.prefab_name ~= "" and arg_243_1.actors_[var_246_2.prefab_name] ~= nil then
						local var_246_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_2.prefab_name].transform, "story_v_out_324151", "324151056", "story_v_out_324151.awb")

						arg_243_1:RecordAudio("324151056", var_246_7)
						arg_243_1:RecordAudio("324151056", var_246_7)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_324151", "324151056", "story_v_out_324151.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_324151", "324151056", "story_v_out_324151.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_8 and arg_243_1.time_ < var_246_0 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play324151057 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 324151057
		arg_247_1.duration_ = 6.37

		local var_247_0 = {
			zh = 6.366,
			ja = 5.966
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play324151058(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_9001
			local var_250_9000

			if arg_247_1.bgs_.J08 == nil then
				local var_250_0 = Object.Instantiate(arg_247_1.paintGo_)

				var_250_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J08")
				var_250_0.name = "J08"
				var_250_0.transform.parent = arg_247_1.stage_.transform
				var_250_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.bgs_.J08 = var_250_0
			end

			if 1.73333333333333 < arg_247_1.time_ and arg_247_1.time_ <= 1.73333333333333 + arg_250_0 then
				local var_250_1 = arg_247_1.bgs_.J08

				arg_247_1.bgs_.J08.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_250_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_2 = var_250_1:GetComponent("SpriteRenderer")

				if var_250_2 and var_250_2.sprite then
					local var_250_3 = 2 * (var_250_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_250_1.transform.localScale = Vector3.New(var_250_3 / var_250_2.sprite.bounds.size.y < var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x and var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x or var_250_3 / var_250_2.sprite.bounds.size.y, var_250_3 / var_250_2.sprite.bounds.size.y < var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x and var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x or var_250_3 / var_250_2.sprite.bounds.size.y, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "J08" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_4 = 1.73333333333333

			if 1.73333333333333 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.allBtn_.enabled = false
			end

			if arg_247_1.time_ >= var_250_4 + 0.3 and arg_247_1.time_ < var_250_4 + 0.3 + arg_250_0 then
				arg_247_1.allBtn_.enabled = true
			end

			local var_250_5 = 0

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_6 = 1.73333333333333

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_6 then
				local var_250_7 = Color.New(0, 0, 0)

				var_250_7.a = Mathf.Lerp(0, 1, (arg_247_1.time_ - var_250_5) / var_250_6)
				arg_247_1.mask_.color = var_250_7
			end

			if arg_247_1.time_ >= var_250_5 + var_250_6 and arg_247_1.time_ < var_250_5 + var_250_6 + arg_250_0 then
				local var_250_8 = Color.New(0, 0, 0)

				var_250_8.a = 1
				arg_247_1.mask_.color = var_250_8
			end

			local var_250_9 = 1.73333333333333

			if 1.73333333333333 < arg_247_1.time_ and arg_247_1.time_ <= var_250_9 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_10 = 2

			if var_250_9 <= arg_247_1.time_ and arg_247_1.time_ < var_250_9 + var_250_10 then
				local var_250_11 = Color.New(0, 0, 0)

				var_250_11.a = Mathf.Lerp(1, 0, (arg_247_1.time_ - var_250_9) / var_250_10)
				arg_247_1.mask_.color = var_250_11
			end

			if arg_247_1.time_ >= var_250_9 + var_250_10 and arg_247_1.time_ < var_250_9 + var_250_10 + arg_250_0 then
				local var_250_12 = Color.New(0, 0, 0)

				arg_247_1.mask_.enabled = false
				var_250_12.a = 0
				arg_247_1.mask_.color = var_250_12
			end

			local var_250_13 = arg_247_1.actors_["1061ui_story"].transform

			if 1.73333333333333 < arg_247_1.time_ and arg_247_1.time_ <= 1.73333333333333 + arg_250_0 then
				arg_247_1.var_.moveOldPos1061ui_story = var_250_13.localPosition
			end

			local var_250_14 = 0.001

			if 1.73333333333333 <= arg_247_1.time_ and arg_247_1.time_ < 1.73333333333333 + var_250_14 then
				var_250_13.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_247_1.time_ - 1.73333333333333) / var_250_14)
				var_250_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_13.position).x, (manager.ui.mainCamera.transform.position - var_250_13.position).y, (manager.ui.mainCamera.transform.position - var_250_13.position).z)
				var_250_13.localEulerAngles.z = 0
				var_250_13.localEulerAngles.x = 0
				var_250_13.localEulerAngles = var_250_13.localEulerAngles
			end

			if arg_247_1.time_ >= 1.73333333333333 + var_250_14 and arg_247_1.time_ < 1.73333333333333 + var_250_14 + arg_250_0 then
				var_250_13.localPosition = Vector3.New(0, 100, 0)
				var_250_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_13.position).x, (manager.ui.mainCamera.transform.position - var_250_13.position).y, (manager.ui.mainCamera.transform.position - var_250_13.position).z)
				var_250_13.localEulerAngles.z = 0
				var_250_13.localEulerAngles.x = 0
				var_250_13.localEulerAngles = var_250_13.localEulerAngles
			end

			local var_250_15 = arg_247_1.actors_["10171ui_story"].transform

			if 1.73333333333333 < arg_247_1.time_ and arg_247_1.time_ <= 1.73333333333333 + arg_250_0 then
				arg_247_1.var_.moveOldPos10171ui_story = var_250_15.localPosition

				local var_250_16 = GameObjectTools.GetOrAddComponent(var_250_15.gameObject, typeof(DynamicBoneHelper))

				if var_250_16 then
					var_250_16:EnableDynamicBone(false)
				end
			end

			local var_250_17 = 0.001

			if 1.73333333333333 <= arg_247_1.time_ and arg_247_1.time_ < 1.73333333333333 + var_250_17 then
				var_250_15.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_247_1.time_ - 1.73333333333333) / var_250_17)
				var_250_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_15.position).x, (manager.ui.mainCamera.transform.position - var_250_15.position).y, (manager.ui.mainCamera.transform.position - var_250_15.position).z)
				var_250_15.localEulerAngles.z = 0
				var_250_15.localEulerAngles.x = 0
				var_250_15.localEulerAngles = var_250_15.localEulerAngles
			end

			if arg_247_1.time_ >= 1.73333333333333 + var_250_17 and arg_247_1.time_ < 1.73333333333333 + var_250_17 + arg_250_0 then
				var_250_15.localPosition = Vector3.New(0, 100, 0)
				var_250_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_15.position).x, (manager.ui.mainCamera.transform.position - var_250_15.position).y, (manager.ui.mainCamera.transform.position - var_250_15.position).z)
				var_250_15.localEulerAngles.z = 0
				var_250_15.localEulerAngles.x = 0
				var_250_15.localEulerAngles = var_250_15.localEulerAngles

				local var_250_18 = GameObjectTools.GetOrAddComponent(var_250_15.gameObject, typeof(DynamicBoneHelper))

				if var_250_18 then
					var_250_18:EnableDynamicBone(true)
				end
			end

			local var_250_19 = arg_247_1.actors_["1061ui_story"]

			if 1.73333333333333 < arg_247_1.time_ and arg_247_1.time_ <= 1.73333333333333 + arg_250_0 and not isNil(var_250_19) and arg_247_1.var_.characterEffect1061ui_story == nil then
				arg_247_1.var_.characterEffect1061ui_story = var_250_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_20 = 0.200000002980232

			if 1.73333333333333 <= arg_247_1.time_ and arg_247_1.time_ < 1.73333333333333 + var_250_20 and not isNil(var_250_19) then
				if arg_247_1.var_.characterEffect1061ui_story and not isNil(var_250_19) then
					arg_247_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 1.73333333333333) / var_250_20)
				end
			end

			if arg_247_1.time_ >= 1.73333333333333 + var_250_20 and arg_247_1.time_ < 1.73333333333333 + var_250_20 + arg_250_0 and not isNil(var_250_19) and arg_247_1.var_.characterEffect1061ui_story then
				arg_247_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 1.73333333333333 < arg_247_1.time_ and arg_247_1.time_ <= 1.73333333333333 + arg_250_0 then
				local var_250_21 = arg_247_1.var_.effect23231

				if not arg_247_1.var_.effect23231 then
					var_250_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_soundonly_keep"), manager.ui.mainCamera.transform)
					var_250_21.name = "23231"
					arg_247_1.var_.effect23231 = var_250_21
				else
					var_250_21.transform:SetParent(var_250_9001)
				end

				var_250_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_250_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.73333333333333 < arg_247_1.time_ and arg_247_1.time_ <= 1.73333333333333 + arg_250_0 then
				local var_250_23 = arg_247_1.var_.effect32421

				if not arg_247_1.var_.effect32421 then
					var_250_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), manager.ui.mainCamera.transform)
					var_250_23.name = "32421"
					arg_247_1.var_.effect32421 = var_250_23
				else
					var_250_23.transform:SetParent(var_250_9000)
				end

				var_250_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_250_23.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_250_23.transform.localScale = Vector3.New(var_250_23.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_250_23.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_250_23.transform.localScale.z)
			end

			local var_250_25 = 1.73333333333333

			arg_247_1.isInRecall_ = false

			if var_250_25 < arg_247_1.time_ and arg_247_1.time_ <= var_250_25 + arg_250_0 then
				arg_247_1.screenFilterGo_:SetActive(false)

				for iter_250_2, iter_250_3 in pairs(arg_247_1.actors_) do
					for iter_250_4, iter_250_5 in ipairs((iter_250_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_250_5.color = iter_250_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_250_26 = 0.034000001847744

			if var_250_25 <= arg_247_1.time_ and arg_247_1.time_ < var_250_25 + var_250_26 then
				arg_247_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_247_1.time_ - var_250_25) / var_250_26)
			end

			if arg_247_1.time_ >= var_250_25 + var_250_26 and arg_247_1.time_ < var_250_25 + var_250_26 + arg_250_0 then
				arg_247_1.screenFilterEffect_.weight = 0
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_27 = 3.3
			local var_250_28 = 0.225

			if 3.3 < arg_247_1.time_ and arg_247_1.time_ <= var_250_27 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_29 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_29:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_30 = arg_247_1:GetWordFromCfg(324151057)
				local var_250_31 = arg_247_1:FormatText(var_250_30.content)

				arg_247_1.text_.text = var_250_31

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_33 = 9 <= 0 and var_250_28 or var_250_28 * (utf8.len(var_250_31) / 9)

				if (9 <= 0 and var_250_28 or var_250_28 * (utf8.len(var_250_31) / 9)) > 0 and var_250_28 < var_250_33 then
					arg_247_1.talkMaxDuration = var_250_33
					var_250_27 = var_250_27 + 0.3

					if var_250_33 + var_250_27 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_33 + var_250_27
					end
				end

				arg_247_1.text_.text = var_250_31
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151057", "story_v_out_324151.awb") ~= 0 then
					local var_250_34 = manager.audio:GetVoiceLength("story_v_out_324151", "324151057", "story_v_out_324151.awb") / 1000

					if var_250_34 + var_250_27 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_34 + var_250_27
					end

					if var_250_30.prefab_name ~= "" and arg_247_1.actors_[var_250_30.prefab_name] ~= nil then
						local var_250_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_30.prefab_name].transform, "story_v_out_324151", "324151057", "story_v_out_324151.awb")

						arg_247_1:RecordAudio("324151057", var_250_35)
						arg_247_1:RecordAudio("324151057", var_250_35)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_324151", "324151057", "story_v_out_324151.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_324151", "324151057", "story_v_out_324151.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_36 = var_250_27 + 0.3
			local var_250_37 = math.max(var_250_28, arg_247_1.talkMaxDuration)

			if var_250_27 + 0.3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_36 + var_250_37 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_36) / var_250_37

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_36 + var_250_37 and arg_247_1.time_ < var_250_36 + var_250_37 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play324151058 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 324151058
		arg_253_1.duration_ = 3.23

		local var_253_0 = {
			zh = 2.79966666666667,
			ja = 3.23266666666667
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play324151059(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if arg_253_1.bgs_.J13f == nil then
				local var_256_0 = Object.Instantiate(arg_253_1.paintGo_)

				var_256_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J13f")
				var_256_0.name = "J13f"
				var_256_0.transform.parent = arg_253_1.stage_.transform
				var_256_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.bgs_.J13f = var_256_0
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				local var_256_1 = arg_253_1.bgs_.J13f

				arg_253_1.bgs_.J13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_256_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_256_2 = var_256_1:GetComponent("SpriteRenderer")

				if var_256_2 and var_256_2.sprite then
					local var_256_3 = 2 * (var_256_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_256_1.transform.localScale = Vector3.New(var_256_3 / var_256_2.sprite.bounds.size.y < var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x and var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x or var_256_3 / var_256_2.sprite.bounds.size.y, var_256_3 / var_256_2.sprite.bounds.size.y < var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x and var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x or var_256_3 / var_256_2.sprite.bounds.size.y, 0)
				end

				for iter_256_0, iter_256_1 in pairs(arg_253_1.bgs_) do
					if iter_256_0 ~= "J13f" then
						iter_256_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_256_4 = 0

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.allBtn_.enabled = false
			end

			if arg_253_1.time_ >= var_256_4 + 0.3 and arg_253_1.time_ < var_256_4 + 0.3 + arg_256_0 then
				arg_253_1.allBtn_.enabled = true
			end

			local var_256_5 = 0

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_6 = 1.49166666666667

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_6 then
				local var_256_7 = Color.New(0, 0, 0)

				var_256_7.a = Mathf.Lerp(1, 0, (arg_253_1.time_ - var_256_5) / var_256_6)
				arg_253_1.mask_.color = var_256_7
			end

			if arg_253_1.time_ >= var_256_5 + var_256_6 and arg_253_1.time_ < var_256_5 + var_256_6 + arg_256_0 then
				local var_256_8 = Color.New(0, 0, 0)

				arg_253_1.mask_.enabled = false
				var_256_8.a = 0
				arg_253_1.mask_.color = var_256_8
			end

			if arg_253_1.frameCnt_ <= 1 then
				arg_253_1.dialog_:SetActive(false)
			end

			local var_256_9 = 1.36666666666667
			local var_256_10 = 0.125

			if 1.36666666666667 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0

				arg_253_1.dialog_:SetActive(true)

				arg_253_1.dialogCg_.alpha = 0

				local var_256_11 = LeanTween.value(arg_253_1.dialog_, 0, 1, 0.3)

				var_256_11:setOnUpdate(LuaHelper.FloatAction(function(arg_257_0)
					arg_253_1.dialogCg_.alpha = arg_257_0
				end))
				var_256_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_253_1.dialog_)
					var_256_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_253_1.duration_ = arg_253_1.duration_ + 0.3

				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_12 = arg_253_1:GetWordFromCfg(324151058)
				local var_256_13 = arg_253_1:FormatText(var_256_12.content)

				arg_253_1.text_.text = var_256_13

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_15 = 5 <= 0 and var_256_10 or var_256_10 * (utf8.len(var_256_13) / 5)

				if (5 <= 0 and var_256_10 or var_256_10 * (utf8.len(var_256_13) / 5)) > 0 and var_256_10 < var_256_15 then
					arg_253_1.talkMaxDuration = var_256_15
					var_256_9 = var_256_9 + 0.3

					if var_256_15 + var_256_9 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_15 + var_256_9
					end
				end

				arg_253_1.text_.text = var_256_13
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151058", "story_v_out_324151.awb") ~= 0 then
					local var_256_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151058", "story_v_out_324151.awb") / 1000

					if var_256_16 + var_256_9 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_16 + var_256_9
					end

					if var_256_12.prefab_name ~= "" and arg_253_1.actors_[var_256_12.prefab_name] ~= nil then
						local var_256_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_12.prefab_name].transform, "story_v_out_324151", "324151058", "story_v_out_324151.awb")

						arg_253_1:RecordAudio("324151058", var_256_17)
						arg_253_1:RecordAudio("324151058", var_256_17)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_324151", "324151058", "story_v_out_324151.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_324151", "324151058", "story_v_out_324151.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_18 = var_256_9 + 0.3
			local var_256_19 = math.max(var_256_10, arg_253_1.talkMaxDuration)

			if var_256_9 + 0.3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_18 + var_256_19 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_18) / var_256_19

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_18 + var_256_19 and arg_253_1.time_ < var_256_18 + var_256_19 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play324151059 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 324151059
		arg_259_1.duration_ = 2.07

		local var_259_0 = {
			zh = 2.033,
			ja = 2.066
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play324151060(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if arg_259_1.bgs_.J23f == nil then
				local var_262_0 = Object.Instantiate(arg_259_1.paintGo_)

				var_262_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J23f")
				var_262_0.name = "J23f"
				var_262_0.transform.parent = arg_259_1.stage_.transform
				var_262_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.bgs_.J23f = var_262_0
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				local var_262_1 = arg_259_1.bgs_.J23f

				arg_259_1.bgs_.J23f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_262_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_262_2 = var_262_1:GetComponent("SpriteRenderer")

				if var_262_2 and var_262_2.sprite then
					local var_262_3 = 2 * (var_262_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_262_1.transform.localScale = Vector3.New(var_262_3 / var_262_2.sprite.bounds.size.y < var_262_3 * manager.ui.mainCameraCom_.aspect / var_262_2.sprite.bounds.size.x and var_262_3 * manager.ui.mainCameraCom_.aspect / var_262_2.sprite.bounds.size.x or var_262_3 / var_262_2.sprite.bounds.size.y, var_262_3 / var_262_2.sprite.bounds.size.y < var_262_3 * manager.ui.mainCameraCom_.aspect / var_262_2.sprite.bounds.size.x and var_262_3 * manager.ui.mainCameraCom_.aspect / var_262_2.sprite.bounds.size.x or var_262_3 / var_262_2.sprite.bounds.size.y, 0)
				end

				for iter_262_0, iter_262_1 in pairs(arg_259_1.bgs_) do
					if iter_262_0 ~= "J23f" then
						iter_262_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_262_4 = 0

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.allBtn_.enabled = false
			end

			if arg_259_1.time_ >= var_262_4 + 0.3 and arg_259_1.time_ < var_262_4 + 0.3 + arg_262_0 then
				arg_259_1.allBtn_.enabled = true
			end

			local var_262_5 = 0

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_6 = 1

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_6 then
				local var_262_7 = Color.New(0, 0, 0)

				var_262_7.a = Mathf.Lerp(1, 0, (arg_259_1.time_ - var_262_5) / var_262_6)
				arg_259_1.mask_.color = var_262_7
			end

			if arg_259_1.time_ >= var_262_5 + var_262_6 and arg_259_1.time_ < var_262_5 + var_262_6 + arg_262_0 then
				local var_262_8 = Color.New(0, 0, 0)

				arg_259_1.mask_.enabled = false
				var_262_8.a = 0
				arg_259_1.mask_.color = var_262_8
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_9 = 1
			local var_262_10 = 0.05

			if 1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_11 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_11:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_12 = arg_259_1:GetWordFromCfg(324151059)
				local var_262_13 = arg_259_1:FormatText(var_262_12.content)

				arg_259_1.text_.text = var_262_13

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_15 = 2 <= 0 and var_262_10 or var_262_10 * (utf8.len(var_262_13) / 2)

				if (2 <= 0 and var_262_10 or var_262_10 * (utf8.len(var_262_13) / 2)) > 0 and var_262_10 < var_262_15 then
					arg_259_1.talkMaxDuration = var_262_15
					var_262_9 = var_262_9 + 0.3

					if var_262_15 + var_262_9 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_15 + var_262_9
					end
				end

				arg_259_1.text_.text = var_262_13
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151059", "story_v_out_324151.awb") ~= 0 then
					local var_262_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151059", "story_v_out_324151.awb") / 1000

					if var_262_16 + var_262_9 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_16 + var_262_9
					end

					if var_262_12.prefab_name ~= "" and arg_259_1.actors_[var_262_12.prefab_name] ~= nil then
						local var_262_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_12.prefab_name].transform, "story_v_out_324151", "324151059", "story_v_out_324151.awb")

						arg_259_1:RecordAudio("324151059", var_262_17)
						arg_259_1:RecordAudio("324151059", var_262_17)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_324151", "324151059", "story_v_out_324151.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_324151", "324151059", "story_v_out_324151.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_18 = var_262_9 + 0.3
			local var_262_19 = math.max(var_262_10, arg_259_1.talkMaxDuration)

			if var_262_9 + 0.3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_18 + var_262_19 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_18) / var_262_19

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_18 + var_262_19 and arg_259_1.time_ < var_262_18 + var_262_19 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play324151060 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 324151060
		arg_265_1.duration_ = 1.6

		local var_265_0 = {
			zh = 1.59933333333333,
			ja = 1.53333333333333
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play324151061(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if arg_265_1.bgs_.J24f == nil then
				local var_268_0 = Object.Instantiate(arg_265_1.paintGo_)

				var_268_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J24f")
				var_268_0.name = "J24f"
				var_268_0.transform.parent = arg_265_1.stage_.transform
				var_268_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.bgs_.J24f = var_268_0
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				local var_268_1 = arg_265_1.bgs_.J24f

				arg_265_1.bgs_.J24f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_268_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_2 = var_268_1:GetComponent("SpriteRenderer")

				if var_268_2 and var_268_2.sprite then
					local var_268_3 = 2 * (var_268_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_268_1.transform.localScale = Vector3.New(var_268_3 / var_268_2.sprite.bounds.size.y < var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x and var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x or var_268_3 / var_268_2.sprite.bounds.size.y, var_268_3 / var_268_2.sprite.bounds.size.y < var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x and var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x or var_268_3 / var_268_2.sprite.bounds.size.y, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "J24f" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_4 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			if arg_265_1.time_ >= var_268_4 + 0.3 and arg_265_1.time_ < var_268_4 + 0.3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_5 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_6 = 0.933333333333333

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_6 then
				local var_268_7 = Color.New(0, 0, 0)

				var_268_7.a = Mathf.Lerp(1, 0, (arg_265_1.time_ - var_268_5) / var_268_6)
				arg_265_1.mask_.color = var_268_7
			end

			if arg_265_1.time_ >= var_268_5 + var_268_6 and arg_265_1.time_ < var_268_5 + var_268_6 + arg_268_0 then
				local var_268_8 = Color.New(0, 0, 0)

				arg_265_1.mask_.enabled = false
				var_268_8.a = 0
				arg_265_1.mask_.color = var_268_8
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_9 = 0.533333333333333
			local var_268_10 = 0.05

			if 0.533333333333333 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_11 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_11:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_12 = arg_265_1:GetWordFromCfg(324151060)
				local var_268_13 = arg_265_1:FormatText(var_268_12.content)

				arg_265_1.text_.text = var_268_13

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_15 = 2 <= 0 and var_268_10 or var_268_10 * (utf8.len(var_268_13) / 2)

				if (2 <= 0 and var_268_10 or var_268_10 * (utf8.len(var_268_13) / 2)) > 0 and var_268_10 < var_268_15 then
					arg_265_1.talkMaxDuration = var_268_15
					var_268_9 = var_268_9 + 0.3

					if var_268_15 + var_268_9 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_15 + var_268_9
					end
				end

				arg_265_1.text_.text = var_268_13
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151060", "story_v_out_324151.awb") ~= 0 then
					local var_268_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151060", "story_v_out_324151.awb") / 1000

					if var_268_16 + var_268_9 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_16 + var_268_9
					end

					if var_268_12.prefab_name ~= "" and arg_265_1.actors_[var_268_12.prefab_name] ~= nil then
						local var_268_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_12.prefab_name].transform, "story_v_out_324151", "324151060", "story_v_out_324151.awb")

						arg_265_1:RecordAudio("324151060", var_268_17)
						arg_265_1:RecordAudio("324151060", var_268_17)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_324151", "324151060", "story_v_out_324151.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_324151", "324151060", "story_v_out_324151.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_18 = var_268_9 + 0.3
			local var_268_19 = math.max(var_268_10, arg_265_1.talkMaxDuration)

			if var_268_9 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_18 + var_268_19 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_18) / var_268_19

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_18 + var_268_19 and arg_265_1.time_ < var_268_18 + var_268_19 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play324151061 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 324151061
		arg_271_1.duration_ = 2

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play324151062(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if arg_271_1.bgs_.ST44 == nil then
				local var_274_0 = Object.Instantiate(arg_271_1.paintGo_)

				var_274_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST44")
				var_274_0.name = "ST44"
				var_274_0.transform.parent = arg_271_1.stage_.transform
				var_274_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.bgs_.ST44 = var_274_0
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				local var_274_1 = arg_271_1.bgs_.ST44

				arg_271_1.bgs_.ST44.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_274_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_2 = var_274_1:GetComponent("SpriteRenderer")

				if var_274_2 and var_274_2.sprite then
					local var_274_3 = 2 * (var_274_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_274_1.transform.localScale = Vector3.New(var_274_3 / var_274_2.sprite.bounds.size.y < var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x and var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x or var_274_3 / var_274_2.sprite.bounds.size.y, var_274_3 / var_274_2.sprite.bounds.size.y < var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x and var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x or var_274_3 / var_274_2.sprite.bounds.size.y, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "ST44" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_4 = 0

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.allBtn_.enabled = false
			end

			if arg_271_1.time_ >= var_274_4 + 0.3 and arg_271_1.time_ < var_274_4 + 0.3 + arg_274_0 then
				arg_271_1.allBtn_.enabled = true
			end

			local var_274_5 = 0

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_6 = 1.1

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_6 then
				local var_274_7 = Color.New(0, 0, 0)

				var_274_7.a = Mathf.Lerp(1, 0, (arg_271_1.time_ - var_274_5) / var_274_6)
				arg_271_1.mask_.color = var_274_7
			end

			if arg_271_1.time_ >= var_274_5 + var_274_6 and arg_271_1.time_ < var_274_5 + var_274_6 + arg_274_0 then
				local var_274_8 = Color.New(0, 0, 0)

				arg_271_1.mask_.enabled = false
				var_274_8.a = 0
				arg_271_1.mask_.color = var_274_8
			end

			local var_274_9 = 0
			local var_274_10 = 0.05

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_11 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_11:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_12 = arg_271_1:GetWordFromCfg(324151061)
				local var_274_13 = arg_271_1:FormatText(var_274_12.content)

				arg_271_1.text_.text = var_274_13

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_15 = 2 <= 0 and var_274_10 or var_274_10 * (utf8.len(var_274_13) / 2)

				if (2 <= 0 and var_274_10 or var_274_10 * (utf8.len(var_274_13) / 2)) > 0 and var_274_10 < var_274_15 then
					arg_271_1.talkMaxDuration = var_274_15
					var_274_9 = var_274_9 + 0.3

					if var_274_15 + var_274_9 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_15 + var_274_9
					end
				end

				arg_271_1.text_.text = var_274_13
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151061", "story_v_out_324151.awb") ~= 0 then
					local var_274_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151061", "story_v_out_324151.awb") / 1000

					if var_274_16 + var_274_9 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_16 + var_274_9
					end

					if var_274_12.prefab_name ~= "" and arg_271_1.actors_[var_274_12.prefab_name] ~= nil then
						local var_274_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_12.prefab_name].transform, "story_v_out_324151", "324151061", "story_v_out_324151.awb")

						arg_271_1:RecordAudio("324151061", var_274_17)
						arg_271_1:RecordAudio("324151061", var_274_17)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_324151", "324151061", "story_v_out_324151.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_324151", "324151061", "story_v_out_324151.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_18 = var_274_9 + 0.3
			local var_274_19 = math.max(var_274_10, arg_271_1.talkMaxDuration)

			if var_274_9 + 0.3 <= arg_271_1.time_ and arg_271_1.time_ < var_274_18 + var_274_19 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_18) / var_274_19

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_18 + var_274_19 and arg_271_1.time_ < var_274_18 + var_274_19 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play324151062 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 324151062
		arg_277_1.duration_ = 2

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play324151063(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if arg_277_1.bgs_.ST2009 == nil then
				local var_280_0 = Object.Instantiate(arg_277_1.paintGo_)

				var_280_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2009")
				var_280_0.name = "ST2009"
				var_280_0.transform.parent = arg_277_1.stage_.transform
				var_280_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_277_1.bgs_.ST2009 = var_280_0
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				local var_280_1 = arg_277_1.bgs_.ST2009

				arg_277_1.bgs_.ST2009.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_280_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_280_2 = var_280_1:GetComponent("SpriteRenderer")

				if var_280_2 and var_280_2.sprite then
					local var_280_3 = 2 * (var_280_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_280_1.transform.localScale = Vector3.New(var_280_3 / var_280_2.sprite.bounds.size.y < var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x and var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x or var_280_3 / var_280_2.sprite.bounds.size.y, var_280_3 / var_280_2.sprite.bounds.size.y < var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x and var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x or var_280_3 / var_280_2.sprite.bounds.size.y, 0)
				end

				for iter_280_0, iter_280_1 in pairs(arg_277_1.bgs_) do
					if iter_280_0 ~= "ST2009" then
						iter_280_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_280_4 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			if arg_277_1.time_ >= var_280_4 + 0.3 and arg_277_1.time_ < var_280_4 + 0.3 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end

			local var_280_5 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_6 = 2

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_6 then
				local var_280_7 = Color.New(0, 0, 0)

				var_280_7.a = Mathf.Lerp(1, 0, (arg_277_1.time_ - var_280_5) / var_280_6)
				arg_277_1.mask_.color = var_280_7
			end

			if arg_277_1.time_ >= var_280_5 + var_280_6 and arg_277_1.time_ < var_280_5 + var_280_6 + arg_280_0 then
				local var_280_8 = Color.New(0, 0, 0)

				arg_277_1.mask_.enabled = false
				var_280_8.a = 0
				arg_277_1.mask_.color = var_280_8
			end

			local var_280_9 = 0
			local var_280_10 = 0.05

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				arg_277_1.dialog_:SetActive(true)

				arg_277_1.dialogCg_.alpha = 0

				local var_280_11 = LeanTween.value(arg_277_1.dialog_, 0, 1, 0.3)

				var_280_11:setOnUpdate(LuaHelper.FloatAction(function(arg_281_0)
					arg_277_1.dialogCg_.alpha = arg_281_0
				end))
				var_280_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_277_1.dialog_)
					var_280_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_277_1.duration_ = arg_277_1.duration_ + 0.3

				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_12 = arg_277_1:GetWordFromCfg(324151062)
				local var_280_13 = arg_277_1:FormatText(var_280_12.content)

				arg_277_1.text_.text = var_280_13

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_15 = 2 <= 0 and var_280_10 or var_280_10 * (utf8.len(var_280_13) / 2)

				if (2 <= 0 and var_280_10 or var_280_10 * (utf8.len(var_280_13) / 2)) > 0 and var_280_10 < var_280_15 then
					arg_277_1.talkMaxDuration = var_280_15
					var_280_9 = var_280_9 + 0.3

					if var_280_15 + var_280_9 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_15 + var_280_9
					end
				end

				arg_277_1.text_.text = var_280_13
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151062", "story_v_out_324151.awb") ~= 0 then
					local var_280_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151062", "story_v_out_324151.awb") / 1000

					if var_280_16 + var_280_9 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_16 + var_280_9
					end

					if var_280_12.prefab_name ~= "" and arg_277_1.actors_[var_280_12.prefab_name] ~= nil then
						local var_280_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_12.prefab_name].transform, "story_v_out_324151", "324151062", "story_v_out_324151.awb")

						arg_277_1:RecordAudio("324151062", var_280_17)
						arg_277_1:RecordAudio("324151062", var_280_17)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_324151", "324151062", "story_v_out_324151.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_324151", "324151062", "story_v_out_324151.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_18 = var_280_9 + 0.3
			local var_280_19 = math.max(var_280_10, arg_277_1.talkMaxDuration)

			if var_280_9 + 0.3 <= arg_277_1.time_ and arg_277_1.time_ < var_280_18 + var_280_19 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_18) / var_280_19

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_18 + var_280_19 and arg_277_1.time_ < var_280_18 + var_280_19 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play324151063 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 324151063
		arg_283_1.duration_ = 1.5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play324151064(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if arg_283_1.bgs_.ST2005 == nil then
				local var_286_0 = Object.Instantiate(arg_283_1.paintGo_)

				var_286_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2005")
				var_286_0.name = "ST2005"
				var_286_0.transform.parent = arg_283_1.stage_.transform
				var_286_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_283_1.bgs_.ST2005 = var_286_0
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				local var_286_1 = arg_283_1.bgs_.ST2005

				arg_283_1.bgs_.ST2005.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_286_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_286_2 = var_286_1:GetComponent("SpriteRenderer")

				if var_286_2 and var_286_2.sprite then
					local var_286_3 = 2 * (var_286_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_286_1.transform.localScale = Vector3.New(var_286_3 / var_286_2.sprite.bounds.size.y < var_286_3 * manager.ui.mainCameraCom_.aspect / var_286_2.sprite.bounds.size.x and var_286_3 * manager.ui.mainCameraCom_.aspect / var_286_2.sprite.bounds.size.x or var_286_3 / var_286_2.sprite.bounds.size.y, var_286_3 / var_286_2.sprite.bounds.size.y < var_286_3 * manager.ui.mainCameraCom_.aspect / var_286_2.sprite.bounds.size.x and var_286_3 * manager.ui.mainCameraCom_.aspect / var_286_2.sprite.bounds.size.x or var_286_3 / var_286_2.sprite.bounds.size.y, 0)
				end

				for iter_286_0, iter_286_1 in pairs(arg_283_1.bgs_) do
					if iter_286_0 ~= "ST2005" then
						iter_286_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_286_4 = 0

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			if arg_283_1.time_ >= var_286_4 + 0.3 and arg_283_1.time_ < var_286_4 + 0.3 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			local var_286_5 = 0

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1.mask_.enabled = true
				arg_283_1.mask_.raycastTarget = true

				arg_283_1:SetGaussion(false)
			end

			local var_286_6 = 1

			if var_286_5 <= arg_283_1.time_ and arg_283_1.time_ < var_286_5 + var_286_6 then
				local var_286_7 = Color.New(0, 0, 0)

				var_286_7.a = Mathf.Lerp(1, 0, (arg_283_1.time_ - var_286_5) / var_286_6)
				arg_283_1.mask_.color = var_286_7
			end

			if arg_283_1.time_ >= var_286_5 + var_286_6 and arg_283_1.time_ < var_286_5 + var_286_6 + arg_286_0 then
				local var_286_8 = Color.New(0, 0, 0)

				arg_283_1.mask_.enabled = false
				var_286_8.a = 0
				arg_283_1.mask_.color = var_286_8
			end

			local var_286_9 = 0
			local var_286_10 = 0.05

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0

				arg_283_1.dialog_:SetActive(true)

				arg_283_1.dialogCg_.alpha = 0

				local var_286_11 = LeanTween.value(arg_283_1.dialog_, 0, 1, 0.3)

				var_286_11:setOnUpdate(LuaHelper.FloatAction(function(arg_287_0)
					arg_283_1.dialogCg_.alpha = arg_287_0
				end))
				var_286_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_283_1.dialog_)
					var_286_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_283_1.duration_ = arg_283_1.duration_ + 0.3

				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_12 = arg_283_1:GetWordFromCfg(324151063)
				local var_286_13 = arg_283_1:FormatText(var_286_12.content)

				arg_283_1.text_.text = var_286_13

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_15 = 2 <= 0 and var_286_10 or var_286_10 * (utf8.len(var_286_13) / 2)

				if (2 <= 0 and var_286_10 or var_286_10 * (utf8.len(var_286_13) / 2)) > 0 and var_286_10 < var_286_15 then
					arg_283_1.talkMaxDuration = var_286_15
					var_286_9 = var_286_9 + 0.3

					if var_286_15 + var_286_9 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_9
					end
				end

				arg_283_1.text_.text = var_286_13
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151063", "story_v_out_324151.awb") ~= 0 then
					local var_286_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151063", "story_v_out_324151.awb") / 1000

					if var_286_16 + var_286_9 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_16 + var_286_9
					end

					if var_286_12.prefab_name ~= "" and arg_283_1.actors_[var_286_12.prefab_name] ~= nil then
						local var_286_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_12.prefab_name].transform, "story_v_out_324151", "324151063", "story_v_out_324151.awb")

						arg_283_1:RecordAudio("324151063", var_286_17)
						arg_283_1:RecordAudio("324151063", var_286_17)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_324151", "324151063", "story_v_out_324151.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_324151", "324151063", "story_v_out_324151.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_18 = var_286_9 + 0.3
			local var_286_19 = math.max(var_286_10, arg_283_1.talkMaxDuration)

			if var_286_9 + 0.3 <= arg_283_1.time_ and arg_283_1.time_ < var_286_18 + var_286_19 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_18) / var_286_19

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_18 + var_286_19 and arg_283_1.time_ < var_286_18 + var_286_19 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play324151064 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 324151064
		arg_289_1.duration_ = 3.8

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play324151065(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if arg_289_1.bgs_.STblack == nil then
				local var_292_0 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_292_0.name = "STblack"
				var_292_0.transform.parent = arg_289_1.stage_.transform
				var_292_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_.STblack = var_292_0
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				local var_292_1 = arg_289_1.bgs_.STblack

				arg_289_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_292_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_2 = var_292_1:GetComponent("SpriteRenderer")

				if var_292_2 and var_292_2.sprite then
					local var_292_3 = 2 * (var_292_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_292_1.transform.localScale = Vector3.New(var_292_3 / var_292_2.sprite.bounds.size.y < var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x and var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x or var_292_3 / var_292_2.sprite.bounds.size.y, var_292_3 / var_292_2.sprite.bounds.size.y < var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x and var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x or var_292_3 / var_292_2.sprite.bounds.size.y, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "STblack" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_4 = "J25f"

			if arg_289_1.bgs_.J25f == nil then
				local var_292_5 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_292_4)
				var_292_5.name = var_292_4
				var_292_5.transform.parent = arg_289_1.stage_.transform
				var_292_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_[var_292_4] = var_292_5
			end

			if 1 < arg_289_1.time_ and arg_289_1.time_ <= 1 + arg_292_0 then
				local var_292_6 = arg_289_1.bgs_.J25f

				arg_289_1.bgs_.J25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_292_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_7 = var_292_6:GetComponent("SpriteRenderer")

				if var_292_7 and var_292_7.sprite then
					local var_292_8 = 2 * (var_292_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_292_6.transform.localScale = Vector3.New(var_292_8 / var_292_7.sprite.bounds.size.y < var_292_8 * manager.ui.mainCameraCom_.aspect / var_292_7.sprite.bounds.size.x and var_292_8 * manager.ui.mainCameraCom_.aspect / var_292_7.sprite.bounds.size.x or var_292_8 / var_292_7.sprite.bounds.size.y, var_292_8 / var_292_7.sprite.bounds.size.y < var_292_8 * manager.ui.mainCameraCom_.aspect / var_292_7.sprite.bounds.size.x and var_292_8 * manager.ui.mainCameraCom_.aspect / var_292_7.sprite.bounds.size.x or var_292_8 / var_292_7.sprite.bounds.size.y, 0)
				end

				for iter_292_2, iter_292_3 in pairs(arg_289_1.bgs_) do
					if iter_292_2 ~= "J25f" then
						iter_292_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_9 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_9 + arg_292_0 then
				arg_289_1.allBtn_.enabled = false
			end

			if arg_289_1.time_ >= var_292_9 + 0.3 and arg_289_1.time_ < var_292_9 + 0.3 + arg_292_0 then
				arg_289_1.allBtn_.enabled = true
			end

			local var_292_10 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_11 = 1

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 then
				local var_292_12 = Color.New(1, 1, 1)

				var_292_12.a = Mathf.Lerp(0, 1, (arg_289_1.time_ - var_292_10) / var_292_11)
				arg_289_1.mask_.color = var_292_12
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 then
				local var_292_13 = Color.New(1, 1, 1)

				var_292_13.a = 1
				arg_289_1.mask_.color = var_292_13
			end

			local var_292_14 = 1

			if 1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_15 = 2.46666666666667

			if var_292_14 <= arg_289_1.time_ and arg_289_1.time_ < var_292_14 + var_292_15 then
				local var_292_16 = Color.New(1, 1, 1)

				var_292_16.a = Mathf.Lerp(1, 0, (arg_289_1.time_ - var_292_14) / var_292_15)
				arg_289_1.mask_.color = var_292_16
			end

			if arg_289_1.time_ >= var_292_14 + var_292_15 and arg_289_1.time_ < var_292_14 + var_292_15 + arg_292_0 then
				local var_292_17 = Color.New(1, 1, 1)

				arg_289_1.mask_.enabled = false
				var_292_17.a = 0
				arg_289_1.mask_.color = var_292_17
			end

			if 1 < arg_289_1.time_ and arg_289_1.time_ <= 1 + arg_292_0 then
				arg_289_1.fswbg_:SetActive(true)
				arg_289_1.dialog_:SetActive(false)

				arg_289_1.fswtw_.percent = 0
				arg_289_1.fswt_.text = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.fswt_)

				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_289_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_289_1.fswtw_:SetDirty()

				arg_289_1.typewritterCharCountI18N = 0

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_18 = 2.53333333333333

			if 2.53333333333333 < arg_289_1.time_ and arg_289_1.time_ <= var_292_18 + arg_292_0 then
				arg_289_1.var_.oldValueTypewriter = arg_289_1.fswtw_.percent

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_19 = 0
			local var_292_20 = 0.466666666666667
			local var_292_21, var_292_22 = arg_289_1:GetPercentByPara(arg_289_1:FormatText(arg_289_1:GetWordFromCfg(102).content), 1)

			if var_292_18 < arg_289_1.time_ and arg_289_1.time_ <= var_292_18 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				local var_292_23 = var_292_19 <= 0 and var_292_20 or var_292_20 * ((var_292_22 - arg_289_1.typewritterCharCountI18N) / var_292_19)

				if (var_292_19 <= 0 and var_292_20 or var_292_20 * ((var_292_22 - arg_289_1.typewritterCharCountI18N) / var_292_19)) > 0 and var_292_20 < var_292_23 then
					arg_289_1.talkMaxDuration = var_292_23

					if var_292_23 + var_292_18 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_18
					end
				end
			end

			local var_292_24 = math.max(0.466666666666667, arg_289_1.talkMaxDuration)

			if var_292_18 <= arg_289_1.time_ and arg_289_1.time_ < var_292_18 + var_292_24 then
				arg_289_1.fswtw_.percent = Mathf.Lerp(arg_289_1.var_.oldValueTypewriter, var_292_21, (arg_289_1.time_ - var_292_18) / var_292_24)
				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_289_1.fswtw_:SetDirty()
			end

			if arg_289_1.time_ >= var_292_18 + var_292_24 and arg_289_1.time_ < var_292_18 + var_292_24 + arg_292_0 then
				arg_289_1.fswtw_.percent = var_292_21

				arg_289_1.fswtw_:SetDirty()
				arg_289_1:ShowNextGo(true)

				arg_289_1.typewritterCharCountI18N = var_292_22
			end

			if 1 < arg_289_1.time_ and arg_289_1.time_ <= 1 + arg_292_0 then
				if arg_289_1.var_.effect23231 then
					Object.Destroy(arg_289_1.var_.effect23231)

					arg_289_1.var_.effect23231 = nil
				end
			end

			if 1 < arg_289_1.time_ and arg_289_1.time_ <= 1 + arg_292_0 then
				if arg_289_1.var_.effect32421 then
					Object.Destroy(arg_289_1.var_.effect32421)

					arg_289_1.var_.effect32421 = nil
				end
			end

			local var_292_27

			if 1 < arg_289_1.time_ and arg_289_1.time_ <= 1 + arg_292_0 then
				local var_292_28 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_292_28 then
					var_292_28.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_292_28.radialBlurScale = 0
					var_292_28.radialBlurGradient = 1
					var_292_28.radialBlurIntensity = 1

					if var_292_27 then
						var_292_28.radialBlurTarget = var_292_27.transform
					end
				end
			end

			local var_292_29 = 2.26666666666667

			if 1 <= arg_289_1.time_ and arg_289_1.time_ < 1 + var_292_29 then
				local var_292_30 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_292_30 then
					var_292_30.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_292_30.radialBlurScale = Mathf.Lerp(0, 0.93, (arg_289_1.time_ - 1) / var_292_29)
					var_292_30.radialBlurGradient = Mathf.Lerp(1, 1, (arg_289_1.time_ - 1) / var_292_29)
					var_292_30.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_289_1.time_ - 1) / var_292_29)
				end
			end

			if arg_289_1.time_ >= 1 + var_292_29 and arg_289_1.time_ < 1 + var_292_29 + arg_292_0 then
				local var_292_31 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_292_31 then
					var_292_31.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_292_31.radialBlurScale = 0.93
					var_292_31.radialBlurGradient = 1
					var_292_31.radialBlurIntensity = 1
				end
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play324151065 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 324151065
		arg_293_1.duration_ = 7.4

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play324151066(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 1 < arg_293_1.time_ and arg_293_1.time_ <= 1 + arg_296_0 then
				local var_296_0 = arg_293_1.bgs_.J22f

				arg_293_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_296_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_1 = var_296_0:GetComponent("SpriteRenderer")

				if var_296_1 and var_296_1.sprite then
					local var_296_2 = 2 * (var_296_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_296_0.transform.localScale = Vector3.New(var_296_2 / var_296_1.sprite.bounds.size.y < var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x and var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x or var_296_2 / var_296_1.sprite.bounds.size.y, var_296_2 / var_296_1.sprite.bounds.size.y < var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x and var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x or var_296_2 / var_296_1.sprite.bounds.size.y, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "J22f" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_3 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			if arg_293_1.time_ >= var_296_3 + 0.3 and arg_293_1.time_ < var_296_3 + 0.3 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end

			local var_296_4 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_5 = 1

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_5 then
				local var_296_6 = Color.New(0, 0, 0)

				var_296_6.a = Mathf.Lerp(0, 1, (arg_293_1.time_ - var_296_4) / var_296_5)
				arg_293_1.mask_.color = var_296_6
			end

			if arg_293_1.time_ >= var_296_4 + var_296_5 and arg_293_1.time_ < var_296_4 + var_296_5 + arg_296_0 then
				local var_296_7 = Color.New(0, 0, 0)

				var_296_7.a = 1
				arg_293_1.mask_.color = var_296_7
			end

			local var_296_8 = 1

			if 1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_9 = 1.93333333333333

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_9 then
				local var_296_10 = Color.New(0, 0, 0)

				var_296_10.a = Mathf.Lerp(1, 0, (arg_293_1.time_ - var_296_8) / var_296_9)
				arg_293_1.mask_.color = var_296_10
			end

			if arg_293_1.time_ >= var_296_8 + var_296_9 and arg_293_1.time_ < var_296_8 + var_296_9 + arg_296_0 then
				local var_296_11 = Color.New(0, 0, 0)

				arg_293_1.mask_.enabled = false
				var_296_11.a = 0
				arg_293_1.mask_.color = var_296_11
			end

			if 1 < arg_293_1.time_ and arg_293_1.time_ <= 1 + arg_296_0 then
				arg_293_1.fswbg_:SetActive(false)
				arg_293_1.dialog_:SetActive(false)
				SetActive(arg_293_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_293_1:ShowNextGo(false)
			end

			if 1.46666666666667 < arg_293_1.time_ and arg_293_1.time_ <= 1.46666666666667 + arg_296_0 then
				arg_293_1.fswbg_:SetActive(false)
				arg_293_1.dialog_:SetActive(false)
				SetActive(arg_293_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_293_1:ShowNextGo(false)
			end

			local var_296_12

			if 1 < arg_293_1.time_ and arg_293_1.time_ <= 1 + arg_296_0 then
				local var_296_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_296_13 then
					var_296_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_296_13.radialBlurScale = 0.945
					var_296_13.radialBlurGradient = 1
					var_296_13.radialBlurIntensity = 1

					if var_296_12 then
						var_296_13.radialBlurTarget = var_296_12.transform
					end
				end
			end

			local var_296_14 = 2.26666666666667

			if 1 <= arg_293_1.time_ and arg_293_1.time_ < 1 + var_296_14 then
				local var_296_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_296_15 then
					var_296_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_296_15.radialBlurScale = Mathf.Lerp(0.945, 0, (arg_293_1.time_ - 1) / var_296_14)
					var_296_15.radialBlurGradient = Mathf.Lerp(1, 1, (arg_293_1.time_ - 1) / var_296_14)
					var_296_15.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_293_1.time_ - 1) / var_296_14)
				end
			end

			if arg_293_1.time_ >= 1 + var_296_14 and arg_293_1.time_ < 1 + var_296_14 + arg_296_0 then
				local var_296_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_296_16 then
					var_296_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_296_16.radialBlurScale = 0
					var_296_16.radialBlurGradient = 1
					var_296_16.radialBlurIntensity = 1
				end
			end

			if arg_293_1.frameCnt_ <= 1 then
				arg_293_1.dialog_:SetActive(false)
			end

			local var_296_17 = 2.4
			local var_296_18 = 0.625

			if 2.4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_17 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				arg_293_1.dialog_:SetActive(true)

				arg_293_1.dialogCg_.alpha = 0

				local var_296_19 = LeanTween.value(arg_293_1.dialog_, 0, 1, 0.3)

				var_296_19:setOnUpdate(LuaHelper.FloatAction(function(arg_297_0)
					arg_293_1.dialogCg_.alpha = arg_297_0
				end))
				var_296_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_293_1.dialog_)
					var_296_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_293_1.duration_ = arg_293_1.duration_ + 0.3

				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_20 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(324151065).content)

				arg_293_1.text_.text = var_296_20

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_22 = 25 <= 0 and var_296_18 or var_296_18 * (utf8.len(var_296_20) / 25)

				if (25 <= 0 and var_296_18 or var_296_18 * (utf8.len(var_296_20) / 25)) > 0 and var_296_18 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22
					var_296_17 = var_296_17 + 0.3

					if var_296_22 + var_296_17 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_17
					end
				end

				arg_293_1.text_.text = var_296_20
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_23 = var_296_17 + 0.3
			local var_296_24 = math.max(var_296_18, arg_293_1.talkMaxDuration)

			if var_296_17 + 0.3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_23 + var_296_24 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_23) / var_296_24

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_23 + var_296_24 and arg_293_1.time_ < var_296_23 + var_296_24 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play324151066 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 324151066
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play324151067(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.6

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(324151066).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 24 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 24)

				if (24 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 24)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play324151067 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 324151067
		arg_303_1.duration_ = 4.27

		local var_303_0 = {
			zh = 4.266,
			ja = 1.933
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play324151068(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["10171ui_story"]) and arg_303_1.var_.characterEffect10171ui_story == nil then
				arg_303_1.var_.characterEffect10171ui_story = arg_303_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["10171ui_story"]) then
				if arg_303_1.var_.characterEffect10171ui_story and not isNil(arg_303_1.actors_["10171ui_story"]) then
					arg_303_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["10171ui_story"]) and arg_303_1.var_.characterEffect10171ui_story then
				arg_303_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_306_2 = 0
			local var_306_3 = 0.175

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_2 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10171")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_4 = arg_303_1:GetWordFromCfg(324151067)
				local var_306_5 = arg_303_1:FormatText(var_306_4.content)

				arg_303_1.text_.text = var_306_5

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_7 = 7 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 7)

				if (7 <= 0 and var_306_3 or var_306_3 * (utf8.len(var_306_5) / 7)) > 0 and var_306_3 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_2
					end
				end

				arg_303_1.text_.text = var_306_5
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151067", "story_v_out_324151.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151067", "story_v_out_324151.awb") / 1000

					if var_306_8 + var_306_2 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_2
					end

					if var_306_4.prefab_name ~= "" and arg_303_1.actors_[var_306_4.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_4.prefab_name].transform, "story_v_out_324151", "324151067", "story_v_out_324151.awb")

						arg_303_1:RecordAudio("324151067", var_306_9)
						arg_303_1:RecordAudio("324151067", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_324151", "324151067", "story_v_out_324151.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_324151", "324151067", "story_v_out_324151.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_3, arg_303_1.talkMaxDuration)

			if var_306_2 <= arg_303_1.time_ and arg_303_1.time_ < var_306_2 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_2) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_2 + var_306_10 and arg_303_1.time_ < var_306_2 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play324151068 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 324151068
		arg_307_1.duration_ = 5.8

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play324151069(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["10171ui_story"]) and arg_307_1.var_.characterEffect10171ui_story == nil then
				arg_307_1.var_.characterEffect10171ui_story = arg_307_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["10171ui_story"]) then
				if arg_307_1.var_.characterEffect10171ui_story and not isNil(arg_307_1.actors_["10171ui_story"]) then
					arg_307_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_307_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["10171ui_story"]) and arg_307_1.var_.characterEffect10171ui_story then
				arg_307_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_307_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			if arg_307_1.time_ >= var_310_1 + 1.1 and arg_307_1.time_ < var_310_1 + 1.1 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			if 0.4 < arg_307_1.time_ and arg_307_1.time_ <= 0.4 + arg_310_0 then
				arg_307_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_stab2", "")
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_3 = 0.8
			local var_310_4 = 1.225

			if 0.8 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_5 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_5:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(324151068).content)

				arg_307_1.text_.text = var_310_6

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_8 = 49 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_6) / 49)

				if (49 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_6) / 49)) > 0 and var_310_4 < var_310_8 then
					arg_307_1.talkMaxDuration = var_310_8
					var_310_3 = var_310_3 + 0.3

					if var_310_8 + var_310_3 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_3
					end
				end

				arg_307_1.text_.text = var_310_6
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_9 = var_310_3 + 0.3
			local var_310_10 = math.max(var_310_4, arg_307_1.talkMaxDuration)

			if var_310_3 + 0.3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_9) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 0.5,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.1,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play324151069 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 324151069
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play324151070(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0.2 < arg_313_1.time_ and arg_313_1.time_ <= 0.2 + arg_316_0 then
				arg_313_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword06", "")
			end

			local var_316_1 = 0
			local var_316_2 = 1.475

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(324151069).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 59 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 59)

				if (59 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 59)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play324151070 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 324151070
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play324151071(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1.55

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(324151070).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 62 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 62)

				if (62 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 62)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play324151071 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 324151071
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play324151072(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.65

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(324151071).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 26 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 26)

				if (26 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 26)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play324151072 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 324151072
		arg_325_1.duration_ = 2

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play324151073(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["10171ui_story"]) and arg_325_1.var_.characterEffect10171ui_story == nil then
				arg_325_1.var_.characterEffect10171ui_story = arg_325_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["10171ui_story"]) then
				if arg_325_1.var_.characterEffect10171ui_story and not isNil(arg_325_1.actors_["10171ui_story"]) then
					arg_325_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["10171ui_story"]) and arg_325_1.var_.characterEffect10171ui_story then
				arg_325_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_328_2 = arg_325_1.actors_["10171ui_story"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos10171ui_story = var_328_2.localPosition

				local var_328_3 = GameObjectTools.GetOrAddComponent(var_328_2.gameObject, typeof(DynamicBoneHelper))

				if var_328_3 then
					var_328_3:EnableDynamicBone(false)
				end
			end

			local var_328_4 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				var_328_2.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_325_1.time_ - 0) / var_328_4)
				var_328_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_2.position).x, (manager.ui.mainCamera.transform.position - var_328_2.position).y, (manager.ui.mainCamera.transform.position - var_328_2.position).z)
				var_328_2.localEulerAngles.z = 0
				var_328_2.localEulerAngles.x = 0
				var_328_2.localEulerAngles = var_328_2.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				var_328_2.localPosition = Vector3.New(0, -0.95, -6.05)
				var_328_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_2.position).x, (manager.ui.mainCamera.transform.position - var_328_2.position).y, (manager.ui.mainCamera.transform.position - var_328_2.position).z)
				var_328_2.localEulerAngles.z = 0
				var_328_2.localEulerAngles.x = 0
				var_328_2.localEulerAngles = var_328_2.localEulerAngles

				local var_328_5 = GameObjectTools.GetOrAddComponent(var_328_2.gameObject, typeof(DynamicBoneHelper))

				if var_328_5 then
					var_328_5:EnableDynamicBone(true)
				end
			end

			local var_328_6 = arg_325_1.actors_["10171ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_6) and arg_325_1.var_.characterEffect10171ui_story == nil then
				arg_325_1.var_.characterEffect10171ui_story = var_328_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_7 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 and not isNil(var_328_6) then
				if arg_325_1.var_.characterEffect10171ui_story and not isNil(var_328_6) then
					arg_325_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 and not isNil(var_328_6) and arg_325_1.var_.characterEffect10171ui_story then
				arg_325_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_328_9 = 0
			local var_328_10 = 0.175

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_11 = arg_325_1:GetWordFromCfg(324151072)
				local var_328_12 = arg_325_1:FormatText(var_328_11.content)

				arg_325_1.text_.text = var_328_12

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_14 = 7 <= 0 and var_328_10 or var_328_10 * (utf8.len(var_328_12) / 7)

				if (7 <= 0 and var_328_10 or var_328_10 * (utf8.len(var_328_12) / 7)) > 0 and var_328_10 < var_328_14 then
					arg_325_1.talkMaxDuration = var_328_14

					if var_328_14 + var_328_9 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_14 + var_328_9
					end
				end

				arg_325_1.text_.text = var_328_12
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151072", "story_v_out_324151.awb") ~= 0 then
					local var_328_15 = manager.audio:GetVoiceLength("story_v_out_324151", "324151072", "story_v_out_324151.awb") / 1000

					if var_328_15 + var_328_9 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_15 + var_328_9
					end

					if var_328_11.prefab_name ~= "" and arg_325_1.actors_[var_328_11.prefab_name] ~= nil then
						local var_328_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_11.prefab_name].transform, "story_v_out_324151", "324151072", "story_v_out_324151.awb")

						arg_325_1:RecordAudio("324151072", var_328_16)
						arg_325_1:RecordAudio("324151072", var_328_16)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_324151", "324151072", "story_v_out_324151.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_324151", "324151072", "story_v_out_324151.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_17 = math.max(var_328_10, arg_325_1.talkMaxDuration)

			if var_328_9 <= arg_325_1.time_ and arg_325_1.time_ < var_328_9 + var_328_17 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_9) / var_328_17

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_9 + var_328_17 and arg_325_1.time_ < var_328_9 + var_328_17 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play324151073 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 324151073
		arg_329_1.duration_ = 7.7

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play324151074(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 1.26666666666667 < arg_329_1.time_ and arg_329_1.time_ <= 1.26666666666667 + arg_332_0 then
				local var_332_0 = arg_329_1.bgs_.ST31

				arg_329_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_332_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_332_1 = var_332_0:GetComponent("SpriteRenderer")

				if var_332_1 and var_332_1.sprite then
					local var_332_2 = 2 * (var_332_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_332_0.transform.localScale = Vector3.New(var_332_2 / var_332_1.sprite.bounds.size.y < var_332_2 * manager.ui.mainCameraCom_.aspect / var_332_1.sprite.bounds.size.x and var_332_2 * manager.ui.mainCameraCom_.aspect / var_332_1.sprite.bounds.size.x or var_332_2 / var_332_1.sprite.bounds.size.y, var_332_2 / var_332_1.sprite.bounds.size.y < var_332_2 * manager.ui.mainCameraCom_.aspect / var_332_1.sprite.bounds.size.x and var_332_2 * manager.ui.mainCameraCom_.aspect / var_332_1.sprite.bounds.size.x or var_332_2 / var_332_1.sprite.bounds.size.y, 0)
				end

				for iter_332_0, iter_332_1 in pairs(arg_329_1.bgs_) do
					if iter_332_0 ~= "ST31" then
						iter_332_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_332_3 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_3 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			if arg_329_1.time_ >= var_332_3 + 0.3 and arg_329_1.time_ < var_332_3 + 0.3 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			local var_332_4 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_5 = 1.3

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_5 then
				local var_332_6 = Color.New(0, 0, 0)

				var_332_6.a = Mathf.Lerp(0, 1, (arg_329_1.time_ - var_332_4) / var_332_5)
				arg_329_1.mask_.color = var_332_6
			end

			if arg_329_1.time_ >= var_332_4 + var_332_5 and arg_329_1.time_ < var_332_4 + var_332_5 + arg_332_0 then
				local var_332_7 = Color.New(0, 0, 0)

				var_332_7.a = 1
				arg_329_1.mask_.color = var_332_7
			end

			local var_332_8 = 1.3

			if 1.3 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_9 = 1.73333333333333

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_9 then
				local var_332_10 = Color.New(0, 0, 0)

				var_332_10.a = Mathf.Lerp(1, 0, (arg_329_1.time_ - var_332_8) / var_332_9)
				arg_329_1.mask_.color = var_332_10
			end

			if arg_329_1.time_ >= var_332_8 + var_332_9 and arg_329_1.time_ < var_332_8 + var_332_9 + arg_332_0 then
				local var_332_11 = Color.New(0, 0, 0)

				arg_329_1.mask_.enabled = false
				var_332_11.a = 0
				arg_329_1.mask_.color = var_332_11
			end

			local var_332_12 = arg_329_1.actors_["10171ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_12) and arg_329_1.var_.characterEffect10171ui_story == nil then
				arg_329_1.var_.characterEffect10171ui_story = var_332_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_13 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_13 and not isNil(var_332_12) then
				if arg_329_1.var_.characterEffect10171ui_story and not isNil(var_332_12) then
					arg_329_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_13)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_13 and arg_329_1.time_ < 0 + var_332_13 + arg_332_0 and not isNil(var_332_12) and arg_329_1.var_.characterEffect10171ui_story then
				arg_329_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_332_14 = arg_329_1.bgs_.ST31.transform

			if 1.3 < arg_329_1.time_ and arg_329_1.time_ <= 1.3 + arg_332_0 then
				arg_329_1.var_.moveOldPosST31 = var_332_14.localPosition
			end

			local var_332_15 = 1.79166666666667

			if 1.3 <= arg_329_1.time_ and arg_329_1.time_ < 1.3 + var_332_15 then
				var_332_14.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPosST31, Vector3.New(0, 1, 7.5), (arg_329_1.time_ - 1.3) / var_332_15)
			end

			if arg_329_1.time_ >= 1.3 + var_332_15 and arg_329_1.time_ < 1.3 + var_332_15 + arg_332_0 then
				var_332_14.localPosition = Vector3.New(0, 1, 7.5)
			end

			local var_332_16 = arg_329_1.actors_["10171ui_story"].transform

			if 1.3 < arg_329_1.time_ and arg_329_1.time_ <= 1.3 + arg_332_0 then
				arg_329_1.var_.moveOldPos10171ui_story = var_332_16.localPosition

				local var_332_17 = GameObjectTools.GetOrAddComponent(var_332_16.gameObject, typeof(DynamicBoneHelper))

				if var_332_17 then
					var_332_17:EnableDynamicBone(false)
				end
			end

			local var_332_18 = 0.001

			if 1.3 <= arg_329_1.time_ and arg_329_1.time_ < 1.3 + var_332_18 then
				var_332_16.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 1.3) / var_332_18)
				var_332_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_16.position).x, (manager.ui.mainCamera.transform.position - var_332_16.position).y, (manager.ui.mainCamera.transform.position - var_332_16.position).z)
				var_332_16.localEulerAngles.z = 0
				var_332_16.localEulerAngles.x = 0
				var_332_16.localEulerAngles = var_332_16.localEulerAngles
			end

			if arg_329_1.time_ >= 1.3 + var_332_18 and arg_329_1.time_ < 1.3 + var_332_18 + arg_332_0 then
				var_332_16.localPosition = Vector3.New(0, 100, 0)
				var_332_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_16.position).x, (manager.ui.mainCamera.transform.position - var_332_16.position).y, (manager.ui.mainCamera.transform.position - var_332_16.position).z)
				var_332_16.localEulerAngles.z = 0
				var_332_16.localEulerAngles.x = 0
				var_332_16.localEulerAngles = var_332_16.localEulerAngles

				local var_332_19 = GameObjectTools.GetOrAddComponent(var_332_16.gameObject, typeof(DynamicBoneHelper))

				if var_332_19 then
					var_332_19:EnableDynamicBone(true)
				end
			end

			local var_332_20 = arg_329_1.actors_["10171ui_story"]

			if 1.3 < arg_329_1.time_ and arg_329_1.time_ <= 1.3 + arg_332_0 and not isNil(var_332_20) and arg_329_1.var_.characterEffect10171ui_story == nil then
				arg_329_1.var_.characterEffect10171ui_story = var_332_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_21 = 0.200000002980232

			if 1.3 <= arg_329_1.time_ and arg_329_1.time_ < 1.3 + var_332_21 and not isNil(var_332_20) then
				if arg_329_1.var_.characterEffect10171ui_story and not isNil(var_332_20) then
					arg_329_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 1.3 + var_332_21 and arg_329_1.time_ < 1.3 + var_332_21 + arg_332_0 and not isNil(var_332_20) and arg_329_1.var_.characterEffect10171ui_story then
				arg_329_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 1.2 < arg_329_1.time_ and arg_329_1.time_ <= 1.2 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if 0.1 < arg_329_1.time_ and arg_329_1.time_ <= 0.1 + arg_332_0 then
				arg_329_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_25 = 2.7
			local var_332_26 = 1.55

			if 2.7 < arg_329_1.time_ and arg_329_1.time_ <= var_332_25 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_27 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_27:setOnUpdate(LuaHelper.FloatAction(function(arg_333_0)
					arg_329_1.dialogCg_.alpha = arg_333_0
				end))
				var_332_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_28 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(324151073).content)

				arg_329_1.text_.text = var_332_28

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_30 = 62 <= 0 and var_332_26 or var_332_26 * (utf8.len(var_332_28) / 62)

				if (62 <= 0 and var_332_26 or var_332_26 * (utf8.len(var_332_28) / 62)) > 0 and var_332_26 < var_332_30 then
					arg_329_1.talkMaxDuration = var_332_30
					var_332_25 = var_332_25 + 0.3

					if var_332_30 + var_332_25 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_30 + var_332_25
					end
				end

				arg_329_1.text_.text = var_332_28
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_31 = var_332_25 + 0.3
			local var_332_32 = math.max(var_332_26, arg_329_1.talkMaxDuration)

			if var_332_25 + 0.3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_31 + var_332_32 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_31) / var_332_32

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_31 + var_332_32 and arg_329_1.time_ < var_332_31 + var_332_32 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST31",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.79166666666667,
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 7.5),
					easeType = LeanTweenType.notUsed
				}
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play324151074 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 324151074
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play324151075(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.925

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(324151074).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 37 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 37)

				if (37 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 37)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play324151075 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 324151075
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play324151076(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 1.225

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(324151075).content)

				arg_339_1.text_.text = var_342_1

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_3 = 49 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 49)

				if (49 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 49)) > 0 and var_342_0 < var_342_3 then
					arg_339_1.talkMaxDuration = var_342_3

					if var_342_3 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_3 + 0
					end
				end

				arg_339_1.text_.text = var_342_1
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_4 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_4

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play324151076 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 324151076
		arg_343_1.duration_ = 3.5

		local var_343_0 = {
			zh = 3.5,
			ja = 2.6
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play324151077(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if arg_343_1.bgs_.J22g == nil then
				local var_346_0 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J22g")
				var_346_0.name = "J22g"
				var_346_0.transform.parent = arg_343_1.stage_.transform
				var_346_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_.J22g = var_346_0
			end

			if 0.925 < arg_343_1.time_ and arg_343_1.time_ <= 0.925 + arg_346_0 then
				local var_346_1 = arg_343_1.bgs_.J22g

				arg_343_1.bgs_.J22g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_346_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_2 = var_346_1:GetComponent("SpriteRenderer")

				if var_346_2 and var_346_2.sprite then
					local var_346_3 = 2 * (var_346_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_346_1.transform.localScale = Vector3.New(var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "J22g" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_4 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.allBtn_.enabled = false
			end

			if arg_343_1.time_ >= var_346_4 + 0.3 and arg_343_1.time_ < var_346_4 + 0.3 + arg_346_0 then
				arg_343_1.allBtn_.enabled = true
			end

			local var_346_5 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_6 = 0.925

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_6 then
				local var_346_7 = Color.New(0, 0, 0)

				var_346_7.a = Mathf.Lerp(0, 1, (arg_343_1.time_ - var_346_5) / var_346_6)
				arg_343_1.mask_.color = var_346_7
			end

			if arg_343_1.time_ >= var_346_5 + var_346_6 and arg_343_1.time_ < var_346_5 + var_346_6 + arg_346_0 then
				local var_346_8 = Color.New(0, 0, 0)

				var_346_8.a = 1
				arg_343_1.mask_.color = var_346_8
			end

			local var_346_9 = 0.925

			if 0.925 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_10 = 0.925

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_10 then
				local var_346_11 = Color.New(0, 0, 0)

				var_346_11.a = Mathf.Lerp(1, 0, (arg_343_1.time_ - var_346_9) / var_346_10)
				arg_343_1.mask_.color = var_346_11
			end

			if arg_343_1.time_ >= var_346_9 + var_346_10 and arg_343_1.time_ < var_346_9 + var_346_10 + arg_346_0 then
				local var_346_12 = Color.New(0, 0, 0)

				arg_343_1.mask_.enabled = false
				var_346_12.a = 0
				arg_343_1.mask_.color = var_346_12
			end

			if 1.2 < arg_343_1.time_ and arg_343_1.time_ <= 1.2 + arg_346_0 then
				arg_343_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_construction", "")
			end

			if 0.1 < arg_343_1.time_ and arg_343_1.time_ <= 0.1 + arg_346_0 then
				arg_343_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_15 = 1.7
			local var_346_16 = 0.075

			if 1.7 < arg_343_1.time_ and arg_343_1.time_ <= var_346_15 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_17 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_17:setOnUpdate(LuaHelper.FloatAction(function(arg_347_0)
					arg_343_1.dialogCg_.alpha = arg_347_0
				end))
				var_346_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_18 = arg_343_1:GetWordFromCfg(324151076)
				local var_346_19 = arg_343_1:FormatText(var_346_18.content)

				arg_343_1.text_.text = var_346_19

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_21 = 3 <= 0 and var_346_16 or var_346_16 * (utf8.len(var_346_19) / 3)

				if (3 <= 0 and var_346_16 or var_346_16 * (utf8.len(var_346_19) / 3)) > 0 and var_346_16 < var_346_21 then
					arg_343_1.talkMaxDuration = var_346_21
					var_346_15 = var_346_15 + 0.3

					if var_346_21 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_21 + var_346_15
					end
				end

				arg_343_1.text_.text = var_346_19
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151076", "story_v_out_324151.awb") ~= 0 then
					local var_346_22 = manager.audio:GetVoiceLength("story_v_out_324151", "324151076", "story_v_out_324151.awb") / 1000

					if var_346_22 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_22 + var_346_15
					end

					if var_346_18.prefab_name ~= "" and arg_343_1.actors_[var_346_18.prefab_name] ~= nil then
						local var_346_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_18.prefab_name].transform, "story_v_out_324151", "324151076", "story_v_out_324151.awb")

						arg_343_1:RecordAudio("324151076", var_346_23)
						arg_343_1:RecordAudio("324151076", var_346_23)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_324151", "324151076", "story_v_out_324151.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_324151", "324151076", "story_v_out_324151.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_24 = var_346_15 + 0.3
			local var_346_25 = math.max(var_346_16, arg_343_1.talkMaxDuration)

			if var_346_15 + 0.3 <= arg_343_1.time_ and arg_343_1.time_ < var_346_24 + var_346_25 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_24) / var_346_25

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_24 + var_346_25 and arg_343_1.time_ < var_346_24 + var_346_25 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play324151077 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 324151077
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play324151078(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10171ui_story = arg_349_1.actors_["10171ui_story"].transform.localPosition

				local var_352_0 = GameObjectTools.GetOrAddComponent(arg_349_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_352_0 then
					var_352_0:EnableDynamicBone(false)
				end
			end

			local var_352_1 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_1 then
				arg_349_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_1)
				arg_349_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10171ui_story"].transform.position).z)
				arg_349_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10171ui_story"].transform.localEulerAngles = arg_349_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_1 and arg_349_1.time_ < 0 + var_352_1 + arg_352_0 then
				arg_349_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10171ui_story"].transform.position).z)
				arg_349_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10171ui_story"].transform.localEulerAngles = arg_349_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_352_2 = GameObjectTools.GetOrAddComponent(arg_349_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_352_2 then
					var_352_2:EnableDynamicBone(true)
				end
			end

			local var_352_3 = arg_349_1.actors_["10171ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_3) and arg_349_1.var_.characterEffect10171ui_story == nil then
				arg_349_1.var_.characterEffect10171ui_story = var_352_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_4 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 and not isNil(var_352_3) then
				if arg_349_1.var_.characterEffect10171ui_story and not isNil(var_352_3) then
					arg_349_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_349_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_4)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 and not isNil(var_352_3) and arg_349_1.var_.characterEffect10171ui_story then
				arg_349_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_349_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_349_1.time_ and arg_349_1.time_ <= 0.1 + arg_352_0 then
				arg_349_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_352_6 = 0
			local var_352_7 = 0.95

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_8 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(324151077).content)

				arg_349_1.text_.text = var_352_8

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_10 = 38 <= 0 and var_352_7 or var_352_7 * (utf8.len(var_352_8) / 38)

				if (38 <= 0 and var_352_7 or var_352_7 * (utf8.len(var_352_8) / 38)) > 0 and var_352_7 < var_352_10 then
					arg_349_1.talkMaxDuration = var_352_10

					if var_352_10 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_8
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_11 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_11 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_11

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_11 and arg_349_1.time_ < var_352_6 + var_352_11 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play324151078 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 324151078
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play324151079(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0.1 < arg_353_1.time_ and arg_353_1.time_ <= 0.1 + arg_356_0 then
				arg_353_1:AudioAction("play", "effect", "se_story_140", "se_story_140_dream_crash02", "")
			end

			if 0.3 < arg_353_1.time_ and arg_353_1.time_ <= 0.3 + arg_356_0 then
				arg_353_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone04", "")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_construction_stop", "")
			end

			local var_356_3 = 0
			local var_356_4 = 1.55

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_3 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_5 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(324151078).content)

				arg_353_1.text_.text = var_356_5

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_7 = 62 <= 0 and var_356_4 or var_356_4 * (utf8.len(var_356_5) / 62)

				if (62 <= 0 and var_356_4 or var_356_4 * (utf8.len(var_356_5) / 62)) > 0 and var_356_4 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_3 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_3
					end
				end

				arg_353_1.text_.text = var_356_5
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_8 = math.max(var_356_4, arg_353_1.talkMaxDuration)

			if var_356_3 <= arg_353_1.time_ and arg_353_1.time_ < var_356_3 + var_356_8 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_3) / var_356_8

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_3 + var_356_8 and arg_353_1.time_ < var_356_3 + var_356_8 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play324151079 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 324151079
		arg_357_1.duration_ = 3.53

		local var_357_0 = {
			zh = 3.533,
			ja = 1.333
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play324151080(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["10171ui_story"]) and arg_357_1.var_.characterEffect10171ui_story == nil then
				arg_357_1.var_.characterEffect10171ui_story = arg_357_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["10171ui_story"]) then
				if arg_357_1.var_.characterEffect10171ui_story and not isNil(arg_357_1.actors_["10171ui_story"]) then
					arg_357_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["10171ui_story"]) and arg_357_1.var_.characterEffect10171ui_story then
				arg_357_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_360_2 = 0
			local var_360_3 = 0.05

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_2 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_4 = arg_357_1:GetWordFromCfg(324151079)
				local var_360_5 = arg_357_1:FormatText(var_360_4.content)

				arg_357_1.text_.text = var_360_5

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_7 = 2 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 2)

				if (2 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 2)) > 0 and var_360_3 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_2
					end
				end

				arg_357_1.text_.text = var_360_5
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151079", "story_v_out_324151.awb") ~= 0 then
					local var_360_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151079", "story_v_out_324151.awb") / 1000

					if var_360_8 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_2
					end

					if var_360_4.prefab_name ~= "" and arg_357_1.actors_[var_360_4.prefab_name] ~= nil then
						local var_360_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_4.prefab_name].transform, "story_v_out_324151", "324151079", "story_v_out_324151.awb")

						arg_357_1:RecordAudio("324151079", var_360_9)
						arg_357_1:RecordAudio("324151079", var_360_9)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_324151", "324151079", "story_v_out_324151.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_324151", "324151079", "story_v_out_324151.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_3, arg_357_1.talkMaxDuration)

			if var_360_2 <= arg_357_1.time_ and arg_357_1.time_ < var_360_2 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_2) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_2 + var_360_10 and arg_357_1.time_ < var_360_2 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play324151080 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 324151080
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play324151081(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["10171ui_story"]) and arg_361_1.var_.characterEffect10171ui_story == nil then
				arg_361_1.var_.characterEffect10171ui_story = arg_361_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["10171ui_story"]) then
				if arg_361_1.var_.characterEffect10171ui_story and not isNil(arg_361_1.actors_["10171ui_story"]) then
					arg_361_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_361_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["10171ui_story"]) and arg_361_1.var_.characterEffect10171ui_story then
				arg_361_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_361_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 1.125

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(324151080).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 45 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 45)

				if (45 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 45)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play324151081 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 324151081
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play324151082(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 1.05

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(324151081).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 42 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 42)

				if (42 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 42)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play324151082 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 324151082
		arg_369_1.duration_ = 3.2

		local var_369_0 = {
			zh = 3.2,
			ja = 2.2
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play324151083(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["10171ui_story"]) and arg_369_1.var_.characterEffect10171ui_story == nil then
				arg_369_1.var_.characterEffect10171ui_story = arg_369_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["10171ui_story"]) then
				if arg_369_1.var_.characterEffect10171ui_story and not isNil(arg_369_1.actors_["10171ui_story"]) then
					arg_369_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["10171ui_story"]) and arg_369_1.var_.characterEffect10171ui_story then
				arg_369_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_372_2 = 0
			local var_372_3 = 0.225

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_2 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_4 = arg_369_1:GetWordFromCfg(324151082)
				local var_372_5 = arg_369_1:FormatText(var_372_4.content)

				arg_369_1.text_.text = var_372_5

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_7 = 9 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 9)

				if (9 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 9)) > 0 and var_372_3 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_2
					end
				end

				arg_369_1.text_.text = var_372_5
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151082", "story_v_out_324151.awb") ~= 0 then
					local var_372_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151082", "story_v_out_324151.awb") / 1000

					if var_372_8 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_2
					end

					if var_372_4.prefab_name ~= "" and arg_369_1.actors_[var_372_4.prefab_name] ~= nil then
						local var_372_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_4.prefab_name].transform, "story_v_out_324151", "324151082", "story_v_out_324151.awb")

						arg_369_1:RecordAudio("324151082", var_372_9)
						arg_369_1:RecordAudio("324151082", var_372_9)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_324151", "324151082", "story_v_out_324151.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_324151", "324151082", "story_v_out_324151.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_3, arg_369_1.talkMaxDuration)

			if var_372_2 <= arg_369_1.time_ and arg_369_1.time_ < var_372_2 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_2) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_2 + var_372_10 and arg_369_1.time_ < var_372_2 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play324151083 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 324151083
		arg_373_1.duration_ = 5.72

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play324151084(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["10171ui_story"]) and arg_373_1.var_.characterEffect10171ui_story == nil then
				arg_373_1.var_.characterEffect10171ui_story = arg_373_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["10171ui_story"]) then
				if arg_373_1.var_.characterEffect10171ui_story and not isNil(arg_373_1.actors_["10171ui_story"]) then
					arg_373_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_373_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_0)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["10171ui_story"]) and arg_373_1.var_.characterEffect10171ui_story then
				arg_373_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_373_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_376_1 = 0

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_2 = 1

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 then
				local var_376_3 = Color.New(1, 1, 1)

				var_376_3.a = Mathf.Lerp(1, 0, (arg_373_1.time_ - var_376_1) / var_376_2)
				arg_373_1.mask_.color = var_376_3
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 then
				local var_376_4 = Color.New(1, 1, 1)

				arg_373_1.mask_.enabled = false
				var_376_4.a = 0
				arg_373_1.mask_.color = var_376_4
			end

			if 0.1 < arg_373_1.time_ and arg_373_1.time_ <= 0.1 + arg_376_0 then
				arg_373_1:AudioAction("play", "effect", "se_story_150", "se_story_150_amb_drone_down01", "")
			end

			if 0.1 < arg_373_1.time_ and arg_373_1.time_ <= 0.1 + arg_376_0 then
				arg_373_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword07", "")
			end

			local var_376_7 = 0.717440504021943
			local var_376_8 = 1.4

			if 0.717440504021943 < arg_373_1.time_ and arg_373_1.time_ <= var_376_7 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_9 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(324151083).content)

				arg_373_1.text_.text = var_376_9

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_11 = 56 <= 0 and var_376_8 or var_376_8 * (utf8.len(var_376_9) / 56)

				if (56 <= 0 and var_376_8 or var_376_8 * (utf8.len(var_376_9) / 56)) > 0 and var_376_8 < var_376_11 then
					arg_373_1.talkMaxDuration = var_376_11

					if var_376_11 + var_376_7 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_11 + var_376_7
					end
				end

				arg_373_1.text_.text = var_376_9
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_12 = math.max(var_376_8, arg_373_1.talkMaxDuration)

			if var_376_7 <= arg_373_1.time_ and arg_373_1.time_ < var_376_7 + var_376_12 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_7) / var_376_12

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_7 + var_376_12 and arg_373_1.time_ < var_376_7 + var_376_12 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 0.5,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.1,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play324151084 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 324151084
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play324151085(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 1.475

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(324151084).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 59 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 59)

				if (59 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 59)) > 0 and var_380_0 < var_380_3 then
					arg_377_1.talkMaxDuration = var_380_3

					if var_380_3 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_3 + 0
					end
				end

				arg_377_1.text_.text = var_380_1
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_4 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_4

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play324151085 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 324151085
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play324151086(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.625

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_1 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(324151085).content)

				arg_381_1.text_.text = var_384_1

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_3 = 25 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 25)

				if (25 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 25)) > 0 and var_384_0 < var_384_3 then
					arg_381_1.talkMaxDuration = var_384_3

					if var_384_3 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_3 + 0
					end
				end

				arg_381_1.text_.text = var_384_1
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_4 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_4

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play324151086 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 324151086
		arg_385_1.duration_ = 2.47

		local var_385_0 = {
			zh = 2.466,
			ja = 1.066
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play324151087(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["10171ui_story"]) and arg_385_1.var_.characterEffect10171ui_story == nil then
				arg_385_1.var_.characterEffect10171ui_story = arg_385_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["10171ui_story"]) then
				if arg_385_1.var_.characterEffect10171ui_story and not isNil(arg_385_1.actors_["10171ui_story"]) then
					arg_385_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["10171ui_story"]) and arg_385_1.var_.characterEffect10171ui_story then
				arg_385_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_388_2 = 0
			local var_388_3 = 0.2

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_2 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_4 = arg_385_1:GetWordFromCfg(324151086)
				local var_388_5 = arg_385_1:FormatText(var_388_4.content)

				arg_385_1.text_.text = var_388_5

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_7 = 8 <= 0 and var_388_3 or var_388_3 * (utf8.len(var_388_5) / 8)

				if (8 <= 0 and var_388_3 or var_388_3 * (utf8.len(var_388_5) / 8)) > 0 and var_388_3 < var_388_7 then
					arg_385_1.talkMaxDuration = var_388_7

					if var_388_7 + var_388_2 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_7 + var_388_2
					end
				end

				arg_385_1.text_.text = var_388_5
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151086", "story_v_out_324151.awb") ~= 0 then
					local var_388_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151086", "story_v_out_324151.awb") / 1000

					if var_388_8 + var_388_2 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_8 + var_388_2
					end

					if var_388_4.prefab_name ~= "" and arg_385_1.actors_[var_388_4.prefab_name] ~= nil then
						local var_388_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_4.prefab_name].transform, "story_v_out_324151", "324151086", "story_v_out_324151.awb")

						arg_385_1:RecordAudio("324151086", var_388_9)
						arg_385_1:RecordAudio("324151086", var_388_9)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_324151", "324151086", "story_v_out_324151.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_324151", "324151086", "story_v_out_324151.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_10 = math.max(var_388_3, arg_385_1.talkMaxDuration)

			if var_388_2 <= arg_385_1.time_ and arg_385_1.time_ < var_388_2 + var_388_10 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_2) / var_388_10

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_2 + var_388_10 and arg_385_1.time_ < var_388_2 + var_388_10 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play324151087 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 324151087
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play324151088(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["10171ui_story"]) and arg_389_1.var_.characterEffect10171ui_story == nil then
				arg_389_1.var_.characterEffect10171ui_story = arg_389_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["10171ui_story"]) then
				if arg_389_1.var_.characterEffect10171ui_story and not isNil(arg_389_1.actors_["10171ui_story"]) then
					arg_389_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_389_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_0)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["10171ui_story"]) and arg_389_1.var_.characterEffect10171ui_story then
				arg_389_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_389_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_392_1 = 0
			local var_392_2 = 1

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_3 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(324151087).content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 40 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 40)

				if (40 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 40)) > 0 and var_392_2 < var_392_5 then
					arg_389_1.talkMaxDuration = var_392_5

					if var_392_5 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + var_392_1
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_6 = math.max(var_392_2, arg_389_1.talkMaxDuration)

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_6 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_1) / var_392_6

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_1 + var_392_6 and arg_389_1.time_ < var_392_1 + var_392_6 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play324151088 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 324151088
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play324151089(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.075

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(324151088).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 43 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 43)

				if (43 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 43)) > 0 and var_396_0 < var_396_3 then
					arg_393_1.talkMaxDuration = var_396_3

					if var_396_3 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_3 + 0
					end
				end

				arg_393_1.text_.text = var_396_1
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_4 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_4

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play324151089 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 324151089
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play324151090(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.95

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(324151089).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 38 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 38)

				if (38 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 38)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play324151090 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 324151090
		arg_401_1.duration_ = 4.67

		local var_401_0 = {
			zh = 2.733,
			ja = 4.666
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play324151091(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["10171ui_story"]) and arg_401_1.var_.characterEffect10171ui_story == nil then
				arg_401_1.var_.characterEffect10171ui_story = arg_401_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["10171ui_story"]) then
				if arg_401_1.var_.characterEffect10171ui_story and not isNil(arg_401_1.actors_["10171ui_story"]) then
					arg_401_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["10171ui_story"]) and arg_401_1.var_.characterEffect10171ui_story then
				arg_401_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_404_2 = 0
			local var_404_3 = 0.3

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_2 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_4 = arg_401_1:GetWordFromCfg(324151090)
				local var_404_5 = arg_401_1:FormatText(var_404_4.content)

				arg_401_1.text_.text = var_404_5

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_7 = 12 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_5) / 12)

				if (12 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_5) / 12)) > 0 and var_404_3 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_2
					end
				end

				arg_401_1.text_.text = var_404_5
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151090", "story_v_out_324151.awb") ~= 0 then
					local var_404_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151090", "story_v_out_324151.awb") / 1000

					if var_404_8 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_2
					end

					if var_404_4.prefab_name ~= "" and arg_401_1.actors_[var_404_4.prefab_name] ~= nil then
						local var_404_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_4.prefab_name].transform, "story_v_out_324151", "324151090", "story_v_out_324151.awb")

						arg_401_1:RecordAudio("324151090", var_404_9)
						arg_401_1:RecordAudio("324151090", var_404_9)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_324151", "324151090", "story_v_out_324151.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_324151", "324151090", "story_v_out_324151.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_3, arg_401_1.talkMaxDuration)

			if var_404_2 <= arg_401_1.time_ and arg_401_1.time_ < var_404_2 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_2) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_2 + var_404_10 and arg_401_1.time_ < var_404_2 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play324151091 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 324151091
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play324151092(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["10171ui_story"]) and arg_405_1.var_.characterEffect10171ui_story == nil then
				arg_405_1.var_.characterEffect10171ui_story = arg_405_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_0 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["10171ui_story"]) then
				if arg_405_1.var_.characterEffect10171ui_story and not isNil(arg_405_1.actors_["10171ui_story"]) then
					arg_405_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_405_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_0)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["10171ui_story"]) and arg_405_1.var_.characterEffect10171ui_story then
				arg_405_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_405_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_408_1 = 0
			local var_408_2 = 1.275

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(324151091).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 51 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 51)

				if (51 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 51)) > 0 and var_408_2 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_1 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_1
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_6 = math.max(var_408_2, arg_405_1.talkMaxDuration)

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_6 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_1) / var_408_6

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_1 + var_408_6 and arg_405_1.time_ < var_408_1 + var_408_6 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play324151092 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 324151092
		arg_409_1.duration_ = 5.59

		local var_409_0 = {
			zh = 5.590999999999,
			ja = 3.824999999999
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play324151093(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_9000

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["10171ui_story"]) and arg_409_1.var_.characterEffect10171ui_story == nil then
				arg_409_1.var_.characterEffect10171ui_story = arg_409_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["10171ui_story"]) then
				if arg_409_1.var_.characterEffect10171ui_story and not isNil(arg_409_1.actors_["10171ui_story"]) then
					arg_409_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["10171ui_story"]) and arg_409_1.var_.characterEffect10171ui_story then
				arg_409_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				local var_412_2 = arg_409_1.var_.effect3434

				if not arg_409_1.var_.effect3434 then
					var_412_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), manager.ui.mainCamera.transform)
					var_412_2.name = "3434"
					arg_409_1.var_.effect3434 = var_412_2
				else
					var_412_2.transform:SetParent(var_412_9000)
				end

				var_412_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_412_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_412_2.transform.localScale = Vector3.New(var_412_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_412_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_412_2.transform.localScale.z)
			end

			local var_412_4 = 0

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.mask_.enabled = true
				arg_409_1.mask_.raycastTarget = true

				arg_409_1:SetGaussion(false)
			end

			local var_412_5 = 0.866666666666667

			if var_412_4 <= arg_409_1.time_ and arg_409_1.time_ < var_412_4 + var_412_5 then
				local var_412_6 = Color.New(0, 0, 0)

				var_412_6.a = Mathf.Lerp(1, 0, (arg_409_1.time_ - var_412_4) / var_412_5)
				arg_409_1.mask_.color = var_412_6
			end

			if arg_409_1.time_ >= var_412_4 + var_412_5 and arg_409_1.time_ < var_412_4 + var_412_5 + arg_412_0 then
				local var_412_7 = Color.New(0, 0, 0)

				arg_409_1.mask_.enabled = false
				var_412_7.a = 0
				arg_409_1.mask_.color = var_412_7
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_8 = 0.724999999999
			local var_412_9 = 0.275

			if 0.724999999999 < arg_409_1.time_ and arg_409_1.time_ <= var_412_8 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_10 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_10:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_11 = arg_409_1:GetWordFromCfg(324151092)
				local var_412_12 = arg_409_1:FormatText(var_412_11.content)

				arg_409_1.text_.text = var_412_12

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_14 = 11 <= 0 and var_412_9 or var_412_9 * (utf8.len(var_412_12) / 11)

				if (11 <= 0 and var_412_9 or var_412_9 * (utf8.len(var_412_12) / 11)) > 0 and var_412_9 < var_412_14 then
					arg_409_1.talkMaxDuration = var_412_14
					var_412_8 = var_412_8 + 0.3

					if var_412_14 + var_412_8 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_14 + var_412_8
					end
				end

				arg_409_1.text_.text = var_412_12
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151092", "story_v_out_324151.awb") ~= 0 then
					local var_412_15 = manager.audio:GetVoiceLength("story_v_out_324151", "324151092", "story_v_out_324151.awb") / 1000

					if var_412_15 + var_412_8 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_15 + var_412_8
					end

					if var_412_11.prefab_name ~= "" and arg_409_1.actors_[var_412_11.prefab_name] ~= nil then
						local var_412_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_11.prefab_name].transform, "story_v_out_324151", "324151092", "story_v_out_324151.awb")

						arg_409_1:RecordAudio("324151092", var_412_16)
						arg_409_1:RecordAudio("324151092", var_412_16)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_324151", "324151092", "story_v_out_324151.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_324151", "324151092", "story_v_out_324151.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_17 = var_412_8 + 0.3
			local var_412_18 = math.max(var_412_9, arg_409_1.talkMaxDuration)

			if var_412_8 + 0.3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_17 + var_412_18 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_17) / var_412_18

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_17 + var_412_18 and arg_409_1.time_ < var_412_17 + var_412_18 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play324151093 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 324151093
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play324151094(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["10171ui_story"]) and arg_415_1.var_.characterEffect10171ui_story == nil then
				arg_415_1.var_.characterEffect10171ui_story = arg_415_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["10171ui_story"]) then
				if arg_415_1.var_.characterEffect10171ui_story and not isNil(arg_415_1.actors_["10171ui_story"]) then
					arg_415_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_415_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_0)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["10171ui_story"]) and arg_415_1.var_.characterEffect10171ui_story then
				arg_415_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_415_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_418_1 = 0
			local var_418_2 = 1.3

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_3 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(324151093).content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 52 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 52)

				if (52 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 52)) > 0 and var_418_2 < var_418_5 then
					arg_415_1.talkMaxDuration = var_418_5

					if var_418_5 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_6 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_6 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_6

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_6 and arg_415_1.time_ < var_418_1 + var_418_6 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play324151094 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 324151094
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play324151095(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 1.45

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(324151094).content)

				arg_419_1.text_.text = var_422_1

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_3 = 58 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 58)

				if (58 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 58)) > 0 and var_422_0 < var_422_3 then
					arg_419_1.talkMaxDuration = var_422_3

					if var_422_3 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_3 + 0
					end
				end

				arg_419_1.text_.text = var_422_1
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_4 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_4

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play324151095 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 324151095
		arg_423_1.duration_ = 6.03

		local var_423_0 = {
			zh = 6.033,
			ja = 2.1
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play324151096(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["10171ui_story"]) and arg_423_1.var_.characterEffect10171ui_story == nil then
				arg_423_1.var_.characterEffect10171ui_story = arg_423_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["10171ui_story"]) then
				if arg_423_1.var_.characterEffect10171ui_story and not isNil(arg_423_1.actors_["10171ui_story"]) then
					arg_423_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["10171ui_story"]) and arg_423_1.var_.characterEffect10171ui_story then
				arg_423_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_426_2 = 0
			local var_426_3 = 0.2

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_2 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_4 = arg_423_1:GetWordFromCfg(324151095)
				local var_426_5 = arg_423_1:FormatText(var_426_4.content)

				arg_423_1.text_.text = var_426_5

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_7 = 8 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 8)

				if (8 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 8)) > 0 and var_426_3 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_2
					end
				end

				arg_423_1.text_.text = var_426_5
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151095", "story_v_out_324151.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151095", "story_v_out_324151.awb") / 1000

					if var_426_8 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_2
					end

					if var_426_4.prefab_name ~= "" and arg_423_1.actors_[var_426_4.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_4.prefab_name].transform, "story_v_out_324151", "324151095", "story_v_out_324151.awb")

						arg_423_1:RecordAudio("324151095", var_426_9)
						arg_423_1:RecordAudio("324151095", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_324151", "324151095", "story_v_out_324151.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_324151", "324151095", "story_v_out_324151.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_10 = math.max(var_426_3, arg_423_1.talkMaxDuration)

			if var_426_2 <= arg_423_1.time_ and arg_423_1.time_ < var_426_2 + var_426_10 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_2) / var_426_10

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_2 + var_426_10 and arg_423_1.time_ < var_426_2 + var_426_10 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play324151096 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 324151096
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play324151097(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["10171ui_story"]) and arg_427_1.var_.characterEffect10171ui_story == nil then
				arg_427_1.var_.characterEffect10171ui_story = arg_427_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["10171ui_story"]) then
				if arg_427_1.var_.characterEffect10171ui_story and not isNil(arg_427_1.actors_["10171ui_story"]) then
					arg_427_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_427_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_0)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["10171ui_story"]) and arg_427_1.var_.characterEffect10171ui_story then
				arg_427_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_427_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				if arg_427_1.var_.effect3434 then
					Object.Destroy(arg_427_1.var_.effect3434)

					arg_427_1.var_.effect3434 = nil
				end
			end

			if 0.1 < arg_427_1.time_ and arg_427_1.time_ <= 0.1 + arg_430_0 then
				arg_427_1:AudioAction("play", "effect", "se_story_150", "se_story_150_amb_drone_down02", "")
			end

			local var_430_3 = 0
			local var_430_4 = 1.625

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_3 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_5 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(324151096).content)

				arg_427_1.text_.text = var_430_5

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_7 = 65 <= 0 and var_430_4 or var_430_4 * (utf8.len(var_430_5) / 65)

				if (65 <= 0 and var_430_4 or var_430_4 * (utf8.len(var_430_5) / 65)) > 0 and var_430_4 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_3 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_3
					end
				end

				arg_427_1.text_.text = var_430_5
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_8 = math.max(var_430_4, arg_427_1.talkMaxDuration)

			if var_430_3 <= arg_427_1.time_ and arg_427_1.time_ < var_430_3 + var_430_8 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_3) / var_430_8

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_3 + var_430_8 and arg_427_1.time_ < var_430_3 + var_430_8 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play324151097 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 324151097
		arg_431_1.duration_ = 3.13

		local var_431_0 = {
			zh = 3.133,
			ja = 2.6
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play324151098(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos10171ui_story = arg_431_1.actors_["10171ui_story"].transform.localPosition

				local var_434_0 = GameObjectTools.GetOrAddComponent(arg_431_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_434_0 then
					var_434_0:EnableDynamicBone(false)
				end
			end

			local var_434_1 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_1 then
				arg_431_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_431_1.time_ - 0) / var_434_1)
				arg_431_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["10171ui_story"].transform.position).z)
				arg_431_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["10171ui_story"].transform.localEulerAngles = arg_431_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_431_1.time_ >= 0 + var_434_1 and arg_431_1.time_ < 0 + var_434_1 + arg_434_0 then
				arg_431_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_431_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["10171ui_story"].transform.position).z)
				arg_431_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["10171ui_story"].transform.localEulerAngles = arg_431_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_434_2 = GameObjectTools.GetOrAddComponent(arg_431_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_434_2 then
					var_434_2:EnableDynamicBone(true)
				end
			end

			local var_434_3 = arg_431_1.actors_["10171ui_story"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_3) and arg_431_1.var_.characterEffect10171ui_story == nil then
				arg_431_1.var_.characterEffect10171ui_story = var_434_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_4 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 and not isNil(var_434_3) then
				if arg_431_1.var_.characterEffect10171ui_story and not isNil(var_434_3) then
					arg_431_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 and not isNil(var_434_3) and arg_431_1.var_.characterEffect10171ui_story then
				arg_431_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_434_6 = 0
			local var_434_7 = 0.175

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_8 = arg_431_1:GetWordFromCfg(324151097)
				local var_434_9 = arg_431_1:FormatText(var_434_8.content)

				arg_431_1.text_.text = var_434_9

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 7 <= 0 and var_434_7 or var_434_7 * (utf8.len(var_434_9) / 7)

				if (7 <= 0 and var_434_7 or var_434_7 * (utf8.len(var_434_9) / 7)) > 0 and var_434_7 < var_434_11 then
					arg_431_1.talkMaxDuration = var_434_11

					if var_434_11 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_11 + var_434_6
					end
				end

				arg_431_1.text_.text = var_434_9
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151097", "story_v_out_324151.awb") ~= 0 then
					local var_434_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151097", "story_v_out_324151.awb") / 1000

					if var_434_12 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_12 + var_434_6
					end

					if var_434_8.prefab_name ~= "" and arg_431_1.actors_[var_434_8.prefab_name] ~= nil then
						local var_434_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_8.prefab_name].transform, "story_v_out_324151", "324151097", "story_v_out_324151.awb")

						arg_431_1:RecordAudio("324151097", var_434_13)
						arg_431_1:RecordAudio("324151097", var_434_13)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_324151", "324151097", "story_v_out_324151.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_324151", "324151097", "story_v_out_324151.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_14 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_14 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_14

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_14 and arg_431_1.time_ < var_434_6 + var_434_14 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play324151098 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 324151098
		arg_435_1.duration_ = 5

		local var_435_0 = {
			zh = 4.1,
			ja = 5
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play324151099(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos10171ui_story = arg_435_1.actors_["10171ui_story"].transform.localPosition

				local var_438_0 = GameObjectTools.GetOrAddComponent(arg_435_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_438_0 then
					var_438_0:EnableDynamicBone(false)
				end
			end

			local var_438_1 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_1 then
				arg_435_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_435_1.time_ - 0) / var_438_1)
				arg_435_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["10171ui_story"].transform.position).z)
				arg_435_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["10171ui_story"].transform.localEulerAngles = arg_435_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_1 and arg_435_1.time_ < 0 + var_438_1 + arg_438_0 then
				arg_435_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_435_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["10171ui_story"].transform.position).z)
				arg_435_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["10171ui_story"].transform.localEulerAngles = arg_435_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_438_2 = GameObjectTools.GetOrAddComponent(arg_435_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_438_2 then
					var_438_2:EnableDynamicBone(true)
				end
			end

			local var_438_3 = "1060ui_story"

			if arg_435_1.actors_["1060ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1060ui_story"))) then
				local var_438_4 = Object.Instantiate(Asset.Load("Char/" .. "1060ui_story"), arg_435_1.stage_.transform)

				var_438_4.name = var_438_3
				var_438_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_435_1.actors_[var_438_3] = var_438_4

				local var_438_5 = var_438_4:GetComponentInChildren(typeof(CharacterEffect))

				var_438_5.enabled = true

				local var_438_6 = GameObjectTools.GetOrAddComponent(var_438_4, typeof(DynamicBoneHelper))

				if var_438_6 then
					var_438_6:EnableDynamicBone(false)
				end

				arg_435_1:ShowWeapon(var_438_5.transform, false)

				arg_435_1.var_[var_438_3 .. "Animator"] = var_438_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_435_1.var_[var_438_3 .. "Animator"].applyRootMotion = true
				arg_435_1.var_[var_438_3 .. "LipSync"] = var_438_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_438_7 = arg_435_1.actors_["1060ui_story"].transform

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1060ui_story = var_438_7.localPosition
			end

			local var_438_8 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_8 then
				var_438_7.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_435_1.time_ - 0) / var_438_8)
				var_438_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_438_7.position).x, (manager.ui.mainCamera.transform.position - var_438_7.position).y, (manager.ui.mainCamera.transform.position - var_438_7.position).z)
				var_438_7.localEulerAngles.z = 0
				var_438_7.localEulerAngles.x = 0
				var_438_7.localEulerAngles = var_438_7.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_8 and arg_435_1.time_ < 0 + var_438_8 + arg_438_0 then
				var_438_7.localPosition = Vector3.New(0, -1.14, -6.33)
				var_438_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_438_7.position).x, (manager.ui.mainCamera.transform.position - var_438_7.position).y, (manager.ui.mainCamera.transform.position - var_438_7.position).z)
				var_438_7.localEulerAngles.z = 0
				var_438_7.localEulerAngles.x = 0
				var_438_7.localEulerAngles = var_438_7.localEulerAngles
			end

			local var_438_9 = arg_435_1.actors_["1060ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1060ui_story == nil then
				arg_435_1.var_.characterEffect1060ui_story = var_438_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_10 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_10 and not isNil(var_438_9) then
				if arg_435_1.var_.characterEffect1060ui_story and not isNil(var_438_9) then
					arg_435_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_10 and arg_435_1.time_ < 0 + var_438_10 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1060ui_story then
				arg_435_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_438_12 = arg_435_1.actors_["10171ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_12) and arg_435_1.var_.characterEffect10171ui_story == nil then
				arg_435_1.var_.characterEffect10171ui_story = var_438_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_13 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_13 and not isNil(var_438_12) then
				if arg_435_1.var_.characterEffect10171ui_story and not isNil(var_438_12) then
					arg_435_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_435_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_13)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_13 and arg_435_1.time_ < 0 + var_438_13 + arg_438_0 and not isNil(var_438_12) and arg_435_1.var_.characterEffect10171ui_story then
				arg_435_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_435_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_1")
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_438_14 = 0
			local var_438_15 = 0.375

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_14 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_16 = arg_435_1:GetWordFromCfg(324151098)
				local var_438_17 = arg_435_1:FormatText(var_438_16.content)

				arg_435_1.text_.text = var_438_17

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_19 = 15 <= 0 and var_438_15 or var_438_15 * (utf8.len(var_438_17) / 15)

				if (15 <= 0 and var_438_15 or var_438_15 * (utf8.len(var_438_17) / 15)) > 0 and var_438_15 < var_438_19 then
					arg_435_1.talkMaxDuration = var_438_19

					if var_438_19 + var_438_14 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_19 + var_438_14
					end
				end

				arg_435_1.text_.text = var_438_17
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151098", "story_v_out_324151.awb") ~= 0 then
					local var_438_20 = manager.audio:GetVoiceLength("story_v_out_324151", "324151098", "story_v_out_324151.awb") / 1000

					if var_438_20 + var_438_14 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_20 + var_438_14
					end

					if var_438_16.prefab_name ~= "" and arg_435_1.actors_[var_438_16.prefab_name] ~= nil then
						local var_438_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_16.prefab_name].transform, "story_v_out_324151", "324151098", "story_v_out_324151.awb")

						arg_435_1:RecordAudio("324151098", var_438_21)
						arg_435_1:RecordAudio("324151098", var_438_21)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_324151", "324151098", "story_v_out_324151.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_324151", "324151098", "story_v_out_324151.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_22 = math.max(var_438_15, arg_435_1.talkMaxDuration)

			if var_438_14 <= arg_435_1.time_ and arg_435_1.time_ < var_438_14 + var_438_22 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_14) / var_438_22

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_14 + var_438_22 and arg_435_1.time_ < var_438_14 + var_438_22 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play324151099 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 324151099
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play324151100(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["1060ui_story"]) and arg_439_1.var_.characterEffect1060ui_story == nil then
				arg_439_1.var_.characterEffect1060ui_story = arg_439_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["1060ui_story"]) then
				if arg_439_1.var_.characterEffect1060ui_story and not isNil(arg_439_1.actors_["1060ui_story"]) then
					arg_439_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_439_1.time_ - 0) / var_442_0)
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["1060ui_story"]) and arg_439_1.var_.characterEffect1060ui_story then
				arg_439_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_442_1 = 0
			local var_442_2 = 1.375

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_3 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(324151099).content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 55 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 55)

				if (55 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 55)) > 0 and var_442_2 < var_442_5 then
					arg_439_1.talkMaxDuration = var_442_5

					if var_442_5 + var_442_1 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + var_442_1
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_6 = math.max(var_442_2, arg_439_1.talkMaxDuration)

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_6 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_1) / var_442_6

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_1 + var_442_6 and arg_439_1.time_ < var_442_1 + var_442_6 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play324151100 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 324151100
		arg_443_1.duration_ = 4.17

		local var_443_0 = {
			zh = 3,
			ja = 4.166
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play324151101(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos10171ui_story = arg_443_1.actors_["10171ui_story"].transform.localPosition

				local var_446_0 = GameObjectTools.GetOrAddComponent(arg_443_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_446_0 then
					var_446_0:EnableDynamicBone(false)
				end
			end

			local var_446_1 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_1 then
				arg_443_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_443_1.time_ - 0) / var_446_1)
				arg_443_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["10171ui_story"].transform.position).z)
				arg_443_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["10171ui_story"].transform.localEulerAngles = arg_443_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_1 and arg_443_1.time_ < 0 + var_446_1 + arg_446_0 then
				arg_443_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_443_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["10171ui_story"].transform.position).z)
				arg_443_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["10171ui_story"].transform.localEulerAngles = arg_443_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_446_2 = GameObjectTools.GetOrAddComponent(arg_443_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_446_2 then
					var_446_2:EnableDynamicBone(true)
				end
			end

			local var_446_3 = arg_443_1.actors_["1060ui_story"].transform

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1060ui_story = var_446_3.localPosition
			end

			local var_446_4 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				var_446_3.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_443_1.time_ - 0) / var_446_4)
				var_446_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_446_3.position).x, (manager.ui.mainCamera.transform.position - var_446_3.position).y, (manager.ui.mainCamera.transform.position - var_446_3.position).z)
				var_446_3.localEulerAngles.z = 0
				var_446_3.localEulerAngles.x = 0
				var_446_3.localEulerAngles = var_446_3.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				var_446_3.localPosition = Vector3.New(0, 100, 0)
				var_446_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_446_3.position).x, (manager.ui.mainCamera.transform.position - var_446_3.position).y, (manager.ui.mainCamera.transform.position - var_446_3.position).z)
				var_446_3.localEulerAngles.z = 0
				var_446_3.localEulerAngles.x = 0
				var_446_3.localEulerAngles = var_446_3.localEulerAngles
			end

			local var_446_5 = arg_443_1.actors_["10171ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_5) and arg_443_1.var_.characterEffect10171ui_story == nil then
				arg_443_1.var_.characterEffect10171ui_story = var_446_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_6 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_6 and not isNil(var_446_5) then
				if arg_443_1.var_.characterEffect10171ui_story and not isNil(var_446_5) then
					arg_443_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= 0 + var_446_6 and arg_443_1.time_ < 0 + var_446_6 + arg_446_0 and not isNil(var_446_5) and arg_443_1.var_.characterEffect10171ui_story then
				arg_443_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_446_8 = 0
			local var_446_9 = 0.35

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_8 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_10 = arg_443_1:GetWordFromCfg(324151100)
				local var_446_11 = arg_443_1:FormatText(var_446_10.content)

				arg_443_1.text_.text = var_446_11

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_13 = 14 <= 0 and var_446_9 or var_446_9 * (utf8.len(var_446_11) / 14)

				if (14 <= 0 and var_446_9 or var_446_9 * (utf8.len(var_446_11) / 14)) > 0 and var_446_9 < var_446_13 then
					arg_443_1.talkMaxDuration = var_446_13

					if var_446_13 + var_446_8 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_13 + var_446_8
					end
				end

				arg_443_1.text_.text = var_446_11
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151100", "story_v_out_324151.awb") ~= 0 then
					local var_446_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151100", "story_v_out_324151.awb") / 1000

					if var_446_14 + var_446_8 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_14 + var_446_8
					end

					if var_446_10.prefab_name ~= "" and arg_443_1.actors_[var_446_10.prefab_name] ~= nil then
						local var_446_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_10.prefab_name].transform, "story_v_out_324151", "324151100", "story_v_out_324151.awb")

						arg_443_1:RecordAudio("324151100", var_446_15)
						arg_443_1:RecordAudio("324151100", var_446_15)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_324151", "324151100", "story_v_out_324151.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_324151", "324151100", "story_v_out_324151.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_16 = math.max(var_446_9, arg_443_1.talkMaxDuration)

			if var_446_8 <= arg_443_1.time_ and arg_443_1.time_ < var_446_8 + var_446_16 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_8) / var_446_16

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_8 + var_446_16 and arg_443_1.time_ < var_446_8 + var_446_16 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play324151101 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 324151101
		arg_447_1.duration_ = 7.67

		local var_447_0 = {
			zh = 4.966,
			ja = 7.666
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play324151102(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos10171ui_story = arg_447_1.actors_["10171ui_story"].transform.localPosition

				local var_450_0 = GameObjectTools.GetOrAddComponent(arg_447_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_450_0 then
					var_450_0:EnableDynamicBone(false)
				end
			end

			local var_450_1 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_1 then
				arg_447_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_447_1.time_ - 0) / var_450_1)
				arg_447_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["10171ui_story"].transform.position).z)
				arg_447_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["10171ui_story"].transform.localEulerAngles = arg_447_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_447_1.time_ >= 0 + var_450_1 and arg_447_1.time_ < 0 + var_450_1 + arg_450_0 then
				arg_447_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_447_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["10171ui_story"].transform.position).z)
				arg_447_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["10171ui_story"].transform.localEulerAngles = arg_447_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_450_2 = GameObjectTools.GetOrAddComponent(arg_447_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_450_2 then
					var_450_2:EnableDynamicBone(true)
				end
			end

			local var_450_3 = "1072ui_story"

			if arg_447_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_450_4 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_447_1.stage_.transform)

				var_450_4.name = var_450_3
				var_450_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_447_1.actors_[var_450_3] = var_450_4

				local var_450_5 = var_450_4:GetComponentInChildren(typeof(CharacterEffect))

				var_450_5.enabled = true

				local var_450_6 = GameObjectTools.GetOrAddComponent(var_450_4, typeof(DynamicBoneHelper))

				if var_450_6 then
					var_450_6:EnableDynamicBone(false)
				end

				arg_447_1:ShowWeapon(var_450_5.transform, false)

				arg_447_1.var_[var_450_3 .. "Animator"] = var_450_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_447_1.var_[var_450_3 .. "Animator"].applyRootMotion = true
				arg_447_1.var_[var_450_3 .. "LipSync"] = var_450_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_450_7 = arg_447_1.actors_["1072ui_story"].transform

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos1072ui_story = var_450_7.localPosition
			end

			local var_450_8 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_8 then
				var_450_7.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_447_1.time_ - 0) / var_450_8)
				var_450_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_450_7.position).x, (manager.ui.mainCamera.transform.position - var_450_7.position).y, (manager.ui.mainCamera.transform.position - var_450_7.position).z)
				var_450_7.localEulerAngles.z = 0
				var_450_7.localEulerAngles.x = 0
				var_450_7.localEulerAngles = var_450_7.localEulerAngles
			end

			if arg_447_1.time_ >= 0 + var_450_8 and arg_447_1.time_ < 0 + var_450_8 + arg_450_0 then
				var_450_7.localPosition = Vector3.New(0.7, -0.71, -6)
				var_450_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_450_7.position).x, (manager.ui.mainCamera.transform.position - var_450_7.position).y, (manager.ui.mainCamera.transform.position - var_450_7.position).z)
				var_450_7.localEulerAngles.z = 0
				var_450_7.localEulerAngles.x = 0
				var_450_7.localEulerAngles = var_450_7.localEulerAngles
			end

			local var_450_9 = arg_447_1.actors_["1072ui_story"]

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(var_450_9) and arg_447_1.var_.characterEffect1072ui_story == nil then
				arg_447_1.var_.characterEffect1072ui_story = var_450_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_10 = 0.200000002980232

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_10 and not isNil(var_450_9) then
				if arg_447_1.var_.characterEffect1072ui_story and not isNil(var_450_9) then
					arg_447_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= 0 + var_450_10 and arg_447_1.time_ < 0 + var_450_10 + arg_450_0 and not isNil(var_450_9) and arg_447_1.var_.characterEffect1072ui_story then
				arg_447_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_450_12 = arg_447_1.actors_["10171ui_story"]

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(var_450_12) and arg_447_1.var_.characterEffect10171ui_story == nil then
				arg_447_1.var_.characterEffect10171ui_story = var_450_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_13 = 0.200000002980232

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_13 and not isNil(var_450_12) then
				if arg_447_1.var_.characterEffect10171ui_story and not isNil(var_450_12) then
					arg_447_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_447_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_447_1.time_ - 0) / var_450_13)
				end
			end

			if arg_447_1.time_ >= 0 + var_450_13 and arg_447_1.time_ < 0 + var_450_13 + arg_450_0 and not isNil(var_450_12) and arg_447_1.var_.characterEffect10171ui_story then
				arg_447_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_447_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_450_14 = 0
			local var_450_15 = 0.55

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_14 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_16 = arg_447_1:GetWordFromCfg(324151101)
				local var_450_17 = arg_447_1:FormatText(var_450_16.content)

				arg_447_1.text_.text = var_450_17

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_19 = 22 <= 0 and var_450_15 or var_450_15 * (utf8.len(var_450_17) / 22)

				if (22 <= 0 and var_450_15 or var_450_15 * (utf8.len(var_450_17) / 22)) > 0 and var_450_15 < var_450_19 then
					arg_447_1.talkMaxDuration = var_450_19

					if var_450_19 + var_450_14 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_19 + var_450_14
					end
				end

				arg_447_1.text_.text = var_450_17
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151101", "story_v_out_324151.awb") ~= 0 then
					local var_450_20 = manager.audio:GetVoiceLength("story_v_out_324151", "324151101", "story_v_out_324151.awb") / 1000

					if var_450_20 + var_450_14 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_20 + var_450_14
					end

					if var_450_16.prefab_name ~= "" and arg_447_1.actors_[var_450_16.prefab_name] ~= nil then
						local var_450_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_16.prefab_name].transform, "story_v_out_324151", "324151101", "story_v_out_324151.awb")

						arg_447_1:RecordAudio("324151101", var_450_21)
						arg_447_1:RecordAudio("324151101", var_450_21)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_324151", "324151101", "story_v_out_324151.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_324151", "324151101", "story_v_out_324151.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_22 = math.max(var_450_15, arg_447_1.talkMaxDuration)

			if var_450_14 <= arg_447_1.time_ and arg_447_1.time_ < var_450_14 + var_450_22 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_14) / var_450_22

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_14 + var_450_22 and arg_447_1.time_ < var_450_14 + var_450_22 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play324151102 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 324151102
		arg_451_1.duration_ = 3.3

		local var_451_0 = {
			zh = 3.033,
			ja = 3.3
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play324151103(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if arg_451_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_454_0 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_451_1.stage_.transform)

				var_454_0.name = "1074ui_story"
				var_454_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_451_1.actors_["1074ui_story"] = var_454_0

				local var_454_1 = var_454_0:GetComponentInChildren(typeof(CharacterEffect))

				var_454_1.enabled = true

				local var_454_2 = GameObjectTools.GetOrAddComponent(var_454_0, typeof(DynamicBoneHelper))

				if var_454_2 then
					var_454_2:EnableDynamicBone(false)
				end

				arg_451_1:ShowWeapon(var_454_1.transform, false)

				arg_451_1.var_["1074ui_story" .. "Animator"] = var_454_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_451_1.var_["1074ui_story" .. "Animator"].applyRootMotion = true
				arg_451_1.var_["1074ui_story" .. "LipSync"] = var_454_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_454_3 = arg_451_1.actors_["1074ui_story"].transform

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1074ui_story = var_454_3.localPosition
			end

			local var_454_4 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_4 then
				var_454_3.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_451_1.time_ - 0) / var_454_4)
				var_454_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_3.position).x, (manager.ui.mainCamera.transform.position - var_454_3.position).y, (manager.ui.mainCamera.transform.position - var_454_3.position).z)
				var_454_3.localEulerAngles.z = 0
				var_454_3.localEulerAngles.x = 0
				var_454_3.localEulerAngles = var_454_3.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_4 and arg_451_1.time_ < 0 + var_454_4 + arg_454_0 then
				var_454_3.localPosition = Vector3.New(0, -1.055, -6.12)
				var_454_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_3.position).x, (manager.ui.mainCamera.transform.position - var_454_3.position).y, (manager.ui.mainCamera.transform.position - var_454_3.position).z)
				var_454_3.localEulerAngles.z = 0
				var_454_3.localEulerAngles.x = 0
				var_454_3.localEulerAngles = var_454_3.localEulerAngles
			end

			local var_454_5 = arg_451_1.actors_["10171ui_story"].transform

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos10171ui_story = var_454_5.localPosition

				local var_454_6 = GameObjectTools.GetOrAddComponent(var_454_5.gameObject, typeof(DynamicBoneHelper))

				if var_454_6 then
					var_454_6:EnableDynamicBone(false)
				end
			end

			local var_454_7 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_7 then
				var_454_5.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_451_1.time_ - 0) / var_454_7)
				var_454_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_5.position).x, (manager.ui.mainCamera.transform.position - var_454_5.position).y, (manager.ui.mainCamera.transform.position - var_454_5.position).z)
				var_454_5.localEulerAngles.z = 0
				var_454_5.localEulerAngles.x = 0
				var_454_5.localEulerAngles = var_454_5.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_7 and arg_451_1.time_ < 0 + var_454_7 + arg_454_0 then
				var_454_5.localPosition = Vector3.New(0, 100, 0)
				var_454_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_5.position).x, (manager.ui.mainCamera.transform.position - var_454_5.position).y, (manager.ui.mainCamera.transform.position - var_454_5.position).z)
				var_454_5.localEulerAngles.z = 0
				var_454_5.localEulerAngles.x = 0
				var_454_5.localEulerAngles = var_454_5.localEulerAngles

				local var_454_8 = GameObjectTools.GetOrAddComponent(var_454_5.gameObject, typeof(DynamicBoneHelper))

				if var_454_8 then
					var_454_8:EnableDynamicBone(true)
				end
			end

			local var_454_9 = arg_451_1.actors_["1072ui_story"].transform

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1072ui_story = var_454_9.localPosition
			end

			local var_454_10 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_10 then
				var_454_9.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_451_1.time_ - 0) / var_454_10)
				var_454_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_9.position).x, (manager.ui.mainCamera.transform.position - var_454_9.position).y, (manager.ui.mainCamera.transform.position - var_454_9.position).z)
				var_454_9.localEulerAngles.z = 0
				var_454_9.localEulerAngles.x = 0
				var_454_9.localEulerAngles = var_454_9.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_10 and arg_451_1.time_ < 0 + var_454_10 + arg_454_0 then
				var_454_9.localPosition = Vector3.New(0, 100, 0)
				var_454_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_9.position).x, (manager.ui.mainCamera.transform.position - var_454_9.position).y, (manager.ui.mainCamera.transform.position - var_454_9.position).z)
				var_454_9.localEulerAngles.z = 0
				var_454_9.localEulerAngles.x = 0
				var_454_9.localEulerAngles = var_454_9.localEulerAngles
			end

			local var_454_11 = arg_451_1.actors_["1074ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_11) and arg_451_1.var_.characterEffect1074ui_story == nil then
				arg_451_1.var_.characterEffect1074ui_story = var_454_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_12 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_12 and not isNil(var_454_11) then
				if arg_451_1.var_.characterEffect1074ui_story and not isNil(var_454_11) then
					arg_451_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_12 and arg_451_1.time_ < 0 + var_454_12 + arg_454_0 and not isNil(var_454_11) and arg_451_1.var_.characterEffect1074ui_story then
				arg_451_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_454_14 = arg_451_1.actors_["1072ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_14) and arg_451_1.var_.characterEffect1072ui_story == nil then
				arg_451_1.var_.characterEffect1072ui_story = var_454_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_15 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_15 and not isNil(var_454_14) then
				if arg_451_1.var_.characterEffect1072ui_story and not isNil(var_454_14) then
					arg_451_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_451_1.time_ - 0) / var_454_15)
				end
			end

			if arg_451_1.time_ >= 0 + var_454_15 and arg_451_1.time_ < 0 + var_454_15 + arg_454_0 and not isNil(var_454_14) and arg_451_1.var_.characterEffect1072ui_story then
				arg_451_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_454_16 = 0
			local var_454_17 = 0.4

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_16 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_18 = arg_451_1:GetWordFromCfg(324151102)
				local var_454_19 = arg_451_1:FormatText(var_454_18.content)

				arg_451_1.text_.text = var_454_19

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_21 = 16 <= 0 and var_454_17 or var_454_17 * (utf8.len(var_454_19) / 16)

				if (16 <= 0 and var_454_17 or var_454_17 * (utf8.len(var_454_19) / 16)) > 0 and var_454_17 < var_454_21 then
					arg_451_1.talkMaxDuration = var_454_21

					if var_454_21 + var_454_16 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_21 + var_454_16
					end
				end

				arg_451_1.text_.text = var_454_19
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151102", "story_v_out_324151.awb") ~= 0 then
					local var_454_22 = manager.audio:GetVoiceLength("story_v_out_324151", "324151102", "story_v_out_324151.awb") / 1000

					if var_454_22 + var_454_16 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_22 + var_454_16
					end

					if var_454_18.prefab_name ~= "" and arg_451_1.actors_[var_454_18.prefab_name] ~= nil then
						local var_454_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_18.prefab_name].transform, "story_v_out_324151", "324151102", "story_v_out_324151.awb")

						arg_451_1:RecordAudio("324151102", var_454_23)
						arg_451_1:RecordAudio("324151102", var_454_23)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_324151", "324151102", "story_v_out_324151.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_324151", "324151102", "story_v_out_324151.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_24 = math.max(var_454_17, arg_451_1.talkMaxDuration)

			if var_454_16 <= arg_451_1.time_ and arg_451_1.time_ < var_454_16 + var_454_24 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_16) / var_454_24

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_16 + var_454_24 and arg_451_1.time_ < var_454_16 + var_454_24 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play324151103 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 324151103
		arg_455_1.duration_ = 7.27

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play324151104(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 1.36666666666667 < arg_455_1.time_ and arg_455_1.time_ <= 1.36666666666667 + arg_458_0 then
				local var_458_0 = arg_455_1.bgs_.J22g

				arg_455_1.bgs_.J22g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_458_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_458_1 = var_458_0:GetComponent("SpriteRenderer")

				if var_458_1 and var_458_1.sprite then
					local var_458_2 = 2 * (var_458_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_458_0.transform.localScale = Vector3.New(var_458_2 / var_458_1.sprite.bounds.size.y < var_458_2 * manager.ui.mainCameraCom_.aspect / var_458_1.sprite.bounds.size.x and var_458_2 * manager.ui.mainCameraCom_.aspect / var_458_1.sprite.bounds.size.x or var_458_2 / var_458_1.sprite.bounds.size.y, var_458_2 / var_458_1.sprite.bounds.size.y < var_458_2 * manager.ui.mainCameraCom_.aspect / var_458_1.sprite.bounds.size.x and var_458_2 * manager.ui.mainCameraCom_.aspect / var_458_1.sprite.bounds.size.x or var_458_2 / var_458_1.sprite.bounds.size.y, 0)
				end

				for iter_458_0, iter_458_1 in pairs(arg_455_1.bgs_) do
					if iter_458_0 ~= "J22g" then
						iter_458_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_458_3 = 1.36666666666667

			if 1.36666666666667 < arg_455_1.time_ and arg_455_1.time_ <= var_458_3 + arg_458_0 then
				arg_455_1.allBtn_.enabled = false
			end

			if arg_455_1.time_ >= var_458_3 + 0.3 and arg_455_1.time_ < var_458_3 + 0.3 + arg_458_0 then
				arg_455_1.allBtn_.enabled = true
			end

			local var_458_4 = 0

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_4 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_5 = 1.36666666666667

			if var_458_4 <= arg_455_1.time_ and arg_455_1.time_ < var_458_4 + var_458_5 then
				local var_458_6 = Color.New(0, 0, 0)

				var_458_6.a = Mathf.Lerp(0, 1, (arg_455_1.time_ - var_458_4) / var_458_5)
				arg_455_1.mask_.color = var_458_6
			end

			if arg_455_1.time_ >= var_458_4 + var_458_5 and arg_455_1.time_ < var_458_4 + var_458_5 + arg_458_0 then
				local var_458_7 = Color.New(0, 0, 0)

				var_458_7.a = 1
				arg_455_1.mask_.color = var_458_7
			end

			local var_458_8 = 1.36666666666667

			if 1.36666666666667 < arg_455_1.time_ and arg_455_1.time_ <= var_458_8 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_9 = 2.23333333333333

			if var_458_8 <= arg_455_1.time_ and arg_455_1.time_ < var_458_8 + var_458_9 then
				local var_458_10 = Color.New(0, 0, 0)

				var_458_10.a = Mathf.Lerp(1, 0, (arg_455_1.time_ - var_458_8) / var_458_9)
				arg_455_1.mask_.color = var_458_10
			end

			if arg_455_1.time_ >= var_458_8 + var_458_9 and arg_455_1.time_ < var_458_8 + var_458_9 + arg_458_0 then
				local var_458_11 = Color.New(0, 0, 0)

				arg_455_1.mask_.enabled = false
				var_458_11.a = 0
				arg_455_1.mask_.color = var_458_11
			end

			local var_458_12 = arg_455_1.actors_["1074ui_story"].transform

			if 1.36666666666667 < arg_455_1.time_ and arg_455_1.time_ <= 1.36666666666667 + arg_458_0 then
				arg_455_1.var_.moveOldPos1074ui_story = var_458_12.localPosition
			end

			local var_458_13 = 0.001

			if 1.36666666666667 <= arg_455_1.time_ and arg_455_1.time_ < 1.36666666666667 + var_458_13 then
				var_458_12.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_455_1.time_ - 1.36666666666667) / var_458_13)
				var_458_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_458_12.position).x, (manager.ui.mainCamera.transform.position - var_458_12.position).y, (manager.ui.mainCamera.transform.position - var_458_12.position).z)
				var_458_12.localEulerAngles.z = 0
				var_458_12.localEulerAngles.x = 0
				var_458_12.localEulerAngles = var_458_12.localEulerAngles
			end

			if arg_455_1.time_ >= 1.36666666666667 + var_458_13 and arg_455_1.time_ < 1.36666666666667 + var_458_13 + arg_458_0 then
				var_458_12.localPosition = Vector3.New(0, 100, 0)
				var_458_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_458_12.position).x, (manager.ui.mainCamera.transform.position - var_458_12.position).y, (manager.ui.mainCamera.transform.position - var_458_12.position).z)
				var_458_12.localEulerAngles.z = 0
				var_458_12.localEulerAngles.x = 0
				var_458_12.localEulerAngles = var_458_12.localEulerAngles
			end

			local var_458_14 = arg_455_1.actors_["1074ui_story"]

			if 1.36666666666667 < arg_455_1.time_ and arg_455_1.time_ <= 1.36666666666667 + arg_458_0 and not isNil(var_458_14) and arg_455_1.var_.characterEffect1074ui_story == nil then
				arg_455_1.var_.characterEffect1074ui_story = var_458_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_15 = 0.200000002980232

			if 1.36666666666667 <= arg_455_1.time_ and arg_455_1.time_ < 1.36666666666667 + var_458_15 and not isNil(var_458_14) then
				if arg_455_1.var_.characterEffect1074ui_story and not isNil(var_458_14) then
					arg_455_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_455_1.time_ - 1.36666666666667) / var_458_15)
				end
			end

			if arg_455_1.time_ >= 1.36666666666667 + var_458_15 and arg_455_1.time_ < 1.36666666666667 + var_458_15 + arg_458_0 and not isNil(var_458_14) and arg_455_1.var_.characterEffect1074ui_story then
				arg_455_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if arg_455_1.frameCnt_ <= 1 then
				arg_455_1.dialog_:SetActive(false)
			end

			local var_458_16 = 2.26666666666667
			local var_458_17 = 1.1

			if 2.26666666666667 < arg_455_1.time_ and arg_455_1.time_ <= var_458_16 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0

				arg_455_1.dialog_:SetActive(true)

				arg_455_1.dialogCg_.alpha = 0

				local var_458_18 = LeanTween.value(arg_455_1.dialog_, 0, 1, 0.3)

				var_458_18:setOnUpdate(LuaHelper.FloatAction(function(arg_459_0)
					arg_455_1.dialogCg_.alpha = arg_459_0
				end))
				var_458_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_455_1.dialog_)
					var_458_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_455_1.duration_ = arg_455_1.duration_ + 0.3

				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_19 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(324151103).content)

				arg_455_1.text_.text = var_458_19

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_21 = 44 <= 0 and var_458_17 or var_458_17 * (utf8.len(var_458_19) / 44)

				if (44 <= 0 and var_458_17 or var_458_17 * (utf8.len(var_458_19) / 44)) > 0 and var_458_17 < var_458_21 then
					arg_455_1.talkMaxDuration = var_458_21
					var_458_16 = var_458_16 + 0.3

					if var_458_21 + var_458_16 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_21 + var_458_16
					end
				end

				arg_455_1.text_.text = var_458_19
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_22 = var_458_16 + 0.3
			local var_458_23 = math.max(var_458_17, arg_455_1.talkMaxDuration)

			if var_458_16 + 0.3 <= arg_455_1.time_ and arg_455_1.time_ < var_458_22 + var_458_23 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_22) / var_458_23

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_22 + var_458_23 and arg_455_1.time_ < var_458_22 + var_458_23 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play324151104 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 324151104
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play324151105(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 1.475

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(324151104).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 59 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 59)

				if (59 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 59)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play324151105 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 324151105
		arg_465_1.duration_ = 6.3

		local var_465_0 = {
			zh = 6.3,
			ja = 4.433
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play324151106(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos10171ui_story = arg_465_1.actors_["10171ui_story"].transform.localPosition

				local var_468_0 = GameObjectTools.GetOrAddComponent(arg_465_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_468_0 then
					var_468_0:EnableDynamicBone(false)
				end
			end

			local var_468_1 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_1 then
				arg_465_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_465_1.time_ - 0) / var_468_1)
				arg_465_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10171ui_story"].transform.position).z)
				arg_465_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["10171ui_story"].transform.localEulerAngles = arg_465_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_1 and arg_465_1.time_ < 0 + var_468_1 + arg_468_0 then
				arg_465_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_465_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["10171ui_story"].transform.position).z)
				arg_465_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["10171ui_story"].transform.localEulerAngles = arg_465_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_468_2 = GameObjectTools.GetOrAddComponent(arg_465_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_468_2 then
					var_468_2:EnableDynamicBone(true)
				end
			end

			local var_468_3 = arg_465_1.actors_["10171ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_3) and arg_465_1.var_.characterEffect10171ui_story == nil then
				arg_465_1.var_.characterEffect10171ui_story = var_468_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_4 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 and not isNil(var_468_3) then
				if arg_465_1.var_.characterEffect10171ui_story and not isNil(var_468_3) then
					arg_465_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 and not isNil(var_468_3) and arg_465_1.var_.characterEffect10171ui_story then
				arg_465_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_468_6 = 0
			local var_468_7 = 0.3

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_8 = arg_465_1:GetWordFromCfg(324151105)
				local var_468_9 = arg_465_1:FormatText(var_468_8.content)

				arg_465_1.text_.text = var_468_9

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_11 = 12 <= 0 and var_468_7 or var_468_7 * (utf8.len(var_468_9) / 12)

				if (12 <= 0 and var_468_7 or var_468_7 * (utf8.len(var_468_9) / 12)) > 0 and var_468_7 < var_468_11 then
					arg_465_1.talkMaxDuration = var_468_11

					if var_468_11 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_11 + var_468_6
					end
				end

				arg_465_1.text_.text = var_468_9
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151105", "story_v_out_324151.awb") ~= 0 then
					local var_468_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151105", "story_v_out_324151.awb") / 1000

					if var_468_12 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_12 + var_468_6
					end

					if var_468_8.prefab_name ~= "" and arg_465_1.actors_[var_468_8.prefab_name] ~= nil then
						local var_468_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_8.prefab_name].transform, "story_v_out_324151", "324151105", "story_v_out_324151.awb")

						arg_465_1:RecordAudio("324151105", var_468_13)
						arg_465_1:RecordAudio("324151105", var_468_13)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_324151", "324151105", "story_v_out_324151.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_324151", "324151105", "story_v_out_324151.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_14 = math.max(var_468_7, arg_465_1.talkMaxDuration)

			if var_468_6 <= arg_465_1.time_ and arg_465_1.time_ < var_468_6 + var_468_14 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_6) / var_468_14

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_6 + var_468_14 and arg_465_1.time_ < var_468_6 + var_468_14 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play324151106 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 324151106
		arg_469_1.duration_ = 4.93

		local var_469_0 = {
			zh = 3.166,
			ja = 4.933
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play324151107(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos1060ui_story = arg_469_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_472_0 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 then
				arg_469_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1060ui_story, Vector3.New(0.7, -1.14, -6.33), (arg_469_1.time_ - 0) / var_472_0)
				arg_469_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1060ui_story"].transform.position).z)
				arg_469_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["1060ui_story"].transform.localEulerAngles = arg_469_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 then
				arg_469_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0.7, -1.14, -6.33)
				arg_469_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1060ui_story"].transform.position).z)
				arg_469_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["1060ui_story"].transform.localEulerAngles = arg_469_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_472_1 = arg_469_1.actors_["1060ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect1060ui_story == nil then
				arg_469_1.var_.characterEffect1060ui_story = var_472_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_2 and not isNil(var_472_1) then
				if arg_469_1.var_.characterEffect1060ui_story and not isNil(var_472_1) then
					arg_469_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= 0 + var_472_2 and arg_469_1.time_ < 0 + var_472_2 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect1060ui_story then
				arg_469_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_472_4 = arg_469_1.actors_["10171ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_4) and arg_469_1.var_.characterEffect10171ui_story == nil then
				arg_469_1.var_.characterEffect10171ui_story = var_472_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_5 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_5 and not isNil(var_472_4) then
				if arg_469_1.var_.characterEffect10171ui_story and not isNil(var_472_4) then
					arg_469_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_469_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_5)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_5 and arg_469_1.time_ < 0 + var_472_5 + arg_472_0 and not isNil(var_472_4) and arg_469_1.var_.characterEffect10171ui_story then
				arg_469_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_469_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_2")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_472_6 = 0
			local var_472_7 = 0.4

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_6 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_8 = arg_469_1:GetWordFromCfg(324151106)
				local var_472_9 = arg_469_1:FormatText(var_472_8.content)

				arg_469_1.text_.text = var_472_9

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_11 = 16 <= 0 and var_472_7 or var_472_7 * (utf8.len(var_472_9) / 16)

				if (16 <= 0 and var_472_7 or var_472_7 * (utf8.len(var_472_9) / 16)) > 0 and var_472_7 < var_472_11 then
					arg_469_1.talkMaxDuration = var_472_11

					if var_472_11 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_11 + var_472_6
					end
				end

				arg_469_1.text_.text = var_472_9
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151106", "story_v_out_324151.awb") ~= 0 then
					local var_472_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151106", "story_v_out_324151.awb") / 1000

					if var_472_12 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_12 + var_472_6
					end

					if var_472_8.prefab_name ~= "" and arg_469_1.actors_[var_472_8.prefab_name] ~= nil then
						local var_472_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_8.prefab_name].transform, "story_v_out_324151", "324151106", "story_v_out_324151.awb")

						arg_469_1:RecordAudio("324151106", var_472_13)
						arg_469_1:RecordAudio("324151106", var_472_13)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_324151", "324151106", "story_v_out_324151.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_324151", "324151106", "story_v_out_324151.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_14 = math.max(var_472_7, arg_469_1.talkMaxDuration)

			if var_472_6 <= arg_469_1.time_ and arg_469_1.time_ < var_472_6 + var_472_14 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_6) / var_472_14

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_6 + var_472_14 and arg_469_1.time_ < var_472_6 + var_472_14 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play324151107 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 324151107
		arg_473_1.duration_ = 2.6

		local var_473_0 = {
			zh = 2.6,
			ja = 2.166
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play324151108(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["10171ui_story"]) and arg_473_1.var_.characterEffect10171ui_story == nil then
				arg_473_1.var_.characterEffect10171ui_story = arg_473_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["10171ui_story"]) then
				if arg_473_1.var_.characterEffect10171ui_story and not isNil(arg_473_1.actors_["10171ui_story"]) then
					arg_473_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["10171ui_story"]) and arg_473_1.var_.characterEffect10171ui_story then
				arg_473_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_476_2 = arg_473_1.actors_["1060ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_2) and arg_473_1.var_.characterEffect1060ui_story == nil then
				arg_473_1.var_.characterEffect1060ui_story = var_476_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_3 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_3 and not isNil(var_476_2) then
				if arg_473_1.var_.characterEffect1060ui_story and not isNil(var_476_2) then
					arg_473_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_3)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_3 and arg_473_1.time_ < 0 + var_476_3 + arg_476_0 and not isNil(var_476_2) and arg_473_1.var_.characterEffect1060ui_story then
				arg_473_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_476_4 = 0
			local var_476_5 = 0.225

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_6 = arg_473_1:GetWordFromCfg(324151107)
				local var_476_7 = arg_473_1:FormatText(var_476_6.content)

				arg_473_1.text_.text = var_476_7

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 9 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 9)

				if (9 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 9)) > 0 and var_476_5 < var_476_9 then
					arg_473_1.talkMaxDuration = var_476_9

					if var_476_9 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_7
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151107", "story_v_out_324151.awb") ~= 0 then
					local var_476_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151107", "story_v_out_324151.awb") / 1000

					if var_476_10 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_10 + var_476_4
					end

					if var_476_6.prefab_name ~= "" and arg_473_1.actors_[var_476_6.prefab_name] ~= nil then
						local var_476_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_6.prefab_name].transform, "story_v_out_324151", "324151107", "story_v_out_324151.awb")

						arg_473_1:RecordAudio("324151107", var_476_11)
						arg_473_1:RecordAudio("324151107", var_476_11)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_324151", "324151107", "story_v_out_324151.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_324151", "324151107", "story_v_out_324151.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_12 = math.max(var_476_5, arg_473_1.talkMaxDuration)

			if var_476_4 <= arg_473_1.time_ and arg_473_1.time_ < var_476_4 + var_476_12 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_4) / var_476_12

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_4 + var_476_12 and arg_473_1.time_ < var_476_4 + var_476_12 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play324151108 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 324151108
		arg_477_1.duration_ = 8.9

		local var_477_0 = {
			zh = 7.433,
			ja = 8.9
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play324151109(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1074ui_story = arg_477_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_480_0 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				arg_477_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_477_1.time_ - 0) / var_480_0)
				arg_477_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1074ui_story"].transform.position).z)
				arg_477_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1074ui_story"].transform.localEulerAngles = arg_477_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				arg_477_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_477_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1074ui_story"].transform.position).z)
				arg_477_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1074ui_story"].transform.localEulerAngles = arg_477_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_480_1 = arg_477_1.actors_["1060ui_story"].transform

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1060ui_story = var_480_1.localPosition
			end

			local var_480_2 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 then
				var_480_1.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_477_1.time_ - 0) / var_480_2)
				var_480_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_1.position).x, (manager.ui.mainCamera.transform.position - var_480_1.position).y, (manager.ui.mainCamera.transform.position - var_480_1.position).z)
				var_480_1.localEulerAngles.z = 0
				var_480_1.localEulerAngles.x = 0
				var_480_1.localEulerAngles = var_480_1.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 then
				var_480_1.localPosition = Vector3.New(0, 100, 0)
				var_480_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_1.position).x, (manager.ui.mainCamera.transform.position - var_480_1.position).y, (manager.ui.mainCamera.transform.position - var_480_1.position).z)
				var_480_1.localEulerAngles.z = 0
				var_480_1.localEulerAngles.x = 0
				var_480_1.localEulerAngles = var_480_1.localEulerAngles
			end

			local var_480_3 = arg_477_1.actors_["1074ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_3) and arg_477_1.var_.characterEffect1074ui_story == nil then
				arg_477_1.var_.characterEffect1074ui_story = var_480_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_4 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 and not isNil(var_480_3) then
				if arg_477_1.var_.characterEffect1074ui_story and not isNil(var_480_3) then
					arg_477_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 and not isNil(var_480_3) and arg_477_1.var_.characterEffect1074ui_story then
				arg_477_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_480_6 = arg_477_1.actors_["10171ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_6) and arg_477_1.var_.characterEffect10171ui_story == nil then
				arg_477_1.var_.characterEffect10171ui_story = var_480_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_7 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_7 and not isNil(var_480_6) then
				if arg_477_1.var_.characterEffect10171ui_story and not isNil(var_480_6) then
					arg_477_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_477_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_7)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_7 and arg_477_1.time_ < 0 + var_480_7 + arg_480_0 and not isNil(var_480_6) and arg_477_1.var_.characterEffect10171ui_story then
				arg_477_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_477_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_480_8 = 0
			local var_480_9 = 1.075

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_8 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_10 = arg_477_1:GetWordFromCfg(324151108)
				local var_480_11 = arg_477_1:FormatText(var_480_10.content)

				arg_477_1.text_.text = var_480_11

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_13 = 43 <= 0 and var_480_9 or var_480_9 * (utf8.len(var_480_11) / 43)

				if (43 <= 0 and var_480_9 or var_480_9 * (utf8.len(var_480_11) / 43)) > 0 and var_480_9 < var_480_13 then
					arg_477_1.talkMaxDuration = var_480_13

					if var_480_13 + var_480_8 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_13 + var_480_8
					end
				end

				arg_477_1.text_.text = var_480_11
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151108", "story_v_out_324151.awb") ~= 0 then
					local var_480_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151108", "story_v_out_324151.awb") / 1000

					if var_480_14 + var_480_8 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_14 + var_480_8
					end

					if var_480_10.prefab_name ~= "" and arg_477_1.actors_[var_480_10.prefab_name] ~= nil then
						local var_480_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_10.prefab_name].transform, "story_v_out_324151", "324151108", "story_v_out_324151.awb")

						arg_477_1:RecordAudio("324151108", var_480_15)
						arg_477_1:RecordAudio("324151108", var_480_15)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_324151", "324151108", "story_v_out_324151.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_324151", "324151108", "story_v_out_324151.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_16 = math.max(var_480_9, arg_477_1.talkMaxDuration)

			if var_480_8 <= arg_477_1.time_ and arg_477_1.time_ < var_480_8 + var_480_16 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_8) / var_480_16

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_8 + var_480_16 and arg_477_1.time_ < var_480_8 + var_480_16 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play324151109 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 324151109
		arg_481_1.duration_ = 3.9

		local var_481_0 = {
			zh = 3.533,
			ja = 3.9
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play324151110(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.525

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:GetWordFromCfg(324151109)
				local var_484_2 = arg_481_1:FormatText(var_484_1.content)

				arg_481_1.text_.text = var_484_2

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 21 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 21)

				if (21 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 21)) > 0 and var_484_0 < var_484_4 then
					arg_481_1.talkMaxDuration = var_484_4

					if var_484_4 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_4 + 0
					end
				end

				arg_481_1.text_.text = var_484_2
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151109", "story_v_out_324151.awb") ~= 0 then
					local var_484_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151109", "story_v_out_324151.awb") / 1000

					if var_484_5 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + 0
					end

					if var_484_1.prefab_name ~= "" and arg_481_1.actors_[var_484_1.prefab_name] ~= nil then
						local var_484_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_1.prefab_name].transform, "story_v_out_324151", "324151109", "story_v_out_324151.awb")

						arg_481_1:RecordAudio("324151109", var_484_6)
						arg_481_1:RecordAudio("324151109", var_484_6)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_324151", "324151109", "story_v_out_324151.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_324151", "324151109", "story_v_out_324151.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play324151110 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 324151110
		arg_485_1.duration_ = 5.13

		local var_485_0 = {
			zh = 5.133,
			ja = 4.3
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play324151111(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos1074ui_story = arg_485_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_488_0 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 then
				arg_485_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_485_1.time_ - 0) / var_488_0)
				arg_485_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1074ui_story"].transform.position).z)
				arg_485_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1074ui_story"].transform.localEulerAngles = arg_485_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 then
				arg_485_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_485_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1074ui_story"].transform.position).z)
				arg_485_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1074ui_story"].transform.localEulerAngles = arg_485_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_488_1 = arg_485_1.actors_["1072ui_story"].transform

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos1072ui_story = var_488_1.localPosition
			end

			local var_488_2 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_2 then
				var_488_1.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_485_1.time_ - 0) / var_488_2)
				var_488_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_1.position).x, (manager.ui.mainCamera.transform.position - var_488_1.position).y, (manager.ui.mainCamera.transform.position - var_488_1.position).z)
				var_488_1.localEulerAngles.z = 0
				var_488_1.localEulerAngles.x = 0
				var_488_1.localEulerAngles = var_488_1.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_2 and arg_485_1.time_ < 0 + var_488_2 + arg_488_0 then
				var_488_1.localPosition = Vector3.New(0.7, -0.71, -6)
				var_488_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_1.position).x, (manager.ui.mainCamera.transform.position - var_488_1.position).y, (manager.ui.mainCamera.transform.position - var_488_1.position).z)
				var_488_1.localEulerAngles.z = 0
				var_488_1.localEulerAngles.x = 0
				var_488_1.localEulerAngles = var_488_1.localEulerAngles
			end

			local var_488_3 = arg_485_1.actors_["1072ui_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_3) and arg_485_1.var_.characterEffect1072ui_story == nil then
				arg_485_1.var_.characterEffect1072ui_story = var_488_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_4 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_4 and not isNil(var_488_3) then
				if arg_485_1.var_.characterEffect1072ui_story and not isNil(var_488_3) then
					arg_485_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_4 and arg_485_1.time_ < 0 + var_488_4 + arg_488_0 and not isNil(var_488_3) and arg_485_1.var_.characterEffect1072ui_story then
				arg_485_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_488_6 = arg_485_1.actors_["1074ui_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_6) and arg_485_1.var_.characterEffect1074ui_story == nil then
				arg_485_1.var_.characterEffect1074ui_story = var_488_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_7 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_7 and not isNil(var_488_6) then
				if arg_485_1.var_.characterEffect1074ui_story and not isNil(var_488_6) then
					arg_485_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_7)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_7 and arg_485_1.time_ < 0 + var_488_7 + arg_488_0 and not isNil(var_488_6) and arg_485_1.var_.characterEffect1074ui_story then
				arg_485_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_488_8 = 0
			local var_488_9 = 0.6

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_8 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_10 = arg_485_1:GetWordFromCfg(324151110)
				local var_488_11 = arg_485_1:FormatText(var_488_10.content)

				arg_485_1.text_.text = var_488_11

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_13 = 24 <= 0 and var_488_9 or var_488_9 * (utf8.len(var_488_11) / 24)

				if (24 <= 0 and var_488_9 or var_488_9 * (utf8.len(var_488_11) / 24)) > 0 and var_488_9 < var_488_13 then
					arg_485_1.talkMaxDuration = var_488_13

					if var_488_13 + var_488_8 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_13 + var_488_8
					end
				end

				arg_485_1.text_.text = var_488_11
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151110", "story_v_out_324151.awb") ~= 0 then
					local var_488_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151110", "story_v_out_324151.awb") / 1000

					if var_488_14 + var_488_8 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_14 + var_488_8
					end

					if var_488_10.prefab_name ~= "" and arg_485_1.actors_[var_488_10.prefab_name] ~= nil then
						local var_488_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_10.prefab_name].transform, "story_v_out_324151", "324151110", "story_v_out_324151.awb")

						arg_485_1:RecordAudio("324151110", var_488_15)
						arg_485_1:RecordAudio("324151110", var_488_15)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_324151", "324151110", "story_v_out_324151.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_324151", "324151110", "story_v_out_324151.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_16 = math.max(var_488_9, arg_485_1.talkMaxDuration)

			if var_488_8 <= arg_485_1.time_ and arg_485_1.time_ < var_488_8 + var_488_16 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_8) / var_488_16

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_8 + var_488_16 and arg_485_1.time_ < var_488_8 + var_488_16 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play324151111 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 324151111
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play324151112(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos1074ui_story = arg_489_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_492_0 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 then
				arg_489_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_489_1.time_ - 0) / var_492_0)
				arg_489_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_489_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["1074ui_story"].transform.position).z)
				arg_489_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_489_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_489_1.actors_["1074ui_story"].transform.localEulerAngles = arg_489_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 then
				arg_489_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_489_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_489_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["1074ui_story"].transform.position).z)
				arg_489_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_489_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_489_1.actors_["1074ui_story"].transform.localEulerAngles = arg_489_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_492_1 = arg_489_1.actors_["1072ui_story"].transform

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos1072ui_story = var_492_1.localPosition
			end

			local var_492_2 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_2 then
				var_492_1.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_489_1.time_ - 0) / var_492_2)
				var_492_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_1.position).x, (manager.ui.mainCamera.transform.position - var_492_1.position).y, (manager.ui.mainCamera.transform.position - var_492_1.position).z)
				var_492_1.localEulerAngles.z = 0
				var_492_1.localEulerAngles.x = 0
				var_492_1.localEulerAngles = var_492_1.localEulerAngles
			end

			if arg_489_1.time_ >= 0 + var_492_2 and arg_489_1.time_ < 0 + var_492_2 + arg_492_0 then
				var_492_1.localPosition = Vector3.New(0, 100, 0)
				var_492_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_1.position).x, (manager.ui.mainCamera.transform.position - var_492_1.position).y, (manager.ui.mainCamera.transform.position - var_492_1.position).z)
				var_492_1.localEulerAngles.z = 0
				var_492_1.localEulerAngles.x = 0
				var_492_1.localEulerAngles = var_492_1.localEulerAngles
			end

			local var_492_3 = arg_489_1.actors_["1072ui_story"]

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(var_492_3) and arg_489_1.var_.characterEffect1072ui_story == nil then
				arg_489_1.var_.characterEffect1072ui_story = var_492_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_4 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 and not isNil(var_492_3) then
				if arg_489_1.var_.characterEffect1072ui_story and not isNil(var_492_3) then
					arg_489_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_4)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 and not isNil(var_492_3) and arg_489_1.var_.characterEffect1072ui_story then
				arg_489_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_492_5 = arg_489_1.actors_["10171ui_story"].transform

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos10171ui_story = var_492_5.localPosition

				local var_492_6 = GameObjectTools.GetOrAddComponent(var_492_5.gameObject, typeof(DynamicBoneHelper))

				if var_492_6 then
					var_492_6:EnableDynamicBone(false)
				end
			end

			local var_492_7 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				var_492_5.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_489_1.time_ - 0) / var_492_7)
				var_492_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_5.position).x, (manager.ui.mainCamera.transform.position - var_492_5.position).y, (manager.ui.mainCamera.transform.position - var_492_5.position).z)
				var_492_5.localEulerAngles.z = 0
				var_492_5.localEulerAngles.x = 0
				var_492_5.localEulerAngles = var_492_5.localEulerAngles
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				var_492_5.localPosition = Vector3.New(0, 100, 0)
				var_492_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_5.position).x, (manager.ui.mainCamera.transform.position - var_492_5.position).y, (manager.ui.mainCamera.transform.position - var_492_5.position).z)
				var_492_5.localEulerAngles.z = 0
				var_492_5.localEulerAngles.x = 0
				var_492_5.localEulerAngles = var_492_5.localEulerAngles

				local var_492_8 = GameObjectTools.GetOrAddComponent(var_492_5.gameObject, typeof(DynamicBoneHelper))

				if var_492_8 then
					var_492_8:EnableDynamicBone(true)
				end
			end

			local var_492_9 = 0
			local var_492_10 = 1.675

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_9 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_11 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(324151111).content)

				arg_489_1.text_.text = var_492_11

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_13 = 67 <= 0 and var_492_10 or var_492_10 * (utf8.len(var_492_11) / 67)

				if (67 <= 0 and var_492_10 or var_492_10 * (utf8.len(var_492_11) / 67)) > 0 and var_492_10 < var_492_13 then
					arg_489_1.talkMaxDuration = var_492_13

					if var_492_13 + var_492_9 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_13 + var_492_9
					end
				end

				arg_489_1.text_.text = var_492_11
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_14 = math.max(var_492_10, arg_489_1.talkMaxDuration)

			if var_492_9 <= arg_489_1.time_ and arg_489_1.time_ < var_492_9 + var_492_14 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_9) / var_492_14

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_9 + var_492_14 and arg_489_1.time_ < var_492_9 + var_492_14 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play324151112 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 324151112
		arg_493_1.duration_ = 7

		local var_493_0 = {
			zh = 6.133,
			ja = 7
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play324151113(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos10171ui_story = arg_493_1.actors_["10171ui_story"].transform.localPosition

				local var_496_0 = GameObjectTools.GetOrAddComponent(arg_493_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_496_0 then
					var_496_0:EnableDynamicBone(false)
				end
			end

			local var_496_1 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_1 then
				arg_493_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_493_1.time_ - 0) / var_496_1)
				arg_493_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["10171ui_story"].transform.position).z)
				arg_493_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["10171ui_story"].transform.localEulerAngles = arg_493_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_1 and arg_493_1.time_ < 0 + var_496_1 + arg_496_0 then
				arg_493_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_493_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["10171ui_story"].transform.position).z)
				arg_493_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["10171ui_story"].transform.localEulerAngles = arg_493_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_496_2 = GameObjectTools.GetOrAddComponent(arg_493_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_496_2 then
					var_496_2:EnableDynamicBone(true)
				end
			end

			local var_496_3 = arg_493_1.actors_["10171ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_3) and arg_493_1.var_.characterEffect10171ui_story == nil then
				arg_493_1.var_.characterEffect10171ui_story = var_496_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_4 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_4 and not isNil(var_496_3) then
				if arg_493_1.var_.characterEffect10171ui_story and not isNil(var_496_3) then
					arg_493_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_4 and arg_493_1.time_ < 0 + var_496_4 + arg_496_0 and not isNil(var_496_3) and arg_493_1.var_.characterEffect10171ui_story then
				arg_493_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_496_6 = 0
			local var_496_7 = 0.525

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_6 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_8 = arg_493_1:GetWordFromCfg(324151112)
				local var_496_9 = arg_493_1:FormatText(var_496_8.content)

				arg_493_1.text_.text = var_496_9

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_11 = 21 <= 0 and var_496_7 or var_496_7 * (utf8.len(var_496_9) / 21)

				if (21 <= 0 and var_496_7 or var_496_7 * (utf8.len(var_496_9) / 21)) > 0 and var_496_7 < var_496_11 then
					arg_493_1.talkMaxDuration = var_496_11

					if var_496_11 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_11 + var_496_6
					end
				end

				arg_493_1.text_.text = var_496_9
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151112", "story_v_out_324151.awb") ~= 0 then
					local var_496_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151112", "story_v_out_324151.awb") / 1000

					if var_496_12 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_12 + var_496_6
					end

					if var_496_8.prefab_name ~= "" and arg_493_1.actors_[var_496_8.prefab_name] ~= nil then
						local var_496_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_8.prefab_name].transform, "story_v_out_324151", "324151112", "story_v_out_324151.awb")

						arg_493_1:RecordAudio("324151112", var_496_13)
						arg_493_1:RecordAudio("324151112", var_496_13)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_324151", "324151112", "story_v_out_324151.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_324151", "324151112", "story_v_out_324151.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_14 = math.max(var_496_7, arg_493_1.talkMaxDuration)

			if var_496_6 <= arg_493_1.time_ and arg_493_1.time_ < var_496_6 + var_496_14 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_6) / var_496_14

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_6 + var_496_14 and arg_493_1.time_ < var_496_6 + var_496_14 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play324151113 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 324151113
		arg_497_1.duration_ = 7.03

		local var_497_0 = {
			zh = 7.033,
			ja = 6.766
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play324151114(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos1060ui_story = arg_497_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_500_0 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 then
				arg_497_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1060ui_story, Vector3.New(0.7, -1.14, -6.33), (arg_497_1.time_ - 0) / var_500_0)
				arg_497_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1060ui_story"].transform.position).z)
				arg_497_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1060ui_story"].transform.localEulerAngles = arg_497_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 then
				arg_497_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0.7, -1.14, -6.33)
				arg_497_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1060ui_story"].transform.position).z)
				arg_497_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1060ui_story"].transform.localEulerAngles = arg_497_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_500_1 = arg_497_1.actors_["1060ui_story"]

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(var_500_1) and arg_497_1.var_.characterEffect1060ui_story == nil then
				arg_497_1.var_.characterEffect1060ui_story = var_500_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_2 and not isNil(var_500_1) then
				if arg_497_1.var_.characterEffect1060ui_story and not isNil(var_500_1) then
					arg_497_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= 0 + var_500_2 and arg_497_1.time_ < 0 + var_500_2 + arg_500_0 and not isNil(var_500_1) and arg_497_1.var_.characterEffect1060ui_story then
				arg_497_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_500_4 = arg_497_1.actors_["10171ui_story"]

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(var_500_4) and arg_497_1.var_.characterEffect10171ui_story == nil then
				arg_497_1.var_.characterEffect10171ui_story = var_500_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_5 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_5 and not isNil(var_500_4) then
				if arg_497_1.var_.characterEffect10171ui_story and not isNil(var_500_4) then
					arg_497_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_497_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_497_1.time_ - 0) / var_500_5)
				end
			end

			if arg_497_1.time_ >= 0 + var_500_5 and arg_497_1.time_ < 0 + var_500_5 + arg_500_0 and not isNil(var_500_4) and arg_497_1.var_.characterEffect10171ui_story then
				arg_497_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_497_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action5_1")
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_500_6 = 0
			local var_500_7 = 0.9

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_6 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_8 = arg_497_1:GetWordFromCfg(324151113)
				local var_500_9 = arg_497_1:FormatText(var_500_8.content)

				arg_497_1.text_.text = var_500_9

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_11 = 36 <= 0 and var_500_7 or var_500_7 * (utf8.len(var_500_9) / 36)

				if (36 <= 0 and var_500_7 or var_500_7 * (utf8.len(var_500_9) / 36)) > 0 and var_500_7 < var_500_11 then
					arg_497_1.talkMaxDuration = var_500_11

					if var_500_11 + var_500_6 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_11 + var_500_6
					end
				end

				arg_497_1.text_.text = var_500_9
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151113", "story_v_out_324151.awb") ~= 0 then
					local var_500_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151113", "story_v_out_324151.awb") / 1000

					if var_500_12 + var_500_6 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_12 + var_500_6
					end

					if var_500_8.prefab_name ~= "" and arg_497_1.actors_[var_500_8.prefab_name] ~= nil then
						local var_500_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_8.prefab_name].transform, "story_v_out_324151", "324151113", "story_v_out_324151.awb")

						arg_497_1:RecordAudio("324151113", var_500_13)
						arg_497_1:RecordAudio("324151113", var_500_13)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_324151", "324151113", "story_v_out_324151.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_324151", "324151113", "story_v_out_324151.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_14 = math.max(var_500_7, arg_497_1.talkMaxDuration)

			if var_500_6 <= arg_497_1.time_ and arg_497_1.time_ < var_500_6 + var_500_14 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_6) / var_500_14

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_6 + var_500_14 and arg_497_1.time_ < var_500_6 + var_500_14 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play324151114 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 324151114
		arg_501_1.duration_ = 11.37

		local var_501_0 = {
			zh = 8.2,
			ja = 11.366
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play324151115(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["10171ui_story"]) and arg_501_1.var_.characterEffect10171ui_story == nil then
				arg_501_1.var_.characterEffect10171ui_story = arg_501_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_0 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["10171ui_story"]) then
				if arg_501_1.var_.characterEffect10171ui_story and not isNil(arg_501_1.actors_["10171ui_story"]) then
					arg_501_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["10171ui_story"]) and arg_501_1.var_.characterEffect10171ui_story then
				arg_501_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_504_2 = arg_501_1.actors_["1060ui_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_2) and arg_501_1.var_.characterEffect1060ui_story == nil then
				arg_501_1.var_.characterEffect1060ui_story = var_504_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_3 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_3 and not isNil(var_504_2) then
				if arg_501_1.var_.characterEffect1060ui_story and not isNil(var_504_2) then
					arg_501_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_501_1.time_ - 0) / var_504_3)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_3 and arg_501_1.time_ < 0 + var_504_3 + arg_504_0 and not isNil(var_504_2) and arg_501_1.var_.characterEffect1060ui_story then
				arg_501_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			local var_504_4 = 0
			local var_504_5 = 0.975

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_4 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_6 = arg_501_1:GetWordFromCfg(324151114)
				local var_504_7 = arg_501_1:FormatText(var_504_6.content)

				arg_501_1.text_.text = var_504_7

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_9 = 39 <= 0 and var_504_5 or var_504_5 * (utf8.len(var_504_7) / 39)

				if (39 <= 0 and var_504_5 or var_504_5 * (utf8.len(var_504_7) / 39)) > 0 and var_504_5 < var_504_9 then
					arg_501_1.talkMaxDuration = var_504_9

					if var_504_9 + var_504_4 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_9 + var_504_4
					end
				end

				arg_501_1.text_.text = var_504_7
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151114", "story_v_out_324151.awb") ~= 0 then
					local var_504_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151114", "story_v_out_324151.awb") / 1000

					if var_504_10 + var_504_4 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_10 + var_504_4
					end

					if var_504_6.prefab_name ~= "" and arg_501_1.actors_[var_504_6.prefab_name] ~= nil then
						local var_504_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_6.prefab_name].transform, "story_v_out_324151", "324151114", "story_v_out_324151.awb")

						arg_501_1:RecordAudio("324151114", var_504_11)
						arg_501_1:RecordAudio("324151114", var_504_11)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_324151", "324151114", "story_v_out_324151.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_324151", "324151114", "story_v_out_324151.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_12 = math.max(var_504_5, arg_501_1.talkMaxDuration)

			if var_504_4 <= arg_501_1.time_ and arg_501_1.time_ < var_504_4 + var_504_12 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_4) / var_504_12

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_4 + var_504_12 and arg_501_1.time_ < var_504_4 + var_504_12 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play324151115 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 324151115
		arg_505_1.duration_ = 8.37

		local var_505_0 = {
			zh = 6.566,
			ja = 8.366
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play324151116(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.var_.moveOldPos1072ui_story = arg_505_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_508_0 = 0.001

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 then
				arg_505_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_505_1.time_ - 0) / var_508_0)
				arg_505_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_505_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1072ui_story"].transform.position).z)
				arg_505_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_505_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_505_1.actors_["1072ui_story"].transform.localEulerAngles = arg_505_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 then
				arg_505_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_505_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_505_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1072ui_story"].transform.position).z)
				arg_505_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_505_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_505_1.actors_["1072ui_story"].transform.localEulerAngles = arg_505_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_508_1 = arg_505_1.actors_["1060ui_story"].transform

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.var_.moveOldPos1060ui_story = var_508_1.localPosition
			end

			local var_508_2 = 0.001

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_2 then
				var_508_1.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_505_1.time_ - 0) / var_508_2)
				var_508_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_508_1.position).x, (manager.ui.mainCamera.transform.position - var_508_1.position).y, (manager.ui.mainCamera.transform.position - var_508_1.position).z)
				var_508_1.localEulerAngles.z = 0
				var_508_1.localEulerAngles.x = 0
				var_508_1.localEulerAngles = var_508_1.localEulerAngles
			end

			if arg_505_1.time_ >= 0 + var_508_2 and arg_505_1.time_ < 0 + var_508_2 + arg_508_0 then
				var_508_1.localPosition = Vector3.New(0, 100, 0)
				var_508_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_508_1.position).x, (manager.ui.mainCamera.transform.position - var_508_1.position).y, (manager.ui.mainCamera.transform.position - var_508_1.position).z)
				var_508_1.localEulerAngles.z = 0
				var_508_1.localEulerAngles.x = 0
				var_508_1.localEulerAngles = var_508_1.localEulerAngles
			end

			local var_508_3 = arg_505_1.actors_["1072ui_story"]

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(var_508_3) and arg_505_1.var_.characterEffect1072ui_story == nil then
				arg_505_1.var_.characterEffect1072ui_story = var_508_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_4 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 and not isNil(var_508_3) then
				if arg_505_1.var_.characterEffect1072ui_story and not isNil(var_508_3) then
					arg_505_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 and not isNil(var_508_3) and arg_505_1.var_.characterEffect1072ui_story then
				arg_505_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_508_6 = arg_505_1.actors_["10171ui_story"]

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(var_508_6) and arg_505_1.var_.characterEffect10171ui_story == nil then
				arg_505_1.var_.characterEffect10171ui_story = var_508_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_7 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_7 and not isNil(var_508_6) then
				if arg_505_1.var_.characterEffect10171ui_story and not isNil(var_508_6) then
					arg_505_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_505_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_505_1.time_ - 0) / var_508_7)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_7 and arg_505_1.time_ < 0 + var_508_7 + arg_508_0 and not isNil(var_508_6) and arg_505_1.var_.characterEffect10171ui_story then
				arg_505_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_505_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_508_8 = 0
			local var_508_9 = 0.725

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_8 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_10 = arg_505_1:GetWordFromCfg(324151115)
				local var_508_11 = arg_505_1:FormatText(var_508_10.content)

				arg_505_1.text_.text = var_508_11

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_13 = 29 <= 0 and var_508_9 or var_508_9 * (utf8.len(var_508_11) / 29)

				if (29 <= 0 and var_508_9 or var_508_9 * (utf8.len(var_508_11) / 29)) > 0 and var_508_9 < var_508_13 then
					arg_505_1.talkMaxDuration = var_508_13

					if var_508_13 + var_508_8 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_13 + var_508_8
					end
				end

				arg_505_1.text_.text = var_508_11
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151115", "story_v_out_324151.awb") ~= 0 then
					local var_508_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151115", "story_v_out_324151.awb") / 1000

					if var_508_14 + var_508_8 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_14 + var_508_8
					end

					if var_508_10.prefab_name ~= "" and arg_505_1.actors_[var_508_10.prefab_name] ~= nil then
						local var_508_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_10.prefab_name].transform, "story_v_out_324151", "324151115", "story_v_out_324151.awb")

						arg_505_1:RecordAudio("324151115", var_508_15)
						arg_505_1:RecordAudio("324151115", var_508_15)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_324151", "324151115", "story_v_out_324151.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_324151", "324151115", "story_v_out_324151.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_16 = math.max(var_508_9, arg_505_1.talkMaxDuration)

			if var_508_8 <= arg_505_1.time_ and arg_505_1.time_ < var_508_8 + var_508_16 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_8) / var_508_16

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_8 + var_508_16 and arg_505_1.time_ < var_508_8 + var_508_16 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_505_1:InitPlayNodeList()
	end,
	Play324151116 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 324151116
		arg_509_1.duration_ = 5.77

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play324151117(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0.575

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_1 = arg_509_1:GetWordFromCfg(324151116)
				local var_512_2 = arg_509_1:FormatText(var_512_1.content)

				arg_509_1.text_.text = var_512_2

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_4 = 23 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 23)

				if (23 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 23)) > 0 and var_512_0 < var_512_4 then
					arg_509_1.talkMaxDuration = var_512_4

					if var_512_4 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_4 + 0
					end
				end

				arg_509_1.text_.text = var_512_2
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151116", "story_v_out_324151.awb") ~= 0 then
					local var_512_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151116", "story_v_out_324151.awb") / 1000

					if var_512_5 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + 0
					end

					if var_512_1.prefab_name ~= "" and arg_509_1.actors_[var_512_1.prefab_name] ~= nil then
						local var_512_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_1.prefab_name].transform, "story_v_out_324151", "324151116", "story_v_out_324151.awb")

						arg_509_1:RecordAudio("324151116", var_512_6)
						arg_509_1:RecordAudio("324151116", var_512_6)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_324151", "324151116", "story_v_out_324151.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_324151", "324151116", "story_v_out_324151.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_7 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_7 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_7

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_7 and arg_509_1.time_ < 0 + var_512_7 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play324151117 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 324151117
		arg_513_1.duration_ = 1.6

		local var_513_0 = {
			zh = 1.6,
			ja = 0.999999999999
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play324151118(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["10171ui_story"]) and arg_513_1.var_.characterEffect10171ui_story == nil then
				arg_513_1.var_.characterEffect10171ui_story = arg_513_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["10171ui_story"]) then
				if arg_513_1.var_.characterEffect10171ui_story and not isNil(arg_513_1.actors_["10171ui_story"]) then
					arg_513_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["10171ui_story"]) and arg_513_1.var_.characterEffect10171ui_story then
				arg_513_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_516_2 = arg_513_1.actors_["1072ui_story"]

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(var_516_2) and arg_513_1.var_.characterEffect1072ui_story == nil then
				arg_513_1.var_.characterEffect1072ui_story = var_516_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_3 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_3 and not isNil(var_516_2) then
				if arg_513_1.var_.characterEffect1072ui_story and not isNil(var_516_2) then
					arg_513_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_513_1.time_ - 0) / var_516_3)
				end
			end

			if arg_513_1.time_ >= 0 + var_516_3 and arg_513_1.time_ < 0 + var_516_3 + arg_516_0 and not isNil(var_516_2) and arg_513_1.var_.characterEffect1072ui_story then
				arg_513_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_516_4 = 0
			local var_516_5 = 0.1

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_4 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_6 = arg_513_1:GetWordFromCfg(324151117)
				local var_516_7 = arg_513_1:FormatText(var_516_6.content)

				arg_513_1.text_.text = var_516_7

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_9 = 4 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 4)

				if (4 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 4)) > 0 and var_516_5 < var_516_9 then
					arg_513_1.talkMaxDuration = var_516_9

					if var_516_9 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_9 + var_516_4
					end
				end

				arg_513_1.text_.text = var_516_7
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151117", "story_v_out_324151.awb") ~= 0 then
					local var_516_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151117", "story_v_out_324151.awb") / 1000

					if var_516_10 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_10 + var_516_4
					end

					if var_516_6.prefab_name ~= "" and arg_513_1.actors_[var_516_6.prefab_name] ~= nil then
						local var_516_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_6.prefab_name].transform, "story_v_out_324151", "324151117", "story_v_out_324151.awb")

						arg_513_1:RecordAudio("324151117", var_516_11)
						arg_513_1:RecordAudio("324151117", var_516_11)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_324151", "324151117", "story_v_out_324151.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_324151", "324151117", "story_v_out_324151.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_12 = math.max(var_516_5, arg_513_1.talkMaxDuration)

			if var_516_4 <= arg_513_1.time_ and arg_513_1.time_ < var_516_4 + var_516_12 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_4) / var_516_12

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_4 + var_516_12 and arg_513_1.time_ < var_516_4 + var_516_12 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play324151118 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 324151118
		arg_517_1.duration_ = 11.83

		local var_517_0 = {
			zh = 8.966,
			ja = 11.833
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play324151119(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(arg_517_1.actors_["1072ui_story"]) and arg_517_1.var_.characterEffect1072ui_story == nil then
				arg_517_1.var_.characterEffect1072ui_story = arg_517_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_0 = 0.200000002980232

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 and not isNil(arg_517_1.actors_["1072ui_story"]) then
				if arg_517_1.var_.characterEffect1072ui_story and not isNil(arg_517_1.actors_["1072ui_story"]) then
					arg_517_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 and not isNil(arg_517_1.actors_["1072ui_story"]) and arg_517_1.var_.characterEffect1072ui_story then
				arg_517_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_520_2 = arg_517_1.actors_["10171ui_story"]

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(var_520_2) and arg_517_1.var_.characterEffect10171ui_story == nil then
				arg_517_1.var_.characterEffect10171ui_story = var_520_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_3 = 0.200000002980232

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_3 and not isNil(var_520_2) then
				if arg_517_1.var_.characterEffect10171ui_story and not isNil(var_520_2) then
					arg_517_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_517_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_517_1.time_ - 0) / var_520_3)
				end
			end

			if arg_517_1.time_ >= 0 + var_520_3 and arg_517_1.time_ < 0 + var_520_3 + arg_520_0 and not isNil(var_520_2) and arg_517_1.var_.characterEffect10171ui_story then
				arg_517_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_517_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_520_4 = 0
			local var_520_5 = 1.1

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_4 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_6 = arg_517_1:GetWordFromCfg(324151118)
				local var_520_7 = arg_517_1:FormatText(var_520_6.content)

				arg_517_1.text_.text = var_520_7

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_9 = 44 <= 0 and var_520_5 or var_520_5 * (utf8.len(var_520_7) / 44)

				if (44 <= 0 and var_520_5 or var_520_5 * (utf8.len(var_520_7) / 44)) > 0 and var_520_5 < var_520_9 then
					arg_517_1.talkMaxDuration = var_520_9

					if var_520_9 + var_520_4 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_9 + var_520_4
					end
				end

				arg_517_1.text_.text = var_520_7
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151118", "story_v_out_324151.awb") ~= 0 then
					local var_520_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151118", "story_v_out_324151.awb") / 1000

					if var_520_10 + var_520_4 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_10 + var_520_4
					end

					if var_520_6.prefab_name ~= "" and arg_517_1.actors_[var_520_6.prefab_name] ~= nil then
						local var_520_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_6.prefab_name].transform, "story_v_out_324151", "324151118", "story_v_out_324151.awb")

						arg_517_1:RecordAudio("324151118", var_520_11)
						arg_517_1:RecordAudio("324151118", var_520_11)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_324151", "324151118", "story_v_out_324151.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_324151", "324151118", "story_v_out_324151.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_12 = math.max(var_520_5, arg_517_1.talkMaxDuration)

			if var_520_4 <= arg_517_1.time_ and arg_517_1.time_ < var_520_4 + var_520_12 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_4) / var_520_12

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_4 + var_520_12 and arg_517_1.time_ < var_520_4 + var_520_12 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play324151119 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 324151119
		arg_521_1.duration_ = 2.53

		local var_521_0 = {
			zh = 2.366,
			ja = 2.533
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play324151120(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["10171ui_story"]) and arg_521_1.var_.characterEffect10171ui_story == nil then
				arg_521_1.var_.characterEffect10171ui_story = arg_521_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["10171ui_story"]) then
				if arg_521_1.var_.characterEffect10171ui_story and not isNil(arg_521_1.actors_["10171ui_story"]) then
					arg_521_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["10171ui_story"]) and arg_521_1.var_.characterEffect10171ui_story then
				arg_521_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_524_2 = arg_521_1.actors_["1072ui_story"]

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(var_524_2) and arg_521_1.var_.characterEffect1072ui_story == nil then
				arg_521_1.var_.characterEffect1072ui_story = var_524_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_3 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_3 and not isNil(var_524_2) then
				if arg_521_1.var_.characterEffect1072ui_story and not isNil(var_524_2) then
					arg_521_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_521_1.time_ - 0) / var_524_3)
				end
			end

			if arg_521_1.time_ >= 0 + var_524_3 and arg_521_1.time_ < 0 + var_524_3 + arg_524_0 and not isNil(var_524_2) and arg_521_1.var_.characterEffect1072ui_story then
				arg_521_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_1")
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_524_4 = 0
			local var_524_5 = 0.15

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_6 = arg_521_1:GetWordFromCfg(324151119)
				local var_524_7 = arg_521_1:FormatText(var_524_6.content)

				arg_521_1.text_.text = var_524_7

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_9 = 6 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 6)

				if (6 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 6)) > 0 and var_524_5 < var_524_9 then
					arg_521_1.talkMaxDuration = var_524_9

					if var_524_9 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_9 + var_524_4
					end
				end

				arg_521_1.text_.text = var_524_7
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151119", "story_v_out_324151.awb") ~= 0 then
					local var_524_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151119", "story_v_out_324151.awb") / 1000

					if var_524_10 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_10 + var_524_4
					end

					if var_524_6.prefab_name ~= "" and arg_521_1.actors_[var_524_6.prefab_name] ~= nil then
						local var_524_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_6.prefab_name].transform, "story_v_out_324151", "324151119", "story_v_out_324151.awb")

						arg_521_1:RecordAudio("324151119", var_524_11)
						arg_521_1:RecordAudio("324151119", var_524_11)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_324151", "324151119", "story_v_out_324151.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_324151", "324151119", "story_v_out_324151.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_12 = math.max(var_524_5, arg_521_1.talkMaxDuration)

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_12 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_4) / var_524_12

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_4 + var_524_12 and arg_521_1.time_ < var_524_4 + var_524_12 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play324151120 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 324151120
		arg_525_1.duration_ = 10.23

		local var_525_0 = {
			zh = 8,
			ja = 10.233
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play324151121(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPos10171ui_story = arg_525_1.actors_["10171ui_story"].transform.localPosition

				local var_528_0 = GameObjectTools.GetOrAddComponent(arg_525_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_528_0 then
					var_528_0:EnableDynamicBone(false)
				end
			end

			local var_528_1 = 0.001

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_1 then
				arg_525_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_525_1.time_ - 0) / var_528_1)
				arg_525_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_525_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["10171ui_story"].transform.position).z)
				arg_525_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_525_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_525_1.actors_["10171ui_story"].transform.localEulerAngles = arg_525_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_525_1.time_ >= 0 + var_528_1 and arg_525_1.time_ < 0 + var_528_1 + arg_528_0 then
				arg_525_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_525_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_525_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["10171ui_story"].transform.position).z)
				arg_525_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_525_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_525_1.actors_["10171ui_story"].transform.localEulerAngles = arg_525_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_528_2 = GameObjectTools.GetOrAddComponent(arg_525_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_528_2 then
					var_528_2:EnableDynamicBone(true)
				end
			end

			local var_528_3 = arg_525_1.actors_["1074ui_story"].transform

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPos1074ui_story = var_528_3.localPosition
			end

			local var_528_4 = 0.001

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_4 then
				var_528_3.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_525_1.time_ - 0) / var_528_4)
				var_528_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_528_3.position).x, (manager.ui.mainCamera.transform.position - var_528_3.position).y, (manager.ui.mainCamera.transform.position - var_528_3.position).z)
				var_528_3.localEulerAngles.z = 0
				var_528_3.localEulerAngles.x = 0
				var_528_3.localEulerAngles = var_528_3.localEulerAngles
			end

			if arg_525_1.time_ >= 0 + var_528_4 and arg_525_1.time_ < 0 + var_528_4 + arg_528_0 then
				var_528_3.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				var_528_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_528_3.position).x, (manager.ui.mainCamera.transform.position - var_528_3.position).y, (manager.ui.mainCamera.transform.position - var_528_3.position).z)
				var_528_3.localEulerAngles.z = 0
				var_528_3.localEulerAngles.x = 0
				var_528_3.localEulerAngles = var_528_3.localEulerAngles
			end

			local var_528_5 = arg_525_1.actors_["1074ui_story"]

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(var_528_5) and arg_525_1.var_.characterEffect1074ui_story == nil then
				arg_525_1.var_.characterEffect1074ui_story = var_528_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_6 = 0.200000002980232

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_6 and not isNil(var_528_5) then
				if arg_525_1.var_.characterEffect1074ui_story and not isNil(var_528_5) then
					arg_525_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= 0 + var_528_6 and arg_525_1.time_ < 0 + var_528_6 + arg_528_0 and not isNil(var_528_5) and arg_525_1.var_.characterEffect1074ui_story then
				arg_525_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_528_8 = arg_525_1.actors_["10171ui_story"]

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(var_528_8) and arg_525_1.var_.characterEffect10171ui_story == nil then
				arg_525_1.var_.characterEffect10171ui_story = var_528_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_9 = 0.200000002980232

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_9 and not isNil(var_528_8) then
				if arg_525_1.var_.characterEffect10171ui_story and not isNil(var_528_8) then
					arg_525_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_525_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_525_1.time_ - 0) / var_528_9)
				end
			end

			if arg_525_1.time_ >= 0 + var_528_9 and arg_525_1.time_ < 0 + var_528_9 + arg_528_0 and not isNil(var_528_8) and arg_525_1.var_.characterEffect10171ui_story then
				arg_525_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_525_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074actionlink/1074action426")
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_528_10 = 0
			local var_528_11 = 0.975

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_10 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_12 = arg_525_1:GetWordFromCfg(324151120)
				local var_528_13 = arg_525_1:FormatText(var_528_12.content)

				arg_525_1.text_.text = var_528_13

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_15 = 39 <= 0 and var_528_11 or var_528_11 * (utf8.len(var_528_13) / 39)

				if (39 <= 0 and var_528_11 or var_528_11 * (utf8.len(var_528_13) / 39)) > 0 and var_528_11 < var_528_15 then
					arg_525_1.talkMaxDuration = var_528_15

					if var_528_15 + var_528_10 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_15 + var_528_10
					end
				end

				arg_525_1.text_.text = var_528_13
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151120", "story_v_out_324151.awb") ~= 0 then
					local var_528_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151120", "story_v_out_324151.awb") / 1000

					if var_528_16 + var_528_10 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_16 + var_528_10
					end

					if var_528_12.prefab_name ~= "" and arg_525_1.actors_[var_528_12.prefab_name] ~= nil then
						local var_528_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_12.prefab_name].transform, "story_v_out_324151", "324151120", "story_v_out_324151.awb")

						arg_525_1:RecordAudio("324151120", var_528_17)
						arg_525_1:RecordAudio("324151120", var_528_17)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_324151", "324151120", "story_v_out_324151.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_324151", "324151120", "story_v_out_324151.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_18 = math.max(var_528_11, arg_525_1.talkMaxDuration)

			if var_528_10 <= arg_525_1.time_ and arg_525_1.time_ < var_528_10 + var_528_18 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_10) / var_528_18

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_10 + var_528_18 and arg_525_1.time_ < var_528_10 + var_528_18 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play324151121 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 324151121
		arg_529_1.duration_ = 6.23

		local var_529_0 = {
			zh = 4.966,
			ja = 6.233
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play324151122(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["1072ui_story"]) and arg_529_1.var_.characterEffect1072ui_story == nil then
				arg_529_1.var_.characterEffect1072ui_story = arg_529_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_0 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["1072ui_story"]) then
				if arg_529_1.var_.characterEffect1072ui_story and not isNil(arg_529_1.actors_["1072ui_story"]) then
					arg_529_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["1072ui_story"]) and arg_529_1.var_.characterEffect1072ui_story then
				arg_529_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_532_2 = arg_529_1.actors_["1074ui_story"]

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(var_532_2) and arg_529_1.var_.characterEffect1074ui_story == nil then
				arg_529_1.var_.characterEffect1074ui_story = var_532_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_3 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_3 and not isNil(var_532_2) then
				if arg_529_1.var_.characterEffect1074ui_story and not isNil(var_532_2) then
					arg_529_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_529_1.time_ - 0) / var_532_3)
				end
			end

			if arg_529_1.time_ >= 0 + var_532_3 and arg_529_1.time_ < 0 + var_532_3 + arg_532_0 and not isNil(var_532_2) and arg_529_1.var_.characterEffect1074ui_story then
				arg_529_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_532_4 = 0
			local var_532_5 = 0.425

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_4 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_6 = arg_529_1:GetWordFromCfg(324151121)
				local var_532_7 = arg_529_1:FormatText(var_532_6.content)

				arg_529_1.text_.text = var_532_7

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_9 = 17 <= 0 and var_532_5 or var_532_5 * (utf8.len(var_532_7) / 17)

				if (17 <= 0 and var_532_5 or var_532_5 * (utf8.len(var_532_7) / 17)) > 0 and var_532_5 < var_532_9 then
					arg_529_1.talkMaxDuration = var_532_9

					if var_532_9 + var_532_4 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_9 + var_532_4
					end
				end

				arg_529_1.text_.text = var_532_7
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151121", "story_v_out_324151.awb") ~= 0 then
					local var_532_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151121", "story_v_out_324151.awb") / 1000

					if var_532_10 + var_532_4 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_10 + var_532_4
					end

					if var_532_6.prefab_name ~= "" and arg_529_1.actors_[var_532_6.prefab_name] ~= nil then
						local var_532_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_6.prefab_name].transform, "story_v_out_324151", "324151121", "story_v_out_324151.awb")

						arg_529_1:RecordAudio("324151121", var_532_11)
						arg_529_1:RecordAudio("324151121", var_532_11)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_324151", "324151121", "story_v_out_324151.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_324151", "324151121", "story_v_out_324151.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_12 = math.max(var_532_5, arg_529_1.talkMaxDuration)

			if var_532_4 <= arg_529_1.time_ and arg_529_1.time_ < var_532_4 + var_532_12 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_4) / var_532_12

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_4 + var_532_12 and arg_529_1.time_ < var_532_4 + var_532_12 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play324151122 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 324151122
		arg_533_1.duration_ = 5.2

		local var_533_0 = {
			zh = 4.466,
			ja = 5.2
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play324151123(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(arg_533_1.actors_["1074ui_story"]) and arg_533_1.var_.characterEffect1074ui_story == nil then
				arg_533_1.var_.characterEffect1074ui_story = arg_533_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_0 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 and not isNil(arg_533_1.actors_["1074ui_story"]) then
				if arg_533_1.var_.characterEffect1074ui_story and not isNil(arg_533_1.actors_["1074ui_story"]) then
					arg_533_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 and not isNil(arg_533_1.actors_["1074ui_story"]) and arg_533_1.var_.characterEffect1074ui_story then
				arg_533_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_536_2 = arg_533_1.actors_["1072ui_story"]

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(var_536_2) and arg_533_1.var_.characterEffect1072ui_story == nil then
				arg_533_1.var_.characterEffect1072ui_story = var_536_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_3 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_3 and not isNil(var_536_2) then
				if arg_533_1.var_.characterEffect1072ui_story and not isNil(var_536_2) then
					arg_533_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_533_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_533_1.time_ - 0) / var_536_3)
				end
			end

			if arg_533_1.time_ >= 0 + var_536_3 and arg_533_1.time_ < 0 + var_536_3 + arg_536_0 and not isNil(var_536_2) and arg_533_1.var_.characterEffect1072ui_story then
				arg_533_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_533_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_536_4 = 0
			local var_536_5 = 0.55

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_4 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_6 = arg_533_1:GetWordFromCfg(324151122)
				local var_536_7 = arg_533_1:FormatText(var_536_6.content)

				arg_533_1.text_.text = var_536_7

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_9 = 22 <= 0 and var_536_5 or var_536_5 * (utf8.len(var_536_7) / 22)

				if (22 <= 0 and var_536_5 or var_536_5 * (utf8.len(var_536_7) / 22)) > 0 and var_536_5 < var_536_9 then
					arg_533_1.talkMaxDuration = var_536_9

					if var_536_9 + var_536_4 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_9 + var_536_4
					end
				end

				arg_533_1.text_.text = var_536_7
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151122", "story_v_out_324151.awb") ~= 0 then
					local var_536_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151122", "story_v_out_324151.awb") / 1000

					if var_536_10 + var_536_4 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_10 + var_536_4
					end

					if var_536_6.prefab_name ~= "" and arg_533_1.actors_[var_536_6.prefab_name] ~= nil then
						local var_536_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_6.prefab_name].transform, "story_v_out_324151", "324151122", "story_v_out_324151.awb")

						arg_533_1:RecordAudio("324151122", var_536_11)
						arg_533_1:RecordAudio("324151122", var_536_11)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_324151", "324151122", "story_v_out_324151.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_324151", "324151122", "story_v_out_324151.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_12 = math.max(var_536_5, arg_533_1.talkMaxDuration)

			if var_536_4 <= arg_533_1.time_ and arg_533_1.time_ < var_536_4 + var_536_12 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_4) / var_536_12

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_4 + var_536_12 and arg_533_1.time_ < var_536_4 + var_536_12 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play324151123 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 324151123
		arg_537_1.duration_ = 17.2

		local var_537_0 = {
			zh = 13.3,
			ja = 17.2
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play324151124(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_2")
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_540_0 = 0
			local var_540_1 = 1.475

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_2 = arg_537_1:GetWordFromCfg(324151123)
				local var_540_3 = arg_537_1:FormatText(var_540_2.content)

				arg_537_1.text_.text = var_540_3

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_5 = 59 <= 0 and var_540_1 or var_540_1 * (utf8.len(var_540_3) / 59)

				if (59 <= 0 and var_540_1 or var_540_1 * (utf8.len(var_540_3) / 59)) > 0 and var_540_1 < var_540_5 then
					arg_537_1.talkMaxDuration = var_540_5

					if var_540_5 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_5 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_3
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151123", "story_v_out_324151.awb") ~= 0 then
					local var_540_6 = manager.audio:GetVoiceLength("story_v_out_324151", "324151123", "story_v_out_324151.awb") / 1000

					if var_540_6 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_6 + var_540_0
					end

					if var_540_2.prefab_name ~= "" and arg_537_1.actors_[var_540_2.prefab_name] ~= nil then
						local var_540_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_2.prefab_name].transform, "story_v_out_324151", "324151123", "story_v_out_324151.awb")

						arg_537_1:RecordAudio("324151123", var_540_7)
						arg_537_1:RecordAudio("324151123", var_540_7)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_324151", "324151123", "story_v_out_324151.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_324151", "324151123", "story_v_out_324151.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_8 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_8 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_8

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_8 and arg_537_1.time_ < var_540_0 + var_540_8 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play324151124 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 324151124
		arg_541_1.duration_ = 6.3

		local var_541_0 = {
			zh = 3.433,
			ja = 6.3
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play324151125(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.45

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_1 = arg_541_1:GetWordFromCfg(324151124)
				local var_544_2 = arg_541_1:FormatText(var_544_1.content)

				arg_541_1.text_.text = var_544_2

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_4 = 18 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 18)

				if (18 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 18)) > 0 and var_544_0 < var_544_4 then
					arg_541_1.talkMaxDuration = var_544_4

					if var_544_4 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_4 + 0
					end
				end

				arg_541_1.text_.text = var_544_2
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151124", "story_v_out_324151.awb") ~= 0 then
					local var_544_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151124", "story_v_out_324151.awb") / 1000

					if var_544_5 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + 0
					end

					if var_544_1.prefab_name ~= "" and arg_541_1.actors_[var_544_1.prefab_name] ~= nil then
						local var_544_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_1.prefab_name].transform, "story_v_out_324151", "324151124", "story_v_out_324151.awb")

						arg_541_1:RecordAudio("324151124", var_544_6)
						arg_541_1:RecordAudio("324151124", var_544_6)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_324151", "324151124", "story_v_out_324151.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_324151", "324151124", "story_v_out_324151.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_7 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_7

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play324151125 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 324151125
		arg_545_1.duration_ = 10.6

		local var_545_0 = {
			zh = 8.2,
			ja = 10.6
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play324151126(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos10171ui_story = arg_545_1.actors_["10171ui_story"].transform.localPosition

				local var_548_0 = GameObjectTools.GetOrAddComponent(arg_545_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_548_0 then
					var_548_0:EnableDynamicBone(false)
				end
			end

			local var_548_1 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_1 then
				arg_545_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos10171ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_545_1.time_ - 0) / var_548_1)
				arg_545_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["10171ui_story"].transform.position).z)
				arg_545_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["10171ui_story"].transform.localEulerAngles = arg_545_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_545_1.time_ >= 0 + var_548_1 and arg_545_1.time_ < 0 + var_548_1 + arg_548_0 then
				arg_545_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_545_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["10171ui_story"].transform.position).z)
				arg_545_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["10171ui_story"].transform.localEulerAngles = arg_545_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_548_2 = GameObjectTools.GetOrAddComponent(arg_545_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_548_2 then
					var_548_2:EnableDynamicBone(true)
				end
			end

			local var_548_3 = arg_545_1.actors_["1072ui_story"].transform

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos1072ui_story = var_548_3.localPosition
			end

			local var_548_4 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_4 then
				var_548_3.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_545_1.time_ - 0) / var_548_4)
				var_548_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_548_3.position).x, (manager.ui.mainCamera.transform.position - var_548_3.position).y, (manager.ui.mainCamera.transform.position - var_548_3.position).z)
				var_548_3.localEulerAngles.z = 0
				var_548_3.localEulerAngles.x = 0
				var_548_3.localEulerAngles = var_548_3.localEulerAngles
			end

			if arg_545_1.time_ >= 0 + var_548_4 and arg_545_1.time_ < 0 + var_548_4 + arg_548_0 then
				var_548_3.localPosition = Vector3.New(0, 100, 0)
				var_548_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_548_3.position).x, (manager.ui.mainCamera.transform.position - var_548_3.position).y, (manager.ui.mainCamera.transform.position - var_548_3.position).z)
				var_548_3.localEulerAngles.z = 0
				var_548_3.localEulerAngles.x = 0
				var_548_3.localEulerAngles = var_548_3.localEulerAngles
			end

			local var_548_5 = arg_545_1.actors_["10171ui_story"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_5) and arg_545_1.var_.characterEffect10171ui_story == nil then
				arg_545_1.var_.characterEffect10171ui_story = var_548_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_6 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_6 and not isNil(var_548_5) then
				if arg_545_1.var_.characterEffect10171ui_story and not isNil(var_548_5) then
					arg_545_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= 0 + var_548_6 and arg_545_1.time_ < 0 + var_548_6 + arg_548_0 and not isNil(var_548_5) and arg_545_1.var_.characterEffect10171ui_story then
				arg_545_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_548_8 = arg_545_1.actors_["1074ui_story"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_8) and arg_545_1.var_.characterEffect1074ui_story == nil then
				arg_545_1.var_.characterEffect1074ui_story = var_548_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_9 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_9 and not isNil(var_548_8) then
				if arg_545_1.var_.characterEffect1074ui_story and not isNil(var_548_8) then
					arg_545_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_545_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_545_1.time_ - 0) / var_548_9)
				end
			end

			if arg_545_1.time_ >= 0 + var_548_9 and arg_545_1.time_ < 0 + var_548_9 + arg_548_0 and not isNil(var_548_8) and arg_545_1.var_.characterEffect1074ui_story then
				arg_545_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_545_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_2")
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_548_10 = 0
			local var_548_11 = 1.025

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_10 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_12 = arg_545_1:GetWordFromCfg(324151125)
				local var_548_13 = arg_545_1:FormatText(var_548_12.content)

				arg_545_1.text_.text = var_548_13

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_15 = 41 <= 0 and var_548_11 or var_548_11 * (utf8.len(var_548_13) / 41)

				if (41 <= 0 and var_548_11 or var_548_11 * (utf8.len(var_548_13) / 41)) > 0 and var_548_11 < var_548_15 then
					arg_545_1.talkMaxDuration = var_548_15

					if var_548_15 + var_548_10 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_15 + var_548_10
					end
				end

				arg_545_1.text_.text = var_548_13
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151125", "story_v_out_324151.awb") ~= 0 then
					local var_548_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151125", "story_v_out_324151.awb") / 1000

					if var_548_16 + var_548_10 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_16 + var_548_10
					end

					if var_548_12.prefab_name ~= "" and arg_545_1.actors_[var_548_12.prefab_name] ~= nil then
						local var_548_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_12.prefab_name].transform, "story_v_out_324151", "324151125", "story_v_out_324151.awb")

						arg_545_1:RecordAudio("324151125", var_548_17)
						arg_545_1:RecordAudio("324151125", var_548_17)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_324151", "324151125", "story_v_out_324151.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_324151", "324151125", "story_v_out_324151.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_18 = math.max(var_548_11, arg_545_1.talkMaxDuration)

			if var_548_10 <= arg_545_1.time_ and arg_545_1.time_ < var_548_10 + var_548_18 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_10) / var_548_18

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_10 + var_548_18 and arg_545_1.time_ < var_548_10 + var_548_18 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play324151126 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 324151126
		arg_549_1.duration_ = 10.83

		local var_549_0 = {
			zh = 8.133,
			ja = 10.833
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play324151127(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.var_.moveOldPos1060ui_story = arg_549_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_552_0 = 0.001

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 then
				arg_549_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1060ui_story, Vector3.New(-0.7, -1.14, -6.33), (arg_549_1.time_ - 0) / var_552_0)
				arg_549_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_549_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1060ui_story"].transform.position).z)
				arg_549_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_549_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_549_1.actors_["1060ui_story"].transform.localEulerAngles = arg_549_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 then
				arg_549_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(-0.7, -1.14, -6.33)
				arg_549_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_549_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1060ui_story"].transform.position).z)
				arg_549_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_549_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_549_1.actors_["1060ui_story"].transform.localEulerAngles = arg_549_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_552_1 = arg_549_1.actors_["1074ui_story"].transform

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.var_.moveOldPos1074ui_story = var_552_1.localPosition
			end

			local var_552_2 = 0.001

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_2 then
				var_552_1.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_549_1.time_ - 0) / var_552_2)
				var_552_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_552_1.position).x, (manager.ui.mainCamera.transform.position - var_552_1.position).y, (manager.ui.mainCamera.transform.position - var_552_1.position).z)
				var_552_1.localEulerAngles.z = 0
				var_552_1.localEulerAngles.x = 0
				var_552_1.localEulerAngles = var_552_1.localEulerAngles
			end

			if arg_549_1.time_ >= 0 + var_552_2 and arg_549_1.time_ < 0 + var_552_2 + arg_552_0 then
				var_552_1.localPosition = Vector3.New(0, 100, 0)
				var_552_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_552_1.position).x, (manager.ui.mainCamera.transform.position - var_552_1.position).y, (manager.ui.mainCamera.transform.position - var_552_1.position).z)
				var_552_1.localEulerAngles.z = 0
				var_552_1.localEulerAngles.x = 0
				var_552_1.localEulerAngles = var_552_1.localEulerAngles
			end

			local var_552_3 = arg_549_1.actors_["1060ui_story"]

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(var_552_3) and arg_549_1.var_.characterEffect1060ui_story == nil then
				arg_549_1.var_.characterEffect1060ui_story = var_552_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_4 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_4 and not isNil(var_552_3) then
				if arg_549_1.var_.characterEffect1060ui_story and not isNil(var_552_3) then
					arg_549_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= 0 + var_552_4 and arg_549_1.time_ < 0 + var_552_4 + arg_552_0 and not isNil(var_552_3) and arg_549_1.var_.characterEffect1060ui_story then
				arg_549_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_552_6 = arg_549_1.actors_["10171ui_story"]

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(var_552_6) and arg_549_1.var_.characterEffect10171ui_story == nil then
				arg_549_1.var_.characterEffect10171ui_story = var_552_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_7 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_7 and not isNil(var_552_6) then
				if arg_549_1.var_.characterEffect10171ui_story and not isNil(var_552_6) then
					arg_549_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_549_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_549_1.time_ - 0) / var_552_7)
				end
			end

			if arg_549_1.time_ >= 0 + var_552_7 and arg_549_1.time_ < 0 + var_552_7 + arg_552_0 and not isNil(var_552_6) and arg_549_1.var_.characterEffect10171ui_story then
				arg_549_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_549_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action5_2")
			end

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_552_8 = 0
			local var_552_9 = 1.025

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_8 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_10 = arg_549_1:GetWordFromCfg(324151126)
				local var_552_11 = arg_549_1:FormatText(var_552_10.content)

				arg_549_1.text_.text = var_552_11

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_13 = 41 <= 0 and var_552_9 or var_552_9 * (utf8.len(var_552_11) / 41)

				if (41 <= 0 and var_552_9 or var_552_9 * (utf8.len(var_552_11) / 41)) > 0 and var_552_9 < var_552_13 then
					arg_549_1.talkMaxDuration = var_552_13

					if var_552_13 + var_552_8 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_13 + var_552_8
					end
				end

				arg_549_1.text_.text = var_552_11
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151126", "story_v_out_324151.awb") ~= 0 then
					local var_552_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151126", "story_v_out_324151.awb") / 1000

					if var_552_14 + var_552_8 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_14 + var_552_8
					end

					if var_552_10.prefab_name ~= "" and arg_549_1.actors_[var_552_10.prefab_name] ~= nil then
						local var_552_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_10.prefab_name].transform, "story_v_out_324151", "324151126", "story_v_out_324151.awb")

						arg_549_1:RecordAudio("324151126", var_552_15)
						arg_549_1:RecordAudio("324151126", var_552_15)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_324151", "324151126", "story_v_out_324151.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_324151", "324151126", "story_v_out_324151.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_16 = math.max(var_552_9, arg_549_1.talkMaxDuration)

			if var_552_8 <= arg_549_1.time_ and arg_549_1.time_ < var_552_8 + var_552_16 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_8) / var_552_16

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_8 + var_552_16 and arg_549_1.time_ < var_552_8 + var_552_16 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_549_1:InitPlayNodeList()
	end,
	Play324151127 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 324151127
		arg_553_1.duration_ = 3.5

		local var_553_0 = {
			zh = 3.1,
			ja = 3.5
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play324151128(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["1074ui_story"]) and arg_553_1.var_.characterEffect1074ui_story == nil then
				arg_553_1.var_.characterEffect1074ui_story = arg_553_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_0 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["1074ui_story"]) then
				if arg_553_1.var_.characterEffect1074ui_story and not isNil(arg_553_1.actors_["1074ui_story"]) then
					arg_553_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["1074ui_story"]) and arg_553_1.var_.characterEffect1074ui_story then
				arg_553_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_556_2 = arg_553_1.actors_["1060ui_story"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_2) and arg_553_1.var_.characterEffect1060ui_story == nil then
				arg_553_1.var_.characterEffect1060ui_story = var_556_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_3 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_3 and not isNil(var_556_2) then
				if arg_553_1.var_.characterEffect1060ui_story and not isNil(var_556_2) then
					arg_553_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_553_1.time_ - 0) / var_556_3)
				end
			end

			if arg_553_1.time_ >= 0 + var_556_3 and arg_553_1.time_ < 0 + var_556_3 + arg_556_0 and not isNil(var_556_2) and arg_553_1.var_.characterEffect1060ui_story then
				arg_553_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_556_4 = 0
			local var_556_5 = 0.4

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_4 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_6 = arg_553_1:GetWordFromCfg(324151127)
				local var_556_7 = arg_553_1:FormatText(var_556_6.content)

				arg_553_1.text_.text = var_556_7

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_9 = 16 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 16)

				if (16 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 16)) > 0 and var_556_5 < var_556_9 then
					arg_553_1.talkMaxDuration = var_556_9

					if var_556_9 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_9 + var_556_4
					end
				end

				arg_553_1.text_.text = var_556_7
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151127", "story_v_out_324151.awb") ~= 0 then
					local var_556_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151127", "story_v_out_324151.awb") / 1000

					if var_556_10 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_4
					end

					if var_556_6.prefab_name ~= "" and arg_553_1.actors_[var_556_6.prefab_name] ~= nil then
						local var_556_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_6.prefab_name].transform, "story_v_out_324151", "324151127", "story_v_out_324151.awb")

						arg_553_1:RecordAudio("324151127", var_556_11)
						arg_553_1:RecordAudio("324151127", var_556_11)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_324151", "324151127", "story_v_out_324151.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_324151", "324151127", "story_v_out_324151.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_12 = math.max(var_556_5, arg_553_1.talkMaxDuration)

			if var_556_4 <= arg_553_1.time_ and arg_553_1.time_ < var_556_4 + var_556_12 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_4) / var_556_12

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_4 + var_556_12 and arg_553_1.time_ < var_556_4 + var_556_12 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play324151128 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 324151128
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play324151129(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos1060ui_story = arg_557_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_560_0 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 then
				arg_557_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_557_1.time_ - 0) / var_560_0)
				arg_557_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_557_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["1060ui_story"].transform.position).z)
				arg_557_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_557_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_557_1.actors_["1060ui_story"].transform.localEulerAngles = arg_557_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 then
				arg_557_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_557_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_557_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["1060ui_story"].transform.position).z)
				arg_557_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_557_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_557_1.actors_["1060ui_story"].transform.localEulerAngles = arg_557_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_560_1 = arg_557_1.actors_["10171ui_story"].transform

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos10171ui_story = var_560_1.localPosition

				local var_560_2 = GameObjectTools.GetOrAddComponent(var_560_1.gameObject, typeof(DynamicBoneHelper))

				if var_560_2 then
					var_560_2:EnableDynamicBone(false)
				end
			end

			local var_560_3 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_3 then
				var_560_1.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_557_1.time_ - 0) / var_560_3)
				var_560_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_560_1.position).x, (manager.ui.mainCamera.transform.position - var_560_1.position).y, (manager.ui.mainCamera.transform.position - var_560_1.position).z)
				var_560_1.localEulerAngles.z = 0
				var_560_1.localEulerAngles.x = 0
				var_560_1.localEulerAngles = var_560_1.localEulerAngles
			end

			if arg_557_1.time_ >= 0 + var_560_3 and arg_557_1.time_ < 0 + var_560_3 + arg_560_0 then
				var_560_1.localPosition = Vector3.New(0, 100, 0)
				var_560_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_560_1.position).x, (manager.ui.mainCamera.transform.position - var_560_1.position).y, (manager.ui.mainCamera.transform.position - var_560_1.position).z)
				var_560_1.localEulerAngles.z = 0
				var_560_1.localEulerAngles.x = 0
				var_560_1.localEulerAngles = var_560_1.localEulerAngles

				local var_560_4 = GameObjectTools.GetOrAddComponent(var_560_1.gameObject, typeof(DynamicBoneHelper))

				if var_560_4 then
					var_560_4:EnableDynamicBone(true)
				end
			end

			local var_560_5 = arg_557_1.actors_["1074ui_story"]

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(var_560_5) and arg_557_1.var_.characterEffect1074ui_story == nil then
				arg_557_1.var_.characterEffect1074ui_story = var_560_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_6 = 0.200000002980232

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_6 and not isNil(var_560_5) then
				if arg_557_1.var_.characterEffect1074ui_story and not isNil(var_560_5) then
					arg_557_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_557_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_557_1.time_ - 0) / var_560_6)
				end
			end

			if arg_557_1.time_ >= 0 + var_560_6 and arg_557_1.time_ < 0 + var_560_6 + arg_560_0 and not isNil(var_560_5) and arg_557_1.var_.characterEffect1074ui_story then
				arg_557_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_557_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0.9 < arg_557_1.time_ and arg_557_1.time_ <= 0.9 + arg_560_0 then
				arg_557_1:AudioAction("play", "effect", "se_story_142", "se_story_142_chopper01", "")
			end

			local var_560_8 = 0
			local var_560_9 = 1.625

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_8 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_10 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(324151128).content)

				arg_557_1.text_.text = var_560_10

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_12 = 65 <= 0 and var_560_9 or var_560_9 * (utf8.len(var_560_10) / 65)

				if (65 <= 0 and var_560_9 or var_560_9 * (utf8.len(var_560_10) / 65)) > 0 and var_560_9 < var_560_12 then
					arg_557_1.talkMaxDuration = var_560_12

					if var_560_12 + var_560_8 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_12 + var_560_8
					end
				end

				arg_557_1.text_.text = var_560_10
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_13 = math.max(var_560_9, arg_557_1.talkMaxDuration)

			if var_560_8 <= arg_557_1.time_ and arg_557_1.time_ < var_560_8 + var_560_13 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_8) / var_560_13

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_8 + var_560_13 and arg_557_1.time_ < var_560_8 + var_560_13 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play324151129 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 324151129
		arg_561_1.duration_ = 7.9

		local var_561_0 = {
			zh = 3.233,
			ja = 7.9
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play324151130(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos10171ui_story = arg_561_1.actors_["10171ui_story"].transform.localPosition

				local var_564_0 = GameObjectTools.GetOrAddComponent(arg_561_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_564_0 then
					var_564_0:EnableDynamicBone(false)
				end
			end

			local var_564_1 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_1 then
				arg_561_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_561_1.time_ - 0) / var_564_1)
				arg_561_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["10171ui_story"].transform.position).z)
				arg_561_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["10171ui_story"].transform.localEulerAngles = arg_561_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_561_1.time_ >= 0 + var_564_1 and arg_561_1.time_ < 0 + var_564_1 + arg_564_0 then
				arg_561_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_561_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["10171ui_story"].transform.position).z)
				arg_561_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["10171ui_story"].transform.localEulerAngles = arg_561_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_564_2 = GameObjectTools.GetOrAddComponent(arg_561_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_564_2 then
					var_564_2:EnableDynamicBone(true)
				end
			end

			local var_564_3 = arg_561_1.actors_["10171ui_story"]

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(var_564_3) and arg_561_1.var_.characterEffect10171ui_story == nil then
				arg_561_1.var_.characterEffect10171ui_story = var_564_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_4 = 0.200000002980232

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_4 and not isNil(var_564_3) then
				if arg_561_1.var_.characterEffect10171ui_story and not isNil(var_564_3) then
					arg_561_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= 0 + var_564_4 and arg_561_1.time_ < 0 + var_564_4 + arg_564_0 and not isNil(var_564_3) and arg_561_1.var_.characterEffect10171ui_story then
				arg_561_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_564_6 = 0
			local var_564_7 = 0.3

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_6 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_8 = arg_561_1:GetWordFromCfg(324151129)
				local var_564_9 = arg_561_1:FormatText(var_564_8.content)

				arg_561_1.text_.text = var_564_9

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_11 = 12 <= 0 and var_564_7 or var_564_7 * (utf8.len(var_564_9) / 12)

				if (12 <= 0 and var_564_7 or var_564_7 * (utf8.len(var_564_9) / 12)) > 0 and var_564_7 < var_564_11 then
					arg_561_1.talkMaxDuration = var_564_11

					if var_564_11 + var_564_6 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_11 + var_564_6
					end
				end

				arg_561_1.text_.text = var_564_9
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151129", "story_v_out_324151.awb") ~= 0 then
					local var_564_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151129", "story_v_out_324151.awb") / 1000

					if var_564_12 + var_564_6 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_12 + var_564_6
					end

					if var_564_8.prefab_name ~= "" and arg_561_1.actors_[var_564_8.prefab_name] ~= nil then
						local var_564_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_8.prefab_name].transform, "story_v_out_324151", "324151129", "story_v_out_324151.awb")

						arg_561_1:RecordAudio("324151129", var_564_13)
						arg_561_1:RecordAudio("324151129", var_564_13)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_324151", "324151129", "story_v_out_324151.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_324151", "324151129", "story_v_out_324151.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_14 = math.max(var_564_7, arg_561_1.talkMaxDuration)

			if var_564_6 <= arg_561_1.time_ and arg_561_1.time_ < var_564_6 + var_564_14 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_6) / var_564_14

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_6 + var_564_14 and arg_561_1.time_ < var_564_6 + var_564_14 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play324151130 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 324151130
		arg_565_1.duration_ = 9.1

		local var_565_0 = {
			zh = 8.4,
			ja = 9.1
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play324151131(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 1.075

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_1 = arg_565_1:GetWordFromCfg(324151130)
				local var_568_2 = arg_565_1:FormatText(var_568_1.content)

				arg_565_1.text_.text = var_568_2

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_4 = 43 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_2) / 43)

				if (43 <= 0 and var_568_0 or var_568_0 * (utf8.len(var_568_2) / 43)) > 0 and var_568_0 < var_568_4 then
					arg_565_1.talkMaxDuration = var_568_4

					if var_568_4 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_4 + 0
					end
				end

				arg_565_1.text_.text = var_568_2
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151130", "story_v_out_324151.awb") ~= 0 then
					local var_568_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151130", "story_v_out_324151.awb") / 1000

					if var_568_5 + 0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_5 + 0
					end

					if var_568_1.prefab_name ~= "" and arg_565_1.actors_[var_568_1.prefab_name] ~= nil then
						local var_568_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_1.prefab_name].transform, "story_v_out_324151", "324151130", "story_v_out_324151.awb")

						arg_565_1:RecordAudio("324151130", var_568_6)
						arg_565_1:RecordAudio("324151130", var_568_6)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_324151", "324151130", "story_v_out_324151.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_324151", "324151130", "story_v_out_324151.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_7 = math.max(var_568_0, arg_565_1.talkMaxDuration)

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_7 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - 0) / var_568_7

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= 0 + var_568_7 and arg_565_1.time_ < 0 + var_568_7 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play324151131 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 324151131
		arg_569_1.duration_ = 4.8

		local var_569_0 = {
			zh = 4,
			ja = 4.8
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play324151132(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_572_0 = 0
			local var_572_1 = 0.5

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_2 = arg_569_1:GetWordFromCfg(324151131)
				local var_572_3 = arg_569_1:FormatText(var_572_2.content)

				arg_569_1.text_.text = var_572_3

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_5 = 20 <= 0 and var_572_1 or var_572_1 * (utf8.len(var_572_3) / 20)

				if (20 <= 0 and var_572_1 or var_572_1 * (utf8.len(var_572_3) / 20)) > 0 and var_572_1 < var_572_5 then
					arg_569_1.talkMaxDuration = var_572_5

					if var_572_5 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + var_572_0
					end
				end

				arg_569_1.text_.text = var_572_3
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151131", "story_v_out_324151.awb") ~= 0 then
					local var_572_6 = manager.audio:GetVoiceLength("story_v_out_324151", "324151131", "story_v_out_324151.awb") / 1000

					if var_572_6 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_6 + var_572_0
					end

					if var_572_2.prefab_name ~= "" and arg_569_1.actors_[var_572_2.prefab_name] ~= nil then
						local var_572_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_2.prefab_name].transform, "story_v_out_324151", "324151131", "story_v_out_324151.awb")

						arg_569_1:RecordAudio("324151131", var_572_7)
						arg_569_1:RecordAudio("324151131", var_572_7)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_out_324151", "324151131", "story_v_out_324151.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_out_324151", "324151131", "story_v_out_324151.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_8 = math.max(var_572_1, arg_569_1.talkMaxDuration)

			if var_572_0 <= arg_569_1.time_ and arg_569_1.time_ < var_572_0 + var_572_8 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_0) / var_572_8

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_0 + var_572_8 and arg_569_1.time_ < var_572_0 + var_572_8 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play324151132 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 324151132
		arg_573_1.duration_ = 2.73

		local var_573_0 = {
			zh = 2.733,
			ja = 1.566
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play324151133(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos10171ui_story = arg_573_1.actors_["10171ui_story"].transform.localPosition

				local var_576_0 = GameObjectTools.GetOrAddComponent(arg_573_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_576_0 then
					var_576_0:EnableDynamicBone(false)
				end
			end

			local var_576_1 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_1 then
				arg_573_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_573_1.time_ - 0) / var_576_1)
				arg_573_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_573_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["10171ui_story"].transform.position).z)
				arg_573_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_573_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_573_1.actors_["10171ui_story"].transform.localEulerAngles = arg_573_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_573_1.time_ >= 0 + var_576_1 and arg_573_1.time_ < 0 + var_576_1 + arg_576_0 then
				arg_573_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_573_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_573_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["10171ui_story"].transform.position).z)
				arg_573_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_573_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_573_1.actors_["10171ui_story"].transform.localEulerAngles = arg_573_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_576_2 = GameObjectTools.GetOrAddComponent(arg_573_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_576_2 then
					var_576_2:EnableDynamicBone(true)
				end
			end

			local var_576_3 = arg_573_1.actors_["1072ui_story"].transform

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos1072ui_story = var_576_3.localPosition
			end

			local var_576_4 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_4 then
				var_576_3.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_573_1.time_ - 0) / var_576_4)
				var_576_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_576_3.position).x, (manager.ui.mainCamera.transform.position - var_576_3.position).y, (manager.ui.mainCamera.transform.position - var_576_3.position).z)
				var_576_3.localEulerAngles.z = 0
				var_576_3.localEulerAngles.x = 0
				var_576_3.localEulerAngles = var_576_3.localEulerAngles
			end

			if arg_573_1.time_ >= 0 + var_576_4 and arg_573_1.time_ < 0 + var_576_4 + arg_576_0 then
				var_576_3.localPosition = Vector3.New(0.7, -0.71, -6)
				var_576_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_576_3.position).x, (manager.ui.mainCamera.transform.position - var_576_3.position).y, (manager.ui.mainCamera.transform.position - var_576_3.position).z)
				var_576_3.localEulerAngles.z = 0
				var_576_3.localEulerAngles.x = 0
				var_576_3.localEulerAngles = var_576_3.localEulerAngles
			end

			local var_576_5 = arg_573_1.actors_["1072ui_story"]

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(var_576_5) and arg_573_1.var_.characterEffect1072ui_story == nil then
				arg_573_1.var_.characterEffect1072ui_story = var_576_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_6 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_6 and not isNil(var_576_5) then
				if arg_573_1.var_.characterEffect1072ui_story and not isNil(var_576_5) then
					arg_573_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= 0 + var_576_6 and arg_573_1.time_ < 0 + var_576_6 + arg_576_0 and not isNil(var_576_5) and arg_573_1.var_.characterEffect1072ui_story then
				arg_573_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_576_8 = arg_573_1.actors_["10171ui_story"]

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(var_576_8) and arg_573_1.var_.characterEffect10171ui_story == nil then
				arg_573_1.var_.characterEffect10171ui_story = var_576_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_9 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_9 and not isNil(var_576_8) then
				if arg_573_1.var_.characterEffect10171ui_story and not isNil(var_576_8) then
					arg_573_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_573_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_573_1.time_ - 0) / var_576_9)
				end
			end

			if arg_573_1.time_ >= 0 + var_576_9 and arg_573_1.time_ < 0 + var_576_9 + arg_576_0 and not isNil(var_576_8) and arg_573_1.var_.characterEffect10171ui_story then
				arg_573_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_573_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_576_10 = 0
			local var_576_11 = 0.125

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_10 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_12 = arg_573_1:GetWordFromCfg(324151132)
				local var_576_13 = arg_573_1:FormatText(var_576_12.content)

				arg_573_1.text_.text = var_576_13

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_15 = 5 <= 0 and var_576_11 or var_576_11 * (utf8.len(var_576_13) / 5)

				if (5 <= 0 and var_576_11 or var_576_11 * (utf8.len(var_576_13) / 5)) > 0 and var_576_11 < var_576_15 then
					arg_573_1.talkMaxDuration = var_576_15

					if var_576_15 + var_576_10 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_15 + var_576_10
					end
				end

				arg_573_1.text_.text = var_576_13
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151132", "story_v_out_324151.awb") ~= 0 then
					local var_576_16 = manager.audio:GetVoiceLength("story_v_out_324151", "324151132", "story_v_out_324151.awb") / 1000

					if var_576_16 + var_576_10 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_16 + var_576_10
					end

					if var_576_12.prefab_name ~= "" and arg_573_1.actors_[var_576_12.prefab_name] ~= nil then
						local var_576_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_12.prefab_name].transform, "story_v_out_324151", "324151132", "story_v_out_324151.awb")

						arg_573_1:RecordAudio("324151132", var_576_17)
						arg_573_1:RecordAudio("324151132", var_576_17)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_out_324151", "324151132", "story_v_out_324151.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_out_324151", "324151132", "story_v_out_324151.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_18 = math.max(var_576_11, arg_573_1.talkMaxDuration)

			if var_576_10 <= arg_573_1.time_ and arg_573_1.time_ < var_576_10 + var_576_18 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_10) / var_576_18

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_10 + var_576_18 and arg_573_1.time_ < var_576_10 + var_576_18 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_573_1:InitPlayNodeList()
	end,
	Play324151133 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 324151133
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play324151134(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.var_.moveOldPos10171ui_story = arg_577_1.actors_["10171ui_story"].transform.localPosition

				local var_580_0 = GameObjectTools.GetOrAddComponent(arg_577_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_580_0 then
					var_580_0:EnableDynamicBone(false)
				end
			end

			local var_580_1 = 0.001

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_1 then
				arg_577_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_577_1.time_ - 0) / var_580_1)
				arg_577_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_577_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["10171ui_story"].transform.position).z)
				arg_577_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_577_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_577_1.actors_["10171ui_story"].transform.localEulerAngles = arg_577_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_577_1.time_ >= 0 + var_580_1 and arg_577_1.time_ < 0 + var_580_1 + arg_580_0 then
				arg_577_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_577_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_577_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["10171ui_story"].transform.position).z)
				arg_577_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_577_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_577_1.actors_["10171ui_story"].transform.localEulerAngles = arg_577_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_580_2 = GameObjectTools.GetOrAddComponent(arg_577_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_580_2 then
					var_580_2:EnableDynamicBone(true)
				end
			end

			local var_580_3 = arg_577_1.actors_["1072ui_story"].transform

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.var_.moveOldPos1072ui_story = var_580_3.localPosition
			end

			local var_580_4 = 0.001

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_4 then
				var_580_3.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_577_1.time_ - 0) / var_580_4)
				var_580_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_580_3.position).x, (manager.ui.mainCamera.transform.position - var_580_3.position).y, (manager.ui.mainCamera.transform.position - var_580_3.position).z)
				var_580_3.localEulerAngles.z = 0
				var_580_3.localEulerAngles.x = 0
				var_580_3.localEulerAngles = var_580_3.localEulerAngles
			end

			if arg_577_1.time_ >= 0 + var_580_4 and arg_577_1.time_ < 0 + var_580_4 + arg_580_0 then
				var_580_3.localPosition = Vector3.New(0, 100, 0)
				var_580_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_580_3.position).x, (manager.ui.mainCamera.transform.position - var_580_3.position).y, (manager.ui.mainCamera.transform.position - var_580_3.position).z)
				var_580_3.localEulerAngles.z = 0
				var_580_3.localEulerAngles.x = 0
				var_580_3.localEulerAngles = var_580_3.localEulerAngles
			end

			local var_580_5 = arg_577_1.actors_["1072ui_story"]

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(var_580_5) and arg_577_1.var_.characterEffect1072ui_story == nil then
				arg_577_1.var_.characterEffect1072ui_story = var_580_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_6 = 0.200000002980232

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_6 and not isNil(var_580_5) then
				if arg_577_1.var_.characterEffect1072ui_story and not isNil(var_580_5) then
					arg_577_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_577_1.time_ - 0) / var_580_6)
				end
			end

			if arg_577_1.time_ >= 0 + var_580_6 and arg_577_1.time_ < 0 + var_580_6 + arg_580_0 and not isNil(var_580_5) and arg_577_1.var_.characterEffect1072ui_story then
				arg_577_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_580_7 = 0
			local var_580_8 = 0.6

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_7 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_9 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(324151133).content)

				arg_577_1.text_.text = var_580_9

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_11 = 24 <= 0 and var_580_8 or var_580_8 * (utf8.len(var_580_9) / 24)

				if (24 <= 0 and var_580_8 or var_580_8 * (utf8.len(var_580_9) / 24)) > 0 and var_580_8 < var_580_11 then
					arg_577_1.talkMaxDuration = var_580_11

					if var_580_11 + var_580_7 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_11 + var_580_7
					end
				end

				arg_577_1.text_.text = var_580_9
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_12 = math.max(var_580_8, arg_577_1.talkMaxDuration)

			if var_580_7 <= arg_577_1.time_ and arg_577_1.time_ < var_580_7 + var_580_12 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_7) / var_580_12

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_7 + var_580_12 and arg_577_1.time_ < var_580_7 + var_580_12 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_577_1:InitPlayNodeList()
	end,
	Play324151134 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 324151134
		arg_581_1.duration_ = 4.17

		local var_581_0 = {
			zh = 4.1,
			ja = 4.166
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play324151135(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.var_.moveOldPos1072ui_story = arg_581_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_584_0 = 0.001

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 then
				arg_581_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_581_1.time_ - 0) / var_584_0)
				arg_581_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1072ui_story"].transform.position).z)
				arg_581_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1072ui_story"].transform.localEulerAngles = arg_581_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 then
				arg_581_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_581_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1072ui_story"].transform.position).z)
				arg_581_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1072ui_story"].transform.localEulerAngles = arg_581_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_584_1 = arg_581_1.actors_["1072ui_story"]

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(var_584_1) and arg_581_1.var_.characterEffect1072ui_story == nil then
				arg_581_1.var_.characterEffect1072ui_story = var_584_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_2 = 0.200000002980232

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_2 and not isNil(var_584_1) then
				if arg_581_1.var_.characterEffect1072ui_story and not isNil(var_584_1) then
					arg_581_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= 0 + var_584_2 and arg_581_1.time_ < 0 + var_584_2 + arg_584_0 and not isNil(var_584_1) and arg_581_1.var_.characterEffect1072ui_story then
				arg_581_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_584_4 = 0
			local var_584_5 = 0.55

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_4 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_6 = arg_581_1:GetWordFromCfg(324151134)
				local var_584_7 = arg_581_1:FormatText(var_584_6.content)

				arg_581_1.text_.text = var_584_7

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_9 = 22 <= 0 and var_584_5 or var_584_5 * (utf8.len(var_584_7) / 22)

				if (22 <= 0 and var_584_5 or var_584_5 * (utf8.len(var_584_7) / 22)) > 0 and var_584_5 < var_584_9 then
					arg_581_1.talkMaxDuration = var_584_9

					if var_584_9 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_9 + var_584_4
					end
				end

				arg_581_1.text_.text = var_584_7
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151134", "story_v_out_324151.awb") ~= 0 then
					local var_584_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151134", "story_v_out_324151.awb") / 1000

					if var_584_10 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_10 + var_584_4
					end

					if var_584_6.prefab_name ~= "" and arg_581_1.actors_[var_584_6.prefab_name] ~= nil then
						local var_584_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_6.prefab_name].transform, "story_v_out_324151", "324151134", "story_v_out_324151.awb")

						arg_581_1:RecordAudio("324151134", var_584_11)
						arg_581_1:RecordAudio("324151134", var_584_11)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_324151", "324151134", "story_v_out_324151.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_324151", "324151134", "story_v_out_324151.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_12 = math.max(var_584_5, arg_581_1.talkMaxDuration)

			if var_584_4 <= arg_581_1.time_ and arg_581_1.time_ < var_584_4 + var_584_12 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_4) / var_584_12

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_4 + var_584_12 and arg_581_1.time_ < var_584_4 + var_584_12 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_581_1:InitPlayNodeList()
	end,
	Play324151135 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 324151135
		arg_585_1.duration_ = 5.2

		local var_585_0 = {
			zh = 3.366,
			ja = 5.2
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play324151136(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0.4

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_1 = arg_585_1:GetWordFromCfg(324151135)
				local var_588_2 = arg_585_1:FormatText(var_588_1.content)

				arg_585_1.text_.text = var_588_2

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_4 = 16 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_2) / 16)

				if (16 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_2) / 16)) > 0 and var_588_0 < var_588_4 then
					arg_585_1.talkMaxDuration = var_588_4

					if var_588_4 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_4 + 0
					end
				end

				arg_585_1.text_.text = var_588_2
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151135", "story_v_out_324151.awb") ~= 0 then
					local var_588_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151135", "story_v_out_324151.awb") / 1000

					if var_588_5 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_5 + 0
					end

					if var_588_1.prefab_name ~= "" and arg_585_1.actors_[var_588_1.prefab_name] ~= nil then
						local var_588_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_1.prefab_name].transform, "story_v_out_324151", "324151135", "story_v_out_324151.awb")

						arg_585_1:RecordAudio("324151135", var_588_6)
						arg_585_1:RecordAudio("324151135", var_588_6)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_324151", "324151135", "story_v_out_324151.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_324151", "324151135", "story_v_out_324151.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_7 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_7 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_7

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_7 and arg_585_1.time_ < 0 + var_588_7 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play324151136 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 324151136
		arg_589_1.duration_ = 9.2

		local var_589_0 = {
			zh = 5.8,
			ja = 9.2
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play324151137(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.var_.moveOldPos10171ui_story = arg_589_1.actors_["10171ui_story"].transform.localPosition

				local var_592_0 = GameObjectTools.GetOrAddComponent(arg_589_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_592_0 then
					var_592_0:EnableDynamicBone(false)
				end
			end

			local var_592_1 = 0.001

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_1 then
				arg_589_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos10171ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_589_1.time_ - 0) / var_592_1)
				arg_589_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_589_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["10171ui_story"].transform.position).z)
				arg_589_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_589_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_589_1.actors_["10171ui_story"].transform.localEulerAngles = arg_589_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_589_1.time_ >= 0 + var_592_1 and arg_589_1.time_ < 0 + var_592_1 + arg_592_0 then
				arg_589_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_589_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_589_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["10171ui_story"].transform.position).z)
				arg_589_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_589_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_589_1.actors_["10171ui_story"].transform.localEulerAngles = arg_589_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_592_2 = GameObjectTools.GetOrAddComponent(arg_589_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_592_2 then
					var_592_2:EnableDynamicBone(true)
				end
			end

			local var_592_3 = arg_589_1.actors_["10171ui_story"]

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(var_592_3) and arg_589_1.var_.characterEffect10171ui_story == nil then
				arg_589_1.var_.characterEffect10171ui_story = var_592_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_4 = 0.200000002980232

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 and not isNil(var_592_3) then
				if arg_589_1.var_.characterEffect10171ui_story and not isNil(var_592_3) then
					arg_589_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 and not isNil(var_592_3) and arg_589_1.var_.characterEffect10171ui_story then
				arg_589_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_592_6 = arg_589_1.actors_["1072ui_story"]

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(var_592_6) and arg_589_1.var_.characterEffect1072ui_story == nil then
				arg_589_1.var_.characterEffect1072ui_story = var_592_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_7 = 0.200000002980232

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_7 and not isNil(var_592_6) then
				if arg_589_1.var_.characterEffect1072ui_story and not isNil(var_592_6) then
					arg_589_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_589_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_589_1.time_ - 0) / var_592_7)
				end
			end

			if arg_589_1.time_ >= 0 + var_592_7 and arg_589_1.time_ < 0 + var_592_7 + arg_592_0 and not isNil(var_592_6) and arg_589_1.var_.characterEffect1072ui_story then
				arg_589_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_589_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_592_8 = 0
			local var_592_9 = 0.775

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_8 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_10 = arg_589_1:GetWordFromCfg(324151136)
				local var_592_11 = arg_589_1:FormatText(var_592_10.content)

				arg_589_1.text_.text = var_592_11

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_13 = 31 <= 0 and var_592_9 or var_592_9 * (utf8.len(var_592_11) / 31)

				if (31 <= 0 and var_592_9 or var_592_9 * (utf8.len(var_592_11) / 31)) > 0 and var_592_9 < var_592_13 then
					arg_589_1.talkMaxDuration = var_592_13

					if var_592_13 + var_592_8 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_13 + var_592_8
					end
				end

				arg_589_1.text_.text = var_592_11
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151136", "story_v_out_324151.awb") ~= 0 then
					local var_592_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151136", "story_v_out_324151.awb") / 1000

					if var_592_14 + var_592_8 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_14 + var_592_8
					end

					if var_592_10.prefab_name ~= "" and arg_589_1.actors_[var_592_10.prefab_name] ~= nil then
						local var_592_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_10.prefab_name].transform, "story_v_out_324151", "324151136", "story_v_out_324151.awb")

						arg_589_1:RecordAudio("324151136", var_592_15)
						arg_589_1:RecordAudio("324151136", var_592_15)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_324151", "324151136", "story_v_out_324151.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_324151", "324151136", "story_v_out_324151.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_16 = math.max(var_592_9, arg_589_1.talkMaxDuration)

			if var_592_8 <= arg_589_1.time_ and arg_589_1.time_ < var_592_8 + var_592_16 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_8) / var_592_16

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_8 + var_592_16 and arg_589_1.time_ < var_592_8 + var_592_16 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play324151137 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 324151137
		arg_593_1.duration_ = 5.1

		local var_593_0 = {
			zh = 4.666,
			ja = 5.1
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play324151138(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(arg_593_1.actors_["1072ui_story"]) and arg_593_1.var_.characterEffect1072ui_story == nil then
				arg_593_1.var_.characterEffect1072ui_story = arg_593_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_0 = 0.200000002980232

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_0 and not isNil(arg_593_1.actors_["1072ui_story"]) then
				if arg_593_1.var_.characterEffect1072ui_story and not isNil(arg_593_1.actors_["1072ui_story"]) then
					arg_593_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_593_1.time_ >= 0 + var_596_0 and arg_593_1.time_ < 0 + var_596_0 + arg_596_0 and not isNil(arg_593_1.actors_["1072ui_story"]) and arg_593_1.var_.characterEffect1072ui_story then
				arg_593_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_596_2 = arg_593_1.actors_["10171ui_story"]

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(var_596_2) and arg_593_1.var_.characterEffect10171ui_story == nil then
				arg_593_1.var_.characterEffect10171ui_story = var_596_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_3 = 0.200000002980232

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_3 and not isNil(var_596_2) then
				if arg_593_1.var_.characterEffect10171ui_story and not isNil(var_596_2) then
					arg_593_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_593_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_593_1.time_ - 0) / var_596_3)
				end
			end

			if arg_593_1.time_ >= 0 + var_596_3 and arg_593_1.time_ < 0 + var_596_3 + arg_596_0 and not isNil(var_596_2) and arg_593_1.var_.characterEffect10171ui_story then
				arg_593_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_593_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action424")
			end

			local var_596_4 = 0
			local var_596_5 = 0.55

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_4 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_6 = arg_593_1:GetWordFromCfg(324151137)
				local var_596_7 = arg_593_1:FormatText(var_596_6.content)

				arg_593_1.text_.text = var_596_7

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_9 = 22 <= 0 and var_596_5 or var_596_5 * (utf8.len(var_596_7) / 22)

				if (22 <= 0 and var_596_5 or var_596_5 * (utf8.len(var_596_7) / 22)) > 0 and var_596_5 < var_596_9 then
					arg_593_1.talkMaxDuration = var_596_9

					if var_596_9 + var_596_4 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_9 + var_596_4
					end
				end

				arg_593_1.text_.text = var_596_7
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151137", "story_v_out_324151.awb") ~= 0 then
					local var_596_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151137", "story_v_out_324151.awb") / 1000

					if var_596_10 + var_596_4 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_10 + var_596_4
					end

					if var_596_6.prefab_name ~= "" and arg_593_1.actors_[var_596_6.prefab_name] ~= nil then
						local var_596_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_6.prefab_name].transform, "story_v_out_324151", "324151137", "story_v_out_324151.awb")

						arg_593_1:RecordAudio("324151137", var_596_11)
						arg_593_1:RecordAudio("324151137", var_596_11)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_out_324151", "324151137", "story_v_out_324151.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_out_324151", "324151137", "story_v_out_324151.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_12 = math.max(var_596_5, arg_593_1.talkMaxDuration)

			if var_596_4 <= arg_593_1.time_ and arg_593_1.time_ < var_596_4 + var_596_12 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_4) / var_596_12

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_4 + var_596_12 and arg_593_1.time_ < var_596_4 + var_596_12 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play324151138 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 324151138
		arg_597_1.duration_ = 5.13

		local var_597_0 = {
			zh = 2.866,
			ja = 5.133
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play324151139(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_600_0 = 0
			local var_600_1 = 0.3

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_2 = arg_597_1:GetWordFromCfg(324151138)
				local var_600_3 = arg_597_1:FormatText(var_600_2.content)

				arg_597_1.text_.text = var_600_3

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_5 = 12 <= 0 and var_600_1 or var_600_1 * (utf8.len(var_600_3) / 12)

				if (12 <= 0 and var_600_1 or var_600_1 * (utf8.len(var_600_3) / 12)) > 0 and var_600_1 < var_600_5 then
					arg_597_1.talkMaxDuration = var_600_5

					if var_600_5 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_5 + var_600_0
					end
				end

				arg_597_1.text_.text = var_600_3
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151138", "story_v_out_324151.awb") ~= 0 then
					local var_600_6 = manager.audio:GetVoiceLength("story_v_out_324151", "324151138", "story_v_out_324151.awb") / 1000

					if var_600_6 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_6 + var_600_0
					end

					if var_600_2.prefab_name ~= "" and arg_597_1.actors_[var_600_2.prefab_name] ~= nil then
						local var_600_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_2.prefab_name].transform, "story_v_out_324151", "324151138", "story_v_out_324151.awb")

						arg_597_1:RecordAudio("324151138", var_600_7)
						arg_597_1:RecordAudio("324151138", var_600_7)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_324151", "324151138", "story_v_out_324151.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_324151", "324151138", "story_v_out_324151.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_8 = math.max(var_600_1, arg_597_1.talkMaxDuration)

			if var_600_0 <= arg_597_1.time_ and arg_597_1.time_ < var_600_0 + var_600_8 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_0) / var_600_8

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_0 + var_600_8 and arg_597_1.time_ < var_600_0 + var_600_8 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play324151139 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 324151139
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play324151140(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.var_.moveOldPos1072ui_story = arg_601_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_604_0 = 0.001

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 then
				arg_601_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_601_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_601_1.time_ - 0) / var_604_0)
				arg_601_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_601_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1072ui_story"].transform.position).z)
				arg_601_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_601_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_601_1.actors_["1072ui_story"].transform.localEulerAngles = arg_601_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 then
				arg_601_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_601_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_601_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1072ui_story"].transform.position).z)
				arg_601_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_601_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_601_1.actors_["1072ui_story"].transform.localEulerAngles = arg_601_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_604_1 = arg_601_1.actors_["10171ui_story"].transform

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.var_.moveOldPos10171ui_story = var_604_1.localPosition

				local var_604_2 = GameObjectTools.GetOrAddComponent(var_604_1.gameObject, typeof(DynamicBoneHelper))

				if var_604_2 then
					var_604_2:EnableDynamicBone(false)
				end
			end

			local var_604_3 = 0.001

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_3 then
				var_604_1.localPosition = Vector3.Lerp(arg_601_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_601_1.time_ - 0) / var_604_3)
				var_604_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_604_1.position).x, (manager.ui.mainCamera.transform.position - var_604_1.position).y, (manager.ui.mainCamera.transform.position - var_604_1.position).z)
				var_604_1.localEulerAngles.z = 0
				var_604_1.localEulerAngles.x = 0
				var_604_1.localEulerAngles = var_604_1.localEulerAngles
			end

			if arg_601_1.time_ >= 0 + var_604_3 and arg_601_1.time_ < 0 + var_604_3 + arg_604_0 then
				var_604_1.localPosition = Vector3.New(0, 100, 0)
				var_604_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_604_1.position).x, (manager.ui.mainCamera.transform.position - var_604_1.position).y, (manager.ui.mainCamera.transform.position - var_604_1.position).z)
				var_604_1.localEulerAngles.z = 0
				var_604_1.localEulerAngles.x = 0
				var_604_1.localEulerAngles = var_604_1.localEulerAngles

				local var_604_4 = GameObjectTools.GetOrAddComponent(var_604_1.gameObject, typeof(DynamicBoneHelper))

				if var_604_4 then
					var_604_4:EnableDynamicBone(true)
				end
			end

			local var_604_5 = arg_601_1.actors_["1072ui_story"]

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 and not isNil(var_604_5) and arg_601_1.var_.characterEffect1072ui_story == nil then
				arg_601_1.var_.characterEffect1072ui_story = var_604_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_6 = 0.200000002980232

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_6 and not isNil(var_604_5) then
				if arg_601_1.var_.characterEffect1072ui_story and not isNil(var_604_5) then
					arg_601_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_601_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_601_1.time_ - 0) / var_604_6)
				end
			end

			if arg_601_1.time_ >= 0 + var_604_6 and arg_601_1.time_ < 0 + var_604_6 + arg_604_0 and not isNil(var_604_5) and arg_601_1.var_.characterEffect1072ui_story then
				arg_601_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_601_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_601_1.time_ and arg_601_1.time_ <= 0.1 + arg_604_0 then
				arg_601_1:AudioAction("play", "effect", "se_story_142", "se_story_142_chopper02", "")
			end

			local var_604_8 = 0
			local var_604_9 = 1.4

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_8 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_10 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(324151139).content)

				arg_601_1.text_.text = var_604_10

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_12 = 56 <= 0 and var_604_9 or var_604_9 * (utf8.len(var_604_10) / 56)

				if (56 <= 0 and var_604_9 or var_604_9 * (utf8.len(var_604_10) / 56)) > 0 and var_604_9 < var_604_12 then
					arg_601_1.talkMaxDuration = var_604_12

					if var_604_12 + var_604_8 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_12 + var_604_8
					end
				end

				arg_601_1.text_.text = var_604_10
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_13 = math.max(var_604_9, arg_601_1.talkMaxDuration)

			if var_604_8 <= arg_601_1.time_ and arg_601_1.time_ < var_604_8 + var_604_13 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_8) / var_604_13

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_8 + var_604_13 and arg_601_1.time_ < var_604_8 + var_604_13 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_601_1:InitPlayNodeList()
	end,
	Play324151140 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 324151140
		arg_605_1.duration_ = 7.47

		local var_605_0 = {
			zh = 5.4,
			ja = 7.466
		}
		local var_605_1 = manager.audio:GetLocalizationFlag()

		if var_605_0[var_605_1] ~= nil then
			arg_605_1.duration_ = var_605_0[var_605_1]
		end

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play324151141(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0.55

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, true)
				arg_605_1.iconController_:SetSelectedState("hero")

				arg_605_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_605_1.callingController_:SetSelectedState("normal")

				arg_605_1.keyicon_.color = Color.New(1, 1, 1)
				arg_605_1.icon_.color = Color.New(1, 1, 1)

				local var_608_1 = arg_605_1:GetWordFromCfg(324151140)
				local var_608_2 = arg_605_1:FormatText(var_608_1.content)

				arg_605_1.text_.text = var_608_2

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_4 = 22 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_2) / 22)

				if (22 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_2) / 22)) > 0 and var_608_0 < var_608_4 then
					arg_605_1.talkMaxDuration = var_608_4

					if var_608_4 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_4 + 0
					end
				end

				arg_605_1.text_.text = var_608_2
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151140", "story_v_out_324151.awb") ~= 0 then
					local var_608_5 = manager.audio:GetVoiceLength("story_v_out_324151", "324151140", "story_v_out_324151.awb") / 1000

					if var_608_5 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_5 + 0
					end

					if var_608_1.prefab_name ~= "" and arg_605_1.actors_[var_608_1.prefab_name] ~= nil then
						local var_608_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_1.prefab_name].transform, "story_v_out_324151", "324151140", "story_v_out_324151.awb")

						arg_605_1:RecordAudio("324151140", var_608_6)
						arg_605_1:RecordAudio("324151140", var_608_6)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_out_324151", "324151140", "story_v_out_324151.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_out_324151", "324151140", "story_v_out_324151.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_7 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_7 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_7

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_7 and arg_605_1.time_ < 0 + var_608_7 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play324151141 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 324151141
		arg_609_1.duration_ = 3.07

		local var_609_0 = {
			zh = 2.3,
			ja = 3.066
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play324151142(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.var_.moveOldPos10171ui_story = arg_609_1.actors_["10171ui_story"].transform.localPosition

				local var_612_0 = GameObjectTools.GetOrAddComponent(arg_609_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_612_0 then
					var_612_0:EnableDynamicBone(false)
				end
			end

			local var_612_1 = 0.001

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_1 then
				arg_609_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_609_1.time_ - 0) / var_612_1)
				arg_609_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_609_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["10171ui_story"].transform.position).z)
				arg_609_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_609_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_609_1.actors_["10171ui_story"].transform.localEulerAngles = arg_609_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_609_1.time_ >= 0 + var_612_1 and arg_609_1.time_ < 0 + var_612_1 + arg_612_0 then
				arg_609_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_609_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_609_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["10171ui_story"].transform.position).z)
				arg_609_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_609_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_609_1.actors_["10171ui_story"].transform.localEulerAngles = arg_609_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_612_2 = GameObjectTools.GetOrAddComponent(arg_609_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_612_2 then
					var_612_2:EnableDynamicBone(true)
				end
			end

			local var_612_3 = arg_609_1.actors_["10171ui_story"]

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 and not isNil(var_612_3) and arg_609_1.var_.characterEffect10171ui_story == nil then
				arg_609_1.var_.characterEffect10171ui_story = var_612_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_4 = 0.200000002980232

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_4 and not isNil(var_612_3) then
				if arg_609_1.var_.characterEffect10171ui_story and not isNil(var_612_3) then
					arg_609_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_609_1.time_ >= 0 + var_612_4 and arg_609_1.time_ < 0 + var_612_4 + arg_612_0 and not isNil(var_612_3) and arg_609_1.var_.characterEffect10171ui_story then
				arg_609_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_612_6 = 0
			local var_612_7 = 0.35

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_6 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				arg_609_1.leftNameTxt_.text = arg_609_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_8 = arg_609_1:GetWordFromCfg(324151141)
				local var_612_9 = arg_609_1:FormatText(var_612_8.content)

				arg_609_1.text_.text = var_612_9

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_11 = 14 <= 0 and var_612_7 or var_612_7 * (utf8.len(var_612_9) / 14)

				if (14 <= 0 and var_612_7 or var_612_7 * (utf8.len(var_612_9) / 14)) > 0 and var_612_7 < var_612_11 then
					arg_609_1.talkMaxDuration = var_612_11

					if var_612_11 + var_612_6 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_11 + var_612_6
					end
				end

				arg_609_1.text_.text = var_612_9
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151141", "story_v_out_324151.awb") ~= 0 then
					local var_612_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151141", "story_v_out_324151.awb") / 1000

					if var_612_12 + var_612_6 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_12 + var_612_6
					end

					if var_612_8.prefab_name ~= "" and arg_609_1.actors_[var_612_8.prefab_name] ~= nil then
						local var_612_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_8.prefab_name].transform, "story_v_out_324151", "324151141", "story_v_out_324151.awb")

						arg_609_1:RecordAudio("324151141", var_612_13)
						arg_609_1:RecordAudio("324151141", var_612_13)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_out_324151", "324151141", "story_v_out_324151.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_out_324151", "324151141", "story_v_out_324151.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_14 = math.max(var_612_7, arg_609_1.talkMaxDuration)

			if var_612_6 <= arg_609_1.time_ and arg_609_1.time_ < var_612_6 + var_612_14 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_6) / var_612_14

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_6 + var_612_14 and arg_609_1.time_ < var_612_6 + var_612_14 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_609_1:InitPlayNodeList()
	end,
	Play324151142 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 324151142
		arg_613_1.duration_ = 13.1

		local var_613_0 = {
			zh = 4.066,
			ja = 13.1
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play324151143(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 and not isNil(arg_613_1.actors_["10171ui_story"]) and arg_613_1.var_.characterEffect10171ui_story == nil then
				arg_613_1.var_.characterEffect10171ui_story = arg_613_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_0 = 0.200000002980232

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_0 and not isNil(arg_613_1.actors_["10171ui_story"]) then
				if arg_613_1.var_.characterEffect10171ui_story and not isNil(arg_613_1.actors_["10171ui_story"]) then
					arg_613_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_613_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_613_1.time_ - 0) / var_616_0)
				end
			end

			if arg_613_1.time_ >= 0 + var_616_0 and arg_613_1.time_ < 0 + var_616_0 + arg_616_0 and not isNil(arg_613_1.actors_["10171ui_story"]) and arg_613_1.var_.characterEffect10171ui_story then
				arg_613_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_613_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_616_1 = 0
			local var_616_2 = 0.425

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_1 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_3 = arg_613_1:GetWordFromCfg(324151142)
				local var_616_4 = arg_613_1:FormatText(var_616_3.content)

				arg_613_1.text_.text = var_616_4

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_6 = 17 <= 0 and var_616_2 or var_616_2 * (utf8.len(var_616_4) / 17)

				if (17 <= 0 and var_616_2 or var_616_2 * (utf8.len(var_616_4) / 17)) > 0 and var_616_2 < var_616_6 then
					arg_613_1.talkMaxDuration = var_616_6

					if var_616_6 + var_616_1 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_6 + var_616_1
					end
				end

				arg_613_1.text_.text = var_616_4
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151142", "story_v_out_324151.awb") ~= 0 then
					local var_616_7 = manager.audio:GetVoiceLength("story_v_out_324151", "324151142", "story_v_out_324151.awb") / 1000

					if var_616_7 + var_616_1 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_1
					end

					if var_616_3.prefab_name ~= "" and arg_613_1.actors_[var_616_3.prefab_name] ~= nil then
						local var_616_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_3.prefab_name].transform, "story_v_out_324151", "324151142", "story_v_out_324151.awb")

						arg_613_1:RecordAudio("324151142", var_616_8)
						arg_613_1:RecordAudio("324151142", var_616_8)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_out_324151", "324151142", "story_v_out_324151.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_out_324151", "324151142", "story_v_out_324151.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_9 = math.max(var_616_2, arg_613_1.talkMaxDuration)

			if var_616_1 <= arg_613_1.time_ and arg_613_1.time_ < var_616_1 + var_616_9 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_1) / var_616_9

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_1 + var_616_9 and arg_613_1.time_ < var_616_1 + var_616_9 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play324151143 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 324151143
		arg_617_1.duration_ = 9.37

		local var_617_0 = {
			zh = 6.7,
			ja = 9.366
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
			arg_617_1.auto_ = false
		end

		function arg_617_1.playNext_(arg_619_0)
			arg_617_1.onStoryFinished_()
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 and not isNil(arg_617_1.actors_["10171ui_story"]) and arg_617_1.var_.characterEffect10171ui_story == nil then
				arg_617_1.var_.characterEffect10171ui_story = arg_617_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_0 = 0.200000002980232

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_0 and not isNil(arg_617_1.actors_["10171ui_story"]) then
				if arg_617_1.var_.characterEffect10171ui_story and not isNil(arg_617_1.actors_["10171ui_story"]) then
					arg_617_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_617_1.time_ >= 0 + var_620_0 and arg_617_1.time_ < 0 + var_620_0 + arg_620_0 and not isNil(arg_617_1.actors_["10171ui_story"]) and arg_617_1.var_.characterEffect10171ui_story then
				arg_617_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_620_2 = 0
			local var_620_3 = 0.75

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_2 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_4 = arg_617_1:GetWordFromCfg(324151143)
				local var_620_5 = arg_617_1:FormatText(var_620_4.content)

				arg_617_1.text_.text = var_620_5

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_7 = 30 <= 0 and var_620_3 or var_620_3 * (utf8.len(var_620_5) / 30)

				if (30 <= 0 and var_620_3 or var_620_3 * (utf8.len(var_620_5) / 30)) > 0 and var_620_3 < var_620_7 then
					arg_617_1.talkMaxDuration = var_620_7

					if var_620_7 + var_620_2 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_7 + var_620_2
					end
				end

				arg_617_1.text_.text = var_620_5
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151143", "story_v_out_324151.awb") ~= 0 then
					local var_620_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151143", "story_v_out_324151.awb") / 1000

					if var_620_8 + var_620_2 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_8 + var_620_2
					end

					if var_620_4.prefab_name ~= "" and arg_617_1.actors_[var_620_4.prefab_name] ~= nil then
						local var_620_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_4.prefab_name].transform, "story_v_out_324151", "324151143", "story_v_out_324151.awb")

						arg_617_1:RecordAudio("324151143", var_620_9)
						arg_617_1:RecordAudio("324151143", var_620_9)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_out_324151", "324151143", "story_v_out_324151.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_out_324151", "324151143", "story_v_out_324151.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_10 = math.max(var_620_3, arg_617_1.talkMaxDuration)

			if var_620_2 <= arg_617_1.time_ and arg_617_1.time_ < var_620_2 + var_620_10 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_2) / var_620_10

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_2 + var_620_10 and arg_617_1.time_ < var_620_2 + var_620_10 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/J02",
		"TextureConfig/Background/ST42",
		"TextureConfig/Background/J05f",
		"TextureConfig/Background/ST2002",
		"TextureConfig/Background/ST39",
		"TextureConfig/Background/J22f",
		"TextureConfig/Background/ST41",
		"TextureConfig/Background/J08",
		"TextureConfig/Background/J13f",
		"TextureConfig/Background/J23f",
		"TextureConfig/Background/J24f",
		"TextureConfig/Background/ST44",
		"TextureConfig/Background/ST2009",
		"TextureConfig/Background/ST2005",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J25f",
		"TextureConfig/Background/J22g"
	},
	voices = {
		"story_v_out_324151.awb"
	}
}
