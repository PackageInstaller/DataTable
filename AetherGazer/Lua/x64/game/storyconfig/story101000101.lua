return {
	Play100011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 100011001
		arg_1_1.duration_ = 4.95

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play100011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v0_prologue", "bgm_story_v0_prologue", "bgm_story_v0_prologue")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v0_prologue", "bgm_story_v0_prologue")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_6 = "STblack"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = 0

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				local var_4_9 = manager.ui.mainCamera.transform.localPosition
				local var_4_10 = Vector3.New(0, 0, 10) + Vector3.New(var_4_9.x, var_4_9.y, 0)
				local var_4_11 = arg_1_1.bgs_.STblack

				var_4_11.transform.localPosition = var_4_10
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = (var_4_11.transform.localPosition - var_4_9).z
					local var_4_14 = manager.ui.mainCameraCom_
					local var_4_15 = 2 * var_4_13 * Mathf.Tan(var_4_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_16 = var_4_15 * var_4_14.aspect
					local var_4_17 = var_4_12.sprite.bounds.size.x
					local var_4_18 = var_4_12.sprite.bounds.size.y
					local var_4_19 = var_4_16 / var_4_17
					local var_4_20 = var_4_15 / var_4_18
					local var_4_21 = var_4_20 < var_4_19 and var_4_19 or var_4_20

					var_4_11.transform.localScale = Vector3.New(var_4_21, var_4_21, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_22 = "S0018"

			if arg_1_1.bgs_[var_4_22] == nil then
				local var_4_23 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_23:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_22)
				var_4_23.name = var_4_22
				var_4_23.transform.parent = arg_1_1.stage_.transform
				var_4_23.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_22] = var_4_23
			end

			local var_4_24 = arg_1_1.bgs_.S0018
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = var_4_24:GetComponent("SpriteRenderer")

				if var_4_26 then
					arg_1_1.var_.alphaOldValueS0018 = var_4_26.color.a
					arg_1_1.var_.alphaMatValueS0018 = var_4_26
				end

				arg_1_1.var_.alphaOldValueS0018 = 0
			end

			local var_4_27 = 1.5

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_25) / var_4_27
				local var_4_29 = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0018, 1, var_4_28)

				if arg_1_1.var_.alphaMatValueS0018 then
					local var_4_30 = arg_1_1.var_.alphaMatValueS0018.color

					var_4_30.a = var_4_29
					arg_1_1.var_.alphaMatValueS0018.color = var_4_30
				end
			end

			if arg_1_1.time_ >= var_4_25 + var_4_27 and arg_1_1.time_ < var_4_25 + var_4_27 + arg_4_0 and arg_1_1.var_.alphaMatValueS0018 then
				local var_4_31 = arg_1_1.var_.alphaMatValueS0018
				local var_4_32 = var_4_31.color

				var_4_32.a = 1
				var_4_31.color = var_4_32
			end

			local var_4_33 = 0
			local var_4_34 = 4.95
			local var_4_35 = manager.audio:GetVoiceLength("story_v_out_100011", "100011001", "story_v_out_100011.awb") / 1000

			if var_4_35 > 0 and var_4_34 < var_4_35 and var_4_35 + var_4_33 > arg_1_1.duration_ then
				local var_4_36 = var_4_35

				arg_1_1.duration_ = var_4_35 + var_4_33
			end

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_37 = "play"
				local var_4_38 = "voice"

				arg_1_1:AudioAction(var_4_37, var_4_38, "story_v_out_100011", "100011001", "story_v_out_100011.awb")
			end

			local var_4_39 = 0

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_40 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_41 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_42 = var_4_40:GetComponent("Text")
				local var_4_43 = var_4_40:GetComponent("RectTransform")

				var_4_42.alignment = UnityEngine.TextAnchor.MiddleLeft
				var_4_43.offsetMin = Vector2.New(400, 105)
				var_4_43.offsetMax = Vector2.New(-400, -200)
			end

			local var_4_44 = 0

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_45 = arg_1_1:GetWordFromCfg(100011001)
				local var_4_46 = arg_1_1:FormatText(var_4_45.content)

				arg_1_1.fswt_.text = var_4_46

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_47 = 0.100000001490116

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_48 = 28
			local var_4_49 = 1.86666666666667
			local var_4_50 = arg_1_1:GetWordFromCfg(100011001)
			local var_4_51 = arg_1_1:FormatText(var_4_50.content)
			local var_4_52, var_4_53 = arg_1_1:GetPercentByPara(var_4_51, 1)

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_54 = var_4_48 <= 0 and var_4_49 or var_4_49 * ((var_4_53 - arg_1_1.typewritterCharCountI18N) / var_4_48)

				if var_4_54 > 0 and var_4_49 < var_4_54 then
					arg_1_1.talkMaxDuration = var_4_54

					if var_4_54 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_54 + var_4_47
					end
				end
			end

			local var_4_55 = 1.86666666666667
			local var_4_56 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_56 then
				local var_4_57 = (arg_1_1.time_ - var_4_47) / var_4_56

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_52, var_4_57)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_56 and arg_1_1.time_ < var_4_47 + var_4_56 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_52

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_53
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play100011002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 100011002
		arg_6_1.duration_ = 21.17

		local var_6_0 = {
			ja = 21.166,
			ko = 14.766,
			zh = 16.166,
			en = 17.4
		}
		local var_6_1 = manager.audio:GetLocalizationFlag()

		if var_6_0[var_6_1] ~= nil then
			arg_6_1.duration_ = var_6_0[var_6_1]
		end

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play100011003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = "S0015"

			if arg_6_1.bgs_[var_9_0] == nil then
				local var_9_1 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_9_0)
				var_9_1.name = var_9_0
				var_9_1.transform.parent = arg_6_1.stage_.transform
				var_9_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_[var_9_0] = var_9_1
			end

			local var_9_2 = 0

			if var_9_2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_2 + arg_9_0 then
				local var_9_3 = manager.ui.mainCamera.transform.localPosition
				local var_9_4 = Vector3.New(0, 0, 10) + Vector3.New(var_9_3.x, var_9_3.y, 0)
				local var_9_5 = arg_6_1.bgs_.S0015

				var_9_5.transform.localPosition = var_9_4
				var_9_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_6 = var_9_5:GetComponent("SpriteRenderer")

				if var_9_6 and var_9_6.sprite then
					local var_9_7 = (var_9_5.transform.localPosition - var_9_3).z
					local var_9_8 = manager.ui.mainCameraCom_
					local var_9_9 = 2 * var_9_7 * Mathf.Tan(var_9_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_9_10 = var_9_9 * var_9_8.aspect
					local var_9_11 = var_9_6.sprite.bounds.size.x
					local var_9_12 = var_9_6.sprite.bounds.size.y
					local var_9_13 = var_9_10 / var_9_11
					local var_9_14 = var_9_9 / var_9_12
					local var_9_15 = var_9_14 < var_9_13 and var_9_13 or var_9_14

					var_9_5.transform.localScale = Vector3.New(var_9_15, var_9_15, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "S0015" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_16 = 0

			if var_9_16 < arg_6_1.time_ and arg_6_1.time_ <= var_9_16 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(true)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_17 = arg_6_1.bgs_.S0015
			local var_9_18 = 0

			if var_9_18 < arg_6_1.time_ and arg_6_1.time_ <= var_9_18 + arg_9_0 then
				local var_9_19 = var_9_17:GetComponent("SpriteRenderer")

				if var_9_19 then
					arg_6_1.var_.alphaOldValueS0015 = var_9_19.color.a
					arg_6_1.var_.alphaMatValueS0015 = var_9_19
				end

				arg_6_1.var_.alphaOldValueS0015 = 0
			end

			local var_9_20 = 1.5

			if var_9_18 <= arg_6_1.time_ and arg_6_1.time_ < var_9_18 + var_9_20 then
				local var_9_21 = (arg_6_1.time_ - var_9_18) / var_9_20
				local var_9_22 = Mathf.Lerp(arg_6_1.var_.alphaOldValueS0015, 1, var_9_21)

				if arg_6_1.var_.alphaMatValueS0015 then
					local var_9_23 = arg_6_1.var_.alphaMatValueS0015.color

					var_9_23.a = var_9_22
					arg_6_1.var_.alphaMatValueS0015.color = var_9_23
				end
			end

			if arg_6_1.time_ >= var_9_18 + var_9_20 and arg_6_1.time_ < var_9_18 + var_9_20 + arg_9_0 and arg_6_1.var_.alphaMatValueS0015 then
				local var_9_24 = arg_6_1.var_.alphaMatValueS0015
				local var_9_25 = var_9_24.color

				var_9_25.a = 1
				var_9_24.color = var_9_25
			end

			local var_9_26 = arg_6_1.bgs_.S0015.transform
			local var_9_27 = 0

			if var_9_27 < arg_6_1.time_ and arg_6_1.time_ <= var_9_27 + arg_9_0 then
				arg_6_1.var_.moveOldPosS0015 = var_9_26.localPosition
			end

			local var_9_28 = 3

			if var_9_27 <= arg_6_1.time_ and arg_6_1.time_ < var_9_27 + var_9_28 then
				local var_9_29 = (arg_6_1.time_ - var_9_27) / var_9_28
				local var_9_30 = Vector3.New(0, 1, 8)

				var_9_26.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPosS0015, var_9_30, var_9_29)
			end

			if arg_6_1.time_ >= var_9_27 + var_9_28 and arg_6_1.time_ < var_9_27 + var_9_28 + arg_9_0 then
				var_9_26.localPosition = Vector3.New(0, 1, 8)
			end

			local var_9_31 = 0

			if var_9_31 < arg_6_1.time_ and arg_6_1.time_ <= var_9_31 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			local var_9_32 = 1.5

			if arg_6_1.time_ >= var_9_31 + var_9_32 and arg_6_1.time_ < var_9_31 + var_9_32 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_33 = 1.5
			local var_9_34 = 1.5

			if var_9_33 < arg_6_1.time_ and arg_6_1.time_ <= var_9_33 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_35 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_35:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_36 = arg_6_1:GetWordFromCfg(100011002)
				local var_9_37 = arg_6_1:FormatText(var_9_36.content)

				arg_6_1.text_.text = var_9_37

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_38 = 60
				local var_9_39 = utf8.len(var_9_37)
				local var_9_40 = var_9_38 <= 0 and var_9_34 or var_9_34 * (var_9_39 / var_9_38)

				if var_9_40 > 0 and var_9_34 < var_9_40 then
					arg_6_1.talkMaxDuration = var_9_40
					var_9_33 = var_9_33 + 0.3

					if var_9_40 + var_9_33 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_40 + var_9_33
					end
				end

				arg_6_1.text_.text = var_9_37
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011002", "story_v_out_100011.awb") ~= 0 then
					local var_9_41 = manager.audio:GetVoiceLength("story_v_out_100011", "100011002", "story_v_out_100011.awb") / 1000

					if var_9_41 + var_9_33 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_41 + var_9_33
					end

					if var_9_36.prefab_name ~= "" and arg_6_1.actors_[var_9_36.prefab_name] ~= nil then
						local var_9_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_6_1.actors_[var_9_36.prefab_name].transform, "story_v_out_100011", "100011002", "story_v_out_100011.awb")

						arg_6_1:RecordAudio("100011002", var_9_42)
						arg_6_1:RecordAudio("100011002", var_9_42)
					else
						arg_6_1:AudioAction("play", "voice", "story_v_out_100011", "100011002", "story_v_out_100011.awb")
					end

					arg_6_1:RecordHistoryTalkVoice("story_v_out_100011", "100011002", "story_v_out_100011.awb")
				end

				local var_9_43 = string.gsub(var_9_37, "「盖亚」", "「盖亚」(Geyser宇宙)")

				arg_6_1:RecordContent(var_9_43)
			end

			local var_9_44 = var_9_33 + 0.3
			local var_9_45 = math.max(var_9_34, arg_6_1.talkMaxDuration)

			if var_9_44 <= arg_6_1.time_ and arg_6_1.time_ < var_9_44 + var_9_45 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_44) / var_9_45

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_44 + var_9_45 and arg_6_1.time_ < var_9_44 + var_9_45 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play100011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 100011003
		arg_12_1.duration_ = 23.33

		local var_12_0 = {
			ja = 23.333,
			ko = 16.7,
			zh = 15.066,
			en = 19.766
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play100011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.bgs_.S0015.transform
			local var_15_1 = 0.967

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPosS0015 = var_15_0.localPosition
			end

			local var_15_2 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2
				local var_15_4 = Vector3.New(0, -100, 10)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPosS0015, var_15_4, var_15_3)
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_15_5 = "S0011"

			if arg_12_1.bgs_[var_15_5] == nil then
				local var_15_6 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_5)
				var_15_6.name = var_15_5
				var_15_6.transform.parent = arg_12_1.stage_.transform
				var_15_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_5] = var_15_6
			end

			local var_15_7 = 1

			if var_15_7 < arg_12_1.time_ and arg_12_1.time_ <= var_15_7 + arg_15_0 then
				local var_15_8 = manager.ui.mainCamera.transform.localPosition
				local var_15_9 = Vector3.New(0, 0, 10) + Vector3.New(var_15_8.x, var_15_8.y, 0)
				local var_15_10 = arg_12_1.bgs_.S0011

				var_15_10.transform.localPosition = var_15_9
				var_15_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_11 = var_15_10:GetComponent("SpriteRenderer")

				if var_15_11 and var_15_11.sprite then
					local var_15_12 = (var_15_10.transform.localPosition - var_15_8).z
					local var_15_13 = manager.ui.mainCameraCom_
					local var_15_14 = 2 * var_15_12 * Mathf.Tan(var_15_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_15_15 = var_15_14 * var_15_13.aspect
					local var_15_16 = var_15_11.sprite.bounds.size.x
					local var_15_17 = var_15_11.sprite.bounds.size.y
					local var_15_18 = var_15_15 / var_15_16
					local var_15_19 = var_15_14 / var_15_17
					local var_15_20 = var_15_19 < var_15_18 and var_15_18 or var_15_19

					var_15_10.transform.localScale = Vector3.New(var_15_20, var_15_20, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "S0011" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_21 = arg_12_1.bgs_.S0015
			local var_15_22 = 0

			if var_15_22 < arg_12_1.time_ and arg_12_1.time_ <= var_15_22 + arg_15_0 then
				local var_15_23 = var_15_21:GetComponent("SpriteRenderer")

				if var_15_23 then
					arg_12_1.var_.alphaOldValueS0015 = var_15_23.color.a
					arg_12_1.var_.alphaMatValueS0015 = var_15_23
				end

				arg_12_1.var_.alphaOldValueS0015 = 1
			end

			local var_15_24 = 1

			if var_15_22 <= arg_12_1.time_ and arg_12_1.time_ < var_15_22 + var_15_24 then
				local var_15_25 = (arg_12_1.time_ - var_15_22) / var_15_24
				local var_15_26 = Mathf.Lerp(arg_12_1.var_.alphaOldValueS0015, 0, var_15_25)

				if arg_12_1.var_.alphaMatValueS0015 then
					local var_15_27 = arg_12_1.var_.alphaMatValueS0015.color

					var_15_27.a = var_15_26
					arg_12_1.var_.alphaMatValueS0015.color = var_15_27
				end
			end

			if arg_12_1.time_ >= var_15_22 + var_15_24 and arg_12_1.time_ < var_15_22 + var_15_24 + arg_15_0 and arg_12_1.var_.alphaMatValueS0015 then
				local var_15_28 = arg_12_1.var_.alphaMatValueS0015
				local var_15_29 = var_15_28.color

				var_15_29.a = 0
				var_15_28.color = var_15_29
			end

			local var_15_30 = arg_12_1.bgs_.S0011
			local var_15_31 = 1

			if var_15_31 < arg_12_1.time_ and arg_12_1.time_ <= var_15_31 + arg_15_0 then
				local var_15_32 = var_15_30:GetComponent("SpriteRenderer")

				if var_15_32 then
					arg_12_1.var_.alphaOldValueS0011 = var_15_32.color.a
					arg_12_1.var_.alphaMatValueS0011 = var_15_32
				end

				arg_12_1.var_.alphaOldValueS0011 = 0
			end

			local var_15_33 = 1.5

			if var_15_31 <= arg_12_1.time_ and arg_12_1.time_ < var_15_31 + var_15_33 then
				local var_15_34 = (arg_12_1.time_ - var_15_31) / var_15_33
				local var_15_35 = Mathf.Lerp(arg_12_1.var_.alphaOldValueS0011, 1, var_15_34)

				if arg_12_1.var_.alphaMatValueS0011 then
					local var_15_36 = arg_12_1.var_.alphaMatValueS0011.color

					var_15_36.a = var_15_35
					arg_12_1.var_.alphaMatValueS0011.color = var_15_36
				end
			end

			if arg_12_1.time_ >= var_15_31 + var_15_33 and arg_12_1.time_ < var_15_31 + var_15_33 + arg_15_0 and arg_12_1.var_.alphaMatValueS0011 then
				local var_15_37 = arg_12_1.var_.alphaMatValueS0011
				local var_15_38 = var_15_37.color

				var_15_38.a = 1
				var_15_37.color = var_15_38
			end

			local var_15_39 = arg_12_1.bgs_.S0011.transform
			local var_15_40 = 1

			if var_15_40 < arg_12_1.time_ and arg_12_1.time_ <= var_15_40 + arg_15_0 then
				arg_12_1.var_.moveOldPosS0011 = var_15_39.localPosition
			end

			local var_15_41 = 3.075

			if var_15_40 <= arg_12_1.time_ and arg_12_1.time_ < var_15_40 + var_15_41 then
				local var_15_42 = (arg_12_1.time_ - var_15_40) / var_15_41
				local var_15_43 = Vector3.New(0, 1, 9)

				var_15_39.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPosS0011, var_15_43, var_15_42)
			end

			if arg_12_1.time_ >= var_15_40 + var_15_41 and arg_12_1.time_ < var_15_40 + var_15_41 + arg_15_0 then
				var_15_39.localPosition = Vector3.New(0, 1, 9)
			end

			local var_15_44 = 0

			if var_15_44 < arg_12_1.time_ and arg_12_1.time_ <= var_15_44 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_45 = 2.5

			if arg_12_1.time_ >= var_15_44 + var_15_45 and arg_12_1.time_ < var_15_44 + var_15_45 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_46 = 2.5
			local var_15_47 = 1.575

			if var_15_46 < arg_12_1.time_ and arg_12_1.time_ <= var_15_46 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_48 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_48:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_49 = arg_12_1:GetWordFromCfg(100011003)
				local var_15_50 = arg_12_1:FormatText(var_15_49.content)

				arg_12_1.text_.text = var_15_50

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_51 = 64
				local var_15_52 = utf8.len(var_15_50)
				local var_15_53 = var_15_51 <= 0 and var_15_47 or var_15_47 * (var_15_52 / var_15_51)

				if var_15_53 > 0 and var_15_47 < var_15_53 then
					arg_12_1.talkMaxDuration = var_15_53
					var_15_46 = var_15_46 + 0.3

					if var_15_53 + var_15_46 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_53 + var_15_46
					end
				end

				arg_12_1.text_.text = var_15_50
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011003", "story_v_out_100011.awb") ~= 0 then
					local var_15_54 = manager.audio:GetVoiceLength("story_v_out_100011", "100011003", "story_v_out_100011.awb") / 1000

					if var_15_54 + var_15_46 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_54 + var_15_46
					end

					if var_15_49.prefab_name ~= "" and arg_12_1.actors_[var_15_49.prefab_name] ~= nil then
						local var_15_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_49.prefab_name].transform, "story_v_out_100011", "100011003", "story_v_out_100011.awb")

						arg_12_1:RecordAudio("100011003", var_15_55)
						arg_12_1:RecordAudio("100011003", var_15_55)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_100011", "100011003", "story_v_out_100011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_100011", "100011003", "story_v_out_100011.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_56 = var_15_46 + 0.3
			local var_15_57 = math.max(var_15_47, arg_12_1.talkMaxDuration)

			if var_15_56 <= arg_12_1.time_ and arg_12_1.time_ < var_15_56 + var_15_57 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_56) / var_15_57

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_56 + var_15_57 and arg_12_1.time_ < var_15_56 + var_15_57 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.075,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play100011004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 100011004
		arg_18_1.duration_ = 21.1

		local var_18_0 = {
			ja = 21.1,
			ko = 14.933,
			zh = 16.366,
			en = 18.233
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play100011005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.bgs_.S0011.transform
			local var_21_1 = 1

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.var_.moveOldPosS0011 = var_21_0.localPosition
			end

			local var_21_2 = 0.001

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2
				local var_21_4 = Vector3.New(0, -100, 10)

				var_21_0.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPosS0011, var_21_4, var_21_3)
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 then
				var_21_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_21_5 = "S0012"

			if arg_18_1.bgs_[var_21_5] == nil then
				local var_21_6 = Object.Instantiate(arg_18_1.paintGo_)

				var_21_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_21_5)
				var_21_6.name = var_21_5
				var_21_6.transform.parent = arg_18_1.stage_.transform
				var_21_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.bgs_[var_21_5] = var_21_6
			end

			local var_21_7 = 1

			if var_21_7 < arg_18_1.time_ and arg_18_1.time_ <= var_21_7 + arg_21_0 then
				local var_21_8 = manager.ui.mainCamera.transform.localPosition
				local var_21_9 = Vector3.New(0, 0, 10) + Vector3.New(var_21_8.x, var_21_8.y, 0)
				local var_21_10 = arg_18_1.bgs_.S0012

				var_21_10.transform.localPosition = var_21_9
				var_21_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_11 = var_21_10:GetComponent("SpriteRenderer")

				if var_21_11 and var_21_11.sprite then
					local var_21_12 = (var_21_10.transform.localPosition - var_21_8).z
					local var_21_13 = manager.ui.mainCameraCom_
					local var_21_14 = 2 * var_21_12 * Mathf.Tan(var_21_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_21_15 = var_21_14 * var_21_13.aspect
					local var_21_16 = var_21_11.sprite.bounds.size.x
					local var_21_17 = var_21_11.sprite.bounds.size.y
					local var_21_18 = var_21_15 / var_21_16
					local var_21_19 = var_21_14 / var_21_17
					local var_21_20 = var_21_19 < var_21_18 and var_21_18 or var_21_19

					var_21_10.transform.localScale = Vector3.New(var_21_20, var_21_20, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "S0012" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_21 = arg_18_1.bgs_.S0011
			local var_21_22 = 0

			if var_21_22 < arg_18_1.time_ and arg_18_1.time_ <= var_21_22 + arg_21_0 then
				local var_21_23 = var_21_21:GetComponent("SpriteRenderer")

				if var_21_23 then
					arg_18_1.var_.alphaOldValueS0011 = var_21_23.color.a
					arg_18_1.var_.alphaMatValueS0011 = var_21_23
				end

				arg_18_1.var_.alphaOldValueS0011 = 1
			end

			local var_21_24 = 1

			if var_21_22 <= arg_18_1.time_ and arg_18_1.time_ < var_21_22 + var_21_24 then
				local var_21_25 = (arg_18_1.time_ - var_21_22) / var_21_24
				local var_21_26 = Mathf.Lerp(arg_18_1.var_.alphaOldValueS0011, 0, var_21_25)

				if arg_18_1.var_.alphaMatValueS0011 then
					local var_21_27 = arg_18_1.var_.alphaMatValueS0011.color

					var_21_27.a = var_21_26
					arg_18_1.var_.alphaMatValueS0011.color = var_21_27
				end
			end

			if arg_18_1.time_ >= var_21_22 + var_21_24 and arg_18_1.time_ < var_21_22 + var_21_24 + arg_21_0 and arg_18_1.var_.alphaMatValueS0011 then
				local var_21_28 = arg_18_1.var_.alphaMatValueS0011
				local var_21_29 = var_21_28.color

				var_21_29.a = 0
				var_21_28.color = var_21_29
			end

			local var_21_30 = arg_18_1.bgs_.S0012
			local var_21_31 = 1

			if var_21_31 < arg_18_1.time_ and arg_18_1.time_ <= var_21_31 + arg_21_0 then
				local var_21_32 = var_21_30:GetComponent("SpriteRenderer")

				if var_21_32 then
					arg_18_1.var_.alphaOldValueS0012 = var_21_32.color.a
					arg_18_1.var_.alphaMatValueS0012 = var_21_32
				end

				arg_18_1.var_.alphaOldValueS0012 = 0
			end

			local var_21_33 = 1.5

			if var_21_31 <= arg_18_1.time_ and arg_18_1.time_ < var_21_31 + var_21_33 then
				local var_21_34 = (arg_18_1.time_ - var_21_31) / var_21_33
				local var_21_35 = Mathf.Lerp(arg_18_1.var_.alphaOldValueS0012, 1, var_21_34)

				if arg_18_1.var_.alphaMatValueS0012 then
					local var_21_36 = arg_18_1.var_.alphaMatValueS0012.color

					var_21_36.a = var_21_35
					arg_18_1.var_.alphaMatValueS0012.color = var_21_36
				end
			end

			if arg_18_1.time_ >= var_21_31 + var_21_33 and arg_18_1.time_ < var_21_31 + var_21_33 + arg_21_0 and arg_18_1.var_.alphaMatValueS0012 then
				local var_21_37 = arg_18_1.var_.alphaMatValueS0012
				local var_21_38 = var_21_37.color

				var_21_38.a = 1
				var_21_37.color = var_21_38
			end

			local var_21_39 = arg_18_1.bgs_.S0012.transform
			local var_21_40 = 1

			if var_21_40 < arg_18_1.time_ and arg_18_1.time_ <= var_21_40 + arg_21_0 then
				arg_18_1.var_.moveOldPosS0012 = var_21_39.localPosition
			end

			local var_21_41 = 3.65

			if var_21_40 <= arg_18_1.time_ and arg_18_1.time_ < var_21_40 + var_21_41 then
				local var_21_42 = (arg_18_1.time_ - var_21_40) / var_21_41
				local var_21_43 = Vector3.New(0, 1, 8)

				var_21_39.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPosS0012, var_21_43, var_21_42)
			end

			if arg_18_1.time_ >= var_21_40 + var_21_41 and arg_18_1.time_ < var_21_40 + var_21_41 + arg_21_0 then
				var_21_39.localPosition = Vector3.New(0, 1, 8)
			end

			local var_21_44 = 0

			if var_21_44 < arg_18_1.time_ and arg_18_1.time_ <= var_21_44 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			local var_21_45 = 2.5

			if arg_18_1.time_ >= var_21_44 + var_21_45 and arg_18_1.time_ < var_21_44 + var_21_45 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_46 = 2.5
			local var_21_47 = 2.15

			if var_21_46 < arg_18_1.time_ and arg_18_1.time_ <= var_21_46 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_48 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_48:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_18_1.dialogCg_.alpha = arg_22_0
				end))
				var_21_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_49 = arg_18_1:GetWordFromCfg(100011004)
				local var_21_50 = arg_18_1:FormatText(var_21_49.content)

				arg_18_1.text_.text = var_21_50

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_51 = 61
				local var_21_52 = utf8.len(var_21_50)
				local var_21_53 = var_21_51 <= 0 and var_21_47 or var_21_47 * (var_21_52 / var_21_51)

				if var_21_53 > 0 and var_21_47 < var_21_53 then
					arg_18_1.talkMaxDuration = var_21_53
					var_21_46 = var_21_46 + 0.3

					if var_21_53 + var_21_46 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_53 + var_21_46
					end
				end

				arg_18_1.text_.text = var_21_50
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011004", "story_v_out_100011.awb") ~= 0 then
					local var_21_54 = manager.audio:GetVoiceLength("story_v_out_100011", "100011004", "story_v_out_100011.awb") / 1000

					if var_21_54 + var_21_46 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_54 + var_21_46
					end

					if var_21_49.prefab_name ~= "" and arg_18_1.actors_[var_21_49.prefab_name] ~= nil then
						local var_21_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_49.prefab_name].transform, "story_v_out_100011", "100011004", "story_v_out_100011.awb")

						arg_18_1:RecordAudio("100011004", var_21_55)
						arg_18_1:RecordAudio("100011004", var_21_55)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_100011", "100011004", "story_v_out_100011.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_100011", "100011004", "story_v_out_100011.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_56 = var_21_46 + 0.3
			local var_21_57 = math.max(var_21_47, arg_18_1.talkMaxDuration)

			if var_21_56 <= arg_18_1.time_ and arg_18_1.time_ < var_21_56 + var_21_57 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_56) / var_21_57

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_56 + var_21_57 and arg_18_1.time_ < var_21_56 + var_21_57 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0011",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.65,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play100011005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 100011005
		arg_24_1.duration_ = 6.43

		local var_24_0 = {
			ja = 6.433,
			ko = 4.233,
			zh = 4.666,
			en = 3.766
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play100011006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 1.075

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_2 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_2:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(100011005)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 19
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7
					var_27_0 = var_27_0 + 0.3

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011005", "story_v_out_100011.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_100011", "100011005", "story_v_out_100011.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_100011", "100011005", "story_v_out_100011.awb")

						arg_24_1:RecordAudio("100011005", var_27_9)
						arg_24_1:RecordAudio("100011005", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_100011", "100011005", "story_v_out_100011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_100011", "100011005", "story_v_out_100011.awb")
				end

				local var_27_10 = string.gsub(var_27_4, "「视骸」", "「视骸」(BUG)")

				arg_24_1:RecordContent(var_27_10)
			end

			local var_27_11 = var_27_0 + 0.3
			local var_27_12 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_11 <= arg_24_1.time_ and arg_24_1.time_ < var_27_11 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_11) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_11 + var_27_12 and arg_24_1.time_ < var_27_11 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play100011006 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 100011006
		arg_30_1.duration_ = 16.47

		local var_30_0 = {
			ja = 16.466,
			ko = 13.766,
			zh = 10.833,
			en = 14.533
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play100011007(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.bgs_.S0012.transform
			local var_33_1 = 1

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.var_.moveOldPosS0012 = var_33_0.localPosition
			end

			local var_33_2 = 0.001

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2
				local var_33_4 = Vector3.New(0, -100, 10)

				var_33_0.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPosS0012, var_33_4, var_33_3)
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 then
				var_33_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_33_5 = "S0016"

			if arg_30_1.bgs_[var_33_5] == nil then
				local var_33_6 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_5)
				var_33_6.name = var_33_5
				var_33_6.transform.parent = arg_30_1.stage_.transform
				var_33_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_5] = var_33_6
			end

			local var_33_7 = 1

			if var_33_7 < arg_30_1.time_ and arg_30_1.time_ <= var_33_7 + arg_33_0 then
				local var_33_8 = manager.ui.mainCamera.transform.localPosition
				local var_33_9 = Vector3.New(0, 0, 10) + Vector3.New(var_33_8.x, var_33_8.y, 0)
				local var_33_10 = arg_30_1.bgs_.S0016

				var_33_10.transform.localPosition = var_33_9
				var_33_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_11 = var_33_10:GetComponent("SpriteRenderer")

				if var_33_11 and var_33_11.sprite then
					local var_33_12 = (var_33_10.transform.localPosition - var_33_8).z
					local var_33_13 = manager.ui.mainCameraCom_
					local var_33_14 = 2 * var_33_12 * Mathf.Tan(var_33_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_33_15 = var_33_14 * var_33_13.aspect
					local var_33_16 = var_33_11.sprite.bounds.size.x
					local var_33_17 = var_33_11.sprite.bounds.size.y
					local var_33_18 = var_33_15 / var_33_16
					local var_33_19 = var_33_14 / var_33_17
					local var_33_20 = var_33_19 < var_33_18 and var_33_18 or var_33_19

					var_33_10.transform.localScale = Vector3.New(var_33_20, var_33_20, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "S0016" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_21 = arg_30_1.bgs_.S0012
			local var_33_22 = 0

			if var_33_22 < arg_30_1.time_ and arg_30_1.time_ <= var_33_22 + arg_33_0 then
				local var_33_23 = var_33_21:GetComponent("SpriteRenderer")

				if var_33_23 then
					arg_30_1.var_.alphaOldValueS0012 = var_33_23.color.a
					arg_30_1.var_.alphaMatValueS0012 = var_33_23
				end

				arg_30_1.var_.alphaOldValueS0012 = 1
			end

			local var_33_24 = 1

			if var_33_22 <= arg_30_1.time_ and arg_30_1.time_ < var_33_22 + var_33_24 then
				local var_33_25 = (arg_30_1.time_ - var_33_22) / var_33_24
				local var_33_26 = Mathf.Lerp(arg_30_1.var_.alphaOldValueS0012, 0, var_33_25)

				if arg_30_1.var_.alphaMatValueS0012 then
					local var_33_27 = arg_30_1.var_.alphaMatValueS0012.color

					var_33_27.a = var_33_26
					arg_30_1.var_.alphaMatValueS0012.color = var_33_27
				end
			end

			if arg_30_1.time_ >= var_33_22 + var_33_24 and arg_30_1.time_ < var_33_22 + var_33_24 + arg_33_0 and arg_30_1.var_.alphaMatValueS0012 then
				local var_33_28 = arg_30_1.var_.alphaMatValueS0012
				local var_33_29 = var_33_28.color

				var_33_29.a = 0
				var_33_28.color = var_33_29
			end

			local var_33_30 = arg_30_1.bgs_.S0016
			local var_33_31 = 1

			if var_33_31 < arg_30_1.time_ and arg_30_1.time_ <= var_33_31 + arg_33_0 then
				local var_33_32 = var_33_30:GetComponent("SpriteRenderer")

				if var_33_32 then
					arg_30_1.var_.alphaOldValueS0016 = var_33_32.color.a
					arg_30_1.var_.alphaMatValueS0016 = var_33_32
				end

				arg_30_1.var_.alphaOldValueS0016 = 0
			end

			local var_33_33 = 1.5

			if var_33_31 <= arg_30_1.time_ and arg_30_1.time_ < var_33_31 + var_33_33 then
				local var_33_34 = (arg_30_1.time_ - var_33_31) / var_33_33
				local var_33_35 = Mathf.Lerp(arg_30_1.var_.alphaOldValueS0016, 1, var_33_34)

				if arg_30_1.var_.alphaMatValueS0016 then
					local var_33_36 = arg_30_1.var_.alphaMatValueS0016.color

					var_33_36.a = var_33_35
					arg_30_1.var_.alphaMatValueS0016.color = var_33_36
				end
			end

			if arg_30_1.time_ >= var_33_31 + var_33_33 and arg_30_1.time_ < var_33_31 + var_33_33 + arg_33_0 and arg_30_1.var_.alphaMatValueS0016 then
				local var_33_37 = arg_30_1.var_.alphaMatValueS0016
				local var_33_38 = var_33_37.color

				var_33_38.a = 1
				var_33_37.color = var_33_38
			end

			local var_33_39 = arg_30_1.bgs_.S0016.transform
			local var_33_40 = 1.73333333333333

			if var_33_40 < arg_30_1.time_ and arg_30_1.time_ <= var_33_40 + arg_33_0 then
				arg_30_1.var_.moveOldPosS0016 = var_33_39.localPosition
			end

			local var_33_41 = 3.3

			if var_33_40 <= arg_30_1.time_ and arg_30_1.time_ < var_33_40 + var_33_41 then
				local var_33_42 = (arg_30_1.time_ - var_33_40) / var_33_41
				local var_33_43 = Vector3.New(0, 1, 9)

				var_33_39.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPosS0016, var_33_43, var_33_42)
			end

			if arg_30_1.time_ >= var_33_40 + var_33_41 and arg_30_1.time_ < var_33_40 + var_33_41 + arg_33_0 then
				var_33_39.localPosition = Vector3.New(0, 1, 9)
			end

			local var_33_44 = 0

			if var_33_44 < arg_30_1.time_ and arg_30_1.time_ <= var_33_44 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			local var_33_45 = 2.5

			if arg_30_1.time_ >= var_33_44 + var_33_45 and arg_30_1.time_ < var_33_44 + var_33_45 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_46 = 2.5
			local var_33_47 = 0.975

			if var_33_46 < arg_30_1.time_ and arg_30_1.time_ <= var_33_46 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_48 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_48:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_49 = arg_30_1:GetWordFromCfg(100011006)
				local var_33_50 = arg_30_1:FormatText(var_33_49.content)

				arg_30_1.text_.text = var_33_50

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_51 = 43
				local var_33_52 = utf8.len(var_33_50)
				local var_33_53 = var_33_51 <= 0 and var_33_47 or var_33_47 * (var_33_52 / var_33_51)

				if var_33_53 > 0 and var_33_47 < var_33_53 then
					arg_30_1.talkMaxDuration = var_33_53
					var_33_46 = var_33_46 + 0.3

					if var_33_53 + var_33_46 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_53 + var_33_46
					end
				end

				arg_30_1.text_.text = var_33_50
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011006", "story_v_out_100011.awb") ~= 0 then
					local var_33_54 = manager.audio:GetVoiceLength("story_v_out_100011", "100011006", "story_v_out_100011.awb") / 1000

					if var_33_54 + var_33_46 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_54 + var_33_46
					end

					if var_33_49.prefab_name ~= "" and arg_30_1.actors_[var_33_49.prefab_name] ~= nil then
						local var_33_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_49.prefab_name].transform, "story_v_out_100011", "100011006", "story_v_out_100011.awb")

						arg_30_1:RecordAudio("100011006", var_33_55)
						arg_30_1:RecordAudio("100011006", var_33_55)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_100011", "100011006", "story_v_out_100011.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_100011", "100011006", "story_v_out_100011.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_56 = var_33_46 + 0.3
			local var_33_57 = math.max(var_33_47, arg_30_1.talkMaxDuration)

			if var_33_56 <= arg_30_1.time_ and arg_30_1.time_ < var_33_56 + var_33_57 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_56) / var_33_57

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_56 + var_33_57 and arg_30_1.time_ < var_33_56 + var_33_57 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.3,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play100011007 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 100011007
		arg_36_1.duration_ = 13.93

		local var_36_0 = {
			ja = 13.933,
			ko = 12.2,
			zh = 10.7,
			en = 12.733
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play100011008(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.bgs_.S0016.transform
			local var_39_1 = 1

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPosS0016 = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, -100, 10)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPosS0016, var_39_4, var_39_3)
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_39_5 = "S0017"

			if arg_36_1.bgs_[var_39_5] == nil then
				local var_39_6 = Object.Instantiate(arg_36_1.paintGo_)

				var_39_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_39_5)
				var_39_6.name = var_39_5
				var_39_6.transform.parent = arg_36_1.stage_.transform
				var_39_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.bgs_[var_39_5] = var_39_6
			end

			local var_39_7 = 1

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 then
				local var_39_8 = manager.ui.mainCamera.transform.localPosition
				local var_39_9 = Vector3.New(0, 0, 10) + Vector3.New(var_39_8.x, var_39_8.y, 0)
				local var_39_10 = arg_36_1.bgs_.S0017

				var_39_10.transform.localPosition = var_39_9
				var_39_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_11 = var_39_10:GetComponent("SpriteRenderer")

				if var_39_11 and var_39_11.sprite then
					local var_39_12 = (var_39_10.transform.localPosition - var_39_8).z
					local var_39_13 = manager.ui.mainCameraCom_
					local var_39_14 = 2 * var_39_12 * Mathf.Tan(var_39_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_39_15 = var_39_14 * var_39_13.aspect
					local var_39_16 = var_39_11.sprite.bounds.size.x
					local var_39_17 = var_39_11.sprite.bounds.size.y
					local var_39_18 = var_39_15 / var_39_16
					local var_39_19 = var_39_14 / var_39_17
					local var_39_20 = var_39_19 < var_39_18 and var_39_18 or var_39_19

					var_39_10.transform.localScale = Vector3.New(var_39_20, var_39_20, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "S0017" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_21 = arg_36_1.bgs_.S0017
			local var_39_22 = 0

			if var_39_22 < arg_36_1.time_ and arg_36_1.time_ <= var_39_22 + arg_39_0 then
				local var_39_23 = var_39_21:GetComponent("SpriteRenderer")

				if var_39_23 then
					arg_36_1.var_.alphaOldValueS0017 = var_39_23.color.a
					arg_36_1.var_.alphaMatValueS0017 = var_39_23
				end

				arg_36_1.var_.alphaOldValueS0017 = 1
			end

			local var_39_24 = 1

			if var_39_22 <= arg_36_1.time_ and arg_36_1.time_ < var_39_22 + var_39_24 then
				local var_39_25 = (arg_36_1.time_ - var_39_22) / var_39_24
				local var_39_26 = Mathf.Lerp(arg_36_1.var_.alphaOldValueS0017, 0, var_39_25)

				if arg_36_1.var_.alphaMatValueS0017 then
					local var_39_27 = arg_36_1.var_.alphaMatValueS0017.color

					var_39_27.a = var_39_26
					arg_36_1.var_.alphaMatValueS0017.color = var_39_27
				end
			end

			if arg_36_1.time_ >= var_39_22 + var_39_24 and arg_36_1.time_ < var_39_22 + var_39_24 + arg_39_0 and arg_36_1.var_.alphaMatValueS0017 then
				local var_39_28 = arg_36_1.var_.alphaMatValueS0017
				local var_39_29 = var_39_28.color

				var_39_29.a = 0
				var_39_28.color = var_39_29
			end

			local var_39_30 = arg_36_1.bgs_.S0017
			local var_39_31 = 1

			if var_39_31 < arg_36_1.time_ and arg_36_1.time_ <= var_39_31 + arg_39_0 then
				local var_39_32 = var_39_30:GetComponent("SpriteRenderer")

				if var_39_32 then
					arg_36_1.var_.alphaOldValueS0017 = var_39_32.color.a
					arg_36_1.var_.alphaMatValueS0017 = var_39_32
				end

				arg_36_1.var_.alphaOldValueS0017 = 0
			end

			local var_39_33 = 1

			if var_39_31 <= arg_36_1.time_ and arg_36_1.time_ < var_39_31 + var_39_33 then
				local var_39_34 = (arg_36_1.time_ - var_39_31) / var_39_33
				local var_39_35 = Mathf.Lerp(arg_36_1.var_.alphaOldValueS0017, 1, var_39_34)

				if arg_36_1.var_.alphaMatValueS0017 then
					local var_39_36 = arg_36_1.var_.alphaMatValueS0017.color

					var_39_36.a = var_39_35
					arg_36_1.var_.alphaMatValueS0017.color = var_39_36
				end
			end

			if arg_36_1.time_ >= var_39_31 + var_39_33 and arg_36_1.time_ < var_39_31 + var_39_33 + arg_39_0 and arg_36_1.var_.alphaMatValueS0017 then
				local var_39_37 = arg_36_1.var_.alphaMatValueS0017
				local var_39_38 = var_39_37.color

				var_39_38.a = 1
				var_39_37.color = var_39_38
			end

			local var_39_39 = arg_36_1.bgs_.S0017.transform
			local var_39_40 = 1.5

			if var_39_40 < arg_36_1.time_ and arg_36_1.time_ <= var_39_40 + arg_39_0 then
				arg_36_1.var_.moveOldPosS0017 = var_39_39.localPosition
			end

			local var_39_41 = 1.8

			if var_39_40 <= arg_36_1.time_ and arg_36_1.time_ < var_39_40 + var_39_41 then
				local var_39_42 = (arg_36_1.time_ - var_39_40) / var_39_41
				local var_39_43 = Vector3.New(0, 1, 9)

				var_39_39.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPosS0017, var_39_43, var_39_42)
			end

			if arg_36_1.time_ >= var_39_40 + var_39_41 and arg_36_1.time_ < var_39_40 + var_39_41 + arg_39_0 then
				var_39_39.localPosition = Vector3.New(0, 1, 9)
			end

			local var_39_44 = 0

			if var_39_44 < arg_36_1.time_ and arg_36_1.time_ <= var_39_44 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_45 = 2

			if arg_36_1.time_ >= var_39_44 + var_39_45 and arg_36_1.time_ < var_39_44 + var_39_45 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_46 = 2
			local var_39_47 = 1.65

			if var_39_46 < arg_36_1.time_ and arg_36_1.time_ <= var_39_46 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_48 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_48:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_49 = arg_36_1:GetWordFromCfg(100011007)
				local var_39_50 = arg_36_1:FormatText(var_39_49.content)

				arg_36_1.text_.text = var_39_50

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_51 = 39
				local var_39_52 = utf8.len(var_39_50)
				local var_39_53 = var_39_51 <= 0 and var_39_47 or var_39_47 * (var_39_52 / var_39_51)

				if var_39_53 > 0 and var_39_47 < var_39_53 then
					arg_36_1.talkMaxDuration = var_39_53
					var_39_46 = var_39_46 + 0.3

					if var_39_53 + var_39_46 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_53 + var_39_46
					end
				end

				arg_36_1.text_.text = var_39_50
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011007", "story_v_out_100011.awb") ~= 0 then
					local var_39_54 = manager.audio:GetVoiceLength("story_v_out_100011", "100011007", "story_v_out_100011.awb") / 1000

					if var_39_54 + var_39_46 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_54 + var_39_46
					end

					if var_39_49.prefab_name ~= "" and arg_36_1.actors_[var_39_49.prefab_name] ~= nil then
						local var_39_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_49.prefab_name].transform, "story_v_out_100011", "100011007", "story_v_out_100011.awb")

						arg_36_1:RecordAudio("100011007", var_39_55)
						arg_36_1:RecordAudio("100011007", var_39_55)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_100011", "100011007", "story_v_out_100011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_100011", "100011007", "story_v_out_100011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_56 = var_39_46 + 0.3
			local var_39_57 = math.max(var_39_47, arg_36_1.talkMaxDuration)

			if var_39_56 <= arg_36_1.time_ and arg_36_1.time_ < var_39_56 + var_39_57 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_56) / var_39_57

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_56 + var_39_57 and arg_36_1.time_ < var_39_56 + var_39_57 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.8,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play100011008 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 100011008
		arg_42_1.duration_ = 14.3

		local var_42_0 = {
			ja = 14.3,
			ko = 10.466,
			zh = 10.266,
			en = 11.4
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play100011009(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.bgs_.S0017.transform
			local var_45_1 = 1

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPosS0017 = var_45_0.localPosition
			end

			local var_45_2 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2
				local var_45_4 = Vector3.New(0, -100, 10)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPosS0017, var_45_4, var_45_3)
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_45_5 = "S0013"

			if arg_42_1.bgs_[var_45_5] == nil then
				local var_45_6 = Object.Instantiate(arg_42_1.paintGo_)

				var_45_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_45_5)
				var_45_6.name = var_45_5
				var_45_6.transform.parent = arg_42_1.stage_.transform
				var_45_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_42_1.bgs_[var_45_5] = var_45_6
			end

			local var_45_7 = 1

			if var_45_7 < arg_42_1.time_ and arg_42_1.time_ <= var_45_7 + arg_45_0 then
				local var_45_8 = manager.ui.mainCamera.transform.localPosition
				local var_45_9 = Vector3.New(0, 0, 10) + Vector3.New(var_45_8.x, var_45_8.y, 0)
				local var_45_10 = arg_42_1.bgs_.S0013

				var_45_10.transform.localPosition = var_45_9
				var_45_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_11 = var_45_10:GetComponent("SpriteRenderer")

				if var_45_11 and var_45_11.sprite then
					local var_45_12 = (var_45_10.transform.localPosition - var_45_8).z
					local var_45_13 = manager.ui.mainCameraCom_
					local var_45_14 = 2 * var_45_12 * Mathf.Tan(var_45_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_45_15 = var_45_14 * var_45_13.aspect
					local var_45_16 = var_45_11.sprite.bounds.size.x
					local var_45_17 = var_45_11.sprite.bounds.size.y
					local var_45_18 = var_45_15 / var_45_16
					local var_45_19 = var_45_14 / var_45_17
					local var_45_20 = var_45_19 < var_45_18 and var_45_18 or var_45_19

					var_45_10.transform.localScale = Vector3.New(var_45_20, var_45_20, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "S0013" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_21 = arg_42_1.bgs_.S0017
			local var_45_22 = 0

			if var_45_22 < arg_42_1.time_ and arg_42_1.time_ <= var_45_22 + arg_45_0 then
				local var_45_23 = var_45_21:GetComponent("SpriteRenderer")

				if var_45_23 then
					arg_42_1.var_.alphaOldValueS0017 = var_45_23.color.a
					arg_42_1.var_.alphaMatValueS0017 = var_45_23
				end

				arg_42_1.var_.alphaOldValueS0017 = 1
			end

			local var_45_24 = 1

			if var_45_22 <= arg_42_1.time_ and arg_42_1.time_ < var_45_22 + var_45_24 then
				local var_45_25 = (arg_42_1.time_ - var_45_22) / var_45_24
				local var_45_26 = Mathf.Lerp(arg_42_1.var_.alphaOldValueS0017, 0, var_45_25)

				if arg_42_1.var_.alphaMatValueS0017 then
					local var_45_27 = arg_42_1.var_.alphaMatValueS0017.color

					var_45_27.a = var_45_26
					arg_42_1.var_.alphaMatValueS0017.color = var_45_27
				end
			end

			if arg_42_1.time_ >= var_45_22 + var_45_24 and arg_42_1.time_ < var_45_22 + var_45_24 + arg_45_0 and arg_42_1.var_.alphaMatValueS0017 then
				local var_45_28 = arg_42_1.var_.alphaMatValueS0017
				local var_45_29 = var_45_28.color

				var_45_29.a = 0
				var_45_28.color = var_45_29
			end

			local var_45_30 = arg_42_1.bgs_.S0013
			local var_45_31 = 1

			if var_45_31 < arg_42_1.time_ and arg_42_1.time_ <= var_45_31 + arg_45_0 then
				local var_45_32 = var_45_30:GetComponent("SpriteRenderer")

				if var_45_32 then
					arg_42_1.var_.alphaOldValueS0013 = var_45_32.color.a
					arg_42_1.var_.alphaMatValueS0013 = var_45_32
				end

				arg_42_1.var_.alphaOldValueS0013 = 0
			end

			local var_45_33 = 1

			if var_45_31 <= arg_42_1.time_ and arg_42_1.time_ < var_45_31 + var_45_33 then
				local var_45_34 = (arg_42_1.time_ - var_45_31) / var_45_33
				local var_45_35 = Mathf.Lerp(arg_42_1.var_.alphaOldValueS0013, 1, var_45_34)

				if arg_42_1.var_.alphaMatValueS0013 then
					local var_45_36 = arg_42_1.var_.alphaMatValueS0013.color

					var_45_36.a = var_45_35
					arg_42_1.var_.alphaMatValueS0013.color = var_45_36
				end
			end

			if arg_42_1.time_ >= var_45_31 + var_45_33 and arg_42_1.time_ < var_45_31 + var_45_33 + arg_45_0 and arg_42_1.var_.alphaMatValueS0013 then
				local var_45_37 = arg_42_1.var_.alphaMatValueS0013
				local var_45_38 = var_45_37.color

				var_45_38.a = 1
				var_45_37.color = var_45_38
			end

			local var_45_39 = arg_42_1.bgs_.S0013.transform
			local var_45_40 = 1.76666666666667

			if var_45_40 < arg_42_1.time_ and arg_42_1.time_ <= var_45_40 + arg_45_0 then
				arg_42_1.var_.moveOldPosS0013 = var_45_39.localPosition
			end

			local var_45_41 = 1.7

			if var_45_40 <= arg_42_1.time_ and arg_42_1.time_ < var_45_40 + var_45_41 then
				local var_45_42 = (arg_42_1.time_ - var_45_40) / var_45_41
				local var_45_43 = Vector3.New(0, 1, 9)

				var_45_39.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPosS0013, var_45_43, var_45_42)
			end

			if arg_42_1.time_ >= var_45_40 + var_45_41 and arg_42_1.time_ < var_45_40 + var_45_41 + arg_45_0 then
				var_45_39.localPosition = Vector3.New(0, 1, 9)
			end

			local var_45_44 = 0

			if var_45_44 < arg_42_1.time_ and arg_42_1.time_ <= var_45_44 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			local var_45_45 = 2

			if arg_42_1.time_ >= var_45_44 + var_45_45 and arg_42_1.time_ < var_45_44 + var_45_45 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_46 = 2
			local var_45_47 = 1.025

			if var_45_46 < arg_42_1.time_ and arg_42_1.time_ <= var_45_46 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_48 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_48:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_49 = arg_42_1:GetWordFromCfg(100011008)
				local var_45_50 = arg_42_1:FormatText(var_45_49.content)

				arg_42_1.text_.text = var_45_50

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_51 = 41
				local var_45_52 = utf8.len(var_45_50)
				local var_45_53 = var_45_51 <= 0 and var_45_47 or var_45_47 * (var_45_52 / var_45_51)

				if var_45_53 > 0 and var_45_47 < var_45_53 then
					arg_42_1.talkMaxDuration = var_45_53
					var_45_46 = var_45_46 + 0.3

					if var_45_53 + var_45_46 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_53 + var_45_46
					end
				end

				arg_42_1.text_.text = var_45_50
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011008", "story_v_out_100011.awb") ~= 0 then
					local var_45_54 = manager.audio:GetVoiceLength("story_v_out_100011", "100011008", "story_v_out_100011.awb") / 1000

					if var_45_54 + var_45_46 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_54 + var_45_46
					end

					if var_45_49.prefab_name ~= "" and arg_42_1.actors_[var_45_49.prefab_name] ~= nil then
						local var_45_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_49.prefab_name].transform, "story_v_out_100011", "100011008", "story_v_out_100011.awb")

						arg_42_1:RecordAudio("100011008", var_45_55)
						arg_42_1:RecordAudio("100011008", var_45_55)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_100011", "100011008", "story_v_out_100011.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_100011", "100011008", "story_v_out_100011.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_56 = var_45_46 + 0.3
			local var_45_57 = math.max(var_45_47, arg_42_1.talkMaxDuration)

			if var_45_56 <= arg_42_1.time_ and arg_42_1.time_ < var_45_56 + var_45_57 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_56) / var_45_57

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_56 + var_45_57 and arg_42_1.time_ < var_45_56 + var_45_57 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0013",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.7,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play100011009 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 100011009
		arg_48_1.duration_ = 6.73

		local var_48_0 = {
			ja = 5.8,
			ko = 4.933,
			zh = 5.033,
			en = 6.733
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play100011010(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.bgs_.S0013.transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPosS0013 = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, 1, 9)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPosS0013, var_51_4, var_51_3)
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, 1, 9)
			end

			local var_51_5 = arg_48_1.bgs_.S0013.transform
			local var_51_6 = 0.0166666666666667

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.var_.moveOldPosS0013 = var_51_5.localPosition
			end

			local var_51_7 = 1.7

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_7 then
				local var_51_8 = (arg_48_1.time_ - var_51_6) / var_51_7
				local var_51_9 = Vector3.New(0.32, 0.72, 8)

				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPosS0013, var_51_9, var_51_8)
			end

			if arg_48_1.time_ >= var_51_6 + var_51_7 and arg_48_1.time_ < var_51_6 + var_51_7 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(0.32, 0.72, 8)
			end

			local var_51_10 = 0
			local var_51_11 = 0.8

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_12 = arg_48_1:GetWordFromCfg(100011009)
				local var_51_13 = arg_48_1:FormatText(var_51_12.content)

				arg_48_1.text_.text = var_51_13

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_14 = 21
				local var_51_15 = utf8.len(var_51_13)
				local var_51_16 = var_51_14 <= 0 and var_51_11 or var_51_11 * (var_51_15 / var_51_14)

				if var_51_16 > 0 and var_51_11 < var_51_16 then
					arg_48_1.talkMaxDuration = var_51_16

					if var_51_16 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_16 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_13
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011009", "story_v_out_100011.awb") ~= 0 then
					local var_51_17 = manager.audio:GetVoiceLength("story_v_out_100011", "100011009", "story_v_out_100011.awb") / 1000

					if var_51_17 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_10
					end

					if var_51_12.prefab_name ~= "" and arg_48_1.actors_[var_51_12.prefab_name] ~= nil then
						local var_51_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_12.prefab_name].transform, "story_v_out_100011", "100011009", "story_v_out_100011.awb")

						arg_48_1:RecordAudio("100011009", var_51_18)
						arg_48_1:RecordAudio("100011009", var_51_18)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_100011", "100011009", "story_v_out_100011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_100011", "100011009", "story_v_out_100011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_19 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_19 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_19

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_19 and arg_48_1.time_ < var_51_10 + var_51_19 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0013",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0013",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.7,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play100011010 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 100011010
		arg_52_1.duration_ = 13.43

		local var_52_0 = {
			ja = 13.4,
			ko = 11.4,
			zh = 9.933,
			en = 13.433
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play100011011(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.bgs_.S0013.transform
			local var_55_1 = 1

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0013 = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, -100, 10)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0013, var_55_4, var_55_3)
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_55_5 = "S0014"

			if arg_52_1.bgs_[var_55_5] == nil then
				local var_55_6 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_5)
				var_55_6.name = var_55_5
				var_55_6.transform.parent = arg_52_1.stage_.transform
				var_55_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_5] = var_55_6
			end

			local var_55_7 = 1

			if var_55_7 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				local var_55_8 = manager.ui.mainCamera.transform.localPosition
				local var_55_9 = Vector3.New(0, 0, 10) + Vector3.New(var_55_8.x, var_55_8.y, 0)
				local var_55_10 = arg_52_1.bgs_.S0014

				var_55_10.transform.localPosition = var_55_9
				var_55_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_11 = var_55_10:GetComponent("SpriteRenderer")

				if var_55_11 and var_55_11.sprite then
					local var_55_12 = (var_55_10.transform.localPosition - var_55_8).z
					local var_55_13 = manager.ui.mainCameraCom_
					local var_55_14 = 2 * var_55_12 * Mathf.Tan(var_55_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_15 = var_55_14 * var_55_13.aspect
					local var_55_16 = var_55_11.sprite.bounds.size.x
					local var_55_17 = var_55_11.sprite.bounds.size.y
					local var_55_18 = var_55_15 / var_55_16
					local var_55_19 = var_55_14 / var_55_17
					local var_55_20 = var_55_19 < var_55_18 and var_55_18 or var_55_19

					var_55_10.transform.localScale = Vector3.New(var_55_20, var_55_20, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "S0014" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_21 = 0

			if var_55_21 < arg_52_1.time_ and arg_52_1.time_ <= var_55_21 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_22 = 1

			if var_55_21 <= arg_52_1.time_ and arg_52_1.time_ < var_55_21 + var_55_22 then
				local var_55_23 = (arg_52_1.time_ - var_55_21) / var_55_22
				local var_55_24 = Color.New(1, 1, 1)

				var_55_24.a = Mathf.Lerp(0, 1, var_55_23)
				arg_52_1.mask_.color = var_55_24
			end

			if arg_52_1.time_ >= var_55_21 + var_55_22 and arg_52_1.time_ < var_55_21 + var_55_22 + arg_55_0 then
				local var_55_25 = Color.New(1, 1, 1)

				var_55_25.a = 1
				arg_52_1.mask_.color = var_55_25
			end

			local var_55_26 = 1

			if var_55_26 < arg_52_1.time_ and arg_52_1.time_ <= var_55_26 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_27 = 1

			if var_55_26 <= arg_52_1.time_ and arg_52_1.time_ < var_55_26 + var_55_27 then
				local var_55_28 = (arg_52_1.time_ - var_55_26) / var_55_27
				local var_55_29 = Color.New(1, 1, 1)

				var_55_29.a = Mathf.Lerp(1, 0, var_55_28)
				arg_52_1.mask_.color = var_55_29
			end

			if arg_52_1.time_ >= var_55_26 + var_55_27 and arg_52_1.time_ < var_55_26 + var_55_27 + arg_55_0 then
				local var_55_30 = Color.New(1, 1, 1)
				local var_55_31 = 0

				arg_52_1.mask_.enabled = false
				var_55_30.a = var_55_31
				arg_52_1.mask_.color = var_55_30
			end

			local var_55_32 = arg_52_1.bgs_.S0014.transform
			local var_55_33 = 1

			if var_55_33 < arg_52_1.time_ and arg_52_1.time_ <= var_55_33 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0014 = var_55_32.localPosition
			end

			local var_55_34 = 0.001

			if var_55_33 <= arg_52_1.time_ and arg_52_1.time_ < var_55_33 + var_55_34 then
				local var_55_35 = (arg_52_1.time_ - var_55_33) / var_55_34
				local var_55_36 = Vector3.New(0, 1, 7)

				var_55_32.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0014, var_55_36, var_55_35)
			end

			if arg_52_1.time_ >= var_55_33 + var_55_34 and arg_52_1.time_ < var_55_33 + var_55_34 + arg_55_0 then
				var_55_32.localPosition = Vector3.New(0, 1, 7)
			end

			local var_55_37 = 0

			if var_55_37 < arg_52_1.time_ and arg_52_1.time_ <= var_55_37 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_38 = 2

			if arg_52_1.time_ >= var_55_37 + var_55_38 and arg_52_1.time_ < var_55_37 + var_55_38 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_39 = 2
			local var_55_40 = 1.025

			if var_55_39 < arg_52_1.time_ and arg_52_1.time_ <= var_55_39 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_41 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_41:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_42 = arg_52_1:GetWordFromCfg(100011010)
				local var_55_43 = arg_52_1:FormatText(var_55_42.content)

				arg_52_1.text_.text = var_55_43

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_44 = 41
				local var_55_45 = utf8.len(var_55_43)
				local var_55_46 = var_55_44 <= 0 and var_55_40 or var_55_40 * (var_55_45 / var_55_44)

				if var_55_46 > 0 and var_55_40 < var_55_46 then
					arg_52_1.talkMaxDuration = var_55_46
					var_55_39 = var_55_39 + 0.3

					if var_55_46 + var_55_39 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_46 + var_55_39
					end
				end

				arg_52_1.text_.text = var_55_43
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011010", "story_v_out_100011.awb") ~= 0 then
					local var_55_47 = manager.audio:GetVoiceLength("story_v_out_100011", "100011010", "story_v_out_100011.awb") / 1000

					if var_55_47 + var_55_39 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_47 + var_55_39
					end

					if var_55_42.prefab_name ~= "" and arg_52_1.actors_[var_55_42.prefab_name] ~= nil then
						local var_55_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_42.prefab_name].transform, "story_v_out_100011", "100011010", "story_v_out_100011.awb")

						arg_52_1:RecordAudio("100011010", var_55_48)
						arg_52_1:RecordAudio("100011010", var_55_48)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_100011", "100011010", "story_v_out_100011.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_100011", "100011010", "story_v_out_100011.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_49 = var_55_39 + 0.3
			local var_55_50 = math.max(var_55_40, arg_52_1.talkMaxDuration)

			if var_55_49 <= arg_52_1.time_ and arg_52_1.time_ < var_55_49 + var_55_50 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_49) / var_55_50

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_49 + var_55_50 and arg_52_1.time_ < var_55_49 + var_55_50 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0013",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0014",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play100011011 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 100011011
		arg_58_1.duration_ = 10.43

		local var_58_0 = {
			ja = 10.433,
			ko = 7.233,
			zh = 6.833,
			en = 9.266
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
				arg_58_0:Play100011012(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.bgs_.S0014.transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.moveOldPosS0014 = var_61_0.localPosition
			end

			local var_61_2 = 0.001

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2
				local var_61_4 = Vector3.New(0, 1, 7)

				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPosS0014, var_61_4, var_61_3)
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(0, 1, 7)
			end

			local var_61_5 = arg_58_1.bgs_.S0014.transform
			local var_61_6 = 0.0166666666666667

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.var_.moveOldPosS0014 = var_61_5.localPosition
			end

			local var_61_7 = 3

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_7 then
				local var_61_8 = (arg_58_1.time_ - var_61_6) / var_61_7
				local var_61_9 = Vector3.New(0, 1, 10)

				var_61_5.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPosS0014, var_61_9, var_61_8)
			end

			if arg_58_1.time_ >= var_61_6 + var_61_7 and arg_58_1.time_ < var_61_6 + var_61_7 + arg_61_0 then
				var_61_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_61_10 = 0
			local var_61_11 = 0.8

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_12 = arg_58_1:GetWordFromCfg(100011011)
				local var_61_13 = arg_58_1:FormatText(var_61_12.content)

				arg_58_1.text_.text = var_61_13

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_14 = 32
				local var_61_15 = utf8.len(var_61_13)
				local var_61_16 = var_61_14 <= 0 and var_61_11 or var_61_11 * (var_61_15 / var_61_14)

				if var_61_16 > 0 and var_61_11 < var_61_16 then
					arg_58_1.talkMaxDuration = var_61_16

					if var_61_16 + var_61_10 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_16 + var_61_10
					end
				end

				arg_58_1.text_.text = var_61_13
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011011", "story_v_out_100011.awb") ~= 0 then
					local var_61_17 = manager.audio:GetVoiceLength("story_v_out_100011", "100011011", "story_v_out_100011.awb") / 1000

					if var_61_17 + var_61_10 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_17 + var_61_10
					end

					if var_61_12.prefab_name ~= "" and arg_58_1.actors_[var_61_12.prefab_name] ~= nil then
						local var_61_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_12.prefab_name].transform, "story_v_out_100011", "100011011", "story_v_out_100011.awb")

						arg_58_1:RecordAudio("100011011", var_61_18)
						arg_58_1:RecordAudio("100011011", var_61_18)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_100011", "100011011", "story_v_out_100011.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_100011", "100011011", "story_v_out_100011.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_19 = math.max(var_61_11, arg_58_1.talkMaxDuration)

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_19 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_10) / var_61_19

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_10 + var_61_19 and arg_58_1.time_ < var_61_10 + var_61_19 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0014",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0014",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play100011012 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 100011012
		arg_62_1.duration_ = 15.07

		local var_62_0 = {
			ja = 15.066,
			ko = 9.6,
			zh = 8.766,
			en = 13.5
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
			arg_62_1.auto_ = false
		end

		function arg_62_1.playNext_(arg_64_0)
			arg_62_1.onStoryFinished_()
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 1.075

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_2 = arg_62_1:GetWordFromCfg(100011012)
				local var_65_3 = arg_62_1:FormatText(var_65_2.content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 43
				local var_65_5 = utf8.len(var_65_3)
				local var_65_6 = var_65_4 <= 0 and var_65_1 or var_65_1 * (var_65_5 / var_65_4)

				if var_65_6 > 0 and var_65_1 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011012", "story_v_out_100011.awb") ~= 0 then
					local var_65_7 = manager.audio:GetVoiceLength("story_v_out_100011", "100011012", "story_v_out_100011.awb") / 1000

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end

					if var_65_2.prefab_name ~= "" and arg_62_1.actors_[var_65_2.prefab_name] ~= nil then
						local var_65_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_2.prefab_name].transform, "story_v_out_100011", "100011012", "story_v_out_100011.awb")

						arg_62_1:RecordAudio("100011012", var_65_8)
						arg_62_1:RecordAudio("100011012", var_65_8)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_100011", "100011012", "story_v_out_100011.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_100011", "100011012", "story_v_out_100011.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_9 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_9 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_9

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_9 and arg_62_1.time_ < var_65_0 + var_65_9 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/S0015",
		"TextureConfig/Background/S0011",
		"TextureConfig/Background/S0012",
		"TextureConfig/Background/S0016",
		"TextureConfig/Background/S0017",
		"TextureConfig/Background/S0013",
		"TextureConfig/Background/S0014"
	},
	voices = {
		"story_v_out_100011.awb"
	}
}
