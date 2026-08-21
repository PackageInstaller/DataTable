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
			local var_4_0 = "ST31"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.ST31

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST31" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = manager.ui.mainCamera.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effect2323
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_soundonly_keep"), var_4_28)
					var_4_26.name = "2323"
					arg_1_1.var_.effect2323 = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_29 = manager.ui.mainCamera.transform
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = arg_1_1.var_.effect3242
				local var_4_32
				local var_4_33 = var_4_29

				if not var_4_31 then
					var_4_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), var_4_33)
					var_4_31.name = "3242"
					arg_1_1.var_.effect3242 = var_4_31
				else
					var_4_31.transform:SetParent(var_4_33)
				end

				var_4_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_31.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_34 = 1.7777777777777777
				local var_4_35 = Screen.width / Screen.height
				local var_4_36 = var_4_35 / var_4_34
				local var_4_37 = Mathf.Max(var_4_34 / var_4_35, 1)

				var_4_31.transform.localScale = Vector3.New(var_4_31.transform.localScale.x * var_4_36, var_4_31.transform.localScale.y * var_4_37, var_4_31.transform.localScale.z)
			end

			local var_4_38 = 0.1
			local var_4_39 = 1

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_40 = "play"
				local var_4_41 = "effect"

				arg_1_1:AudioAction(var_4_40, var_4_41, "se_story_1310", "se_story_1310_wind", "")
			end

			local var_4_42 = 0
			local var_4_43 = 1

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "effect"

				arg_1_1:AudioAction(var_4_44, var_4_45, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_46 = 1.3
			local var_4_47 = 0.2

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_48 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_48:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_49 = arg_1_1:FormatText(StoryNameCfg[672].name)

				arg_1_1.leftNameTxt_.text = var_4_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_50 = arg_1_1:GetWordFromCfg(324151001)
				local var_4_51 = arg_1_1:FormatText(var_4_50.content)

				arg_1_1.text_.text = var_4_51

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_52 = 8
				local var_4_53 = utf8.len(var_4_51)
				local var_4_54 = var_4_52 <= 0 and var_4_47 or var_4_47 * (var_4_53 / var_4_52)

				if var_4_54 > 0 and var_4_47 < var_4_54 then
					arg_1_1.talkMaxDuration = var_4_54
					var_4_46 = var_4_46 + 0.3

					if var_4_54 + var_4_46 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_54 + var_4_46
					end
				end

				arg_1_1.text_.text = var_4_51
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151001", "story_v_out_324151.awb") ~= 0 then
					local var_4_55 = manager.audio:GetVoiceLength("story_v_out_324151", "324151001", "story_v_out_324151.awb") / 1000

					if var_4_55 + var_4_46 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_55 + var_4_46
					end

					if var_4_50.prefab_name ~= "" and arg_1_1.actors_[var_4_50.prefab_name] ~= nil then
						local var_4_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_50.prefab_name].transform, "story_v_out_324151", "324151001", "story_v_out_324151.awb")

						arg_1_1:RecordAudio("324151001", var_4_56)
						arg_1_1:RecordAudio("324151001", var_4_56)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324151", "324151001", "story_v_out_324151.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324151", "324151001", "story_v_out_324151.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_57 = var_4_46 + 0.3
			local var_4_58 = math.max(var_4_47, arg_1_1.talkMaxDuration)

			if var_4_57 <= arg_1_1.time_ and arg_1_1.time_ < var_4_57 + var_4_58 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_57) / var_4_58

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_57 + var_4_58 and arg_1_1.time_ < var_4_57 + var_4_58 + arg_4_0 then
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
			local var_10_0 = "ST47"

			if arg_7_1.bgs_[var_10_0] == nil then
				local var_10_1 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_0)
				var_10_1.name = var_10_0
				var_10_1.transform.parent = arg_7_1.stage_.transform
				var_10_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_0] = var_10_1
			end

			local var_10_2 = 0

			if var_10_2 < arg_7_1.time_ and arg_7_1.time_ <= var_10_2 + arg_10_0 then
				local var_10_3 = manager.ui.mainCamera.transform.localPosition
				local var_10_4 = Vector3.New(0, 0, 10) + Vector3.New(var_10_3.x, var_10_3.y, 0)
				local var_10_5 = arg_7_1.bgs_.ST47

				var_10_5.transform.localPosition = var_10_4
				var_10_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_6 = var_10_5:GetComponent("SpriteRenderer")

				if var_10_6 and var_10_6.sprite then
					local var_10_7 = (var_10_5.transform.localPosition - var_10_3).z
					local var_10_8 = manager.ui.mainCameraCom_
					local var_10_9 = 2 * var_10_7 * Mathf.Tan(var_10_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_10_10 = var_10_9 * var_10_8.aspect
					local var_10_11 = var_10_6.sprite.bounds.size.x
					local var_10_12 = var_10_6.sprite.bounds.size.y
					local var_10_13 = var_10_10 / var_10_11
					local var_10_14 = var_10_9 / var_10_12
					local var_10_15 = var_10_14 < var_10_13 and var_10_13 or var_10_14

					var_10_5.transform.localScale = Vector3.New(var_10_15, var_10_15, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "ST47" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_16 = 0

			if var_10_16 < arg_7_1.time_ and arg_7_1.time_ <= var_10_16 + arg_10_0 then
				arg_7_1.allBtn_.enabled = false
			end

			local var_10_17 = 0.3

			if arg_7_1.time_ >= var_10_16 + var_10_17 and arg_7_1.time_ < var_10_16 + var_10_17 + arg_10_0 then
				arg_7_1.allBtn_.enabled = true
			end

			local var_10_18 = 0

			if var_10_18 < arg_7_1.time_ and arg_7_1.time_ <= var_10_18 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_19 = 1

			if var_10_18 <= arg_7_1.time_ and arg_7_1.time_ < var_10_18 + var_10_19 then
				local var_10_20 = (arg_7_1.time_ - var_10_18) / var_10_19
				local var_10_21 = Color.New(0, 0, 0)

				var_10_21.a = Mathf.Lerp(1, 0, var_10_20)
				arg_7_1.mask_.color = var_10_21
			end

			if arg_7_1.time_ >= var_10_18 + var_10_19 and arg_7_1.time_ < var_10_18 + var_10_19 + arg_10_0 then
				local var_10_22 = Color.New(0, 0, 0)
				local var_10_23 = 0

				arg_7_1.mask_.enabled = false
				var_10_22.a = var_10_23
				arg_7_1.mask_.color = var_10_22
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_24 = 0.433333333333333
			local var_10_25 = 0.2

			if var_10_24 < arg_7_1.time_ and arg_7_1.time_ <= var_10_24 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_26 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_26:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_27 = arg_7_1:FormatText(StoryNameCfg[672].name)

				arg_7_1.leftNameTxt_.text = var_10_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_28 = arg_7_1:GetWordFromCfg(324151002)
				local var_10_29 = arg_7_1:FormatText(var_10_28.content)

				arg_7_1.text_.text = var_10_29

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_30 = 8
				local var_10_31 = utf8.len(var_10_29)
				local var_10_32 = var_10_30 <= 0 and var_10_25 or var_10_25 * (var_10_31 / var_10_30)

				if var_10_32 > 0 and var_10_25 < var_10_32 then
					arg_7_1.talkMaxDuration = var_10_32
					var_10_24 = var_10_24 + 0.3

					if var_10_32 + var_10_24 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_32 + var_10_24
					end
				end

				arg_7_1.text_.text = var_10_29
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151002", "story_v_out_324151.awb") ~= 0 then
					local var_10_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151002", "story_v_out_324151.awb") / 1000

					if var_10_33 + var_10_24 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_33 + var_10_24
					end

					if var_10_28.prefab_name ~= "" and arg_7_1.actors_[var_10_28.prefab_name] ~= nil then
						local var_10_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_28.prefab_name].transform, "story_v_out_324151", "324151002", "story_v_out_324151.awb")

						arg_7_1:RecordAudio("324151002", var_10_34)
						arg_7_1:RecordAudio("324151002", var_10_34)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_324151", "324151002", "story_v_out_324151.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_324151", "324151002", "story_v_out_324151.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_35 = var_10_24 + 0.3
			local var_10_36 = math.max(var_10_25, arg_7_1.talkMaxDuration)

			if var_10_35 <= arg_7_1.time_ and arg_7_1.time_ < var_10_35 + var_10_36 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_35) / var_10_36

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_35 + var_10_36 and arg_7_1.time_ < var_10_35 + var_10_36 + arg_10_0 then
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
			local var_16_0 = "J02"

			if arg_13_1.bgs_[var_16_0] == nil then
				local var_16_1 = Object.Instantiate(arg_13_1.paintGo_)

				var_16_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_16_0)
				var_16_1.name = var_16_0
				var_16_1.transform.parent = arg_13_1.stage_.transform
				var_16_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.bgs_[var_16_0] = var_16_1
			end

			local var_16_2 = 0

			if var_16_2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				local var_16_3 = manager.ui.mainCamera.transform.localPosition
				local var_16_4 = Vector3.New(0, 0, 10) + Vector3.New(var_16_3.x, var_16_3.y, 0)
				local var_16_5 = arg_13_1.bgs_.J02

				var_16_5.transform.localPosition = var_16_4
				var_16_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_16_6 = var_16_5:GetComponent("SpriteRenderer")

				if var_16_6 and var_16_6.sprite then
					local var_16_7 = (var_16_5.transform.localPosition - var_16_3).z
					local var_16_8 = manager.ui.mainCameraCom_
					local var_16_9 = 2 * var_16_7 * Mathf.Tan(var_16_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_16_10 = var_16_9 * var_16_8.aspect
					local var_16_11 = var_16_6.sprite.bounds.size.x
					local var_16_12 = var_16_6.sprite.bounds.size.y
					local var_16_13 = var_16_10 / var_16_11
					local var_16_14 = var_16_9 / var_16_12
					local var_16_15 = var_16_14 < var_16_13 and var_16_13 or var_16_14

					var_16_5.transform.localScale = Vector3.New(var_16_15, var_16_15, 0)
				end

				for iter_16_0, iter_16_1 in pairs(arg_13_1.bgs_) do
					if iter_16_0 ~= "J02" then
						iter_16_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			local var_16_17 = 0.3

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_19 = 2

			if var_16_18 <= arg_13_1.time_ and arg_13_1.time_ < var_16_18 + var_16_19 then
				local var_16_20 = (arg_13_1.time_ - var_16_18) / var_16_19
				local var_16_21 = Color.New(0, 0, 0)

				var_16_21.a = Mathf.Lerp(1, 0, var_16_20)
				arg_13_1.mask_.color = var_16_21
			end

			if arg_13_1.time_ >= var_16_18 + var_16_19 and arg_13_1.time_ < var_16_18 + var_16_19 + arg_16_0 then
				local var_16_22 = Color.New(0, 0, 0)
				local var_16_23 = 0

				arg_13_1.mask_.enabled = false
				var_16_22.a = var_16_23
				arg_13_1.mask_.color = var_16_22
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_24 = 1
			local var_16_25 = 0.2

			if var_16_24 < arg_13_1.time_ and arg_13_1.time_ <= var_16_24 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_26 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_26:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_27 = arg_13_1:FormatText(StoryNameCfg[672].name)

				arg_13_1.leftNameTxt_.text = var_16_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_28 = arg_13_1:GetWordFromCfg(324151003)
				local var_16_29 = arg_13_1:FormatText(var_16_28.content)

				arg_13_1.text_.text = var_16_29

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_30 = 8
				local var_16_31 = utf8.len(var_16_29)
				local var_16_32 = var_16_30 <= 0 and var_16_25 or var_16_25 * (var_16_31 / var_16_30)

				if var_16_32 > 0 and var_16_25 < var_16_32 then
					arg_13_1.talkMaxDuration = var_16_32
					var_16_24 = var_16_24 + 0.3

					if var_16_32 + var_16_24 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_32 + var_16_24
					end
				end

				arg_13_1.text_.text = var_16_29
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151003", "story_v_out_324151.awb") ~= 0 then
					local var_16_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151003", "story_v_out_324151.awb") / 1000

					if var_16_33 + var_16_24 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_33 + var_16_24
					end

					if var_16_28.prefab_name ~= "" and arg_13_1.actors_[var_16_28.prefab_name] ~= nil then
						local var_16_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_28.prefab_name].transform, "story_v_out_324151", "324151003", "story_v_out_324151.awb")

						arg_13_1:RecordAudio("324151003", var_16_34)
						arg_13_1:RecordAudio("324151003", var_16_34)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_324151", "324151003", "story_v_out_324151.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_324151", "324151003", "story_v_out_324151.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_35 = var_16_24 + 0.3
			local var_16_36 = math.max(var_16_25, arg_13_1.talkMaxDuration)

			if var_16_35 <= arg_13_1.time_ and arg_13_1.time_ < var_16_35 + var_16_36 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_35) / var_16_36

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_35 + var_16_36 and arg_13_1.time_ < var_16_35 + var_16_36 + arg_16_0 then
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
			local var_22_0 = "ST42"

			if arg_19_1.bgs_[var_22_0] == nil then
				local var_22_1 = Object.Instantiate(arg_19_1.paintGo_)

				var_22_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_22_0)
				var_22_1.name = var_22_0
				var_22_1.transform.parent = arg_19_1.stage_.transform
				var_22_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.bgs_[var_22_0] = var_22_1
			end

			local var_22_2 = 0

			if var_22_2 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				local var_22_3 = manager.ui.mainCamera.transform.localPosition
				local var_22_4 = Vector3.New(0, 0, 10) + Vector3.New(var_22_3.x, var_22_3.y, 0)
				local var_22_5 = arg_19_1.bgs_.ST42

				var_22_5.transform.localPosition = var_22_4
				var_22_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_22_6 = var_22_5:GetComponent("SpriteRenderer")

				if var_22_6 and var_22_6.sprite then
					local var_22_7 = (var_22_5.transform.localPosition - var_22_3).z
					local var_22_8 = manager.ui.mainCameraCom_
					local var_22_9 = 2 * var_22_7 * Mathf.Tan(var_22_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_22_10 = var_22_9 * var_22_8.aspect
					local var_22_11 = var_22_6.sprite.bounds.size.x
					local var_22_12 = var_22_6.sprite.bounds.size.y
					local var_22_13 = var_22_10 / var_22_11
					local var_22_14 = var_22_9 / var_22_12
					local var_22_15 = var_22_14 < var_22_13 and var_22_13 or var_22_14

					var_22_5.transform.localScale = Vector3.New(var_22_15, var_22_15, 0)
				end

				for iter_22_0, iter_22_1 in pairs(arg_19_1.bgs_) do
					if iter_22_0 ~= "ST42" then
						iter_22_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_22_16 = 0

			if var_22_16 < arg_19_1.time_ and arg_19_1.time_ <= var_22_16 + arg_22_0 then
				arg_19_1.allBtn_.enabled = false
			end

			local var_22_17 = 0.3

			if arg_19_1.time_ >= var_22_16 + var_22_17 and arg_19_1.time_ < var_22_16 + var_22_17 + arg_22_0 then
				arg_19_1.allBtn_.enabled = true
			end

			local var_22_18 = 0

			if var_22_18 < arg_19_1.time_ and arg_19_1.time_ <= var_22_18 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_19 = 1

			if var_22_18 <= arg_19_1.time_ and arg_19_1.time_ < var_22_18 + var_22_19 then
				local var_22_20 = (arg_19_1.time_ - var_22_18) / var_22_19
				local var_22_21 = Color.New(0, 0, 0)

				var_22_21.a = Mathf.Lerp(1, 0, var_22_20)
				arg_19_1.mask_.color = var_22_21
			end

			if arg_19_1.time_ >= var_22_18 + var_22_19 and arg_19_1.time_ < var_22_18 + var_22_19 + arg_22_0 then
				local var_22_22 = Color.New(0, 0, 0)
				local var_22_23 = 0

				arg_19_1.mask_.enabled = false
				var_22_22.a = var_22_23
				arg_19_1.mask_.color = var_22_22
			end

			if arg_19_1.frameCnt_ <= 1 then
				arg_19_1.dialog_:SetActive(false)
			end

			local var_22_24 = 0.3
			local var_22_25 = 0.2

			if var_22_24 < arg_19_1.time_ and arg_19_1.time_ <= var_22_24 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				arg_19_1.dialog_:SetActive(true)

				arg_19_1.dialogCg_.alpha = 0

				local var_22_26 = LeanTween.value(arg_19_1.dialog_, 0, 1, 0.3)

				var_22_26:setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
					arg_19_1.dialogCg_.alpha = arg_23_0
				end))
				var_22_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_19_1.dialog_)
					var_22_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_19_1.duration_ = arg_19_1.duration_ + 0.3

				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_27 = arg_19_1:FormatText(StoryNameCfg[672].name)

				arg_19_1.leftNameTxt_.text = var_22_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_28 = arg_19_1:GetWordFromCfg(324151004)
				local var_22_29 = arg_19_1:FormatText(var_22_28.content)

				arg_19_1.text_.text = var_22_29

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_30 = 8
				local var_22_31 = utf8.len(var_22_29)
				local var_22_32 = var_22_30 <= 0 and var_22_25 or var_22_25 * (var_22_31 / var_22_30)

				if var_22_32 > 0 and var_22_25 < var_22_32 then
					arg_19_1.talkMaxDuration = var_22_32
					var_22_24 = var_22_24 + 0.3

					if var_22_32 + var_22_24 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_32 + var_22_24
					end
				end

				arg_19_1.text_.text = var_22_29
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151004", "story_v_out_324151.awb") ~= 0 then
					local var_22_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151004", "story_v_out_324151.awb") / 1000

					if var_22_33 + var_22_24 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_33 + var_22_24
					end

					if var_22_28.prefab_name ~= "" and arg_19_1.actors_[var_22_28.prefab_name] ~= nil then
						local var_22_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_28.prefab_name].transform, "story_v_out_324151", "324151004", "story_v_out_324151.awb")

						arg_19_1:RecordAudio("324151004", var_22_34)
						arg_19_1:RecordAudio("324151004", var_22_34)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_324151", "324151004", "story_v_out_324151.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_324151", "324151004", "story_v_out_324151.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_35 = var_22_24 + 0.3
			local var_22_36 = math.max(var_22_25, arg_19_1.talkMaxDuration)

			if var_22_35 <= arg_19_1.time_ and arg_19_1.time_ < var_22_35 + var_22_36 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_35) / var_22_36

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_35 + var_22_36 and arg_19_1.time_ < var_22_35 + var_22_36 + arg_22_0 then
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
			local var_28_0 = "J05f"

			if arg_25_1.bgs_[var_28_0] == nil then
				local var_28_1 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_28_0)
				var_28_1.name = var_28_0
				var_28_1.transform.parent = arg_25_1.stage_.transform
				var_28_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_[var_28_0] = var_28_1
			end

			local var_28_2 = 0

			if var_28_2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				local var_28_3 = manager.ui.mainCamera.transform.localPosition
				local var_28_4 = Vector3.New(0, 0, 10) + Vector3.New(var_28_3.x, var_28_3.y, 0)
				local var_28_5 = arg_25_1.bgs_.J05f

				var_28_5.transform.localPosition = var_28_4
				var_28_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_6 = var_28_5:GetComponent("SpriteRenderer")

				if var_28_6 and var_28_6.sprite then
					local var_28_7 = (var_28_5.transform.localPosition - var_28_3).z
					local var_28_8 = manager.ui.mainCameraCom_
					local var_28_9 = 2 * var_28_7 * Mathf.Tan(var_28_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_28_10 = var_28_9 * var_28_8.aspect
					local var_28_11 = var_28_6.sprite.bounds.size.x
					local var_28_12 = var_28_6.sprite.bounds.size.y
					local var_28_13 = var_28_10 / var_28_11
					local var_28_14 = var_28_9 / var_28_12
					local var_28_15 = var_28_14 < var_28_13 and var_28_13 or var_28_14

					var_28_5.transform.localScale = Vector3.New(var_28_15, var_28_15, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "J05f" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			local var_28_17 = 0.3

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_18 = 0

			if var_28_18 < arg_25_1.time_ and arg_25_1.time_ <= var_28_18 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_19 = 1.16666666666667

			if var_28_18 <= arg_25_1.time_ and arg_25_1.time_ < var_28_18 + var_28_19 then
				local var_28_20 = (arg_25_1.time_ - var_28_18) / var_28_19
				local var_28_21 = Color.New(0, 0, 0)

				var_28_21.a = Mathf.Lerp(1, 0, var_28_20)
				arg_25_1.mask_.color = var_28_21
			end

			if arg_25_1.time_ >= var_28_18 + var_28_19 and arg_25_1.time_ < var_28_18 + var_28_19 + arg_28_0 then
				local var_28_22 = Color.New(0, 0, 0)
				local var_28_23 = 0

				arg_25_1.mask_.enabled = false
				var_28_22.a = var_28_23
				arg_25_1.mask_.color = var_28_22
			end

			local var_28_24 = 0
			local var_28_25 = 0.225

			if var_28_24 < arg_25_1.time_ and arg_25_1.time_ <= var_28_24 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_26 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_26:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_27 = arg_25_1:FormatText(StoryNameCfg[672].name)

				arg_25_1.leftNameTxt_.text = var_28_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_28 = arg_25_1:GetWordFromCfg(324151005)
				local var_28_29 = arg_25_1:FormatText(var_28_28.content)

				arg_25_1.text_.text = var_28_29

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_30 = 9
				local var_28_31 = utf8.len(var_28_29)
				local var_28_32 = var_28_30 <= 0 and var_28_25 or var_28_25 * (var_28_31 / var_28_30)

				if var_28_32 > 0 and var_28_25 < var_28_32 then
					arg_25_1.talkMaxDuration = var_28_32
					var_28_24 = var_28_24 + 0.3

					if var_28_32 + var_28_24 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_32 + var_28_24
					end
				end

				arg_25_1.text_.text = var_28_29
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151005", "story_v_out_324151.awb") ~= 0 then
					local var_28_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151005", "story_v_out_324151.awb") / 1000

					if var_28_33 + var_28_24 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_33 + var_28_24
					end

					if var_28_28.prefab_name ~= "" and arg_25_1.actors_[var_28_28.prefab_name] ~= nil then
						local var_28_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_28.prefab_name].transform, "story_v_out_324151", "324151005", "story_v_out_324151.awb")

						arg_25_1:RecordAudio("324151005", var_28_34)
						arg_25_1:RecordAudio("324151005", var_28_34)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_324151", "324151005", "story_v_out_324151.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_324151", "324151005", "story_v_out_324151.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_35 = var_28_24 + 0.3
			local var_28_36 = math.max(var_28_25, arg_25_1.talkMaxDuration)

			if var_28_35 <= arg_25_1.time_ and arg_25_1.time_ < var_28_35 + var_28_36 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_35) / var_28_36

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_35 + var_28_36 and arg_25_1.time_ < var_28_35 + var_28_36 + arg_28_0 then
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
			local var_34_0 = "ST2002"

			if arg_31_1.bgs_[var_34_0] == nil then
				local var_34_1 = Object.Instantiate(arg_31_1.paintGo_)

				var_34_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_34_0)
				var_34_1.name = var_34_0
				var_34_1.transform.parent = arg_31_1.stage_.transform
				var_34_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.bgs_[var_34_0] = var_34_1
			end

			local var_34_2 = 0

			if var_34_2 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				local var_34_3 = manager.ui.mainCamera.transform.localPosition
				local var_34_4 = Vector3.New(0, 0, 10) + Vector3.New(var_34_3.x, var_34_3.y, 0)
				local var_34_5 = arg_31_1.bgs_.ST2002

				var_34_5.transform.localPosition = var_34_4
				var_34_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_34_6 = var_34_5:GetComponent("SpriteRenderer")

				if var_34_6 and var_34_6.sprite then
					local var_34_7 = (var_34_5.transform.localPosition - var_34_3).z
					local var_34_8 = manager.ui.mainCameraCom_
					local var_34_9 = 2 * var_34_7 * Mathf.Tan(var_34_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_34_10 = var_34_9 * var_34_8.aspect
					local var_34_11 = var_34_6.sprite.bounds.size.x
					local var_34_12 = var_34_6.sprite.bounds.size.y
					local var_34_13 = var_34_10 / var_34_11
					local var_34_14 = var_34_9 / var_34_12
					local var_34_15 = var_34_14 < var_34_13 and var_34_13 or var_34_14

					var_34_5.transform.localScale = Vector3.New(var_34_15, var_34_15, 0)
				end

				for iter_34_0, iter_34_1 in pairs(arg_31_1.bgs_) do
					if iter_34_0 ~= "ST2002" then
						iter_34_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_34_16 = 0

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 then
				arg_31_1.allBtn_.enabled = false
			end

			local var_34_17 = 0.3

			if arg_31_1.time_ >= var_34_16 + var_34_17 and arg_31_1.time_ < var_34_16 + var_34_17 + arg_34_0 then
				arg_31_1.allBtn_.enabled = true
			end

			local var_34_18 = 0

			if var_34_18 < arg_31_1.time_ and arg_31_1.time_ <= var_34_18 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_19 = 2

			if var_34_18 <= arg_31_1.time_ and arg_31_1.time_ < var_34_18 + var_34_19 then
				local var_34_20 = (arg_31_1.time_ - var_34_18) / var_34_19
				local var_34_21 = Color.New(0, 0, 0)

				var_34_21.a = Mathf.Lerp(1, 0, var_34_20)
				arg_31_1.mask_.color = var_34_21
			end

			if arg_31_1.time_ >= var_34_18 + var_34_19 and arg_31_1.time_ < var_34_18 + var_34_19 + arg_34_0 then
				local var_34_22 = Color.New(0, 0, 0)
				local var_34_23 = 0

				arg_31_1.mask_.enabled = false
				var_34_22.a = var_34_23
				arg_31_1.mask_.color = var_34_22
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_24 = 0.775
			local var_34_25 = 0.225

			if var_34_24 < arg_31_1.time_ and arg_31_1.time_ <= var_34_24 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_26 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_26:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_27 = arg_31_1:FormatText(StoryNameCfg[672].name)

				arg_31_1.leftNameTxt_.text = var_34_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_28 = arg_31_1:GetWordFromCfg(324151006)
				local var_34_29 = arg_31_1:FormatText(var_34_28.content)

				arg_31_1.text_.text = var_34_29

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_30 = 9
				local var_34_31 = utf8.len(var_34_29)
				local var_34_32 = var_34_30 <= 0 and var_34_25 or var_34_25 * (var_34_31 / var_34_30)

				if var_34_32 > 0 and var_34_25 < var_34_32 then
					arg_31_1.talkMaxDuration = var_34_32
					var_34_24 = var_34_24 + 0.3

					if var_34_32 + var_34_24 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_32 + var_34_24
					end
				end

				arg_31_1.text_.text = var_34_29
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151006", "story_v_out_324151.awb") ~= 0 then
					local var_34_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151006", "story_v_out_324151.awb") / 1000

					if var_34_33 + var_34_24 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_33 + var_34_24
					end

					if var_34_28.prefab_name ~= "" and arg_31_1.actors_[var_34_28.prefab_name] ~= nil then
						local var_34_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_28.prefab_name].transform, "story_v_out_324151", "324151006", "story_v_out_324151.awb")

						arg_31_1:RecordAudio("324151006", var_34_34)
						arg_31_1:RecordAudio("324151006", var_34_34)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_324151", "324151006", "story_v_out_324151.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_324151", "324151006", "story_v_out_324151.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_35 = var_34_24 + 0.3
			local var_34_36 = math.max(var_34_25, arg_31_1.talkMaxDuration)

			if var_34_35 <= arg_31_1.time_ and arg_31_1.time_ < var_34_35 + var_34_36 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_35) / var_34_36

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_35 + var_34_36 and arg_31_1.time_ < var_34_35 + var_34_36 + arg_34_0 then
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
			local var_40_0 = "ST39"

			if arg_37_1.bgs_[var_40_0] == nil then
				local var_40_1 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_40_0)
				var_40_1.name = var_40_0
				var_40_1.transform.parent = arg_37_1.stage_.transform
				var_40_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_[var_40_0] = var_40_1
			end

			local var_40_2 = 0

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				local var_40_3 = manager.ui.mainCamera.transform.localPosition
				local var_40_4 = Vector3.New(0, 0, 10) + Vector3.New(var_40_3.x, var_40_3.y, 0)
				local var_40_5 = arg_37_1.bgs_.ST39

				var_40_5.transform.localPosition = var_40_4
				var_40_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_6 = var_40_5:GetComponent("SpriteRenderer")

				if var_40_6 and var_40_6.sprite then
					local var_40_7 = (var_40_5.transform.localPosition - var_40_3).z
					local var_40_8 = manager.ui.mainCameraCom_
					local var_40_9 = 2 * var_40_7 * Mathf.Tan(var_40_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_40_10 = var_40_9 * var_40_8.aspect
					local var_40_11 = var_40_6.sprite.bounds.size.x
					local var_40_12 = var_40_6.sprite.bounds.size.y
					local var_40_13 = var_40_10 / var_40_11
					local var_40_14 = var_40_9 / var_40_12
					local var_40_15 = var_40_14 < var_40_13 and var_40_13 or var_40_14

					var_40_5.transform.localScale = Vector3.New(var_40_15, var_40_15, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "ST39" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			local var_40_17 = 0.3

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			local var_40_18 = 0

			if var_40_18 < arg_37_1.time_ and arg_37_1.time_ <= var_40_18 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_19 = 1.3

			if var_40_18 <= arg_37_1.time_ and arg_37_1.time_ < var_40_18 + var_40_19 then
				local var_40_20 = (arg_37_1.time_ - var_40_18) / var_40_19
				local var_40_21 = Color.New(0, 0, 0)

				var_40_21.a = Mathf.Lerp(1, 0, var_40_20)
				arg_37_1.mask_.color = var_40_21
			end

			if arg_37_1.time_ >= var_40_18 + var_40_19 and arg_37_1.time_ < var_40_18 + var_40_19 + arg_40_0 then
				local var_40_22 = Color.New(0, 0, 0)
				local var_40_23 = 0

				arg_37_1.mask_.enabled = false
				var_40_22.a = var_40_23
				arg_37_1.mask_.color = var_40_22
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_24 = 0.775
			local var_40_25 = 0.225

			if var_40_24 < arg_37_1.time_ and arg_37_1.time_ <= var_40_24 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_26 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_26:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_27 = arg_37_1:FormatText(StoryNameCfg[672].name)

				arg_37_1.leftNameTxt_.text = var_40_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_28 = arg_37_1:GetWordFromCfg(324151007)
				local var_40_29 = arg_37_1:FormatText(var_40_28.content)

				arg_37_1.text_.text = var_40_29

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_30 = 9
				local var_40_31 = utf8.len(var_40_29)
				local var_40_32 = var_40_30 <= 0 and var_40_25 or var_40_25 * (var_40_31 / var_40_30)

				if var_40_32 > 0 and var_40_25 < var_40_32 then
					arg_37_1.talkMaxDuration = var_40_32
					var_40_24 = var_40_24 + 0.3

					if var_40_32 + var_40_24 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_32 + var_40_24
					end
				end

				arg_37_1.text_.text = var_40_29
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151007", "story_v_out_324151.awb") ~= 0 then
					local var_40_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151007", "story_v_out_324151.awb") / 1000

					if var_40_33 + var_40_24 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_33 + var_40_24
					end

					if var_40_28.prefab_name ~= "" and arg_37_1.actors_[var_40_28.prefab_name] ~= nil then
						local var_40_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_28.prefab_name].transform, "story_v_out_324151", "324151007", "story_v_out_324151.awb")

						arg_37_1:RecordAudio("324151007", var_40_34)
						arg_37_1:RecordAudio("324151007", var_40_34)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_324151", "324151007", "story_v_out_324151.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_324151", "324151007", "story_v_out_324151.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_35 = var_40_24 + 0.3
			local var_40_36 = math.max(var_40_25, arg_37_1.talkMaxDuration)

			if var_40_35 <= arg_37_1.time_ and arg_37_1.time_ < var_40_35 + var_40_36 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_35) / var_40_36

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_35 + var_40_36 and arg_37_1.time_ < var_40_35 + var_40_36 + arg_40_0 then
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
			local var_46_0 = "J22f"

			if arg_43_1.bgs_[var_46_0] == nil then
				local var_46_1 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_46_0)
				var_46_1.name = var_46_0
				var_46_1.transform.parent = arg_43_1.stage_.transform
				var_46_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_[var_46_0] = var_46_1
			end

			local var_46_2 = 0

			if var_46_2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				local var_46_3 = manager.ui.mainCamera.transform.localPosition
				local var_46_4 = Vector3.New(0, 0, 10) + Vector3.New(var_46_3.x, var_46_3.y, 0)
				local var_46_5 = arg_43_1.bgs_.J22f

				var_46_5.transform.localPosition = var_46_4
				var_46_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_6 = var_46_5:GetComponent("SpriteRenderer")

				if var_46_6 and var_46_6.sprite then
					local var_46_7 = (var_46_5.transform.localPosition - var_46_3).z
					local var_46_8 = manager.ui.mainCameraCom_
					local var_46_9 = 2 * var_46_7 * Mathf.Tan(var_46_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_46_10 = var_46_9 * var_46_8.aspect
					local var_46_11 = var_46_6.sprite.bounds.size.x
					local var_46_12 = var_46_6.sprite.bounds.size.y
					local var_46_13 = var_46_10 / var_46_11
					local var_46_14 = var_46_9 / var_46_12
					local var_46_15 = var_46_14 < var_46_13 and var_46_13 or var_46_14

					var_46_5.transform.localScale = Vector3.New(var_46_15, var_46_15, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "J22f" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_16 = 0

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			local var_46_17 = 0.3

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_18 = 0

			if var_46_18 < arg_43_1.time_ and arg_43_1.time_ <= var_46_18 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_19 = 1.1

			if var_46_18 <= arg_43_1.time_ and arg_43_1.time_ < var_46_18 + var_46_19 then
				local var_46_20 = (arg_43_1.time_ - var_46_18) / var_46_19
				local var_46_21 = Color.New(0, 0, 0)

				var_46_21.a = Mathf.Lerp(1, 0, var_46_20)
				arg_43_1.mask_.color = var_46_21
			end

			if arg_43_1.time_ >= var_46_18 + var_46_19 and arg_43_1.time_ < var_46_18 + var_46_19 + arg_46_0 then
				local var_46_22 = Color.New(0, 0, 0)
				local var_46_23 = 0

				arg_43_1.mask_.enabled = false
				var_46_22.a = var_46_23
				arg_43_1.mask_.color = var_46_22
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_24 = 0.666666666666667
			local var_46_25 = 0.175

			if var_46_24 < arg_43_1.time_ and arg_43_1.time_ <= var_46_24 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_26 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_26:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_27 = arg_43_1:FormatText(StoryNameCfg[672].name)

				arg_43_1.leftNameTxt_.text = var_46_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_28 = arg_43_1:GetWordFromCfg(324151008)
				local var_46_29 = arg_43_1:FormatText(var_46_28.content)

				arg_43_1.text_.text = var_46_29

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_30 = 7
				local var_46_31 = utf8.len(var_46_29)
				local var_46_32 = var_46_30 <= 0 and var_46_25 or var_46_25 * (var_46_31 / var_46_30)

				if var_46_32 > 0 and var_46_25 < var_46_32 then
					arg_43_1.talkMaxDuration = var_46_32
					var_46_24 = var_46_24 + 0.3

					if var_46_32 + var_46_24 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_32 + var_46_24
					end
				end

				arg_43_1.text_.text = var_46_29
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151008", "story_v_out_324151.awb") ~= 0 then
					local var_46_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151008", "story_v_out_324151.awb") / 1000

					if var_46_33 + var_46_24 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_33 + var_46_24
					end

					if var_46_28.prefab_name ~= "" and arg_43_1.actors_[var_46_28.prefab_name] ~= nil then
						local var_46_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_28.prefab_name].transform, "story_v_out_324151", "324151008", "story_v_out_324151.awb")

						arg_43_1:RecordAudio("324151008", var_46_34)
						arg_43_1:RecordAudio("324151008", var_46_34)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_324151", "324151008", "story_v_out_324151.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_324151", "324151008", "story_v_out_324151.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_35 = var_46_24 + 0.3
			local var_46_36 = math.max(var_46_25, arg_43_1.talkMaxDuration)

			if var_46_35 <= arg_43_1.time_ and arg_43_1.time_ < var_46_35 + var_46_36 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_35) / var_46_36

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_35 + var_46_36 and arg_43_1.time_ < var_46_35 + var_46_36 + arg_46_0 then
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
			local var_52_0 = 0
			local var_52_1 = 0.05

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(324151009)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 2
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
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
			local var_56_0 = 0
			local var_56_1 = 1

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				local var_56_2 = "play"
				local var_56_3 = "music"

				arg_53_1:AudioAction(var_56_2, var_56_3, "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_56_4 = ""
				local var_56_5 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

				if var_56_5 ~= "" then
					if arg_53_1.bgmTxt_.text ~= var_56_5 and arg_53_1.bgmTxt_.text ~= "" then
						if arg_53_1.bgmTxt2_.text ~= "" then
							arg_53_1.bgmTxt_.text = arg_53_1.bgmTxt2_.text
						end

						arg_53_1.bgmTxt2_.text = var_56_5

						arg_53_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_53_1.bgmTxt_.text = var_56_5
						arg_53_1.bgmTxt2_.text = var_56_5
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

			local var_56_6 = 0
			local var_56_7 = 1.375

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(324151010)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 55
				local var_56_11 = utf8.len(var_56_9)
				local var_56_12 = var_56_10 <= 0 and var_56_7 or var_56_7 * (var_56_11 / var_56_10)

				if var_56_12 > 0 and var_56_7 < var_56_12 then
					arg_53_1.talkMaxDuration = var_56_12

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_13 and arg_53_1.time_ < var_56_6 + var_56_13 + arg_56_0 then
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
			local var_61_0 = "10171ui_story"

			if arg_58_1.actors_[var_61_0] == nil then
				local var_61_1 = Asset.Load("Char/" .. "10171ui_story")

				if not isNil(var_61_1) then
					local var_61_2 = Object.Instantiate(Asset.Load("Char/" .. "10171ui_story"), arg_58_1.stage_.transform)

					var_61_2.name = var_61_0
					var_61_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_58_1.actors_[var_61_0] = var_61_2

					local var_61_3 = var_61_2:GetComponentInChildren(typeof(CharacterEffect))

					var_61_3.enabled = true

					local var_61_4 = GameObjectTools.GetOrAddComponent(var_61_2, typeof(DynamicBoneHelper))

					if var_61_4 then
						var_61_4:EnableDynamicBone(false)
					end

					arg_58_1:ShowWeapon(var_61_3.transform, false)

					arg_58_1.var_[var_61_0 .. "Animator"] = var_61_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_58_1.var_[var_61_0 .. "Animator"].applyRootMotion = true
					arg_58_1.var_[var_61_0 .. "LipSync"] = var_61_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_61_5 = arg_58_1.actors_["10171ui_story"].transform
			local var_61_6 = 2.33333333333333

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.var_.moveOldPos10171ui_story = var_61_5.localPosition

				local var_61_7 = GameObjectTools.GetOrAddComponent(var_61_5.gameObject, typeof(DynamicBoneHelper))

				if var_61_7 then
					var_61_7:EnableDynamicBone(false)
				end
			end

			local var_61_8 = 0.001

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_8 then
				local var_61_9 = (arg_58_1.time_ - var_61_6) / var_61_8
				local var_61_10 = Vector3.New(0, -0.95, -6.05)

				var_61_5.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10171ui_story, var_61_10, var_61_9)

				local var_61_11 = manager.ui.mainCamera.transform.position - var_61_5.position

				var_61_5.forward = Vector3.New(var_61_11.x, var_61_11.y, var_61_11.z)

				local var_61_12 = var_61_5.localEulerAngles

				var_61_12.z = 0
				var_61_12.x = 0
				var_61_5.localEulerAngles = var_61_12
			end

			if arg_58_1.time_ >= var_61_6 + var_61_8 and arg_58_1.time_ < var_61_6 + var_61_8 + arg_61_0 then
				var_61_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_61_13 = manager.ui.mainCamera.transform.position - var_61_5.position

				var_61_5.forward = Vector3.New(var_61_13.x, var_61_13.y, var_61_13.z)

				local var_61_14 = var_61_5.localEulerAngles

				var_61_14.z = 0
				var_61_14.x = 0
				var_61_5.localEulerAngles = var_61_14

				local var_61_15 = GameObjectTools.GetOrAddComponent(var_61_5.gameObject, typeof(DynamicBoneHelper))

				if var_61_15 then
					var_61_15:EnableDynamicBone(true)
				end
			end

			local var_61_16 = arg_58_1.actors_["10171ui_story"]
			local var_61_17 = 2.33333333333333

			if var_61_17 < arg_58_1.time_ and arg_58_1.time_ <= var_61_17 + arg_61_0 and not isNil(var_61_16) and arg_58_1.var_.characterEffect10171ui_story == nil then
				arg_58_1.var_.characterEffect10171ui_story = var_61_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_18 = 0.200000002980232

			if var_61_17 <= arg_58_1.time_ and arg_58_1.time_ < var_61_17 + var_61_18 and not isNil(var_61_16) then
				local var_61_19 = (arg_58_1.time_ - var_61_17) / var_61_18

				if arg_58_1.var_.characterEffect10171ui_story and not isNil(var_61_16) then
					arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_17 + var_61_18 and arg_58_1.time_ < var_61_17 + var_61_18 + arg_61_0 and not isNil(var_61_16) and arg_58_1.var_.characterEffect10171ui_story then
				arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_61_20 = 2.33333333333333

			if var_61_20 < arg_58_1.time_ and arg_58_1.time_ <= var_61_20 + arg_61_0 then
				arg_58_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_61_21 = 2.33333333333333

			if var_61_21 < arg_58_1.time_ and arg_58_1.time_ <= var_61_21 + arg_61_0 then
				arg_58_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_61_22 = 0

			if var_61_22 < arg_58_1.time_ and arg_58_1.time_ <= var_61_22 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_23 = 0.933333333333333

			if var_61_22 <= arg_58_1.time_ and arg_58_1.time_ < var_61_22 + var_61_23 then
				local var_61_24 = (arg_58_1.time_ - var_61_22) / var_61_23
				local var_61_25 = Color.New(0, 0, 0)

				var_61_25.a = Mathf.Lerp(0, 1, var_61_24)
				arg_58_1.mask_.color = var_61_25
			end

			if arg_58_1.time_ >= var_61_22 + var_61_23 and arg_58_1.time_ < var_61_22 + var_61_23 + arg_61_0 then
				local var_61_26 = Color.New(0, 0, 0)

				var_61_26.a = 1
				arg_58_1.mask_.color = var_61_26
			end

			local var_61_27 = 0.933333333333333

			if var_61_27 < arg_58_1.time_ and arg_58_1.time_ <= var_61_27 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_28 = 1.76666666666667

			if var_61_27 <= arg_58_1.time_ and arg_58_1.time_ < var_61_27 + var_61_28 then
				local var_61_29 = (arg_58_1.time_ - var_61_27) / var_61_28
				local var_61_30 = Color.New(0, 0, 0)

				var_61_30.a = Mathf.Lerp(1, 0, var_61_29)
				arg_58_1.mask_.color = var_61_30
			end

			if arg_58_1.time_ >= var_61_27 + var_61_28 and arg_58_1.time_ < var_61_27 + var_61_28 + arg_61_0 then
				local var_61_31 = Color.New(0, 0, 0)
				local var_61_32 = 0

				arg_58_1.mask_.enabled = false
				var_61_31.a = var_61_32
				arg_58_1.mask_.color = var_61_31
			end

			local var_61_33 = manager.ui.mainCamera.transform
			local var_61_34 = 0.933333333333333

			if var_61_34 < arg_58_1.time_ and arg_58_1.time_ <= var_61_34 + arg_61_0 then
				local var_61_35 = arg_58_1.var_.effect2323

				if var_61_35 then
					Object.Destroy(var_61_35)

					arg_58_1.var_.effect2323 = nil
				end
			end

			local var_61_36 = manager.ui.mainCamera.transform
			local var_61_37 = 0.933333333333333

			if var_61_37 < arg_58_1.time_ and arg_58_1.time_ <= var_61_37 + arg_61_0 then
				local var_61_38 = arg_58_1.var_.effect3242

				if var_61_38 then
					Object.Destroy(var_61_38)

					arg_58_1.var_.effect3242 = nil
				end
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_39 = 2.7
			local var_61_40 = 0.2

			if var_61_39 < arg_58_1.time_ and arg_58_1.time_ <= var_61_39 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_41 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_41:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_42 = arg_58_1:FormatText(StoryNameCfg[1451].name)

				arg_58_1.leftNameTxt_.text = var_61_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_43 = arg_58_1:GetWordFromCfg(324151011)
				local var_61_44 = arg_58_1:FormatText(var_61_43.content)

				arg_58_1.text_.text = var_61_44

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_45 = 8
				local var_61_46 = utf8.len(var_61_44)
				local var_61_47 = var_61_45 <= 0 and var_61_40 or var_61_40 * (var_61_46 / var_61_45)

				if var_61_47 > 0 and var_61_40 < var_61_47 then
					arg_58_1.talkMaxDuration = var_61_47
					var_61_39 = var_61_39 + 0.3

					if var_61_47 + var_61_39 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_47 + var_61_39
					end
				end

				arg_58_1.text_.text = var_61_44
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151011", "story_v_out_324151.awb") ~= 0 then
					local var_61_48 = manager.audio:GetVoiceLength("story_v_out_324151", "324151011", "story_v_out_324151.awb") / 1000

					if var_61_48 + var_61_39 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_48 + var_61_39
					end

					if var_61_43.prefab_name ~= "" and arg_58_1.actors_[var_61_43.prefab_name] ~= nil then
						local var_61_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_43.prefab_name].transform, "story_v_out_324151", "324151011", "story_v_out_324151.awb")

						arg_58_1:RecordAudio("324151011", var_61_49)
						arg_58_1:RecordAudio("324151011", var_61_49)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_324151", "324151011", "story_v_out_324151.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_324151", "324151011", "story_v_out_324151.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_50 = var_61_39 + 0.3
			local var_61_51 = math.max(var_61_40, arg_58_1.talkMaxDuration)

			if var_61_50 <= arg_58_1.time_ and arg_58_1.time_ < var_61_50 + var_61_51 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_50) / var_61_51

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_50 + var_61_51 and arg_58_1.time_ < var_61_50 + var_61_51 + arg_61_0 then
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
			local var_67_0 = arg_64_1.actors_["10171ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos10171ui_story = var_67_0.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_3 then
				local var_67_4 = (arg_64_1.time_ - var_67_1) / var_67_3
				local var_67_5 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10171ui_story, var_67_5, var_67_4)

				local var_67_6 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_6.x, var_67_6.y, var_67_6.z)

				local var_67_7 = var_67_0.localEulerAngles

				var_67_7.z = 0
				var_67_7.x = 0
				var_67_0.localEulerAngles = var_67_7
			end

			if arg_64_1.time_ >= var_67_1 + var_67_3 and arg_64_1.time_ < var_67_1 + var_67_3 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_8 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_8.x, var_67_8.y, var_67_8.z)

				local var_67_9 = var_67_0.localEulerAngles

				var_67_9.z = 0
				var_67_9.x = 0
				var_67_0.localEulerAngles = var_67_9

				local var_67_10 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_10 then
					var_67_10:EnableDynamicBone(true)
				end
			end

			local var_67_11 = arg_64_1.actors_["10171ui_story"]
			local var_67_12 = 0

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 and not isNil(var_67_11) and arg_64_1.var_.characterEffect10171ui_story == nil then
				arg_64_1.var_.characterEffect10171ui_story = var_67_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_13 = 0.200000002980232

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_13 and not isNil(var_67_11) then
				local var_67_14 = (arg_64_1.time_ - var_67_12) / var_67_13

				if arg_64_1.var_.characterEffect10171ui_story and not isNil(var_67_11) then
					local var_67_15 = Mathf.Lerp(0, 0.5, var_67_14)

					arg_64_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10171ui_story.fillRatio = var_67_15
				end
			end

			if arg_64_1.time_ >= var_67_12 + var_67_13 and arg_64_1.time_ < var_67_12 + var_67_13 + arg_67_0 and not isNil(var_67_11) and arg_64_1.var_.characterEffect10171ui_story then
				local var_67_16 = 0.5

				arg_64_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10171ui_story.fillRatio = var_67_16
			end

			local var_67_17 = 0
			local var_67_18 = 1.55

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_19 = arg_64_1:GetWordFromCfg(324151012)
				local var_67_20 = arg_64_1:FormatText(var_67_19.content)

				arg_64_1.text_.text = var_67_20

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_21 = 62
				local var_67_22 = utf8.len(var_67_20)
				local var_67_23 = var_67_21 <= 0 and var_67_18 or var_67_18 * (var_67_22 / var_67_21)

				if var_67_23 > 0 and var_67_18 < var_67_23 then
					arg_64_1.talkMaxDuration = var_67_23

					if var_67_23 + var_67_17 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_17
					end
				end

				arg_64_1.text_.text = var_67_20
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_24 = math.max(var_67_18, arg_64_1.talkMaxDuration)

			if var_67_17 <= arg_64_1.time_ and arg_64_1.time_ < var_67_17 + var_67_24 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_17) / var_67_24

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_17 + var_67_24 and arg_64_1.time_ < var_67_17 + var_67_24 + arg_67_0 then
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
			local var_71_0 = 0
			local var_71_1 = 0.4

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[1468].name)

				arg_68_1.leftNameTxt_.text = var_71_2

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

				local var_71_3 = arg_68_1:GetWordFromCfg(324151013)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 16
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151013", "story_v_out_324151.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151013", "story_v_out_324151.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_324151", "324151013", "story_v_out_324151.awb")

						arg_68_1:RecordAudio("324151013", var_71_9)
						arg_68_1:RecordAudio("324151013", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324151", "324151013", "story_v_out_324151.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324151", "324151013", "story_v_out_324151.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_10 and arg_68_1.time_ < var_71_0 + var_71_10 + arg_71_0 then
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
			local var_75_0 = arg_72_1.actors_["10171ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos10171ui_story = var_75_0.localPosition

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end
			end

			local var_75_3 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_3 then
				local var_75_4 = (arg_72_1.time_ - var_75_1) / var_75_3
				local var_75_5 = Vector3.New(0, -0.95, -6.05)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10171ui_story, var_75_5, var_75_4)

				local var_75_6 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_6.x, var_75_6.y, var_75_6.z)

				local var_75_7 = var_75_0.localEulerAngles

				var_75_7.z = 0
				var_75_7.x = 0
				var_75_0.localEulerAngles = var_75_7
			end

			if arg_72_1.time_ >= var_75_1 + var_75_3 and arg_72_1.time_ < var_75_1 + var_75_3 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_75_8 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_8.x, var_75_8.y, var_75_8.z)

				local var_75_9 = var_75_0.localEulerAngles

				var_75_9.z = 0
				var_75_9.x = 0
				var_75_0.localEulerAngles = var_75_9

				local var_75_10 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_10 then
					var_75_10:EnableDynamicBone(true)
				end
			end

			local var_75_11 = arg_72_1.actors_["10171ui_story"]
			local var_75_12 = 0

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 and not isNil(var_75_11) and arg_72_1.var_.characterEffect10171ui_story == nil then
				arg_72_1.var_.characterEffect10171ui_story = var_75_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_13 = 0.200000002980232

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_13 and not isNil(var_75_11) then
				local var_75_14 = (arg_72_1.time_ - var_75_12) / var_75_13

				if arg_72_1.var_.characterEffect10171ui_story and not isNil(var_75_11) then
					arg_72_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_12 + var_75_13 and arg_72_1.time_ < var_75_12 + var_75_13 + arg_75_0 and not isNil(var_75_11) and arg_72_1.var_.characterEffect10171ui_story then
				arg_72_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_75_15 = 0

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_75_17 = 0
			local var_75_18 = 0.225

			if var_75_17 < arg_72_1.time_ and arg_72_1.time_ <= var_75_17 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_19 = arg_72_1:FormatText(StoryNameCfg[1451].name)

				arg_72_1.leftNameTxt_.text = var_75_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_20 = arg_72_1:GetWordFromCfg(324151014)
				local var_75_21 = arg_72_1:FormatText(var_75_20.content)

				arg_72_1.text_.text = var_75_21

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_22 = 9
				local var_75_23 = utf8.len(var_75_21)
				local var_75_24 = var_75_22 <= 0 and var_75_18 or var_75_18 * (var_75_23 / var_75_22)

				if var_75_24 > 0 and var_75_18 < var_75_24 then
					arg_72_1.talkMaxDuration = var_75_24

					if var_75_24 + var_75_17 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_24 + var_75_17
					end
				end

				arg_72_1.text_.text = var_75_21
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151014", "story_v_out_324151.awb") ~= 0 then
					local var_75_25 = manager.audio:GetVoiceLength("story_v_out_324151", "324151014", "story_v_out_324151.awb") / 1000

					if var_75_25 + var_75_17 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_25 + var_75_17
					end

					if var_75_20.prefab_name ~= "" and arg_72_1.actors_[var_75_20.prefab_name] ~= nil then
						local var_75_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_20.prefab_name].transform, "story_v_out_324151", "324151014", "story_v_out_324151.awb")

						arg_72_1:RecordAudio("324151014", var_75_26)
						arg_72_1:RecordAudio("324151014", var_75_26)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324151", "324151014", "story_v_out_324151.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324151", "324151014", "story_v_out_324151.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_27 = math.max(var_75_18, arg_72_1.talkMaxDuration)

			if var_75_17 <= arg_72_1.time_ and arg_72_1.time_ < var_75_17 + var_75_27 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_17) / var_75_27

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_17 + var_75_27 and arg_72_1.time_ < var_75_17 + var_75_27 + arg_75_0 then
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
			local var_79_0 = arg_76_1.actors_["10171ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10171ui_story == nil then
				arg_76_1.var_.characterEffect10171ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect10171ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_76_1.var_.characterEffect10171ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10171ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_76_1.var_.characterEffect10171ui_story.fillRatio = var_79_5
			end

			local var_79_6 = 0
			local var_79_7 = 0.6

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[1468].name)

				arg_76_1.leftNameTxt_.text = var_79_8

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

				local var_79_9 = arg_76_1:GetWordFromCfg(324151015)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 24
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151015", "story_v_out_324151.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151015", "story_v_out_324151.awb") / 1000

					if var_79_14 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_6
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_out_324151", "324151015", "story_v_out_324151.awb")

						arg_76_1:RecordAudio("324151015", var_79_15)
						arg_76_1:RecordAudio("324151015", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_324151", "324151015", "story_v_out_324151.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_324151", "324151015", "story_v_out_324151.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_16 and arg_76_1.time_ < var_79_6 + var_79_16 + arg_79_0 then
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
			local var_83_0 = arg_80_1.actors_["10171ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10171ui_story == nil then
				arg_80_1.var_.characterEffect10171ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect10171ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10171ui_story then
				arg_80_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_83_4 = 0
			local var_83_5 = 0.5

			if var_83_4 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_6 = arg_80_1:FormatText(StoryNameCfg[1451].name)

				arg_80_1.leftNameTxt_.text = var_83_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:GetWordFromCfg(324151016)
				local var_83_8 = arg_80_1:FormatText(var_83_7.content)

				arg_80_1.text_.text = var_83_8

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 20
				local var_83_10 = utf8.len(var_83_8)
				local var_83_11 = var_83_9 <= 0 and var_83_5 or var_83_5 * (var_83_10 / var_83_9)

				if var_83_11 > 0 and var_83_5 < var_83_11 then
					arg_80_1.talkMaxDuration = var_83_11

					if var_83_11 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_8
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151016", "story_v_out_324151.awb") ~= 0 then
					local var_83_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151016", "story_v_out_324151.awb") / 1000

					if var_83_12 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_12 + var_83_4
					end

					if var_83_7.prefab_name ~= "" and arg_80_1.actors_[var_83_7.prefab_name] ~= nil then
						local var_83_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_7.prefab_name].transform, "story_v_out_324151", "324151016", "story_v_out_324151.awb")

						arg_80_1:RecordAudio("324151016", var_83_13)
						arg_80_1:RecordAudio("324151016", var_83_13)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_324151", "324151016", "story_v_out_324151.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_324151", "324151016", "story_v_out_324151.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_14 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_14

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_14 and arg_80_1.time_ < var_83_4 + var_83_14 + arg_83_0 then
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
			local var_87_0 = arg_84_1.actors_["10171ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10171ui_story == nil then
				arg_84_1.var_.characterEffect10171ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect10171ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10171ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10171ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10171ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 0.875

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[1468].name)

				arg_84_1.leftNameTxt_.text = var_87_8

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

				local var_87_9 = arg_84_1:GetWordFromCfg(324151017)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 35
				local var_87_12 = utf8.len(var_87_10)
				local var_87_13 = var_87_11 <= 0 and var_87_7 or var_87_7 * (var_87_12 / var_87_11)

				if var_87_13 > 0 and var_87_7 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151017", "story_v_out_324151.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151017", "story_v_out_324151.awb") / 1000

					if var_87_14 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_6
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_324151", "324151017", "story_v_out_324151.awb")

						arg_84_1:RecordAudio("324151017", var_87_15)
						arg_84_1:RecordAudio("324151017", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324151", "324151017", "story_v_out_324151.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324151", "324151017", "story_v_out_324151.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_16 and arg_84_1.time_ < var_87_6 + var_87_16 + arg_87_0 then
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
			local var_91_0 = arg_88_1.actors_["10171ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10171ui_story == nil then
				arg_88_1.var_.characterEffect10171ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect10171ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10171ui_story then
				arg_88_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_2")
			end

			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_91_6 = 0
			local var_91_7 = 0.875

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[1451].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_9 = arg_88_1:GetWordFromCfg(324151018)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 35
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151018", "story_v_out_324151.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151018", "story_v_out_324151.awb") / 1000

					if var_91_14 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_6
					end

					if var_91_9.prefab_name ~= "" and arg_88_1.actors_[var_91_9.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_9.prefab_name].transform, "story_v_out_324151", "324151018", "story_v_out_324151.awb")

						arg_88_1:RecordAudio("324151018", var_91_15)
						arg_88_1:RecordAudio("324151018", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_324151", "324151018", "story_v_out_324151.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_324151", "324151018", "story_v_out_324151.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_16 and arg_88_1.time_ < var_91_6 + var_91_16 + arg_91_0 then
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
			local var_95_0 = arg_92_1.actors_["10171ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos10171ui_story = var_95_0.localPosition

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end
			end

			local var_95_3 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_3 then
				local var_95_4 = (arg_92_1.time_ - var_95_1) / var_95_3
				local var_95_5 = Vector3.New(0, 100, 0)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10171ui_story, var_95_5, var_95_4)

				local var_95_6 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_6.x, var_95_6.y, var_95_6.z)

				local var_95_7 = var_95_0.localEulerAngles

				var_95_7.z = 0
				var_95_7.x = 0
				var_95_0.localEulerAngles = var_95_7
			end

			if arg_92_1.time_ >= var_95_1 + var_95_3 and arg_92_1.time_ < var_95_1 + var_95_3 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, 100, 0)

				local var_95_8 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_8.x, var_95_8.y, var_95_8.z)

				local var_95_9 = var_95_0.localEulerAngles

				var_95_9.z = 0
				var_95_9.x = 0
				var_95_0.localEulerAngles = var_95_9

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(true)
				end
			end

			local var_95_11 = arg_92_1.actors_["10171ui_story"]
			local var_95_12 = 0

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect10171ui_story == nil then
				arg_92_1.var_.characterEffect10171ui_story = var_95_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_13 = 0.200000002980232

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_13 and not isNil(var_95_11) then
				local var_95_14 = (arg_92_1.time_ - var_95_12) / var_95_13

				if arg_92_1.var_.characterEffect10171ui_story and not isNil(var_95_11) then
					local var_95_15 = Mathf.Lerp(0, 0.5, var_95_14)

					arg_92_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10171ui_story.fillRatio = var_95_15
				end
			end

			if arg_92_1.time_ >= var_95_12 + var_95_13 and arg_92_1.time_ < var_95_12 + var_95_13 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect10171ui_story then
				local var_95_16 = 0.5

				arg_92_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10171ui_story.fillRatio = var_95_16
			end

			local var_95_17 = 0.1
			local var_95_18 = 1

			if var_95_17 < arg_92_1.time_ and arg_92_1.time_ <= var_95_17 + arg_95_0 then
				local var_95_19 = "play"
				local var_95_20 = "effect"

				arg_92_1:AudioAction(var_95_19, var_95_20, "se_story_142", "se_story_142_chopper01", "")
			end

			local var_95_21 = 0
			local var_95_22 = 0.825

			if var_95_21 < arg_92_1.time_ and arg_92_1.time_ <= var_95_21 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_23 = arg_92_1:GetWordFromCfg(324151019)
				local var_95_24 = arg_92_1:FormatText(var_95_23.content)

				arg_92_1.text_.text = var_95_24

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_25 = 33
				local var_95_26 = utf8.len(var_95_24)
				local var_95_27 = var_95_25 <= 0 and var_95_22 or var_95_22 * (var_95_26 / var_95_25)

				if var_95_27 > 0 and var_95_22 < var_95_27 then
					arg_92_1.talkMaxDuration = var_95_27

					if var_95_27 + var_95_21 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_27 + var_95_21
					end
				end

				arg_92_1.text_.text = var_95_24
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_28 = math.max(var_95_22, arg_92_1.talkMaxDuration)

			if var_95_21 <= arg_92_1.time_ and arg_92_1.time_ < var_95_21 + var_95_28 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_21) / var_95_28

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_21 + var_95_28 and arg_92_1.time_ < var_95_21 + var_95_28 + arg_95_0 then
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
			local var_99_0 = 0
			local var_99_1 = 0.45

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[672].name)

				arg_96_1.leftNameTxt_.text = var_99_2

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

				local var_99_3 = arg_96_1:GetWordFromCfg(324151020)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 18
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151020", "story_v_out_324151.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151020", "story_v_out_324151.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_324151", "324151020", "story_v_out_324151.awb")

						arg_96_1:RecordAudio("324151020", var_99_9)
						arg_96_1:RecordAudio("324151020", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_324151", "324151020", "story_v_out_324151.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_324151", "324151020", "story_v_out_324151.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_10 and arg_96_1.time_ < var_99_0 + var_99_10 + arg_99_0 then
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
			local var_103_0 = 0
			local var_103_1 = 1.025

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_2 = arg_100_1:GetWordFromCfg(324151021)
				local var_103_3 = arg_100_1:FormatText(var_103_2.content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 41
				local var_103_5 = utf8.len(var_103_3)
				local var_103_6 = var_103_4 <= 0 and var_103_1 or var_103_1 * (var_103_5 / var_103_4)

				if var_103_6 > 0 and var_103_1 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_7 and arg_100_1.time_ < var_103_0 + var_103_7 + arg_103_0 then
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
			local var_107_0 = 0
			local var_107_1 = 1.675

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(324151022)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 67
				local var_107_5 = utf8.len(var_107_3)
				local var_107_6 = var_107_4 <= 0 and var_107_1 or var_107_1 * (var_107_5 / var_107_4)

				if var_107_6 > 0 and var_107_1 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_7 and arg_104_1.time_ < var_107_0 + var_107_7 + arg_107_0 then
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
			local var_111_0 = 0
			local var_111_1 = 1.275

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(324151023)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 51
				local var_111_5 = utf8.len(var_111_3)
				local var_111_6 = var_111_4 <= 0 and var_111_1 or var_111_1 * (var_111_5 / var_111_4)

				if var_111_6 > 0 and var_111_1 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_7 and arg_108_1.time_ < var_111_0 + var_111_7 + arg_111_0 then
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
			local var_115_0 = arg_112_1.actors_["10171ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10171ui_story == nil then
				arg_112_1.var_.characterEffect10171ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect10171ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10171ui_story then
				arg_112_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_115_4 = 0
			local var_115_5 = 0.2

			if var_115_4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_6 = arg_112_1:FormatText(StoryNameCfg[1451].name)

				arg_112_1.leftNameTxt_.text = var_115_6

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

				local var_115_7 = arg_112_1:GetWordFromCfg(324151024)
				local var_115_8 = arg_112_1:FormatText(var_115_7.content)

				arg_112_1.text_.text = var_115_8

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 8
				local var_115_10 = utf8.len(var_115_8)
				local var_115_11 = var_115_9 <= 0 and var_115_5 or var_115_5 * (var_115_10 / var_115_9)

				if var_115_11 > 0 and var_115_5 < var_115_11 then
					arg_112_1.talkMaxDuration = var_115_11

					if var_115_11 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_11 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_8
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151024", "story_v_out_324151.awb") ~= 0 then
					local var_115_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151024", "story_v_out_324151.awb") / 1000

					if var_115_12 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_4
					end

					if var_115_7.prefab_name ~= "" and arg_112_1.actors_[var_115_7.prefab_name] ~= nil then
						local var_115_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_7.prefab_name].transform, "story_v_out_324151", "324151024", "story_v_out_324151.awb")

						arg_112_1:RecordAudio("324151024", var_115_13)
						arg_112_1:RecordAudio("324151024", var_115_13)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_324151", "324151024", "story_v_out_324151.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_324151", "324151024", "story_v_out_324151.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_14 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_14 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_14

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_14 and arg_112_1.time_ < var_115_4 + var_115_14 + arg_115_0 then
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
			local var_119_0 = arg_116_1.actors_["10171ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10171ui_story == nil then
				arg_116_1.var_.characterEffect10171ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect10171ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_116_1.var_.characterEffect10171ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10171ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_116_1.var_.characterEffect10171ui_story.fillRatio = var_119_5
			end

			local var_119_6 = 0
			local var_119_7 = 0.9

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_8 = arg_116_1:GetWordFromCfg(324151025)
				local var_119_9 = arg_116_1:FormatText(var_119_8.content)

				arg_116_1.text_.text = var_119_9

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_10 = 36
				local var_119_11 = utf8.len(var_119_9)
				local var_119_12 = var_119_10 <= 0 and var_119_7 or var_119_7 * (var_119_11 / var_119_10)

				if var_119_12 > 0 and var_119_7 < var_119_12 then
					arg_116_1.talkMaxDuration = var_119_12

					if var_119_12 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_12 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_9
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_13 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_13 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_13

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_13 and arg_116_1.time_ < var_119_6 + var_119_13 + arg_119_0 then
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
			local var_123_0 = arg_120_1.actors_["10171ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect10171ui_story == nil then
				arg_120_1.var_.characterEffect10171ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect10171ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect10171ui_story then
				arg_120_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_123_4 = 0
			local var_123_5 = 0.6

			if var_123_4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_6 = arg_120_1:FormatText(StoryNameCfg[1451].name)

				arg_120_1.leftNameTxt_.text = var_123_6

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

				local var_123_7 = arg_120_1:GetWordFromCfg(324151026)
				local var_123_8 = arg_120_1:FormatText(var_123_7.content)

				arg_120_1.text_.text = var_123_8

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 24
				local var_123_10 = utf8.len(var_123_8)
				local var_123_11 = var_123_9 <= 0 and var_123_5 or var_123_5 * (var_123_10 / var_123_9)

				if var_123_11 > 0 and var_123_5 < var_123_11 then
					arg_120_1.talkMaxDuration = var_123_11

					if var_123_11 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_8
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151026", "story_v_out_324151.awb") ~= 0 then
					local var_123_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151026", "story_v_out_324151.awb") / 1000

					if var_123_12 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_4
					end

					if var_123_7.prefab_name ~= "" and arg_120_1.actors_[var_123_7.prefab_name] ~= nil then
						local var_123_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_7.prefab_name].transform, "story_v_out_324151", "324151026", "story_v_out_324151.awb")

						arg_120_1:RecordAudio("324151026", var_123_13)
						arg_120_1:RecordAudio("324151026", var_123_13)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_324151", "324151026", "story_v_out_324151.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_324151", "324151026", "story_v_out_324151.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_14 and arg_120_1.time_ < var_123_4 + var_123_14 + arg_123_0 then
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
			local var_127_0 = arg_124_1.actors_["10171ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10171ui_story == nil then
				arg_124_1.var_.characterEffect10171ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect10171ui_story and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10171ui_story.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10171ui_story then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10171ui_story.fillRatio = var_127_5
			end

			local var_127_6 = 0.5
			local var_127_7 = 1

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				local var_127_8 = "play"
				local var_127_9 = "effect"

				arg_124_1:AudioAction(var_127_8, var_127_9, "se_story_150", "se_story_150_sword04", "")
			end

			local var_127_10 = 0
			local var_127_11 = 1.725

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_12 = arg_124_1:GetWordFromCfg(324151027)
				local var_127_13 = arg_124_1:FormatText(var_127_12.content)

				arg_124_1.text_.text = var_127_13

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_14 = 69
				local var_127_15 = utf8.len(var_127_13)
				local var_127_16 = var_127_14 <= 0 and var_127_11 or var_127_11 * (var_127_15 / var_127_14)

				if var_127_16 > 0 and var_127_11 < var_127_16 then
					arg_124_1.talkMaxDuration = var_127_16

					if var_127_16 + var_127_10 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_16 + var_127_10
					end
				end

				arg_124_1.text_.text = var_127_13
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_17 = math.max(var_127_11, arg_124_1.talkMaxDuration)

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_17 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_10) / var_127_17

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_10 + var_127_17 and arg_124_1.time_ < var_127_10 + var_127_17 + arg_127_0 then
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
			local var_131_0 = arg_128_1.actors_["10171ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10171ui_story == nil then
				arg_128_1.var_.characterEffect10171ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect10171ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10171ui_story then
				arg_128_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_131_4 = 0
			local var_131_5 = 0.675

			if var_131_4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_6 = arg_128_1:FormatText(StoryNameCfg[1451].name)

				arg_128_1.leftNameTxt_.text = var_131_6

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

				local var_131_7 = arg_128_1:GetWordFromCfg(324151028)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 27
				local var_131_10 = utf8.len(var_131_8)
				local var_131_11 = var_131_9 <= 0 and var_131_5 or var_131_5 * (var_131_10 / var_131_9)

				if var_131_11 > 0 and var_131_5 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151028", "story_v_out_324151.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151028", "story_v_out_324151.awb") / 1000

					if var_131_12 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_4
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_324151", "324151028", "story_v_out_324151.awb")

						arg_128_1:RecordAudio("324151028", var_131_13)
						arg_128_1:RecordAudio("324151028", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324151", "324151028", "story_v_out_324151.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324151", "324151028", "story_v_out_324151.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_14 and arg_128_1.time_ < var_131_4 + var_131_14 + arg_131_0 then
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
			local var_135_0 = "ST41"

			if arg_132_1.bgs_[var_135_0] == nil then
				local var_135_1 = Object.Instantiate(arg_132_1.paintGo_)

				var_135_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_135_0)
				var_135_1.name = var_135_0
				var_135_1.transform.parent = arg_132_1.stage_.transform
				var_135_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.bgs_[var_135_0] = var_135_1
			end

			local var_135_2 = 1.20163297123897

			if var_135_2 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
				local var_135_3 = manager.ui.mainCamera.transform.localPosition
				local var_135_4 = Vector3.New(0, 0, 10) + Vector3.New(var_135_3.x, var_135_3.y, 0)
				local var_135_5 = arg_132_1.bgs_.ST41

				var_135_5.transform.localPosition = var_135_4
				var_135_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_135_6 = var_135_5:GetComponent("SpriteRenderer")

				if var_135_6 and var_135_6.sprite then
					local var_135_7 = (var_135_5.transform.localPosition - var_135_3).z
					local var_135_8 = manager.ui.mainCameraCom_
					local var_135_9 = 2 * var_135_7 * Mathf.Tan(var_135_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_135_10 = var_135_9 * var_135_8.aspect
					local var_135_11 = var_135_6.sprite.bounds.size.x
					local var_135_12 = var_135_6.sprite.bounds.size.y
					local var_135_13 = var_135_10 / var_135_11
					local var_135_14 = var_135_9 / var_135_12
					local var_135_15 = var_135_14 < var_135_13 and var_135_13 or var_135_14

					var_135_5.transform.localScale = Vector3.New(var_135_15, var_135_15, 0)
				end

				for iter_135_0, iter_135_1 in pairs(arg_132_1.bgs_) do
					if iter_135_0 ~= "ST41" then
						iter_135_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_135_16 = 3.33333333333333

			if var_135_16 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				arg_132_1.allBtn_.enabled = false
			end

			local var_135_17 = 0.3

			if arg_132_1.time_ >= var_135_16 + var_135_17 and arg_132_1.time_ < var_135_16 + var_135_17 + arg_135_0 then
				arg_132_1.allBtn_.enabled = true
			end

			local var_135_18 = 0

			if var_135_18 < arg_132_1.time_ and arg_132_1.time_ <= var_135_18 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_19 = 1.20163297123897

			if var_135_18 <= arg_132_1.time_ and arg_132_1.time_ < var_135_18 + var_135_19 then
				local var_135_20 = (arg_132_1.time_ - var_135_18) / var_135_19
				local var_135_21 = Color.New(0, 0, 0)

				var_135_21.a = Mathf.Lerp(0, 1, var_135_20)
				arg_132_1.mask_.color = var_135_21
			end

			if arg_132_1.time_ >= var_135_18 + var_135_19 and arg_132_1.time_ < var_135_18 + var_135_19 + arg_135_0 then
				local var_135_22 = Color.New(0, 0, 0)

				var_135_22.a = 1
				arg_132_1.mask_.color = var_135_22
			end

			local var_135_23 = 1.20163297123897

			if var_135_23 < arg_132_1.time_ and arg_132_1.time_ <= var_135_23 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_24 = 1.46733333518108

			if var_135_23 <= arg_132_1.time_ and arg_132_1.time_ < var_135_23 + var_135_24 then
				local var_135_25 = (arg_132_1.time_ - var_135_23) / var_135_24
				local var_135_26 = Color.New(0, 0, 0)

				var_135_26.a = Mathf.Lerp(1, 0, var_135_25)
				arg_132_1.mask_.color = var_135_26
			end

			if arg_132_1.time_ >= var_135_23 + var_135_24 and arg_132_1.time_ < var_135_23 + var_135_24 + arg_135_0 then
				local var_135_27 = Color.New(0, 0, 0)
				local var_135_28 = 0

				arg_132_1.mask_.enabled = false
				var_135_27.a = var_135_28
				arg_132_1.mask_.color = var_135_27
			end

			local var_135_29 = "1061ui_story"

			if arg_132_1.actors_[var_135_29] == nil then
				local var_135_30 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_135_30) then
					local var_135_31 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_132_1.stage_.transform)

					var_135_31.name = var_135_29
					var_135_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_132_1.actors_[var_135_29] = var_135_31

					local var_135_32 = var_135_31:GetComponentInChildren(typeof(CharacterEffect))

					var_135_32.enabled = true

					local var_135_33 = GameObjectTools.GetOrAddComponent(var_135_31, typeof(DynamicBoneHelper))

					if var_135_33 then
						var_135_33:EnableDynamicBone(false)
					end

					arg_132_1:ShowWeapon(var_135_32.transform, false)

					arg_132_1.var_[var_135_29 .. "Animator"] = var_135_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_132_1.var_[var_135_29 .. "Animator"].applyRootMotion = true
					arg_132_1.var_[var_135_29 .. "LipSync"] = var_135_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_135_34 = arg_132_1.actors_["1061ui_story"].transform
			local var_135_35 = 6.43563297308671

			if var_135_35 < arg_132_1.time_ and arg_132_1.time_ <= var_135_35 + arg_135_0 then
				arg_132_1.var_.moveOldPos1061ui_story = var_135_34.localPosition
			end

			local var_135_36 = 0.001

			if var_135_35 <= arg_132_1.time_ and arg_132_1.time_ < var_135_35 + var_135_36 then
				local var_135_37 = (arg_132_1.time_ - var_135_35) / var_135_36
				local var_135_38 = Vector3.New(0, -1.18, -6.15)

				var_135_34.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1061ui_story, var_135_38, var_135_37)

				local var_135_39 = manager.ui.mainCamera.transform.position - var_135_34.position

				var_135_34.forward = Vector3.New(var_135_39.x, var_135_39.y, var_135_39.z)

				local var_135_40 = var_135_34.localEulerAngles

				var_135_40.z = 0
				var_135_40.x = 0
				var_135_34.localEulerAngles = var_135_40
			end

			if arg_132_1.time_ >= var_135_35 + var_135_36 and arg_132_1.time_ < var_135_35 + var_135_36 + arg_135_0 then
				var_135_34.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_135_41 = manager.ui.mainCamera.transform.position - var_135_34.position

				var_135_34.forward = Vector3.New(var_135_41.x, var_135_41.y, var_135_41.z)

				local var_135_42 = var_135_34.localEulerAngles

				var_135_42.z = 0
				var_135_42.x = 0
				var_135_34.localEulerAngles = var_135_42
			end

			local var_135_43 = arg_132_1.actors_["1061ui_story"]
			local var_135_44 = 6.43563297308671

			if var_135_44 < arg_132_1.time_ and arg_132_1.time_ <= var_135_44 + arg_135_0 and not isNil(var_135_43) and arg_132_1.var_.characterEffect1061ui_story == nil then
				arg_132_1.var_.characterEffect1061ui_story = var_135_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_45 = 0.200000002980232

			if var_135_44 <= arg_132_1.time_ and arg_132_1.time_ < var_135_44 + var_135_45 and not isNil(var_135_43) then
				local var_135_46 = (arg_132_1.time_ - var_135_44) / var_135_45

				if arg_132_1.var_.characterEffect1061ui_story and not isNil(var_135_43) then
					arg_132_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_44 + var_135_45 and arg_132_1.time_ < var_135_44 + var_135_45 + arg_135_0 and not isNil(var_135_43) and arg_132_1.var_.characterEffect1061ui_story then
				arg_132_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_135_47 = arg_132_1.actors_["10171ui_story"]
			local var_135_48 = 6.43563297308671

			if var_135_48 < arg_132_1.time_ and arg_132_1.time_ <= var_135_48 + arg_135_0 and not isNil(var_135_47) and arg_132_1.var_.characterEffect10171ui_story == nil then
				arg_132_1.var_.characterEffect10171ui_story = var_135_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_49 = 0.200000002980232

			if var_135_48 <= arg_132_1.time_ and arg_132_1.time_ < var_135_48 + var_135_49 and not isNil(var_135_47) then
				local var_135_50 = (arg_132_1.time_ - var_135_48) / var_135_49

				if arg_132_1.var_.characterEffect10171ui_story and not isNil(var_135_47) then
					local var_135_51 = Mathf.Lerp(0, 0.5, var_135_50)

					arg_132_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10171ui_story.fillRatio = var_135_51
				end
			end

			if arg_132_1.time_ >= var_135_48 + var_135_49 and arg_132_1.time_ < var_135_48 + var_135_49 + arg_135_0 and not isNil(var_135_47) and arg_132_1.var_.characterEffect10171ui_story then
				local var_135_52 = 0.5

				arg_132_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10171ui_story.fillRatio = var_135_52
			end

			local var_135_53 = 6.43563297308671

			if var_135_53 < arg_132_1.time_ and arg_132_1.time_ <= var_135_53 + arg_135_0 then
				arg_132_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_135_54 = 6.43563297308671

			if var_135_54 < arg_132_1.time_ and arg_132_1.time_ <= var_135_54 + arg_135_0 then
				arg_132_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_135_55 = 5.43563297308671
			local var_135_56 = 1

			if var_135_55 < arg_132_1.time_ and arg_132_1.time_ <= var_135_55 + arg_135_0 then
				local var_135_57 = "play"
				local var_135_58 = "effect"

				arg_132_1:AudioAction(var_135_57, var_135_58, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_135_59 = 0
			local var_135_60 = 1

			if var_135_59 < arg_132_1.time_ and arg_132_1.time_ <= var_135_59 + arg_135_0 then
				local var_135_61 = "stop"
				local var_135_62 = "effect"

				arg_132_1:AudioAction(var_135_61, var_135_62, "se_story_1310", "se_story_1310_wind", "")
			end

			local var_135_63 = 5.40163297123897

			arg_132_1.isInRecall_ = false

			if var_135_63 < arg_132_1.time_ and arg_132_1.time_ <= var_135_63 + arg_135_0 then
				arg_132_1.screenFilterGo_:SetActive(true)

				arg_132_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_135_2, iter_135_3 in pairs(arg_132_1.actors_) do
					local var_135_64 = iter_135_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_135_4, iter_135_5 in ipairs(var_135_64) do
						if iter_135_5.color.r > 0.51 then
							iter_135_5.color = Color.New(1, 1, 1)
						else
							iter_135_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_135_65 = 0.034000001847744

			if var_135_63 <= arg_132_1.time_ and arg_132_1.time_ < var_135_63 + var_135_65 then
				local var_135_66 = (arg_132_1.time_ - var_135_63) / var_135_65

				arg_132_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_135_66)
			end

			if arg_132_1.time_ >= var_135_63 + var_135_65 and arg_132_1.time_ < var_135_63 + var_135_65 + arg_135_0 then
				arg_132_1.screenFilterEffect_.weight = 1
			end

			local var_135_67 = 1.20163297123897
			local var_135_68 = 3
			local var_135_69 = "ST41"

			if var_135_67 < arg_132_1.time_ and arg_132_1.time_ <= var_135_67 + arg_135_0 then
				arg_132_1.timestampController_:SetSelectedState("show")
				arg_132_1.timestampAni_:Play("in")

				arg_132_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_135_69)

				arg_132_1.timestampColorController_:SetSelectedState("hot")
				arg_132_1.timeColdImg_:SetAlpha(0.031)

				local var_135_70 = arg_132_1:GetWordFromCfg(501128)
				local var_135_71 = arg_132_1:FormatText(var_135_70.content)

				arg_132_1.text_timeText_.text = var_135_71

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_timeText_)

				local var_135_72 = arg_132_1:GetWordFromCfg(501129)
				local var_135_73 = arg_132_1:FormatText(var_135_72.content)

				arg_132_1.text_siteText_.text = var_135_73

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_siteText_)
			end

			if arg_132_1.time_ >= var_135_67 + var_135_68 and arg_132_1.time_ < var_135_67 + var_135_68 + arg_135_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_132_1.timestampAni_, "out", function()
					arg_132_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_135_74 = 4.20163297123897

			if var_135_74 < arg_132_1.time_ and arg_132_1.time_ <= var_135_74 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_75 = 1.2

			if var_135_74 <= arg_132_1.time_ and arg_132_1.time_ < var_135_74 + var_135_75 then
				local var_135_76 = (arg_132_1.time_ - var_135_74) / var_135_75
				local var_135_77 = Color.New(0, 0, 0)

				var_135_77.a = Mathf.Lerp(0, 1, var_135_76)
				arg_132_1.mask_.color = var_135_77
			end

			if arg_132_1.time_ >= var_135_74 + var_135_75 and arg_132_1.time_ < var_135_74 + var_135_75 + arg_135_0 then
				local var_135_78 = Color.New(0, 0, 0)

				var_135_78.a = 1
				arg_132_1.mask_.color = var_135_78
			end

			local var_135_79 = 5.40163297123897

			if var_135_79 < arg_132_1.time_ and arg_132_1.time_ <= var_135_79 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_80 = 1.2

			if var_135_79 <= arg_132_1.time_ and arg_132_1.time_ < var_135_79 + var_135_80 then
				local var_135_81 = (arg_132_1.time_ - var_135_79) / var_135_80
				local var_135_82 = Color.New(0, 0, 0)

				var_135_82.a = Mathf.Lerp(1, 0, var_135_81)
				arg_132_1.mask_.color = var_135_82
			end

			if arg_132_1.time_ >= var_135_79 + var_135_80 and arg_132_1.time_ < var_135_79 + var_135_80 + arg_135_0 then
				local var_135_83 = Color.New(0, 0, 0)
				local var_135_84 = 0

				arg_132_1.mask_.enabled = false
				var_135_83.a = var_135_84
				arg_132_1.mask_.color = var_135_83
			end

			local var_135_85 = 1.33333333333333

			if var_135_85 < arg_132_1.time_ and arg_132_1.time_ <= var_135_85 + arg_135_0 then
				arg_132_1.allBtn_.enabled = false
			end

			local var_135_86 = 5

			if arg_132_1.time_ >= var_135_85 + var_135_86 and arg_132_1.time_ < var_135_85 + var_135_86 + arg_135_0 then
				arg_132_1.allBtn_.enabled = true
			end

			if arg_132_1.frameCnt_ <= 1 then
				arg_132_1.dialog_:SetActive(false)
			end

			local var_135_87 = 6.63563297606694
			local var_135_88 = 0.35

			if var_135_87 < arg_132_1.time_ and arg_132_1.time_ <= var_135_87 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0

				arg_132_1.dialog_:SetActive(true)

				arg_132_1.dialogCg_.alpha = 0

				local var_135_89 = LeanTween.value(arg_132_1.dialog_, 0, 1, 0.3)

				var_135_89:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_132_1.dialogCg_.alpha = arg_137_0
				end))
				var_135_89:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_132_1.dialog_)
					var_135_89:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_132_1.duration_ = arg_132_1.duration_ + 0.3

				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_90 = arg_132_1:FormatText(StoryNameCfg[612].name)

				arg_132_1.leftNameTxt_.text = var_135_90

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_91 = arg_132_1:GetWordFromCfg(324151029)
				local var_135_92 = arg_132_1:FormatText(var_135_91.content)

				arg_132_1.text_.text = var_135_92

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_93 = 14
				local var_135_94 = utf8.len(var_135_92)
				local var_135_95 = var_135_93 <= 0 and var_135_88 or var_135_88 * (var_135_94 / var_135_93)

				if var_135_95 > 0 and var_135_88 < var_135_95 then
					arg_132_1.talkMaxDuration = var_135_95
					var_135_87 = var_135_87 + 0.3

					if var_135_95 + var_135_87 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_95 + var_135_87
					end
				end

				arg_132_1.text_.text = var_135_92
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151029", "story_v_out_324151.awb") ~= 0 then
					local var_135_96 = manager.audio:GetVoiceLength("story_v_out_324151", "324151029", "story_v_out_324151.awb") / 1000

					if var_135_96 + var_135_87 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_96 + var_135_87
					end

					if var_135_91.prefab_name ~= "" and arg_132_1.actors_[var_135_91.prefab_name] ~= nil then
						local var_135_97 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_91.prefab_name].transform, "story_v_out_324151", "324151029", "story_v_out_324151.awb")

						arg_132_1:RecordAudio("324151029", var_135_97)
						arg_132_1:RecordAudio("324151029", var_135_97)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_324151", "324151029", "story_v_out_324151.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_324151", "324151029", "story_v_out_324151.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_98 = var_135_87 + 0.3
			local var_135_99 = math.max(var_135_88, arg_132_1.talkMaxDuration)

			if var_135_98 <= arg_132_1.time_ and arg_132_1.time_ < var_135_98 + var_135_99 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_98) / var_135_99

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_98 + var_135_99 and arg_132_1.time_ < var_135_98 + var_135_99 + arg_135_0 then
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
			local var_142_0 = arg_139_1.actors_["1061ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1061ui_story == nil then
				arg_139_1.var_.characterEffect1061ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1061ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1061ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1061ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1061ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0.2
			local var_142_7 = 1

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				local var_142_8 = "play"
				local var_142_9 = "effect"

				arg_139_1:AudioAction(var_142_8, var_142_9, "se_story_150", "se_story_150_sword05", "")
			end

			local var_142_10 = 0
			local var_142_11 = 1.6

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_12 = arg_139_1:GetWordFromCfg(324151030)
				local var_142_13 = arg_139_1:FormatText(var_142_12.content)

				arg_139_1.text_.text = var_142_13

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_14 = 64
				local var_142_15 = utf8.len(var_142_13)
				local var_142_16 = var_142_14 <= 0 and var_142_11 or var_142_11 * (var_142_15 / var_142_14)

				if var_142_16 > 0 and var_142_11 < var_142_16 then
					arg_139_1.talkMaxDuration = var_142_16

					if var_142_16 + var_142_10 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_16 + var_142_10
					end
				end

				arg_139_1.text_.text = var_142_13
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_17 = math.max(var_142_11, arg_139_1.talkMaxDuration)

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_17 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_10) / var_142_17

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_10 + var_142_17 and arg_139_1.time_ < var_142_10 + var_142_17 + arg_142_0 then
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
			local var_146_0 = arg_143_1.actors_["1061ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1061ui_story == nil then
				arg_143_1.var_.characterEffect1061ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1061ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1061ui_story then
				arg_143_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_146_4 = 0
			local var_146_5 = 0.2

			if var_146_4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_6 = arg_143_1:FormatText(StoryNameCfg[612].name)

				arg_143_1.leftNameTxt_.text = var_146_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_7 = arg_143_1:GetWordFromCfg(324151031)
				local var_146_8 = arg_143_1:FormatText(var_146_7.content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 8
				local var_146_10 = utf8.len(var_146_8)
				local var_146_11 = var_146_9 <= 0 and var_146_5 or var_146_5 * (var_146_10 / var_146_9)

				if var_146_11 > 0 and var_146_5 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151031", "story_v_out_324151.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151031", "story_v_out_324151.awb") / 1000

					if var_146_12 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_4
					end

					if var_146_7.prefab_name ~= "" and arg_143_1.actors_[var_146_7.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_7.prefab_name].transform, "story_v_out_324151", "324151031", "story_v_out_324151.awb")

						arg_143_1:RecordAudio("324151031", var_146_13)
						arg_143_1:RecordAudio("324151031", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_324151", "324151031", "story_v_out_324151.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_324151", "324151031", "story_v_out_324151.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_14 and arg_143_1.time_ < var_146_4 + var_146_14 + arg_146_0 then
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
			local var_150_0 = arg_147_1.actors_["10171ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10171ui_story = var_150_0.localPosition

				local var_150_2 = GameObjectTools.GetOrAddComponent(var_150_0.gameObject, typeof(DynamicBoneHelper))

				if var_150_2 then
					var_150_2:EnableDynamicBone(false)
				end
			end

			local var_150_3 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_3 then
				local var_150_4 = (arg_147_1.time_ - var_150_1) / var_150_3
				local var_150_5 = Vector3.New(0.7, -0.95, -6.05)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10171ui_story, var_150_5, var_150_4)

				local var_150_6 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_6.x, var_150_6.y, var_150_6.z)

				local var_150_7 = var_150_0.localEulerAngles

				var_150_7.z = 0
				var_150_7.x = 0
				var_150_0.localEulerAngles = var_150_7
			end

			if arg_147_1.time_ >= var_150_1 + var_150_3 and arg_147_1.time_ < var_150_1 + var_150_3 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_150_8 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_8.x, var_150_8.y, var_150_8.z)

				local var_150_9 = var_150_0.localEulerAngles

				var_150_9.z = 0
				var_150_9.x = 0
				var_150_0.localEulerAngles = var_150_9

				local var_150_10 = GameObjectTools.GetOrAddComponent(var_150_0.gameObject, typeof(DynamicBoneHelper))

				if var_150_10 then
					var_150_10:EnableDynamicBone(true)
				end
			end

			local var_150_11 = arg_147_1.actors_["1061ui_story"].transform
			local var_150_12 = 0

			if var_150_12 < arg_147_1.time_ and arg_147_1.time_ <= var_150_12 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061ui_story = var_150_11.localPosition
			end

			local var_150_13 = 0.001

			if var_150_12 <= arg_147_1.time_ and arg_147_1.time_ < var_150_12 + var_150_13 then
				local var_150_14 = (arg_147_1.time_ - var_150_12) / var_150_13
				local var_150_15 = Vector3.New(-0.7, -1.18, -6.15)

				var_150_11.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061ui_story, var_150_15, var_150_14)

				local var_150_16 = manager.ui.mainCamera.transform.position - var_150_11.position

				var_150_11.forward = Vector3.New(var_150_16.x, var_150_16.y, var_150_16.z)

				local var_150_17 = var_150_11.localEulerAngles

				var_150_17.z = 0
				var_150_17.x = 0
				var_150_11.localEulerAngles = var_150_17
			end

			if arg_147_1.time_ >= var_150_12 + var_150_13 and arg_147_1.time_ < var_150_12 + var_150_13 + arg_150_0 then
				var_150_11.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_150_18 = manager.ui.mainCamera.transform.position - var_150_11.position

				var_150_11.forward = Vector3.New(var_150_18.x, var_150_18.y, var_150_18.z)

				local var_150_19 = var_150_11.localEulerAngles

				var_150_19.z = 0
				var_150_19.x = 0
				var_150_11.localEulerAngles = var_150_19
			end

			local var_150_20 = arg_147_1.actors_["10171ui_story"]
			local var_150_21 = 0

			if var_150_21 < arg_147_1.time_ and arg_147_1.time_ <= var_150_21 + arg_150_0 and not isNil(var_150_20) and arg_147_1.var_.characterEffect10171ui_story == nil then
				arg_147_1.var_.characterEffect10171ui_story = var_150_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_22 = 0.200000002980232

			if var_150_21 <= arg_147_1.time_ and arg_147_1.time_ < var_150_21 + var_150_22 and not isNil(var_150_20) then
				local var_150_23 = (arg_147_1.time_ - var_150_21) / var_150_22

				if arg_147_1.var_.characterEffect10171ui_story and not isNil(var_150_20) then
					arg_147_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_21 + var_150_22 and arg_147_1.time_ < var_150_21 + var_150_22 + arg_150_0 and not isNil(var_150_20) and arg_147_1.var_.characterEffect10171ui_story then
				arg_147_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_150_24 = arg_147_1.actors_["1061ui_story"]
			local var_150_25 = 0

			if var_150_25 < arg_147_1.time_ and arg_147_1.time_ <= var_150_25 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.characterEffect1061ui_story == nil then
				arg_147_1.var_.characterEffect1061ui_story = var_150_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_26 = 0.200000002980232

			if var_150_25 <= arg_147_1.time_ and arg_147_1.time_ < var_150_25 + var_150_26 and not isNil(var_150_24) then
				local var_150_27 = (arg_147_1.time_ - var_150_25) / var_150_26

				if arg_147_1.var_.characterEffect1061ui_story and not isNil(var_150_24) then
					local var_150_28 = Mathf.Lerp(0, 0.5, var_150_27)

					arg_147_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1061ui_story.fillRatio = var_150_28
				end
			end

			if arg_147_1.time_ >= var_150_25 + var_150_26 and arg_147_1.time_ < var_150_25 + var_150_26 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.characterEffect1061ui_story then
				local var_150_29 = 0.5

				arg_147_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1061ui_story.fillRatio = var_150_29
			end

			local var_150_30 = 0

			if var_150_30 < arg_147_1.time_ and arg_147_1.time_ <= var_150_30 + arg_150_0 then
				arg_147_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_1")
			end

			local var_150_31 = 0

			if var_150_31 < arg_147_1.time_ and arg_147_1.time_ <= var_150_31 + arg_150_0 then
				arg_147_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_150_32 = 0
			local var_150_33 = 0.175

			if var_150_32 < arg_147_1.time_ and arg_147_1.time_ <= var_150_32 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_34 = arg_147_1:FormatText(StoryNameCfg[1451].name)

				arg_147_1.leftNameTxt_.text = var_150_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_35 = arg_147_1:GetWordFromCfg(324151032)
				local var_150_36 = arg_147_1:FormatText(var_150_35.content)

				arg_147_1.text_.text = var_150_36

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_37 = 7
				local var_150_38 = utf8.len(var_150_36)
				local var_150_39 = var_150_37 <= 0 and var_150_33 or var_150_33 * (var_150_38 / var_150_37)

				if var_150_39 > 0 and var_150_33 < var_150_39 then
					arg_147_1.talkMaxDuration = var_150_39

					if var_150_39 + var_150_32 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_39 + var_150_32
					end
				end

				arg_147_1.text_.text = var_150_36
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151032", "story_v_out_324151.awb") ~= 0 then
					local var_150_40 = manager.audio:GetVoiceLength("story_v_out_324151", "324151032", "story_v_out_324151.awb") / 1000

					if var_150_40 + var_150_32 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_40 + var_150_32
					end

					if var_150_35.prefab_name ~= "" and arg_147_1.actors_[var_150_35.prefab_name] ~= nil then
						local var_150_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_35.prefab_name].transform, "story_v_out_324151", "324151032", "story_v_out_324151.awb")

						arg_147_1:RecordAudio("324151032", var_150_41)
						arg_147_1:RecordAudio("324151032", var_150_41)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_324151", "324151032", "story_v_out_324151.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_324151", "324151032", "story_v_out_324151.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_42 = math.max(var_150_33, arg_147_1.talkMaxDuration)

			if var_150_32 <= arg_147_1.time_ and arg_147_1.time_ < var_150_32 + var_150_42 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_32) / var_150_42

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_32 + var_150_42 and arg_147_1.time_ < var_150_32 + var_150_42 + arg_150_0 then
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
			local var_154_0 = arg_151_1.actors_["1061ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1061ui_story == nil then
				arg_151_1.var_.characterEffect1061ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1061ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1061ui_story then
				arg_151_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_154_4 = arg_151_1.actors_["10171ui_story"]
			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect10171ui_story == nil then
				arg_151_1.var_.characterEffect10171ui_story = var_154_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_6 = 0.200000002980232

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_6 and not isNil(var_154_4) then
				local var_154_7 = (arg_151_1.time_ - var_154_5) / var_154_6

				if arg_151_1.var_.characterEffect10171ui_story and not isNil(var_154_4) then
					local var_154_8 = Mathf.Lerp(0, 0.5, var_154_7)

					arg_151_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10171ui_story.fillRatio = var_154_8
				end
			end

			if arg_151_1.time_ >= var_154_5 + var_154_6 and arg_151_1.time_ < var_154_5 + var_154_6 + arg_154_0 and not isNil(var_154_4) and arg_151_1.var_.characterEffect10171ui_story then
				local var_154_9 = 0.5

				arg_151_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10171ui_story.fillRatio = var_154_9
			end

			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 then
				arg_151_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_154_11 = 0
			local var_154_12 = 0.225

			if var_154_11 < arg_151_1.time_ and arg_151_1.time_ <= var_154_11 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_13 = arg_151_1:FormatText(StoryNameCfg[612].name)

				arg_151_1.leftNameTxt_.text = var_154_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_14 = arg_151_1:GetWordFromCfg(324151033)
				local var_154_15 = arg_151_1:FormatText(var_154_14.content)

				arg_151_1.text_.text = var_154_15

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_16 = 9
				local var_154_17 = utf8.len(var_154_15)
				local var_154_18 = var_154_16 <= 0 and var_154_12 or var_154_12 * (var_154_17 / var_154_16)

				if var_154_18 > 0 and var_154_12 < var_154_18 then
					arg_151_1.talkMaxDuration = var_154_18

					if var_154_18 + var_154_11 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_18 + var_154_11
					end
				end

				arg_151_1.text_.text = var_154_15
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151033", "story_v_out_324151.awb") ~= 0 then
					local var_154_19 = manager.audio:GetVoiceLength("story_v_out_324151", "324151033", "story_v_out_324151.awb") / 1000

					if var_154_19 + var_154_11 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_11
					end

					if var_154_14.prefab_name ~= "" and arg_151_1.actors_[var_154_14.prefab_name] ~= nil then
						local var_154_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_14.prefab_name].transform, "story_v_out_324151", "324151033", "story_v_out_324151.awb")

						arg_151_1:RecordAudio("324151033", var_154_20)
						arg_151_1:RecordAudio("324151033", var_154_20)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_324151", "324151033", "story_v_out_324151.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_324151", "324151033", "story_v_out_324151.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_21 = math.max(var_154_12, arg_151_1.talkMaxDuration)

			if var_154_11 <= arg_151_1.time_ and arg_151_1.time_ < var_154_11 + var_154_21 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_11) / var_154_21

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_11 + var_154_21 and arg_151_1.time_ < var_154_11 + var_154_21 + arg_154_0 then
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
			local var_158_0 = arg_155_1.actors_["10171ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10171ui_story == nil then
				arg_155_1.var_.characterEffect10171ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect10171ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10171ui_story then
				arg_155_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_158_4 = arg_155_1.actors_["1061ui_story"]
			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.characterEffect1061ui_story == nil then
				arg_155_1.var_.characterEffect1061ui_story = var_158_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_6 = 0.200000002980232

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_6 and not isNil(var_158_4) then
				local var_158_7 = (arg_155_1.time_ - var_158_5) / var_158_6

				if arg_155_1.var_.characterEffect1061ui_story and not isNil(var_158_4) then
					local var_158_8 = Mathf.Lerp(0, 0.5, var_158_7)

					arg_155_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1061ui_story.fillRatio = var_158_8
				end
			end

			if arg_155_1.time_ >= var_158_5 + var_158_6 and arg_155_1.time_ < var_158_5 + var_158_6 + arg_158_0 and not isNil(var_158_4) and arg_155_1.var_.characterEffect1061ui_story then
				local var_158_9 = 0.5

				arg_155_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1061ui_story.fillRatio = var_158_9
			end

			local var_158_10 = 0
			local var_158_11 = 0.475

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_12 = arg_155_1:FormatText(StoryNameCfg[1451].name)

				arg_155_1.leftNameTxt_.text = var_158_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_13 = arg_155_1:GetWordFromCfg(324151034)
				local var_158_14 = arg_155_1:FormatText(var_158_13.content)

				arg_155_1.text_.text = var_158_14

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_15 = 19
				local var_158_16 = utf8.len(var_158_14)
				local var_158_17 = var_158_15 <= 0 and var_158_11 or var_158_11 * (var_158_16 / var_158_15)

				if var_158_17 > 0 and var_158_11 < var_158_17 then
					arg_155_1.talkMaxDuration = var_158_17

					if var_158_17 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_10
					end
				end

				arg_155_1.text_.text = var_158_14
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151034", "story_v_out_324151.awb") ~= 0 then
					local var_158_18 = manager.audio:GetVoiceLength("story_v_out_324151", "324151034", "story_v_out_324151.awb") / 1000

					if var_158_18 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_18 + var_158_10
					end

					if var_158_13.prefab_name ~= "" and arg_155_1.actors_[var_158_13.prefab_name] ~= nil then
						local var_158_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_13.prefab_name].transform, "story_v_out_324151", "324151034", "story_v_out_324151.awb")

						arg_155_1:RecordAudio("324151034", var_158_19)
						arg_155_1:RecordAudio("324151034", var_158_19)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_324151", "324151034", "story_v_out_324151.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_324151", "324151034", "story_v_out_324151.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_20 = math.max(var_158_11, arg_155_1.talkMaxDuration)

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_20 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_10) / var_158_20

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_10 + var_158_20 and arg_155_1.time_ < var_158_10 + var_158_20 + arg_158_0 then
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
			local var_162_0 = arg_159_1.actors_["1061ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1061ui_story == nil then
				arg_159_1.var_.characterEffect1061ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1061ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1061ui_story then
				arg_159_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_162_4 = arg_159_1.actors_["10171ui_story"]
			local var_162_5 = 0

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect10171ui_story == nil then
				arg_159_1.var_.characterEffect10171ui_story = var_162_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_6 = 0.200000002980232

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_6 and not isNil(var_162_4) then
				local var_162_7 = (arg_159_1.time_ - var_162_5) / var_162_6

				if arg_159_1.var_.characterEffect10171ui_story and not isNil(var_162_4) then
					local var_162_8 = Mathf.Lerp(0, 0.5, var_162_7)

					arg_159_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10171ui_story.fillRatio = var_162_8
				end
			end

			if arg_159_1.time_ >= var_162_5 + var_162_6 and arg_159_1.time_ < var_162_5 + var_162_6 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect10171ui_story then
				local var_162_9 = 0.5

				arg_159_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10171ui_story.fillRatio = var_162_9
			end

			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_162_11 = 0

			if var_162_11 < arg_159_1.time_ and arg_159_1.time_ <= var_162_11 + arg_162_0 then
				arg_159_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_162_12 = 0
			local var_162_13 = 0.375

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_14 = arg_159_1:FormatText(StoryNameCfg[612].name)

				arg_159_1.leftNameTxt_.text = var_162_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_15 = arg_159_1:GetWordFromCfg(324151035)
				local var_162_16 = arg_159_1:FormatText(var_162_15.content)

				arg_159_1.text_.text = var_162_16

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_17 = 15
				local var_162_18 = utf8.len(var_162_16)
				local var_162_19 = var_162_17 <= 0 and var_162_13 or var_162_13 * (var_162_18 / var_162_17)

				if var_162_19 > 0 and var_162_13 < var_162_19 then
					arg_159_1.talkMaxDuration = var_162_19

					if var_162_19 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_19 + var_162_12
					end
				end

				arg_159_1.text_.text = var_162_16
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151035", "story_v_out_324151.awb") ~= 0 then
					local var_162_20 = manager.audio:GetVoiceLength("story_v_out_324151", "324151035", "story_v_out_324151.awb") / 1000

					if var_162_20 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_20 + var_162_12
					end

					if var_162_15.prefab_name ~= "" and arg_159_1.actors_[var_162_15.prefab_name] ~= nil then
						local var_162_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_15.prefab_name].transform, "story_v_out_324151", "324151035", "story_v_out_324151.awb")

						arg_159_1:RecordAudio("324151035", var_162_21)
						arg_159_1:RecordAudio("324151035", var_162_21)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_324151", "324151035", "story_v_out_324151.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_324151", "324151035", "story_v_out_324151.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_22 = math.max(var_162_13, arg_159_1.talkMaxDuration)

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_22 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_12) / var_162_22

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_12 + var_162_22 and arg_159_1.time_ < var_162_12 + var_162_22 + arg_162_0 then
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
			local var_166_0 = arg_163_1.actors_["10171ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10171ui_story == nil then
				arg_163_1.var_.characterEffect10171ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect10171ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10171ui_story then
				arg_163_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_166_4 = arg_163_1.actors_["1061ui_story"]
			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect1061ui_story == nil then
				arg_163_1.var_.characterEffect1061ui_story = var_166_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_6 = 0.200000002980232

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_6 and not isNil(var_166_4) then
				local var_166_7 = (arg_163_1.time_ - var_166_5) / var_166_6

				if arg_163_1.var_.characterEffect1061ui_story and not isNil(var_166_4) then
					local var_166_8 = Mathf.Lerp(0, 0.5, var_166_7)

					arg_163_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1061ui_story.fillRatio = var_166_8
				end
			end

			if arg_163_1.time_ >= var_166_5 + var_166_6 and arg_163_1.time_ < var_166_5 + var_166_6 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect1061ui_story then
				local var_166_9 = 0.5

				arg_163_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1061ui_story.fillRatio = var_166_9
			end

			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_2")
			end

			local var_166_11 = 0

			if var_166_11 < arg_163_1.time_ and arg_163_1.time_ <= var_166_11 + arg_166_0 then
				arg_163_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_166_12 = 0
			local var_166_13 = 0.85

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_14 = arg_163_1:FormatText(StoryNameCfg[1451].name)

				arg_163_1.leftNameTxt_.text = var_166_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_15 = arg_163_1:GetWordFromCfg(324151036)
				local var_166_16 = arg_163_1:FormatText(var_166_15.content)

				arg_163_1.text_.text = var_166_16

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_17 = 34
				local var_166_18 = utf8.len(var_166_16)
				local var_166_19 = var_166_17 <= 0 and var_166_13 or var_166_13 * (var_166_18 / var_166_17)

				if var_166_19 > 0 and var_166_13 < var_166_19 then
					arg_163_1.talkMaxDuration = var_166_19

					if var_166_19 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_19 + var_166_12
					end
				end

				arg_163_1.text_.text = var_166_16
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151036", "story_v_out_324151.awb") ~= 0 then
					local var_166_20 = manager.audio:GetVoiceLength("story_v_out_324151", "324151036", "story_v_out_324151.awb") / 1000

					if var_166_20 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_20 + var_166_12
					end

					if var_166_15.prefab_name ~= "" and arg_163_1.actors_[var_166_15.prefab_name] ~= nil then
						local var_166_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_15.prefab_name].transform, "story_v_out_324151", "324151036", "story_v_out_324151.awb")

						arg_163_1:RecordAudio("324151036", var_166_21)
						arg_163_1:RecordAudio("324151036", var_166_21)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_324151", "324151036", "story_v_out_324151.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_324151", "324151036", "story_v_out_324151.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_22 = math.max(var_166_13, arg_163_1.talkMaxDuration)

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_22 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_12) / var_166_22

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_12 + var_166_22 and arg_163_1.time_ < var_166_12 + var_166_22 + arg_166_0 then
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
			local var_170_0 = 0
			local var_170_1 = 0.575

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[1451].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(324151037)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 23
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151037", "story_v_out_324151.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151037", "story_v_out_324151.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_324151", "324151037", "story_v_out_324151.awb")

						arg_167_1:RecordAudio("324151037", var_170_9)
						arg_167_1:RecordAudio("324151037", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_324151", "324151037", "story_v_out_324151.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_324151", "324151037", "story_v_out_324151.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
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
			local var_174_0 = arg_171_1.actors_["10171ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10171ui_story = var_174_0.localPosition

				local var_174_2 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(false)
				end
			end

			local var_174_3 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_3 then
				local var_174_4 = (arg_171_1.time_ - var_174_1) / var_174_3
				local var_174_5 = Vector3.New(0, 100, 0)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10171ui_story, var_174_5, var_174_4)

				local var_174_6 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_6.x, var_174_6.y, var_174_6.z)

				local var_174_7 = var_174_0.localEulerAngles

				var_174_7.z = 0
				var_174_7.x = 0
				var_174_0.localEulerAngles = var_174_7
			end

			if arg_171_1.time_ >= var_174_1 + var_174_3 and arg_171_1.time_ < var_174_1 + var_174_3 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, 100, 0)

				local var_174_8 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_8.x, var_174_8.y, var_174_8.z)

				local var_174_9 = var_174_0.localEulerAngles

				var_174_9.z = 0
				var_174_9.x = 0
				var_174_0.localEulerAngles = var_174_9

				local var_174_10 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_10 then
					var_174_10:EnableDynamicBone(true)
				end
			end

			local var_174_11 = arg_171_1.actors_["1061ui_story"].transform
			local var_174_12 = 0

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.var_.moveOldPos1061ui_story = var_174_11.localPosition
			end

			local var_174_13 = 0.001

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_13 then
				local var_174_14 = (arg_171_1.time_ - var_174_12) / var_174_13
				local var_174_15 = Vector3.New(0, 100, 0)

				var_174_11.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1061ui_story, var_174_15, var_174_14)

				local var_174_16 = manager.ui.mainCamera.transform.position - var_174_11.position

				var_174_11.forward = Vector3.New(var_174_16.x, var_174_16.y, var_174_16.z)

				local var_174_17 = var_174_11.localEulerAngles

				var_174_17.z = 0
				var_174_17.x = 0
				var_174_11.localEulerAngles = var_174_17
			end

			if arg_171_1.time_ >= var_174_12 + var_174_13 and arg_171_1.time_ < var_174_12 + var_174_13 + arg_174_0 then
				var_174_11.localPosition = Vector3.New(0, 100, 0)

				local var_174_18 = manager.ui.mainCamera.transform.position - var_174_11.position

				var_174_11.forward = Vector3.New(var_174_18.x, var_174_18.y, var_174_18.z)

				local var_174_19 = var_174_11.localEulerAngles

				var_174_19.z = 0
				var_174_19.x = 0
				var_174_11.localEulerAngles = var_174_19
			end

			local var_174_20 = arg_171_1.actors_["10171ui_story"]
			local var_174_21 = 0

			if var_174_21 < arg_171_1.time_ and arg_171_1.time_ <= var_174_21 + arg_174_0 and not isNil(var_174_20) and arg_171_1.var_.characterEffect10171ui_story == nil then
				arg_171_1.var_.characterEffect10171ui_story = var_174_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_22 = 0.200000002980232

			if var_174_21 <= arg_171_1.time_ and arg_171_1.time_ < var_174_21 + var_174_22 and not isNil(var_174_20) then
				local var_174_23 = (arg_171_1.time_ - var_174_21) / var_174_22

				if arg_171_1.var_.characterEffect10171ui_story and not isNil(var_174_20) then
					local var_174_24 = Mathf.Lerp(0, 0.5, var_174_23)

					arg_171_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10171ui_story.fillRatio = var_174_24
				end
			end

			if arg_171_1.time_ >= var_174_21 + var_174_22 and arg_171_1.time_ < var_174_21 + var_174_22 + arg_174_0 and not isNil(var_174_20) and arg_171_1.var_.characterEffect10171ui_story then
				local var_174_25 = 0.5

				arg_171_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10171ui_story.fillRatio = var_174_25
			end

			local var_174_26 = 0
			local var_174_27 = 0.925

			if var_174_26 < arg_171_1.time_ and arg_171_1.time_ <= var_174_26 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_28 = arg_171_1:GetWordFromCfg(324151038)
				local var_174_29 = arg_171_1:FormatText(var_174_28.content)

				arg_171_1.text_.text = var_174_29

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_30 = 37
				local var_174_31 = utf8.len(var_174_29)
				local var_174_32 = var_174_30 <= 0 and var_174_27 or var_174_27 * (var_174_31 / var_174_30)

				if var_174_32 > 0 and var_174_27 < var_174_32 then
					arg_171_1.talkMaxDuration = var_174_32

					if var_174_32 + var_174_26 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_32 + var_174_26
					end
				end

				arg_171_1.text_.text = var_174_29
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_33 = math.max(var_174_27, arg_171_1.talkMaxDuration)

			if var_174_26 <= arg_171_1.time_ and arg_171_1.time_ < var_174_26 + var_174_33 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_26) / var_174_33

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_26 + var_174_33 and arg_171_1.time_ < var_174_26 + var_174_33 + arg_174_0 then
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
			local var_178_0 = arg_175_1.actors_["1061ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1061ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1061ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["1061ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1061ui_story == nil then
				arg_175_1.var_.characterEffect1061ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect1061ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1061ui_story then
				arg_175_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_15 = 0
			local var_178_16 = 0.375

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_17 = arg_175_1:FormatText(StoryNameCfg[612].name)

				arg_175_1.leftNameTxt_.text = var_178_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:GetWordFromCfg(324151039)
				local var_178_19 = arg_175_1:FormatText(var_178_18.content)

				arg_175_1.text_.text = var_178_19

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 15
				local var_178_21 = utf8.len(var_178_19)
				local var_178_22 = var_178_20 <= 0 and var_178_16 or var_178_16 * (var_178_21 / var_178_20)

				if var_178_22 > 0 and var_178_16 < var_178_22 then
					arg_175_1.talkMaxDuration = var_178_22

					if var_178_22 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_22 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_19
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151039", "story_v_out_324151.awb") ~= 0 then
					local var_178_23 = manager.audio:GetVoiceLength("story_v_out_324151", "324151039", "story_v_out_324151.awb") / 1000

					if var_178_23 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_15
					end

					if var_178_18.prefab_name ~= "" and arg_175_1.actors_[var_178_18.prefab_name] ~= nil then
						local var_178_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_18.prefab_name].transform, "story_v_out_324151", "324151039", "story_v_out_324151.awb")

						arg_175_1:RecordAudio("324151039", var_178_24)
						arg_175_1:RecordAudio("324151039", var_178_24)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_324151", "324151039", "story_v_out_324151.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_324151", "324151039", "story_v_out_324151.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_25 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_25 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_25

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_25 and arg_175_1.time_ < var_178_15 + var_178_25 + arg_178_0 then
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
			local var_182_0 = arg_179_1.actors_["10171ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10171ui_story = var_182_0.localPosition

				local var_182_2 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(false)
				end
			end

			local var_182_3 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_3 then
				local var_182_4 = (arg_179_1.time_ - var_182_1) / var_182_3
				local var_182_5 = Vector3.New(0.7, -0.95, -6.05)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10171ui_story, var_182_5, var_182_4)

				local var_182_6 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_6.x, var_182_6.y, var_182_6.z)

				local var_182_7 = var_182_0.localEulerAngles

				var_182_7.z = 0
				var_182_7.x = 0
				var_182_0.localEulerAngles = var_182_7
			end

			if arg_179_1.time_ >= var_182_1 + var_182_3 and arg_179_1.time_ < var_182_1 + var_182_3 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_182_8 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_8.x, var_182_8.y, var_182_8.z)

				local var_182_9 = var_182_0.localEulerAngles

				var_182_9.z = 0
				var_182_9.x = 0
				var_182_0.localEulerAngles = var_182_9

				local var_182_10 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_10 then
					var_182_10:EnableDynamicBone(true)
				end
			end

			local var_182_11 = arg_179_1.actors_["10171ui_story"]
			local var_182_12 = 0

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect10171ui_story == nil then
				arg_179_1.var_.characterEffect10171ui_story = var_182_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_13 = 0.200000002980232

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_13 and not isNil(var_182_11) then
				local var_182_14 = (arg_179_1.time_ - var_182_12) / var_182_13

				if arg_179_1.var_.characterEffect10171ui_story and not isNil(var_182_11) then
					arg_179_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_12 + var_182_13 and arg_179_1.time_ < var_182_12 + var_182_13 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect10171ui_story then
				arg_179_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_182_15 = arg_179_1.actors_["1061ui_story"]
			local var_182_16 = 0

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 and not isNil(var_182_15) and arg_179_1.var_.characterEffect1061ui_story == nil then
				arg_179_1.var_.characterEffect1061ui_story = var_182_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_17 = 0.200000002980232

			if var_182_16 <= arg_179_1.time_ and arg_179_1.time_ < var_182_16 + var_182_17 and not isNil(var_182_15) then
				local var_182_18 = (arg_179_1.time_ - var_182_16) / var_182_17

				if arg_179_1.var_.characterEffect1061ui_story and not isNil(var_182_15) then
					local var_182_19 = Mathf.Lerp(0, 0.5, var_182_18)

					arg_179_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1061ui_story.fillRatio = var_182_19
				end
			end

			if arg_179_1.time_ >= var_182_16 + var_182_17 and arg_179_1.time_ < var_182_16 + var_182_17 + arg_182_0 and not isNil(var_182_15) and arg_179_1.var_.characterEffect1061ui_story then
				local var_182_20 = 0.5

				arg_179_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1061ui_story.fillRatio = var_182_20
			end

			local var_182_21 = 0

			if var_182_21 < arg_179_1.time_ and arg_179_1.time_ <= var_182_21 + arg_182_0 then
				arg_179_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_182_22 = 0

			if var_182_22 < arg_179_1.time_ and arg_179_1.time_ <= var_182_22 + arg_182_0 then
				arg_179_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_182_23 = 0
			local var_182_24 = 1.4

			if var_182_23 < arg_179_1.time_ and arg_179_1.time_ <= var_182_23 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_25 = arg_179_1:FormatText(StoryNameCfg[1451].name)

				arg_179_1.leftNameTxt_.text = var_182_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_26 = arg_179_1:GetWordFromCfg(324151040)
				local var_182_27 = arg_179_1:FormatText(var_182_26.content)

				arg_179_1.text_.text = var_182_27

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_28 = 56
				local var_182_29 = utf8.len(var_182_27)
				local var_182_30 = var_182_28 <= 0 and var_182_24 or var_182_24 * (var_182_29 / var_182_28)

				if var_182_30 > 0 and var_182_24 < var_182_30 then
					arg_179_1.talkMaxDuration = var_182_30

					if var_182_30 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_30 + var_182_23
					end
				end

				arg_179_1.text_.text = var_182_27
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151040", "story_v_out_324151.awb") ~= 0 then
					local var_182_31 = manager.audio:GetVoiceLength("story_v_out_324151", "324151040", "story_v_out_324151.awb") / 1000

					if var_182_31 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_31 + var_182_23
					end

					if var_182_26.prefab_name ~= "" and arg_179_1.actors_[var_182_26.prefab_name] ~= nil then
						local var_182_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_26.prefab_name].transform, "story_v_out_324151", "324151040", "story_v_out_324151.awb")

						arg_179_1:RecordAudio("324151040", var_182_32)
						arg_179_1:RecordAudio("324151040", var_182_32)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_324151", "324151040", "story_v_out_324151.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_324151", "324151040", "story_v_out_324151.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_33 = math.max(var_182_24, arg_179_1.talkMaxDuration)

			if var_182_23 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_33 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_23) / var_182_33

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_23 + var_182_33 and arg_179_1.time_ < var_182_23 + var_182_33 + arg_182_0 then
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
			local var_186_0 = 0
			local var_186_1 = 0.55

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[1451].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:GetWordFromCfg(324151041)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 22
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151041", "story_v_out_324151.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151041", "story_v_out_324151.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_324151", "324151041", "story_v_out_324151.awb")

						arg_183_1:RecordAudio("324151041", var_186_9)
						arg_183_1:RecordAudio("324151041", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_324151", "324151041", "story_v_out_324151.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_324151", "324151041", "story_v_out_324151.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
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
			local var_190_0 = arg_187_1.actors_["1061ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1061ui_story == nil then
				arg_187_1.var_.characterEffect1061ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1061ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1061ui_story then
				arg_187_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_190_4 = arg_187_1.actors_["10171ui_story"]
			local var_190_5 = 0

			if var_190_5 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect10171ui_story == nil then
				arg_187_1.var_.characterEffect10171ui_story = var_190_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_6 = 0.200000002980232

			if var_190_5 <= arg_187_1.time_ and arg_187_1.time_ < var_190_5 + var_190_6 and not isNil(var_190_4) then
				local var_190_7 = (arg_187_1.time_ - var_190_5) / var_190_6

				if arg_187_1.var_.characterEffect10171ui_story and not isNil(var_190_4) then
					local var_190_8 = Mathf.Lerp(0, 0.5, var_190_7)

					arg_187_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10171ui_story.fillRatio = var_190_8
				end
			end

			if arg_187_1.time_ >= var_190_5 + var_190_6 and arg_187_1.time_ < var_190_5 + var_190_6 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect10171ui_story then
				local var_190_9 = 0.5

				arg_187_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10171ui_story.fillRatio = var_190_9
			end

			local var_190_10 = 0
			local var_190_11 = 0.525

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_12 = arg_187_1:FormatText(StoryNameCfg[612].name)

				arg_187_1.leftNameTxt_.text = var_190_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_13 = arg_187_1:GetWordFromCfg(324151042)
				local var_190_14 = arg_187_1:FormatText(var_190_13.content)

				arg_187_1.text_.text = var_190_14

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_15 = 21
				local var_190_16 = utf8.len(var_190_14)
				local var_190_17 = var_190_15 <= 0 and var_190_11 or var_190_11 * (var_190_16 / var_190_15)

				if var_190_17 > 0 and var_190_11 < var_190_17 then
					arg_187_1.talkMaxDuration = var_190_17

					if var_190_17 + var_190_10 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_17 + var_190_10
					end
				end

				arg_187_1.text_.text = var_190_14
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151042", "story_v_out_324151.awb") ~= 0 then
					local var_190_18 = manager.audio:GetVoiceLength("story_v_out_324151", "324151042", "story_v_out_324151.awb") / 1000

					if var_190_18 + var_190_10 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_18 + var_190_10
					end

					if var_190_13.prefab_name ~= "" and arg_187_1.actors_[var_190_13.prefab_name] ~= nil then
						local var_190_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_13.prefab_name].transform, "story_v_out_324151", "324151042", "story_v_out_324151.awb")

						arg_187_1:RecordAudio("324151042", var_190_19)
						arg_187_1:RecordAudio("324151042", var_190_19)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_324151", "324151042", "story_v_out_324151.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_324151", "324151042", "story_v_out_324151.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_20 = math.max(var_190_11, arg_187_1.talkMaxDuration)

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_20 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_10) / var_190_20

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_10 + var_190_20 and arg_187_1.time_ < var_190_10 + var_190_20 + arg_190_0 then
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
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_194_2 = 0
			local var_194_3 = 1.25

			if var_194_2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_4 = arg_191_1:FormatText(StoryNameCfg[612].name)

				arg_191_1.leftNameTxt_.text = var_194_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_5 = arg_191_1:GetWordFromCfg(324151043)
				local var_194_6 = arg_191_1:FormatText(var_194_5.content)

				arg_191_1.text_.text = var_194_6

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 50
				local var_194_8 = utf8.len(var_194_6)
				local var_194_9 = var_194_7 <= 0 and var_194_3 or var_194_3 * (var_194_8 / var_194_7)

				if var_194_9 > 0 and var_194_3 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_6
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151043", "story_v_out_324151.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151043", "story_v_out_324151.awb") / 1000

					if var_194_10 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_2
					end

					if var_194_5.prefab_name ~= "" and arg_191_1.actors_[var_194_5.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_5.prefab_name].transform, "story_v_out_324151", "324151043", "story_v_out_324151.awb")

						arg_191_1:RecordAudio("324151043", var_194_11)
						arg_191_1:RecordAudio("324151043", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_324151", "324151043", "story_v_out_324151.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_324151", "324151043", "story_v_out_324151.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_12 and arg_191_1.time_ < var_194_2 + var_194_12 + arg_194_0 then
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
			local var_198_0 = 0
			local var_198_1 = 0.6

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[612].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:GetWordFromCfg(324151044)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 24
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151044", "story_v_out_324151.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151044", "story_v_out_324151.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_324151", "324151044", "story_v_out_324151.awb")

						arg_195_1:RecordAudio("324151044", var_198_9)
						arg_195_1:RecordAudio("324151044", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_324151", "324151044", "story_v_out_324151.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_324151", "324151044", "story_v_out_324151.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
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
			local var_202_0 = arg_199_1.actors_["10171ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10171ui_story == nil then
				arg_199_1.var_.characterEffect10171ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect10171ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10171ui_story then
				arg_199_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_202_4 = arg_199_1.actors_["1061ui_story"]
			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect1061ui_story == nil then
				arg_199_1.var_.characterEffect1061ui_story = var_202_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_6 = 0.200000002980232

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_6 and not isNil(var_202_4) then
				local var_202_7 = (arg_199_1.time_ - var_202_5) / var_202_6

				if arg_199_1.var_.characterEffect1061ui_story and not isNil(var_202_4) then
					local var_202_8 = Mathf.Lerp(0, 0.5, var_202_7)

					arg_199_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1061ui_story.fillRatio = var_202_8
				end
			end

			if arg_199_1.time_ >= var_202_5 + var_202_6 and arg_199_1.time_ < var_202_5 + var_202_6 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect1061ui_story then
				local var_202_9 = 0.5

				arg_199_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1061ui_story.fillRatio = var_202_9
			end

			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			local var_202_11 = 0

			if var_202_11 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 then
				arg_199_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_202_12 = 0
			local var_202_13 = 0.375

			if var_202_12 < arg_199_1.time_ and arg_199_1.time_ <= var_202_12 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_14 = arg_199_1:FormatText(StoryNameCfg[1451].name)

				arg_199_1.leftNameTxt_.text = var_202_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_15 = arg_199_1:GetWordFromCfg(324151045)
				local var_202_16 = arg_199_1:FormatText(var_202_15.content)

				arg_199_1.text_.text = var_202_16

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_17 = 15
				local var_202_18 = utf8.len(var_202_16)
				local var_202_19 = var_202_17 <= 0 and var_202_13 or var_202_13 * (var_202_18 / var_202_17)

				if var_202_19 > 0 and var_202_13 < var_202_19 then
					arg_199_1.talkMaxDuration = var_202_19

					if var_202_19 + var_202_12 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_19 + var_202_12
					end
				end

				arg_199_1.text_.text = var_202_16
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151045", "story_v_out_324151.awb") ~= 0 then
					local var_202_20 = manager.audio:GetVoiceLength("story_v_out_324151", "324151045", "story_v_out_324151.awb") / 1000

					if var_202_20 + var_202_12 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_20 + var_202_12
					end

					if var_202_15.prefab_name ~= "" and arg_199_1.actors_[var_202_15.prefab_name] ~= nil then
						local var_202_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_15.prefab_name].transform, "story_v_out_324151", "324151045", "story_v_out_324151.awb")

						arg_199_1:RecordAudio("324151045", var_202_21)
						arg_199_1:RecordAudio("324151045", var_202_21)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_324151", "324151045", "story_v_out_324151.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_324151", "324151045", "story_v_out_324151.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_22 = math.max(var_202_13, arg_199_1.talkMaxDuration)

			if var_202_12 <= arg_199_1.time_ and arg_199_1.time_ < var_202_12 + var_202_22 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_12) / var_202_22

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_12 + var_202_22 and arg_199_1.time_ < var_202_12 + var_202_22 + arg_202_0 then
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
			local var_206_0 = arg_203_1.actors_["1061ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1061ui_story == nil then
				arg_203_1.var_.characterEffect1061ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1061ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1061ui_story then
				arg_203_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_206_4 = arg_203_1.actors_["10171ui_story"]
			local var_206_5 = 0

			if var_206_5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect10171ui_story == nil then
				arg_203_1.var_.characterEffect10171ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_6 = 0.200000002980232

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_6 and not isNil(var_206_4) then
				local var_206_7 = (arg_203_1.time_ - var_206_5) / var_206_6

				if arg_203_1.var_.characterEffect10171ui_story and not isNil(var_206_4) then
					local var_206_8 = Mathf.Lerp(0, 0.5, var_206_7)

					arg_203_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10171ui_story.fillRatio = var_206_8
				end
			end

			if arg_203_1.time_ >= var_206_5 + var_206_6 and arg_203_1.time_ < var_206_5 + var_206_6 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect10171ui_story then
				local var_206_9 = 0.5

				arg_203_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10171ui_story.fillRatio = var_206_9
			end

			local var_206_10 = 0
			local var_206_11 = 0.475

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_12 = arg_203_1:FormatText(StoryNameCfg[612].name)

				arg_203_1.leftNameTxt_.text = var_206_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_13 = arg_203_1:GetWordFromCfg(324151046)
				local var_206_14 = arg_203_1:FormatText(var_206_13.content)

				arg_203_1.text_.text = var_206_14

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_15 = 19
				local var_206_16 = utf8.len(var_206_14)
				local var_206_17 = var_206_15 <= 0 and var_206_11 or var_206_11 * (var_206_16 / var_206_15)

				if var_206_17 > 0 and var_206_11 < var_206_17 then
					arg_203_1.talkMaxDuration = var_206_17

					if var_206_17 + var_206_10 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_17 + var_206_10
					end
				end

				arg_203_1.text_.text = var_206_14
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151046", "story_v_out_324151.awb") ~= 0 then
					local var_206_18 = manager.audio:GetVoiceLength("story_v_out_324151", "324151046", "story_v_out_324151.awb") / 1000

					if var_206_18 + var_206_10 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_18 + var_206_10
					end

					if var_206_13.prefab_name ~= "" and arg_203_1.actors_[var_206_13.prefab_name] ~= nil then
						local var_206_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_13.prefab_name].transform, "story_v_out_324151", "324151046", "story_v_out_324151.awb")

						arg_203_1:RecordAudio("324151046", var_206_19)
						arg_203_1:RecordAudio("324151046", var_206_19)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_324151", "324151046", "story_v_out_324151.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_324151", "324151046", "story_v_out_324151.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_20 = math.max(var_206_11, arg_203_1.talkMaxDuration)

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_20 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_10) / var_206_20

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_10 + var_206_20 and arg_203_1.time_ < var_206_10 + var_206_20 + arg_206_0 then
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
			local var_210_0 = arg_207_1.actors_["10171ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10171ui_story == nil then
				arg_207_1.var_.characterEffect10171ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect10171ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10171ui_story then
				arg_207_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_210_4 = arg_207_1.actors_["1061ui_story"]
			local var_210_5 = 0

			if var_210_5 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1061ui_story == nil then
				arg_207_1.var_.characterEffect1061ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_6 and not isNil(var_210_4) then
				local var_210_7 = (arg_207_1.time_ - var_210_5) / var_210_6

				if arg_207_1.var_.characterEffect1061ui_story and not isNil(var_210_4) then
					local var_210_8 = Mathf.Lerp(0, 0.5, var_210_7)

					arg_207_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1061ui_story.fillRatio = var_210_8
				end
			end

			if arg_207_1.time_ >= var_210_5 + var_210_6 and arg_207_1.time_ < var_210_5 + var_210_6 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1061ui_story then
				local var_210_9 = 0.5

				arg_207_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1061ui_story.fillRatio = var_210_9
			end

			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action43034")
			end

			local var_210_11 = 0

			if var_210_11 < arg_207_1.time_ and arg_207_1.time_ <= var_210_11 + arg_210_0 then
				arg_207_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_210_12 = 0
			local var_210_13 = 0.9

			if var_210_12 < arg_207_1.time_ and arg_207_1.time_ <= var_210_12 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_14 = arg_207_1:FormatText(StoryNameCfg[1451].name)

				arg_207_1.leftNameTxt_.text = var_210_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_15 = arg_207_1:GetWordFromCfg(324151047)
				local var_210_16 = arg_207_1:FormatText(var_210_15.content)

				arg_207_1.text_.text = var_210_16

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_17 = 36
				local var_210_18 = utf8.len(var_210_16)
				local var_210_19 = var_210_17 <= 0 and var_210_13 or var_210_13 * (var_210_18 / var_210_17)

				if var_210_19 > 0 and var_210_13 < var_210_19 then
					arg_207_1.talkMaxDuration = var_210_19

					if var_210_19 + var_210_12 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_19 + var_210_12
					end
				end

				arg_207_1.text_.text = var_210_16
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151047", "story_v_out_324151.awb") ~= 0 then
					local var_210_20 = manager.audio:GetVoiceLength("story_v_out_324151", "324151047", "story_v_out_324151.awb") / 1000

					if var_210_20 + var_210_12 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_20 + var_210_12
					end

					if var_210_15.prefab_name ~= "" and arg_207_1.actors_[var_210_15.prefab_name] ~= nil then
						local var_210_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_15.prefab_name].transform, "story_v_out_324151", "324151047", "story_v_out_324151.awb")

						arg_207_1:RecordAudio("324151047", var_210_21)
						arg_207_1:RecordAudio("324151047", var_210_21)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_324151", "324151047", "story_v_out_324151.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_324151", "324151047", "story_v_out_324151.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_22 = math.max(var_210_13, arg_207_1.talkMaxDuration)

			if var_210_12 <= arg_207_1.time_ and arg_207_1.time_ < var_210_12 + var_210_22 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_12) / var_210_22

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_12 + var_210_22 and arg_207_1.time_ < var_210_12 + var_210_22 + arg_210_0 then
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
			local var_214_0 = arg_211_1.actors_["10171ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos10171ui_story = var_214_0.localPosition

				local var_214_2 = GameObjectTools.GetOrAddComponent(var_214_0.gameObject, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(false)
				end
			end

			local var_214_3 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_3 then
				local var_214_4 = (arg_211_1.time_ - var_214_1) / var_214_3
				local var_214_5 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10171ui_story, var_214_5, var_214_4)

				local var_214_6 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_6.x, var_214_6.y, var_214_6.z)

				local var_214_7 = var_214_0.localEulerAngles

				var_214_7.z = 0
				var_214_7.x = 0
				var_214_0.localEulerAngles = var_214_7
			end

			if arg_211_1.time_ >= var_214_1 + var_214_3 and arg_211_1.time_ < var_214_1 + var_214_3 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_8 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_8.x, var_214_8.y, var_214_8.z)

				local var_214_9 = var_214_0.localEulerAngles

				var_214_9.z = 0
				var_214_9.x = 0
				var_214_0.localEulerAngles = var_214_9

				local var_214_10 = GameObjectTools.GetOrAddComponent(var_214_0.gameObject, typeof(DynamicBoneHelper))

				if var_214_10 then
					var_214_10:EnableDynamicBone(true)
				end
			end

			local var_214_11 = arg_211_1.actors_["1061ui_story"].transform
			local var_214_12 = 0

			if var_214_12 < arg_211_1.time_ and arg_211_1.time_ <= var_214_12 + arg_214_0 then
				arg_211_1.var_.moveOldPos1061ui_story = var_214_11.localPosition
			end

			local var_214_13 = 0.001

			if var_214_12 <= arg_211_1.time_ and arg_211_1.time_ < var_214_12 + var_214_13 then
				local var_214_14 = (arg_211_1.time_ - var_214_12) / var_214_13
				local var_214_15 = Vector3.New(0, 100, 0)

				var_214_11.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1061ui_story, var_214_15, var_214_14)

				local var_214_16 = manager.ui.mainCamera.transform.position - var_214_11.position

				var_214_11.forward = Vector3.New(var_214_16.x, var_214_16.y, var_214_16.z)

				local var_214_17 = var_214_11.localEulerAngles

				var_214_17.z = 0
				var_214_17.x = 0
				var_214_11.localEulerAngles = var_214_17
			end

			if arg_211_1.time_ >= var_214_12 + var_214_13 and arg_211_1.time_ < var_214_12 + var_214_13 + arg_214_0 then
				var_214_11.localPosition = Vector3.New(0, 100, 0)

				local var_214_18 = manager.ui.mainCamera.transform.position - var_214_11.position

				var_214_11.forward = Vector3.New(var_214_18.x, var_214_18.y, var_214_18.z)

				local var_214_19 = var_214_11.localEulerAngles

				var_214_19.z = 0
				var_214_19.x = 0
				var_214_11.localEulerAngles = var_214_19
			end

			local var_214_20 = arg_211_1.actors_["10171ui_story"]
			local var_214_21 = 0

			if var_214_21 < arg_211_1.time_ and arg_211_1.time_ <= var_214_21 + arg_214_0 and not isNil(var_214_20) and arg_211_1.var_.characterEffect10171ui_story == nil then
				arg_211_1.var_.characterEffect10171ui_story = var_214_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_22 = 0.200000002980232

			if var_214_21 <= arg_211_1.time_ and arg_211_1.time_ < var_214_21 + var_214_22 and not isNil(var_214_20) then
				local var_214_23 = (arg_211_1.time_ - var_214_21) / var_214_22

				if arg_211_1.var_.characterEffect10171ui_story and not isNil(var_214_20) then
					local var_214_24 = Mathf.Lerp(0, 0.5, var_214_23)

					arg_211_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_211_1.var_.characterEffect10171ui_story.fillRatio = var_214_24
				end
			end

			if arg_211_1.time_ >= var_214_21 + var_214_22 and arg_211_1.time_ < var_214_21 + var_214_22 + arg_214_0 and not isNil(var_214_20) and arg_211_1.var_.characterEffect10171ui_story then
				local var_214_25 = 0.5

				arg_211_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_211_1.var_.characterEffect10171ui_story.fillRatio = var_214_25
			end

			local var_214_26 = 0
			local var_214_27 = 1.575

			if var_214_26 < arg_211_1.time_ and arg_211_1.time_ <= var_214_26 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_28 = arg_211_1:GetWordFromCfg(324151048)
				local var_214_29 = arg_211_1:FormatText(var_214_28.content)

				arg_211_1.text_.text = var_214_29

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_30 = 63
				local var_214_31 = utf8.len(var_214_29)
				local var_214_32 = var_214_30 <= 0 and var_214_27 or var_214_27 * (var_214_31 / var_214_30)

				if var_214_32 > 0 and var_214_27 < var_214_32 then
					arg_211_1.talkMaxDuration = var_214_32

					if var_214_32 + var_214_26 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_32 + var_214_26
					end
				end

				arg_211_1.text_.text = var_214_29
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_33 = math.max(var_214_27, arg_211_1.talkMaxDuration)

			if var_214_26 <= arg_211_1.time_ and arg_211_1.time_ < var_214_26 + var_214_33 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_26) / var_214_33

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_26 + var_214_33 and arg_211_1.time_ < var_214_26 + var_214_33 + arg_214_0 then
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
			local var_218_0 = 0
			local var_218_1 = 1.25

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(324151049)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 50
				local var_218_5 = utf8.len(var_218_3)
				local var_218_6 = var_218_4 <= 0 and var_218_1 or var_218_1 * (var_218_5 / var_218_4)

				if var_218_6 > 0 and var_218_1 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_7 and arg_215_1.time_ < var_218_0 + var_218_7 + arg_218_0 then
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
			local var_222_0 = arg_219_1.actors_["1061ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1061ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1061ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["1061ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1061ui_story == nil then
				arg_219_1.var_.characterEffect1061ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect1061ui_story and not isNil(var_222_9) then
					arg_219_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1061ui_story then
				arg_219_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_222_13 = 0

			if var_222_13 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				arg_219_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_222_15 = 0
			local var_222_16 = 0.175

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_17 = arg_219_1:FormatText(StoryNameCfg[612].name)

				arg_219_1.leftNameTxt_.text = var_222_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_18 = arg_219_1:GetWordFromCfg(324151050)
				local var_222_19 = arg_219_1:FormatText(var_222_18.content)

				arg_219_1.text_.text = var_222_19

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_20 = 7
				local var_222_21 = utf8.len(var_222_19)
				local var_222_22 = var_222_20 <= 0 and var_222_16 or var_222_16 * (var_222_21 / var_222_20)

				if var_222_22 > 0 and var_222_16 < var_222_22 then
					arg_219_1.talkMaxDuration = var_222_22

					if var_222_22 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_22 + var_222_15
					end
				end

				arg_219_1.text_.text = var_222_19
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151050", "story_v_out_324151.awb") ~= 0 then
					local var_222_23 = manager.audio:GetVoiceLength("story_v_out_324151", "324151050", "story_v_out_324151.awb") / 1000

					if var_222_23 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_23 + var_222_15
					end

					if var_222_18.prefab_name ~= "" and arg_219_1.actors_[var_222_18.prefab_name] ~= nil then
						local var_222_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_18.prefab_name].transform, "story_v_out_324151", "324151050", "story_v_out_324151.awb")

						arg_219_1:RecordAudio("324151050", var_222_24)
						arg_219_1:RecordAudio("324151050", var_222_24)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_324151", "324151050", "story_v_out_324151.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_324151", "324151050", "story_v_out_324151.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_25 = math.max(var_222_16, arg_219_1.talkMaxDuration)

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_25 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_15) / var_222_25

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_15 + var_222_25 and arg_219_1.time_ < var_222_15 + var_222_25 + arg_222_0 then
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
			local var_226_0 = arg_223_1.actors_["10171ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos10171ui_story = var_226_0.localPosition

				local var_226_2 = GameObjectTools.GetOrAddComponent(var_226_0.gameObject, typeof(DynamicBoneHelper))

				if var_226_2 then
					var_226_2:EnableDynamicBone(false)
				end
			end

			local var_226_3 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_3 then
				local var_226_4 = (arg_223_1.time_ - var_226_1) / var_226_3
				local var_226_5 = Vector3.New(0.7, -0.95, -6.05)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10171ui_story, var_226_5, var_226_4)

				local var_226_6 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_6.x, var_226_6.y, var_226_6.z)

				local var_226_7 = var_226_0.localEulerAngles

				var_226_7.z = 0
				var_226_7.x = 0
				var_226_0.localEulerAngles = var_226_7
			end

			if arg_223_1.time_ >= var_226_1 + var_226_3 and arg_223_1.time_ < var_226_1 + var_226_3 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_226_8 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_8.x, var_226_8.y, var_226_8.z)

				local var_226_9 = var_226_0.localEulerAngles

				var_226_9.z = 0
				var_226_9.x = 0
				var_226_0.localEulerAngles = var_226_9

				local var_226_10 = GameObjectTools.GetOrAddComponent(var_226_0.gameObject, typeof(DynamicBoneHelper))

				if var_226_10 then
					var_226_10:EnableDynamicBone(true)
				end
			end

			local var_226_11 = arg_223_1.actors_["10171ui_story"]
			local var_226_12 = 0

			if var_226_12 < arg_223_1.time_ and arg_223_1.time_ <= var_226_12 + arg_226_0 and not isNil(var_226_11) and arg_223_1.var_.characterEffect10171ui_story == nil then
				arg_223_1.var_.characterEffect10171ui_story = var_226_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_13 = 0.200000002980232

			if var_226_12 <= arg_223_1.time_ and arg_223_1.time_ < var_226_12 + var_226_13 and not isNil(var_226_11) then
				local var_226_14 = (arg_223_1.time_ - var_226_12) / var_226_13

				if arg_223_1.var_.characterEffect10171ui_story and not isNil(var_226_11) then
					arg_223_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_12 + var_226_13 and arg_223_1.time_ < var_226_12 + var_226_13 + arg_226_0 and not isNil(var_226_11) and arg_223_1.var_.characterEffect10171ui_story then
				arg_223_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_226_15 = arg_223_1.actors_["1061ui_story"]
			local var_226_16 = 0

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 and not isNil(var_226_15) and arg_223_1.var_.characterEffect1061ui_story == nil then
				arg_223_1.var_.characterEffect1061ui_story = var_226_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_17 = 0.200000002980232

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_17 and not isNil(var_226_15) then
				local var_226_18 = (arg_223_1.time_ - var_226_16) / var_226_17

				if arg_223_1.var_.characterEffect1061ui_story and not isNil(var_226_15) then
					local var_226_19 = Mathf.Lerp(0, 0.5, var_226_18)

					arg_223_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1061ui_story.fillRatio = var_226_19
				end
			end

			if arg_223_1.time_ >= var_226_16 + var_226_17 and arg_223_1.time_ < var_226_16 + var_226_17 + arg_226_0 and not isNil(var_226_15) and arg_223_1.var_.characterEffect1061ui_story then
				local var_226_20 = 0.5

				arg_223_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1061ui_story.fillRatio = var_226_20
			end

			local var_226_21 = 0

			if var_226_21 < arg_223_1.time_ and arg_223_1.time_ <= var_226_21 + arg_226_0 then
				arg_223_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			local var_226_22 = 0

			if var_226_22 < arg_223_1.time_ and arg_223_1.time_ <= var_226_22 + arg_226_0 then
				arg_223_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_226_23 = 0
			local var_226_24 = 0.975

			if var_226_23 < arg_223_1.time_ and arg_223_1.time_ <= var_226_23 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_25 = arg_223_1:FormatText(StoryNameCfg[1451].name)

				arg_223_1.leftNameTxt_.text = var_226_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_26 = arg_223_1:GetWordFromCfg(324151051)
				local var_226_27 = arg_223_1:FormatText(var_226_26.content)

				arg_223_1.text_.text = var_226_27

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_28 = 39
				local var_226_29 = utf8.len(var_226_27)
				local var_226_30 = var_226_28 <= 0 and var_226_24 or var_226_24 * (var_226_29 / var_226_28)

				if var_226_30 > 0 and var_226_24 < var_226_30 then
					arg_223_1.talkMaxDuration = var_226_30

					if var_226_30 + var_226_23 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_30 + var_226_23
					end
				end

				arg_223_1.text_.text = var_226_27
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151051", "story_v_out_324151.awb") ~= 0 then
					local var_226_31 = manager.audio:GetVoiceLength("story_v_out_324151", "324151051", "story_v_out_324151.awb") / 1000

					if var_226_31 + var_226_23 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_31 + var_226_23
					end

					if var_226_26.prefab_name ~= "" and arg_223_1.actors_[var_226_26.prefab_name] ~= nil then
						local var_226_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_26.prefab_name].transform, "story_v_out_324151", "324151051", "story_v_out_324151.awb")

						arg_223_1:RecordAudio("324151051", var_226_32)
						arg_223_1:RecordAudio("324151051", var_226_32)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_324151", "324151051", "story_v_out_324151.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_324151", "324151051", "story_v_out_324151.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_33 = math.max(var_226_24, arg_223_1.talkMaxDuration)

			if var_226_23 <= arg_223_1.time_ and arg_223_1.time_ < var_226_23 + var_226_33 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_23) / var_226_33

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_23 + var_226_33 and arg_223_1.time_ < var_226_23 + var_226_33 + arg_226_0 then
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
			local var_230_0 = 0
			local var_230_1 = 1.3

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[1451].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_3 = arg_227_1:GetWordFromCfg(324151052)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 52
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151052", "story_v_out_324151.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151052", "story_v_out_324151.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_324151", "324151052", "story_v_out_324151.awb")

						arg_227_1:RecordAudio("324151052", var_230_9)
						arg_227_1:RecordAudio("324151052", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_324151", "324151052", "story_v_out_324151.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_324151", "324151052", "story_v_out_324151.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
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
			local var_234_0 = arg_231_1.actors_["1061ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1061ui_story == nil then
				arg_231_1.var_.characterEffect1061ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1061ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1061ui_story then
				arg_231_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_234_4 = arg_231_1.actors_["10171ui_story"]
			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect10171ui_story == nil then
				arg_231_1.var_.characterEffect10171ui_story = var_234_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 and not isNil(var_234_4) then
				local var_234_7 = (arg_231_1.time_ - var_234_5) / var_234_6

				if arg_231_1.var_.characterEffect10171ui_story and not isNil(var_234_4) then
					local var_234_8 = Mathf.Lerp(0, 0.5, var_234_7)

					arg_231_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10171ui_story.fillRatio = var_234_8
				end
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect10171ui_story then
				local var_234_9 = 0.5

				arg_231_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10171ui_story.fillRatio = var_234_9
			end

			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_234_11 = 0

			if var_234_11 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				arg_231_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_234_12 = 0
			local var_234_13 = 0.975

			if var_234_12 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_14 = arg_231_1:FormatText(StoryNameCfg[612].name)

				arg_231_1.leftNameTxt_.text = var_234_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_15 = arg_231_1:GetWordFromCfg(324151053)
				local var_234_16 = arg_231_1:FormatText(var_234_15.content)

				arg_231_1.text_.text = var_234_16

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_17 = 39
				local var_234_18 = utf8.len(var_234_16)
				local var_234_19 = var_234_17 <= 0 and var_234_13 or var_234_13 * (var_234_18 / var_234_17)

				if var_234_19 > 0 and var_234_13 < var_234_19 then
					arg_231_1.talkMaxDuration = var_234_19

					if var_234_19 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_12
					end
				end

				arg_231_1.text_.text = var_234_16
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151053", "story_v_out_324151.awb") ~= 0 then
					local var_234_20 = manager.audio:GetVoiceLength("story_v_out_324151", "324151053", "story_v_out_324151.awb") / 1000

					if var_234_20 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_20 + var_234_12
					end

					if var_234_15.prefab_name ~= "" and arg_231_1.actors_[var_234_15.prefab_name] ~= nil then
						local var_234_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_15.prefab_name].transform, "story_v_out_324151", "324151053", "story_v_out_324151.awb")

						arg_231_1:RecordAudio("324151053", var_234_21)
						arg_231_1:RecordAudio("324151053", var_234_21)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_324151", "324151053", "story_v_out_324151.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_324151", "324151053", "story_v_out_324151.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_22 = math.max(var_234_13, arg_231_1.talkMaxDuration)

			if var_234_12 <= arg_231_1.time_ and arg_231_1.time_ < var_234_12 + var_234_22 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_12) / var_234_22

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_12 + var_234_22 and arg_231_1.time_ < var_234_12 + var_234_22 + arg_234_0 then
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
			local var_238_0 = arg_235_1.actors_["10171ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect10171ui_story == nil then
				arg_235_1.var_.characterEffect10171ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect10171ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect10171ui_story then
				arg_235_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_238_4 = arg_235_1.actors_["1061ui_story"]
			local var_238_5 = 0

			if var_238_5 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1061ui_story == nil then
				arg_235_1.var_.characterEffect1061ui_story = var_238_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_6 = 0.200000002980232

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_6 and not isNil(var_238_4) then
				local var_238_7 = (arg_235_1.time_ - var_238_5) / var_238_6

				if arg_235_1.var_.characterEffect1061ui_story and not isNil(var_238_4) then
					local var_238_8 = Mathf.Lerp(0, 0.5, var_238_7)

					arg_235_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1061ui_story.fillRatio = var_238_8
				end
			end

			if arg_235_1.time_ >= var_238_5 + var_238_6 and arg_235_1.time_ < var_238_5 + var_238_6 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1061ui_story then
				local var_238_9 = 0.5

				arg_235_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1061ui_story.fillRatio = var_238_9
			end

			local var_238_10 = 0
			local var_238_11 = 0.3

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_12 = arg_235_1:FormatText(StoryNameCfg[1451].name)

				arg_235_1.leftNameTxt_.text = var_238_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_13 = arg_235_1:GetWordFromCfg(324151054)
				local var_238_14 = arg_235_1:FormatText(var_238_13.content)

				arg_235_1.text_.text = var_238_14

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_15 = 12
				local var_238_16 = utf8.len(var_238_14)
				local var_238_17 = var_238_15 <= 0 and var_238_11 or var_238_11 * (var_238_16 / var_238_15)

				if var_238_17 > 0 and var_238_11 < var_238_17 then
					arg_235_1.talkMaxDuration = var_238_17

					if var_238_17 + var_238_10 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_17 + var_238_10
					end
				end

				arg_235_1.text_.text = var_238_14
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151054", "story_v_out_324151.awb") ~= 0 then
					local var_238_18 = manager.audio:GetVoiceLength("story_v_out_324151", "324151054", "story_v_out_324151.awb") / 1000

					if var_238_18 + var_238_10 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_18 + var_238_10
					end

					if var_238_13.prefab_name ~= "" and arg_235_1.actors_[var_238_13.prefab_name] ~= nil then
						local var_238_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_13.prefab_name].transform, "story_v_out_324151", "324151054", "story_v_out_324151.awb")

						arg_235_1:RecordAudio("324151054", var_238_19)
						arg_235_1:RecordAudio("324151054", var_238_19)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_324151", "324151054", "story_v_out_324151.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_324151", "324151054", "story_v_out_324151.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_20 = math.max(var_238_11, arg_235_1.talkMaxDuration)

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_20 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_10) / var_238_20

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_10 + var_238_20 and arg_235_1.time_ < var_238_10 + var_238_20 + arg_238_0 then
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
			local var_242_0 = arg_239_1.actors_["1061ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1061ui_story == nil then
				arg_239_1.var_.characterEffect1061ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect1061ui_story and not isNil(var_242_0) then
					arg_239_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1061ui_story then
				arg_239_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_242_4 = arg_239_1.actors_["10171ui_story"]
			local var_242_5 = 0

			if var_242_5 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect10171ui_story == nil then
				arg_239_1.var_.characterEffect10171ui_story = var_242_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_6 = 0.200000002980232

			if var_242_5 <= arg_239_1.time_ and arg_239_1.time_ < var_242_5 + var_242_6 and not isNil(var_242_4) then
				local var_242_7 = (arg_239_1.time_ - var_242_5) / var_242_6

				if arg_239_1.var_.characterEffect10171ui_story and not isNil(var_242_4) then
					local var_242_8 = Mathf.Lerp(0, 0.5, var_242_7)

					arg_239_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10171ui_story.fillRatio = var_242_8
				end
			end

			if arg_239_1.time_ >= var_242_5 + var_242_6 and arg_239_1.time_ < var_242_5 + var_242_6 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect10171ui_story then
				local var_242_9 = 0.5

				arg_239_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10171ui_story.fillRatio = var_242_9
			end

			local var_242_10 = 0
			local var_242_11 = 1.025

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_12 = arg_239_1:FormatText(StoryNameCfg[612].name)

				arg_239_1.leftNameTxt_.text = var_242_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_13 = arg_239_1:GetWordFromCfg(324151055)
				local var_242_14 = arg_239_1:FormatText(var_242_13.content)

				arg_239_1.text_.text = var_242_14

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_15 = 41
				local var_242_16 = utf8.len(var_242_14)
				local var_242_17 = var_242_15 <= 0 and var_242_11 or var_242_11 * (var_242_16 / var_242_15)

				if var_242_17 > 0 and var_242_11 < var_242_17 then
					arg_239_1.talkMaxDuration = var_242_17

					if var_242_17 + var_242_10 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_17 + var_242_10
					end
				end

				arg_239_1.text_.text = var_242_14
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151055", "story_v_out_324151.awb") ~= 0 then
					local var_242_18 = manager.audio:GetVoiceLength("story_v_out_324151", "324151055", "story_v_out_324151.awb") / 1000

					if var_242_18 + var_242_10 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_18 + var_242_10
					end

					if var_242_13.prefab_name ~= "" and arg_239_1.actors_[var_242_13.prefab_name] ~= nil then
						local var_242_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_13.prefab_name].transform, "story_v_out_324151", "324151055", "story_v_out_324151.awb")

						arg_239_1:RecordAudio("324151055", var_242_19)
						arg_239_1:RecordAudio("324151055", var_242_19)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_324151", "324151055", "story_v_out_324151.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_324151", "324151055", "story_v_out_324151.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_20 = math.max(var_242_11, arg_239_1.talkMaxDuration)

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_20 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_10) / var_242_20

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_10 + var_242_20 and arg_239_1.time_ < var_242_10 + var_242_20 + arg_242_0 then
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
			local var_246_0 = 0

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_246_2 = 0
			local var_246_3 = 0.85

			if var_246_2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_4 = arg_243_1:FormatText(StoryNameCfg[612].name)

				arg_243_1.leftNameTxt_.text = var_246_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_5 = arg_243_1:GetWordFromCfg(324151056)
				local var_246_6 = arg_243_1:FormatText(var_246_5.content)

				arg_243_1.text_.text = var_246_6

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 34
				local var_246_8 = utf8.len(var_246_6)
				local var_246_9 = var_246_7 <= 0 and var_246_3 or var_246_3 * (var_246_8 / var_246_7)

				if var_246_9 > 0 and var_246_3 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_6
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151056", "story_v_out_324151.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151056", "story_v_out_324151.awb") / 1000

					if var_246_10 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_2
					end

					if var_246_5.prefab_name ~= "" and arg_243_1.actors_[var_246_5.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_5.prefab_name].transform, "story_v_out_324151", "324151056", "story_v_out_324151.awb")

						arg_243_1:RecordAudio("324151056", var_246_11)
						arg_243_1:RecordAudio("324151056", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_324151", "324151056", "story_v_out_324151.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_324151", "324151056", "story_v_out_324151.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_12 and arg_243_1.time_ < var_246_2 + var_246_12 + arg_246_0 then
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
			local var_250_0 = "J08"

			if arg_247_1.bgs_[var_250_0] == nil then
				local var_250_1 = Object.Instantiate(arg_247_1.paintGo_)

				var_250_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_250_0)
				var_250_1.name = var_250_0
				var_250_1.transform.parent = arg_247_1.stage_.transform
				var_250_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.bgs_[var_250_0] = var_250_1
			end

			local var_250_2 = 1.73333333333333

			if var_250_2 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				local var_250_3 = manager.ui.mainCamera.transform.localPosition
				local var_250_4 = Vector3.New(0, 0, 10) + Vector3.New(var_250_3.x, var_250_3.y, 0)
				local var_250_5 = arg_247_1.bgs_.J08

				var_250_5.transform.localPosition = var_250_4
				var_250_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_6 = var_250_5:GetComponent("SpriteRenderer")

				if var_250_6 and var_250_6.sprite then
					local var_250_7 = (var_250_5.transform.localPosition - var_250_3).z
					local var_250_8 = manager.ui.mainCameraCom_
					local var_250_9 = 2 * var_250_7 * Mathf.Tan(var_250_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_250_10 = var_250_9 * var_250_8.aspect
					local var_250_11 = var_250_6.sprite.bounds.size.x
					local var_250_12 = var_250_6.sprite.bounds.size.y
					local var_250_13 = var_250_10 / var_250_11
					local var_250_14 = var_250_9 / var_250_12
					local var_250_15 = var_250_14 < var_250_13 and var_250_13 or var_250_14

					var_250_5.transform.localScale = Vector3.New(var_250_15, var_250_15, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "J08" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_16 = 1.73333333333333

			if var_250_16 < arg_247_1.time_ and arg_247_1.time_ <= var_250_16 + arg_250_0 then
				arg_247_1.allBtn_.enabled = false
			end

			local var_250_17 = 0.3

			if arg_247_1.time_ >= var_250_16 + var_250_17 and arg_247_1.time_ < var_250_16 + var_250_17 + arg_250_0 then
				arg_247_1.allBtn_.enabled = true
			end

			local var_250_18 = 0

			if var_250_18 < arg_247_1.time_ and arg_247_1.time_ <= var_250_18 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_19 = 1.73333333333333

			if var_250_18 <= arg_247_1.time_ and arg_247_1.time_ < var_250_18 + var_250_19 then
				local var_250_20 = (arg_247_1.time_ - var_250_18) / var_250_19
				local var_250_21 = Color.New(0, 0, 0)

				var_250_21.a = Mathf.Lerp(0, 1, var_250_20)
				arg_247_1.mask_.color = var_250_21
			end

			if arg_247_1.time_ >= var_250_18 + var_250_19 and arg_247_1.time_ < var_250_18 + var_250_19 + arg_250_0 then
				local var_250_22 = Color.New(0, 0, 0)

				var_250_22.a = 1
				arg_247_1.mask_.color = var_250_22
			end

			local var_250_23 = 1.73333333333333

			if var_250_23 < arg_247_1.time_ and arg_247_1.time_ <= var_250_23 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_24 = 2

			if var_250_23 <= arg_247_1.time_ and arg_247_1.time_ < var_250_23 + var_250_24 then
				local var_250_25 = (arg_247_1.time_ - var_250_23) / var_250_24
				local var_250_26 = Color.New(0, 0, 0)

				var_250_26.a = Mathf.Lerp(1, 0, var_250_25)
				arg_247_1.mask_.color = var_250_26
			end

			if arg_247_1.time_ >= var_250_23 + var_250_24 and arg_247_1.time_ < var_250_23 + var_250_24 + arg_250_0 then
				local var_250_27 = Color.New(0, 0, 0)
				local var_250_28 = 0

				arg_247_1.mask_.enabled = false
				var_250_27.a = var_250_28
				arg_247_1.mask_.color = var_250_27
			end

			local var_250_29 = arg_247_1.actors_["1061ui_story"].transform
			local var_250_30 = 1.73333333333333

			if var_250_30 < arg_247_1.time_ and arg_247_1.time_ <= var_250_30 + arg_250_0 then
				arg_247_1.var_.moveOldPos1061ui_story = var_250_29.localPosition
			end

			local var_250_31 = 0.001

			if var_250_30 <= arg_247_1.time_ and arg_247_1.time_ < var_250_30 + var_250_31 then
				local var_250_32 = (arg_247_1.time_ - var_250_30) / var_250_31
				local var_250_33 = Vector3.New(0, 100, 0)

				var_250_29.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1061ui_story, var_250_33, var_250_32)

				local var_250_34 = manager.ui.mainCamera.transform.position - var_250_29.position

				var_250_29.forward = Vector3.New(var_250_34.x, var_250_34.y, var_250_34.z)

				local var_250_35 = var_250_29.localEulerAngles

				var_250_35.z = 0
				var_250_35.x = 0
				var_250_29.localEulerAngles = var_250_35
			end

			if arg_247_1.time_ >= var_250_30 + var_250_31 and arg_247_1.time_ < var_250_30 + var_250_31 + arg_250_0 then
				var_250_29.localPosition = Vector3.New(0, 100, 0)

				local var_250_36 = manager.ui.mainCamera.transform.position - var_250_29.position

				var_250_29.forward = Vector3.New(var_250_36.x, var_250_36.y, var_250_36.z)

				local var_250_37 = var_250_29.localEulerAngles

				var_250_37.z = 0
				var_250_37.x = 0
				var_250_29.localEulerAngles = var_250_37
			end

			local var_250_38 = arg_247_1.actors_["10171ui_story"].transform
			local var_250_39 = 1.73333333333333

			if var_250_39 < arg_247_1.time_ and arg_247_1.time_ <= var_250_39 + arg_250_0 then
				arg_247_1.var_.moveOldPos10171ui_story = var_250_38.localPosition

				local var_250_40 = GameObjectTools.GetOrAddComponent(var_250_38.gameObject, typeof(DynamicBoneHelper))

				if var_250_40 then
					var_250_40:EnableDynamicBone(false)
				end
			end

			local var_250_41 = 0.001

			if var_250_39 <= arg_247_1.time_ and arg_247_1.time_ < var_250_39 + var_250_41 then
				local var_250_42 = (arg_247_1.time_ - var_250_39) / var_250_41
				local var_250_43 = Vector3.New(0, 100, 0)

				var_250_38.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10171ui_story, var_250_43, var_250_42)

				local var_250_44 = manager.ui.mainCamera.transform.position - var_250_38.position

				var_250_38.forward = Vector3.New(var_250_44.x, var_250_44.y, var_250_44.z)

				local var_250_45 = var_250_38.localEulerAngles

				var_250_45.z = 0
				var_250_45.x = 0
				var_250_38.localEulerAngles = var_250_45
			end

			if arg_247_1.time_ >= var_250_39 + var_250_41 and arg_247_1.time_ < var_250_39 + var_250_41 + arg_250_0 then
				var_250_38.localPosition = Vector3.New(0, 100, 0)

				local var_250_46 = manager.ui.mainCamera.transform.position - var_250_38.position

				var_250_38.forward = Vector3.New(var_250_46.x, var_250_46.y, var_250_46.z)

				local var_250_47 = var_250_38.localEulerAngles

				var_250_47.z = 0
				var_250_47.x = 0
				var_250_38.localEulerAngles = var_250_47

				local var_250_48 = GameObjectTools.GetOrAddComponent(var_250_38.gameObject, typeof(DynamicBoneHelper))

				if var_250_48 then
					var_250_48:EnableDynamicBone(true)
				end
			end

			local var_250_49 = arg_247_1.actors_["1061ui_story"]
			local var_250_50 = 1.73333333333333

			if var_250_50 < arg_247_1.time_ and arg_247_1.time_ <= var_250_50 + arg_250_0 and not isNil(var_250_49) and arg_247_1.var_.characterEffect1061ui_story == nil then
				arg_247_1.var_.characterEffect1061ui_story = var_250_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_51 = 0.200000002980232

			if var_250_50 <= arg_247_1.time_ and arg_247_1.time_ < var_250_50 + var_250_51 and not isNil(var_250_49) then
				local var_250_52 = (arg_247_1.time_ - var_250_50) / var_250_51

				if arg_247_1.var_.characterEffect1061ui_story and not isNil(var_250_49) then
					local var_250_53 = Mathf.Lerp(0, 0.5, var_250_52)

					arg_247_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1061ui_story.fillRatio = var_250_53
				end
			end

			if arg_247_1.time_ >= var_250_50 + var_250_51 and arg_247_1.time_ < var_250_50 + var_250_51 + arg_250_0 and not isNil(var_250_49) and arg_247_1.var_.characterEffect1061ui_story then
				local var_250_54 = 0.5

				arg_247_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1061ui_story.fillRatio = var_250_54
			end

			local var_250_55 = manager.ui.mainCamera.transform
			local var_250_56 = 1.73333333333333

			if var_250_56 < arg_247_1.time_ and arg_247_1.time_ <= var_250_56 + arg_250_0 then
				local var_250_57 = arg_247_1.var_.effect23231
				local var_250_58
				local var_250_59 = var_250_55

				if not var_250_57 then
					var_250_57 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_soundonly_keep"), var_250_59)
					var_250_57.name = "23231"
					arg_247_1.var_.effect23231 = var_250_57
				else
					var_250_57.transform:SetParent(var_250_59)
				end

				var_250_57.transform.localPosition = Vector3.New(0, 0, 0)
				var_250_57.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_250_60 = manager.ui.mainCamera.transform
			local var_250_61 = 1.73333333333333

			if var_250_61 < arg_247_1.time_ and arg_247_1.time_ <= var_250_61 + arg_250_0 then
				local var_250_62 = arg_247_1.var_.effect32421
				local var_250_63
				local var_250_64 = var_250_60

				if not var_250_62 then
					var_250_62 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), var_250_64)
					var_250_62.name = "32421"
					arg_247_1.var_.effect32421 = var_250_62
				else
					var_250_62.transform:SetParent(var_250_64)
				end

				var_250_62.transform.localPosition = Vector3.New(0, 0, 0)
				var_250_62.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_250_65 = 1.7777777777777777
				local var_250_66 = Screen.width / Screen.height
				local var_250_67 = var_250_66 / var_250_65
				local var_250_68 = Mathf.Max(var_250_65 / var_250_66, 1)

				var_250_62.transform.localScale = Vector3.New(var_250_62.transform.localScale.x * var_250_67, var_250_62.transform.localScale.y * var_250_68, var_250_62.transform.localScale.z)
			end

			local var_250_69 = 1.73333333333333

			arg_247_1.isInRecall_ = false

			if var_250_69 < arg_247_1.time_ and arg_247_1.time_ <= var_250_69 + arg_250_0 then
				arg_247_1.screenFilterGo_:SetActive(false)

				for iter_250_2, iter_250_3 in pairs(arg_247_1.actors_) do
					local var_250_70 = iter_250_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_250_4, iter_250_5 in ipairs(var_250_70) do
						if iter_250_5.color.r > 0.51 then
							iter_250_5.color = Color.New(1, 1, 1)
						else
							iter_250_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_250_71 = 0.034000001847744

			if var_250_69 <= arg_247_1.time_ and arg_247_1.time_ < var_250_69 + var_250_71 then
				local var_250_72 = (arg_247_1.time_ - var_250_69) / var_250_71

				arg_247_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_250_72)
			end

			if arg_247_1.time_ >= var_250_69 + var_250_71 and arg_247_1.time_ < var_250_69 + var_250_71 + arg_250_0 then
				arg_247_1.screenFilterEffect_.weight = 0
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_73 = 3.3
			local var_250_74 = 0.225

			if var_250_73 < arg_247_1.time_ and arg_247_1.time_ <= var_250_73 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_75 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_75:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_75:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_75:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_76 = arg_247_1:FormatText(StoryNameCfg[672].name)

				arg_247_1.leftNameTxt_.text = var_250_76

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_77 = arg_247_1:GetWordFromCfg(324151057)
				local var_250_78 = arg_247_1:FormatText(var_250_77.content)

				arg_247_1.text_.text = var_250_78

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_79 = 9
				local var_250_80 = utf8.len(var_250_78)
				local var_250_81 = var_250_79 <= 0 and var_250_74 or var_250_74 * (var_250_80 / var_250_79)

				if var_250_81 > 0 and var_250_74 < var_250_81 then
					arg_247_1.talkMaxDuration = var_250_81
					var_250_73 = var_250_73 + 0.3

					if var_250_81 + var_250_73 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_81 + var_250_73
					end
				end

				arg_247_1.text_.text = var_250_78
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151057", "story_v_out_324151.awb") ~= 0 then
					local var_250_82 = manager.audio:GetVoiceLength("story_v_out_324151", "324151057", "story_v_out_324151.awb") / 1000

					if var_250_82 + var_250_73 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_82 + var_250_73
					end

					if var_250_77.prefab_name ~= "" and arg_247_1.actors_[var_250_77.prefab_name] ~= nil then
						local var_250_83 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_77.prefab_name].transform, "story_v_out_324151", "324151057", "story_v_out_324151.awb")

						arg_247_1:RecordAudio("324151057", var_250_83)
						arg_247_1:RecordAudio("324151057", var_250_83)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_324151", "324151057", "story_v_out_324151.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_324151", "324151057", "story_v_out_324151.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_84 = var_250_73 + 0.3
			local var_250_85 = math.max(var_250_74, arg_247_1.talkMaxDuration)

			if var_250_84 <= arg_247_1.time_ and arg_247_1.time_ < var_250_84 + var_250_85 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_84) / var_250_85

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_84 + var_250_85 and arg_247_1.time_ < var_250_84 + var_250_85 + arg_250_0 then
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
			local var_256_0 = "J13f"

			if arg_253_1.bgs_[var_256_0] == nil then
				local var_256_1 = Object.Instantiate(arg_253_1.paintGo_)

				var_256_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_256_0)
				var_256_1.name = var_256_0
				var_256_1.transform.parent = arg_253_1.stage_.transform
				var_256_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.bgs_[var_256_0] = var_256_1
			end

			local var_256_2 = 0

			if var_256_2 < arg_253_1.time_ and arg_253_1.time_ <= var_256_2 + arg_256_0 then
				local var_256_3 = manager.ui.mainCamera.transform.localPosition
				local var_256_4 = Vector3.New(0, 0, 10) + Vector3.New(var_256_3.x, var_256_3.y, 0)
				local var_256_5 = arg_253_1.bgs_.J13f

				var_256_5.transform.localPosition = var_256_4
				var_256_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_256_6 = var_256_5:GetComponent("SpriteRenderer")

				if var_256_6 and var_256_6.sprite then
					local var_256_7 = (var_256_5.transform.localPosition - var_256_3).z
					local var_256_8 = manager.ui.mainCameraCom_
					local var_256_9 = 2 * var_256_7 * Mathf.Tan(var_256_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_256_10 = var_256_9 * var_256_8.aspect
					local var_256_11 = var_256_6.sprite.bounds.size.x
					local var_256_12 = var_256_6.sprite.bounds.size.y
					local var_256_13 = var_256_10 / var_256_11
					local var_256_14 = var_256_9 / var_256_12
					local var_256_15 = var_256_14 < var_256_13 and var_256_13 or var_256_14

					var_256_5.transform.localScale = Vector3.New(var_256_15, var_256_15, 0)
				end

				for iter_256_0, iter_256_1 in pairs(arg_253_1.bgs_) do
					if iter_256_0 ~= "J13f" then
						iter_256_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_256_16 = 0

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 then
				arg_253_1.allBtn_.enabled = false
			end

			local var_256_17 = 0.3

			if arg_253_1.time_ >= var_256_16 + var_256_17 and arg_253_1.time_ < var_256_16 + var_256_17 + arg_256_0 then
				arg_253_1.allBtn_.enabled = true
			end

			local var_256_18 = 0

			if var_256_18 < arg_253_1.time_ and arg_253_1.time_ <= var_256_18 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_19 = 1.49166666666667

			if var_256_18 <= arg_253_1.time_ and arg_253_1.time_ < var_256_18 + var_256_19 then
				local var_256_20 = (arg_253_1.time_ - var_256_18) / var_256_19
				local var_256_21 = Color.New(0, 0, 0)

				var_256_21.a = Mathf.Lerp(1, 0, var_256_20)
				arg_253_1.mask_.color = var_256_21
			end

			if arg_253_1.time_ >= var_256_18 + var_256_19 and arg_253_1.time_ < var_256_18 + var_256_19 + arg_256_0 then
				local var_256_22 = Color.New(0, 0, 0)
				local var_256_23 = 0

				arg_253_1.mask_.enabled = false
				var_256_22.a = var_256_23
				arg_253_1.mask_.color = var_256_22
			end

			if arg_253_1.frameCnt_ <= 1 then
				arg_253_1.dialog_:SetActive(false)
			end

			local var_256_24 = 1.36666666666667
			local var_256_25 = 0.125

			if var_256_24 < arg_253_1.time_ and arg_253_1.time_ <= var_256_24 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0

				arg_253_1.dialog_:SetActive(true)

				arg_253_1.dialogCg_.alpha = 0

				local var_256_26 = LeanTween.value(arg_253_1.dialog_, 0, 1, 0.3)

				var_256_26:setOnUpdate(LuaHelper.FloatAction(function(arg_257_0)
					arg_253_1.dialogCg_.alpha = arg_257_0
				end))
				var_256_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_253_1.dialog_)
					var_256_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_253_1.duration_ = arg_253_1.duration_ + 0.3

				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_27 = arg_253_1:FormatText(StoryNameCfg[672].name)

				arg_253_1.leftNameTxt_.text = var_256_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_28 = arg_253_1:GetWordFromCfg(324151058)
				local var_256_29 = arg_253_1:FormatText(var_256_28.content)

				arg_253_1.text_.text = var_256_29

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_30 = 5
				local var_256_31 = utf8.len(var_256_29)
				local var_256_32 = var_256_30 <= 0 and var_256_25 or var_256_25 * (var_256_31 / var_256_30)

				if var_256_32 > 0 and var_256_25 < var_256_32 then
					arg_253_1.talkMaxDuration = var_256_32
					var_256_24 = var_256_24 + 0.3

					if var_256_32 + var_256_24 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_32 + var_256_24
					end
				end

				arg_253_1.text_.text = var_256_29
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151058", "story_v_out_324151.awb") ~= 0 then
					local var_256_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151058", "story_v_out_324151.awb") / 1000

					if var_256_33 + var_256_24 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_33 + var_256_24
					end

					if var_256_28.prefab_name ~= "" and arg_253_1.actors_[var_256_28.prefab_name] ~= nil then
						local var_256_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_28.prefab_name].transform, "story_v_out_324151", "324151058", "story_v_out_324151.awb")

						arg_253_1:RecordAudio("324151058", var_256_34)
						arg_253_1:RecordAudio("324151058", var_256_34)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_324151", "324151058", "story_v_out_324151.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_324151", "324151058", "story_v_out_324151.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_35 = var_256_24 + 0.3
			local var_256_36 = math.max(var_256_25, arg_253_1.talkMaxDuration)

			if var_256_35 <= arg_253_1.time_ and arg_253_1.time_ < var_256_35 + var_256_36 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_35) / var_256_36

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_35 + var_256_36 and arg_253_1.time_ < var_256_35 + var_256_36 + arg_256_0 then
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
			local var_262_0 = "J23f"

			if arg_259_1.bgs_[var_262_0] == nil then
				local var_262_1 = Object.Instantiate(arg_259_1.paintGo_)

				var_262_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_262_0)
				var_262_1.name = var_262_0
				var_262_1.transform.parent = arg_259_1.stage_.transform
				var_262_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.bgs_[var_262_0] = var_262_1
			end

			local var_262_2 = 0

			if var_262_2 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				local var_262_3 = manager.ui.mainCamera.transform.localPosition
				local var_262_4 = Vector3.New(0, 0, 10) + Vector3.New(var_262_3.x, var_262_3.y, 0)
				local var_262_5 = arg_259_1.bgs_.J23f

				var_262_5.transform.localPosition = var_262_4
				var_262_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_262_6 = var_262_5:GetComponent("SpriteRenderer")

				if var_262_6 and var_262_6.sprite then
					local var_262_7 = (var_262_5.transform.localPosition - var_262_3).z
					local var_262_8 = manager.ui.mainCameraCom_
					local var_262_9 = 2 * var_262_7 * Mathf.Tan(var_262_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_262_10 = var_262_9 * var_262_8.aspect
					local var_262_11 = var_262_6.sprite.bounds.size.x
					local var_262_12 = var_262_6.sprite.bounds.size.y
					local var_262_13 = var_262_10 / var_262_11
					local var_262_14 = var_262_9 / var_262_12
					local var_262_15 = var_262_14 < var_262_13 and var_262_13 or var_262_14

					var_262_5.transform.localScale = Vector3.New(var_262_15, var_262_15, 0)
				end

				for iter_262_0, iter_262_1 in pairs(arg_259_1.bgs_) do
					if iter_262_0 ~= "J23f" then
						iter_262_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_262_16 = 0

			if var_262_16 < arg_259_1.time_ and arg_259_1.time_ <= var_262_16 + arg_262_0 then
				arg_259_1.allBtn_.enabled = false
			end

			local var_262_17 = 0.3

			if arg_259_1.time_ >= var_262_16 + var_262_17 and arg_259_1.time_ < var_262_16 + var_262_17 + arg_262_0 then
				arg_259_1.allBtn_.enabled = true
			end

			local var_262_18 = 0

			if var_262_18 < arg_259_1.time_ and arg_259_1.time_ <= var_262_18 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_19 = 1

			if var_262_18 <= arg_259_1.time_ and arg_259_1.time_ < var_262_18 + var_262_19 then
				local var_262_20 = (arg_259_1.time_ - var_262_18) / var_262_19
				local var_262_21 = Color.New(0, 0, 0)

				var_262_21.a = Mathf.Lerp(1, 0, var_262_20)
				arg_259_1.mask_.color = var_262_21
			end

			if arg_259_1.time_ >= var_262_18 + var_262_19 and arg_259_1.time_ < var_262_18 + var_262_19 + arg_262_0 then
				local var_262_22 = Color.New(0, 0, 0)
				local var_262_23 = 0

				arg_259_1.mask_.enabled = false
				var_262_22.a = var_262_23
				arg_259_1.mask_.color = var_262_22
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_24 = 1
			local var_262_25 = 0.05

			if var_262_24 < arg_259_1.time_ and arg_259_1.time_ <= var_262_24 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_26 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_26:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_27 = arg_259_1:FormatText(StoryNameCfg[672].name)

				arg_259_1.leftNameTxt_.text = var_262_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_28 = arg_259_1:GetWordFromCfg(324151059)
				local var_262_29 = arg_259_1:FormatText(var_262_28.content)

				arg_259_1.text_.text = var_262_29

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_30 = 2
				local var_262_31 = utf8.len(var_262_29)
				local var_262_32 = var_262_30 <= 0 and var_262_25 or var_262_25 * (var_262_31 / var_262_30)

				if var_262_32 > 0 and var_262_25 < var_262_32 then
					arg_259_1.talkMaxDuration = var_262_32
					var_262_24 = var_262_24 + 0.3

					if var_262_32 + var_262_24 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_32 + var_262_24
					end
				end

				arg_259_1.text_.text = var_262_29
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151059", "story_v_out_324151.awb") ~= 0 then
					local var_262_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151059", "story_v_out_324151.awb") / 1000

					if var_262_33 + var_262_24 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_33 + var_262_24
					end

					if var_262_28.prefab_name ~= "" and arg_259_1.actors_[var_262_28.prefab_name] ~= nil then
						local var_262_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_28.prefab_name].transform, "story_v_out_324151", "324151059", "story_v_out_324151.awb")

						arg_259_1:RecordAudio("324151059", var_262_34)
						arg_259_1:RecordAudio("324151059", var_262_34)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_324151", "324151059", "story_v_out_324151.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_324151", "324151059", "story_v_out_324151.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_35 = var_262_24 + 0.3
			local var_262_36 = math.max(var_262_25, arg_259_1.talkMaxDuration)

			if var_262_35 <= arg_259_1.time_ and arg_259_1.time_ < var_262_35 + var_262_36 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_35) / var_262_36

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_35 + var_262_36 and arg_259_1.time_ < var_262_35 + var_262_36 + arg_262_0 then
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
			local var_268_0 = "J24f"

			if arg_265_1.bgs_[var_268_0] == nil then
				local var_268_1 = Object.Instantiate(arg_265_1.paintGo_)

				var_268_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_268_0)
				var_268_1.name = var_268_0
				var_268_1.transform.parent = arg_265_1.stage_.transform
				var_268_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.bgs_[var_268_0] = var_268_1
			end

			local var_268_2 = 0

			if var_268_2 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				local var_268_3 = manager.ui.mainCamera.transform.localPosition
				local var_268_4 = Vector3.New(0, 0, 10) + Vector3.New(var_268_3.x, var_268_3.y, 0)
				local var_268_5 = arg_265_1.bgs_.J24f

				var_268_5.transform.localPosition = var_268_4
				var_268_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_6 = var_268_5:GetComponent("SpriteRenderer")

				if var_268_6 and var_268_6.sprite then
					local var_268_7 = (var_268_5.transform.localPosition - var_268_3).z
					local var_268_8 = manager.ui.mainCameraCom_
					local var_268_9 = 2 * var_268_7 * Mathf.Tan(var_268_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_268_10 = var_268_9 * var_268_8.aspect
					local var_268_11 = var_268_6.sprite.bounds.size.x
					local var_268_12 = var_268_6.sprite.bounds.size.y
					local var_268_13 = var_268_10 / var_268_11
					local var_268_14 = var_268_9 / var_268_12
					local var_268_15 = var_268_14 < var_268_13 and var_268_13 or var_268_14

					var_268_5.transform.localScale = Vector3.New(var_268_15, var_268_15, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "J24f" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			local var_268_17 = 0.3

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_18 = 0

			if var_268_18 < arg_265_1.time_ and arg_265_1.time_ <= var_268_18 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_19 = 0.933333333333333

			if var_268_18 <= arg_265_1.time_ and arg_265_1.time_ < var_268_18 + var_268_19 then
				local var_268_20 = (arg_265_1.time_ - var_268_18) / var_268_19
				local var_268_21 = Color.New(0, 0, 0)

				var_268_21.a = Mathf.Lerp(1, 0, var_268_20)
				arg_265_1.mask_.color = var_268_21
			end

			if arg_265_1.time_ >= var_268_18 + var_268_19 and arg_265_1.time_ < var_268_18 + var_268_19 + arg_268_0 then
				local var_268_22 = Color.New(0, 0, 0)
				local var_268_23 = 0

				arg_265_1.mask_.enabled = false
				var_268_22.a = var_268_23
				arg_265_1.mask_.color = var_268_22
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_24 = 0.533333333333333
			local var_268_25 = 0.05

			if var_268_24 < arg_265_1.time_ and arg_265_1.time_ <= var_268_24 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_26 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_26:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_27 = arg_265_1:FormatText(StoryNameCfg[672].name)

				arg_265_1.leftNameTxt_.text = var_268_27

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

				local var_268_28 = arg_265_1:GetWordFromCfg(324151060)
				local var_268_29 = arg_265_1:FormatText(var_268_28.content)

				arg_265_1.text_.text = var_268_29

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_30 = 2
				local var_268_31 = utf8.len(var_268_29)
				local var_268_32 = var_268_30 <= 0 and var_268_25 or var_268_25 * (var_268_31 / var_268_30)

				if var_268_32 > 0 and var_268_25 < var_268_32 then
					arg_265_1.talkMaxDuration = var_268_32
					var_268_24 = var_268_24 + 0.3

					if var_268_32 + var_268_24 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_32 + var_268_24
					end
				end

				arg_265_1.text_.text = var_268_29
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151060", "story_v_out_324151.awb") ~= 0 then
					local var_268_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151060", "story_v_out_324151.awb") / 1000

					if var_268_33 + var_268_24 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_33 + var_268_24
					end

					if var_268_28.prefab_name ~= "" and arg_265_1.actors_[var_268_28.prefab_name] ~= nil then
						local var_268_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_28.prefab_name].transform, "story_v_out_324151", "324151060", "story_v_out_324151.awb")

						arg_265_1:RecordAudio("324151060", var_268_34)
						arg_265_1:RecordAudio("324151060", var_268_34)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_324151", "324151060", "story_v_out_324151.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_324151", "324151060", "story_v_out_324151.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_35 = var_268_24 + 0.3
			local var_268_36 = math.max(var_268_25, arg_265_1.talkMaxDuration)

			if var_268_35 <= arg_265_1.time_ and arg_265_1.time_ < var_268_35 + var_268_36 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_35) / var_268_36

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_35 + var_268_36 and arg_265_1.time_ < var_268_35 + var_268_36 + arg_268_0 then
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
			local var_274_0 = "ST44"

			if arg_271_1.bgs_[var_274_0] == nil then
				local var_274_1 = Object.Instantiate(arg_271_1.paintGo_)

				var_274_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_274_0)
				var_274_1.name = var_274_0
				var_274_1.transform.parent = arg_271_1.stage_.transform
				var_274_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.bgs_[var_274_0] = var_274_1
			end

			local var_274_2 = 0

			if var_274_2 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				local var_274_3 = manager.ui.mainCamera.transform.localPosition
				local var_274_4 = Vector3.New(0, 0, 10) + Vector3.New(var_274_3.x, var_274_3.y, 0)
				local var_274_5 = arg_271_1.bgs_.ST44

				var_274_5.transform.localPosition = var_274_4
				var_274_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_6 = var_274_5:GetComponent("SpriteRenderer")

				if var_274_6 and var_274_6.sprite then
					local var_274_7 = (var_274_5.transform.localPosition - var_274_3).z
					local var_274_8 = manager.ui.mainCameraCom_
					local var_274_9 = 2 * var_274_7 * Mathf.Tan(var_274_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_274_10 = var_274_9 * var_274_8.aspect
					local var_274_11 = var_274_6.sprite.bounds.size.x
					local var_274_12 = var_274_6.sprite.bounds.size.y
					local var_274_13 = var_274_10 / var_274_11
					local var_274_14 = var_274_9 / var_274_12
					local var_274_15 = var_274_14 < var_274_13 and var_274_13 or var_274_14

					var_274_5.transform.localScale = Vector3.New(var_274_15, var_274_15, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "ST44" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_16 = 0

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.allBtn_.enabled = false
			end

			local var_274_17 = 0.3

			if arg_271_1.time_ >= var_274_16 + var_274_17 and arg_271_1.time_ < var_274_16 + var_274_17 + arg_274_0 then
				arg_271_1.allBtn_.enabled = true
			end

			local var_274_18 = 0

			if var_274_18 < arg_271_1.time_ and arg_271_1.time_ <= var_274_18 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_19 = 1.1

			if var_274_18 <= arg_271_1.time_ and arg_271_1.time_ < var_274_18 + var_274_19 then
				local var_274_20 = (arg_271_1.time_ - var_274_18) / var_274_19
				local var_274_21 = Color.New(0, 0, 0)

				var_274_21.a = Mathf.Lerp(1, 0, var_274_20)
				arg_271_1.mask_.color = var_274_21
			end

			if arg_271_1.time_ >= var_274_18 + var_274_19 and arg_271_1.time_ < var_274_18 + var_274_19 + arg_274_0 then
				local var_274_22 = Color.New(0, 0, 0)
				local var_274_23 = 0

				arg_271_1.mask_.enabled = false
				var_274_22.a = var_274_23
				arg_271_1.mask_.color = var_274_22
			end

			local var_274_24 = 0
			local var_274_25 = 0.05

			if var_274_24 < arg_271_1.time_ and arg_271_1.time_ <= var_274_24 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_26 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_26:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_27 = arg_271_1:FormatText(StoryNameCfg[672].name)

				arg_271_1.leftNameTxt_.text = var_274_27

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

				local var_274_28 = arg_271_1:GetWordFromCfg(324151061)
				local var_274_29 = arg_271_1:FormatText(var_274_28.content)

				arg_271_1.text_.text = var_274_29

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_30 = 2
				local var_274_31 = utf8.len(var_274_29)
				local var_274_32 = var_274_30 <= 0 and var_274_25 or var_274_25 * (var_274_31 / var_274_30)

				if var_274_32 > 0 and var_274_25 < var_274_32 then
					arg_271_1.talkMaxDuration = var_274_32
					var_274_24 = var_274_24 + 0.3

					if var_274_32 + var_274_24 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_32 + var_274_24
					end
				end

				arg_271_1.text_.text = var_274_29
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151061", "story_v_out_324151.awb") ~= 0 then
					local var_274_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151061", "story_v_out_324151.awb") / 1000

					if var_274_33 + var_274_24 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_33 + var_274_24
					end

					if var_274_28.prefab_name ~= "" and arg_271_1.actors_[var_274_28.prefab_name] ~= nil then
						local var_274_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_28.prefab_name].transform, "story_v_out_324151", "324151061", "story_v_out_324151.awb")

						arg_271_1:RecordAudio("324151061", var_274_34)
						arg_271_1:RecordAudio("324151061", var_274_34)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_324151", "324151061", "story_v_out_324151.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_324151", "324151061", "story_v_out_324151.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_35 = var_274_24 + 0.3
			local var_274_36 = math.max(var_274_25, arg_271_1.talkMaxDuration)

			if var_274_35 <= arg_271_1.time_ and arg_271_1.time_ < var_274_35 + var_274_36 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_35) / var_274_36

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_35 + var_274_36 and arg_271_1.time_ < var_274_35 + var_274_36 + arg_274_0 then
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
			local var_280_0 = "ST2009"

			if arg_277_1.bgs_[var_280_0] == nil then
				local var_280_1 = Object.Instantiate(arg_277_1.paintGo_)

				var_280_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_280_0)
				var_280_1.name = var_280_0
				var_280_1.transform.parent = arg_277_1.stage_.transform
				var_280_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_277_1.bgs_[var_280_0] = var_280_1
			end

			local var_280_2 = 0

			if var_280_2 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				local var_280_3 = manager.ui.mainCamera.transform.localPosition
				local var_280_4 = Vector3.New(0, 0, 10) + Vector3.New(var_280_3.x, var_280_3.y, 0)
				local var_280_5 = arg_277_1.bgs_.ST2009

				var_280_5.transform.localPosition = var_280_4
				var_280_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_280_6 = var_280_5:GetComponent("SpriteRenderer")

				if var_280_6 and var_280_6.sprite then
					local var_280_7 = (var_280_5.transform.localPosition - var_280_3).z
					local var_280_8 = manager.ui.mainCameraCom_
					local var_280_9 = 2 * var_280_7 * Mathf.Tan(var_280_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_280_10 = var_280_9 * var_280_8.aspect
					local var_280_11 = var_280_6.sprite.bounds.size.x
					local var_280_12 = var_280_6.sprite.bounds.size.y
					local var_280_13 = var_280_10 / var_280_11
					local var_280_14 = var_280_9 / var_280_12
					local var_280_15 = var_280_14 < var_280_13 and var_280_13 or var_280_14

					var_280_5.transform.localScale = Vector3.New(var_280_15, var_280_15, 0)
				end

				for iter_280_0, iter_280_1 in pairs(arg_277_1.bgs_) do
					if iter_280_0 ~= "ST2009" then
						iter_280_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_280_16 = 0

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			local var_280_17 = 0.3

			if arg_277_1.time_ >= var_280_16 + var_280_17 and arg_277_1.time_ < var_280_16 + var_280_17 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end

			local var_280_18 = 0

			if var_280_18 < arg_277_1.time_ and arg_277_1.time_ <= var_280_18 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_19 = 2

			if var_280_18 <= arg_277_1.time_ and arg_277_1.time_ < var_280_18 + var_280_19 then
				local var_280_20 = (arg_277_1.time_ - var_280_18) / var_280_19
				local var_280_21 = Color.New(0, 0, 0)

				var_280_21.a = Mathf.Lerp(1, 0, var_280_20)
				arg_277_1.mask_.color = var_280_21
			end

			if arg_277_1.time_ >= var_280_18 + var_280_19 and arg_277_1.time_ < var_280_18 + var_280_19 + arg_280_0 then
				local var_280_22 = Color.New(0, 0, 0)
				local var_280_23 = 0

				arg_277_1.mask_.enabled = false
				var_280_22.a = var_280_23
				arg_277_1.mask_.color = var_280_22
			end

			local var_280_24 = 0
			local var_280_25 = 0.05

			if var_280_24 < arg_277_1.time_ and arg_277_1.time_ <= var_280_24 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				arg_277_1.dialog_:SetActive(true)

				arg_277_1.dialogCg_.alpha = 0

				local var_280_26 = LeanTween.value(arg_277_1.dialog_, 0, 1, 0.3)

				var_280_26:setOnUpdate(LuaHelper.FloatAction(function(arg_281_0)
					arg_277_1.dialogCg_.alpha = arg_281_0
				end))
				var_280_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_277_1.dialog_)
					var_280_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_277_1.duration_ = arg_277_1.duration_ + 0.3

				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_27 = arg_277_1:FormatText(StoryNameCfg[672].name)

				arg_277_1.leftNameTxt_.text = var_280_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_28 = arg_277_1:GetWordFromCfg(324151062)
				local var_280_29 = arg_277_1:FormatText(var_280_28.content)

				arg_277_1.text_.text = var_280_29

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_30 = 2
				local var_280_31 = utf8.len(var_280_29)
				local var_280_32 = var_280_30 <= 0 and var_280_25 or var_280_25 * (var_280_31 / var_280_30)

				if var_280_32 > 0 and var_280_25 < var_280_32 then
					arg_277_1.talkMaxDuration = var_280_32
					var_280_24 = var_280_24 + 0.3

					if var_280_32 + var_280_24 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_32 + var_280_24
					end
				end

				arg_277_1.text_.text = var_280_29
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151062", "story_v_out_324151.awb") ~= 0 then
					local var_280_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151062", "story_v_out_324151.awb") / 1000

					if var_280_33 + var_280_24 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_33 + var_280_24
					end

					if var_280_28.prefab_name ~= "" and arg_277_1.actors_[var_280_28.prefab_name] ~= nil then
						local var_280_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_28.prefab_name].transform, "story_v_out_324151", "324151062", "story_v_out_324151.awb")

						arg_277_1:RecordAudio("324151062", var_280_34)
						arg_277_1:RecordAudio("324151062", var_280_34)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_324151", "324151062", "story_v_out_324151.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_324151", "324151062", "story_v_out_324151.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_35 = var_280_24 + 0.3
			local var_280_36 = math.max(var_280_25, arg_277_1.talkMaxDuration)

			if var_280_35 <= arg_277_1.time_ and arg_277_1.time_ < var_280_35 + var_280_36 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_35) / var_280_36

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_35 + var_280_36 and arg_277_1.time_ < var_280_35 + var_280_36 + arg_280_0 then
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
			local var_286_0 = "ST2005"

			if arg_283_1.bgs_[var_286_0] == nil then
				local var_286_1 = Object.Instantiate(arg_283_1.paintGo_)

				var_286_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_286_0)
				var_286_1.name = var_286_0
				var_286_1.transform.parent = arg_283_1.stage_.transform
				var_286_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_283_1.bgs_[var_286_0] = var_286_1
			end

			local var_286_2 = 0

			if var_286_2 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				local var_286_3 = manager.ui.mainCamera.transform.localPosition
				local var_286_4 = Vector3.New(0, 0, 10) + Vector3.New(var_286_3.x, var_286_3.y, 0)
				local var_286_5 = arg_283_1.bgs_.ST2005

				var_286_5.transform.localPosition = var_286_4
				var_286_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_286_6 = var_286_5:GetComponent("SpriteRenderer")

				if var_286_6 and var_286_6.sprite then
					local var_286_7 = (var_286_5.transform.localPosition - var_286_3).z
					local var_286_8 = manager.ui.mainCameraCom_
					local var_286_9 = 2 * var_286_7 * Mathf.Tan(var_286_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_286_10 = var_286_9 * var_286_8.aspect
					local var_286_11 = var_286_6.sprite.bounds.size.x
					local var_286_12 = var_286_6.sprite.bounds.size.y
					local var_286_13 = var_286_10 / var_286_11
					local var_286_14 = var_286_9 / var_286_12
					local var_286_15 = var_286_14 < var_286_13 and var_286_13 or var_286_14

					var_286_5.transform.localScale = Vector3.New(var_286_15, var_286_15, 0)
				end

				for iter_286_0, iter_286_1 in pairs(arg_283_1.bgs_) do
					if iter_286_0 ~= "ST2005" then
						iter_286_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_286_16 = 0

			if var_286_16 < arg_283_1.time_ and arg_283_1.time_ <= var_286_16 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			local var_286_17 = 0.3

			if arg_283_1.time_ >= var_286_16 + var_286_17 and arg_283_1.time_ < var_286_16 + var_286_17 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			local var_286_18 = 0

			if var_286_18 < arg_283_1.time_ and arg_283_1.time_ <= var_286_18 + arg_286_0 then
				arg_283_1.mask_.enabled = true
				arg_283_1.mask_.raycastTarget = true

				arg_283_1:SetGaussion(false)
			end

			local var_286_19 = 1

			if var_286_18 <= arg_283_1.time_ and arg_283_1.time_ < var_286_18 + var_286_19 then
				local var_286_20 = (arg_283_1.time_ - var_286_18) / var_286_19
				local var_286_21 = Color.New(0, 0, 0)

				var_286_21.a = Mathf.Lerp(1, 0, var_286_20)
				arg_283_1.mask_.color = var_286_21
			end

			if arg_283_1.time_ >= var_286_18 + var_286_19 and arg_283_1.time_ < var_286_18 + var_286_19 + arg_286_0 then
				local var_286_22 = Color.New(0, 0, 0)
				local var_286_23 = 0

				arg_283_1.mask_.enabled = false
				var_286_22.a = var_286_23
				arg_283_1.mask_.color = var_286_22
			end

			local var_286_24 = 0
			local var_286_25 = 0.05

			if var_286_24 < arg_283_1.time_ and arg_283_1.time_ <= var_286_24 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0

				arg_283_1.dialog_:SetActive(true)

				arg_283_1.dialogCg_.alpha = 0

				local var_286_26 = LeanTween.value(arg_283_1.dialog_, 0, 1, 0.3)

				var_286_26:setOnUpdate(LuaHelper.FloatAction(function(arg_287_0)
					arg_283_1.dialogCg_.alpha = arg_287_0
				end))
				var_286_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_283_1.dialog_)
					var_286_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_283_1.duration_ = arg_283_1.duration_ + 0.3

				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_27 = arg_283_1:FormatText(StoryNameCfg[672].name)

				arg_283_1.leftNameTxt_.text = var_286_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_28 = arg_283_1:GetWordFromCfg(324151063)
				local var_286_29 = arg_283_1:FormatText(var_286_28.content)

				arg_283_1.text_.text = var_286_29

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_30 = 2
				local var_286_31 = utf8.len(var_286_29)
				local var_286_32 = var_286_30 <= 0 and var_286_25 or var_286_25 * (var_286_31 / var_286_30)

				if var_286_32 > 0 and var_286_25 < var_286_32 then
					arg_283_1.talkMaxDuration = var_286_32
					var_286_24 = var_286_24 + 0.3

					if var_286_32 + var_286_24 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_32 + var_286_24
					end
				end

				arg_283_1.text_.text = var_286_29
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151063", "story_v_out_324151.awb") ~= 0 then
					local var_286_33 = manager.audio:GetVoiceLength("story_v_out_324151", "324151063", "story_v_out_324151.awb") / 1000

					if var_286_33 + var_286_24 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_33 + var_286_24
					end

					if var_286_28.prefab_name ~= "" and arg_283_1.actors_[var_286_28.prefab_name] ~= nil then
						local var_286_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_28.prefab_name].transform, "story_v_out_324151", "324151063", "story_v_out_324151.awb")

						arg_283_1:RecordAudio("324151063", var_286_34)
						arg_283_1:RecordAudio("324151063", var_286_34)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_324151", "324151063", "story_v_out_324151.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_324151", "324151063", "story_v_out_324151.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_35 = var_286_24 + 0.3
			local var_286_36 = math.max(var_286_25, arg_283_1.talkMaxDuration)

			if var_286_35 <= arg_283_1.time_ and arg_283_1.time_ < var_286_35 + var_286_36 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_35) / var_286_36

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_35 + var_286_36 and arg_283_1.time_ < var_286_35 + var_286_36 + arg_286_0 then
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
			local var_292_0 = "STblack"

			if arg_289_1.bgs_[var_292_0] == nil then
				local var_292_1 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_292_0)
				var_292_1.name = var_292_0
				var_292_1.transform.parent = arg_289_1.stage_.transform
				var_292_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_[var_292_0] = var_292_1
			end

			local var_292_2 = 0

			if var_292_2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				local var_292_3 = manager.ui.mainCamera.transform.localPosition
				local var_292_4 = Vector3.New(0, 0, 10) + Vector3.New(var_292_3.x, var_292_3.y, 0)
				local var_292_5 = arg_289_1.bgs_.STblack

				var_292_5.transform.localPosition = var_292_4
				var_292_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_6 = var_292_5:GetComponent("SpriteRenderer")

				if var_292_6 and var_292_6.sprite then
					local var_292_7 = (var_292_5.transform.localPosition - var_292_3).z
					local var_292_8 = manager.ui.mainCameraCom_
					local var_292_9 = 2 * var_292_7 * Mathf.Tan(var_292_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_292_10 = var_292_9 * var_292_8.aspect
					local var_292_11 = var_292_6.sprite.bounds.size.x
					local var_292_12 = var_292_6.sprite.bounds.size.y
					local var_292_13 = var_292_10 / var_292_11
					local var_292_14 = var_292_9 / var_292_12
					local var_292_15 = var_292_14 < var_292_13 and var_292_13 or var_292_14

					var_292_5.transform.localScale = Vector3.New(var_292_15, var_292_15, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "STblack" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_16 = "J25f"

			if arg_289_1.bgs_[var_292_16] == nil then
				local var_292_17 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_292_16)
				var_292_17.name = var_292_16
				var_292_17.transform.parent = arg_289_1.stage_.transform
				var_292_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_[var_292_16] = var_292_17
			end

			local var_292_18 = 1

			if var_292_18 < arg_289_1.time_ and arg_289_1.time_ <= var_292_18 + arg_292_0 then
				local var_292_19 = manager.ui.mainCamera.transform.localPosition
				local var_292_20 = Vector3.New(0, 0, 10) + Vector3.New(var_292_19.x, var_292_19.y, 0)
				local var_292_21 = arg_289_1.bgs_.J25f

				var_292_21.transform.localPosition = var_292_20
				var_292_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_22 = var_292_21:GetComponent("SpriteRenderer")

				if var_292_22 and var_292_22.sprite then
					local var_292_23 = (var_292_21.transform.localPosition - var_292_19).z
					local var_292_24 = manager.ui.mainCameraCom_
					local var_292_25 = 2 * var_292_23 * Mathf.Tan(var_292_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_292_26 = var_292_25 * var_292_24.aspect
					local var_292_27 = var_292_22.sprite.bounds.size.x
					local var_292_28 = var_292_22.sprite.bounds.size.y
					local var_292_29 = var_292_26 / var_292_27
					local var_292_30 = var_292_25 / var_292_28
					local var_292_31 = var_292_30 < var_292_29 and var_292_29 or var_292_30

					var_292_21.transform.localScale = Vector3.New(var_292_31, var_292_31, 0)
				end

				for iter_292_2, iter_292_3 in pairs(arg_289_1.bgs_) do
					if iter_292_2 ~= "J25f" then
						iter_292_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_32 = 0

			if var_292_32 < arg_289_1.time_ and arg_289_1.time_ <= var_292_32 + arg_292_0 then
				arg_289_1.allBtn_.enabled = false
			end

			local var_292_33 = 0.3

			if arg_289_1.time_ >= var_292_32 + var_292_33 and arg_289_1.time_ < var_292_32 + var_292_33 + arg_292_0 then
				arg_289_1.allBtn_.enabled = true
			end

			local var_292_34 = 0

			if var_292_34 < arg_289_1.time_ and arg_289_1.time_ <= var_292_34 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_35 = 1

			if var_292_34 <= arg_289_1.time_ and arg_289_1.time_ < var_292_34 + var_292_35 then
				local var_292_36 = (arg_289_1.time_ - var_292_34) / var_292_35
				local var_292_37 = Color.New(1, 1, 1)

				var_292_37.a = Mathf.Lerp(0, 1, var_292_36)
				arg_289_1.mask_.color = var_292_37
			end

			if arg_289_1.time_ >= var_292_34 + var_292_35 and arg_289_1.time_ < var_292_34 + var_292_35 + arg_292_0 then
				local var_292_38 = Color.New(1, 1, 1)

				var_292_38.a = 1
				arg_289_1.mask_.color = var_292_38
			end

			local var_292_39 = 1

			if var_292_39 < arg_289_1.time_ and arg_289_1.time_ <= var_292_39 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_40 = 2.46666666666667

			if var_292_39 <= arg_289_1.time_ and arg_289_1.time_ < var_292_39 + var_292_40 then
				local var_292_41 = (arg_289_1.time_ - var_292_39) / var_292_40
				local var_292_42 = Color.New(1, 1, 1)

				var_292_42.a = Mathf.Lerp(1, 0, var_292_41)
				arg_289_1.mask_.color = var_292_42
			end

			if arg_289_1.time_ >= var_292_39 + var_292_40 and arg_289_1.time_ < var_292_39 + var_292_40 + arg_292_0 then
				local var_292_43 = Color.New(1, 1, 1)
				local var_292_44 = 0

				arg_289_1.mask_.enabled = false
				var_292_43.a = var_292_44
				arg_289_1.mask_.color = var_292_43
			end

			local var_292_45 = 1

			if var_292_45 < arg_289_1.time_ and arg_289_1.time_ <= var_292_45 + arg_292_0 then
				arg_289_1.fswbg_:SetActive(true)
				arg_289_1.dialog_:SetActive(false)

				arg_289_1.fswtw_.percent = 0

				local var_292_46 = arg_289_1:GetWordFromCfg(102)
				local var_292_47 = arg_289_1:FormatText(var_292_46.content)

				arg_289_1.fswt_.text = var_292_47

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.fswt_)

				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_289_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_289_1.fswtw_:SetDirty()

				arg_289_1.typewritterCharCountI18N = 0

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_48 = 2.53333333333333

			if var_292_48 < arg_289_1.time_ and arg_289_1.time_ <= var_292_48 + arg_292_0 then
				arg_289_1.var_.oldValueTypewriter = arg_289_1.fswtw_.percent

				SetActive(arg_289_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_289_1:ShowNextGo(false)
			end

			local var_292_49 = 0
			local var_292_50 = 0.466666666666667
			local var_292_51 = arg_289_1:GetWordFromCfg(102)
			local var_292_52 = arg_289_1:FormatText(var_292_51.content)
			local var_292_53, var_292_54 = arg_289_1:GetPercentByPara(var_292_52, 1)

			if var_292_48 < arg_289_1.time_ and arg_289_1.time_ <= var_292_48 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				local var_292_55 = var_292_49 <= 0 and var_292_50 or var_292_50 * ((var_292_54 - arg_289_1.typewritterCharCountI18N) / var_292_49)

				if var_292_55 > 0 and var_292_50 < var_292_55 then
					arg_289_1.talkMaxDuration = var_292_55

					if var_292_55 + var_292_48 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_55 + var_292_48
					end
				end
			end

			local var_292_56 = 0.466666666666667
			local var_292_57 = math.max(var_292_56, arg_289_1.talkMaxDuration)

			if var_292_48 <= arg_289_1.time_ and arg_289_1.time_ < var_292_48 + var_292_57 then
				local var_292_58 = (arg_289_1.time_ - var_292_48) / var_292_57

				arg_289_1.fswtw_.percent = Mathf.Lerp(arg_289_1.var_.oldValueTypewriter, var_292_53, var_292_58)
				arg_289_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_289_1.fswtw_:SetDirty()
			end

			if arg_289_1.time_ >= var_292_48 + var_292_57 and arg_289_1.time_ < var_292_48 + var_292_57 + arg_292_0 then
				arg_289_1.fswtw_.percent = var_292_53

				arg_289_1.fswtw_:SetDirty()
				arg_289_1:ShowNextGo(true)

				arg_289_1.typewritterCharCountI18N = var_292_54
			end

			local var_292_59 = manager.ui.mainCamera.transform
			local var_292_60 = 1

			if var_292_60 < arg_289_1.time_ and arg_289_1.time_ <= var_292_60 + arg_292_0 then
				local var_292_61 = arg_289_1.var_.effect23231

				if var_292_61 then
					Object.Destroy(var_292_61)

					arg_289_1.var_.effect23231 = nil
				end
			end

			local var_292_62 = manager.ui.mainCamera.transform
			local var_292_63 = 1

			if var_292_63 < arg_289_1.time_ and arg_289_1.time_ <= var_292_63 + arg_292_0 then
				local var_292_64 = arg_289_1.var_.effect32421

				if var_292_64 then
					Object.Destroy(var_292_64)

					arg_289_1.var_.effect32421 = nil
				end
			end

			local var_292_65
			local var_292_66 = 1

			if var_292_66 < arg_289_1.time_ and arg_289_1.time_ <= var_292_66 + arg_292_0 then
				local var_292_67 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_292_67 then
					var_292_67.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_292_67.radialBlurScale = 0
					var_292_67.radialBlurGradient = 1
					var_292_67.radialBlurIntensity = 1

					if var_292_65 then
						var_292_67.radialBlurTarget = var_292_65.transform
					end
				end
			end

			local var_292_68 = 2.26666666666667

			if var_292_66 <= arg_289_1.time_ and arg_289_1.time_ < var_292_66 + var_292_68 then
				local var_292_69 = (arg_289_1.time_ - var_292_66) / var_292_68
				local var_292_70 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_292_70 then
					var_292_70.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_292_70.radialBlurScale = Mathf.Lerp(0, 0.93, var_292_69)
					var_292_70.radialBlurGradient = Mathf.Lerp(1, 1, var_292_69)
					var_292_70.radialBlurIntensity = Mathf.Lerp(1, 1, var_292_69)
				end
			end

			if arg_289_1.time_ >= var_292_66 + var_292_68 and arg_289_1.time_ < var_292_66 + var_292_68 + arg_292_0 then
				local var_292_71 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_292_71 then
					var_292_71.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_292_71.radialBlurScale = 0.93
					var_292_71.radialBlurGradient = 1
					var_292_71.radialBlurIntensity = 1
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
			local var_296_0 = 1

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				local var_296_1 = manager.ui.mainCamera.transform.localPosition
				local var_296_2 = Vector3.New(0, 0, 10) + Vector3.New(var_296_1.x, var_296_1.y, 0)
				local var_296_3 = arg_293_1.bgs_.J22f

				var_296_3.transform.localPosition = var_296_2
				var_296_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_4 = var_296_3:GetComponent("SpriteRenderer")

				if var_296_4 and var_296_4.sprite then
					local var_296_5 = (var_296_3.transform.localPosition - var_296_1).z
					local var_296_6 = manager.ui.mainCameraCom_
					local var_296_7 = 2 * var_296_5 * Mathf.Tan(var_296_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_296_8 = var_296_7 * var_296_6.aspect
					local var_296_9 = var_296_4.sprite.bounds.size.x
					local var_296_10 = var_296_4.sprite.bounds.size.y
					local var_296_11 = var_296_8 / var_296_9
					local var_296_12 = var_296_7 / var_296_10
					local var_296_13 = var_296_12 < var_296_11 and var_296_11 or var_296_12

					var_296_3.transform.localScale = Vector3.New(var_296_13, var_296_13, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "J22f" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_14 = 0

			if var_296_14 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			local var_296_15 = 0.3

			if arg_293_1.time_ >= var_296_14 + var_296_15 and arg_293_1.time_ < var_296_14 + var_296_15 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end

			local var_296_16 = 0

			if var_296_16 < arg_293_1.time_ and arg_293_1.time_ <= var_296_16 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_17 = 1

			if var_296_16 <= arg_293_1.time_ and arg_293_1.time_ < var_296_16 + var_296_17 then
				local var_296_18 = (arg_293_1.time_ - var_296_16) / var_296_17
				local var_296_19 = Color.New(0, 0, 0)

				var_296_19.a = Mathf.Lerp(0, 1, var_296_18)
				arg_293_1.mask_.color = var_296_19
			end

			if arg_293_1.time_ >= var_296_16 + var_296_17 and arg_293_1.time_ < var_296_16 + var_296_17 + arg_296_0 then
				local var_296_20 = Color.New(0, 0, 0)

				var_296_20.a = 1
				arg_293_1.mask_.color = var_296_20
			end

			local var_296_21 = 1

			if var_296_21 < arg_293_1.time_ and arg_293_1.time_ <= var_296_21 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_22 = 1.93333333333333

			if var_296_21 <= arg_293_1.time_ and arg_293_1.time_ < var_296_21 + var_296_22 then
				local var_296_23 = (arg_293_1.time_ - var_296_21) / var_296_22
				local var_296_24 = Color.New(0, 0, 0)

				var_296_24.a = Mathf.Lerp(1, 0, var_296_23)
				arg_293_1.mask_.color = var_296_24
			end

			if arg_293_1.time_ >= var_296_21 + var_296_22 and arg_293_1.time_ < var_296_21 + var_296_22 + arg_296_0 then
				local var_296_25 = Color.New(0, 0, 0)
				local var_296_26 = 0

				arg_293_1.mask_.enabled = false
				var_296_25.a = var_296_26
				arg_293_1.mask_.color = var_296_25
			end

			local var_296_27 = 1

			if var_296_27 < arg_293_1.time_ and arg_293_1.time_ <= var_296_27 + arg_296_0 then
				arg_293_1.fswbg_:SetActive(false)
				arg_293_1.dialog_:SetActive(false)
				SetActive(arg_293_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_293_1:ShowNextGo(false)
			end

			local var_296_28 = 1.46666666666667

			if var_296_28 < arg_293_1.time_ and arg_293_1.time_ <= var_296_28 + arg_296_0 then
				arg_293_1.fswbg_:SetActive(false)
				arg_293_1.dialog_:SetActive(false)
				SetActive(arg_293_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_293_1:ShowNextGo(false)
			end

			local var_296_29
			local var_296_30 = 1

			if var_296_30 < arg_293_1.time_ and arg_293_1.time_ <= var_296_30 + arg_296_0 then
				local var_296_31 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_296_31 then
					var_296_31.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_296_31.radialBlurScale = 0.945
					var_296_31.radialBlurGradient = 1
					var_296_31.radialBlurIntensity = 1

					if var_296_29 then
						var_296_31.radialBlurTarget = var_296_29.transform
					end
				end
			end

			local var_296_32 = 2.26666666666667

			if var_296_30 <= arg_293_1.time_ and arg_293_1.time_ < var_296_30 + var_296_32 then
				local var_296_33 = (arg_293_1.time_ - var_296_30) / var_296_32
				local var_296_34 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_296_34 then
					var_296_34.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_296_34.radialBlurScale = Mathf.Lerp(0.945, 0, var_296_33)
					var_296_34.radialBlurGradient = Mathf.Lerp(1, 1, var_296_33)
					var_296_34.radialBlurIntensity = Mathf.Lerp(1, 1, var_296_33)
				end
			end

			if arg_293_1.time_ >= var_296_30 + var_296_32 and arg_293_1.time_ < var_296_30 + var_296_32 + arg_296_0 then
				local var_296_35 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_296_35 then
					var_296_35.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_296_35.radialBlurScale = 0
					var_296_35.radialBlurGradient = 1
					var_296_35.radialBlurIntensity = 1
				end
			end

			if arg_293_1.frameCnt_ <= 1 then
				arg_293_1.dialog_:SetActive(false)
			end

			local var_296_36 = 2.4
			local var_296_37 = 0.625

			if var_296_36 < arg_293_1.time_ and arg_293_1.time_ <= var_296_36 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				arg_293_1.dialog_:SetActive(true)

				arg_293_1.dialogCg_.alpha = 0

				local var_296_38 = LeanTween.value(arg_293_1.dialog_, 0, 1, 0.3)

				var_296_38:setOnUpdate(LuaHelper.FloatAction(function(arg_297_0)
					arg_293_1.dialogCg_.alpha = arg_297_0
				end))
				var_296_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_293_1.dialog_)
					var_296_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_293_1.duration_ = arg_293_1.duration_ + 0.3

				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_39 = arg_293_1:GetWordFromCfg(324151065)
				local var_296_40 = arg_293_1:FormatText(var_296_39.content)

				arg_293_1.text_.text = var_296_40

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_41 = 25
				local var_296_42 = utf8.len(var_296_40)
				local var_296_43 = var_296_41 <= 0 and var_296_37 or var_296_37 * (var_296_42 / var_296_41)

				if var_296_43 > 0 and var_296_37 < var_296_43 then
					arg_293_1.talkMaxDuration = var_296_43
					var_296_36 = var_296_36 + 0.3

					if var_296_43 + var_296_36 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_43 + var_296_36
					end
				end

				arg_293_1.text_.text = var_296_40
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_44 = var_296_36 + 0.3
			local var_296_45 = math.max(var_296_37, arg_293_1.talkMaxDuration)

			if var_296_44 <= arg_293_1.time_ and arg_293_1.time_ < var_296_44 + var_296_45 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_44) / var_296_45

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_44 + var_296_45 and arg_293_1.time_ < var_296_44 + var_296_45 + arg_296_0 then
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
			local var_302_0 = 0
			local var_302_1 = 0.6

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_2 = arg_299_1:GetWordFromCfg(324151066)
				local var_302_3 = arg_299_1:FormatText(var_302_2.content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 24
				local var_302_5 = utf8.len(var_302_3)
				local var_302_6 = var_302_4 <= 0 and var_302_1 or var_302_1 * (var_302_5 / var_302_4)

				if var_302_6 > 0 and var_302_1 < var_302_6 then
					arg_299_1.talkMaxDuration = var_302_6

					if var_302_6 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_6 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_7 and arg_299_1.time_ < var_302_0 + var_302_7 + arg_302_0 then
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
			local var_306_0 = arg_303_1.actors_["10171ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect10171ui_story == nil then
				arg_303_1.var_.characterEffect10171ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect10171ui_story and not isNil(var_306_0) then
					arg_303_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect10171ui_story then
				arg_303_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_306_4 = 0
			local var_306_5 = 0.175

			if var_306_4 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_6 = arg_303_1:FormatText(StoryNameCfg[1451].name)

				arg_303_1.leftNameTxt_.text = var_306_6

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

				local var_306_7 = arg_303_1:GetWordFromCfg(324151067)
				local var_306_8 = arg_303_1:FormatText(var_306_7.content)

				arg_303_1.text_.text = var_306_8

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_9 = 7
				local var_306_10 = utf8.len(var_306_8)
				local var_306_11 = var_306_9 <= 0 and var_306_5 or var_306_5 * (var_306_10 / var_306_9)

				if var_306_11 > 0 and var_306_5 < var_306_11 then
					arg_303_1.talkMaxDuration = var_306_11

					if var_306_11 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_11 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_8
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151067", "story_v_out_324151.awb") ~= 0 then
					local var_306_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151067", "story_v_out_324151.awb") / 1000

					if var_306_12 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_12 + var_306_4
					end

					if var_306_7.prefab_name ~= "" and arg_303_1.actors_[var_306_7.prefab_name] ~= nil then
						local var_306_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_7.prefab_name].transform, "story_v_out_324151", "324151067", "story_v_out_324151.awb")

						arg_303_1:RecordAudio("324151067", var_306_13)
						arg_303_1:RecordAudio("324151067", var_306_13)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_324151", "324151067", "story_v_out_324151.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_324151", "324151067", "story_v_out_324151.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_14 = math.max(var_306_5, arg_303_1.talkMaxDuration)

			if var_306_4 <= arg_303_1.time_ and arg_303_1.time_ < var_306_4 + var_306_14 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_4) / var_306_14

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_4 + var_306_14 and arg_303_1.time_ < var_306_4 + var_306_14 + arg_306_0 then
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
			local var_310_0 = arg_307_1.actors_["10171ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect10171ui_story == nil then
				arg_307_1.var_.characterEffect10171ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect10171ui_story and not isNil(var_310_0) then
					local var_310_4 = Mathf.Lerp(0, 0.5, var_310_3)

					arg_307_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_307_1.var_.characterEffect10171ui_story.fillRatio = var_310_4
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect10171ui_story then
				local var_310_5 = 0.5

				arg_307_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_307_1.var_.characterEffect10171ui_story.fillRatio = var_310_5
			end

			local var_310_6 = 0

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			local var_310_7 = 1.1

			if arg_307_1.time_ >= var_310_6 + var_310_7 and arg_307_1.time_ < var_310_6 + var_310_7 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			local var_310_8 = 0.4
			local var_310_9 = 1

			if var_310_8 < arg_307_1.time_ and arg_307_1.time_ <= var_310_8 + arg_310_0 then
				local var_310_10 = "play"
				local var_310_11 = "effect"

				arg_307_1:AudioAction(var_310_10, var_310_11, "se_story_1211", "se_story_1211_stab2", "")
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_12 = 0.8
			local var_310_13 = 1.225

			if var_310_12 < arg_307_1.time_ and arg_307_1.time_ <= var_310_12 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_14 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_14:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_15 = arg_307_1:GetWordFromCfg(324151068)
				local var_310_16 = arg_307_1:FormatText(var_310_15.content)

				arg_307_1.text_.text = var_310_16

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_17 = 49
				local var_310_18 = utf8.len(var_310_16)
				local var_310_19 = var_310_17 <= 0 and var_310_13 or var_310_13 * (var_310_18 / var_310_17)

				if var_310_19 > 0 and var_310_13 < var_310_19 then
					arg_307_1.talkMaxDuration = var_310_19
					var_310_12 = var_310_12 + 0.3

					if var_310_19 + var_310_12 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_19 + var_310_12
					end
				end

				arg_307_1.text_.text = var_310_16
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_20 = var_310_12 + 0.3
			local var_310_21 = math.max(var_310_13, arg_307_1.talkMaxDuration)

			if var_310_20 <= arg_307_1.time_ and arg_307_1.time_ < var_310_20 + var_310_21 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_20) / var_310_21

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_20 + var_310_21 and arg_307_1.time_ < var_310_20 + var_310_21 + arg_310_0 then
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
			local var_316_0 = 0.2
			local var_316_1 = 1

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				local var_316_2 = "play"
				local var_316_3 = "effect"

				arg_313_1:AudioAction(var_316_2, var_316_3, "se_story_150", "se_story_150_sword06", "")
			end

			local var_316_4 = 0
			local var_316_5 = 1.475

			if var_316_4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(324151069)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_8 = 59
				local var_316_9 = utf8.len(var_316_7)
				local var_316_10 = var_316_8 <= 0 and var_316_5 or var_316_5 * (var_316_9 / var_316_8)

				if var_316_10 > 0 and var_316_5 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_11 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_11 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_11

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_11 and arg_313_1.time_ < var_316_4 + var_316_11 + arg_316_0 then
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
			local var_320_0 = 0
			local var_320_1 = 1.55

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(324151070)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 62
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
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
			local var_324_0 = 0
			local var_324_1 = 0.65

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_2 = arg_321_1:GetWordFromCfg(324151071)
				local var_324_3 = arg_321_1:FormatText(var_324_2.content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 26
				local var_324_5 = utf8.len(var_324_3)
				local var_324_6 = var_324_4 <= 0 and var_324_1 or var_324_1 * (var_324_5 / var_324_4)

				if var_324_6 > 0 and var_324_1 < var_324_6 then
					arg_321_1.talkMaxDuration = var_324_6

					if var_324_6 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_6 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_7 and arg_321_1.time_ < var_324_0 + var_324_7 + arg_324_0 then
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
			local var_328_0 = arg_325_1.actors_["10171ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect10171ui_story == nil then
				arg_325_1.var_.characterEffect10171ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect10171ui_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect10171ui_story then
				arg_325_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_328_4 = arg_325_1.actors_["10171ui_story"].transform
			local var_328_5 = 0

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.var_.moveOldPos10171ui_story = var_328_4.localPosition

				local var_328_6 = GameObjectTools.GetOrAddComponent(var_328_4.gameObject, typeof(DynamicBoneHelper))

				if var_328_6 then
					var_328_6:EnableDynamicBone(false)
				end
			end

			local var_328_7 = 0.001

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_7 then
				local var_328_8 = (arg_325_1.time_ - var_328_5) / var_328_7
				local var_328_9 = Vector3.New(0, -0.95, -6.05)

				var_328_4.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10171ui_story, var_328_9, var_328_8)

				local var_328_10 = manager.ui.mainCamera.transform.position - var_328_4.position

				var_328_4.forward = Vector3.New(var_328_10.x, var_328_10.y, var_328_10.z)

				local var_328_11 = var_328_4.localEulerAngles

				var_328_11.z = 0
				var_328_11.x = 0
				var_328_4.localEulerAngles = var_328_11
			end

			if arg_325_1.time_ >= var_328_5 + var_328_7 and arg_325_1.time_ < var_328_5 + var_328_7 + arg_328_0 then
				var_328_4.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_328_12 = manager.ui.mainCamera.transform.position - var_328_4.position

				var_328_4.forward = Vector3.New(var_328_12.x, var_328_12.y, var_328_12.z)

				local var_328_13 = var_328_4.localEulerAngles

				var_328_13.z = 0
				var_328_13.x = 0
				var_328_4.localEulerAngles = var_328_13

				local var_328_14 = GameObjectTools.GetOrAddComponent(var_328_4.gameObject, typeof(DynamicBoneHelper))

				if var_328_14 then
					var_328_14:EnableDynamicBone(true)
				end
			end

			local var_328_15 = arg_325_1.actors_["10171ui_story"]
			local var_328_16 = 0

			if var_328_16 < arg_325_1.time_ and arg_325_1.time_ <= var_328_16 + arg_328_0 and not isNil(var_328_15) and arg_325_1.var_.characterEffect10171ui_story == nil then
				arg_325_1.var_.characterEffect10171ui_story = var_328_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_17 = 0.200000002980232

			if var_328_16 <= arg_325_1.time_ and arg_325_1.time_ < var_328_16 + var_328_17 and not isNil(var_328_15) then
				local var_328_18 = (arg_325_1.time_ - var_328_16) / var_328_17

				if arg_325_1.var_.characterEffect10171ui_story and not isNil(var_328_15) then
					arg_325_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_16 + var_328_17 and arg_325_1.time_ < var_328_16 + var_328_17 + arg_328_0 and not isNil(var_328_15) and arg_325_1.var_.characterEffect10171ui_story then
				arg_325_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_328_19 = 0

			if var_328_19 < arg_325_1.time_ and arg_325_1.time_ <= var_328_19 + arg_328_0 then
				arg_325_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_328_20 = 0

			if var_328_20 < arg_325_1.time_ and arg_325_1.time_ <= var_328_20 + arg_328_0 then
				arg_325_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_328_21 = 0
			local var_328_22 = 0.175

			if var_328_21 < arg_325_1.time_ and arg_325_1.time_ <= var_328_21 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_23 = arg_325_1:FormatText(StoryNameCfg[1451].name)

				arg_325_1.leftNameTxt_.text = var_328_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_24 = arg_325_1:GetWordFromCfg(324151072)
				local var_328_25 = arg_325_1:FormatText(var_328_24.content)

				arg_325_1.text_.text = var_328_25

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_26 = 7
				local var_328_27 = utf8.len(var_328_25)
				local var_328_28 = var_328_26 <= 0 and var_328_22 or var_328_22 * (var_328_27 / var_328_26)

				if var_328_28 > 0 and var_328_22 < var_328_28 then
					arg_325_1.talkMaxDuration = var_328_28

					if var_328_28 + var_328_21 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_28 + var_328_21
					end
				end

				arg_325_1.text_.text = var_328_25
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151072", "story_v_out_324151.awb") ~= 0 then
					local var_328_29 = manager.audio:GetVoiceLength("story_v_out_324151", "324151072", "story_v_out_324151.awb") / 1000

					if var_328_29 + var_328_21 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_29 + var_328_21
					end

					if var_328_24.prefab_name ~= "" and arg_325_1.actors_[var_328_24.prefab_name] ~= nil then
						local var_328_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_24.prefab_name].transform, "story_v_out_324151", "324151072", "story_v_out_324151.awb")

						arg_325_1:RecordAudio("324151072", var_328_30)
						arg_325_1:RecordAudio("324151072", var_328_30)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_324151", "324151072", "story_v_out_324151.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_324151", "324151072", "story_v_out_324151.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_31 = math.max(var_328_22, arg_325_1.talkMaxDuration)

			if var_328_21 <= arg_325_1.time_ and arg_325_1.time_ < var_328_21 + var_328_31 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_21) / var_328_31

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_21 + var_328_31 and arg_325_1.time_ < var_328_21 + var_328_31 + arg_328_0 then
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
			local var_332_0 = 1.26666666666667

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				local var_332_1 = manager.ui.mainCamera.transform.localPosition
				local var_332_2 = Vector3.New(0, 0, 10) + Vector3.New(var_332_1.x, var_332_1.y, 0)
				local var_332_3 = arg_329_1.bgs_.ST31

				var_332_3.transform.localPosition = var_332_2
				var_332_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_332_4 = var_332_3:GetComponent("SpriteRenderer")

				if var_332_4 and var_332_4.sprite then
					local var_332_5 = (var_332_3.transform.localPosition - var_332_1).z
					local var_332_6 = manager.ui.mainCameraCom_
					local var_332_7 = 2 * var_332_5 * Mathf.Tan(var_332_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_332_8 = var_332_7 * var_332_6.aspect
					local var_332_9 = var_332_4.sprite.bounds.size.x
					local var_332_10 = var_332_4.sprite.bounds.size.y
					local var_332_11 = var_332_8 / var_332_9
					local var_332_12 = var_332_7 / var_332_10
					local var_332_13 = var_332_12 < var_332_11 and var_332_11 or var_332_12

					var_332_3.transform.localScale = Vector3.New(var_332_13, var_332_13, 0)
				end

				for iter_332_0, iter_332_1 in pairs(arg_329_1.bgs_) do
					if iter_332_0 ~= "ST31" then
						iter_332_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_332_14 = 0

			if var_332_14 < arg_329_1.time_ and arg_329_1.time_ <= var_332_14 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			local var_332_15 = 0.3

			if arg_329_1.time_ >= var_332_14 + var_332_15 and arg_329_1.time_ < var_332_14 + var_332_15 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			local var_332_16 = 0

			if var_332_16 < arg_329_1.time_ and arg_329_1.time_ <= var_332_16 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_17 = 1.3

			if var_332_16 <= arg_329_1.time_ and arg_329_1.time_ < var_332_16 + var_332_17 then
				local var_332_18 = (arg_329_1.time_ - var_332_16) / var_332_17
				local var_332_19 = Color.New(0, 0, 0)

				var_332_19.a = Mathf.Lerp(0, 1, var_332_18)
				arg_329_1.mask_.color = var_332_19
			end

			if arg_329_1.time_ >= var_332_16 + var_332_17 and arg_329_1.time_ < var_332_16 + var_332_17 + arg_332_0 then
				local var_332_20 = Color.New(0, 0, 0)

				var_332_20.a = 1
				arg_329_1.mask_.color = var_332_20
			end

			local var_332_21 = 1.3

			if var_332_21 < arg_329_1.time_ and arg_329_1.time_ <= var_332_21 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_22 = 1.73333333333333

			if var_332_21 <= arg_329_1.time_ and arg_329_1.time_ < var_332_21 + var_332_22 then
				local var_332_23 = (arg_329_1.time_ - var_332_21) / var_332_22
				local var_332_24 = Color.New(0, 0, 0)

				var_332_24.a = Mathf.Lerp(1, 0, var_332_23)
				arg_329_1.mask_.color = var_332_24
			end

			if arg_329_1.time_ >= var_332_21 + var_332_22 and arg_329_1.time_ < var_332_21 + var_332_22 + arg_332_0 then
				local var_332_25 = Color.New(0, 0, 0)
				local var_332_26 = 0

				arg_329_1.mask_.enabled = false
				var_332_25.a = var_332_26
				arg_329_1.mask_.color = var_332_25
			end

			local var_332_27 = arg_329_1.actors_["10171ui_story"]
			local var_332_28 = 0

			if var_332_28 < arg_329_1.time_ and arg_329_1.time_ <= var_332_28 + arg_332_0 and not isNil(var_332_27) and arg_329_1.var_.characterEffect10171ui_story == nil then
				arg_329_1.var_.characterEffect10171ui_story = var_332_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_29 = 0.200000002980232

			if var_332_28 <= arg_329_1.time_ and arg_329_1.time_ < var_332_28 + var_332_29 and not isNil(var_332_27) then
				local var_332_30 = (arg_329_1.time_ - var_332_28) / var_332_29

				if arg_329_1.var_.characterEffect10171ui_story and not isNil(var_332_27) then
					local var_332_31 = Mathf.Lerp(0, 0.5, var_332_30)

					arg_329_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10171ui_story.fillRatio = var_332_31
				end
			end

			if arg_329_1.time_ >= var_332_28 + var_332_29 and arg_329_1.time_ < var_332_28 + var_332_29 + arg_332_0 and not isNil(var_332_27) and arg_329_1.var_.characterEffect10171ui_story then
				local var_332_32 = 0.5

				arg_329_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10171ui_story.fillRatio = var_332_32
			end

			local var_332_33 = arg_329_1.bgs_.ST31.transform
			local var_332_34 = 1.3

			if var_332_34 < arg_329_1.time_ and arg_329_1.time_ <= var_332_34 + arg_332_0 then
				arg_329_1.var_.moveOldPosST31 = var_332_33.localPosition
			end

			local var_332_35 = 1.79166666666667

			if var_332_34 <= arg_329_1.time_ and arg_329_1.time_ < var_332_34 + var_332_35 then
				local var_332_36 = (arg_329_1.time_ - var_332_34) / var_332_35
				local var_332_37 = Vector3.New(0, 1, 7.5)

				var_332_33.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPosST31, var_332_37, var_332_36)
			end

			if arg_329_1.time_ >= var_332_34 + var_332_35 and arg_329_1.time_ < var_332_34 + var_332_35 + arg_332_0 then
				var_332_33.localPosition = Vector3.New(0, 1, 7.5)
			end

			local var_332_38 = arg_329_1.actors_["10171ui_story"].transform
			local var_332_39 = 1.3

			if var_332_39 < arg_329_1.time_ and arg_329_1.time_ <= var_332_39 + arg_332_0 then
				arg_329_1.var_.moveOldPos10171ui_story = var_332_38.localPosition

				local var_332_40 = GameObjectTools.GetOrAddComponent(var_332_38.gameObject, typeof(DynamicBoneHelper))

				if var_332_40 then
					var_332_40:EnableDynamicBone(false)
				end
			end

			local var_332_41 = 0.001

			if var_332_39 <= arg_329_1.time_ and arg_329_1.time_ < var_332_39 + var_332_41 then
				local var_332_42 = (arg_329_1.time_ - var_332_39) / var_332_41
				local var_332_43 = Vector3.New(0, 100, 0)

				var_332_38.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10171ui_story, var_332_43, var_332_42)

				local var_332_44 = manager.ui.mainCamera.transform.position - var_332_38.position

				var_332_38.forward = Vector3.New(var_332_44.x, var_332_44.y, var_332_44.z)

				local var_332_45 = var_332_38.localEulerAngles

				var_332_45.z = 0
				var_332_45.x = 0
				var_332_38.localEulerAngles = var_332_45
			end

			if arg_329_1.time_ >= var_332_39 + var_332_41 and arg_329_1.time_ < var_332_39 + var_332_41 + arg_332_0 then
				var_332_38.localPosition = Vector3.New(0, 100, 0)

				local var_332_46 = manager.ui.mainCamera.transform.position - var_332_38.position

				var_332_38.forward = Vector3.New(var_332_46.x, var_332_46.y, var_332_46.z)

				local var_332_47 = var_332_38.localEulerAngles

				var_332_47.z = 0
				var_332_47.x = 0
				var_332_38.localEulerAngles = var_332_47

				local var_332_48 = GameObjectTools.GetOrAddComponent(var_332_38.gameObject, typeof(DynamicBoneHelper))

				if var_332_48 then
					var_332_48:EnableDynamicBone(true)
				end
			end

			local var_332_49 = arg_329_1.actors_["10171ui_story"]
			local var_332_50 = 1.3

			if var_332_50 < arg_329_1.time_ and arg_329_1.time_ <= var_332_50 + arg_332_0 and not isNil(var_332_49) and arg_329_1.var_.characterEffect10171ui_story == nil then
				arg_329_1.var_.characterEffect10171ui_story = var_332_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_51 = 0.200000002980232

			if var_332_50 <= arg_329_1.time_ and arg_329_1.time_ < var_332_50 + var_332_51 and not isNil(var_332_49) then
				local var_332_52 = (arg_329_1.time_ - var_332_50) / var_332_51

				if arg_329_1.var_.characterEffect10171ui_story and not isNil(var_332_49) then
					arg_329_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_50 + var_332_51 and arg_329_1.time_ < var_332_50 + var_332_51 + arg_332_0 and not isNil(var_332_49) and arg_329_1.var_.characterEffect10171ui_story then
				arg_329_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_332_53 = 1.2
			local var_332_54 = 1

			if var_332_53 < arg_329_1.time_ and arg_329_1.time_ <= var_332_53 + arg_332_0 then
				local var_332_55 = "play"
				local var_332_56 = "effect"

				arg_329_1:AudioAction(var_332_55, var_332_56, "se_story_140", "se_story_140_amb_lfe", "")
			end

			local var_332_57 = 0.1
			local var_332_58 = 1

			if var_332_57 < arg_329_1.time_ and arg_329_1.time_ <= var_332_57 + arg_332_0 then
				local var_332_59 = "stop"
				local var_332_60 = "effect"

				arg_329_1:AudioAction(var_332_59, var_332_60, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_61 = 2.7
			local var_332_62 = 1.55

			if var_332_61 < arg_329_1.time_ and arg_329_1.time_ <= var_332_61 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_63 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_63:setOnUpdate(LuaHelper.FloatAction(function(arg_333_0)
					arg_329_1.dialogCg_.alpha = arg_333_0
				end))
				var_332_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_64 = arg_329_1:GetWordFromCfg(324151073)
				local var_332_65 = arg_329_1:FormatText(var_332_64.content)

				arg_329_1.text_.text = var_332_65

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_66 = 62
				local var_332_67 = utf8.len(var_332_65)
				local var_332_68 = var_332_66 <= 0 and var_332_62 or var_332_62 * (var_332_67 / var_332_66)

				if var_332_68 > 0 and var_332_62 < var_332_68 then
					arg_329_1.talkMaxDuration = var_332_68
					var_332_61 = var_332_61 + 0.3

					if var_332_68 + var_332_61 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_68 + var_332_61
					end
				end

				arg_329_1.text_.text = var_332_65
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_69 = var_332_61 + 0.3
			local var_332_70 = math.max(var_332_62, arg_329_1.talkMaxDuration)

			if var_332_69 <= arg_329_1.time_ and arg_329_1.time_ < var_332_69 + var_332_70 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_69) / var_332_70

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_69 + var_332_70 and arg_329_1.time_ < var_332_69 + var_332_70 + arg_332_0 then
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
			local var_338_0 = 0
			local var_338_1 = 0.925

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_2 = arg_335_1:GetWordFromCfg(324151074)
				local var_338_3 = arg_335_1:FormatText(var_338_2.content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 37
				local var_338_5 = utf8.len(var_338_3)
				local var_338_6 = var_338_4 <= 0 and var_338_1 or var_338_1 * (var_338_5 / var_338_4)

				if var_338_6 > 0 and var_338_1 < var_338_6 then
					arg_335_1.talkMaxDuration = var_338_6

					if var_338_6 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_6 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_7 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_7 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_7

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_7 and arg_335_1.time_ < var_338_0 + var_338_7 + arg_338_0 then
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
			local var_342_0 = 0
			local var_342_1 = 1.225

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_2 = arg_339_1:GetWordFromCfg(324151075)
				local var_342_3 = arg_339_1:FormatText(var_342_2.content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 49
				local var_342_5 = utf8.len(var_342_3)
				local var_342_6 = var_342_4 <= 0 and var_342_1 or var_342_1 * (var_342_5 / var_342_4)

				if var_342_6 > 0 and var_342_1 < var_342_6 then
					arg_339_1.talkMaxDuration = var_342_6

					if var_342_6 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_6 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_7 and arg_339_1.time_ < var_342_0 + var_342_7 + arg_342_0 then
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
			local var_346_0 = "J22g"

			if arg_343_1.bgs_[var_346_0] == nil then
				local var_346_1 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_346_0)
				var_346_1.name = var_346_0
				var_346_1.transform.parent = arg_343_1.stage_.transform
				var_346_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_[var_346_0] = var_346_1
			end

			local var_346_2 = 0.925

			if var_346_2 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				local var_346_3 = manager.ui.mainCamera.transform.localPosition
				local var_346_4 = Vector3.New(0, 0, 10) + Vector3.New(var_346_3.x, var_346_3.y, 0)
				local var_346_5 = arg_343_1.bgs_.J22g

				var_346_5.transform.localPosition = var_346_4
				var_346_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_6 = var_346_5:GetComponent("SpriteRenderer")

				if var_346_6 and var_346_6.sprite then
					local var_346_7 = (var_346_5.transform.localPosition - var_346_3).z
					local var_346_8 = manager.ui.mainCameraCom_
					local var_346_9 = 2 * var_346_7 * Mathf.Tan(var_346_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_346_10 = var_346_9 * var_346_8.aspect
					local var_346_11 = var_346_6.sprite.bounds.size.x
					local var_346_12 = var_346_6.sprite.bounds.size.y
					local var_346_13 = var_346_10 / var_346_11
					local var_346_14 = var_346_9 / var_346_12
					local var_346_15 = var_346_14 < var_346_13 and var_346_13 or var_346_14

					var_346_5.transform.localScale = Vector3.New(var_346_15, var_346_15, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "J22g" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_16 = 0

			if var_346_16 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 then
				arg_343_1.allBtn_.enabled = false
			end

			local var_346_17 = 0.3

			if arg_343_1.time_ >= var_346_16 + var_346_17 and arg_343_1.time_ < var_346_16 + var_346_17 + arg_346_0 then
				arg_343_1.allBtn_.enabled = true
			end

			local var_346_18 = 0

			if var_346_18 < arg_343_1.time_ and arg_343_1.time_ <= var_346_18 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_19 = 0.925

			if var_346_18 <= arg_343_1.time_ and arg_343_1.time_ < var_346_18 + var_346_19 then
				local var_346_20 = (arg_343_1.time_ - var_346_18) / var_346_19
				local var_346_21 = Color.New(0, 0, 0)

				var_346_21.a = Mathf.Lerp(0, 1, var_346_20)
				arg_343_1.mask_.color = var_346_21
			end

			if arg_343_1.time_ >= var_346_18 + var_346_19 and arg_343_1.time_ < var_346_18 + var_346_19 + arg_346_0 then
				local var_346_22 = Color.New(0, 0, 0)

				var_346_22.a = 1
				arg_343_1.mask_.color = var_346_22
			end

			local var_346_23 = 0.925

			if var_346_23 < arg_343_1.time_ and arg_343_1.time_ <= var_346_23 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_24 = 0.925

			if var_346_23 <= arg_343_1.time_ and arg_343_1.time_ < var_346_23 + var_346_24 then
				local var_346_25 = (arg_343_1.time_ - var_346_23) / var_346_24
				local var_346_26 = Color.New(0, 0, 0)

				var_346_26.a = Mathf.Lerp(1, 0, var_346_25)
				arg_343_1.mask_.color = var_346_26
			end

			if arg_343_1.time_ >= var_346_23 + var_346_24 and arg_343_1.time_ < var_346_23 + var_346_24 + arg_346_0 then
				local var_346_27 = Color.New(0, 0, 0)
				local var_346_28 = 0

				arg_343_1.mask_.enabled = false
				var_346_27.a = var_346_28
				arg_343_1.mask_.color = var_346_27
			end

			local var_346_29 = 1.2
			local var_346_30 = 1

			if var_346_29 < arg_343_1.time_ and arg_343_1.time_ <= var_346_29 + arg_346_0 then
				local var_346_31 = "play"
				local var_346_32 = "effect"

				arg_343_1:AudioAction(var_346_31, var_346_32, "se_story_145", "se_story_145_amb_construction", "")
			end

			local var_346_33 = 0.1
			local var_346_34 = 1

			if var_346_33 < arg_343_1.time_ and arg_343_1.time_ <= var_346_33 + arg_346_0 then
				local var_346_35 = "stop"
				local var_346_36 = "effect"

				arg_343_1:AudioAction(var_346_35, var_346_36, "se_story_140", "se_story_140_amb_lfe", "")
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_37 = 1.7
			local var_346_38 = 0.075

			if var_346_37 < arg_343_1.time_ and arg_343_1.time_ <= var_346_37 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_39 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_39:setOnUpdate(LuaHelper.FloatAction(function(arg_347_0)
					arg_343_1.dialogCg_.alpha = arg_347_0
				end))
				var_346_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_40 = arg_343_1:FormatText(StoryNameCfg[1451].name)

				arg_343_1.leftNameTxt_.text = var_346_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_41 = arg_343_1:GetWordFromCfg(324151076)
				local var_346_42 = arg_343_1:FormatText(var_346_41.content)

				arg_343_1.text_.text = var_346_42

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_43 = 3
				local var_346_44 = utf8.len(var_346_42)
				local var_346_45 = var_346_43 <= 0 and var_346_38 or var_346_38 * (var_346_44 / var_346_43)

				if var_346_45 > 0 and var_346_38 < var_346_45 then
					arg_343_1.talkMaxDuration = var_346_45
					var_346_37 = var_346_37 + 0.3

					if var_346_45 + var_346_37 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_45 + var_346_37
					end
				end

				arg_343_1.text_.text = var_346_42
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151076", "story_v_out_324151.awb") ~= 0 then
					local var_346_46 = manager.audio:GetVoiceLength("story_v_out_324151", "324151076", "story_v_out_324151.awb") / 1000

					if var_346_46 + var_346_37 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_46 + var_346_37
					end

					if var_346_41.prefab_name ~= "" and arg_343_1.actors_[var_346_41.prefab_name] ~= nil then
						local var_346_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_41.prefab_name].transform, "story_v_out_324151", "324151076", "story_v_out_324151.awb")

						arg_343_1:RecordAudio("324151076", var_346_47)
						arg_343_1:RecordAudio("324151076", var_346_47)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_324151", "324151076", "story_v_out_324151.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_324151", "324151076", "story_v_out_324151.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_48 = var_346_37 + 0.3
			local var_346_49 = math.max(var_346_38, arg_343_1.talkMaxDuration)

			if var_346_48 <= arg_343_1.time_ and arg_343_1.time_ < var_346_48 + var_346_49 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_48) / var_346_49

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_48 + var_346_49 and arg_343_1.time_ < var_346_48 + var_346_49 + arg_346_0 then
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
			local var_352_0 = arg_349_1.actors_["10171ui_story"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos10171ui_story = var_352_0.localPosition

				local var_352_2 = GameObjectTools.GetOrAddComponent(var_352_0.gameObject, typeof(DynamicBoneHelper))

				if var_352_2 then
					var_352_2:EnableDynamicBone(false)
				end
			end

			local var_352_3 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_3 then
				local var_352_4 = (arg_349_1.time_ - var_352_1) / var_352_3
				local var_352_5 = Vector3.New(0, 100, 0)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10171ui_story, var_352_5, var_352_4)

				local var_352_6 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_6.x, var_352_6.y, var_352_6.z)

				local var_352_7 = var_352_0.localEulerAngles

				var_352_7.z = 0
				var_352_7.x = 0
				var_352_0.localEulerAngles = var_352_7
			end

			if arg_349_1.time_ >= var_352_1 + var_352_3 and arg_349_1.time_ < var_352_1 + var_352_3 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, 100, 0)

				local var_352_8 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_8.x, var_352_8.y, var_352_8.z)

				local var_352_9 = var_352_0.localEulerAngles

				var_352_9.z = 0
				var_352_9.x = 0
				var_352_0.localEulerAngles = var_352_9

				local var_352_10 = GameObjectTools.GetOrAddComponent(var_352_0.gameObject, typeof(DynamicBoneHelper))

				if var_352_10 then
					var_352_10:EnableDynamicBone(true)
				end
			end

			local var_352_11 = arg_349_1.actors_["10171ui_story"]
			local var_352_12 = 0

			if var_352_12 < arg_349_1.time_ and arg_349_1.time_ <= var_352_12 + arg_352_0 and not isNil(var_352_11) and arg_349_1.var_.characterEffect10171ui_story == nil then
				arg_349_1.var_.characterEffect10171ui_story = var_352_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_13 = 0.200000002980232

			if var_352_12 <= arg_349_1.time_ and arg_349_1.time_ < var_352_12 + var_352_13 and not isNil(var_352_11) then
				local var_352_14 = (arg_349_1.time_ - var_352_12) / var_352_13

				if arg_349_1.var_.characterEffect10171ui_story and not isNil(var_352_11) then
					local var_352_15 = Mathf.Lerp(0, 0.5, var_352_14)

					arg_349_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_349_1.var_.characterEffect10171ui_story.fillRatio = var_352_15
				end
			end

			if arg_349_1.time_ >= var_352_12 + var_352_13 and arg_349_1.time_ < var_352_12 + var_352_13 + arg_352_0 and not isNil(var_352_11) and arg_349_1.var_.characterEffect10171ui_story then
				local var_352_16 = 0.5

				arg_349_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_349_1.var_.characterEffect10171ui_story.fillRatio = var_352_16
			end

			local var_352_17 = 0.1
			local var_352_18 = 1

			if var_352_17 < arg_349_1.time_ and arg_349_1.time_ <= var_352_17 + arg_352_0 then
				local var_352_19 = "play"
				local var_352_20 = "effect"

				arg_349_1:AudioAction(var_352_19, var_352_20, "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_352_21 = 0
			local var_352_22 = 0.95

			if var_352_21 < arg_349_1.time_ and arg_349_1.time_ <= var_352_21 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_23 = arg_349_1:GetWordFromCfg(324151077)
				local var_352_24 = arg_349_1:FormatText(var_352_23.content)

				arg_349_1.text_.text = var_352_24

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_25 = 38
				local var_352_26 = utf8.len(var_352_24)
				local var_352_27 = var_352_25 <= 0 and var_352_22 or var_352_22 * (var_352_26 / var_352_25)

				if var_352_27 > 0 and var_352_22 < var_352_27 then
					arg_349_1.talkMaxDuration = var_352_27

					if var_352_27 + var_352_21 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_27 + var_352_21
					end
				end

				arg_349_1.text_.text = var_352_24
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_28 = math.max(var_352_22, arg_349_1.talkMaxDuration)

			if var_352_21 <= arg_349_1.time_ and arg_349_1.time_ < var_352_21 + var_352_28 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_21) / var_352_28

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_21 + var_352_28 and arg_349_1.time_ < var_352_21 + var_352_28 + arg_352_0 then
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
			local var_356_0 = 0.1
			local var_356_1 = 1

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				local var_356_2 = "play"
				local var_356_3 = "effect"

				arg_353_1:AudioAction(var_356_2, var_356_3, "se_story_140", "se_story_140_dream_crash02", "")
			end

			local var_356_4 = 0.3
			local var_356_5 = 1

			if var_356_4 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				local var_356_6 = "play"
				local var_356_7 = "effect"

				arg_353_1:AudioAction(var_356_6, var_356_7, "se_story_140", "se_story_140_amb_drone04", "")
			end

			local var_356_8 = 0
			local var_356_9 = 0.466666666666667

			if var_356_8 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 then
				local var_356_10 = "play"
				local var_356_11 = "effect"

				arg_353_1:AudioAction(var_356_10, var_356_11, "se_story_145", "se_story_145_amb_construction_stop", "")
			end

			local var_356_12 = 0
			local var_356_13 = 1.55

			if var_356_12 < arg_353_1.time_ and arg_353_1.time_ <= var_356_12 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_14 = arg_353_1:GetWordFromCfg(324151078)
				local var_356_15 = arg_353_1:FormatText(var_356_14.content)

				arg_353_1.text_.text = var_356_15

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_16 = 62
				local var_356_17 = utf8.len(var_356_15)
				local var_356_18 = var_356_16 <= 0 and var_356_13 or var_356_13 * (var_356_17 / var_356_16)

				if var_356_18 > 0 and var_356_13 < var_356_18 then
					arg_353_1.talkMaxDuration = var_356_18

					if var_356_18 + var_356_12 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_18 + var_356_12
					end
				end

				arg_353_1.text_.text = var_356_15
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_19 = math.max(var_356_13, arg_353_1.talkMaxDuration)

			if var_356_12 <= arg_353_1.time_ and arg_353_1.time_ < var_356_12 + var_356_19 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_12) / var_356_19

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_12 + var_356_19 and arg_353_1.time_ < var_356_12 + var_356_19 + arg_356_0 then
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
			local var_360_0 = arg_357_1.actors_["10171ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect10171ui_story == nil then
				arg_357_1.var_.characterEffect10171ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect10171ui_story and not isNil(var_360_0) then
					arg_357_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect10171ui_story then
				arg_357_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_360_4 = 0
			local var_360_5 = 0.05

			if var_360_4 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_6 = arg_357_1:FormatText(StoryNameCfg[1451].name)

				arg_357_1.leftNameTxt_.text = var_360_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_7 = arg_357_1:GetWordFromCfg(324151079)
				local var_360_8 = arg_357_1:FormatText(var_360_7.content)

				arg_357_1.text_.text = var_360_8

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 2
				local var_360_10 = utf8.len(var_360_8)
				local var_360_11 = var_360_9 <= 0 and var_360_5 or var_360_5 * (var_360_10 / var_360_9)

				if var_360_11 > 0 and var_360_5 < var_360_11 then
					arg_357_1.talkMaxDuration = var_360_11

					if var_360_11 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_11 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_8
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151079", "story_v_out_324151.awb") ~= 0 then
					local var_360_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151079", "story_v_out_324151.awb") / 1000

					if var_360_12 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_12 + var_360_4
					end

					if var_360_7.prefab_name ~= "" and arg_357_1.actors_[var_360_7.prefab_name] ~= nil then
						local var_360_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_7.prefab_name].transform, "story_v_out_324151", "324151079", "story_v_out_324151.awb")

						arg_357_1:RecordAudio("324151079", var_360_13)
						arg_357_1:RecordAudio("324151079", var_360_13)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_324151", "324151079", "story_v_out_324151.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_324151", "324151079", "story_v_out_324151.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_14 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_14 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_14

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_14 and arg_357_1.time_ < var_360_4 + var_360_14 + arg_360_0 then
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
			local var_364_0 = arg_361_1.actors_["10171ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect10171ui_story == nil then
				arg_361_1.var_.characterEffect10171ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect10171ui_story and not isNil(var_364_0) then
					local var_364_4 = Mathf.Lerp(0, 0.5, var_364_3)

					arg_361_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_361_1.var_.characterEffect10171ui_story.fillRatio = var_364_4
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect10171ui_story then
				local var_364_5 = 0.5

				arg_361_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_361_1.var_.characterEffect10171ui_story.fillRatio = var_364_5
			end

			local var_364_6 = 0
			local var_364_7 = 1.125

			if var_364_6 < arg_361_1.time_ and arg_361_1.time_ <= var_364_6 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_8 = arg_361_1:GetWordFromCfg(324151080)
				local var_364_9 = arg_361_1:FormatText(var_364_8.content)

				arg_361_1.text_.text = var_364_9

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_10 = 45
				local var_364_11 = utf8.len(var_364_9)
				local var_364_12 = var_364_10 <= 0 and var_364_7 or var_364_7 * (var_364_11 / var_364_10)

				if var_364_12 > 0 and var_364_7 < var_364_12 then
					arg_361_1.talkMaxDuration = var_364_12

					if var_364_12 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_12 + var_364_6
					end
				end

				arg_361_1.text_.text = var_364_9
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_13 = math.max(var_364_7, arg_361_1.talkMaxDuration)

			if var_364_6 <= arg_361_1.time_ and arg_361_1.time_ < var_364_6 + var_364_13 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_6) / var_364_13

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_6 + var_364_13 and arg_361_1.time_ < var_364_6 + var_364_13 + arg_364_0 then
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
			local var_368_0 = 0
			local var_368_1 = 1.05

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_2 = arg_365_1:GetWordFromCfg(324151081)
				local var_368_3 = arg_365_1:FormatText(var_368_2.content)

				arg_365_1.text_.text = var_368_3

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 42
				local var_368_5 = utf8.len(var_368_3)
				local var_368_6 = var_368_4 <= 0 and var_368_1 or var_368_1 * (var_368_5 / var_368_4)

				if var_368_6 > 0 and var_368_1 < var_368_6 then
					arg_365_1.talkMaxDuration = var_368_6

					if var_368_6 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_6 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_3
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_7 and arg_365_1.time_ < var_368_0 + var_368_7 + arg_368_0 then
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
			local var_372_0 = arg_369_1.actors_["10171ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect10171ui_story == nil then
				arg_369_1.var_.characterEffect10171ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect10171ui_story and not isNil(var_372_0) then
					arg_369_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect10171ui_story then
				arg_369_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_372_4 = 0
			local var_372_5 = 0.225

			if var_372_4 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_6 = arg_369_1:FormatText(StoryNameCfg[1451].name)

				arg_369_1.leftNameTxt_.text = var_372_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_7 = arg_369_1:GetWordFromCfg(324151082)
				local var_372_8 = arg_369_1:FormatText(var_372_7.content)

				arg_369_1.text_.text = var_372_8

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_9 = 9
				local var_372_10 = utf8.len(var_372_8)
				local var_372_11 = var_372_9 <= 0 and var_372_5 or var_372_5 * (var_372_10 / var_372_9)

				if var_372_11 > 0 and var_372_5 < var_372_11 then
					arg_369_1.talkMaxDuration = var_372_11

					if var_372_11 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_11 + var_372_4
					end
				end

				arg_369_1.text_.text = var_372_8
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151082", "story_v_out_324151.awb") ~= 0 then
					local var_372_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151082", "story_v_out_324151.awb") / 1000

					if var_372_12 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_12 + var_372_4
					end

					if var_372_7.prefab_name ~= "" and arg_369_1.actors_[var_372_7.prefab_name] ~= nil then
						local var_372_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_7.prefab_name].transform, "story_v_out_324151", "324151082", "story_v_out_324151.awb")

						arg_369_1:RecordAudio("324151082", var_372_13)
						arg_369_1:RecordAudio("324151082", var_372_13)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_324151", "324151082", "story_v_out_324151.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_324151", "324151082", "story_v_out_324151.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_14 = math.max(var_372_5, arg_369_1.talkMaxDuration)

			if var_372_4 <= arg_369_1.time_ and arg_369_1.time_ < var_372_4 + var_372_14 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_4) / var_372_14

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_4 + var_372_14 and arg_369_1.time_ < var_372_4 + var_372_14 + arg_372_0 then
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
			local var_376_0 = arg_373_1.actors_["10171ui_story"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect10171ui_story == nil then
				arg_373_1.var_.characterEffect10171ui_story = var_376_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.characterEffect10171ui_story and not isNil(var_376_0) then
					local var_376_4 = Mathf.Lerp(0, 0.5, var_376_3)

					arg_373_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_373_1.var_.characterEffect10171ui_story.fillRatio = var_376_4
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect10171ui_story then
				local var_376_5 = 0.5

				arg_373_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_373_1.var_.characterEffect10171ui_story.fillRatio = var_376_5
			end

			local var_376_6 = 0

			if var_376_6 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_7 = 1

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_7 then
				local var_376_8 = (arg_373_1.time_ - var_376_6) / var_376_7
				local var_376_9 = Color.New(1, 1, 1)

				var_376_9.a = Mathf.Lerp(1, 0, var_376_8)
				arg_373_1.mask_.color = var_376_9
			end

			if arg_373_1.time_ >= var_376_6 + var_376_7 and arg_373_1.time_ < var_376_6 + var_376_7 + arg_376_0 then
				local var_376_10 = Color.New(1, 1, 1)
				local var_376_11 = 0

				arg_373_1.mask_.enabled = false
				var_376_10.a = var_376_11
				arg_373_1.mask_.color = var_376_10
			end

			local var_376_12 = 0.1
			local var_376_13 = 1

			if var_376_12 < arg_373_1.time_ and arg_373_1.time_ <= var_376_12 + arg_376_0 then
				local var_376_14 = "play"
				local var_376_15 = "effect"

				arg_373_1:AudioAction(var_376_14, var_376_15, "se_story_150", "se_story_150_amb_drone_down01", "")
			end

			local var_376_16 = 0.1
			local var_376_17 = 1

			if var_376_16 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 then
				local var_376_18 = "play"
				local var_376_19 = "effect"

				arg_373_1:AudioAction(var_376_18, var_376_19, "se_story_150", "se_story_150_sword07", "")
			end

			local var_376_20 = 0.717440504021943
			local var_376_21 = 1.4

			if var_376_20 < arg_373_1.time_ and arg_373_1.time_ <= var_376_20 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_22 = arg_373_1:GetWordFromCfg(324151083)
				local var_376_23 = arg_373_1:FormatText(var_376_22.content)

				arg_373_1.text_.text = var_376_23

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_24 = 56
				local var_376_25 = utf8.len(var_376_23)
				local var_376_26 = var_376_24 <= 0 and var_376_21 or var_376_21 * (var_376_25 / var_376_24)

				if var_376_26 > 0 and var_376_21 < var_376_26 then
					arg_373_1.talkMaxDuration = var_376_26

					if var_376_26 + var_376_20 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_26 + var_376_20
					end
				end

				arg_373_1.text_.text = var_376_23
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_27 = math.max(var_376_21, arg_373_1.talkMaxDuration)

			if var_376_20 <= arg_373_1.time_ and arg_373_1.time_ < var_376_20 + var_376_27 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_20) / var_376_27

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_20 + var_376_27 and arg_373_1.time_ < var_376_20 + var_376_27 + arg_376_0 then
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
			local var_380_0 = 0
			local var_380_1 = 1.475

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_2 = arg_377_1:GetWordFromCfg(324151084)
				local var_380_3 = arg_377_1:FormatText(var_380_2.content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_4 = 59
				local var_380_5 = utf8.len(var_380_3)
				local var_380_6 = var_380_4 <= 0 and var_380_1 or var_380_1 * (var_380_5 / var_380_4)

				if var_380_6 > 0 and var_380_1 < var_380_6 then
					arg_377_1.talkMaxDuration = var_380_6

					if var_380_6 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_6 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_7 and arg_377_1.time_ < var_380_0 + var_380_7 + arg_380_0 then
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
			local var_384_0 = 0
			local var_384_1 = 0.625

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_2 = arg_381_1:GetWordFromCfg(324151085)
				local var_384_3 = arg_381_1:FormatText(var_384_2.content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 25
				local var_384_5 = utf8.len(var_384_3)
				local var_384_6 = var_384_4 <= 0 and var_384_1 or var_384_1 * (var_384_5 / var_384_4)

				if var_384_6 > 0 and var_384_1 < var_384_6 then
					arg_381_1.talkMaxDuration = var_384_6

					if var_384_6 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_7 and arg_381_1.time_ < var_384_0 + var_384_7 + arg_384_0 then
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
			local var_388_0 = arg_385_1.actors_["10171ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect10171ui_story == nil then
				arg_385_1.var_.characterEffect10171ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect10171ui_story and not isNil(var_388_0) then
					arg_385_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect10171ui_story then
				arg_385_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_388_4 = 0
			local var_388_5 = 0.2

			if var_388_4 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_6 = arg_385_1:FormatText(StoryNameCfg[1451].name)

				arg_385_1.leftNameTxt_.text = var_388_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_7 = arg_385_1:GetWordFromCfg(324151086)
				local var_388_8 = arg_385_1:FormatText(var_388_7.content)

				arg_385_1.text_.text = var_388_8

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 8
				local var_388_10 = utf8.len(var_388_8)
				local var_388_11 = var_388_9 <= 0 and var_388_5 or var_388_5 * (var_388_10 / var_388_9)

				if var_388_11 > 0 and var_388_5 < var_388_11 then
					arg_385_1.talkMaxDuration = var_388_11

					if var_388_11 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_11 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_8
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151086", "story_v_out_324151.awb") ~= 0 then
					local var_388_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151086", "story_v_out_324151.awb") / 1000

					if var_388_12 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_12 + var_388_4
					end

					if var_388_7.prefab_name ~= "" and arg_385_1.actors_[var_388_7.prefab_name] ~= nil then
						local var_388_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_7.prefab_name].transform, "story_v_out_324151", "324151086", "story_v_out_324151.awb")

						arg_385_1:RecordAudio("324151086", var_388_13)
						arg_385_1:RecordAudio("324151086", var_388_13)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_324151", "324151086", "story_v_out_324151.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_324151", "324151086", "story_v_out_324151.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_14 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_14 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_14

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_14 and arg_385_1.time_ < var_388_4 + var_388_14 + arg_388_0 then
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
			local var_392_0 = arg_389_1.actors_["10171ui_story"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect10171ui_story == nil then
				arg_389_1.var_.characterEffect10171ui_story = var_392_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.characterEffect10171ui_story and not isNil(var_392_0) then
					local var_392_4 = Mathf.Lerp(0, 0.5, var_392_3)

					arg_389_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_389_1.var_.characterEffect10171ui_story.fillRatio = var_392_4
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect10171ui_story then
				local var_392_5 = 0.5

				arg_389_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_389_1.var_.characterEffect10171ui_story.fillRatio = var_392_5
			end

			local var_392_6 = 0
			local var_392_7 = 1

			if var_392_6 < arg_389_1.time_ and arg_389_1.time_ <= var_392_6 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_8 = arg_389_1:GetWordFromCfg(324151087)
				local var_392_9 = arg_389_1:FormatText(var_392_8.content)

				arg_389_1.text_.text = var_392_9

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_10 = 40
				local var_392_11 = utf8.len(var_392_9)
				local var_392_12 = var_392_10 <= 0 and var_392_7 or var_392_7 * (var_392_11 / var_392_10)

				if var_392_12 > 0 and var_392_7 < var_392_12 then
					arg_389_1.talkMaxDuration = var_392_12

					if var_392_12 + var_392_6 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_12 + var_392_6
					end
				end

				arg_389_1.text_.text = var_392_9
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_13 = math.max(var_392_7, arg_389_1.talkMaxDuration)

			if var_392_6 <= arg_389_1.time_ and arg_389_1.time_ < var_392_6 + var_392_13 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_6) / var_392_13

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_6 + var_392_13 and arg_389_1.time_ < var_392_6 + var_392_13 + arg_392_0 then
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
			local var_396_0 = 0
			local var_396_1 = 1.075

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_2 = arg_393_1:GetWordFromCfg(324151088)
				local var_396_3 = arg_393_1:FormatText(var_396_2.content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 43
				local var_396_5 = utf8.len(var_396_3)
				local var_396_6 = var_396_4 <= 0 and var_396_1 or var_396_1 * (var_396_5 / var_396_4)

				if var_396_6 > 0 and var_396_1 < var_396_6 then
					arg_393_1.talkMaxDuration = var_396_6

					if var_396_6 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_6 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_7 and arg_393_1.time_ < var_396_0 + var_396_7 + arg_396_0 then
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
			local var_400_0 = 0
			local var_400_1 = 0.95

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_2 = arg_397_1:GetWordFromCfg(324151089)
				local var_400_3 = arg_397_1:FormatText(var_400_2.content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 38
				local var_400_5 = utf8.len(var_400_3)
				local var_400_6 = var_400_4 <= 0 and var_400_1 or var_400_1 * (var_400_5 / var_400_4)

				if var_400_6 > 0 and var_400_1 < var_400_6 then
					arg_397_1.talkMaxDuration = var_400_6

					if var_400_6 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_7 and arg_397_1.time_ < var_400_0 + var_400_7 + arg_400_0 then
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
			local var_404_0 = arg_401_1.actors_["10171ui_story"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect10171ui_story == nil then
				arg_401_1.var_.characterEffect10171ui_story = var_404_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.characterEffect10171ui_story and not isNil(var_404_0) then
					arg_401_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect10171ui_story then
				arg_401_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_404_4 = 0
			local var_404_5 = 0.3

			if var_404_4 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_6 = arg_401_1:FormatText(StoryNameCfg[1451].name)

				arg_401_1.leftNameTxt_.text = var_404_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_7 = arg_401_1:GetWordFromCfg(324151090)
				local var_404_8 = arg_401_1:FormatText(var_404_7.content)

				arg_401_1.text_.text = var_404_8

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_9 = 12
				local var_404_10 = utf8.len(var_404_8)
				local var_404_11 = var_404_9 <= 0 and var_404_5 or var_404_5 * (var_404_10 / var_404_9)

				if var_404_11 > 0 and var_404_5 < var_404_11 then
					arg_401_1.talkMaxDuration = var_404_11

					if var_404_11 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_11 + var_404_4
					end
				end

				arg_401_1.text_.text = var_404_8
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151090", "story_v_out_324151.awb") ~= 0 then
					local var_404_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151090", "story_v_out_324151.awb") / 1000

					if var_404_12 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_12 + var_404_4
					end

					if var_404_7.prefab_name ~= "" and arg_401_1.actors_[var_404_7.prefab_name] ~= nil then
						local var_404_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_7.prefab_name].transform, "story_v_out_324151", "324151090", "story_v_out_324151.awb")

						arg_401_1:RecordAudio("324151090", var_404_13)
						arg_401_1:RecordAudio("324151090", var_404_13)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_324151", "324151090", "story_v_out_324151.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_324151", "324151090", "story_v_out_324151.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_5, arg_401_1.talkMaxDuration)

			if var_404_4 <= arg_401_1.time_ and arg_401_1.time_ < var_404_4 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_4) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_4 + var_404_14 and arg_401_1.time_ < var_404_4 + var_404_14 + arg_404_0 then
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
			local var_408_0 = arg_405_1.actors_["10171ui_story"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect10171ui_story == nil then
				arg_405_1.var_.characterEffect10171ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.characterEffect10171ui_story and not isNil(var_408_0) then
					local var_408_4 = Mathf.Lerp(0, 0.5, var_408_3)

					arg_405_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_405_1.var_.characterEffect10171ui_story.fillRatio = var_408_4
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect10171ui_story then
				local var_408_5 = 0.5

				arg_405_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_405_1.var_.characterEffect10171ui_story.fillRatio = var_408_5
			end

			local var_408_6 = 0
			local var_408_7 = 1.275

			if var_408_6 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_8 = arg_405_1:GetWordFromCfg(324151091)
				local var_408_9 = arg_405_1:FormatText(var_408_8.content)

				arg_405_1.text_.text = var_408_9

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_10 = 51
				local var_408_11 = utf8.len(var_408_9)
				local var_408_12 = var_408_10 <= 0 and var_408_7 or var_408_7 * (var_408_11 / var_408_10)

				if var_408_12 > 0 and var_408_7 < var_408_12 then
					arg_405_1.talkMaxDuration = var_408_12

					if var_408_12 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_12 + var_408_6
					end
				end

				arg_405_1.text_.text = var_408_9
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_13 = math.max(var_408_7, arg_405_1.talkMaxDuration)

			if var_408_6 <= arg_405_1.time_ and arg_405_1.time_ < var_408_6 + var_408_13 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_6) / var_408_13

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_6 + var_408_13 and arg_405_1.time_ < var_408_6 + var_408_13 + arg_408_0 then
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
			local var_412_0 = arg_409_1.actors_["10171ui_story"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect10171ui_story == nil then
				arg_409_1.var_.characterEffect10171ui_story = var_412_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.characterEffect10171ui_story and not isNil(var_412_0) then
					arg_409_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect10171ui_story then
				arg_409_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_412_4 = manager.ui.mainCamera.transform
			local var_412_5 = 0

			if var_412_5 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				local var_412_6 = arg_409_1.var_.effect3434
				local var_412_7
				local var_412_8 = var_412_4

				if not var_412_6 then
					var_412_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), var_412_8)
					var_412_6.name = "3434"
					arg_409_1.var_.effect3434 = var_412_6
				else
					var_412_6.transform:SetParent(var_412_8)
				end

				var_412_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_412_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_412_9 = 1.7777777777777777
				local var_412_10 = Screen.width / Screen.height
				local var_412_11 = var_412_10 / var_412_9
				local var_412_12 = Mathf.Max(var_412_9 / var_412_10, 1)

				var_412_6.transform.localScale = Vector3.New(var_412_6.transform.localScale.x * var_412_11, var_412_6.transform.localScale.y * var_412_12, var_412_6.transform.localScale.z)
			end

			local var_412_13 = 0

			if var_412_13 < arg_409_1.time_ and arg_409_1.time_ <= var_412_13 + arg_412_0 then
				arg_409_1.mask_.enabled = true
				arg_409_1.mask_.raycastTarget = true

				arg_409_1:SetGaussion(false)
			end

			local var_412_14 = 0.866666666666667

			if var_412_13 <= arg_409_1.time_ and arg_409_1.time_ < var_412_13 + var_412_14 then
				local var_412_15 = (arg_409_1.time_ - var_412_13) / var_412_14
				local var_412_16 = Color.New(0, 0, 0)

				var_412_16.a = Mathf.Lerp(1, 0, var_412_15)
				arg_409_1.mask_.color = var_412_16
			end

			if arg_409_1.time_ >= var_412_13 + var_412_14 and arg_409_1.time_ < var_412_13 + var_412_14 + arg_412_0 then
				local var_412_17 = Color.New(0, 0, 0)
				local var_412_18 = 0

				arg_409_1.mask_.enabled = false
				var_412_17.a = var_412_18
				arg_409_1.mask_.color = var_412_17
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_19 = 0.724999999999
			local var_412_20 = 0.275

			if var_412_19 < arg_409_1.time_ and arg_409_1.time_ <= var_412_19 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_21 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_21:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_22 = arg_409_1:FormatText(StoryNameCfg[1451].name)

				arg_409_1.leftNameTxt_.text = var_412_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_23 = arg_409_1:GetWordFromCfg(324151092)
				local var_412_24 = arg_409_1:FormatText(var_412_23.content)

				arg_409_1.text_.text = var_412_24

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_25 = 11
				local var_412_26 = utf8.len(var_412_24)
				local var_412_27 = var_412_25 <= 0 and var_412_20 or var_412_20 * (var_412_26 / var_412_25)

				if var_412_27 > 0 and var_412_20 < var_412_27 then
					arg_409_1.talkMaxDuration = var_412_27
					var_412_19 = var_412_19 + 0.3

					if var_412_27 + var_412_19 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_27 + var_412_19
					end
				end

				arg_409_1.text_.text = var_412_24
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151092", "story_v_out_324151.awb") ~= 0 then
					local var_412_28 = manager.audio:GetVoiceLength("story_v_out_324151", "324151092", "story_v_out_324151.awb") / 1000

					if var_412_28 + var_412_19 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_28 + var_412_19
					end

					if var_412_23.prefab_name ~= "" and arg_409_1.actors_[var_412_23.prefab_name] ~= nil then
						local var_412_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_23.prefab_name].transform, "story_v_out_324151", "324151092", "story_v_out_324151.awb")

						arg_409_1:RecordAudio("324151092", var_412_29)
						arg_409_1:RecordAudio("324151092", var_412_29)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_324151", "324151092", "story_v_out_324151.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_324151", "324151092", "story_v_out_324151.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_30 = var_412_19 + 0.3
			local var_412_31 = math.max(var_412_20, arg_409_1.talkMaxDuration)

			if var_412_30 <= arg_409_1.time_ and arg_409_1.time_ < var_412_30 + var_412_31 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_30) / var_412_31

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_30 + var_412_31 and arg_409_1.time_ < var_412_30 + var_412_31 + arg_412_0 then
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
			local var_418_0 = arg_415_1.actors_["10171ui_story"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect10171ui_story == nil then
				arg_415_1.var_.characterEffect10171ui_story = var_418_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.characterEffect10171ui_story and not isNil(var_418_0) then
					local var_418_4 = Mathf.Lerp(0, 0.5, var_418_3)

					arg_415_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_415_1.var_.characterEffect10171ui_story.fillRatio = var_418_4
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect10171ui_story then
				local var_418_5 = 0.5

				arg_415_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_415_1.var_.characterEffect10171ui_story.fillRatio = var_418_5
			end

			local var_418_6 = 0
			local var_418_7 = 1.3

			if var_418_6 < arg_415_1.time_ and arg_415_1.time_ <= var_418_6 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_8 = arg_415_1:GetWordFromCfg(324151093)
				local var_418_9 = arg_415_1:FormatText(var_418_8.content)

				arg_415_1.text_.text = var_418_9

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_10 = 52
				local var_418_11 = utf8.len(var_418_9)
				local var_418_12 = var_418_10 <= 0 and var_418_7 or var_418_7 * (var_418_11 / var_418_10)

				if var_418_12 > 0 and var_418_7 < var_418_12 then
					arg_415_1.talkMaxDuration = var_418_12

					if var_418_12 + var_418_6 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_12 + var_418_6
					end
				end

				arg_415_1.text_.text = var_418_9
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_13 = math.max(var_418_7, arg_415_1.talkMaxDuration)

			if var_418_6 <= arg_415_1.time_ and arg_415_1.time_ < var_418_6 + var_418_13 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_6) / var_418_13

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_6 + var_418_13 and arg_415_1.time_ < var_418_6 + var_418_13 + arg_418_0 then
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
			local var_422_0 = 0
			local var_422_1 = 1.45

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_2 = arg_419_1:GetWordFromCfg(324151094)
				local var_422_3 = arg_419_1:FormatText(var_422_2.content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 58
				local var_422_5 = utf8.len(var_422_3)
				local var_422_6 = var_422_4 <= 0 and var_422_1 or var_422_1 * (var_422_5 / var_422_4)

				if var_422_6 > 0 and var_422_1 < var_422_6 then
					arg_419_1.talkMaxDuration = var_422_6

					if var_422_6 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_6 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_7 and arg_419_1.time_ < var_422_0 + var_422_7 + arg_422_0 then
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
			local var_426_0 = arg_423_1.actors_["10171ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect10171ui_story == nil then
				arg_423_1.var_.characterEffect10171ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect10171ui_story and not isNil(var_426_0) then
					arg_423_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect10171ui_story then
				arg_423_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_426_4 = 0
			local var_426_5 = 0.2

			if var_426_4 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_6 = arg_423_1:FormatText(StoryNameCfg[1451].name)

				arg_423_1.leftNameTxt_.text = var_426_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_7 = arg_423_1:GetWordFromCfg(324151095)
				local var_426_8 = arg_423_1:FormatText(var_426_7.content)

				arg_423_1.text_.text = var_426_8

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 8
				local var_426_10 = utf8.len(var_426_8)
				local var_426_11 = var_426_9 <= 0 and var_426_5 or var_426_5 * (var_426_10 / var_426_9)

				if var_426_11 > 0 and var_426_5 < var_426_11 then
					arg_423_1.talkMaxDuration = var_426_11

					if var_426_11 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_11 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_8
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151095", "story_v_out_324151.awb") ~= 0 then
					local var_426_12 = manager.audio:GetVoiceLength("story_v_out_324151", "324151095", "story_v_out_324151.awb") / 1000

					if var_426_12 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_12 + var_426_4
					end

					if var_426_7.prefab_name ~= "" and arg_423_1.actors_[var_426_7.prefab_name] ~= nil then
						local var_426_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_7.prefab_name].transform, "story_v_out_324151", "324151095", "story_v_out_324151.awb")

						arg_423_1:RecordAudio("324151095", var_426_13)
						arg_423_1:RecordAudio("324151095", var_426_13)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_324151", "324151095", "story_v_out_324151.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_324151", "324151095", "story_v_out_324151.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_14 = math.max(var_426_5, arg_423_1.talkMaxDuration)

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_14 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_4) / var_426_14

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_4 + var_426_14 and arg_423_1.time_ < var_426_4 + var_426_14 + arg_426_0 then
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
			local var_430_0 = arg_427_1.actors_["10171ui_story"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect10171ui_story == nil then
				arg_427_1.var_.characterEffect10171ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 and not isNil(var_430_0) then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.characterEffect10171ui_story and not isNil(var_430_0) then
					local var_430_4 = Mathf.Lerp(0, 0.5, var_430_3)

					arg_427_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_427_1.var_.characterEffect10171ui_story.fillRatio = var_430_4
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect10171ui_story then
				local var_430_5 = 0.5

				arg_427_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_427_1.var_.characterEffect10171ui_story.fillRatio = var_430_5
			end

			local var_430_6 = manager.ui.mainCamera.transform
			local var_430_7 = 0

			if var_430_7 < arg_427_1.time_ and arg_427_1.time_ <= var_430_7 + arg_430_0 then
				local var_430_8 = arg_427_1.var_.effect3434

				if var_430_8 then
					Object.Destroy(var_430_8)

					arg_427_1.var_.effect3434 = nil
				end
			end

			local var_430_9 = 0.1
			local var_430_10 = 1

			if var_430_9 < arg_427_1.time_ and arg_427_1.time_ <= var_430_9 + arg_430_0 then
				local var_430_11 = "play"
				local var_430_12 = "effect"

				arg_427_1:AudioAction(var_430_11, var_430_12, "se_story_150", "se_story_150_amb_drone_down02", "")
			end

			local var_430_13 = 0
			local var_430_14 = 1.625

			if var_430_13 < arg_427_1.time_ and arg_427_1.time_ <= var_430_13 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_15 = arg_427_1:GetWordFromCfg(324151096)
				local var_430_16 = arg_427_1:FormatText(var_430_15.content)

				arg_427_1.text_.text = var_430_16

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_17 = 65
				local var_430_18 = utf8.len(var_430_16)
				local var_430_19 = var_430_17 <= 0 and var_430_14 or var_430_14 * (var_430_18 / var_430_17)

				if var_430_19 > 0 and var_430_14 < var_430_19 then
					arg_427_1.talkMaxDuration = var_430_19

					if var_430_19 + var_430_13 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_19 + var_430_13
					end
				end

				arg_427_1.text_.text = var_430_16
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_20 = math.max(var_430_14, arg_427_1.talkMaxDuration)

			if var_430_13 <= arg_427_1.time_ and arg_427_1.time_ < var_430_13 + var_430_20 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_13) / var_430_20

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_13 + var_430_20 and arg_427_1.time_ < var_430_13 + var_430_20 + arg_430_0 then
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
			local var_434_0 = arg_431_1.actors_["10171ui_story"].transform
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.var_.moveOldPos10171ui_story = var_434_0.localPosition

				local var_434_2 = GameObjectTools.GetOrAddComponent(var_434_0.gameObject, typeof(DynamicBoneHelper))

				if var_434_2 then
					var_434_2:EnableDynamicBone(false)
				end
			end

			local var_434_3 = 0.001

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_3 then
				local var_434_4 = (arg_431_1.time_ - var_434_1) / var_434_3
				local var_434_5 = Vector3.New(0, -0.95, -6.05)

				var_434_0.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos10171ui_story, var_434_5, var_434_4)

				local var_434_6 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_6.x, var_434_6.y, var_434_6.z)

				local var_434_7 = var_434_0.localEulerAngles

				var_434_7.z = 0
				var_434_7.x = 0
				var_434_0.localEulerAngles = var_434_7
			end

			if arg_431_1.time_ >= var_434_1 + var_434_3 and arg_431_1.time_ < var_434_1 + var_434_3 + arg_434_0 then
				var_434_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_434_8 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_8.x, var_434_8.y, var_434_8.z)

				local var_434_9 = var_434_0.localEulerAngles

				var_434_9.z = 0
				var_434_9.x = 0
				var_434_0.localEulerAngles = var_434_9

				local var_434_10 = GameObjectTools.GetOrAddComponent(var_434_0.gameObject, typeof(DynamicBoneHelper))

				if var_434_10 then
					var_434_10:EnableDynamicBone(true)
				end
			end

			local var_434_11 = arg_431_1.actors_["10171ui_story"]
			local var_434_12 = 0

			if var_434_12 < arg_431_1.time_ and arg_431_1.time_ <= var_434_12 + arg_434_0 and not isNil(var_434_11) and arg_431_1.var_.characterEffect10171ui_story == nil then
				arg_431_1.var_.characterEffect10171ui_story = var_434_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_13 = 0.200000002980232

			if var_434_12 <= arg_431_1.time_ and arg_431_1.time_ < var_434_12 + var_434_13 and not isNil(var_434_11) then
				local var_434_14 = (arg_431_1.time_ - var_434_12) / var_434_13

				if arg_431_1.var_.characterEffect10171ui_story and not isNil(var_434_11) then
					arg_431_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_12 + var_434_13 and arg_431_1.time_ < var_434_12 + var_434_13 + arg_434_0 and not isNil(var_434_11) and arg_431_1.var_.characterEffect10171ui_story then
				arg_431_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_434_15 = 0

			if var_434_15 < arg_431_1.time_ and arg_431_1.time_ <= var_434_15 + arg_434_0 then
				arg_431_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_434_16 = 0

			if var_434_16 < arg_431_1.time_ and arg_431_1.time_ <= var_434_16 + arg_434_0 then
				arg_431_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_434_17 = 0
			local var_434_18 = 0.175

			if var_434_17 < arg_431_1.time_ and arg_431_1.time_ <= var_434_17 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_19 = arg_431_1:FormatText(StoryNameCfg[1451].name)

				arg_431_1.leftNameTxt_.text = var_434_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_20 = arg_431_1:GetWordFromCfg(324151097)
				local var_434_21 = arg_431_1:FormatText(var_434_20.content)

				arg_431_1.text_.text = var_434_21

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_22 = 7
				local var_434_23 = utf8.len(var_434_21)
				local var_434_24 = var_434_22 <= 0 and var_434_18 or var_434_18 * (var_434_23 / var_434_22)

				if var_434_24 > 0 and var_434_18 < var_434_24 then
					arg_431_1.talkMaxDuration = var_434_24

					if var_434_24 + var_434_17 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_24 + var_434_17
					end
				end

				arg_431_1.text_.text = var_434_21
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151097", "story_v_out_324151.awb") ~= 0 then
					local var_434_25 = manager.audio:GetVoiceLength("story_v_out_324151", "324151097", "story_v_out_324151.awb") / 1000

					if var_434_25 + var_434_17 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_25 + var_434_17
					end

					if var_434_20.prefab_name ~= "" and arg_431_1.actors_[var_434_20.prefab_name] ~= nil then
						local var_434_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_20.prefab_name].transform, "story_v_out_324151", "324151097", "story_v_out_324151.awb")

						arg_431_1:RecordAudio("324151097", var_434_26)
						arg_431_1:RecordAudio("324151097", var_434_26)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_324151", "324151097", "story_v_out_324151.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_324151", "324151097", "story_v_out_324151.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_27 = math.max(var_434_18, arg_431_1.talkMaxDuration)

			if var_434_17 <= arg_431_1.time_ and arg_431_1.time_ < var_434_17 + var_434_27 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_17) / var_434_27

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_17 + var_434_27 and arg_431_1.time_ < var_434_17 + var_434_27 + arg_434_0 then
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
			local var_438_0 = arg_435_1.actors_["10171ui_story"].transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.var_.moveOldPos10171ui_story = var_438_0.localPosition

				local var_438_2 = GameObjectTools.GetOrAddComponent(var_438_0.gameObject, typeof(DynamicBoneHelper))

				if var_438_2 then
					var_438_2:EnableDynamicBone(false)
				end
			end

			local var_438_3 = 0.001

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_3 then
				local var_438_4 = (arg_435_1.time_ - var_438_1) / var_438_3
				local var_438_5 = Vector3.New(0, 100, 0)

				var_438_0.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos10171ui_story, var_438_5, var_438_4)

				local var_438_6 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_6.x, var_438_6.y, var_438_6.z)

				local var_438_7 = var_438_0.localEulerAngles

				var_438_7.z = 0
				var_438_7.x = 0
				var_438_0.localEulerAngles = var_438_7
			end

			if arg_435_1.time_ >= var_438_1 + var_438_3 and arg_435_1.time_ < var_438_1 + var_438_3 + arg_438_0 then
				var_438_0.localPosition = Vector3.New(0, 100, 0)

				local var_438_8 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_8.x, var_438_8.y, var_438_8.z)

				local var_438_9 = var_438_0.localEulerAngles

				var_438_9.z = 0
				var_438_9.x = 0
				var_438_0.localEulerAngles = var_438_9

				local var_438_10 = GameObjectTools.GetOrAddComponent(var_438_0.gameObject, typeof(DynamicBoneHelper))

				if var_438_10 then
					var_438_10:EnableDynamicBone(true)
				end
			end

			local var_438_11 = "1060ui_story"

			if arg_435_1.actors_[var_438_11] == nil then
				local var_438_12 = Asset.Load("Char/" .. "1060ui_story")

				if not isNil(var_438_12) then
					local var_438_13 = Object.Instantiate(Asset.Load("Char/" .. "1060ui_story"), arg_435_1.stage_.transform)

					var_438_13.name = var_438_11
					var_438_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_435_1.actors_[var_438_11] = var_438_13

					local var_438_14 = var_438_13:GetComponentInChildren(typeof(CharacterEffect))

					var_438_14.enabled = true

					local var_438_15 = GameObjectTools.GetOrAddComponent(var_438_13, typeof(DynamicBoneHelper))

					if var_438_15 then
						var_438_15:EnableDynamicBone(false)
					end

					arg_435_1:ShowWeapon(var_438_14.transform, false)

					arg_435_1.var_[var_438_11 .. "Animator"] = var_438_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_435_1.var_[var_438_11 .. "Animator"].applyRootMotion = true
					arg_435_1.var_[var_438_11 .. "LipSync"] = var_438_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_438_16 = arg_435_1.actors_["1060ui_story"].transform
			local var_438_17 = 0

			if var_438_17 < arg_435_1.time_ and arg_435_1.time_ <= var_438_17 + arg_438_0 then
				arg_435_1.var_.moveOldPos1060ui_story = var_438_16.localPosition
			end

			local var_438_18 = 0.001

			if var_438_17 <= arg_435_1.time_ and arg_435_1.time_ < var_438_17 + var_438_18 then
				local var_438_19 = (arg_435_1.time_ - var_438_17) / var_438_18
				local var_438_20 = Vector3.New(0, -1.14, -6.33)

				var_438_16.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1060ui_story, var_438_20, var_438_19)

				local var_438_21 = manager.ui.mainCamera.transform.position - var_438_16.position

				var_438_16.forward = Vector3.New(var_438_21.x, var_438_21.y, var_438_21.z)

				local var_438_22 = var_438_16.localEulerAngles

				var_438_22.z = 0
				var_438_22.x = 0
				var_438_16.localEulerAngles = var_438_22
			end

			if arg_435_1.time_ >= var_438_17 + var_438_18 and arg_435_1.time_ < var_438_17 + var_438_18 + arg_438_0 then
				var_438_16.localPosition = Vector3.New(0, -1.14, -6.33)

				local var_438_23 = manager.ui.mainCamera.transform.position - var_438_16.position

				var_438_16.forward = Vector3.New(var_438_23.x, var_438_23.y, var_438_23.z)

				local var_438_24 = var_438_16.localEulerAngles

				var_438_24.z = 0
				var_438_24.x = 0
				var_438_16.localEulerAngles = var_438_24
			end

			local var_438_25 = arg_435_1.actors_["1060ui_story"]
			local var_438_26 = 0

			if var_438_26 < arg_435_1.time_ and arg_435_1.time_ <= var_438_26 + arg_438_0 and not isNil(var_438_25) and arg_435_1.var_.characterEffect1060ui_story == nil then
				arg_435_1.var_.characterEffect1060ui_story = var_438_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_27 = 0.200000002980232

			if var_438_26 <= arg_435_1.time_ and arg_435_1.time_ < var_438_26 + var_438_27 and not isNil(var_438_25) then
				local var_438_28 = (arg_435_1.time_ - var_438_26) / var_438_27

				if arg_435_1.var_.characterEffect1060ui_story and not isNil(var_438_25) then
					arg_435_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= var_438_26 + var_438_27 and arg_435_1.time_ < var_438_26 + var_438_27 + arg_438_0 and not isNil(var_438_25) and arg_435_1.var_.characterEffect1060ui_story then
				arg_435_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_438_29 = arg_435_1.actors_["10171ui_story"]
			local var_438_30 = 0

			if var_438_30 < arg_435_1.time_ and arg_435_1.time_ <= var_438_30 + arg_438_0 and not isNil(var_438_29) and arg_435_1.var_.characterEffect10171ui_story == nil then
				arg_435_1.var_.characterEffect10171ui_story = var_438_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_31 = 0.200000002980232

			if var_438_30 <= arg_435_1.time_ and arg_435_1.time_ < var_438_30 + var_438_31 and not isNil(var_438_29) then
				local var_438_32 = (arg_435_1.time_ - var_438_30) / var_438_31

				if arg_435_1.var_.characterEffect10171ui_story and not isNil(var_438_29) then
					local var_438_33 = Mathf.Lerp(0, 0.5, var_438_32)

					arg_435_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_435_1.var_.characterEffect10171ui_story.fillRatio = var_438_33
				end
			end

			if arg_435_1.time_ >= var_438_30 + var_438_31 and arg_435_1.time_ < var_438_30 + var_438_31 + arg_438_0 and not isNil(var_438_29) and arg_435_1.var_.characterEffect10171ui_story then
				local var_438_34 = 0.5

				arg_435_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_435_1.var_.characterEffect10171ui_story.fillRatio = var_438_34
			end

			local var_438_35 = 0

			if var_438_35 < arg_435_1.time_ and arg_435_1.time_ <= var_438_35 + arg_438_0 then
				arg_435_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_1")
			end

			local var_438_36 = 0

			if var_438_36 < arg_435_1.time_ and arg_435_1.time_ <= var_438_36 + arg_438_0 then
				arg_435_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_438_37 = 0
			local var_438_38 = 0.375

			if var_438_37 < arg_435_1.time_ and arg_435_1.time_ <= var_438_37 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_39 = arg_435_1:FormatText(StoryNameCfg[584].name)

				arg_435_1.leftNameTxt_.text = var_438_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_40 = arg_435_1:GetWordFromCfg(324151098)
				local var_438_41 = arg_435_1:FormatText(var_438_40.content)

				arg_435_1.text_.text = var_438_41

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_42 = 15
				local var_438_43 = utf8.len(var_438_41)
				local var_438_44 = var_438_42 <= 0 and var_438_38 or var_438_38 * (var_438_43 / var_438_42)

				if var_438_44 > 0 and var_438_38 < var_438_44 then
					arg_435_1.talkMaxDuration = var_438_44

					if var_438_44 + var_438_37 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_44 + var_438_37
					end
				end

				arg_435_1.text_.text = var_438_41
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151098", "story_v_out_324151.awb") ~= 0 then
					local var_438_45 = manager.audio:GetVoiceLength("story_v_out_324151", "324151098", "story_v_out_324151.awb") / 1000

					if var_438_45 + var_438_37 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_45 + var_438_37
					end

					if var_438_40.prefab_name ~= "" and arg_435_1.actors_[var_438_40.prefab_name] ~= nil then
						local var_438_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_40.prefab_name].transform, "story_v_out_324151", "324151098", "story_v_out_324151.awb")

						arg_435_1:RecordAudio("324151098", var_438_46)
						arg_435_1:RecordAudio("324151098", var_438_46)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_324151", "324151098", "story_v_out_324151.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_324151", "324151098", "story_v_out_324151.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_47 = math.max(var_438_38, arg_435_1.talkMaxDuration)

			if var_438_37 <= arg_435_1.time_ and arg_435_1.time_ < var_438_37 + var_438_47 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_37) / var_438_47

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_37 + var_438_47 and arg_435_1.time_ < var_438_37 + var_438_47 + arg_438_0 then
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
			local var_442_0 = arg_439_1.actors_["1060ui_story"]
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1060ui_story == nil then
				arg_439_1.var_.characterEffect1060ui_story = var_442_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 and not isNil(var_442_0) then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2

				if arg_439_1.var_.characterEffect1060ui_story and not isNil(var_442_0) then
					local var_442_4 = Mathf.Lerp(0, 0.5, var_442_3)

					arg_439_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1060ui_story.fillRatio = var_442_4
				end
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1060ui_story then
				local var_442_5 = 0.5

				arg_439_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1060ui_story.fillRatio = var_442_5
			end

			local var_442_6 = 0
			local var_442_7 = 1.375

			if var_442_6 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_8 = arg_439_1:GetWordFromCfg(324151099)
				local var_442_9 = arg_439_1:FormatText(var_442_8.content)

				arg_439_1.text_.text = var_442_9

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_10 = 55
				local var_442_11 = utf8.len(var_442_9)
				local var_442_12 = var_442_10 <= 0 and var_442_7 or var_442_7 * (var_442_11 / var_442_10)

				if var_442_12 > 0 and var_442_7 < var_442_12 then
					arg_439_1.talkMaxDuration = var_442_12

					if var_442_12 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_12 + var_442_6
					end
				end

				arg_439_1.text_.text = var_442_9
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_13 = math.max(var_442_7, arg_439_1.talkMaxDuration)

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_13 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_6) / var_442_13

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_6 + var_442_13 and arg_439_1.time_ < var_442_6 + var_442_13 + arg_442_0 then
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
			local var_446_0 = arg_443_1.actors_["10171ui_story"].transform
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.var_.moveOldPos10171ui_story = var_446_0.localPosition

				local var_446_2 = GameObjectTools.GetOrAddComponent(var_446_0.gameObject, typeof(DynamicBoneHelper))

				if var_446_2 then
					var_446_2:EnableDynamicBone(false)
				end
			end

			local var_446_3 = 0.001

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_3 then
				local var_446_4 = (arg_443_1.time_ - var_446_1) / var_446_3
				local var_446_5 = Vector3.New(0, -0.95, -6.05)

				var_446_0.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10171ui_story, var_446_5, var_446_4)

				local var_446_6 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_6.x, var_446_6.y, var_446_6.z)

				local var_446_7 = var_446_0.localEulerAngles

				var_446_7.z = 0
				var_446_7.x = 0
				var_446_0.localEulerAngles = var_446_7
			end

			if arg_443_1.time_ >= var_446_1 + var_446_3 and arg_443_1.time_ < var_446_1 + var_446_3 + arg_446_0 then
				var_446_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_446_8 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_8.x, var_446_8.y, var_446_8.z)

				local var_446_9 = var_446_0.localEulerAngles

				var_446_9.z = 0
				var_446_9.x = 0
				var_446_0.localEulerAngles = var_446_9

				local var_446_10 = GameObjectTools.GetOrAddComponent(var_446_0.gameObject, typeof(DynamicBoneHelper))

				if var_446_10 then
					var_446_10:EnableDynamicBone(true)
				end
			end

			local var_446_11 = arg_443_1.actors_["1060ui_story"].transform
			local var_446_12 = 0

			if var_446_12 < arg_443_1.time_ and arg_443_1.time_ <= var_446_12 + arg_446_0 then
				arg_443_1.var_.moveOldPos1060ui_story = var_446_11.localPosition
			end

			local var_446_13 = 0.001

			if var_446_12 <= arg_443_1.time_ and arg_443_1.time_ < var_446_12 + var_446_13 then
				local var_446_14 = (arg_443_1.time_ - var_446_12) / var_446_13
				local var_446_15 = Vector3.New(0, 100, 0)

				var_446_11.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1060ui_story, var_446_15, var_446_14)

				local var_446_16 = manager.ui.mainCamera.transform.position - var_446_11.position

				var_446_11.forward = Vector3.New(var_446_16.x, var_446_16.y, var_446_16.z)

				local var_446_17 = var_446_11.localEulerAngles

				var_446_17.z = 0
				var_446_17.x = 0
				var_446_11.localEulerAngles = var_446_17
			end

			if arg_443_1.time_ >= var_446_12 + var_446_13 and arg_443_1.time_ < var_446_12 + var_446_13 + arg_446_0 then
				var_446_11.localPosition = Vector3.New(0, 100, 0)

				local var_446_18 = manager.ui.mainCamera.transform.position - var_446_11.position

				var_446_11.forward = Vector3.New(var_446_18.x, var_446_18.y, var_446_18.z)

				local var_446_19 = var_446_11.localEulerAngles

				var_446_19.z = 0
				var_446_19.x = 0
				var_446_11.localEulerAngles = var_446_19
			end

			local var_446_20 = arg_443_1.actors_["10171ui_story"]
			local var_446_21 = 0

			if var_446_21 < arg_443_1.time_ and arg_443_1.time_ <= var_446_21 + arg_446_0 and not isNil(var_446_20) and arg_443_1.var_.characterEffect10171ui_story == nil then
				arg_443_1.var_.characterEffect10171ui_story = var_446_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_22 = 0.200000002980232

			if var_446_21 <= arg_443_1.time_ and arg_443_1.time_ < var_446_21 + var_446_22 and not isNil(var_446_20) then
				local var_446_23 = (arg_443_1.time_ - var_446_21) / var_446_22

				if arg_443_1.var_.characterEffect10171ui_story and not isNil(var_446_20) then
					arg_443_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= var_446_21 + var_446_22 and arg_443_1.time_ < var_446_21 + var_446_22 + arg_446_0 and not isNil(var_446_20) and arg_443_1.var_.characterEffect10171ui_story then
				arg_443_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_446_24 = 0

			if var_446_24 < arg_443_1.time_ and arg_443_1.time_ <= var_446_24 + arg_446_0 then
				arg_443_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_446_25 = 0

			if var_446_25 < arg_443_1.time_ and arg_443_1.time_ <= var_446_25 + arg_446_0 then
				arg_443_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_446_26 = 0
			local var_446_27 = 0.35

			if var_446_26 < arg_443_1.time_ and arg_443_1.time_ <= var_446_26 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_28 = arg_443_1:FormatText(StoryNameCfg[1451].name)

				arg_443_1.leftNameTxt_.text = var_446_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_29 = arg_443_1:GetWordFromCfg(324151100)
				local var_446_30 = arg_443_1:FormatText(var_446_29.content)

				arg_443_1.text_.text = var_446_30

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_31 = 14
				local var_446_32 = utf8.len(var_446_30)
				local var_446_33 = var_446_31 <= 0 and var_446_27 or var_446_27 * (var_446_32 / var_446_31)

				if var_446_33 > 0 and var_446_27 < var_446_33 then
					arg_443_1.talkMaxDuration = var_446_33

					if var_446_33 + var_446_26 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_33 + var_446_26
					end
				end

				arg_443_1.text_.text = var_446_30
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151100", "story_v_out_324151.awb") ~= 0 then
					local var_446_34 = manager.audio:GetVoiceLength("story_v_out_324151", "324151100", "story_v_out_324151.awb") / 1000

					if var_446_34 + var_446_26 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_34 + var_446_26
					end

					if var_446_29.prefab_name ~= "" and arg_443_1.actors_[var_446_29.prefab_name] ~= nil then
						local var_446_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_29.prefab_name].transform, "story_v_out_324151", "324151100", "story_v_out_324151.awb")

						arg_443_1:RecordAudio("324151100", var_446_35)
						arg_443_1:RecordAudio("324151100", var_446_35)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_324151", "324151100", "story_v_out_324151.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_324151", "324151100", "story_v_out_324151.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_36 = math.max(var_446_27, arg_443_1.talkMaxDuration)

			if var_446_26 <= arg_443_1.time_ and arg_443_1.time_ < var_446_26 + var_446_36 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_26) / var_446_36

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_26 + var_446_36 and arg_443_1.time_ < var_446_26 + var_446_36 + arg_446_0 then
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
			local var_450_0 = arg_447_1.actors_["10171ui_story"].transform
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.var_.moveOldPos10171ui_story = var_450_0.localPosition

				local var_450_2 = GameObjectTools.GetOrAddComponent(var_450_0.gameObject, typeof(DynamicBoneHelper))

				if var_450_2 then
					var_450_2:EnableDynamicBone(false)
				end
			end

			local var_450_3 = 0.001

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_3 then
				local var_450_4 = (arg_447_1.time_ - var_450_1) / var_450_3
				local var_450_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10171ui_story, var_450_5, var_450_4)

				local var_450_6 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_6.x, var_450_6.y, var_450_6.z)

				local var_450_7 = var_450_0.localEulerAngles

				var_450_7.z = 0
				var_450_7.x = 0
				var_450_0.localEulerAngles = var_450_7
			end

			if arg_447_1.time_ >= var_450_1 + var_450_3 and arg_447_1.time_ < var_450_1 + var_450_3 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_450_8 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_8.x, var_450_8.y, var_450_8.z)

				local var_450_9 = var_450_0.localEulerAngles

				var_450_9.z = 0
				var_450_9.x = 0
				var_450_0.localEulerAngles = var_450_9

				local var_450_10 = GameObjectTools.GetOrAddComponent(var_450_0.gameObject, typeof(DynamicBoneHelper))

				if var_450_10 then
					var_450_10:EnableDynamicBone(true)
				end
			end

			local var_450_11 = "1072ui_story"

			if arg_447_1.actors_[var_450_11] == nil then
				local var_450_12 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_450_12) then
					local var_450_13 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_447_1.stage_.transform)

					var_450_13.name = var_450_11
					var_450_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_447_1.actors_[var_450_11] = var_450_13

					local var_450_14 = var_450_13:GetComponentInChildren(typeof(CharacterEffect))

					var_450_14.enabled = true

					local var_450_15 = GameObjectTools.GetOrAddComponent(var_450_13, typeof(DynamicBoneHelper))

					if var_450_15 then
						var_450_15:EnableDynamicBone(false)
					end

					arg_447_1:ShowWeapon(var_450_14.transform, false)

					arg_447_1.var_[var_450_11 .. "Animator"] = var_450_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_447_1.var_[var_450_11 .. "Animator"].applyRootMotion = true
					arg_447_1.var_[var_450_11 .. "LipSync"] = var_450_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_450_16 = arg_447_1.actors_["1072ui_story"].transform
			local var_450_17 = 0

			if var_450_17 < arg_447_1.time_ and arg_447_1.time_ <= var_450_17 + arg_450_0 then
				arg_447_1.var_.moveOldPos1072ui_story = var_450_16.localPosition
			end

			local var_450_18 = 0.001

			if var_450_17 <= arg_447_1.time_ and arg_447_1.time_ < var_450_17 + var_450_18 then
				local var_450_19 = (arg_447_1.time_ - var_450_17) / var_450_18
				local var_450_20 = Vector3.New(0.7, -0.71, -6)

				var_450_16.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1072ui_story, var_450_20, var_450_19)

				local var_450_21 = manager.ui.mainCamera.transform.position - var_450_16.position

				var_450_16.forward = Vector3.New(var_450_21.x, var_450_21.y, var_450_21.z)

				local var_450_22 = var_450_16.localEulerAngles

				var_450_22.z = 0
				var_450_22.x = 0
				var_450_16.localEulerAngles = var_450_22
			end

			if arg_447_1.time_ >= var_450_17 + var_450_18 and arg_447_1.time_ < var_450_17 + var_450_18 + arg_450_0 then
				var_450_16.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_450_23 = manager.ui.mainCamera.transform.position - var_450_16.position

				var_450_16.forward = Vector3.New(var_450_23.x, var_450_23.y, var_450_23.z)

				local var_450_24 = var_450_16.localEulerAngles

				var_450_24.z = 0
				var_450_24.x = 0
				var_450_16.localEulerAngles = var_450_24
			end

			local var_450_25 = arg_447_1.actors_["1072ui_story"]
			local var_450_26 = 0

			if var_450_26 < arg_447_1.time_ and arg_447_1.time_ <= var_450_26 + arg_450_0 and not isNil(var_450_25) and arg_447_1.var_.characterEffect1072ui_story == nil then
				arg_447_1.var_.characterEffect1072ui_story = var_450_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_27 = 0.200000002980232

			if var_450_26 <= arg_447_1.time_ and arg_447_1.time_ < var_450_26 + var_450_27 and not isNil(var_450_25) then
				local var_450_28 = (arg_447_1.time_ - var_450_26) / var_450_27

				if arg_447_1.var_.characterEffect1072ui_story and not isNil(var_450_25) then
					arg_447_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= var_450_26 + var_450_27 and arg_447_1.time_ < var_450_26 + var_450_27 + arg_450_0 and not isNil(var_450_25) and arg_447_1.var_.characterEffect1072ui_story then
				arg_447_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_450_29 = arg_447_1.actors_["10171ui_story"]
			local var_450_30 = 0

			if var_450_30 < arg_447_1.time_ and arg_447_1.time_ <= var_450_30 + arg_450_0 and not isNil(var_450_29) and arg_447_1.var_.characterEffect10171ui_story == nil then
				arg_447_1.var_.characterEffect10171ui_story = var_450_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_31 = 0.200000002980232

			if var_450_30 <= arg_447_1.time_ and arg_447_1.time_ < var_450_30 + var_450_31 and not isNil(var_450_29) then
				local var_450_32 = (arg_447_1.time_ - var_450_30) / var_450_31

				if arg_447_1.var_.characterEffect10171ui_story and not isNil(var_450_29) then
					local var_450_33 = Mathf.Lerp(0, 0.5, var_450_32)

					arg_447_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_447_1.var_.characterEffect10171ui_story.fillRatio = var_450_33
				end
			end

			if arg_447_1.time_ >= var_450_30 + var_450_31 and arg_447_1.time_ < var_450_30 + var_450_31 + arg_450_0 and not isNil(var_450_29) and arg_447_1.var_.characterEffect10171ui_story then
				local var_450_34 = 0.5

				arg_447_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_447_1.var_.characterEffect10171ui_story.fillRatio = var_450_34
			end

			local var_450_35 = 0

			if var_450_35 < arg_447_1.time_ and arg_447_1.time_ <= var_450_35 + arg_450_0 then
				arg_447_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_450_36 = 0

			if var_450_36 < arg_447_1.time_ and arg_447_1.time_ <= var_450_36 + arg_450_0 then
				arg_447_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_450_37 = 0
			local var_450_38 = 0.55

			if var_450_37 < arg_447_1.time_ and arg_447_1.time_ <= var_450_37 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_39 = arg_447_1:FormatText(StoryNameCfg[379].name)

				arg_447_1.leftNameTxt_.text = var_450_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_40 = arg_447_1:GetWordFromCfg(324151101)
				local var_450_41 = arg_447_1:FormatText(var_450_40.content)

				arg_447_1.text_.text = var_450_41

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_42 = 22
				local var_450_43 = utf8.len(var_450_41)
				local var_450_44 = var_450_42 <= 0 and var_450_38 or var_450_38 * (var_450_43 / var_450_42)

				if var_450_44 > 0 and var_450_38 < var_450_44 then
					arg_447_1.talkMaxDuration = var_450_44

					if var_450_44 + var_450_37 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_44 + var_450_37
					end
				end

				arg_447_1.text_.text = var_450_41
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151101", "story_v_out_324151.awb") ~= 0 then
					local var_450_45 = manager.audio:GetVoiceLength("story_v_out_324151", "324151101", "story_v_out_324151.awb") / 1000

					if var_450_45 + var_450_37 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_45 + var_450_37
					end

					if var_450_40.prefab_name ~= "" and arg_447_1.actors_[var_450_40.prefab_name] ~= nil then
						local var_450_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_40.prefab_name].transform, "story_v_out_324151", "324151101", "story_v_out_324151.awb")

						arg_447_1:RecordAudio("324151101", var_450_46)
						arg_447_1:RecordAudio("324151101", var_450_46)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_324151", "324151101", "story_v_out_324151.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_324151", "324151101", "story_v_out_324151.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_47 = math.max(var_450_38, arg_447_1.talkMaxDuration)

			if var_450_37 <= arg_447_1.time_ and arg_447_1.time_ < var_450_37 + var_450_47 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_37) / var_450_47

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_37 + var_450_47 and arg_447_1.time_ < var_450_37 + var_450_47 + arg_450_0 then
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
			local var_454_0 = "1074ui_story"

			if arg_451_1.actors_[var_454_0] == nil then
				local var_454_1 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_454_1) then
					local var_454_2 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_451_1.stage_.transform)

					var_454_2.name = var_454_0
					var_454_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_451_1.actors_[var_454_0] = var_454_2

					local var_454_3 = var_454_2:GetComponentInChildren(typeof(CharacterEffect))

					var_454_3.enabled = true

					local var_454_4 = GameObjectTools.GetOrAddComponent(var_454_2, typeof(DynamicBoneHelper))

					if var_454_4 then
						var_454_4:EnableDynamicBone(false)
					end

					arg_451_1:ShowWeapon(var_454_3.transform, false)

					arg_451_1.var_[var_454_0 .. "Animator"] = var_454_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_451_1.var_[var_454_0 .. "Animator"].applyRootMotion = true
					arg_451_1.var_[var_454_0 .. "LipSync"] = var_454_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_454_5 = arg_451_1.actors_["1074ui_story"].transform
			local var_454_6 = 0

			if var_454_6 < arg_451_1.time_ and arg_451_1.time_ <= var_454_6 + arg_454_0 then
				arg_451_1.var_.moveOldPos1074ui_story = var_454_5.localPosition
			end

			local var_454_7 = 0.001

			if var_454_6 <= arg_451_1.time_ and arg_451_1.time_ < var_454_6 + var_454_7 then
				local var_454_8 = (arg_451_1.time_ - var_454_6) / var_454_7
				local var_454_9 = Vector3.New(0, -1.055, -6.12)

				var_454_5.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1074ui_story, var_454_9, var_454_8)

				local var_454_10 = manager.ui.mainCamera.transform.position - var_454_5.position

				var_454_5.forward = Vector3.New(var_454_10.x, var_454_10.y, var_454_10.z)

				local var_454_11 = var_454_5.localEulerAngles

				var_454_11.z = 0
				var_454_11.x = 0
				var_454_5.localEulerAngles = var_454_11
			end

			if arg_451_1.time_ >= var_454_6 + var_454_7 and arg_451_1.time_ < var_454_6 + var_454_7 + arg_454_0 then
				var_454_5.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_454_12 = manager.ui.mainCamera.transform.position - var_454_5.position

				var_454_5.forward = Vector3.New(var_454_12.x, var_454_12.y, var_454_12.z)

				local var_454_13 = var_454_5.localEulerAngles

				var_454_13.z = 0
				var_454_13.x = 0
				var_454_5.localEulerAngles = var_454_13
			end

			local var_454_14 = arg_451_1.actors_["10171ui_story"].transform
			local var_454_15 = 0

			if var_454_15 < arg_451_1.time_ and arg_451_1.time_ <= var_454_15 + arg_454_0 then
				arg_451_1.var_.moveOldPos10171ui_story = var_454_14.localPosition

				local var_454_16 = GameObjectTools.GetOrAddComponent(var_454_14.gameObject, typeof(DynamicBoneHelper))

				if var_454_16 then
					var_454_16:EnableDynamicBone(false)
				end
			end

			local var_454_17 = 0.001

			if var_454_15 <= arg_451_1.time_ and arg_451_1.time_ < var_454_15 + var_454_17 then
				local var_454_18 = (arg_451_1.time_ - var_454_15) / var_454_17
				local var_454_19 = Vector3.New(0, 100, 0)

				var_454_14.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos10171ui_story, var_454_19, var_454_18)

				local var_454_20 = manager.ui.mainCamera.transform.position - var_454_14.position

				var_454_14.forward = Vector3.New(var_454_20.x, var_454_20.y, var_454_20.z)

				local var_454_21 = var_454_14.localEulerAngles

				var_454_21.z = 0
				var_454_21.x = 0
				var_454_14.localEulerAngles = var_454_21
			end

			if arg_451_1.time_ >= var_454_15 + var_454_17 and arg_451_1.time_ < var_454_15 + var_454_17 + arg_454_0 then
				var_454_14.localPosition = Vector3.New(0, 100, 0)

				local var_454_22 = manager.ui.mainCamera.transform.position - var_454_14.position

				var_454_14.forward = Vector3.New(var_454_22.x, var_454_22.y, var_454_22.z)

				local var_454_23 = var_454_14.localEulerAngles

				var_454_23.z = 0
				var_454_23.x = 0
				var_454_14.localEulerAngles = var_454_23

				local var_454_24 = GameObjectTools.GetOrAddComponent(var_454_14.gameObject, typeof(DynamicBoneHelper))

				if var_454_24 then
					var_454_24:EnableDynamicBone(true)
				end
			end

			local var_454_25 = arg_451_1.actors_["1072ui_story"].transform
			local var_454_26 = 0

			if var_454_26 < arg_451_1.time_ and arg_451_1.time_ <= var_454_26 + arg_454_0 then
				arg_451_1.var_.moveOldPos1072ui_story = var_454_25.localPosition
			end

			local var_454_27 = 0.001

			if var_454_26 <= arg_451_1.time_ and arg_451_1.time_ < var_454_26 + var_454_27 then
				local var_454_28 = (arg_451_1.time_ - var_454_26) / var_454_27
				local var_454_29 = Vector3.New(0, 100, 0)

				var_454_25.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1072ui_story, var_454_29, var_454_28)

				local var_454_30 = manager.ui.mainCamera.transform.position - var_454_25.position

				var_454_25.forward = Vector3.New(var_454_30.x, var_454_30.y, var_454_30.z)

				local var_454_31 = var_454_25.localEulerAngles

				var_454_31.z = 0
				var_454_31.x = 0
				var_454_25.localEulerAngles = var_454_31
			end

			if arg_451_1.time_ >= var_454_26 + var_454_27 and arg_451_1.time_ < var_454_26 + var_454_27 + arg_454_0 then
				var_454_25.localPosition = Vector3.New(0, 100, 0)

				local var_454_32 = manager.ui.mainCamera.transform.position - var_454_25.position

				var_454_25.forward = Vector3.New(var_454_32.x, var_454_32.y, var_454_32.z)

				local var_454_33 = var_454_25.localEulerAngles

				var_454_33.z = 0
				var_454_33.x = 0
				var_454_25.localEulerAngles = var_454_33
			end

			local var_454_34 = arg_451_1.actors_["1074ui_story"]
			local var_454_35 = 0

			if var_454_35 < arg_451_1.time_ and arg_451_1.time_ <= var_454_35 + arg_454_0 and not isNil(var_454_34) and arg_451_1.var_.characterEffect1074ui_story == nil then
				arg_451_1.var_.characterEffect1074ui_story = var_454_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_36 = 0.200000002980232

			if var_454_35 <= arg_451_1.time_ and arg_451_1.time_ < var_454_35 + var_454_36 and not isNil(var_454_34) then
				local var_454_37 = (arg_451_1.time_ - var_454_35) / var_454_36

				if arg_451_1.var_.characterEffect1074ui_story and not isNil(var_454_34) then
					arg_451_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= var_454_35 + var_454_36 and arg_451_1.time_ < var_454_35 + var_454_36 + arg_454_0 and not isNil(var_454_34) and arg_451_1.var_.characterEffect1074ui_story then
				arg_451_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_454_38 = arg_451_1.actors_["1072ui_story"]
			local var_454_39 = 0

			if var_454_39 < arg_451_1.time_ and arg_451_1.time_ <= var_454_39 + arg_454_0 and not isNil(var_454_38) and arg_451_1.var_.characterEffect1072ui_story == nil then
				arg_451_1.var_.characterEffect1072ui_story = var_454_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_40 = 0.200000002980232

			if var_454_39 <= arg_451_1.time_ and arg_451_1.time_ < var_454_39 + var_454_40 and not isNil(var_454_38) then
				local var_454_41 = (arg_451_1.time_ - var_454_39) / var_454_40

				if arg_451_1.var_.characterEffect1072ui_story and not isNil(var_454_38) then
					local var_454_42 = Mathf.Lerp(0, 0.5, var_454_41)

					arg_451_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1072ui_story.fillRatio = var_454_42
				end
			end

			if arg_451_1.time_ >= var_454_39 + var_454_40 and arg_451_1.time_ < var_454_39 + var_454_40 + arg_454_0 and not isNil(var_454_38) and arg_451_1.var_.characterEffect1072ui_story then
				local var_454_43 = 0.5

				arg_451_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1072ui_story.fillRatio = var_454_43
			end

			local var_454_44 = 0

			if var_454_44 < arg_451_1.time_ and arg_451_1.time_ <= var_454_44 + arg_454_0 then
				arg_451_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_454_45 = 0

			if var_454_45 < arg_451_1.time_ and arg_451_1.time_ <= var_454_45 + arg_454_0 then
				arg_451_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_454_46 = 0
			local var_454_47 = 0.4

			if var_454_46 < arg_451_1.time_ and arg_451_1.time_ <= var_454_46 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_48 = arg_451_1:FormatText(StoryNameCfg[410].name)

				arg_451_1.leftNameTxt_.text = var_454_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_49 = arg_451_1:GetWordFromCfg(324151102)
				local var_454_50 = arg_451_1:FormatText(var_454_49.content)

				arg_451_1.text_.text = var_454_50

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_51 = 16
				local var_454_52 = utf8.len(var_454_50)
				local var_454_53 = var_454_51 <= 0 and var_454_47 or var_454_47 * (var_454_52 / var_454_51)

				if var_454_53 > 0 and var_454_47 < var_454_53 then
					arg_451_1.talkMaxDuration = var_454_53

					if var_454_53 + var_454_46 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_53 + var_454_46
					end
				end

				arg_451_1.text_.text = var_454_50
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151102", "story_v_out_324151.awb") ~= 0 then
					local var_454_54 = manager.audio:GetVoiceLength("story_v_out_324151", "324151102", "story_v_out_324151.awb") / 1000

					if var_454_54 + var_454_46 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_54 + var_454_46
					end

					if var_454_49.prefab_name ~= "" and arg_451_1.actors_[var_454_49.prefab_name] ~= nil then
						local var_454_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_49.prefab_name].transform, "story_v_out_324151", "324151102", "story_v_out_324151.awb")

						arg_451_1:RecordAudio("324151102", var_454_55)
						arg_451_1:RecordAudio("324151102", var_454_55)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_324151", "324151102", "story_v_out_324151.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_324151", "324151102", "story_v_out_324151.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_56 = math.max(var_454_47, arg_451_1.talkMaxDuration)

			if var_454_46 <= arg_451_1.time_ and arg_451_1.time_ < var_454_46 + var_454_56 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_46) / var_454_56

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_46 + var_454_56 and arg_451_1.time_ < var_454_46 + var_454_56 + arg_454_0 then
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
			local var_458_0 = 1.36666666666667

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				local var_458_1 = manager.ui.mainCamera.transform.localPosition
				local var_458_2 = Vector3.New(0, 0, 10) + Vector3.New(var_458_1.x, var_458_1.y, 0)
				local var_458_3 = arg_455_1.bgs_.J22g

				var_458_3.transform.localPosition = var_458_2
				var_458_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_458_4 = var_458_3:GetComponent("SpriteRenderer")

				if var_458_4 and var_458_4.sprite then
					local var_458_5 = (var_458_3.transform.localPosition - var_458_1).z
					local var_458_6 = manager.ui.mainCameraCom_
					local var_458_7 = 2 * var_458_5 * Mathf.Tan(var_458_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_458_8 = var_458_7 * var_458_6.aspect
					local var_458_9 = var_458_4.sprite.bounds.size.x
					local var_458_10 = var_458_4.sprite.bounds.size.y
					local var_458_11 = var_458_8 / var_458_9
					local var_458_12 = var_458_7 / var_458_10
					local var_458_13 = var_458_12 < var_458_11 and var_458_11 or var_458_12

					var_458_3.transform.localScale = Vector3.New(var_458_13, var_458_13, 0)
				end

				for iter_458_0, iter_458_1 in pairs(arg_455_1.bgs_) do
					if iter_458_0 ~= "J22g" then
						iter_458_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_458_14 = 1.36666666666667

			if var_458_14 < arg_455_1.time_ and arg_455_1.time_ <= var_458_14 + arg_458_0 then
				arg_455_1.allBtn_.enabled = false
			end

			local var_458_15 = 0.3

			if arg_455_1.time_ >= var_458_14 + var_458_15 and arg_455_1.time_ < var_458_14 + var_458_15 + arg_458_0 then
				arg_455_1.allBtn_.enabled = true
			end

			local var_458_16 = 0

			if var_458_16 < arg_455_1.time_ and arg_455_1.time_ <= var_458_16 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_17 = 1.36666666666667

			if var_458_16 <= arg_455_1.time_ and arg_455_1.time_ < var_458_16 + var_458_17 then
				local var_458_18 = (arg_455_1.time_ - var_458_16) / var_458_17
				local var_458_19 = Color.New(0, 0, 0)

				var_458_19.a = Mathf.Lerp(0, 1, var_458_18)
				arg_455_1.mask_.color = var_458_19
			end

			if arg_455_1.time_ >= var_458_16 + var_458_17 and arg_455_1.time_ < var_458_16 + var_458_17 + arg_458_0 then
				local var_458_20 = Color.New(0, 0, 0)

				var_458_20.a = 1
				arg_455_1.mask_.color = var_458_20
			end

			local var_458_21 = 1.36666666666667

			if var_458_21 < arg_455_1.time_ and arg_455_1.time_ <= var_458_21 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_22 = 2.23333333333333

			if var_458_21 <= arg_455_1.time_ and arg_455_1.time_ < var_458_21 + var_458_22 then
				local var_458_23 = (arg_455_1.time_ - var_458_21) / var_458_22
				local var_458_24 = Color.New(0, 0, 0)

				var_458_24.a = Mathf.Lerp(1, 0, var_458_23)
				arg_455_1.mask_.color = var_458_24
			end

			if arg_455_1.time_ >= var_458_21 + var_458_22 and arg_455_1.time_ < var_458_21 + var_458_22 + arg_458_0 then
				local var_458_25 = Color.New(0, 0, 0)
				local var_458_26 = 0

				arg_455_1.mask_.enabled = false
				var_458_25.a = var_458_26
				arg_455_1.mask_.color = var_458_25
			end

			local var_458_27 = arg_455_1.actors_["1074ui_story"].transform
			local var_458_28 = 1.36666666666667

			if var_458_28 < arg_455_1.time_ and arg_455_1.time_ <= var_458_28 + arg_458_0 then
				arg_455_1.var_.moveOldPos1074ui_story = var_458_27.localPosition
			end

			local var_458_29 = 0.001

			if var_458_28 <= arg_455_1.time_ and arg_455_1.time_ < var_458_28 + var_458_29 then
				local var_458_30 = (arg_455_1.time_ - var_458_28) / var_458_29
				local var_458_31 = Vector3.New(0, 100, 0)

				var_458_27.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1074ui_story, var_458_31, var_458_30)

				local var_458_32 = manager.ui.mainCamera.transform.position - var_458_27.position

				var_458_27.forward = Vector3.New(var_458_32.x, var_458_32.y, var_458_32.z)

				local var_458_33 = var_458_27.localEulerAngles

				var_458_33.z = 0
				var_458_33.x = 0
				var_458_27.localEulerAngles = var_458_33
			end

			if arg_455_1.time_ >= var_458_28 + var_458_29 and arg_455_1.time_ < var_458_28 + var_458_29 + arg_458_0 then
				var_458_27.localPosition = Vector3.New(0, 100, 0)

				local var_458_34 = manager.ui.mainCamera.transform.position - var_458_27.position

				var_458_27.forward = Vector3.New(var_458_34.x, var_458_34.y, var_458_34.z)

				local var_458_35 = var_458_27.localEulerAngles

				var_458_35.z = 0
				var_458_35.x = 0
				var_458_27.localEulerAngles = var_458_35
			end

			local var_458_36 = arg_455_1.actors_["1074ui_story"]
			local var_458_37 = 1.36666666666667

			if var_458_37 < arg_455_1.time_ and arg_455_1.time_ <= var_458_37 + arg_458_0 and not isNil(var_458_36) and arg_455_1.var_.characterEffect1074ui_story == nil then
				arg_455_1.var_.characterEffect1074ui_story = var_458_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_38 = 0.200000002980232

			if var_458_37 <= arg_455_1.time_ and arg_455_1.time_ < var_458_37 + var_458_38 and not isNil(var_458_36) then
				local var_458_39 = (arg_455_1.time_ - var_458_37) / var_458_38

				if arg_455_1.var_.characterEffect1074ui_story and not isNil(var_458_36) then
					local var_458_40 = Mathf.Lerp(0, 0.5, var_458_39)

					arg_455_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1074ui_story.fillRatio = var_458_40
				end
			end

			if arg_455_1.time_ >= var_458_37 + var_458_38 and arg_455_1.time_ < var_458_37 + var_458_38 + arg_458_0 and not isNil(var_458_36) and arg_455_1.var_.characterEffect1074ui_story then
				local var_458_41 = 0.5

				arg_455_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1074ui_story.fillRatio = var_458_41
			end

			if arg_455_1.frameCnt_ <= 1 then
				arg_455_1.dialog_:SetActive(false)
			end

			local var_458_42 = 2.26666666666667
			local var_458_43 = 1.1

			if var_458_42 < arg_455_1.time_ and arg_455_1.time_ <= var_458_42 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0

				arg_455_1.dialog_:SetActive(true)

				arg_455_1.dialogCg_.alpha = 0

				local var_458_44 = LeanTween.value(arg_455_1.dialog_, 0, 1, 0.3)

				var_458_44:setOnUpdate(LuaHelper.FloatAction(function(arg_459_0)
					arg_455_1.dialogCg_.alpha = arg_459_0
				end))
				var_458_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_455_1.dialog_)
					var_458_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_455_1.duration_ = arg_455_1.duration_ + 0.3

				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_45 = arg_455_1:GetWordFromCfg(324151103)
				local var_458_46 = arg_455_1:FormatText(var_458_45.content)

				arg_455_1.text_.text = var_458_46

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_47 = 44
				local var_458_48 = utf8.len(var_458_46)
				local var_458_49 = var_458_47 <= 0 and var_458_43 or var_458_43 * (var_458_48 / var_458_47)

				if var_458_49 > 0 and var_458_43 < var_458_49 then
					arg_455_1.talkMaxDuration = var_458_49
					var_458_42 = var_458_42 + 0.3

					if var_458_49 + var_458_42 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_49 + var_458_42
					end
				end

				arg_455_1.text_.text = var_458_46
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_50 = var_458_42 + 0.3
			local var_458_51 = math.max(var_458_43, arg_455_1.talkMaxDuration)

			if var_458_50 <= arg_455_1.time_ and arg_455_1.time_ < var_458_50 + var_458_51 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_50) / var_458_51

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_50 + var_458_51 and arg_455_1.time_ < var_458_50 + var_458_51 + arg_458_0 then
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
			local var_464_0 = 0
			local var_464_1 = 1.475

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_2 = arg_461_1:GetWordFromCfg(324151104)
				local var_464_3 = arg_461_1:FormatText(var_464_2.content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 59
				local var_464_5 = utf8.len(var_464_3)
				local var_464_6 = var_464_4 <= 0 and var_464_1 or var_464_1 * (var_464_5 / var_464_4)

				if var_464_6 > 0 and var_464_1 < var_464_6 then
					arg_461_1.talkMaxDuration = var_464_6

					if var_464_6 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_7 and arg_461_1.time_ < var_464_0 + var_464_7 + arg_464_0 then
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
			local var_468_0 = arg_465_1.actors_["10171ui_story"].transform
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.var_.moveOldPos10171ui_story = var_468_0.localPosition

				local var_468_2 = GameObjectTools.GetOrAddComponent(var_468_0.gameObject, typeof(DynamicBoneHelper))

				if var_468_2 then
					var_468_2:EnableDynamicBone(false)
				end
			end

			local var_468_3 = 0.001

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_3 then
				local var_468_4 = (arg_465_1.time_ - var_468_1) / var_468_3
				local var_468_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_468_0.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos10171ui_story, var_468_5, var_468_4)

				local var_468_6 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_6.x, var_468_6.y, var_468_6.z)

				local var_468_7 = var_468_0.localEulerAngles

				var_468_7.z = 0
				var_468_7.x = 0
				var_468_0.localEulerAngles = var_468_7
			end

			if arg_465_1.time_ >= var_468_1 + var_468_3 and arg_465_1.time_ < var_468_1 + var_468_3 + arg_468_0 then
				var_468_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_468_8 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_8.x, var_468_8.y, var_468_8.z)

				local var_468_9 = var_468_0.localEulerAngles

				var_468_9.z = 0
				var_468_9.x = 0
				var_468_0.localEulerAngles = var_468_9

				local var_468_10 = GameObjectTools.GetOrAddComponent(var_468_0.gameObject, typeof(DynamicBoneHelper))

				if var_468_10 then
					var_468_10:EnableDynamicBone(true)
				end
			end

			local var_468_11 = arg_465_1.actors_["10171ui_story"]
			local var_468_12 = 0

			if var_468_12 < arg_465_1.time_ and arg_465_1.time_ <= var_468_12 + arg_468_0 and not isNil(var_468_11) and arg_465_1.var_.characterEffect10171ui_story == nil then
				arg_465_1.var_.characterEffect10171ui_story = var_468_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_13 = 0.200000002980232

			if var_468_12 <= arg_465_1.time_ and arg_465_1.time_ < var_468_12 + var_468_13 and not isNil(var_468_11) then
				local var_468_14 = (arg_465_1.time_ - var_468_12) / var_468_13

				if arg_465_1.var_.characterEffect10171ui_story and not isNil(var_468_11) then
					arg_465_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= var_468_12 + var_468_13 and arg_465_1.time_ < var_468_12 + var_468_13 + arg_468_0 and not isNil(var_468_11) and arg_465_1.var_.characterEffect10171ui_story then
				arg_465_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_468_15 = 0

			if var_468_15 < arg_465_1.time_ and arg_465_1.time_ <= var_468_15 + arg_468_0 then
				arg_465_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_468_16 = 0

			if var_468_16 < arg_465_1.time_ and arg_465_1.time_ <= var_468_16 + arg_468_0 then
				arg_465_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_468_17 = 0
			local var_468_18 = 0.3

			if var_468_17 < arg_465_1.time_ and arg_465_1.time_ <= var_468_17 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_19 = arg_465_1:FormatText(StoryNameCfg[1451].name)

				arg_465_1.leftNameTxt_.text = var_468_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_20 = arg_465_1:GetWordFromCfg(324151105)
				local var_468_21 = arg_465_1:FormatText(var_468_20.content)

				arg_465_1.text_.text = var_468_21

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_22 = 12
				local var_468_23 = utf8.len(var_468_21)
				local var_468_24 = var_468_22 <= 0 and var_468_18 or var_468_18 * (var_468_23 / var_468_22)

				if var_468_24 > 0 and var_468_18 < var_468_24 then
					arg_465_1.talkMaxDuration = var_468_24

					if var_468_24 + var_468_17 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_24 + var_468_17
					end
				end

				arg_465_1.text_.text = var_468_21
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151105", "story_v_out_324151.awb") ~= 0 then
					local var_468_25 = manager.audio:GetVoiceLength("story_v_out_324151", "324151105", "story_v_out_324151.awb") / 1000

					if var_468_25 + var_468_17 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_25 + var_468_17
					end

					if var_468_20.prefab_name ~= "" and arg_465_1.actors_[var_468_20.prefab_name] ~= nil then
						local var_468_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_20.prefab_name].transform, "story_v_out_324151", "324151105", "story_v_out_324151.awb")

						arg_465_1:RecordAudio("324151105", var_468_26)
						arg_465_1:RecordAudio("324151105", var_468_26)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_324151", "324151105", "story_v_out_324151.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_324151", "324151105", "story_v_out_324151.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_27 = math.max(var_468_18, arg_465_1.talkMaxDuration)

			if var_468_17 <= arg_465_1.time_ and arg_465_1.time_ < var_468_17 + var_468_27 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_17) / var_468_27

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_17 + var_468_27 and arg_465_1.time_ < var_468_17 + var_468_27 + arg_468_0 then
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
			local var_472_0 = arg_469_1.actors_["1060ui_story"].transform
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.var_.moveOldPos1060ui_story = var_472_0.localPosition
			end

			local var_472_2 = 0.001

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2
				local var_472_4 = Vector3.New(0.7, -1.14, -6.33)

				var_472_0.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1060ui_story, var_472_4, var_472_3)

				local var_472_5 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_5.x, var_472_5.y, var_472_5.z)

				local var_472_6 = var_472_0.localEulerAngles

				var_472_6.z = 0
				var_472_6.x = 0
				var_472_0.localEulerAngles = var_472_6
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 then
				var_472_0.localPosition = Vector3.New(0.7, -1.14, -6.33)

				local var_472_7 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_7.x, var_472_7.y, var_472_7.z)

				local var_472_8 = var_472_0.localEulerAngles

				var_472_8.z = 0
				var_472_8.x = 0
				var_472_0.localEulerAngles = var_472_8
			end

			local var_472_9 = arg_469_1.actors_["1060ui_story"]
			local var_472_10 = 0

			if var_472_10 < arg_469_1.time_ and arg_469_1.time_ <= var_472_10 + arg_472_0 and not isNil(var_472_9) and arg_469_1.var_.characterEffect1060ui_story == nil then
				arg_469_1.var_.characterEffect1060ui_story = var_472_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_11 = 0.200000002980232

			if var_472_10 <= arg_469_1.time_ and arg_469_1.time_ < var_472_10 + var_472_11 and not isNil(var_472_9) then
				local var_472_12 = (arg_469_1.time_ - var_472_10) / var_472_11

				if arg_469_1.var_.characterEffect1060ui_story and not isNil(var_472_9) then
					arg_469_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= var_472_10 + var_472_11 and arg_469_1.time_ < var_472_10 + var_472_11 + arg_472_0 and not isNil(var_472_9) and arg_469_1.var_.characterEffect1060ui_story then
				arg_469_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_472_13 = arg_469_1.actors_["10171ui_story"]
			local var_472_14 = 0

			if var_472_14 < arg_469_1.time_ and arg_469_1.time_ <= var_472_14 + arg_472_0 and not isNil(var_472_13) and arg_469_1.var_.characterEffect10171ui_story == nil then
				arg_469_1.var_.characterEffect10171ui_story = var_472_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_15 = 0.200000002980232

			if var_472_14 <= arg_469_1.time_ and arg_469_1.time_ < var_472_14 + var_472_15 and not isNil(var_472_13) then
				local var_472_16 = (arg_469_1.time_ - var_472_14) / var_472_15

				if arg_469_1.var_.characterEffect10171ui_story and not isNil(var_472_13) then
					local var_472_17 = Mathf.Lerp(0, 0.5, var_472_16)

					arg_469_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_469_1.var_.characterEffect10171ui_story.fillRatio = var_472_17
				end
			end

			if arg_469_1.time_ >= var_472_14 + var_472_15 and arg_469_1.time_ < var_472_14 + var_472_15 + arg_472_0 and not isNil(var_472_13) and arg_469_1.var_.characterEffect10171ui_story then
				local var_472_18 = 0.5

				arg_469_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_469_1.var_.characterEffect10171ui_story.fillRatio = var_472_18
			end

			local var_472_19 = 0

			if var_472_19 < arg_469_1.time_ and arg_469_1.time_ <= var_472_19 + arg_472_0 then
				arg_469_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_2")
			end

			local var_472_20 = 0

			if var_472_20 < arg_469_1.time_ and arg_469_1.time_ <= var_472_20 + arg_472_0 then
				arg_469_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_472_21 = 0
			local var_472_22 = 0.4

			if var_472_21 < arg_469_1.time_ and arg_469_1.time_ <= var_472_21 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_23 = arg_469_1:FormatText(StoryNameCfg[584].name)

				arg_469_1.leftNameTxt_.text = var_472_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_24 = arg_469_1:GetWordFromCfg(324151106)
				local var_472_25 = arg_469_1:FormatText(var_472_24.content)

				arg_469_1.text_.text = var_472_25

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_26 = 16
				local var_472_27 = utf8.len(var_472_25)
				local var_472_28 = var_472_26 <= 0 and var_472_22 or var_472_22 * (var_472_27 / var_472_26)

				if var_472_28 > 0 and var_472_22 < var_472_28 then
					arg_469_1.talkMaxDuration = var_472_28

					if var_472_28 + var_472_21 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_28 + var_472_21
					end
				end

				arg_469_1.text_.text = var_472_25
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151106", "story_v_out_324151.awb") ~= 0 then
					local var_472_29 = manager.audio:GetVoiceLength("story_v_out_324151", "324151106", "story_v_out_324151.awb") / 1000

					if var_472_29 + var_472_21 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_29 + var_472_21
					end

					if var_472_24.prefab_name ~= "" and arg_469_1.actors_[var_472_24.prefab_name] ~= nil then
						local var_472_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_24.prefab_name].transform, "story_v_out_324151", "324151106", "story_v_out_324151.awb")

						arg_469_1:RecordAudio("324151106", var_472_30)
						arg_469_1:RecordAudio("324151106", var_472_30)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_324151", "324151106", "story_v_out_324151.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_324151", "324151106", "story_v_out_324151.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_31 = math.max(var_472_22, arg_469_1.talkMaxDuration)

			if var_472_21 <= arg_469_1.time_ and arg_469_1.time_ < var_472_21 + var_472_31 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_21) / var_472_31

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_21 + var_472_31 and arg_469_1.time_ < var_472_21 + var_472_31 + arg_472_0 then
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
			local var_476_0 = arg_473_1.actors_["10171ui_story"]
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect10171ui_story == nil then
				arg_473_1.var_.characterEffect10171ui_story = var_476_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 and not isNil(var_476_0) then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2

				if arg_473_1.var_.characterEffect10171ui_story and not isNil(var_476_0) then
					arg_473_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect10171ui_story then
				arg_473_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_476_4 = arg_473_1.actors_["1060ui_story"]
			local var_476_5 = 0

			if var_476_5 < arg_473_1.time_ and arg_473_1.time_ <= var_476_5 + arg_476_0 and not isNil(var_476_4) and arg_473_1.var_.characterEffect1060ui_story == nil then
				arg_473_1.var_.characterEffect1060ui_story = var_476_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_6 = 0.200000002980232

			if var_476_5 <= arg_473_1.time_ and arg_473_1.time_ < var_476_5 + var_476_6 and not isNil(var_476_4) then
				local var_476_7 = (arg_473_1.time_ - var_476_5) / var_476_6

				if arg_473_1.var_.characterEffect1060ui_story and not isNil(var_476_4) then
					local var_476_8 = Mathf.Lerp(0, 0.5, var_476_7)

					arg_473_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1060ui_story.fillRatio = var_476_8
				end
			end

			if arg_473_1.time_ >= var_476_5 + var_476_6 and arg_473_1.time_ < var_476_5 + var_476_6 + arg_476_0 and not isNil(var_476_4) and arg_473_1.var_.characterEffect1060ui_story then
				local var_476_9 = 0.5

				arg_473_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1060ui_story.fillRatio = var_476_9
			end

			local var_476_10 = 0
			local var_476_11 = 0.225

			if var_476_10 < arg_473_1.time_ and arg_473_1.time_ <= var_476_10 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_12 = arg_473_1:FormatText(StoryNameCfg[1451].name)

				arg_473_1.leftNameTxt_.text = var_476_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_13 = arg_473_1:GetWordFromCfg(324151107)
				local var_476_14 = arg_473_1:FormatText(var_476_13.content)

				arg_473_1.text_.text = var_476_14

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_15 = 9
				local var_476_16 = utf8.len(var_476_14)
				local var_476_17 = var_476_15 <= 0 and var_476_11 or var_476_11 * (var_476_16 / var_476_15)

				if var_476_17 > 0 and var_476_11 < var_476_17 then
					arg_473_1.talkMaxDuration = var_476_17

					if var_476_17 + var_476_10 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_17 + var_476_10
					end
				end

				arg_473_1.text_.text = var_476_14
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151107", "story_v_out_324151.awb") ~= 0 then
					local var_476_18 = manager.audio:GetVoiceLength("story_v_out_324151", "324151107", "story_v_out_324151.awb") / 1000

					if var_476_18 + var_476_10 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_18 + var_476_10
					end

					if var_476_13.prefab_name ~= "" and arg_473_1.actors_[var_476_13.prefab_name] ~= nil then
						local var_476_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_13.prefab_name].transform, "story_v_out_324151", "324151107", "story_v_out_324151.awb")

						arg_473_1:RecordAudio("324151107", var_476_19)
						arg_473_1:RecordAudio("324151107", var_476_19)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_324151", "324151107", "story_v_out_324151.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_324151", "324151107", "story_v_out_324151.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_20 = math.max(var_476_11, arg_473_1.talkMaxDuration)

			if var_476_10 <= arg_473_1.time_ and arg_473_1.time_ < var_476_10 + var_476_20 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_10) / var_476_20

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_10 + var_476_20 and arg_473_1.time_ < var_476_10 + var_476_20 + arg_476_0 then
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
			local var_480_0 = arg_477_1.actors_["1074ui_story"].transform
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.var_.moveOldPos1074ui_story = var_480_0.localPosition
			end

			local var_480_2 = 0.001

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2
				local var_480_4 = Vector3.New(0.7, -1.055, -6.12)

				var_480_0.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1074ui_story, var_480_4, var_480_3)

				local var_480_5 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_5.x, var_480_5.y, var_480_5.z)

				local var_480_6 = var_480_0.localEulerAngles

				var_480_6.z = 0
				var_480_6.x = 0
				var_480_0.localEulerAngles = var_480_6
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 then
				var_480_0.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_480_7 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_7.x, var_480_7.y, var_480_7.z)

				local var_480_8 = var_480_0.localEulerAngles

				var_480_8.z = 0
				var_480_8.x = 0
				var_480_0.localEulerAngles = var_480_8
			end

			local var_480_9 = arg_477_1.actors_["1060ui_story"].transform
			local var_480_10 = 0

			if var_480_10 < arg_477_1.time_ and arg_477_1.time_ <= var_480_10 + arg_480_0 then
				arg_477_1.var_.moveOldPos1060ui_story = var_480_9.localPosition
			end

			local var_480_11 = 0.001

			if var_480_10 <= arg_477_1.time_ and arg_477_1.time_ < var_480_10 + var_480_11 then
				local var_480_12 = (arg_477_1.time_ - var_480_10) / var_480_11
				local var_480_13 = Vector3.New(0, 100, 0)

				var_480_9.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1060ui_story, var_480_13, var_480_12)

				local var_480_14 = manager.ui.mainCamera.transform.position - var_480_9.position

				var_480_9.forward = Vector3.New(var_480_14.x, var_480_14.y, var_480_14.z)

				local var_480_15 = var_480_9.localEulerAngles

				var_480_15.z = 0
				var_480_15.x = 0
				var_480_9.localEulerAngles = var_480_15
			end

			if arg_477_1.time_ >= var_480_10 + var_480_11 and arg_477_1.time_ < var_480_10 + var_480_11 + arg_480_0 then
				var_480_9.localPosition = Vector3.New(0, 100, 0)

				local var_480_16 = manager.ui.mainCamera.transform.position - var_480_9.position

				var_480_9.forward = Vector3.New(var_480_16.x, var_480_16.y, var_480_16.z)

				local var_480_17 = var_480_9.localEulerAngles

				var_480_17.z = 0
				var_480_17.x = 0
				var_480_9.localEulerAngles = var_480_17
			end

			local var_480_18 = arg_477_1.actors_["1074ui_story"]
			local var_480_19 = 0

			if var_480_19 < arg_477_1.time_ and arg_477_1.time_ <= var_480_19 + arg_480_0 and not isNil(var_480_18) and arg_477_1.var_.characterEffect1074ui_story == nil then
				arg_477_1.var_.characterEffect1074ui_story = var_480_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_20 = 0.200000002980232

			if var_480_19 <= arg_477_1.time_ and arg_477_1.time_ < var_480_19 + var_480_20 and not isNil(var_480_18) then
				local var_480_21 = (arg_477_1.time_ - var_480_19) / var_480_20

				if arg_477_1.var_.characterEffect1074ui_story and not isNil(var_480_18) then
					arg_477_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_19 + var_480_20 and arg_477_1.time_ < var_480_19 + var_480_20 + arg_480_0 and not isNil(var_480_18) and arg_477_1.var_.characterEffect1074ui_story then
				arg_477_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_480_22 = arg_477_1.actors_["10171ui_story"]
			local var_480_23 = 0

			if var_480_23 < arg_477_1.time_ and arg_477_1.time_ <= var_480_23 + arg_480_0 and not isNil(var_480_22) and arg_477_1.var_.characterEffect10171ui_story == nil then
				arg_477_1.var_.characterEffect10171ui_story = var_480_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_24 = 0.200000002980232

			if var_480_23 <= arg_477_1.time_ and arg_477_1.time_ < var_480_23 + var_480_24 and not isNil(var_480_22) then
				local var_480_25 = (arg_477_1.time_ - var_480_23) / var_480_24

				if arg_477_1.var_.characterEffect10171ui_story and not isNil(var_480_22) then
					local var_480_26 = Mathf.Lerp(0, 0.5, var_480_25)

					arg_477_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_477_1.var_.characterEffect10171ui_story.fillRatio = var_480_26
				end
			end

			if arg_477_1.time_ >= var_480_23 + var_480_24 and arg_477_1.time_ < var_480_23 + var_480_24 + arg_480_0 and not isNil(var_480_22) and arg_477_1.var_.characterEffect10171ui_story then
				local var_480_27 = 0.5

				arg_477_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_477_1.var_.characterEffect10171ui_story.fillRatio = var_480_27
			end

			local var_480_28 = 0

			if var_480_28 < arg_477_1.time_ and arg_477_1.time_ <= var_480_28 + arg_480_0 then
				arg_477_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			local var_480_29 = 0

			if var_480_29 < arg_477_1.time_ and arg_477_1.time_ <= var_480_29 + arg_480_0 then
				arg_477_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_480_30 = 0
			local var_480_31 = 1.075

			if var_480_30 < arg_477_1.time_ and arg_477_1.time_ <= var_480_30 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_32 = arg_477_1:FormatText(StoryNameCfg[410].name)

				arg_477_1.leftNameTxt_.text = var_480_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_33 = arg_477_1:GetWordFromCfg(324151108)
				local var_480_34 = arg_477_1:FormatText(var_480_33.content)

				arg_477_1.text_.text = var_480_34

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_35 = 43
				local var_480_36 = utf8.len(var_480_34)
				local var_480_37 = var_480_35 <= 0 and var_480_31 or var_480_31 * (var_480_36 / var_480_35)

				if var_480_37 > 0 and var_480_31 < var_480_37 then
					arg_477_1.talkMaxDuration = var_480_37

					if var_480_37 + var_480_30 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_37 + var_480_30
					end
				end

				arg_477_1.text_.text = var_480_34
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151108", "story_v_out_324151.awb") ~= 0 then
					local var_480_38 = manager.audio:GetVoiceLength("story_v_out_324151", "324151108", "story_v_out_324151.awb") / 1000

					if var_480_38 + var_480_30 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_38 + var_480_30
					end

					if var_480_33.prefab_name ~= "" and arg_477_1.actors_[var_480_33.prefab_name] ~= nil then
						local var_480_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_33.prefab_name].transform, "story_v_out_324151", "324151108", "story_v_out_324151.awb")

						arg_477_1:RecordAudio("324151108", var_480_39)
						arg_477_1:RecordAudio("324151108", var_480_39)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_324151", "324151108", "story_v_out_324151.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_324151", "324151108", "story_v_out_324151.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_40 = math.max(var_480_31, arg_477_1.talkMaxDuration)

			if var_480_30 <= arg_477_1.time_ and arg_477_1.time_ < var_480_30 + var_480_40 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_30) / var_480_40

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_30 + var_480_40 and arg_477_1.time_ < var_480_30 + var_480_40 + arg_480_0 then
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
			local var_484_0 = 0
			local var_484_1 = 0.525

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_2 = arg_481_1:FormatText(StoryNameCfg[410].name)

				arg_481_1.leftNameTxt_.text = var_484_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_3 = arg_481_1:GetWordFromCfg(324151109)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 21
				local var_484_6 = utf8.len(var_484_4)
				local var_484_7 = var_484_5 <= 0 and var_484_1 or var_484_1 * (var_484_6 / var_484_5)

				if var_484_7 > 0 and var_484_1 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151109", "story_v_out_324151.awb") ~= 0 then
					local var_484_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151109", "story_v_out_324151.awb") / 1000

					if var_484_8 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_8 + var_484_0
					end

					if var_484_3.prefab_name ~= "" and arg_481_1.actors_[var_484_3.prefab_name] ~= nil then
						local var_484_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_3.prefab_name].transform, "story_v_out_324151", "324151109", "story_v_out_324151.awb")

						arg_481_1:RecordAudio("324151109", var_484_9)
						arg_481_1:RecordAudio("324151109", var_484_9)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_324151", "324151109", "story_v_out_324151.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_324151", "324151109", "story_v_out_324151.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_10 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_10 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_10

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_10 and arg_481_1.time_ < var_484_0 + var_484_10 + arg_484_0 then
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
			local var_488_0 = arg_485_1.actors_["1074ui_story"].transform
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.var_.moveOldPos1074ui_story = var_488_0.localPosition
			end

			local var_488_2 = 0.001

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2
				local var_488_4 = Vector3.New(0, 100, 0)

				var_488_0.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1074ui_story, var_488_4, var_488_3)

				local var_488_5 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_5.x, var_488_5.y, var_488_5.z)

				local var_488_6 = var_488_0.localEulerAngles

				var_488_6.z = 0
				var_488_6.x = 0
				var_488_0.localEulerAngles = var_488_6
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 then
				var_488_0.localPosition = Vector3.New(0, 100, 0)

				local var_488_7 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_7.x, var_488_7.y, var_488_7.z)

				local var_488_8 = var_488_0.localEulerAngles

				var_488_8.z = 0
				var_488_8.x = 0
				var_488_0.localEulerAngles = var_488_8
			end

			local var_488_9 = arg_485_1.actors_["1072ui_story"].transform
			local var_488_10 = 0

			if var_488_10 < arg_485_1.time_ and arg_485_1.time_ <= var_488_10 + arg_488_0 then
				arg_485_1.var_.moveOldPos1072ui_story = var_488_9.localPosition
			end

			local var_488_11 = 0.001

			if var_488_10 <= arg_485_1.time_ and arg_485_1.time_ < var_488_10 + var_488_11 then
				local var_488_12 = (arg_485_1.time_ - var_488_10) / var_488_11
				local var_488_13 = Vector3.New(0.7, -0.71, -6)

				var_488_9.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1072ui_story, var_488_13, var_488_12)

				local var_488_14 = manager.ui.mainCamera.transform.position - var_488_9.position

				var_488_9.forward = Vector3.New(var_488_14.x, var_488_14.y, var_488_14.z)

				local var_488_15 = var_488_9.localEulerAngles

				var_488_15.z = 0
				var_488_15.x = 0
				var_488_9.localEulerAngles = var_488_15
			end

			if arg_485_1.time_ >= var_488_10 + var_488_11 and arg_485_1.time_ < var_488_10 + var_488_11 + arg_488_0 then
				var_488_9.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_488_16 = manager.ui.mainCamera.transform.position - var_488_9.position

				var_488_9.forward = Vector3.New(var_488_16.x, var_488_16.y, var_488_16.z)

				local var_488_17 = var_488_9.localEulerAngles

				var_488_17.z = 0
				var_488_17.x = 0
				var_488_9.localEulerAngles = var_488_17
			end

			local var_488_18 = arg_485_1.actors_["1072ui_story"]
			local var_488_19 = 0

			if var_488_19 < arg_485_1.time_ and arg_485_1.time_ <= var_488_19 + arg_488_0 and not isNil(var_488_18) and arg_485_1.var_.characterEffect1072ui_story == nil then
				arg_485_1.var_.characterEffect1072ui_story = var_488_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_20 = 0.200000002980232

			if var_488_19 <= arg_485_1.time_ and arg_485_1.time_ < var_488_19 + var_488_20 and not isNil(var_488_18) then
				local var_488_21 = (arg_485_1.time_ - var_488_19) / var_488_20

				if arg_485_1.var_.characterEffect1072ui_story and not isNil(var_488_18) then
					arg_485_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= var_488_19 + var_488_20 and arg_485_1.time_ < var_488_19 + var_488_20 + arg_488_0 and not isNil(var_488_18) and arg_485_1.var_.characterEffect1072ui_story then
				arg_485_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_488_22 = arg_485_1.actors_["1074ui_story"]
			local var_488_23 = 0

			if var_488_23 < arg_485_1.time_ and arg_485_1.time_ <= var_488_23 + arg_488_0 and not isNil(var_488_22) and arg_485_1.var_.characterEffect1074ui_story == nil then
				arg_485_1.var_.characterEffect1074ui_story = var_488_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_24 = 0.200000002980232

			if var_488_23 <= arg_485_1.time_ and arg_485_1.time_ < var_488_23 + var_488_24 and not isNil(var_488_22) then
				local var_488_25 = (arg_485_1.time_ - var_488_23) / var_488_24

				if arg_485_1.var_.characterEffect1074ui_story and not isNil(var_488_22) then
					local var_488_26 = Mathf.Lerp(0, 0.5, var_488_25)

					arg_485_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1074ui_story.fillRatio = var_488_26
				end
			end

			if arg_485_1.time_ >= var_488_23 + var_488_24 and arg_485_1.time_ < var_488_23 + var_488_24 + arg_488_0 and not isNil(var_488_22) and arg_485_1.var_.characterEffect1074ui_story then
				local var_488_27 = 0.5

				arg_485_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1074ui_story.fillRatio = var_488_27
			end

			local var_488_28 = 0

			if var_488_28 < arg_485_1.time_ and arg_485_1.time_ <= var_488_28 + arg_488_0 then
				arg_485_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			local var_488_29 = 0

			if var_488_29 < arg_485_1.time_ and arg_485_1.time_ <= var_488_29 + arg_488_0 then
				arg_485_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_488_30 = 0
			local var_488_31 = 0.6

			if var_488_30 < arg_485_1.time_ and arg_485_1.time_ <= var_488_30 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_32 = arg_485_1:FormatText(StoryNameCfg[379].name)

				arg_485_1.leftNameTxt_.text = var_488_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_33 = arg_485_1:GetWordFromCfg(324151110)
				local var_488_34 = arg_485_1:FormatText(var_488_33.content)

				arg_485_1.text_.text = var_488_34

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_35 = 24
				local var_488_36 = utf8.len(var_488_34)
				local var_488_37 = var_488_35 <= 0 and var_488_31 or var_488_31 * (var_488_36 / var_488_35)

				if var_488_37 > 0 and var_488_31 < var_488_37 then
					arg_485_1.talkMaxDuration = var_488_37

					if var_488_37 + var_488_30 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_37 + var_488_30
					end
				end

				arg_485_1.text_.text = var_488_34
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151110", "story_v_out_324151.awb") ~= 0 then
					local var_488_38 = manager.audio:GetVoiceLength("story_v_out_324151", "324151110", "story_v_out_324151.awb") / 1000

					if var_488_38 + var_488_30 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_38 + var_488_30
					end

					if var_488_33.prefab_name ~= "" and arg_485_1.actors_[var_488_33.prefab_name] ~= nil then
						local var_488_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_33.prefab_name].transform, "story_v_out_324151", "324151110", "story_v_out_324151.awb")

						arg_485_1:RecordAudio("324151110", var_488_39)
						arg_485_1:RecordAudio("324151110", var_488_39)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_324151", "324151110", "story_v_out_324151.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_324151", "324151110", "story_v_out_324151.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_40 = math.max(var_488_31, arg_485_1.talkMaxDuration)

			if var_488_30 <= arg_485_1.time_ and arg_485_1.time_ < var_488_30 + var_488_40 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_30) / var_488_40

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_30 + var_488_40 and arg_485_1.time_ < var_488_30 + var_488_40 + arg_488_0 then
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
			local var_492_0 = arg_489_1.actors_["1074ui_story"].transform
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.var_.moveOldPos1074ui_story = var_492_0.localPosition
			end

			local var_492_2 = 0.001

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2
				local var_492_4 = Vector3.New(0, 100, 0)

				var_492_0.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1074ui_story, var_492_4, var_492_3)

				local var_492_5 = manager.ui.mainCamera.transform.position - var_492_0.position

				var_492_0.forward = Vector3.New(var_492_5.x, var_492_5.y, var_492_5.z)

				local var_492_6 = var_492_0.localEulerAngles

				var_492_6.z = 0
				var_492_6.x = 0
				var_492_0.localEulerAngles = var_492_6
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 then
				var_492_0.localPosition = Vector3.New(0, 100, 0)

				local var_492_7 = manager.ui.mainCamera.transform.position - var_492_0.position

				var_492_0.forward = Vector3.New(var_492_7.x, var_492_7.y, var_492_7.z)

				local var_492_8 = var_492_0.localEulerAngles

				var_492_8.z = 0
				var_492_8.x = 0
				var_492_0.localEulerAngles = var_492_8
			end

			local var_492_9 = arg_489_1.actors_["1072ui_story"].transform
			local var_492_10 = 0

			if var_492_10 < arg_489_1.time_ and arg_489_1.time_ <= var_492_10 + arg_492_0 then
				arg_489_1.var_.moveOldPos1072ui_story = var_492_9.localPosition
			end

			local var_492_11 = 0.001

			if var_492_10 <= arg_489_1.time_ and arg_489_1.time_ < var_492_10 + var_492_11 then
				local var_492_12 = (arg_489_1.time_ - var_492_10) / var_492_11
				local var_492_13 = Vector3.New(0, 100, 0)

				var_492_9.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1072ui_story, var_492_13, var_492_12)

				local var_492_14 = manager.ui.mainCamera.transform.position - var_492_9.position

				var_492_9.forward = Vector3.New(var_492_14.x, var_492_14.y, var_492_14.z)

				local var_492_15 = var_492_9.localEulerAngles

				var_492_15.z = 0
				var_492_15.x = 0
				var_492_9.localEulerAngles = var_492_15
			end

			if arg_489_1.time_ >= var_492_10 + var_492_11 and arg_489_1.time_ < var_492_10 + var_492_11 + arg_492_0 then
				var_492_9.localPosition = Vector3.New(0, 100, 0)

				local var_492_16 = manager.ui.mainCamera.transform.position - var_492_9.position

				var_492_9.forward = Vector3.New(var_492_16.x, var_492_16.y, var_492_16.z)

				local var_492_17 = var_492_9.localEulerAngles

				var_492_17.z = 0
				var_492_17.x = 0
				var_492_9.localEulerAngles = var_492_17
			end

			local var_492_18 = arg_489_1.actors_["1072ui_story"]
			local var_492_19 = 0

			if var_492_19 < arg_489_1.time_ and arg_489_1.time_ <= var_492_19 + arg_492_0 and not isNil(var_492_18) and arg_489_1.var_.characterEffect1072ui_story == nil then
				arg_489_1.var_.characterEffect1072ui_story = var_492_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_20 = 0.200000002980232

			if var_492_19 <= arg_489_1.time_ and arg_489_1.time_ < var_492_19 + var_492_20 and not isNil(var_492_18) then
				local var_492_21 = (arg_489_1.time_ - var_492_19) / var_492_20

				if arg_489_1.var_.characterEffect1072ui_story and not isNil(var_492_18) then
					local var_492_22 = Mathf.Lerp(0, 0.5, var_492_21)

					arg_489_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1072ui_story.fillRatio = var_492_22
				end
			end

			if arg_489_1.time_ >= var_492_19 + var_492_20 and arg_489_1.time_ < var_492_19 + var_492_20 + arg_492_0 and not isNil(var_492_18) and arg_489_1.var_.characterEffect1072ui_story then
				local var_492_23 = 0.5

				arg_489_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1072ui_story.fillRatio = var_492_23
			end

			local var_492_24 = arg_489_1.actors_["10171ui_story"].transform
			local var_492_25 = 0

			if var_492_25 < arg_489_1.time_ and arg_489_1.time_ <= var_492_25 + arg_492_0 then
				arg_489_1.var_.moveOldPos10171ui_story = var_492_24.localPosition

				local var_492_26 = GameObjectTools.GetOrAddComponent(var_492_24.gameObject, typeof(DynamicBoneHelper))

				if var_492_26 then
					var_492_26:EnableDynamicBone(false)
				end
			end

			local var_492_27 = 0.001

			if var_492_25 <= arg_489_1.time_ and arg_489_1.time_ < var_492_25 + var_492_27 then
				local var_492_28 = (arg_489_1.time_ - var_492_25) / var_492_27
				local var_492_29 = Vector3.New(0, 100, 0)

				var_492_24.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10171ui_story, var_492_29, var_492_28)

				local var_492_30 = manager.ui.mainCamera.transform.position - var_492_24.position

				var_492_24.forward = Vector3.New(var_492_30.x, var_492_30.y, var_492_30.z)

				local var_492_31 = var_492_24.localEulerAngles

				var_492_31.z = 0
				var_492_31.x = 0
				var_492_24.localEulerAngles = var_492_31
			end

			if arg_489_1.time_ >= var_492_25 + var_492_27 and arg_489_1.time_ < var_492_25 + var_492_27 + arg_492_0 then
				var_492_24.localPosition = Vector3.New(0, 100, 0)

				local var_492_32 = manager.ui.mainCamera.transform.position - var_492_24.position

				var_492_24.forward = Vector3.New(var_492_32.x, var_492_32.y, var_492_32.z)

				local var_492_33 = var_492_24.localEulerAngles

				var_492_33.z = 0
				var_492_33.x = 0
				var_492_24.localEulerAngles = var_492_33

				local var_492_34 = GameObjectTools.GetOrAddComponent(var_492_24.gameObject, typeof(DynamicBoneHelper))

				if var_492_34 then
					var_492_34:EnableDynamicBone(true)
				end
			end

			local var_492_35 = 0
			local var_492_36 = 1.675

			if var_492_35 < arg_489_1.time_ and arg_489_1.time_ <= var_492_35 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_37 = arg_489_1:GetWordFromCfg(324151111)
				local var_492_38 = arg_489_1:FormatText(var_492_37.content)

				arg_489_1.text_.text = var_492_38

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_39 = 67
				local var_492_40 = utf8.len(var_492_38)
				local var_492_41 = var_492_39 <= 0 and var_492_36 or var_492_36 * (var_492_40 / var_492_39)

				if var_492_41 > 0 and var_492_36 < var_492_41 then
					arg_489_1.talkMaxDuration = var_492_41

					if var_492_41 + var_492_35 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_41 + var_492_35
					end
				end

				arg_489_1.text_.text = var_492_38
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_42 = math.max(var_492_36, arg_489_1.talkMaxDuration)

			if var_492_35 <= arg_489_1.time_ and arg_489_1.time_ < var_492_35 + var_492_42 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_35) / var_492_42

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_35 + var_492_42 and arg_489_1.time_ < var_492_35 + var_492_42 + arg_492_0 then
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
			local var_496_0 = arg_493_1.actors_["10171ui_story"].transform
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 then
				arg_493_1.var_.moveOldPos10171ui_story = var_496_0.localPosition

				local var_496_2 = GameObjectTools.GetOrAddComponent(var_496_0.gameObject, typeof(DynamicBoneHelper))

				if var_496_2 then
					var_496_2:EnableDynamicBone(false)
				end
			end

			local var_496_3 = 0.001

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_3 then
				local var_496_4 = (arg_493_1.time_ - var_496_1) / var_496_3
				local var_496_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_496_0.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos10171ui_story, var_496_5, var_496_4)

				local var_496_6 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_6.x, var_496_6.y, var_496_6.z)

				local var_496_7 = var_496_0.localEulerAngles

				var_496_7.z = 0
				var_496_7.x = 0
				var_496_0.localEulerAngles = var_496_7
			end

			if arg_493_1.time_ >= var_496_1 + var_496_3 and arg_493_1.time_ < var_496_1 + var_496_3 + arg_496_0 then
				var_496_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_496_8 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_8.x, var_496_8.y, var_496_8.z)

				local var_496_9 = var_496_0.localEulerAngles

				var_496_9.z = 0
				var_496_9.x = 0
				var_496_0.localEulerAngles = var_496_9

				local var_496_10 = GameObjectTools.GetOrAddComponent(var_496_0.gameObject, typeof(DynamicBoneHelper))

				if var_496_10 then
					var_496_10:EnableDynamicBone(true)
				end
			end

			local var_496_11 = arg_493_1.actors_["10171ui_story"]
			local var_496_12 = 0

			if var_496_12 < arg_493_1.time_ and arg_493_1.time_ <= var_496_12 + arg_496_0 and not isNil(var_496_11) and arg_493_1.var_.characterEffect10171ui_story == nil then
				arg_493_1.var_.characterEffect10171ui_story = var_496_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_13 = 0.200000002980232

			if var_496_12 <= arg_493_1.time_ and arg_493_1.time_ < var_496_12 + var_496_13 and not isNil(var_496_11) then
				local var_496_14 = (arg_493_1.time_ - var_496_12) / var_496_13

				if arg_493_1.var_.characterEffect10171ui_story and not isNil(var_496_11) then
					arg_493_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= var_496_12 + var_496_13 and arg_493_1.time_ < var_496_12 + var_496_13 + arg_496_0 and not isNil(var_496_11) and arg_493_1.var_.characterEffect10171ui_story then
				arg_493_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_496_15 = 0

			if var_496_15 < arg_493_1.time_ and arg_493_1.time_ <= var_496_15 + arg_496_0 then
				arg_493_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			local var_496_16 = 0

			if var_496_16 < arg_493_1.time_ and arg_493_1.time_ <= var_496_16 + arg_496_0 then
				arg_493_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_496_17 = 0
			local var_496_18 = 0.525

			if var_496_17 < arg_493_1.time_ and arg_493_1.time_ <= var_496_17 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_19 = arg_493_1:FormatText(StoryNameCfg[1451].name)

				arg_493_1.leftNameTxt_.text = var_496_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_20 = arg_493_1:GetWordFromCfg(324151112)
				local var_496_21 = arg_493_1:FormatText(var_496_20.content)

				arg_493_1.text_.text = var_496_21

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_22 = 21
				local var_496_23 = utf8.len(var_496_21)
				local var_496_24 = var_496_22 <= 0 and var_496_18 or var_496_18 * (var_496_23 / var_496_22)

				if var_496_24 > 0 and var_496_18 < var_496_24 then
					arg_493_1.talkMaxDuration = var_496_24

					if var_496_24 + var_496_17 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_24 + var_496_17
					end
				end

				arg_493_1.text_.text = var_496_21
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151112", "story_v_out_324151.awb") ~= 0 then
					local var_496_25 = manager.audio:GetVoiceLength("story_v_out_324151", "324151112", "story_v_out_324151.awb") / 1000

					if var_496_25 + var_496_17 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_25 + var_496_17
					end

					if var_496_20.prefab_name ~= "" and arg_493_1.actors_[var_496_20.prefab_name] ~= nil then
						local var_496_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_20.prefab_name].transform, "story_v_out_324151", "324151112", "story_v_out_324151.awb")

						arg_493_1:RecordAudio("324151112", var_496_26)
						arg_493_1:RecordAudio("324151112", var_496_26)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_324151", "324151112", "story_v_out_324151.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_324151", "324151112", "story_v_out_324151.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_27 = math.max(var_496_18, arg_493_1.talkMaxDuration)

			if var_496_17 <= arg_493_1.time_ and arg_493_1.time_ < var_496_17 + var_496_27 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_17) / var_496_27

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_17 + var_496_27 and arg_493_1.time_ < var_496_17 + var_496_27 + arg_496_0 then
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
			local var_500_0 = arg_497_1.actors_["1060ui_story"].transform
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.var_.moveOldPos1060ui_story = var_500_0.localPosition
			end

			local var_500_2 = 0.001

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2
				local var_500_4 = Vector3.New(0.7, -1.14, -6.33)

				var_500_0.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1060ui_story, var_500_4, var_500_3)

				local var_500_5 = manager.ui.mainCamera.transform.position - var_500_0.position

				var_500_0.forward = Vector3.New(var_500_5.x, var_500_5.y, var_500_5.z)

				local var_500_6 = var_500_0.localEulerAngles

				var_500_6.z = 0
				var_500_6.x = 0
				var_500_0.localEulerAngles = var_500_6
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 then
				var_500_0.localPosition = Vector3.New(0.7, -1.14, -6.33)

				local var_500_7 = manager.ui.mainCamera.transform.position - var_500_0.position

				var_500_0.forward = Vector3.New(var_500_7.x, var_500_7.y, var_500_7.z)

				local var_500_8 = var_500_0.localEulerAngles

				var_500_8.z = 0
				var_500_8.x = 0
				var_500_0.localEulerAngles = var_500_8
			end

			local var_500_9 = arg_497_1.actors_["1060ui_story"]
			local var_500_10 = 0

			if var_500_10 < arg_497_1.time_ and arg_497_1.time_ <= var_500_10 + arg_500_0 and not isNil(var_500_9) and arg_497_1.var_.characterEffect1060ui_story == nil then
				arg_497_1.var_.characterEffect1060ui_story = var_500_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_11 = 0.200000002980232

			if var_500_10 <= arg_497_1.time_ and arg_497_1.time_ < var_500_10 + var_500_11 and not isNil(var_500_9) then
				local var_500_12 = (arg_497_1.time_ - var_500_10) / var_500_11

				if arg_497_1.var_.characterEffect1060ui_story and not isNil(var_500_9) then
					arg_497_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= var_500_10 + var_500_11 and arg_497_1.time_ < var_500_10 + var_500_11 + arg_500_0 and not isNil(var_500_9) and arg_497_1.var_.characterEffect1060ui_story then
				arg_497_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_500_13 = arg_497_1.actors_["10171ui_story"]
			local var_500_14 = 0

			if var_500_14 < arg_497_1.time_ and arg_497_1.time_ <= var_500_14 + arg_500_0 and not isNil(var_500_13) and arg_497_1.var_.characterEffect10171ui_story == nil then
				arg_497_1.var_.characterEffect10171ui_story = var_500_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_15 = 0.200000002980232

			if var_500_14 <= arg_497_1.time_ and arg_497_1.time_ < var_500_14 + var_500_15 and not isNil(var_500_13) then
				local var_500_16 = (arg_497_1.time_ - var_500_14) / var_500_15

				if arg_497_1.var_.characterEffect10171ui_story and not isNil(var_500_13) then
					local var_500_17 = Mathf.Lerp(0, 0.5, var_500_16)

					arg_497_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_497_1.var_.characterEffect10171ui_story.fillRatio = var_500_17
				end
			end

			if arg_497_1.time_ >= var_500_14 + var_500_15 and arg_497_1.time_ < var_500_14 + var_500_15 + arg_500_0 and not isNil(var_500_13) and arg_497_1.var_.characterEffect10171ui_story then
				local var_500_18 = 0.5

				arg_497_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_497_1.var_.characterEffect10171ui_story.fillRatio = var_500_18
			end

			local var_500_19 = 0

			if var_500_19 < arg_497_1.time_ and arg_497_1.time_ <= var_500_19 + arg_500_0 then
				arg_497_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action5_1")
			end

			local var_500_20 = 0

			if var_500_20 < arg_497_1.time_ and arg_497_1.time_ <= var_500_20 + arg_500_0 then
				arg_497_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_500_21 = 0
			local var_500_22 = 0.9

			if var_500_21 < arg_497_1.time_ and arg_497_1.time_ <= var_500_21 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_23 = arg_497_1:FormatText(StoryNameCfg[584].name)

				arg_497_1.leftNameTxt_.text = var_500_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_24 = arg_497_1:GetWordFromCfg(324151113)
				local var_500_25 = arg_497_1:FormatText(var_500_24.content)

				arg_497_1.text_.text = var_500_25

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_26 = 36
				local var_500_27 = utf8.len(var_500_25)
				local var_500_28 = var_500_26 <= 0 and var_500_22 or var_500_22 * (var_500_27 / var_500_26)

				if var_500_28 > 0 and var_500_22 < var_500_28 then
					arg_497_1.talkMaxDuration = var_500_28

					if var_500_28 + var_500_21 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_28 + var_500_21
					end
				end

				arg_497_1.text_.text = var_500_25
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151113", "story_v_out_324151.awb") ~= 0 then
					local var_500_29 = manager.audio:GetVoiceLength("story_v_out_324151", "324151113", "story_v_out_324151.awb") / 1000

					if var_500_29 + var_500_21 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_29 + var_500_21
					end

					if var_500_24.prefab_name ~= "" and arg_497_1.actors_[var_500_24.prefab_name] ~= nil then
						local var_500_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_24.prefab_name].transform, "story_v_out_324151", "324151113", "story_v_out_324151.awb")

						arg_497_1:RecordAudio("324151113", var_500_30)
						arg_497_1:RecordAudio("324151113", var_500_30)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_324151", "324151113", "story_v_out_324151.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_324151", "324151113", "story_v_out_324151.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_31 = math.max(var_500_22, arg_497_1.talkMaxDuration)

			if var_500_21 <= arg_497_1.time_ and arg_497_1.time_ < var_500_21 + var_500_31 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_21) / var_500_31

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_21 + var_500_31 and arg_497_1.time_ < var_500_21 + var_500_31 + arg_500_0 then
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
			local var_504_0 = arg_501_1.actors_["10171ui_story"]
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect10171ui_story == nil then
				arg_501_1.var_.characterEffect10171ui_story = var_504_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.200000002980232

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 and not isNil(var_504_0) then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2

				if arg_501_1.var_.characterEffect10171ui_story and not isNil(var_504_0) then
					arg_501_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect10171ui_story then
				arg_501_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_504_4 = arg_501_1.actors_["1060ui_story"]
			local var_504_5 = 0

			if var_504_5 < arg_501_1.time_ and arg_501_1.time_ <= var_504_5 + arg_504_0 and not isNil(var_504_4) and arg_501_1.var_.characterEffect1060ui_story == nil then
				arg_501_1.var_.characterEffect1060ui_story = var_504_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_6 = 0.200000002980232

			if var_504_5 <= arg_501_1.time_ and arg_501_1.time_ < var_504_5 + var_504_6 and not isNil(var_504_4) then
				local var_504_7 = (arg_501_1.time_ - var_504_5) / var_504_6

				if arg_501_1.var_.characterEffect1060ui_story and not isNil(var_504_4) then
					local var_504_8 = Mathf.Lerp(0, 0.5, var_504_7)

					arg_501_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1060ui_story.fillRatio = var_504_8
				end
			end

			if arg_501_1.time_ >= var_504_5 + var_504_6 and arg_501_1.time_ < var_504_5 + var_504_6 + arg_504_0 and not isNil(var_504_4) and arg_501_1.var_.characterEffect1060ui_story then
				local var_504_9 = 0.5

				arg_501_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1060ui_story.fillRatio = var_504_9
			end

			local var_504_10 = 0

			if var_504_10 < arg_501_1.time_ and arg_501_1.time_ <= var_504_10 + arg_504_0 then
				arg_501_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			local var_504_11 = 0
			local var_504_12 = 0.975

			if var_504_11 < arg_501_1.time_ and arg_501_1.time_ <= var_504_11 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_13 = arg_501_1:FormatText(StoryNameCfg[1451].name)

				arg_501_1.leftNameTxt_.text = var_504_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_14 = arg_501_1:GetWordFromCfg(324151114)
				local var_504_15 = arg_501_1:FormatText(var_504_14.content)

				arg_501_1.text_.text = var_504_15

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_16 = 39
				local var_504_17 = utf8.len(var_504_15)
				local var_504_18 = var_504_16 <= 0 and var_504_12 or var_504_12 * (var_504_17 / var_504_16)

				if var_504_18 > 0 and var_504_12 < var_504_18 then
					arg_501_1.talkMaxDuration = var_504_18

					if var_504_18 + var_504_11 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_18 + var_504_11
					end
				end

				arg_501_1.text_.text = var_504_15
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151114", "story_v_out_324151.awb") ~= 0 then
					local var_504_19 = manager.audio:GetVoiceLength("story_v_out_324151", "324151114", "story_v_out_324151.awb") / 1000

					if var_504_19 + var_504_11 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_19 + var_504_11
					end

					if var_504_14.prefab_name ~= "" and arg_501_1.actors_[var_504_14.prefab_name] ~= nil then
						local var_504_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_14.prefab_name].transform, "story_v_out_324151", "324151114", "story_v_out_324151.awb")

						arg_501_1:RecordAudio("324151114", var_504_20)
						arg_501_1:RecordAudio("324151114", var_504_20)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_324151", "324151114", "story_v_out_324151.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_324151", "324151114", "story_v_out_324151.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_21 = math.max(var_504_12, arg_501_1.talkMaxDuration)

			if var_504_11 <= arg_501_1.time_ and arg_501_1.time_ < var_504_11 + var_504_21 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_11) / var_504_21

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_11 + var_504_21 and arg_501_1.time_ < var_504_11 + var_504_21 + arg_504_0 then
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
			local var_508_0 = arg_505_1.actors_["1072ui_story"].transform
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 then
				arg_505_1.var_.moveOldPos1072ui_story = var_508_0.localPosition
			end

			local var_508_2 = 0.001

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2
				local var_508_4 = Vector3.New(0.7, -0.71, -6)

				var_508_0.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1072ui_story, var_508_4, var_508_3)

				local var_508_5 = manager.ui.mainCamera.transform.position - var_508_0.position

				var_508_0.forward = Vector3.New(var_508_5.x, var_508_5.y, var_508_5.z)

				local var_508_6 = var_508_0.localEulerAngles

				var_508_6.z = 0
				var_508_6.x = 0
				var_508_0.localEulerAngles = var_508_6
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 then
				var_508_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_508_7 = manager.ui.mainCamera.transform.position - var_508_0.position

				var_508_0.forward = Vector3.New(var_508_7.x, var_508_7.y, var_508_7.z)

				local var_508_8 = var_508_0.localEulerAngles

				var_508_8.z = 0
				var_508_8.x = 0
				var_508_0.localEulerAngles = var_508_8
			end

			local var_508_9 = arg_505_1.actors_["1060ui_story"].transform
			local var_508_10 = 0

			if var_508_10 < arg_505_1.time_ and arg_505_1.time_ <= var_508_10 + arg_508_0 then
				arg_505_1.var_.moveOldPos1060ui_story = var_508_9.localPosition
			end

			local var_508_11 = 0.001

			if var_508_10 <= arg_505_1.time_ and arg_505_1.time_ < var_508_10 + var_508_11 then
				local var_508_12 = (arg_505_1.time_ - var_508_10) / var_508_11
				local var_508_13 = Vector3.New(0, 100, 0)

				var_508_9.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1060ui_story, var_508_13, var_508_12)

				local var_508_14 = manager.ui.mainCamera.transform.position - var_508_9.position

				var_508_9.forward = Vector3.New(var_508_14.x, var_508_14.y, var_508_14.z)

				local var_508_15 = var_508_9.localEulerAngles

				var_508_15.z = 0
				var_508_15.x = 0
				var_508_9.localEulerAngles = var_508_15
			end

			if arg_505_1.time_ >= var_508_10 + var_508_11 and arg_505_1.time_ < var_508_10 + var_508_11 + arg_508_0 then
				var_508_9.localPosition = Vector3.New(0, 100, 0)

				local var_508_16 = manager.ui.mainCamera.transform.position - var_508_9.position

				var_508_9.forward = Vector3.New(var_508_16.x, var_508_16.y, var_508_16.z)

				local var_508_17 = var_508_9.localEulerAngles

				var_508_17.z = 0
				var_508_17.x = 0
				var_508_9.localEulerAngles = var_508_17
			end

			local var_508_18 = arg_505_1.actors_["1072ui_story"]
			local var_508_19 = 0

			if var_508_19 < arg_505_1.time_ and arg_505_1.time_ <= var_508_19 + arg_508_0 and not isNil(var_508_18) and arg_505_1.var_.characterEffect1072ui_story == nil then
				arg_505_1.var_.characterEffect1072ui_story = var_508_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_20 = 0.200000002980232

			if var_508_19 <= arg_505_1.time_ and arg_505_1.time_ < var_508_19 + var_508_20 and not isNil(var_508_18) then
				local var_508_21 = (arg_505_1.time_ - var_508_19) / var_508_20

				if arg_505_1.var_.characterEffect1072ui_story and not isNil(var_508_18) then
					arg_505_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= var_508_19 + var_508_20 and arg_505_1.time_ < var_508_19 + var_508_20 + arg_508_0 and not isNil(var_508_18) and arg_505_1.var_.characterEffect1072ui_story then
				arg_505_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_508_22 = arg_505_1.actors_["10171ui_story"]
			local var_508_23 = 0

			if var_508_23 < arg_505_1.time_ and arg_505_1.time_ <= var_508_23 + arg_508_0 and not isNil(var_508_22) and arg_505_1.var_.characterEffect10171ui_story == nil then
				arg_505_1.var_.characterEffect10171ui_story = var_508_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_24 = 0.200000002980232

			if var_508_23 <= arg_505_1.time_ and arg_505_1.time_ < var_508_23 + var_508_24 and not isNil(var_508_22) then
				local var_508_25 = (arg_505_1.time_ - var_508_23) / var_508_24

				if arg_505_1.var_.characterEffect10171ui_story and not isNil(var_508_22) then
					local var_508_26 = Mathf.Lerp(0, 0.5, var_508_25)

					arg_505_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_505_1.var_.characterEffect10171ui_story.fillRatio = var_508_26
				end
			end

			if arg_505_1.time_ >= var_508_23 + var_508_24 and arg_505_1.time_ < var_508_23 + var_508_24 + arg_508_0 and not isNil(var_508_22) and arg_505_1.var_.characterEffect10171ui_story then
				local var_508_27 = 0.5

				arg_505_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_505_1.var_.characterEffect10171ui_story.fillRatio = var_508_27
			end

			local var_508_28 = 0

			if var_508_28 < arg_505_1.time_ and arg_505_1.time_ <= var_508_28 + arg_508_0 then
				arg_505_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			local var_508_29 = 0

			if var_508_29 < arg_505_1.time_ and arg_505_1.time_ <= var_508_29 + arg_508_0 then
				arg_505_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_508_30 = 0
			local var_508_31 = 0.725

			if var_508_30 < arg_505_1.time_ and arg_505_1.time_ <= var_508_30 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_32 = arg_505_1:FormatText(StoryNameCfg[379].name)

				arg_505_1.leftNameTxt_.text = var_508_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_33 = arg_505_1:GetWordFromCfg(324151115)
				local var_508_34 = arg_505_1:FormatText(var_508_33.content)

				arg_505_1.text_.text = var_508_34

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_35 = 29
				local var_508_36 = utf8.len(var_508_34)
				local var_508_37 = var_508_35 <= 0 and var_508_31 or var_508_31 * (var_508_36 / var_508_35)

				if var_508_37 > 0 and var_508_31 < var_508_37 then
					arg_505_1.talkMaxDuration = var_508_37

					if var_508_37 + var_508_30 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_37 + var_508_30
					end
				end

				arg_505_1.text_.text = var_508_34
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151115", "story_v_out_324151.awb") ~= 0 then
					local var_508_38 = manager.audio:GetVoiceLength("story_v_out_324151", "324151115", "story_v_out_324151.awb") / 1000

					if var_508_38 + var_508_30 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_38 + var_508_30
					end

					if var_508_33.prefab_name ~= "" and arg_505_1.actors_[var_508_33.prefab_name] ~= nil then
						local var_508_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_33.prefab_name].transform, "story_v_out_324151", "324151115", "story_v_out_324151.awb")

						arg_505_1:RecordAudio("324151115", var_508_39)
						arg_505_1:RecordAudio("324151115", var_508_39)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_324151", "324151115", "story_v_out_324151.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_324151", "324151115", "story_v_out_324151.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_40 = math.max(var_508_31, arg_505_1.talkMaxDuration)

			if var_508_30 <= arg_505_1.time_ and arg_505_1.time_ < var_508_30 + var_508_40 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_30) / var_508_40

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_30 + var_508_40 and arg_505_1.time_ < var_508_30 + var_508_40 + arg_508_0 then
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
			local var_512_0 = 0
			local var_512_1 = 0.575

			if var_512_0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_2 = arg_509_1:FormatText(StoryNameCfg[379].name)

				arg_509_1.leftNameTxt_.text = var_512_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_3 = arg_509_1:GetWordFromCfg(324151116)
				local var_512_4 = arg_509_1:FormatText(var_512_3.content)

				arg_509_1.text_.text = var_512_4

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 23
				local var_512_6 = utf8.len(var_512_4)
				local var_512_7 = var_512_5 <= 0 and var_512_1 or var_512_1 * (var_512_6 / var_512_5)

				if var_512_7 > 0 and var_512_1 < var_512_7 then
					arg_509_1.talkMaxDuration = var_512_7

					if var_512_7 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_7 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_4
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151116", "story_v_out_324151.awb") ~= 0 then
					local var_512_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151116", "story_v_out_324151.awb") / 1000

					if var_512_8 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_8 + var_512_0
					end

					if var_512_3.prefab_name ~= "" and arg_509_1.actors_[var_512_3.prefab_name] ~= nil then
						local var_512_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_3.prefab_name].transform, "story_v_out_324151", "324151116", "story_v_out_324151.awb")

						arg_509_1:RecordAudio("324151116", var_512_9)
						arg_509_1:RecordAudio("324151116", var_512_9)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_324151", "324151116", "story_v_out_324151.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_324151", "324151116", "story_v_out_324151.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_10 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_10 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_10

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_10 and arg_509_1.time_ < var_512_0 + var_512_10 + arg_512_0 then
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
			local var_516_0 = arg_513_1.actors_["10171ui_story"]
			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect10171ui_story == nil then
				arg_513_1.var_.characterEffect10171ui_story = var_516_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_2 = 0.200000002980232

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_2 and not isNil(var_516_0) then
				local var_516_3 = (arg_513_1.time_ - var_516_1) / var_516_2

				if arg_513_1.var_.characterEffect10171ui_story and not isNil(var_516_0) then
					arg_513_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= var_516_1 + var_516_2 and arg_513_1.time_ < var_516_1 + var_516_2 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect10171ui_story then
				arg_513_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_516_4 = arg_513_1.actors_["1072ui_story"]
			local var_516_5 = 0

			if var_516_5 < arg_513_1.time_ and arg_513_1.time_ <= var_516_5 + arg_516_0 and not isNil(var_516_4) and arg_513_1.var_.characterEffect1072ui_story == nil then
				arg_513_1.var_.characterEffect1072ui_story = var_516_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_6 = 0.200000002980232

			if var_516_5 <= arg_513_1.time_ and arg_513_1.time_ < var_516_5 + var_516_6 and not isNil(var_516_4) then
				local var_516_7 = (arg_513_1.time_ - var_516_5) / var_516_6

				if arg_513_1.var_.characterEffect1072ui_story and not isNil(var_516_4) then
					local var_516_8 = Mathf.Lerp(0, 0.5, var_516_7)

					arg_513_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1072ui_story.fillRatio = var_516_8
				end
			end

			if arg_513_1.time_ >= var_516_5 + var_516_6 and arg_513_1.time_ < var_516_5 + var_516_6 + arg_516_0 and not isNil(var_516_4) and arg_513_1.var_.characterEffect1072ui_story then
				local var_516_9 = 0.5

				arg_513_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1072ui_story.fillRatio = var_516_9
			end

			local var_516_10 = 0
			local var_516_11 = 0.1

			if var_516_10 < arg_513_1.time_ and arg_513_1.time_ <= var_516_10 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_12 = arg_513_1:FormatText(StoryNameCfg[1451].name)

				arg_513_1.leftNameTxt_.text = var_516_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_13 = arg_513_1:GetWordFromCfg(324151117)
				local var_516_14 = arg_513_1:FormatText(var_516_13.content)

				arg_513_1.text_.text = var_516_14

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_15 = 4
				local var_516_16 = utf8.len(var_516_14)
				local var_516_17 = var_516_15 <= 0 and var_516_11 or var_516_11 * (var_516_16 / var_516_15)

				if var_516_17 > 0 and var_516_11 < var_516_17 then
					arg_513_1.talkMaxDuration = var_516_17

					if var_516_17 + var_516_10 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_17 + var_516_10
					end
				end

				arg_513_1.text_.text = var_516_14
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151117", "story_v_out_324151.awb") ~= 0 then
					local var_516_18 = manager.audio:GetVoiceLength("story_v_out_324151", "324151117", "story_v_out_324151.awb") / 1000

					if var_516_18 + var_516_10 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_18 + var_516_10
					end

					if var_516_13.prefab_name ~= "" and arg_513_1.actors_[var_516_13.prefab_name] ~= nil then
						local var_516_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_13.prefab_name].transform, "story_v_out_324151", "324151117", "story_v_out_324151.awb")

						arg_513_1:RecordAudio("324151117", var_516_19)
						arg_513_1:RecordAudio("324151117", var_516_19)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_324151", "324151117", "story_v_out_324151.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_324151", "324151117", "story_v_out_324151.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_20 = math.max(var_516_11, arg_513_1.talkMaxDuration)

			if var_516_10 <= arg_513_1.time_ and arg_513_1.time_ < var_516_10 + var_516_20 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_10) / var_516_20

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_10 + var_516_20 and arg_513_1.time_ < var_516_10 + var_516_20 + arg_516_0 then
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
			local var_520_0 = arg_517_1.actors_["1072ui_story"]
			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.characterEffect1072ui_story == nil then
				arg_517_1.var_.characterEffect1072ui_story = var_520_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_2 = 0.200000002980232

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_2 and not isNil(var_520_0) then
				local var_520_3 = (arg_517_1.time_ - var_520_1) / var_520_2

				if arg_517_1.var_.characterEffect1072ui_story and not isNil(var_520_0) then
					arg_517_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= var_520_1 + var_520_2 and arg_517_1.time_ < var_520_1 + var_520_2 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.characterEffect1072ui_story then
				arg_517_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_520_4 = arg_517_1.actors_["10171ui_story"]
			local var_520_5 = 0

			if var_520_5 < arg_517_1.time_ and arg_517_1.time_ <= var_520_5 + arg_520_0 and not isNil(var_520_4) and arg_517_1.var_.characterEffect10171ui_story == nil then
				arg_517_1.var_.characterEffect10171ui_story = var_520_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_6 = 0.200000002980232

			if var_520_5 <= arg_517_1.time_ and arg_517_1.time_ < var_520_5 + var_520_6 and not isNil(var_520_4) then
				local var_520_7 = (arg_517_1.time_ - var_520_5) / var_520_6

				if arg_517_1.var_.characterEffect10171ui_story and not isNil(var_520_4) then
					local var_520_8 = Mathf.Lerp(0, 0.5, var_520_7)

					arg_517_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_517_1.var_.characterEffect10171ui_story.fillRatio = var_520_8
				end
			end

			if arg_517_1.time_ >= var_520_5 + var_520_6 and arg_517_1.time_ < var_520_5 + var_520_6 + arg_520_0 and not isNil(var_520_4) and arg_517_1.var_.characterEffect10171ui_story then
				local var_520_9 = 0.5

				arg_517_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_517_1.var_.characterEffect10171ui_story.fillRatio = var_520_9
			end

			local var_520_10 = 0

			if var_520_10 < arg_517_1.time_ and arg_517_1.time_ <= var_520_10 + arg_520_0 then
				arg_517_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			local var_520_11 = 0

			if var_520_11 < arg_517_1.time_ and arg_517_1.time_ <= var_520_11 + arg_520_0 then
				arg_517_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_520_12 = 0
			local var_520_13 = 1.1

			if var_520_12 < arg_517_1.time_ and arg_517_1.time_ <= var_520_12 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_14 = arg_517_1:FormatText(StoryNameCfg[379].name)

				arg_517_1.leftNameTxt_.text = var_520_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_15 = arg_517_1:GetWordFromCfg(324151118)
				local var_520_16 = arg_517_1:FormatText(var_520_15.content)

				arg_517_1.text_.text = var_520_16

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_17 = 44
				local var_520_18 = utf8.len(var_520_16)
				local var_520_19 = var_520_17 <= 0 and var_520_13 or var_520_13 * (var_520_18 / var_520_17)

				if var_520_19 > 0 and var_520_13 < var_520_19 then
					arg_517_1.talkMaxDuration = var_520_19

					if var_520_19 + var_520_12 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_19 + var_520_12
					end
				end

				arg_517_1.text_.text = var_520_16
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151118", "story_v_out_324151.awb") ~= 0 then
					local var_520_20 = manager.audio:GetVoiceLength("story_v_out_324151", "324151118", "story_v_out_324151.awb") / 1000

					if var_520_20 + var_520_12 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_20 + var_520_12
					end

					if var_520_15.prefab_name ~= "" and arg_517_1.actors_[var_520_15.prefab_name] ~= nil then
						local var_520_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_15.prefab_name].transform, "story_v_out_324151", "324151118", "story_v_out_324151.awb")

						arg_517_1:RecordAudio("324151118", var_520_21)
						arg_517_1:RecordAudio("324151118", var_520_21)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_324151", "324151118", "story_v_out_324151.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_324151", "324151118", "story_v_out_324151.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_22 = math.max(var_520_13, arg_517_1.talkMaxDuration)

			if var_520_12 <= arg_517_1.time_ and arg_517_1.time_ < var_520_12 + var_520_22 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_12) / var_520_22

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_12 + var_520_22 and arg_517_1.time_ < var_520_12 + var_520_22 + arg_520_0 then
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
			local var_524_0 = arg_521_1.actors_["10171ui_story"]
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect10171ui_story == nil then
				arg_521_1.var_.characterEffect10171ui_story = var_524_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.200000002980232

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 and not isNil(var_524_0) then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2

				if arg_521_1.var_.characterEffect10171ui_story and not isNil(var_524_0) then
					arg_521_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect10171ui_story then
				arg_521_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_524_4 = arg_521_1.actors_["1072ui_story"]
			local var_524_5 = 0

			if var_524_5 < arg_521_1.time_ and arg_521_1.time_ <= var_524_5 + arg_524_0 and not isNil(var_524_4) and arg_521_1.var_.characterEffect1072ui_story == nil then
				arg_521_1.var_.characterEffect1072ui_story = var_524_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_6 = 0.200000002980232

			if var_524_5 <= arg_521_1.time_ and arg_521_1.time_ < var_524_5 + var_524_6 and not isNil(var_524_4) then
				local var_524_7 = (arg_521_1.time_ - var_524_5) / var_524_6

				if arg_521_1.var_.characterEffect1072ui_story and not isNil(var_524_4) then
					local var_524_8 = Mathf.Lerp(0, 0.5, var_524_7)

					arg_521_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1072ui_story.fillRatio = var_524_8
				end
			end

			if arg_521_1.time_ >= var_524_5 + var_524_6 and arg_521_1.time_ < var_524_5 + var_524_6 + arg_524_0 and not isNil(var_524_4) and arg_521_1.var_.characterEffect1072ui_story then
				local var_524_9 = 0.5

				arg_521_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1072ui_story.fillRatio = var_524_9
			end

			local var_524_10 = 0

			if var_524_10 < arg_521_1.time_ and arg_521_1.time_ <= var_524_10 + arg_524_0 then
				arg_521_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_1")
			end

			local var_524_11 = 0

			if var_524_11 < arg_521_1.time_ and arg_521_1.time_ <= var_524_11 + arg_524_0 then
				arg_521_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_524_12 = 0
			local var_524_13 = 0.15

			if var_524_12 < arg_521_1.time_ and arg_521_1.time_ <= var_524_12 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_14 = arg_521_1:FormatText(StoryNameCfg[1451].name)

				arg_521_1.leftNameTxt_.text = var_524_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_15 = arg_521_1:GetWordFromCfg(324151119)
				local var_524_16 = arg_521_1:FormatText(var_524_15.content)

				arg_521_1.text_.text = var_524_16

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_17 = 6
				local var_524_18 = utf8.len(var_524_16)
				local var_524_19 = var_524_17 <= 0 and var_524_13 or var_524_13 * (var_524_18 / var_524_17)

				if var_524_19 > 0 and var_524_13 < var_524_19 then
					arg_521_1.talkMaxDuration = var_524_19

					if var_524_19 + var_524_12 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_19 + var_524_12
					end
				end

				arg_521_1.text_.text = var_524_16
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151119", "story_v_out_324151.awb") ~= 0 then
					local var_524_20 = manager.audio:GetVoiceLength("story_v_out_324151", "324151119", "story_v_out_324151.awb") / 1000

					if var_524_20 + var_524_12 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_20 + var_524_12
					end

					if var_524_15.prefab_name ~= "" and arg_521_1.actors_[var_524_15.prefab_name] ~= nil then
						local var_524_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_15.prefab_name].transform, "story_v_out_324151", "324151119", "story_v_out_324151.awb")

						arg_521_1:RecordAudio("324151119", var_524_21)
						arg_521_1:RecordAudio("324151119", var_524_21)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_324151", "324151119", "story_v_out_324151.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_324151", "324151119", "story_v_out_324151.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_22 = math.max(var_524_13, arg_521_1.talkMaxDuration)

			if var_524_12 <= arg_521_1.time_ and arg_521_1.time_ < var_524_12 + var_524_22 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_12) / var_524_22

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_12 + var_524_22 and arg_521_1.time_ < var_524_12 + var_524_22 + arg_524_0 then
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
			local var_528_0 = arg_525_1.actors_["10171ui_story"].transform
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 then
				arg_525_1.var_.moveOldPos10171ui_story = var_528_0.localPosition

				local var_528_2 = GameObjectTools.GetOrAddComponent(var_528_0.gameObject, typeof(DynamicBoneHelper))

				if var_528_2 then
					var_528_2:EnableDynamicBone(false)
				end
			end

			local var_528_3 = 0.001

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_3 then
				local var_528_4 = (arg_525_1.time_ - var_528_1) / var_528_3
				local var_528_5 = Vector3.New(0, 100, 0)

				var_528_0.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10171ui_story, var_528_5, var_528_4)

				local var_528_6 = manager.ui.mainCamera.transform.position - var_528_0.position

				var_528_0.forward = Vector3.New(var_528_6.x, var_528_6.y, var_528_6.z)

				local var_528_7 = var_528_0.localEulerAngles

				var_528_7.z = 0
				var_528_7.x = 0
				var_528_0.localEulerAngles = var_528_7
			end

			if arg_525_1.time_ >= var_528_1 + var_528_3 and arg_525_1.time_ < var_528_1 + var_528_3 + arg_528_0 then
				var_528_0.localPosition = Vector3.New(0, 100, 0)

				local var_528_8 = manager.ui.mainCamera.transform.position - var_528_0.position

				var_528_0.forward = Vector3.New(var_528_8.x, var_528_8.y, var_528_8.z)

				local var_528_9 = var_528_0.localEulerAngles

				var_528_9.z = 0
				var_528_9.x = 0
				var_528_0.localEulerAngles = var_528_9

				local var_528_10 = GameObjectTools.GetOrAddComponent(var_528_0.gameObject, typeof(DynamicBoneHelper))

				if var_528_10 then
					var_528_10:EnableDynamicBone(true)
				end
			end

			local var_528_11 = arg_525_1.actors_["1074ui_story"].transform
			local var_528_12 = 0

			if var_528_12 < arg_525_1.time_ and arg_525_1.time_ <= var_528_12 + arg_528_0 then
				arg_525_1.var_.moveOldPos1074ui_story = var_528_11.localPosition
			end

			local var_528_13 = 0.001

			if var_528_12 <= arg_525_1.time_ and arg_525_1.time_ < var_528_12 + var_528_13 then
				local var_528_14 = (arg_525_1.time_ - var_528_12) / var_528_13
				local var_528_15 = Vector3.New(-0.7, -1.055, -6.12)

				var_528_11.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1074ui_story, var_528_15, var_528_14)

				local var_528_16 = manager.ui.mainCamera.transform.position - var_528_11.position

				var_528_11.forward = Vector3.New(var_528_16.x, var_528_16.y, var_528_16.z)

				local var_528_17 = var_528_11.localEulerAngles

				var_528_17.z = 0
				var_528_17.x = 0
				var_528_11.localEulerAngles = var_528_17
			end

			if arg_525_1.time_ >= var_528_12 + var_528_13 and arg_525_1.time_ < var_528_12 + var_528_13 + arg_528_0 then
				var_528_11.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_528_18 = manager.ui.mainCamera.transform.position - var_528_11.position

				var_528_11.forward = Vector3.New(var_528_18.x, var_528_18.y, var_528_18.z)

				local var_528_19 = var_528_11.localEulerAngles

				var_528_19.z = 0
				var_528_19.x = 0
				var_528_11.localEulerAngles = var_528_19
			end

			local var_528_20 = arg_525_1.actors_["1074ui_story"]
			local var_528_21 = 0

			if var_528_21 < arg_525_1.time_ and arg_525_1.time_ <= var_528_21 + arg_528_0 and not isNil(var_528_20) and arg_525_1.var_.characterEffect1074ui_story == nil then
				arg_525_1.var_.characterEffect1074ui_story = var_528_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_22 = 0.200000002980232

			if var_528_21 <= arg_525_1.time_ and arg_525_1.time_ < var_528_21 + var_528_22 and not isNil(var_528_20) then
				local var_528_23 = (arg_525_1.time_ - var_528_21) / var_528_22

				if arg_525_1.var_.characterEffect1074ui_story and not isNil(var_528_20) then
					arg_525_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= var_528_21 + var_528_22 and arg_525_1.time_ < var_528_21 + var_528_22 + arg_528_0 and not isNil(var_528_20) and arg_525_1.var_.characterEffect1074ui_story then
				arg_525_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_528_24 = arg_525_1.actors_["10171ui_story"]
			local var_528_25 = 0

			if var_528_25 < arg_525_1.time_ and arg_525_1.time_ <= var_528_25 + arg_528_0 and not isNil(var_528_24) and arg_525_1.var_.characterEffect10171ui_story == nil then
				arg_525_1.var_.characterEffect10171ui_story = var_528_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_26 = 0.200000002980232

			if var_528_25 <= arg_525_1.time_ and arg_525_1.time_ < var_528_25 + var_528_26 and not isNil(var_528_24) then
				local var_528_27 = (arg_525_1.time_ - var_528_25) / var_528_26

				if arg_525_1.var_.characterEffect10171ui_story and not isNil(var_528_24) then
					local var_528_28 = Mathf.Lerp(0, 0.5, var_528_27)

					arg_525_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_525_1.var_.characterEffect10171ui_story.fillRatio = var_528_28
				end
			end

			if arg_525_1.time_ >= var_528_25 + var_528_26 and arg_525_1.time_ < var_528_25 + var_528_26 + arg_528_0 and not isNil(var_528_24) and arg_525_1.var_.characterEffect10171ui_story then
				local var_528_29 = 0.5

				arg_525_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_525_1.var_.characterEffect10171ui_story.fillRatio = var_528_29
			end

			local var_528_30 = 0

			if var_528_30 < arg_525_1.time_ and arg_525_1.time_ <= var_528_30 + arg_528_0 then
				arg_525_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074actionlink/1074action426")
			end

			local var_528_31 = 0

			if var_528_31 < arg_525_1.time_ and arg_525_1.time_ <= var_528_31 + arg_528_0 then
				arg_525_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_528_32 = 0
			local var_528_33 = 0.975

			if var_528_32 < arg_525_1.time_ and arg_525_1.time_ <= var_528_32 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_34 = arg_525_1:FormatText(StoryNameCfg[410].name)

				arg_525_1.leftNameTxt_.text = var_528_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_35 = arg_525_1:GetWordFromCfg(324151120)
				local var_528_36 = arg_525_1:FormatText(var_528_35.content)

				arg_525_1.text_.text = var_528_36

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_37 = 39
				local var_528_38 = utf8.len(var_528_36)
				local var_528_39 = var_528_37 <= 0 and var_528_33 or var_528_33 * (var_528_38 / var_528_37)

				if var_528_39 > 0 and var_528_33 < var_528_39 then
					arg_525_1.talkMaxDuration = var_528_39

					if var_528_39 + var_528_32 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_39 + var_528_32
					end
				end

				arg_525_1.text_.text = var_528_36
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151120", "story_v_out_324151.awb") ~= 0 then
					local var_528_40 = manager.audio:GetVoiceLength("story_v_out_324151", "324151120", "story_v_out_324151.awb") / 1000

					if var_528_40 + var_528_32 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_40 + var_528_32
					end

					if var_528_35.prefab_name ~= "" and arg_525_1.actors_[var_528_35.prefab_name] ~= nil then
						local var_528_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_35.prefab_name].transform, "story_v_out_324151", "324151120", "story_v_out_324151.awb")

						arg_525_1:RecordAudio("324151120", var_528_41)
						arg_525_1:RecordAudio("324151120", var_528_41)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_324151", "324151120", "story_v_out_324151.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_324151", "324151120", "story_v_out_324151.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_42 = math.max(var_528_33, arg_525_1.talkMaxDuration)

			if var_528_32 <= arg_525_1.time_ and arg_525_1.time_ < var_528_32 + var_528_42 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_32) / var_528_42

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_32 + var_528_42 and arg_525_1.time_ < var_528_32 + var_528_42 + arg_528_0 then
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
			local var_532_0 = arg_529_1.actors_["1072ui_story"]
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1072ui_story == nil then
				arg_529_1.var_.characterEffect1072ui_story = var_532_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_2 = 0.200000002980232

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 and not isNil(var_532_0) then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2

				if arg_529_1.var_.characterEffect1072ui_story and not isNil(var_532_0) then
					arg_529_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1072ui_story then
				arg_529_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_532_4 = arg_529_1.actors_["1074ui_story"]
			local var_532_5 = 0

			if var_532_5 < arg_529_1.time_ and arg_529_1.time_ <= var_532_5 + arg_532_0 and not isNil(var_532_4) and arg_529_1.var_.characterEffect1074ui_story == nil then
				arg_529_1.var_.characterEffect1074ui_story = var_532_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_6 = 0.200000002980232

			if var_532_5 <= arg_529_1.time_ and arg_529_1.time_ < var_532_5 + var_532_6 and not isNil(var_532_4) then
				local var_532_7 = (arg_529_1.time_ - var_532_5) / var_532_6

				if arg_529_1.var_.characterEffect1074ui_story and not isNil(var_532_4) then
					local var_532_8 = Mathf.Lerp(0, 0.5, var_532_7)

					arg_529_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1074ui_story.fillRatio = var_532_8
				end
			end

			if arg_529_1.time_ >= var_532_5 + var_532_6 and arg_529_1.time_ < var_532_5 + var_532_6 + arg_532_0 and not isNil(var_532_4) and arg_529_1.var_.characterEffect1074ui_story then
				local var_532_9 = 0.5

				arg_529_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1074ui_story.fillRatio = var_532_9
			end

			local var_532_10 = 0

			if var_532_10 < arg_529_1.time_ and arg_529_1.time_ <= var_532_10 + arg_532_0 then
				arg_529_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_532_11 = 0

			if var_532_11 < arg_529_1.time_ and arg_529_1.time_ <= var_532_11 + arg_532_0 then
				arg_529_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_532_12 = 0
			local var_532_13 = 0.425

			if var_532_12 < arg_529_1.time_ and arg_529_1.time_ <= var_532_12 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_14 = arg_529_1:FormatText(StoryNameCfg[379].name)

				arg_529_1.leftNameTxt_.text = var_532_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_15 = arg_529_1:GetWordFromCfg(324151121)
				local var_532_16 = arg_529_1:FormatText(var_532_15.content)

				arg_529_1.text_.text = var_532_16

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_17 = 17
				local var_532_18 = utf8.len(var_532_16)
				local var_532_19 = var_532_17 <= 0 and var_532_13 or var_532_13 * (var_532_18 / var_532_17)

				if var_532_19 > 0 and var_532_13 < var_532_19 then
					arg_529_1.talkMaxDuration = var_532_19

					if var_532_19 + var_532_12 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_19 + var_532_12
					end
				end

				arg_529_1.text_.text = var_532_16
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151121", "story_v_out_324151.awb") ~= 0 then
					local var_532_20 = manager.audio:GetVoiceLength("story_v_out_324151", "324151121", "story_v_out_324151.awb") / 1000

					if var_532_20 + var_532_12 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_20 + var_532_12
					end

					if var_532_15.prefab_name ~= "" and arg_529_1.actors_[var_532_15.prefab_name] ~= nil then
						local var_532_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_15.prefab_name].transform, "story_v_out_324151", "324151121", "story_v_out_324151.awb")

						arg_529_1:RecordAudio("324151121", var_532_21)
						arg_529_1:RecordAudio("324151121", var_532_21)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_324151", "324151121", "story_v_out_324151.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_324151", "324151121", "story_v_out_324151.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_22 = math.max(var_532_13, arg_529_1.talkMaxDuration)

			if var_532_12 <= arg_529_1.time_ and arg_529_1.time_ < var_532_12 + var_532_22 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_12) / var_532_22

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_12 + var_532_22 and arg_529_1.time_ < var_532_12 + var_532_22 + arg_532_0 then
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
			local var_536_0 = arg_533_1.actors_["1074ui_story"]
			local var_536_1 = 0

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1074ui_story == nil then
				arg_533_1.var_.characterEffect1074ui_story = var_536_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_2 = 0.200000002980232

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_2 and not isNil(var_536_0) then
				local var_536_3 = (arg_533_1.time_ - var_536_1) / var_536_2

				if arg_533_1.var_.characterEffect1074ui_story and not isNil(var_536_0) then
					arg_533_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_533_1.time_ >= var_536_1 + var_536_2 and arg_533_1.time_ < var_536_1 + var_536_2 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1074ui_story then
				arg_533_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_536_4 = arg_533_1.actors_["1072ui_story"]
			local var_536_5 = 0

			if var_536_5 < arg_533_1.time_ and arg_533_1.time_ <= var_536_5 + arg_536_0 and not isNil(var_536_4) and arg_533_1.var_.characterEffect1072ui_story == nil then
				arg_533_1.var_.characterEffect1072ui_story = var_536_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_6 = 0.200000002980232

			if var_536_5 <= arg_533_1.time_ and arg_533_1.time_ < var_536_5 + var_536_6 and not isNil(var_536_4) then
				local var_536_7 = (arg_533_1.time_ - var_536_5) / var_536_6

				if arg_533_1.var_.characterEffect1072ui_story and not isNil(var_536_4) then
					local var_536_8 = Mathf.Lerp(0, 0.5, var_536_7)

					arg_533_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_533_1.var_.characterEffect1072ui_story.fillRatio = var_536_8
				end
			end

			if arg_533_1.time_ >= var_536_5 + var_536_6 and arg_533_1.time_ < var_536_5 + var_536_6 + arg_536_0 and not isNil(var_536_4) and arg_533_1.var_.characterEffect1072ui_story then
				local var_536_9 = 0.5

				arg_533_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_533_1.var_.characterEffect1072ui_story.fillRatio = var_536_9
			end

			local var_536_10 = 0
			local var_536_11 = 0.55

			if var_536_10 < arg_533_1.time_ and arg_533_1.time_ <= var_536_10 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_12 = arg_533_1:FormatText(StoryNameCfg[410].name)

				arg_533_1.leftNameTxt_.text = var_536_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_13 = arg_533_1:GetWordFromCfg(324151122)
				local var_536_14 = arg_533_1:FormatText(var_536_13.content)

				arg_533_1.text_.text = var_536_14

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_15 = 22
				local var_536_16 = utf8.len(var_536_14)
				local var_536_17 = var_536_15 <= 0 and var_536_11 or var_536_11 * (var_536_16 / var_536_15)

				if var_536_17 > 0 and var_536_11 < var_536_17 then
					arg_533_1.talkMaxDuration = var_536_17

					if var_536_17 + var_536_10 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_17 + var_536_10
					end
				end

				arg_533_1.text_.text = var_536_14
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151122", "story_v_out_324151.awb") ~= 0 then
					local var_536_18 = manager.audio:GetVoiceLength("story_v_out_324151", "324151122", "story_v_out_324151.awb") / 1000

					if var_536_18 + var_536_10 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_18 + var_536_10
					end

					if var_536_13.prefab_name ~= "" and arg_533_1.actors_[var_536_13.prefab_name] ~= nil then
						local var_536_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_13.prefab_name].transform, "story_v_out_324151", "324151122", "story_v_out_324151.awb")

						arg_533_1:RecordAudio("324151122", var_536_19)
						arg_533_1:RecordAudio("324151122", var_536_19)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_324151", "324151122", "story_v_out_324151.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_324151", "324151122", "story_v_out_324151.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_20 = math.max(var_536_11, arg_533_1.talkMaxDuration)

			if var_536_10 <= arg_533_1.time_ and arg_533_1.time_ < var_536_10 + var_536_20 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_10) / var_536_20

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_10 + var_536_20 and arg_533_1.time_ < var_536_10 + var_536_20 + arg_536_0 then
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
			local var_540_0 = 0

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_2")
			end

			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_540_2 = 0
			local var_540_3 = 1.475

			if var_540_2 < arg_537_1.time_ and arg_537_1.time_ <= var_540_2 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_4 = arg_537_1:FormatText(StoryNameCfg[410].name)

				arg_537_1.leftNameTxt_.text = var_540_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_5 = arg_537_1:GetWordFromCfg(324151123)
				local var_540_6 = arg_537_1:FormatText(var_540_5.content)

				arg_537_1.text_.text = var_540_6

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_7 = 59
				local var_540_8 = utf8.len(var_540_6)
				local var_540_9 = var_540_7 <= 0 and var_540_3 or var_540_3 * (var_540_8 / var_540_7)

				if var_540_9 > 0 and var_540_3 < var_540_9 then
					arg_537_1.talkMaxDuration = var_540_9

					if var_540_9 + var_540_2 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_9 + var_540_2
					end
				end

				arg_537_1.text_.text = var_540_6
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151123", "story_v_out_324151.awb") ~= 0 then
					local var_540_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151123", "story_v_out_324151.awb") / 1000

					if var_540_10 + var_540_2 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_10 + var_540_2
					end

					if var_540_5.prefab_name ~= "" and arg_537_1.actors_[var_540_5.prefab_name] ~= nil then
						local var_540_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_5.prefab_name].transform, "story_v_out_324151", "324151123", "story_v_out_324151.awb")

						arg_537_1:RecordAudio("324151123", var_540_11)
						arg_537_1:RecordAudio("324151123", var_540_11)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_324151", "324151123", "story_v_out_324151.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_324151", "324151123", "story_v_out_324151.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_12 = math.max(var_540_3, arg_537_1.talkMaxDuration)

			if var_540_2 <= arg_537_1.time_ and arg_537_1.time_ < var_540_2 + var_540_12 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_2) / var_540_12

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_2 + var_540_12 and arg_537_1.time_ < var_540_2 + var_540_12 + arg_540_0 then
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
			local var_544_0 = 0
			local var_544_1 = 0.45

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_2 = arg_541_1:FormatText(StoryNameCfg[410].name)

				arg_541_1.leftNameTxt_.text = var_544_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:GetWordFromCfg(324151124)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 18
				local var_544_6 = utf8.len(var_544_4)
				local var_544_7 = var_544_5 <= 0 and var_544_1 or var_544_1 * (var_544_6 / var_544_5)

				if var_544_7 > 0 and var_544_1 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151124", "story_v_out_324151.awb") ~= 0 then
					local var_544_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151124", "story_v_out_324151.awb") / 1000

					if var_544_8 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_8 + var_544_0
					end

					if var_544_3.prefab_name ~= "" and arg_541_1.actors_[var_544_3.prefab_name] ~= nil then
						local var_544_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_3.prefab_name].transform, "story_v_out_324151", "324151124", "story_v_out_324151.awb")

						arg_541_1:RecordAudio("324151124", var_544_9)
						arg_541_1:RecordAudio("324151124", var_544_9)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_324151", "324151124", "story_v_out_324151.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_324151", "324151124", "story_v_out_324151.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_10 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_10 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_10

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_10 and arg_541_1.time_ < var_544_0 + var_544_10 + arg_544_0 then
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
			local var_548_0 = arg_545_1.actors_["10171ui_story"].transform
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 then
				arg_545_1.var_.moveOldPos10171ui_story = var_548_0.localPosition

				local var_548_2 = GameObjectTools.GetOrAddComponent(var_548_0.gameObject, typeof(DynamicBoneHelper))

				if var_548_2 then
					var_548_2:EnableDynamicBone(false)
				end
			end

			local var_548_3 = 0.001

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_3 then
				local var_548_4 = (arg_545_1.time_ - var_548_1) / var_548_3
				local var_548_5 = Vector3.New(0.7, -0.95, -6.05)

				var_548_0.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos10171ui_story, var_548_5, var_548_4)

				local var_548_6 = manager.ui.mainCamera.transform.position - var_548_0.position

				var_548_0.forward = Vector3.New(var_548_6.x, var_548_6.y, var_548_6.z)

				local var_548_7 = var_548_0.localEulerAngles

				var_548_7.z = 0
				var_548_7.x = 0
				var_548_0.localEulerAngles = var_548_7
			end

			if arg_545_1.time_ >= var_548_1 + var_548_3 and arg_545_1.time_ < var_548_1 + var_548_3 + arg_548_0 then
				var_548_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_548_8 = manager.ui.mainCamera.transform.position - var_548_0.position

				var_548_0.forward = Vector3.New(var_548_8.x, var_548_8.y, var_548_8.z)

				local var_548_9 = var_548_0.localEulerAngles

				var_548_9.z = 0
				var_548_9.x = 0
				var_548_0.localEulerAngles = var_548_9

				local var_548_10 = GameObjectTools.GetOrAddComponent(var_548_0.gameObject, typeof(DynamicBoneHelper))

				if var_548_10 then
					var_548_10:EnableDynamicBone(true)
				end
			end

			local var_548_11 = arg_545_1.actors_["1072ui_story"].transform
			local var_548_12 = 0

			if var_548_12 < arg_545_1.time_ and arg_545_1.time_ <= var_548_12 + arg_548_0 then
				arg_545_1.var_.moveOldPos1072ui_story = var_548_11.localPosition
			end

			local var_548_13 = 0.001

			if var_548_12 <= arg_545_1.time_ and arg_545_1.time_ < var_548_12 + var_548_13 then
				local var_548_14 = (arg_545_1.time_ - var_548_12) / var_548_13
				local var_548_15 = Vector3.New(0, 100, 0)

				var_548_11.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1072ui_story, var_548_15, var_548_14)

				local var_548_16 = manager.ui.mainCamera.transform.position - var_548_11.position

				var_548_11.forward = Vector3.New(var_548_16.x, var_548_16.y, var_548_16.z)

				local var_548_17 = var_548_11.localEulerAngles

				var_548_17.z = 0
				var_548_17.x = 0
				var_548_11.localEulerAngles = var_548_17
			end

			if arg_545_1.time_ >= var_548_12 + var_548_13 and arg_545_1.time_ < var_548_12 + var_548_13 + arg_548_0 then
				var_548_11.localPosition = Vector3.New(0, 100, 0)

				local var_548_18 = manager.ui.mainCamera.transform.position - var_548_11.position

				var_548_11.forward = Vector3.New(var_548_18.x, var_548_18.y, var_548_18.z)

				local var_548_19 = var_548_11.localEulerAngles

				var_548_19.z = 0
				var_548_19.x = 0
				var_548_11.localEulerAngles = var_548_19
			end

			local var_548_20 = arg_545_1.actors_["10171ui_story"]
			local var_548_21 = 0

			if var_548_21 < arg_545_1.time_ and arg_545_1.time_ <= var_548_21 + arg_548_0 and not isNil(var_548_20) and arg_545_1.var_.characterEffect10171ui_story == nil then
				arg_545_1.var_.characterEffect10171ui_story = var_548_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_22 = 0.200000002980232

			if var_548_21 <= arg_545_1.time_ and arg_545_1.time_ < var_548_21 + var_548_22 and not isNil(var_548_20) then
				local var_548_23 = (arg_545_1.time_ - var_548_21) / var_548_22

				if arg_545_1.var_.characterEffect10171ui_story and not isNil(var_548_20) then
					arg_545_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= var_548_21 + var_548_22 and arg_545_1.time_ < var_548_21 + var_548_22 + arg_548_0 and not isNil(var_548_20) and arg_545_1.var_.characterEffect10171ui_story then
				arg_545_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_548_24 = arg_545_1.actors_["1074ui_story"]
			local var_548_25 = 0

			if var_548_25 < arg_545_1.time_ and arg_545_1.time_ <= var_548_25 + arg_548_0 and not isNil(var_548_24) and arg_545_1.var_.characterEffect1074ui_story == nil then
				arg_545_1.var_.characterEffect1074ui_story = var_548_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_26 = 0.200000002980232

			if var_548_25 <= arg_545_1.time_ and arg_545_1.time_ < var_548_25 + var_548_26 and not isNil(var_548_24) then
				local var_548_27 = (arg_545_1.time_ - var_548_25) / var_548_26

				if arg_545_1.var_.characterEffect1074ui_story and not isNil(var_548_24) then
					local var_548_28 = Mathf.Lerp(0, 0.5, var_548_27)

					arg_545_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_545_1.var_.characterEffect1074ui_story.fillRatio = var_548_28
				end
			end

			if arg_545_1.time_ >= var_548_25 + var_548_26 and arg_545_1.time_ < var_548_25 + var_548_26 + arg_548_0 and not isNil(var_548_24) and arg_545_1.var_.characterEffect1074ui_story then
				local var_548_29 = 0.5

				arg_545_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_545_1.var_.characterEffect1074ui_story.fillRatio = var_548_29
			end

			local var_548_30 = 0

			if var_548_30 < arg_545_1.time_ and arg_545_1.time_ <= var_548_30 + arg_548_0 then
				arg_545_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_2")
			end

			local var_548_31 = 0

			if var_548_31 < arg_545_1.time_ and arg_545_1.time_ <= var_548_31 + arg_548_0 then
				arg_545_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_548_32 = 0
			local var_548_33 = 1.025

			if var_548_32 < arg_545_1.time_ and arg_545_1.time_ <= var_548_32 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_34 = arg_545_1:FormatText(StoryNameCfg[1451].name)

				arg_545_1.leftNameTxt_.text = var_548_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_35 = arg_545_1:GetWordFromCfg(324151125)
				local var_548_36 = arg_545_1:FormatText(var_548_35.content)

				arg_545_1.text_.text = var_548_36

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_37 = 41
				local var_548_38 = utf8.len(var_548_36)
				local var_548_39 = var_548_37 <= 0 and var_548_33 or var_548_33 * (var_548_38 / var_548_37)

				if var_548_39 > 0 and var_548_33 < var_548_39 then
					arg_545_1.talkMaxDuration = var_548_39

					if var_548_39 + var_548_32 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_39 + var_548_32
					end
				end

				arg_545_1.text_.text = var_548_36
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151125", "story_v_out_324151.awb") ~= 0 then
					local var_548_40 = manager.audio:GetVoiceLength("story_v_out_324151", "324151125", "story_v_out_324151.awb") / 1000

					if var_548_40 + var_548_32 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_40 + var_548_32
					end

					if var_548_35.prefab_name ~= "" and arg_545_1.actors_[var_548_35.prefab_name] ~= nil then
						local var_548_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_35.prefab_name].transform, "story_v_out_324151", "324151125", "story_v_out_324151.awb")

						arg_545_1:RecordAudio("324151125", var_548_41)
						arg_545_1:RecordAudio("324151125", var_548_41)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_324151", "324151125", "story_v_out_324151.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_324151", "324151125", "story_v_out_324151.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_42 = math.max(var_548_33, arg_545_1.talkMaxDuration)

			if var_548_32 <= arg_545_1.time_ and arg_545_1.time_ < var_548_32 + var_548_42 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_32) / var_548_42

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_32 + var_548_42 and arg_545_1.time_ < var_548_32 + var_548_42 + arg_548_0 then
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
			local var_552_0 = arg_549_1.actors_["1060ui_story"].transform
			local var_552_1 = 0

			if var_552_1 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.var_.moveOldPos1060ui_story = var_552_0.localPosition
			end

			local var_552_2 = 0.001

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_2 then
				local var_552_3 = (arg_549_1.time_ - var_552_1) / var_552_2
				local var_552_4 = Vector3.New(-0.7, -1.14, -6.33)

				var_552_0.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1060ui_story, var_552_4, var_552_3)

				local var_552_5 = manager.ui.mainCamera.transform.position - var_552_0.position

				var_552_0.forward = Vector3.New(var_552_5.x, var_552_5.y, var_552_5.z)

				local var_552_6 = var_552_0.localEulerAngles

				var_552_6.z = 0
				var_552_6.x = 0
				var_552_0.localEulerAngles = var_552_6
			end

			if arg_549_1.time_ >= var_552_1 + var_552_2 and arg_549_1.time_ < var_552_1 + var_552_2 + arg_552_0 then
				var_552_0.localPosition = Vector3.New(-0.7, -1.14, -6.33)

				local var_552_7 = manager.ui.mainCamera.transform.position - var_552_0.position

				var_552_0.forward = Vector3.New(var_552_7.x, var_552_7.y, var_552_7.z)

				local var_552_8 = var_552_0.localEulerAngles

				var_552_8.z = 0
				var_552_8.x = 0
				var_552_0.localEulerAngles = var_552_8
			end

			local var_552_9 = arg_549_1.actors_["1074ui_story"].transform
			local var_552_10 = 0

			if var_552_10 < arg_549_1.time_ and arg_549_1.time_ <= var_552_10 + arg_552_0 then
				arg_549_1.var_.moveOldPos1074ui_story = var_552_9.localPosition
			end

			local var_552_11 = 0.001

			if var_552_10 <= arg_549_1.time_ and arg_549_1.time_ < var_552_10 + var_552_11 then
				local var_552_12 = (arg_549_1.time_ - var_552_10) / var_552_11
				local var_552_13 = Vector3.New(0, 100, 0)

				var_552_9.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1074ui_story, var_552_13, var_552_12)

				local var_552_14 = manager.ui.mainCamera.transform.position - var_552_9.position

				var_552_9.forward = Vector3.New(var_552_14.x, var_552_14.y, var_552_14.z)

				local var_552_15 = var_552_9.localEulerAngles

				var_552_15.z = 0
				var_552_15.x = 0
				var_552_9.localEulerAngles = var_552_15
			end

			if arg_549_1.time_ >= var_552_10 + var_552_11 and arg_549_1.time_ < var_552_10 + var_552_11 + arg_552_0 then
				var_552_9.localPosition = Vector3.New(0, 100, 0)

				local var_552_16 = manager.ui.mainCamera.transform.position - var_552_9.position

				var_552_9.forward = Vector3.New(var_552_16.x, var_552_16.y, var_552_16.z)

				local var_552_17 = var_552_9.localEulerAngles

				var_552_17.z = 0
				var_552_17.x = 0
				var_552_9.localEulerAngles = var_552_17
			end

			local var_552_18 = arg_549_1.actors_["1060ui_story"]
			local var_552_19 = 0

			if var_552_19 < arg_549_1.time_ and arg_549_1.time_ <= var_552_19 + arg_552_0 and not isNil(var_552_18) and arg_549_1.var_.characterEffect1060ui_story == nil then
				arg_549_1.var_.characterEffect1060ui_story = var_552_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_20 = 0.200000002980232

			if var_552_19 <= arg_549_1.time_ and arg_549_1.time_ < var_552_19 + var_552_20 and not isNil(var_552_18) then
				local var_552_21 = (arg_549_1.time_ - var_552_19) / var_552_20

				if arg_549_1.var_.characterEffect1060ui_story and not isNil(var_552_18) then
					arg_549_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= var_552_19 + var_552_20 and arg_549_1.time_ < var_552_19 + var_552_20 + arg_552_0 and not isNil(var_552_18) and arg_549_1.var_.characterEffect1060ui_story then
				arg_549_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_552_22 = arg_549_1.actors_["10171ui_story"]
			local var_552_23 = 0

			if var_552_23 < arg_549_1.time_ and arg_549_1.time_ <= var_552_23 + arg_552_0 and not isNil(var_552_22) and arg_549_1.var_.characterEffect10171ui_story == nil then
				arg_549_1.var_.characterEffect10171ui_story = var_552_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_24 = 0.200000002980232

			if var_552_23 <= arg_549_1.time_ and arg_549_1.time_ < var_552_23 + var_552_24 and not isNil(var_552_22) then
				local var_552_25 = (arg_549_1.time_ - var_552_23) / var_552_24

				if arg_549_1.var_.characterEffect10171ui_story and not isNil(var_552_22) then
					local var_552_26 = Mathf.Lerp(0, 0.5, var_552_25)

					arg_549_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_549_1.var_.characterEffect10171ui_story.fillRatio = var_552_26
				end
			end

			if arg_549_1.time_ >= var_552_23 + var_552_24 and arg_549_1.time_ < var_552_23 + var_552_24 + arg_552_0 and not isNil(var_552_22) and arg_549_1.var_.characterEffect10171ui_story then
				local var_552_27 = 0.5

				arg_549_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_549_1.var_.characterEffect10171ui_story.fillRatio = var_552_27
			end

			local var_552_28 = 0

			if var_552_28 < arg_549_1.time_ and arg_549_1.time_ <= var_552_28 + arg_552_0 then
				arg_549_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action5_2")
			end

			local var_552_29 = 0

			if var_552_29 < arg_549_1.time_ and arg_549_1.time_ <= var_552_29 + arg_552_0 then
				arg_549_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_552_30 = 0
			local var_552_31 = 1.025

			if var_552_30 < arg_549_1.time_ and arg_549_1.time_ <= var_552_30 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_32 = arg_549_1:FormatText(StoryNameCfg[584].name)

				arg_549_1.leftNameTxt_.text = var_552_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_33 = arg_549_1:GetWordFromCfg(324151126)
				local var_552_34 = arg_549_1:FormatText(var_552_33.content)

				arg_549_1.text_.text = var_552_34

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_35 = 41
				local var_552_36 = utf8.len(var_552_34)
				local var_552_37 = var_552_35 <= 0 and var_552_31 or var_552_31 * (var_552_36 / var_552_35)

				if var_552_37 > 0 and var_552_31 < var_552_37 then
					arg_549_1.talkMaxDuration = var_552_37

					if var_552_37 + var_552_30 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_37 + var_552_30
					end
				end

				arg_549_1.text_.text = var_552_34
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151126", "story_v_out_324151.awb") ~= 0 then
					local var_552_38 = manager.audio:GetVoiceLength("story_v_out_324151", "324151126", "story_v_out_324151.awb") / 1000

					if var_552_38 + var_552_30 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_38 + var_552_30
					end

					if var_552_33.prefab_name ~= "" and arg_549_1.actors_[var_552_33.prefab_name] ~= nil then
						local var_552_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_33.prefab_name].transform, "story_v_out_324151", "324151126", "story_v_out_324151.awb")

						arg_549_1:RecordAudio("324151126", var_552_39)
						arg_549_1:RecordAudio("324151126", var_552_39)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_324151", "324151126", "story_v_out_324151.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_324151", "324151126", "story_v_out_324151.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_40 = math.max(var_552_31, arg_549_1.talkMaxDuration)

			if var_552_30 <= arg_549_1.time_ and arg_549_1.time_ < var_552_30 + var_552_40 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_30) / var_552_40

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_30 + var_552_40 and arg_549_1.time_ < var_552_30 + var_552_40 + arg_552_0 then
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
			local var_556_0 = arg_553_1.actors_["1074ui_story"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1074ui_story == nil then
				arg_553_1.var_.characterEffect1074ui_story = var_556_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.characterEffect1074ui_story and not isNil(var_556_0) then
					arg_553_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1074ui_story then
				arg_553_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_556_4 = arg_553_1.actors_["1060ui_story"]
			local var_556_5 = 0

			if var_556_5 < arg_553_1.time_ and arg_553_1.time_ <= var_556_5 + arg_556_0 and not isNil(var_556_4) and arg_553_1.var_.characterEffect1060ui_story == nil then
				arg_553_1.var_.characterEffect1060ui_story = var_556_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_6 = 0.200000002980232

			if var_556_5 <= arg_553_1.time_ and arg_553_1.time_ < var_556_5 + var_556_6 and not isNil(var_556_4) then
				local var_556_7 = (arg_553_1.time_ - var_556_5) / var_556_6

				if arg_553_1.var_.characterEffect1060ui_story and not isNil(var_556_4) then
					local var_556_8 = Mathf.Lerp(0, 0.5, var_556_7)

					arg_553_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1060ui_story.fillRatio = var_556_8
				end
			end

			if arg_553_1.time_ >= var_556_5 + var_556_6 and arg_553_1.time_ < var_556_5 + var_556_6 + arg_556_0 and not isNil(var_556_4) and arg_553_1.var_.characterEffect1060ui_story then
				local var_556_9 = 0.5

				arg_553_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1060ui_story.fillRatio = var_556_9
			end

			local var_556_10 = 0
			local var_556_11 = 0.4

			if var_556_10 < arg_553_1.time_ and arg_553_1.time_ <= var_556_10 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_12 = arg_553_1:FormatText(StoryNameCfg[410].name)

				arg_553_1.leftNameTxt_.text = var_556_12

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

				local var_556_13 = arg_553_1:GetWordFromCfg(324151127)
				local var_556_14 = arg_553_1:FormatText(var_556_13.content)

				arg_553_1.text_.text = var_556_14

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_15 = 16
				local var_556_16 = utf8.len(var_556_14)
				local var_556_17 = var_556_15 <= 0 and var_556_11 or var_556_11 * (var_556_16 / var_556_15)

				if var_556_17 > 0 and var_556_11 < var_556_17 then
					arg_553_1.talkMaxDuration = var_556_17

					if var_556_17 + var_556_10 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_17 + var_556_10
					end
				end

				arg_553_1.text_.text = var_556_14
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151127", "story_v_out_324151.awb") ~= 0 then
					local var_556_18 = manager.audio:GetVoiceLength("story_v_out_324151", "324151127", "story_v_out_324151.awb") / 1000

					if var_556_18 + var_556_10 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_18 + var_556_10
					end

					if var_556_13.prefab_name ~= "" and arg_553_1.actors_[var_556_13.prefab_name] ~= nil then
						local var_556_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_13.prefab_name].transform, "story_v_out_324151", "324151127", "story_v_out_324151.awb")

						arg_553_1:RecordAudio("324151127", var_556_19)
						arg_553_1:RecordAudio("324151127", var_556_19)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_324151", "324151127", "story_v_out_324151.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_324151", "324151127", "story_v_out_324151.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_20 = math.max(var_556_11, arg_553_1.talkMaxDuration)

			if var_556_10 <= arg_553_1.time_ and arg_553_1.time_ < var_556_10 + var_556_20 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_10) / var_556_20

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_10 + var_556_20 and arg_553_1.time_ < var_556_10 + var_556_20 + arg_556_0 then
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
			local var_560_0 = arg_557_1.actors_["1060ui_story"].transform
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.var_.moveOldPos1060ui_story = var_560_0.localPosition
			end

			local var_560_2 = 0.001

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2
				local var_560_4 = Vector3.New(0, 100, 0)

				var_560_0.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1060ui_story, var_560_4, var_560_3)

				local var_560_5 = manager.ui.mainCamera.transform.position - var_560_0.position

				var_560_0.forward = Vector3.New(var_560_5.x, var_560_5.y, var_560_5.z)

				local var_560_6 = var_560_0.localEulerAngles

				var_560_6.z = 0
				var_560_6.x = 0
				var_560_0.localEulerAngles = var_560_6
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 then
				var_560_0.localPosition = Vector3.New(0, 100, 0)

				local var_560_7 = manager.ui.mainCamera.transform.position - var_560_0.position

				var_560_0.forward = Vector3.New(var_560_7.x, var_560_7.y, var_560_7.z)

				local var_560_8 = var_560_0.localEulerAngles

				var_560_8.z = 0
				var_560_8.x = 0
				var_560_0.localEulerAngles = var_560_8
			end

			local var_560_9 = arg_557_1.actors_["10171ui_story"].transform
			local var_560_10 = 0

			if var_560_10 < arg_557_1.time_ and arg_557_1.time_ <= var_560_10 + arg_560_0 then
				arg_557_1.var_.moveOldPos10171ui_story = var_560_9.localPosition

				local var_560_11 = GameObjectTools.GetOrAddComponent(var_560_9.gameObject, typeof(DynamicBoneHelper))

				if var_560_11 then
					var_560_11:EnableDynamicBone(false)
				end
			end

			local var_560_12 = 0.001

			if var_560_10 <= arg_557_1.time_ and arg_557_1.time_ < var_560_10 + var_560_12 then
				local var_560_13 = (arg_557_1.time_ - var_560_10) / var_560_12
				local var_560_14 = Vector3.New(0, 100, 0)

				var_560_9.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos10171ui_story, var_560_14, var_560_13)

				local var_560_15 = manager.ui.mainCamera.transform.position - var_560_9.position

				var_560_9.forward = Vector3.New(var_560_15.x, var_560_15.y, var_560_15.z)

				local var_560_16 = var_560_9.localEulerAngles

				var_560_16.z = 0
				var_560_16.x = 0
				var_560_9.localEulerAngles = var_560_16
			end

			if arg_557_1.time_ >= var_560_10 + var_560_12 and arg_557_1.time_ < var_560_10 + var_560_12 + arg_560_0 then
				var_560_9.localPosition = Vector3.New(0, 100, 0)

				local var_560_17 = manager.ui.mainCamera.transform.position - var_560_9.position

				var_560_9.forward = Vector3.New(var_560_17.x, var_560_17.y, var_560_17.z)

				local var_560_18 = var_560_9.localEulerAngles

				var_560_18.z = 0
				var_560_18.x = 0
				var_560_9.localEulerAngles = var_560_18

				local var_560_19 = GameObjectTools.GetOrAddComponent(var_560_9.gameObject, typeof(DynamicBoneHelper))

				if var_560_19 then
					var_560_19:EnableDynamicBone(true)
				end
			end

			local var_560_20 = arg_557_1.actors_["1074ui_story"]
			local var_560_21 = 0

			if var_560_21 < arg_557_1.time_ and arg_557_1.time_ <= var_560_21 + arg_560_0 and not isNil(var_560_20) and arg_557_1.var_.characterEffect1074ui_story == nil then
				arg_557_1.var_.characterEffect1074ui_story = var_560_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_22 = 0.200000002980232

			if var_560_21 <= arg_557_1.time_ and arg_557_1.time_ < var_560_21 + var_560_22 and not isNil(var_560_20) then
				local var_560_23 = (arg_557_1.time_ - var_560_21) / var_560_22

				if arg_557_1.var_.characterEffect1074ui_story and not isNil(var_560_20) then
					local var_560_24 = Mathf.Lerp(0, 0.5, var_560_23)

					arg_557_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_557_1.var_.characterEffect1074ui_story.fillRatio = var_560_24
				end
			end

			if arg_557_1.time_ >= var_560_21 + var_560_22 and arg_557_1.time_ < var_560_21 + var_560_22 + arg_560_0 and not isNil(var_560_20) and arg_557_1.var_.characterEffect1074ui_story then
				local var_560_25 = 0.5

				arg_557_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_557_1.var_.characterEffect1074ui_story.fillRatio = var_560_25
			end

			local var_560_26 = 0.9
			local var_560_27 = 1

			if var_560_26 < arg_557_1.time_ and arg_557_1.time_ <= var_560_26 + arg_560_0 then
				local var_560_28 = "play"
				local var_560_29 = "effect"

				arg_557_1:AudioAction(var_560_28, var_560_29, "se_story_142", "se_story_142_chopper01", "")
			end

			local var_560_30 = 0
			local var_560_31 = 1.625

			if var_560_30 < arg_557_1.time_ and arg_557_1.time_ <= var_560_30 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_32 = arg_557_1:GetWordFromCfg(324151128)
				local var_560_33 = arg_557_1:FormatText(var_560_32.content)

				arg_557_1.text_.text = var_560_33

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_34 = 65
				local var_560_35 = utf8.len(var_560_33)
				local var_560_36 = var_560_34 <= 0 and var_560_31 or var_560_31 * (var_560_35 / var_560_34)

				if var_560_36 > 0 and var_560_31 < var_560_36 then
					arg_557_1.talkMaxDuration = var_560_36

					if var_560_36 + var_560_30 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_36 + var_560_30
					end
				end

				arg_557_1.text_.text = var_560_33
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_37 = math.max(var_560_31, arg_557_1.talkMaxDuration)

			if var_560_30 <= arg_557_1.time_ and arg_557_1.time_ < var_560_30 + var_560_37 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_30) / var_560_37

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_30 + var_560_37 and arg_557_1.time_ < var_560_30 + var_560_37 + arg_560_0 then
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
			local var_564_0 = arg_561_1.actors_["10171ui_story"].transform
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 then
				arg_561_1.var_.moveOldPos10171ui_story = var_564_0.localPosition

				local var_564_2 = GameObjectTools.GetOrAddComponent(var_564_0.gameObject, typeof(DynamicBoneHelper))

				if var_564_2 then
					var_564_2:EnableDynamicBone(false)
				end
			end

			local var_564_3 = 0.001

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_3 then
				local var_564_4 = (arg_561_1.time_ - var_564_1) / var_564_3
				local var_564_5 = Vector3.New(0, -0.95, -6.05)

				var_564_0.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos10171ui_story, var_564_5, var_564_4)

				local var_564_6 = manager.ui.mainCamera.transform.position - var_564_0.position

				var_564_0.forward = Vector3.New(var_564_6.x, var_564_6.y, var_564_6.z)

				local var_564_7 = var_564_0.localEulerAngles

				var_564_7.z = 0
				var_564_7.x = 0
				var_564_0.localEulerAngles = var_564_7
			end

			if arg_561_1.time_ >= var_564_1 + var_564_3 and arg_561_1.time_ < var_564_1 + var_564_3 + arg_564_0 then
				var_564_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_564_8 = manager.ui.mainCamera.transform.position - var_564_0.position

				var_564_0.forward = Vector3.New(var_564_8.x, var_564_8.y, var_564_8.z)

				local var_564_9 = var_564_0.localEulerAngles

				var_564_9.z = 0
				var_564_9.x = 0
				var_564_0.localEulerAngles = var_564_9

				local var_564_10 = GameObjectTools.GetOrAddComponent(var_564_0.gameObject, typeof(DynamicBoneHelper))

				if var_564_10 then
					var_564_10:EnableDynamicBone(true)
				end
			end

			local var_564_11 = arg_561_1.actors_["10171ui_story"]
			local var_564_12 = 0

			if var_564_12 < arg_561_1.time_ and arg_561_1.time_ <= var_564_12 + arg_564_0 and not isNil(var_564_11) and arg_561_1.var_.characterEffect10171ui_story == nil then
				arg_561_1.var_.characterEffect10171ui_story = var_564_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_13 = 0.200000002980232

			if var_564_12 <= arg_561_1.time_ and arg_561_1.time_ < var_564_12 + var_564_13 and not isNil(var_564_11) then
				local var_564_14 = (arg_561_1.time_ - var_564_12) / var_564_13

				if arg_561_1.var_.characterEffect10171ui_story and not isNil(var_564_11) then
					arg_561_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= var_564_12 + var_564_13 and arg_561_1.time_ < var_564_12 + var_564_13 + arg_564_0 and not isNil(var_564_11) and arg_561_1.var_.characterEffect10171ui_story then
				arg_561_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_564_15 = 0

			if var_564_15 < arg_561_1.time_ and arg_561_1.time_ <= var_564_15 + arg_564_0 then
				arg_561_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_564_16 = 0

			if var_564_16 < arg_561_1.time_ and arg_561_1.time_ <= var_564_16 + arg_564_0 then
				arg_561_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_564_17 = 0
			local var_564_18 = 0.3

			if var_564_17 < arg_561_1.time_ and arg_561_1.time_ <= var_564_17 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_19 = arg_561_1:FormatText(StoryNameCfg[1451].name)

				arg_561_1.leftNameTxt_.text = var_564_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_20 = arg_561_1:GetWordFromCfg(324151129)
				local var_564_21 = arg_561_1:FormatText(var_564_20.content)

				arg_561_1.text_.text = var_564_21

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_22 = 12
				local var_564_23 = utf8.len(var_564_21)
				local var_564_24 = var_564_22 <= 0 and var_564_18 or var_564_18 * (var_564_23 / var_564_22)

				if var_564_24 > 0 and var_564_18 < var_564_24 then
					arg_561_1.talkMaxDuration = var_564_24

					if var_564_24 + var_564_17 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_24 + var_564_17
					end
				end

				arg_561_1.text_.text = var_564_21
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151129", "story_v_out_324151.awb") ~= 0 then
					local var_564_25 = manager.audio:GetVoiceLength("story_v_out_324151", "324151129", "story_v_out_324151.awb") / 1000

					if var_564_25 + var_564_17 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_25 + var_564_17
					end

					if var_564_20.prefab_name ~= "" and arg_561_1.actors_[var_564_20.prefab_name] ~= nil then
						local var_564_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_20.prefab_name].transform, "story_v_out_324151", "324151129", "story_v_out_324151.awb")

						arg_561_1:RecordAudio("324151129", var_564_26)
						arg_561_1:RecordAudio("324151129", var_564_26)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_324151", "324151129", "story_v_out_324151.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_324151", "324151129", "story_v_out_324151.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_27 = math.max(var_564_18, arg_561_1.talkMaxDuration)

			if var_564_17 <= arg_561_1.time_ and arg_561_1.time_ < var_564_17 + var_564_27 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_17) / var_564_27

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_17 + var_564_27 and arg_561_1.time_ < var_564_17 + var_564_27 + arg_564_0 then
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
			local var_568_0 = 0
			local var_568_1 = 1.075

			if var_568_0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_2 = arg_565_1:FormatText(StoryNameCfg[1451].name)

				arg_565_1.leftNameTxt_.text = var_568_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_3 = arg_565_1:GetWordFromCfg(324151130)
				local var_568_4 = arg_565_1:FormatText(var_568_3.content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 43
				local var_568_6 = utf8.len(var_568_4)
				local var_568_7 = var_568_5 <= 0 and var_568_1 or var_568_1 * (var_568_6 / var_568_5)

				if var_568_7 > 0 and var_568_1 < var_568_7 then
					arg_565_1.talkMaxDuration = var_568_7

					if var_568_7 + var_568_0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_0
					end
				end

				arg_565_1.text_.text = var_568_4
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151130", "story_v_out_324151.awb") ~= 0 then
					local var_568_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151130", "story_v_out_324151.awb") / 1000

					if var_568_8 + var_568_0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_8 + var_568_0
					end

					if var_568_3.prefab_name ~= "" and arg_565_1.actors_[var_568_3.prefab_name] ~= nil then
						local var_568_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_3.prefab_name].transform, "story_v_out_324151", "324151130", "story_v_out_324151.awb")

						arg_565_1:RecordAudio("324151130", var_568_9)
						arg_565_1:RecordAudio("324151130", var_568_9)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_324151", "324151130", "story_v_out_324151.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_324151", "324151130", "story_v_out_324151.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_10 = math.max(var_568_1, arg_565_1.talkMaxDuration)

			if var_568_0 <= arg_565_1.time_ and arg_565_1.time_ < var_568_0 + var_568_10 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_0) / var_568_10

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_0 + var_568_10 and arg_565_1.time_ < var_568_0 + var_568_10 + arg_568_0 then
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
			local var_572_0 = 0

			if var_572_0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_0 + arg_572_0 then
				arg_569_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 then
				arg_569_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_572_2 = 0
			local var_572_3 = 0.5

			if var_572_2 < arg_569_1.time_ and arg_569_1.time_ <= var_572_2 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_4 = arg_569_1:FormatText(StoryNameCfg[1451].name)

				arg_569_1.leftNameTxt_.text = var_572_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_5 = arg_569_1:GetWordFromCfg(324151131)
				local var_572_6 = arg_569_1:FormatText(var_572_5.content)

				arg_569_1.text_.text = var_572_6

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_7 = 20
				local var_572_8 = utf8.len(var_572_6)
				local var_572_9 = var_572_7 <= 0 and var_572_3 or var_572_3 * (var_572_8 / var_572_7)

				if var_572_9 > 0 and var_572_3 < var_572_9 then
					arg_569_1.talkMaxDuration = var_572_9

					if var_572_9 + var_572_2 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_9 + var_572_2
					end
				end

				arg_569_1.text_.text = var_572_6
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151131", "story_v_out_324151.awb") ~= 0 then
					local var_572_10 = manager.audio:GetVoiceLength("story_v_out_324151", "324151131", "story_v_out_324151.awb") / 1000

					if var_572_10 + var_572_2 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_10 + var_572_2
					end

					if var_572_5.prefab_name ~= "" and arg_569_1.actors_[var_572_5.prefab_name] ~= nil then
						local var_572_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_5.prefab_name].transform, "story_v_out_324151", "324151131", "story_v_out_324151.awb")

						arg_569_1:RecordAudio("324151131", var_572_11)
						arg_569_1:RecordAudio("324151131", var_572_11)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_out_324151", "324151131", "story_v_out_324151.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_out_324151", "324151131", "story_v_out_324151.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_12 = math.max(var_572_3, arg_569_1.talkMaxDuration)

			if var_572_2 <= arg_569_1.time_ and arg_569_1.time_ < var_572_2 + var_572_12 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_2) / var_572_12

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_2 + var_572_12 and arg_569_1.time_ < var_572_2 + var_572_12 + arg_572_0 then
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
			local var_576_0 = arg_573_1.actors_["10171ui_story"].transform
			local var_576_1 = 0

			if var_576_1 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 then
				arg_573_1.var_.moveOldPos10171ui_story = var_576_0.localPosition

				local var_576_2 = GameObjectTools.GetOrAddComponent(var_576_0.gameObject, typeof(DynamicBoneHelper))

				if var_576_2 then
					var_576_2:EnableDynamicBone(false)
				end
			end

			local var_576_3 = 0.001

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_3 then
				local var_576_4 = (arg_573_1.time_ - var_576_1) / var_576_3
				local var_576_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_576_0.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos10171ui_story, var_576_5, var_576_4)

				local var_576_6 = manager.ui.mainCamera.transform.position - var_576_0.position

				var_576_0.forward = Vector3.New(var_576_6.x, var_576_6.y, var_576_6.z)

				local var_576_7 = var_576_0.localEulerAngles

				var_576_7.z = 0
				var_576_7.x = 0
				var_576_0.localEulerAngles = var_576_7
			end

			if arg_573_1.time_ >= var_576_1 + var_576_3 and arg_573_1.time_ < var_576_1 + var_576_3 + arg_576_0 then
				var_576_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_576_8 = manager.ui.mainCamera.transform.position - var_576_0.position

				var_576_0.forward = Vector3.New(var_576_8.x, var_576_8.y, var_576_8.z)

				local var_576_9 = var_576_0.localEulerAngles

				var_576_9.z = 0
				var_576_9.x = 0
				var_576_0.localEulerAngles = var_576_9

				local var_576_10 = GameObjectTools.GetOrAddComponent(var_576_0.gameObject, typeof(DynamicBoneHelper))

				if var_576_10 then
					var_576_10:EnableDynamicBone(true)
				end
			end

			local var_576_11 = arg_573_1.actors_["1072ui_story"].transform
			local var_576_12 = 0

			if var_576_12 < arg_573_1.time_ and arg_573_1.time_ <= var_576_12 + arg_576_0 then
				arg_573_1.var_.moveOldPos1072ui_story = var_576_11.localPosition
			end

			local var_576_13 = 0.001

			if var_576_12 <= arg_573_1.time_ and arg_573_1.time_ < var_576_12 + var_576_13 then
				local var_576_14 = (arg_573_1.time_ - var_576_12) / var_576_13
				local var_576_15 = Vector3.New(0.7, -0.71, -6)

				var_576_11.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1072ui_story, var_576_15, var_576_14)

				local var_576_16 = manager.ui.mainCamera.transform.position - var_576_11.position

				var_576_11.forward = Vector3.New(var_576_16.x, var_576_16.y, var_576_16.z)

				local var_576_17 = var_576_11.localEulerAngles

				var_576_17.z = 0
				var_576_17.x = 0
				var_576_11.localEulerAngles = var_576_17
			end

			if arg_573_1.time_ >= var_576_12 + var_576_13 and arg_573_1.time_ < var_576_12 + var_576_13 + arg_576_0 then
				var_576_11.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_576_18 = manager.ui.mainCamera.transform.position - var_576_11.position

				var_576_11.forward = Vector3.New(var_576_18.x, var_576_18.y, var_576_18.z)

				local var_576_19 = var_576_11.localEulerAngles

				var_576_19.z = 0
				var_576_19.x = 0
				var_576_11.localEulerAngles = var_576_19
			end

			local var_576_20 = arg_573_1.actors_["1072ui_story"]
			local var_576_21 = 0

			if var_576_21 < arg_573_1.time_ and arg_573_1.time_ <= var_576_21 + arg_576_0 and not isNil(var_576_20) and arg_573_1.var_.characterEffect1072ui_story == nil then
				arg_573_1.var_.characterEffect1072ui_story = var_576_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_22 = 0.200000002980232

			if var_576_21 <= arg_573_1.time_ and arg_573_1.time_ < var_576_21 + var_576_22 and not isNil(var_576_20) then
				local var_576_23 = (arg_573_1.time_ - var_576_21) / var_576_22

				if arg_573_1.var_.characterEffect1072ui_story and not isNil(var_576_20) then
					arg_573_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= var_576_21 + var_576_22 and arg_573_1.time_ < var_576_21 + var_576_22 + arg_576_0 and not isNil(var_576_20) and arg_573_1.var_.characterEffect1072ui_story then
				arg_573_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_576_24 = arg_573_1.actors_["10171ui_story"]
			local var_576_25 = 0

			if var_576_25 < arg_573_1.time_ and arg_573_1.time_ <= var_576_25 + arg_576_0 and not isNil(var_576_24) and arg_573_1.var_.characterEffect10171ui_story == nil then
				arg_573_1.var_.characterEffect10171ui_story = var_576_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_26 = 0.200000002980232

			if var_576_25 <= arg_573_1.time_ and arg_573_1.time_ < var_576_25 + var_576_26 and not isNil(var_576_24) then
				local var_576_27 = (arg_573_1.time_ - var_576_25) / var_576_26

				if arg_573_1.var_.characterEffect10171ui_story and not isNil(var_576_24) then
					local var_576_28 = Mathf.Lerp(0, 0.5, var_576_27)

					arg_573_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_573_1.var_.characterEffect10171ui_story.fillRatio = var_576_28
				end
			end

			if arg_573_1.time_ >= var_576_25 + var_576_26 and arg_573_1.time_ < var_576_25 + var_576_26 + arg_576_0 and not isNil(var_576_24) and arg_573_1.var_.characterEffect10171ui_story then
				local var_576_29 = 0.5

				arg_573_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_573_1.var_.characterEffect10171ui_story.fillRatio = var_576_29
			end

			local var_576_30 = 0
			local var_576_31 = 0.125

			if var_576_30 < arg_573_1.time_ and arg_573_1.time_ <= var_576_30 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_32 = arg_573_1:FormatText(StoryNameCfg[379].name)

				arg_573_1.leftNameTxt_.text = var_576_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_33 = arg_573_1:GetWordFromCfg(324151132)
				local var_576_34 = arg_573_1:FormatText(var_576_33.content)

				arg_573_1.text_.text = var_576_34

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_35 = 5
				local var_576_36 = utf8.len(var_576_34)
				local var_576_37 = var_576_35 <= 0 and var_576_31 or var_576_31 * (var_576_36 / var_576_35)

				if var_576_37 > 0 and var_576_31 < var_576_37 then
					arg_573_1.talkMaxDuration = var_576_37

					if var_576_37 + var_576_30 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_37 + var_576_30
					end
				end

				arg_573_1.text_.text = var_576_34
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151132", "story_v_out_324151.awb") ~= 0 then
					local var_576_38 = manager.audio:GetVoiceLength("story_v_out_324151", "324151132", "story_v_out_324151.awb") / 1000

					if var_576_38 + var_576_30 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_38 + var_576_30
					end

					if var_576_33.prefab_name ~= "" and arg_573_1.actors_[var_576_33.prefab_name] ~= nil then
						local var_576_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_33.prefab_name].transform, "story_v_out_324151", "324151132", "story_v_out_324151.awb")

						arg_573_1:RecordAudio("324151132", var_576_39)
						arg_573_1:RecordAudio("324151132", var_576_39)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_out_324151", "324151132", "story_v_out_324151.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_out_324151", "324151132", "story_v_out_324151.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_40 = math.max(var_576_31, arg_573_1.talkMaxDuration)

			if var_576_30 <= arg_573_1.time_ and arg_573_1.time_ < var_576_30 + var_576_40 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_30) / var_576_40

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_30 + var_576_40 and arg_573_1.time_ < var_576_30 + var_576_40 + arg_576_0 then
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
			local var_580_0 = arg_577_1.actors_["10171ui_story"].transform
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 then
				arg_577_1.var_.moveOldPos10171ui_story = var_580_0.localPosition

				local var_580_2 = GameObjectTools.GetOrAddComponent(var_580_0.gameObject, typeof(DynamicBoneHelper))

				if var_580_2 then
					var_580_2:EnableDynamicBone(false)
				end
			end

			local var_580_3 = 0.001

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_3 then
				local var_580_4 = (arg_577_1.time_ - var_580_1) / var_580_3
				local var_580_5 = Vector3.New(0, 100, 0)

				var_580_0.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos10171ui_story, var_580_5, var_580_4)

				local var_580_6 = manager.ui.mainCamera.transform.position - var_580_0.position

				var_580_0.forward = Vector3.New(var_580_6.x, var_580_6.y, var_580_6.z)

				local var_580_7 = var_580_0.localEulerAngles

				var_580_7.z = 0
				var_580_7.x = 0
				var_580_0.localEulerAngles = var_580_7
			end

			if arg_577_1.time_ >= var_580_1 + var_580_3 and arg_577_1.time_ < var_580_1 + var_580_3 + arg_580_0 then
				var_580_0.localPosition = Vector3.New(0, 100, 0)

				local var_580_8 = manager.ui.mainCamera.transform.position - var_580_0.position

				var_580_0.forward = Vector3.New(var_580_8.x, var_580_8.y, var_580_8.z)

				local var_580_9 = var_580_0.localEulerAngles

				var_580_9.z = 0
				var_580_9.x = 0
				var_580_0.localEulerAngles = var_580_9

				local var_580_10 = GameObjectTools.GetOrAddComponent(var_580_0.gameObject, typeof(DynamicBoneHelper))

				if var_580_10 then
					var_580_10:EnableDynamicBone(true)
				end
			end

			local var_580_11 = arg_577_1.actors_["1072ui_story"].transform
			local var_580_12 = 0

			if var_580_12 < arg_577_1.time_ and arg_577_1.time_ <= var_580_12 + arg_580_0 then
				arg_577_1.var_.moveOldPos1072ui_story = var_580_11.localPosition
			end

			local var_580_13 = 0.001

			if var_580_12 <= arg_577_1.time_ and arg_577_1.time_ < var_580_12 + var_580_13 then
				local var_580_14 = (arg_577_1.time_ - var_580_12) / var_580_13
				local var_580_15 = Vector3.New(0, 100, 0)

				var_580_11.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1072ui_story, var_580_15, var_580_14)

				local var_580_16 = manager.ui.mainCamera.transform.position - var_580_11.position

				var_580_11.forward = Vector3.New(var_580_16.x, var_580_16.y, var_580_16.z)

				local var_580_17 = var_580_11.localEulerAngles

				var_580_17.z = 0
				var_580_17.x = 0
				var_580_11.localEulerAngles = var_580_17
			end

			if arg_577_1.time_ >= var_580_12 + var_580_13 and arg_577_1.time_ < var_580_12 + var_580_13 + arg_580_0 then
				var_580_11.localPosition = Vector3.New(0, 100, 0)

				local var_580_18 = manager.ui.mainCamera.transform.position - var_580_11.position

				var_580_11.forward = Vector3.New(var_580_18.x, var_580_18.y, var_580_18.z)

				local var_580_19 = var_580_11.localEulerAngles

				var_580_19.z = 0
				var_580_19.x = 0
				var_580_11.localEulerAngles = var_580_19
			end

			local var_580_20 = arg_577_1.actors_["1072ui_story"]
			local var_580_21 = 0

			if var_580_21 < arg_577_1.time_ and arg_577_1.time_ <= var_580_21 + arg_580_0 and not isNil(var_580_20) and arg_577_1.var_.characterEffect1072ui_story == nil then
				arg_577_1.var_.characterEffect1072ui_story = var_580_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_22 = 0.200000002980232

			if var_580_21 <= arg_577_1.time_ and arg_577_1.time_ < var_580_21 + var_580_22 and not isNil(var_580_20) then
				local var_580_23 = (arg_577_1.time_ - var_580_21) / var_580_22

				if arg_577_1.var_.characterEffect1072ui_story and not isNil(var_580_20) then
					local var_580_24 = Mathf.Lerp(0, 0.5, var_580_23)

					arg_577_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1072ui_story.fillRatio = var_580_24
				end
			end

			if arg_577_1.time_ >= var_580_21 + var_580_22 and arg_577_1.time_ < var_580_21 + var_580_22 + arg_580_0 and not isNil(var_580_20) and arg_577_1.var_.characterEffect1072ui_story then
				local var_580_25 = 0.5

				arg_577_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1072ui_story.fillRatio = var_580_25
			end

			local var_580_26 = 0
			local var_580_27 = 0.6

			if var_580_26 < arg_577_1.time_ and arg_577_1.time_ <= var_580_26 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_28 = arg_577_1:GetWordFromCfg(324151133)
				local var_580_29 = arg_577_1:FormatText(var_580_28.content)

				arg_577_1.text_.text = var_580_29

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_30 = 24
				local var_580_31 = utf8.len(var_580_29)
				local var_580_32 = var_580_30 <= 0 and var_580_27 or var_580_27 * (var_580_31 / var_580_30)

				if var_580_32 > 0 and var_580_27 < var_580_32 then
					arg_577_1.talkMaxDuration = var_580_32

					if var_580_32 + var_580_26 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_32 + var_580_26
					end
				end

				arg_577_1.text_.text = var_580_29
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_33 = math.max(var_580_27, arg_577_1.talkMaxDuration)

			if var_580_26 <= arg_577_1.time_ and arg_577_1.time_ < var_580_26 + var_580_33 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_26) / var_580_33

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_26 + var_580_33 and arg_577_1.time_ < var_580_26 + var_580_33 + arg_580_0 then
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
			local var_584_0 = arg_581_1.actors_["1072ui_story"].transform
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 then
				arg_581_1.var_.moveOldPos1072ui_story = var_584_0.localPosition
			end

			local var_584_2 = 0.001

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2
				local var_584_4 = Vector3.New(-0.7, -0.71, -6)

				var_584_0.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1072ui_story, var_584_4, var_584_3)

				local var_584_5 = manager.ui.mainCamera.transform.position - var_584_0.position

				var_584_0.forward = Vector3.New(var_584_5.x, var_584_5.y, var_584_5.z)

				local var_584_6 = var_584_0.localEulerAngles

				var_584_6.z = 0
				var_584_6.x = 0
				var_584_0.localEulerAngles = var_584_6
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 then
				var_584_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_584_7 = manager.ui.mainCamera.transform.position - var_584_0.position

				var_584_0.forward = Vector3.New(var_584_7.x, var_584_7.y, var_584_7.z)

				local var_584_8 = var_584_0.localEulerAngles

				var_584_8.z = 0
				var_584_8.x = 0
				var_584_0.localEulerAngles = var_584_8
			end

			local var_584_9 = arg_581_1.actors_["1072ui_story"]
			local var_584_10 = 0

			if var_584_10 < arg_581_1.time_ and arg_581_1.time_ <= var_584_10 + arg_584_0 and not isNil(var_584_9) and arg_581_1.var_.characterEffect1072ui_story == nil then
				arg_581_1.var_.characterEffect1072ui_story = var_584_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_11 = 0.200000002980232

			if var_584_10 <= arg_581_1.time_ and arg_581_1.time_ < var_584_10 + var_584_11 and not isNil(var_584_9) then
				local var_584_12 = (arg_581_1.time_ - var_584_10) / var_584_11

				if arg_581_1.var_.characterEffect1072ui_story and not isNil(var_584_9) then
					arg_581_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= var_584_10 + var_584_11 and arg_581_1.time_ < var_584_10 + var_584_11 + arg_584_0 and not isNil(var_584_9) and arg_581_1.var_.characterEffect1072ui_story then
				arg_581_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_584_13 = 0

			if var_584_13 < arg_581_1.time_ and arg_581_1.time_ <= var_584_13 + arg_584_0 then
				arg_581_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			local var_584_14 = 0

			if var_584_14 < arg_581_1.time_ and arg_581_1.time_ <= var_584_14 + arg_584_0 then
				arg_581_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_584_15 = 0
			local var_584_16 = 0.55

			if var_584_15 < arg_581_1.time_ and arg_581_1.time_ <= var_584_15 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_17 = arg_581_1:FormatText(StoryNameCfg[379].name)

				arg_581_1.leftNameTxt_.text = var_584_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_18 = arg_581_1:GetWordFromCfg(324151134)
				local var_584_19 = arg_581_1:FormatText(var_584_18.content)

				arg_581_1.text_.text = var_584_19

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_20 = 22
				local var_584_21 = utf8.len(var_584_19)
				local var_584_22 = var_584_20 <= 0 and var_584_16 or var_584_16 * (var_584_21 / var_584_20)

				if var_584_22 > 0 and var_584_16 < var_584_22 then
					arg_581_1.talkMaxDuration = var_584_22

					if var_584_22 + var_584_15 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_22 + var_584_15
					end
				end

				arg_581_1.text_.text = var_584_19
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151134", "story_v_out_324151.awb") ~= 0 then
					local var_584_23 = manager.audio:GetVoiceLength("story_v_out_324151", "324151134", "story_v_out_324151.awb") / 1000

					if var_584_23 + var_584_15 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_23 + var_584_15
					end

					if var_584_18.prefab_name ~= "" and arg_581_1.actors_[var_584_18.prefab_name] ~= nil then
						local var_584_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_18.prefab_name].transform, "story_v_out_324151", "324151134", "story_v_out_324151.awb")

						arg_581_1:RecordAudio("324151134", var_584_24)
						arg_581_1:RecordAudio("324151134", var_584_24)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_324151", "324151134", "story_v_out_324151.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_324151", "324151134", "story_v_out_324151.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_25 = math.max(var_584_16, arg_581_1.talkMaxDuration)

			if var_584_15 <= arg_581_1.time_ and arg_581_1.time_ < var_584_15 + var_584_25 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_15) / var_584_25

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_15 + var_584_25 and arg_581_1.time_ < var_584_15 + var_584_25 + arg_584_0 then
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
			local var_588_0 = 0
			local var_588_1 = 0.4

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_2 = arg_585_1:FormatText(StoryNameCfg[379].name)

				arg_585_1.leftNameTxt_.text = var_588_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_3 = arg_585_1:GetWordFromCfg(324151135)
				local var_588_4 = arg_585_1:FormatText(var_588_3.content)

				arg_585_1.text_.text = var_588_4

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_5 = 16
				local var_588_6 = utf8.len(var_588_4)
				local var_588_7 = var_588_5 <= 0 and var_588_1 or var_588_1 * (var_588_6 / var_588_5)

				if var_588_7 > 0 and var_588_1 < var_588_7 then
					arg_585_1.talkMaxDuration = var_588_7

					if var_588_7 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_7 + var_588_0
					end
				end

				arg_585_1.text_.text = var_588_4
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151135", "story_v_out_324151.awb") ~= 0 then
					local var_588_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151135", "story_v_out_324151.awb") / 1000

					if var_588_8 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_8 + var_588_0
					end

					if var_588_3.prefab_name ~= "" and arg_585_1.actors_[var_588_3.prefab_name] ~= nil then
						local var_588_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_3.prefab_name].transform, "story_v_out_324151", "324151135", "story_v_out_324151.awb")

						arg_585_1:RecordAudio("324151135", var_588_9)
						arg_585_1:RecordAudio("324151135", var_588_9)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_324151", "324151135", "story_v_out_324151.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_324151", "324151135", "story_v_out_324151.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_10 = math.max(var_588_1, arg_585_1.talkMaxDuration)

			if var_588_0 <= arg_585_1.time_ and arg_585_1.time_ < var_588_0 + var_588_10 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_0) / var_588_10

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_0 + var_588_10 and arg_585_1.time_ < var_588_0 + var_588_10 + arg_588_0 then
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
			local var_592_0 = arg_589_1.actors_["10171ui_story"].transform
			local var_592_1 = 0

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.var_.moveOldPos10171ui_story = var_592_0.localPosition

				local var_592_2 = GameObjectTools.GetOrAddComponent(var_592_0.gameObject, typeof(DynamicBoneHelper))

				if var_592_2 then
					var_592_2:EnableDynamicBone(false)
				end
			end

			local var_592_3 = 0.001

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_3 then
				local var_592_4 = (arg_589_1.time_ - var_592_1) / var_592_3
				local var_592_5 = Vector3.New(0.7, -0.95, -6.05)

				var_592_0.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos10171ui_story, var_592_5, var_592_4)

				local var_592_6 = manager.ui.mainCamera.transform.position - var_592_0.position

				var_592_0.forward = Vector3.New(var_592_6.x, var_592_6.y, var_592_6.z)

				local var_592_7 = var_592_0.localEulerAngles

				var_592_7.z = 0
				var_592_7.x = 0
				var_592_0.localEulerAngles = var_592_7
			end

			if arg_589_1.time_ >= var_592_1 + var_592_3 and arg_589_1.time_ < var_592_1 + var_592_3 + arg_592_0 then
				var_592_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_592_8 = manager.ui.mainCamera.transform.position - var_592_0.position

				var_592_0.forward = Vector3.New(var_592_8.x, var_592_8.y, var_592_8.z)

				local var_592_9 = var_592_0.localEulerAngles

				var_592_9.z = 0
				var_592_9.x = 0
				var_592_0.localEulerAngles = var_592_9

				local var_592_10 = GameObjectTools.GetOrAddComponent(var_592_0.gameObject, typeof(DynamicBoneHelper))

				if var_592_10 then
					var_592_10:EnableDynamicBone(true)
				end
			end

			local var_592_11 = arg_589_1.actors_["10171ui_story"]
			local var_592_12 = 0

			if var_592_12 < arg_589_1.time_ and arg_589_1.time_ <= var_592_12 + arg_592_0 and not isNil(var_592_11) and arg_589_1.var_.characterEffect10171ui_story == nil then
				arg_589_1.var_.characterEffect10171ui_story = var_592_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_13 = 0.200000002980232

			if var_592_12 <= arg_589_1.time_ and arg_589_1.time_ < var_592_12 + var_592_13 and not isNil(var_592_11) then
				local var_592_14 = (arg_589_1.time_ - var_592_12) / var_592_13

				if arg_589_1.var_.characterEffect10171ui_story and not isNil(var_592_11) then
					arg_589_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_589_1.time_ >= var_592_12 + var_592_13 and arg_589_1.time_ < var_592_12 + var_592_13 + arg_592_0 and not isNil(var_592_11) and arg_589_1.var_.characterEffect10171ui_story then
				arg_589_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_592_15 = arg_589_1.actors_["1072ui_story"]
			local var_592_16 = 0

			if var_592_16 < arg_589_1.time_ and arg_589_1.time_ <= var_592_16 + arg_592_0 and not isNil(var_592_15) and arg_589_1.var_.characterEffect1072ui_story == nil then
				arg_589_1.var_.characterEffect1072ui_story = var_592_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_17 = 0.200000002980232

			if var_592_16 <= arg_589_1.time_ and arg_589_1.time_ < var_592_16 + var_592_17 and not isNil(var_592_15) then
				local var_592_18 = (arg_589_1.time_ - var_592_16) / var_592_17

				if arg_589_1.var_.characterEffect1072ui_story and not isNil(var_592_15) then
					local var_592_19 = Mathf.Lerp(0, 0.5, var_592_18)

					arg_589_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_589_1.var_.characterEffect1072ui_story.fillRatio = var_592_19
				end
			end

			if arg_589_1.time_ >= var_592_16 + var_592_17 and arg_589_1.time_ < var_592_16 + var_592_17 + arg_592_0 and not isNil(var_592_15) and arg_589_1.var_.characterEffect1072ui_story then
				local var_592_20 = 0.5

				arg_589_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_589_1.var_.characterEffect1072ui_story.fillRatio = var_592_20
			end

			local var_592_21 = 0

			if var_592_21 < arg_589_1.time_ and arg_589_1.time_ <= var_592_21 + arg_592_0 then
				arg_589_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			local var_592_22 = 0

			if var_592_22 < arg_589_1.time_ and arg_589_1.time_ <= var_592_22 + arg_592_0 then
				arg_589_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_592_23 = 0
			local var_592_24 = 0.775

			if var_592_23 < arg_589_1.time_ and arg_589_1.time_ <= var_592_23 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_25 = arg_589_1:FormatText(StoryNameCfg[1451].name)

				arg_589_1.leftNameTxt_.text = var_592_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_26 = arg_589_1:GetWordFromCfg(324151136)
				local var_592_27 = arg_589_1:FormatText(var_592_26.content)

				arg_589_1.text_.text = var_592_27

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_28 = 31
				local var_592_29 = utf8.len(var_592_27)
				local var_592_30 = var_592_28 <= 0 and var_592_24 or var_592_24 * (var_592_29 / var_592_28)

				if var_592_30 > 0 and var_592_24 < var_592_30 then
					arg_589_1.talkMaxDuration = var_592_30

					if var_592_30 + var_592_23 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_30 + var_592_23
					end
				end

				arg_589_1.text_.text = var_592_27
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151136", "story_v_out_324151.awb") ~= 0 then
					local var_592_31 = manager.audio:GetVoiceLength("story_v_out_324151", "324151136", "story_v_out_324151.awb") / 1000

					if var_592_31 + var_592_23 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_31 + var_592_23
					end

					if var_592_26.prefab_name ~= "" and arg_589_1.actors_[var_592_26.prefab_name] ~= nil then
						local var_592_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_26.prefab_name].transform, "story_v_out_324151", "324151136", "story_v_out_324151.awb")

						arg_589_1:RecordAudio("324151136", var_592_32)
						arg_589_1:RecordAudio("324151136", var_592_32)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_324151", "324151136", "story_v_out_324151.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_324151", "324151136", "story_v_out_324151.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_33 = math.max(var_592_24, arg_589_1.talkMaxDuration)

			if var_592_23 <= arg_589_1.time_ and arg_589_1.time_ < var_592_23 + var_592_33 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_23) / var_592_33

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_23 + var_592_33 and arg_589_1.time_ < var_592_23 + var_592_33 + arg_592_0 then
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
			local var_596_0 = arg_593_1.actors_["1072ui_story"]
			local var_596_1 = 0

			if var_596_1 < arg_593_1.time_ and arg_593_1.time_ <= var_596_1 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect1072ui_story == nil then
				arg_593_1.var_.characterEffect1072ui_story = var_596_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_2 = 0.200000002980232

			if var_596_1 <= arg_593_1.time_ and arg_593_1.time_ < var_596_1 + var_596_2 and not isNil(var_596_0) then
				local var_596_3 = (arg_593_1.time_ - var_596_1) / var_596_2

				if arg_593_1.var_.characterEffect1072ui_story and not isNil(var_596_0) then
					arg_593_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_593_1.time_ >= var_596_1 + var_596_2 and arg_593_1.time_ < var_596_1 + var_596_2 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect1072ui_story then
				arg_593_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_596_4 = arg_593_1.actors_["10171ui_story"]
			local var_596_5 = 0

			if var_596_5 < arg_593_1.time_ and arg_593_1.time_ <= var_596_5 + arg_596_0 and not isNil(var_596_4) and arg_593_1.var_.characterEffect10171ui_story == nil then
				arg_593_1.var_.characterEffect10171ui_story = var_596_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_6 = 0.200000002980232

			if var_596_5 <= arg_593_1.time_ and arg_593_1.time_ < var_596_5 + var_596_6 and not isNil(var_596_4) then
				local var_596_7 = (arg_593_1.time_ - var_596_5) / var_596_6

				if arg_593_1.var_.characterEffect10171ui_story and not isNil(var_596_4) then
					local var_596_8 = Mathf.Lerp(0, 0.5, var_596_7)

					arg_593_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_593_1.var_.characterEffect10171ui_story.fillRatio = var_596_8
				end
			end

			if arg_593_1.time_ >= var_596_5 + var_596_6 and arg_593_1.time_ < var_596_5 + var_596_6 + arg_596_0 and not isNil(var_596_4) and arg_593_1.var_.characterEffect10171ui_story then
				local var_596_9 = 0.5

				arg_593_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_593_1.var_.characterEffect10171ui_story.fillRatio = var_596_9
			end

			local var_596_10 = 0

			if var_596_10 < arg_593_1.time_ and arg_593_1.time_ <= var_596_10 + arg_596_0 then
				arg_593_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action424")
			end

			local var_596_11 = 0
			local var_596_12 = 0.55

			if var_596_11 < arg_593_1.time_ and arg_593_1.time_ <= var_596_11 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_13 = arg_593_1:FormatText(StoryNameCfg[379].name)

				arg_593_1.leftNameTxt_.text = var_596_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_14 = arg_593_1:GetWordFromCfg(324151137)
				local var_596_15 = arg_593_1:FormatText(var_596_14.content)

				arg_593_1.text_.text = var_596_15

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_16 = 22
				local var_596_17 = utf8.len(var_596_15)
				local var_596_18 = var_596_16 <= 0 and var_596_12 or var_596_12 * (var_596_17 / var_596_16)

				if var_596_18 > 0 and var_596_12 < var_596_18 then
					arg_593_1.talkMaxDuration = var_596_18

					if var_596_18 + var_596_11 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_18 + var_596_11
					end
				end

				arg_593_1.text_.text = var_596_15
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151137", "story_v_out_324151.awb") ~= 0 then
					local var_596_19 = manager.audio:GetVoiceLength("story_v_out_324151", "324151137", "story_v_out_324151.awb") / 1000

					if var_596_19 + var_596_11 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_19 + var_596_11
					end

					if var_596_14.prefab_name ~= "" and arg_593_1.actors_[var_596_14.prefab_name] ~= nil then
						local var_596_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_14.prefab_name].transform, "story_v_out_324151", "324151137", "story_v_out_324151.awb")

						arg_593_1:RecordAudio("324151137", var_596_20)
						arg_593_1:RecordAudio("324151137", var_596_20)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_out_324151", "324151137", "story_v_out_324151.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_out_324151", "324151137", "story_v_out_324151.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_21 = math.max(var_596_12, arg_593_1.talkMaxDuration)

			if var_596_11 <= arg_593_1.time_ and arg_593_1.time_ < var_596_11 + var_596_21 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_11) / var_596_21

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_11 + var_596_21 and arg_593_1.time_ < var_596_11 + var_596_21 + arg_596_0 then
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
			local var_600_0 = 0

			if var_600_0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_600_1 = 0
			local var_600_2 = 0.3

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_3 = arg_597_1:FormatText(StoryNameCfg[379].name)

				arg_597_1.leftNameTxt_.text = var_600_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_4 = arg_597_1:GetWordFromCfg(324151138)
				local var_600_5 = arg_597_1:FormatText(var_600_4.content)

				arg_597_1.text_.text = var_600_5

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_6 = 12
				local var_600_7 = utf8.len(var_600_5)
				local var_600_8 = var_600_6 <= 0 and var_600_2 or var_600_2 * (var_600_7 / var_600_6)

				if var_600_8 > 0 and var_600_2 < var_600_8 then
					arg_597_1.talkMaxDuration = var_600_8

					if var_600_8 + var_600_1 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_8 + var_600_1
					end
				end

				arg_597_1.text_.text = var_600_5
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151138", "story_v_out_324151.awb") ~= 0 then
					local var_600_9 = manager.audio:GetVoiceLength("story_v_out_324151", "324151138", "story_v_out_324151.awb") / 1000

					if var_600_9 + var_600_1 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_9 + var_600_1
					end

					if var_600_4.prefab_name ~= "" and arg_597_1.actors_[var_600_4.prefab_name] ~= nil then
						local var_600_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_4.prefab_name].transform, "story_v_out_324151", "324151138", "story_v_out_324151.awb")

						arg_597_1:RecordAudio("324151138", var_600_10)
						arg_597_1:RecordAudio("324151138", var_600_10)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_324151", "324151138", "story_v_out_324151.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_324151", "324151138", "story_v_out_324151.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_11 = math.max(var_600_2, arg_597_1.talkMaxDuration)

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_11 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_1) / var_600_11

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_1 + var_600_11 and arg_597_1.time_ < var_600_1 + var_600_11 + arg_600_0 then
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
			local var_604_0 = arg_601_1.actors_["1072ui_story"].transform
			local var_604_1 = 0

			if var_604_1 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 then
				arg_601_1.var_.moveOldPos1072ui_story = var_604_0.localPosition
			end

			local var_604_2 = 0.001

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_2 then
				local var_604_3 = (arg_601_1.time_ - var_604_1) / var_604_2
				local var_604_4 = Vector3.New(0, 100, 0)

				var_604_0.localPosition = Vector3.Lerp(arg_601_1.var_.moveOldPos1072ui_story, var_604_4, var_604_3)

				local var_604_5 = manager.ui.mainCamera.transform.position - var_604_0.position

				var_604_0.forward = Vector3.New(var_604_5.x, var_604_5.y, var_604_5.z)

				local var_604_6 = var_604_0.localEulerAngles

				var_604_6.z = 0
				var_604_6.x = 0
				var_604_0.localEulerAngles = var_604_6
			end

			if arg_601_1.time_ >= var_604_1 + var_604_2 and arg_601_1.time_ < var_604_1 + var_604_2 + arg_604_0 then
				var_604_0.localPosition = Vector3.New(0, 100, 0)

				local var_604_7 = manager.ui.mainCamera.transform.position - var_604_0.position

				var_604_0.forward = Vector3.New(var_604_7.x, var_604_7.y, var_604_7.z)

				local var_604_8 = var_604_0.localEulerAngles

				var_604_8.z = 0
				var_604_8.x = 0
				var_604_0.localEulerAngles = var_604_8
			end

			local var_604_9 = arg_601_1.actors_["10171ui_story"].transform
			local var_604_10 = 0

			if var_604_10 < arg_601_1.time_ and arg_601_1.time_ <= var_604_10 + arg_604_0 then
				arg_601_1.var_.moveOldPos10171ui_story = var_604_9.localPosition

				local var_604_11 = GameObjectTools.GetOrAddComponent(var_604_9.gameObject, typeof(DynamicBoneHelper))

				if var_604_11 then
					var_604_11:EnableDynamicBone(false)
				end
			end

			local var_604_12 = 0.001

			if var_604_10 <= arg_601_1.time_ and arg_601_1.time_ < var_604_10 + var_604_12 then
				local var_604_13 = (arg_601_1.time_ - var_604_10) / var_604_12
				local var_604_14 = Vector3.New(0, 100, 0)

				var_604_9.localPosition = Vector3.Lerp(arg_601_1.var_.moveOldPos10171ui_story, var_604_14, var_604_13)

				local var_604_15 = manager.ui.mainCamera.transform.position - var_604_9.position

				var_604_9.forward = Vector3.New(var_604_15.x, var_604_15.y, var_604_15.z)

				local var_604_16 = var_604_9.localEulerAngles

				var_604_16.z = 0
				var_604_16.x = 0
				var_604_9.localEulerAngles = var_604_16
			end

			if arg_601_1.time_ >= var_604_10 + var_604_12 and arg_601_1.time_ < var_604_10 + var_604_12 + arg_604_0 then
				var_604_9.localPosition = Vector3.New(0, 100, 0)

				local var_604_17 = manager.ui.mainCamera.transform.position - var_604_9.position

				var_604_9.forward = Vector3.New(var_604_17.x, var_604_17.y, var_604_17.z)

				local var_604_18 = var_604_9.localEulerAngles

				var_604_18.z = 0
				var_604_18.x = 0
				var_604_9.localEulerAngles = var_604_18

				local var_604_19 = GameObjectTools.GetOrAddComponent(var_604_9.gameObject, typeof(DynamicBoneHelper))

				if var_604_19 then
					var_604_19:EnableDynamicBone(true)
				end
			end

			local var_604_20 = arg_601_1.actors_["1072ui_story"]
			local var_604_21 = 0

			if var_604_21 < arg_601_1.time_ and arg_601_1.time_ <= var_604_21 + arg_604_0 and not isNil(var_604_20) and arg_601_1.var_.characterEffect1072ui_story == nil then
				arg_601_1.var_.characterEffect1072ui_story = var_604_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_22 = 0.200000002980232

			if var_604_21 <= arg_601_1.time_ and arg_601_1.time_ < var_604_21 + var_604_22 and not isNil(var_604_20) then
				local var_604_23 = (arg_601_1.time_ - var_604_21) / var_604_22

				if arg_601_1.var_.characterEffect1072ui_story and not isNil(var_604_20) then
					local var_604_24 = Mathf.Lerp(0, 0.5, var_604_23)

					arg_601_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_601_1.var_.characterEffect1072ui_story.fillRatio = var_604_24
				end
			end

			if arg_601_1.time_ >= var_604_21 + var_604_22 and arg_601_1.time_ < var_604_21 + var_604_22 + arg_604_0 and not isNil(var_604_20) and arg_601_1.var_.characterEffect1072ui_story then
				local var_604_25 = 0.5

				arg_601_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_601_1.var_.characterEffect1072ui_story.fillRatio = var_604_25
			end

			local var_604_26 = 0.1
			local var_604_27 = 1

			if var_604_26 < arg_601_1.time_ and arg_601_1.time_ <= var_604_26 + arg_604_0 then
				local var_604_28 = "play"
				local var_604_29 = "effect"

				arg_601_1:AudioAction(var_604_28, var_604_29, "se_story_142", "se_story_142_chopper02", "")
			end

			local var_604_30 = 0
			local var_604_31 = 1.4

			if var_604_30 < arg_601_1.time_ and arg_601_1.time_ <= var_604_30 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_32 = arg_601_1:GetWordFromCfg(324151139)
				local var_604_33 = arg_601_1:FormatText(var_604_32.content)

				arg_601_1.text_.text = var_604_33

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_34 = 56
				local var_604_35 = utf8.len(var_604_33)
				local var_604_36 = var_604_34 <= 0 and var_604_31 or var_604_31 * (var_604_35 / var_604_34)

				if var_604_36 > 0 and var_604_31 < var_604_36 then
					arg_601_1.talkMaxDuration = var_604_36

					if var_604_36 + var_604_30 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_36 + var_604_30
					end
				end

				arg_601_1.text_.text = var_604_33
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_37 = math.max(var_604_31, arg_601_1.talkMaxDuration)

			if var_604_30 <= arg_601_1.time_ and arg_601_1.time_ < var_604_30 + var_604_37 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_30) / var_604_37

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_30 + var_604_37 and arg_601_1.time_ < var_604_30 + var_604_37 + arg_604_0 then
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
			local var_608_0 = 0
			local var_608_1 = 0.55

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_2 = arg_605_1:FormatText(StoryNameCfg[1468].name)

				arg_605_1.leftNameTxt_.text = var_608_2

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

				local var_608_3 = arg_605_1:GetWordFromCfg(324151140)
				local var_608_4 = arg_605_1:FormatText(var_608_3.content)

				arg_605_1.text_.text = var_608_4

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_5 = 22
				local var_608_6 = utf8.len(var_608_4)
				local var_608_7 = var_608_5 <= 0 and var_608_1 or var_608_1 * (var_608_6 / var_608_5)

				if var_608_7 > 0 and var_608_1 < var_608_7 then
					arg_605_1.talkMaxDuration = var_608_7

					if var_608_7 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_7 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_4
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151140", "story_v_out_324151.awb") ~= 0 then
					local var_608_8 = manager.audio:GetVoiceLength("story_v_out_324151", "324151140", "story_v_out_324151.awb") / 1000

					if var_608_8 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_8 + var_608_0
					end

					if var_608_3.prefab_name ~= "" and arg_605_1.actors_[var_608_3.prefab_name] ~= nil then
						local var_608_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_3.prefab_name].transform, "story_v_out_324151", "324151140", "story_v_out_324151.awb")

						arg_605_1:RecordAudio("324151140", var_608_9)
						arg_605_1:RecordAudio("324151140", var_608_9)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_out_324151", "324151140", "story_v_out_324151.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_out_324151", "324151140", "story_v_out_324151.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_10 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_10 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_10

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_10 and arg_605_1.time_ < var_608_0 + var_608_10 + arg_608_0 then
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
			local var_612_0 = arg_609_1.actors_["10171ui_story"].transform
			local var_612_1 = 0

			if var_612_1 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 then
				arg_609_1.var_.moveOldPos10171ui_story = var_612_0.localPosition

				local var_612_2 = GameObjectTools.GetOrAddComponent(var_612_0.gameObject, typeof(DynamicBoneHelper))

				if var_612_2 then
					var_612_2:EnableDynamicBone(false)
				end
			end

			local var_612_3 = 0.001

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_3 then
				local var_612_4 = (arg_609_1.time_ - var_612_1) / var_612_3
				local var_612_5 = Vector3.New(0, -0.95, -6.05)

				var_612_0.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos10171ui_story, var_612_5, var_612_4)

				local var_612_6 = manager.ui.mainCamera.transform.position - var_612_0.position

				var_612_0.forward = Vector3.New(var_612_6.x, var_612_6.y, var_612_6.z)

				local var_612_7 = var_612_0.localEulerAngles

				var_612_7.z = 0
				var_612_7.x = 0
				var_612_0.localEulerAngles = var_612_7
			end

			if arg_609_1.time_ >= var_612_1 + var_612_3 and arg_609_1.time_ < var_612_1 + var_612_3 + arg_612_0 then
				var_612_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_612_8 = manager.ui.mainCamera.transform.position - var_612_0.position

				var_612_0.forward = Vector3.New(var_612_8.x, var_612_8.y, var_612_8.z)

				local var_612_9 = var_612_0.localEulerAngles

				var_612_9.z = 0
				var_612_9.x = 0
				var_612_0.localEulerAngles = var_612_9

				local var_612_10 = GameObjectTools.GetOrAddComponent(var_612_0.gameObject, typeof(DynamicBoneHelper))

				if var_612_10 then
					var_612_10:EnableDynamicBone(true)
				end
			end

			local var_612_11 = arg_609_1.actors_["10171ui_story"]
			local var_612_12 = 0

			if var_612_12 < arg_609_1.time_ and arg_609_1.time_ <= var_612_12 + arg_612_0 and not isNil(var_612_11) and arg_609_1.var_.characterEffect10171ui_story == nil then
				arg_609_1.var_.characterEffect10171ui_story = var_612_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_13 = 0.200000002980232

			if var_612_12 <= arg_609_1.time_ and arg_609_1.time_ < var_612_12 + var_612_13 and not isNil(var_612_11) then
				local var_612_14 = (arg_609_1.time_ - var_612_12) / var_612_13

				if arg_609_1.var_.characterEffect10171ui_story and not isNil(var_612_11) then
					arg_609_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_609_1.time_ >= var_612_12 + var_612_13 and arg_609_1.time_ < var_612_12 + var_612_13 + arg_612_0 and not isNil(var_612_11) and arg_609_1.var_.characterEffect10171ui_story then
				arg_609_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_612_15 = 0

			if var_612_15 < arg_609_1.time_ and arg_609_1.time_ <= var_612_15 + arg_612_0 then
				arg_609_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			local var_612_16 = 0

			if var_612_16 < arg_609_1.time_ and arg_609_1.time_ <= var_612_16 + arg_612_0 then
				arg_609_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_612_17 = 0
			local var_612_18 = 0.35

			if var_612_17 < arg_609_1.time_ and arg_609_1.time_ <= var_612_17 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_19 = arg_609_1:FormatText(StoryNameCfg[1451].name)

				arg_609_1.leftNameTxt_.text = var_612_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_20 = arg_609_1:GetWordFromCfg(324151141)
				local var_612_21 = arg_609_1:FormatText(var_612_20.content)

				arg_609_1.text_.text = var_612_21

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_22 = 14
				local var_612_23 = utf8.len(var_612_21)
				local var_612_24 = var_612_22 <= 0 and var_612_18 or var_612_18 * (var_612_23 / var_612_22)

				if var_612_24 > 0 and var_612_18 < var_612_24 then
					arg_609_1.talkMaxDuration = var_612_24

					if var_612_24 + var_612_17 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_24 + var_612_17
					end
				end

				arg_609_1.text_.text = var_612_21
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151141", "story_v_out_324151.awb") ~= 0 then
					local var_612_25 = manager.audio:GetVoiceLength("story_v_out_324151", "324151141", "story_v_out_324151.awb") / 1000

					if var_612_25 + var_612_17 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_25 + var_612_17
					end

					if var_612_20.prefab_name ~= "" and arg_609_1.actors_[var_612_20.prefab_name] ~= nil then
						local var_612_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_20.prefab_name].transform, "story_v_out_324151", "324151141", "story_v_out_324151.awb")

						arg_609_1:RecordAudio("324151141", var_612_26)
						arg_609_1:RecordAudio("324151141", var_612_26)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_out_324151", "324151141", "story_v_out_324151.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_out_324151", "324151141", "story_v_out_324151.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_27 = math.max(var_612_18, arg_609_1.talkMaxDuration)

			if var_612_17 <= arg_609_1.time_ and arg_609_1.time_ < var_612_17 + var_612_27 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_17) / var_612_27

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_17 + var_612_27 and arg_609_1.time_ < var_612_17 + var_612_27 + arg_612_0 then
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
			local var_616_0 = arg_613_1.actors_["10171ui_story"]
			local var_616_1 = 0

			if var_616_1 < arg_613_1.time_ and arg_613_1.time_ <= var_616_1 + arg_616_0 and not isNil(var_616_0) and arg_613_1.var_.characterEffect10171ui_story == nil then
				arg_613_1.var_.characterEffect10171ui_story = var_616_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_2 = 0.200000002980232

			if var_616_1 <= arg_613_1.time_ and arg_613_1.time_ < var_616_1 + var_616_2 and not isNil(var_616_0) then
				local var_616_3 = (arg_613_1.time_ - var_616_1) / var_616_2

				if arg_613_1.var_.characterEffect10171ui_story and not isNil(var_616_0) then
					local var_616_4 = Mathf.Lerp(0, 0.5, var_616_3)

					arg_613_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_613_1.var_.characterEffect10171ui_story.fillRatio = var_616_4
				end
			end

			if arg_613_1.time_ >= var_616_1 + var_616_2 and arg_613_1.time_ < var_616_1 + var_616_2 + arg_616_0 and not isNil(var_616_0) and arg_613_1.var_.characterEffect10171ui_story then
				local var_616_5 = 0.5

				arg_613_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_613_1.var_.characterEffect10171ui_story.fillRatio = var_616_5
			end

			local var_616_6 = 0
			local var_616_7 = 0.425

			if var_616_6 < arg_613_1.time_ and arg_613_1.time_ <= var_616_6 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_8 = arg_613_1:FormatText(StoryNameCfg[1468].name)

				arg_613_1.leftNameTxt_.text = var_616_8

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

				local var_616_9 = arg_613_1:GetWordFromCfg(324151142)
				local var_616_10 = arg_613_1:FormatText(var_616_9.content)

				arg_613_1.text_.text = var_616_10

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_11 = 17
				local var_616_12 = utf8.len(var_616_10)
				local var_616_13 = var_616_11 <= 0 and var_616_7 or var_616_7 * (var_616_12 / var_616_11)

				if var_616_13 > 0 and var_616_7 < var_616_13 then
					arg_613_1.talkMaxDuration = var_616_13

					if var_616_13 + var_616_6 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_13 + var_616_6
					end
				end

				arg_613_1.text_.text = var_616_10
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151142", "story_v_out_324151.awb") ~= 0 then
					local var_616_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151142", "story_v_out_324151.awb") / 1000

					if var_616_14 + var_616_6 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_14 + var_616_6
					end

					if var_616_9.prefab_name ~= "" and arg_613_1.actors_[var_616_9.prefab_name] ~= nil then
						local var_616_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_9.prefab_name].transform, "story_v_out_324151", "324151142", "story_v_out_324151.awb")

						arg_613_1:RecordAudio("324151142", var_616_15)
						arg_613_1:RecordAudio("324151142", var_616_15)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_out_324151", "324151142", "story_v_out_324151.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_out_324151", "324151142", "story_v_out_324151.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_16 = math.max(var_616_7, arg_613_1.talkMaxDuration)

			if var_616_6 <= arg_613_1.time_ and arg_613_1.time_ < var_616_6 + var_616_16 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_6) / var_616_16

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_6 + var_616_16 and arg_613_1.time_ < var_616_6 + var_616_16 + arg_616_0 then
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
			local var_620_0 = arg_617_1.actors_["10171ui_story"]
			local var_620_1 = 0

			if var_620_1 < arg_617_1.time_ and arg_617_1.time_ <= var_620_1 + arg_620_0 and not isNil(var_620_0) and arg_617_1.var_.characterEffect10171ui_story == nil then
				arg_617_1.var_.characterEffect10171ui_story = var_620_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_2 = 0.200000002980232

			if var_620_1 <= arg_617_1.time_ and arg_617_1.time_ < var_620_1 + var_620_2 and not isNil(var_620_0) then
				local var_620_3 = (arg_617_1.time_ - var_620_1) / var_620_2

				if arg_617_1.var_.characterEffect10171ui_story and not isNil(var_620_0) then
					arg_617_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_617_1.time_ >= var_620_1 + var_620_2 and arg_617_1.time_ < var_620_1 + var_620_2 + arg_620_0 and not isNil(var_620_0) and arg_617_1.var_.characterEffect10171ui_story then
				arg_617_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_620_4 = 0

			if var_620_4 < arg_617_1.time_ and arg_617_1.time_ <= var_620_4 + arg_620_0 then
				arg_617_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_620_5 = 0

			if var_620_5 < arg_617_1.time_ and arg_617_1.time_ <= var_620_5 + arg_620_0 then
				arg_617_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_620_6 = 0
			local var_620_7 = 0.75

			if var_620_6 < arg_617_1.time_ and arg_617_1.time_ <= var_620_6 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				local var_620_8 = arg_617_1:FormatText(StoryNameCfg[1451].name)

				arg_617_1.leftNameTxt_.text = var_620_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_9 = arg_617_1:GetWordFromCfg(324151143)
				local var_620_10 = arg_617_1:FormatText(var_620_9.content)

				arg_617_1.text_.text = var_620_10

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_11 = 30
				local var_620_12 = utf8.len(var_620_10)
				local var_620_13 = var_620_11 <= 0 and var_620_7 or var_620_7 * (var_620_12 / var_620_11)

				if var_620_13 > 0 and var_620_7 < var_620_13 then
					arg_617_1.talkMaxDuration = var_620_13

					if var_620_13 + var_620_6 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_13 + var_620_6
					end
				end

				arg_617_1.text_.text = var_620_10
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324151", "324151143", "story_v_out_324151.awb") ~= 0 then
					local var_620_14 = manager.audio:GetVoiceLength("story_v_out_324151", "324151143", "story_v_out_324151.awb") / 1000

					if var_620_14 + var_620_6 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_14 + var_620_6
					end

					if var_620_9.prefab_name ~= "" and arg_617_1.actors_[var_620_9.prefab_name] ~= nil then
						local var_620_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_9.prefab_name].transform, "story_v_out_324151", "324151143", "story_v_out_324151.awb")

						arg_617_1:RecordAudio("324151143", var_620_15)
						arg_617_1:RecordAudio("324151143", var_620_15)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_out_324151", "324151143", "story_v_out_324151.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_out_324151", "324151143", "story_v_out_324151.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_16 = math.max(var_620_7, arg_617_1.talkMaxDuration)

			if var_620_6 <= arg_617_1.time_ and arg_617_1.time_ < var_620_6 + var_620_16 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_6) / var_620_16

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_6 + var_620_16 and arg_617_1.time_ < var_620_6 + var_620_16 + arg_620_0 then
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
