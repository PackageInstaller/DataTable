return {
	Play322011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322011001
		arg_1_1.duration_ = 7.13

		local var_1_0 = {
			zh = 6.833,
			ja = 7.133
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
				arg_1_0:Play322011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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
				local var_4_9 = arg_1_1.var_.effect1001

				if not arg_1_1.var_.effect1001 then
					var_4_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_wasteland_in_keep"), manager.ui.mainCamera.transform)
					var_4_9.name = "1001"
					arg_1_1.var_.effect1001 = var_4_9
				else
					var_4_9.transform:SetParent(var_4_9000)
				end

				var_4_9.transform.localPosition = Vector3.New(0, 0, -0.04)
				var_4_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire", "")
			end

			local var_4_15 = 2
			local var_4_16 = 0.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:GetWordFromCfg(322011001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 19 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 19)

				if (19 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 19)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011001", "story_v_out_322011.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_322011", "322011001", "story_v_out_322011.awb") / 1000

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_322011", "322011001", "story_v_out_322011.awb")

						arg_1_1:RecordAudio("322011001", var_4_22)
						arg_1_1:RecordAudio("322011001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322011", "322011001", "story_v_out_322011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322011", "322011001", "story_v_out_322011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_15) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_15 + var_4_23 and arg_1_1.time_ < var_4_15 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322011002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 322011002
		arg_6_1.duration_ = 2.27

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play322011003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0.125

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0
				arg_6_1.dialogCg_.alpha = 1

				arg_6_1.dialog_:SetActive(true)
				SetActive(arg_6_1.leftNameGo_, true)

				arg_6_1.leftNameTxt_.text = arg_6_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, true)
				arg_6_1.iconController_:SetSelectedState("hero")

				arg_6_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10150")

				arg_6_1.callingController_:SetSelectedState("normal")

				arg_6_1.keyicon_.color = Color.New(1, 1, 1)
				arg_6_1.icon_.color = Color.New(1, 1, 1)

				local var_9_1 = arg_6_1:GetWordFromCfg(322011002)
				local var_9_2 = arg_6_1:FormatText(var_9_1.content)

				arg_6_1.text_.text = var_9_2

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_4 = 5 <= 0 and var_9_0 or var_9_0 * (utf8.len(var_9_2) / 5)

				if (5 <= 0 and var_9_0 or var_9_0 * (utf8.len(var_9_2) / 5)) > 0 and var_9_0 < var_9_4 then
					arg_6_1.talkMaxDuration = var_9_4

					if var_9_4 + 0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_4 + 0
					end
				end

				arg_6_1.text_.text = var_9_2
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011002", "story_v_out_322011.awb") ~= 0 then
					local var_9_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011002", "story_v_out_322011.awb") / 1000

					if var_9_5 + 0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_5 + 0
					end

					if var_9_1.prefab_name ~= "" and arg_6_1.actors_[var_9_1.prefab_name] ~= nil then
						local var_9_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_6_1.actors_[var_9_1.prefab_name].transform, "story_v_out_322011", "322011002", "story_v_out_322011.awb")

						arg_6_1:RecordAudio("322011002", var_9_6)
						arg_6_1:RecordAudio("322011002", var_9_6)
					else
						arg_6_1:AudioAction("play", "voice", "story_v_out_322011", "322011002", "story_v_out_322011.awb")
					end

					arg_6_1:RecordHistoryTalkVoice("story_v_out_322011", "322011002", "story_v_out_322011.awb")
				end

				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_7 = math.max(var_9_0, arg_6_1.talkMaxDuration)

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_7 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - 0) / var_9_7

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= 0 + var_9_7 and arg_6_1.time_ < 0 + var_9_7 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play322011003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322011003
		arg_10_1.duration_ = 2.67

		local var_10_0 = {
			zh = 2.666,
			ja = 2.566
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322011004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_13_0 = 0.25

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_0 then
				local var_13_1, var_13_2 = math.modf((arg_10_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_13_2 * 0.13, var_13_2 * 0.13, var_13_2 * 0.13) + arg_10_1.var_.shakeOldPos
			end

			if arg_10_1.time_ >= 0 + var_13_0 and arg_10_1.time_ < 0 + var_13_0 + arg_13_0 then
				manager.ui.mainCamera.transform.localPosition = arg_10_1.var_.shakeOldPos
			end

			local var_13_3 = 0
			local var_13_4 = 0.25

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_5 = arg_10_1:GetWordFromCfg(322011003)
				local var_13_6 = arg_10_1:FormatText(var_13_5.content)

				arg_10_1.text_.text = var_13_6

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_8 = 10 <= 0 and var_13_4 or var_13_4 * (utf8.len(var_13_6) / 10)

				if (10 <= 0 and var_13_4 or var_13_4 * (utf8.len(var_13_6) / 10)) > 0 and var_13_4 < var_13_8 then
					arg_10_1.talkMaxDuration = var_13_8

					if var_13_8 + var_13_3 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_8 + var_13_3
					end
				end

				arg_10_1.text_.text = var_13_6
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011003", "story_v_out_322011.awb") ~= 0 then
					local var_13_9 = manager.audio:GetVoiceLength("story_v_out_322011", "322011003", "story_v_out_322011.awb") / 1000

					if var_13_9 + var_13_3 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_9 + var_13_3
					end

					if var_13_5.prefab_name ~= "" and arg_10_1.actors_[var_13_5.prefab_name] ~= nil then
						local var_13_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_5.prefab_name].transform, "story_v_out_322011", "322011003", "story_v_out_322011.awb")

						arg_10_1:RecordAudio("322011003", var_13_10)
						arg_10_1:RecordAudio("322011003", var_13_10)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_322011", "322011003", "story_v_out_322011.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_322011", "322011003", "story_v_out_322011.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_11 = math.max(var_13_4, arg_10_1.talkMaxDuration)

			if var_13_3 <= arg_10_1.time_ and arg_10_1.time_ < var_13_3 + var_13_11 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_3) / var_13_11

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_3 + var_13_11 and arg_10_1.time_ < var_13_3 + var_13_11 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play322011004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322011004
		arg_14_1.duration_ = 2.76

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322011005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_0 = 1

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 then
				local var_17_1 = Color.New(0, 0, 0)

				var_17_1.a = Mathf.Lerp(0, 1, (arg_14_1.time_ - 0) / var_17_0)
				arg_14_1.mask_.color = var_17_1
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 then
				local var_17_2 = Color.New(0, 0, 0)

				var_17_2.a = 1
				arg_14_1.mask_.color = var_17_2
			end

			local var_17_3 = 1

			if 1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_3 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_4 = 1

			if var_17_3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_3 + var_17_4 then
				local var_17_5 = Color.New(0, 0, 0)

				var_17_5.a = Mathf.Lerp(1, 0, (arg_14_1.time_ - var_17_3) / var_17_4)
				arg_14_1.mask_.color = var_17_5
			end

			if arg_14_1.time_ >= var_17_3 + var_17_4 and arg_14_1.time_ < var_17_3 + var_17_4 + arg_17_0 then
				local var_17_6 = Color.New(0, 0, 0)

				arg_14_1.mask_.enabled = false
				var_17_6.a = 0
				arg_14_1.mask_.color = var_17_6
			end

			if 0.983333333333333 < arg_14_1.time_ and arg_14_1.time_ <= 0.983333333333333 + arg_17_0 then
				if arg_14_1.var_.effect1001 then
					Object.Destroy(arg_14_1.var_.effect1001)

					arg_14_1.var_.effect1001 = nil
				end
			end

			if 0.983333333333333 < arg_14_1.time_ and arg_14_1.time_ <= 0.983333333333333 + arg_17_0 then
				if arg_14_1.var_.effect1001 then
					Object.Destroy(arg_14_1.var_.effect1001)

					arg_14_1.var_.effect1001 = nil
				end
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322011004,
				charCount = 12,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 0.8,
				groupID = "1004",
				startTime = 1.95953700141981,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.DISABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 419161,
				charCount = 2,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 1,
				groupID = "10042",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.DISABLE,
					bgColor = Color.New(0, 0, 0, 1)
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play322011005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322011005
		arg_18_1.duration_ = 4

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play322011006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			return
		end

		arg_18_1.nodeConfigList_ = {
			{
				groupID = "1004",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322011005,
				charCount = 45,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 3,
				groupID = "1005",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.DISABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play322011006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322011006
		arg_22_1.duration_ = 3

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322011007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = manager.audio:GetVoiceLength("story_v_out_322011", "322011006", "story_v_out_322011.awb") / 1000

			if var_25_0 > 0 and 3 < var_25_0 and var_25_0 + 0 > arg_22_1.duration_ then
				arg_22_1.duration_ = var_25_0 + 0
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:AudioAction("play", "voice", "story_v_out_322011", "322011006", "story_v_out_322011.awb")
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				groupID = "1005",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322011006,
				charCount = 8,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 0.533333333333333,
				groupID = "1006",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.DISABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play322011007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 322011007
		arg_26_1.duration_ = 5.13

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play322011008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = manager.audio:GetVoiceLength("story_v_out_322011", "322011007", "story_v_out_322011.awb") / 1000

			if var_29_0 > 0 and 5.133 < var_29_0 and var_29_0 + 0 > arg_26_1.duration_ then
				arg_26_1.duration_ = var_29_0 + 0
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:AudioAction("play", "voice", "story_v_out_322011", "322011007", "story_v_out_322011.awb")
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				groupID = "1006",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322011007,
				charCount = 8,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 0.533333333333333,
				groupID = "1007",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.DISABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play322011008 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 322011008
		arg_30_1.duration_ = 1.67

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play322011009(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = manager.audio:GetVoiceLength("story_v_out_322011", "322011008", "story_v_out_322011.awb") / 1000

			if var_33_0 > 0 and 1.666 < var_33_0 and var_33_0 + 0 > arg_30_1.duration_ then
				arg_30_1.duration_ = var_33_0 + 0
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:AudioAction("play", "voice", "story_v_out_322011", "322011008", "story_v_out_322011.awb")
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				groupID = "1007",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = true,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				contentID = 322011008,
				charCount = 5,
				enableEffect = true,
				enableLayoutChange = true,
				duration = 0.333333333333333,
				groupID = "1008",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				bgData = {
					bgActionType = StoryPlayerConst.TEXT_GROUP_BG_ACTION_TYPE.DISABLE,
					bgColor = Color.New(0, 0, 0, 0.5)
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play322011009 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 322011009
		arg_34_1.duration_ = 7.77

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play322011010(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_9000

			if arg_34_1.bgs_.L10f == nil then
				local var_37_0 = Object.Instantiate(arg_34_1.paintGo_)

				var_37_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10f")
				var_37_0.name = "L10f"
				var_37_0.transform.parent = arg_34_1.stage_.transform
				var_37_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.bgs_.L10f = var_37_0
			end

			if 1 < arg_34_1.time_ and arg_34_1.time_ <= 1 + arg_37_0 then
				local var_37_1 = arg_34_1.bgs_.L10f

				arg_34_1.bgs_.L10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_37_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_2 = var_37_1:GetComponent("SpriteRenderer")

				if var_37_2 and var_37_2.sprite then
					local var_37_3 = 2 * (var_37_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_37_1.transform.localScale = Vector3.New(var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "L10f" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_4 = 2.76666666666667

			if 2.76666666666667 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			if arg_34_1.time_ >= var_37_4 + 0.3 and arg_34_1.time_ < var_37_4 + 0.3 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			local var_37_5 = 0

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_6 = 1

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 then
				local var_37_7 = Color.New(0, 0, 0)

				var_37_7.a = Mathf.Lerp(0, 1, (arg_34_1.time_ - var_37_5) / var_37_6)
				arg_34_1.mask_.color = var_37_7
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 then
				local var_37_8 = Color.New(0, 0, 0)

				var_37_8.a = 1
				arg_34_1.mask_.color = var_37_8
			end

			local var_37_9 = 1

			if 1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_9 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_10 = 0.0166666666666667

			if var_37_9 <= arg_34_1.time_ and arg_34_1.time_ < var_37_9 + var_37_10 then
				local var_37_11 = Color.New(0, 0, 0)

				var_37_11.a = Mathf.Lerp(1, 0, (arg_34_1.time_ - var_37_9) / var_37_10)
				arg_34_1.mask_.color = var_37_11
			end

			if arg_34_1.time_ >= var_37_9 + var_37_10 and arg_34_1.time_ < var_37_9 + var_37_10 + arg_37_0 then
				local var_37_12 = Color.New(0, 0, 0)

				arg_34_1.mask_.enabled = false
				var_37_12.a = 0
				arg_34_1.mask_.color = var_37_12
			end

			if 1 < arg_34_1.time_ and arg_34_1.time_ <= 1 + arg_37_0 then
				local var_37_13 = arg_34_1.var_.effect1009

				if not arg_34_1.var_.effect1009 then
					var_37_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), manager.ui.mainCamera.transform)
					var_37_13.name = "1009"
					arg_34_1.var_.effect1009 = var_37_13
				else
					var_37_13.transform:SetParent(var_37_9000)
				end

				var_37_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_37_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.76666666666667 < arg_34_1.time_ and arg_34_1.time_ <= 2.76666666666667 + arg_37_0 then
				if arg_34_1.var_.effect1009 then
					Object.Destroy(arg_34_1.var_.effect1009)

					arg_34_1.var_.effect1009 = nil
				end
			end

			local var_37_16 = 1

			arg_34_1.isInRecall_ = false

			if var_37_16 < arg_34_1.time_ and arg_34_1.time_ <= var_37_16 + arg_37_0 then
				arg_34_1.screenFilterGo_:SetActive(true)

				arg_34_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_37_2, iter_37_3 in pairs(arg_34_1.actors_) do
					for iter_37_4, iter_37_5 in ipairs((iter_37_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_37_5.color = iter_37_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_37_17 = 0.0166666666666667

			if var_37_16 <= arg_34_1.time_ and arg_34_1.time_ < var_37_16 + var_37_17 then
				arg_34_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_34_1.time_ - var_37_16) / var_37_17)
			end

			if arg_34_1.time_ >= var_37_16 + var_37_17 and arg_34_1.time_ < var_37_16 + var_37_17 + arg_37_0 then
				arg_34_1.screenFilterEffect_.weight = 1
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_37_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_34_1.bgmTxt_.text ~= var_37_20 and arg_34_1.bgmTxt_.text ~= "" then
						if arg_34_1.bgmTxt2_.text ~= "" then
							arg_34_1.bgmTxt_.text = arg_34_1.bgmTxt2_.text
						end

						arg_34_1.bgmTxt2_.text = var_37_20

						arg_34_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_34_1.bgmTxt_.text = var_37_20
						arg_34_1.bgmTxt2_.text = var_37_20
					end

					if arg_34_1.bgmTimer then
						arg_34_1.bgmTimer:Stop()

						arg_34_1.bgmTimer = nil
					end

					if arg_34_1.settingData.show_music_name == 1 then
						arg_34_1.musicController:SetSelectedState("show")
						arg_34_1.musicAnimator_:Play("open", 0, 0)

						if arg_34_1.settingData.music_time ~= 0 then
							arg_34_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_34_1.settingData.music_time), function()
								if arg_34_1 == nil or isNil(arg_34_1.bgmTxt_) then
									return
								end

								arg_34_1.musicController:SetSelectedState("hide")
								arg_34_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_34_1.time_ and arg_34_1.time_ <= 0.433333333333333 + arg_37_0 then
				arg_34_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_37_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				if "" ~= "" then
					if arg_34_1.bgmTxt_.text ~= var_37_23 and arg_34_1.bgmTxt_.text ~= "" then
						if arg_34_1.bgmTxt2_.text ~= "" then
							arg_34_1.bgmTxt_.text = arg_34_1.bgmTxt2_.text
						end

						arg_34_1.bgmTxt2_.text = var_37_23

						arg_34_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_34_1.bgmTxt_.text = var_37_23
						arg_34_1.bgmTxt2_.text = var_37_23
					end

					if arg_34_1.bgmTimer then
						arg_34_1.bgmTimer:Stop()

						arg_34_1.bgmTimer = nil
					end

					if arg_34_1.settingData.show_music_name == 1 then
						arg_34_1.musicController:SetSelectedState("show")
						arg_34_1.musicAnimator_:Play("open", 0, 0)

						if arg_34_1.settingData.music_time ~= 0 then
							arg_34_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_34_1.settingData.music_time), function()
								if arg_34_1 == nil or isNil(arg_34_1.bgmTxt_) then
									return
								end

								arg_34_1.musicController:SetSelectedState("hide")
								arg_34_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.533333333333333 < arg_34_1.time_ and arg_34_1.time_ <= 0.533333333333333 + arg_37_0 then
				arg_34_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_fire", "")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum02", "")
			end

			if 3 < arg_34_1.time_ and arg_34_1.time_ <= 3 + arg_37_0 then
				arg_34_1:AudioAction("play", "effect", "se_story_140", "se_story_140_rock", "")
			end

			local var_37_28

			if 1 < arg_34_1.time_ and arg_34_1.time_ <= 1 + arg_37_0 then
				local var_37_29 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_37_29 then
					var_37_29.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_37_29.radialBlurScale = 1
					var_37_29.radialBlurGradient = 1
					var_37_29.radialBlurIntensity = 1

					if var_37_28 then
						var_37_29.radialBlurTarget = var_37_28.transform
					end
				end
			end

			local var_37_30 = 1.76666666666667

			if 1 <= arg_34_1.time_ and arg_34_1.time_ < 1 + var_37_30 then
				local var_37_31 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_37_31 then
					var_37_31.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_37_31.radialBlurScale = Mathf.Lerp(1, 1, (arg_34_1.time_ - 1) / var_37_30)
					var_37_31.radialBlurGradient = Mathf.Lerp(1, 1, (arg_34_1.time_ - 1) / var_37_30)
					var_37_31.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_34_1.time_ - 1) / var_37_30)
				end
			end

			if arg_34_1.time_ >= 1 + var_37_30 and arg_34_1.time_ < 1 + var_37_30 + arg_37_0 then
				local var_37_32 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_37_32 then
					var_37_32.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_37_32.radialBlurScale = 1
					var_37_32.radialBlurGradient = 1
					var_37_32.radialBlurIntensity = 1
				end
			end

			local var_37_33

			if 2.76666666666667 < arg_34_1.time_ and arg_34_1.time_ <= 2.76666666666667 + arg_37_0 then
				local var_37_34 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_37_34 then
					var_37_34.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_37_34.radialBlurScale = 0
					var_37_34.radialBlurGradient = 1
					var_37_34.radialBlurIntensity = 1

					if var_37_33 then
						var_37_34.radialBlurTarget = var_37_33.transform
					end
				end
			end

			local var_37_35 = 0.8

			if 2.76666666666667 <= arg_34_1.time_ and arg_34_1.time_ < 2.76666666666667 + var_37_35 then
				local var_37_36 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_37_36 then
					var_37_36.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_37_36.radialBlurScale = Mathf.Lerp(0, 0, (arg_34_1.time_ - 2.76666666666667) / var_37_35)
					var_37_36.radialBlurGradient = Mathf.Lerp(1, 1, (arg_34_1.time_ - 2.76666666666667) / var_37_35)
					var_37_36.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_34_1.time_ - 2.76666666666667) / var_37_35)
				end
			end

			if arg_34_1.time_ >= 2.76666666666667 + var_37_35 and arg_34_1.time_ < 2.76666666666667 + var_37_35 + arg_37_0 then
				local var_37_37 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_37_37 then
					var_37_37.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_37_37.radialBlurScale = 0
					var_37_37.radialBlurGradient = 1
					var_37_37.radialBlurIntensity = 1
				end
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_38 = 2.76666666666667
			local var_37_39 = 1.1

			if 2.76666666666667 < arg_34_1.time_ and arg_34_1.time_ <= var_37_38 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_40 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_40:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_34_1.dialogCg_.alpha = arg_40_0
				end))
				var_37_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_41 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(322011009).content)

				arg_34_1.text_.text = var_37_41

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_43 = 44 <= 0 and var_37_39 or var_37_39 * (utf8.len(var_37_41) / 44)

				if (44 <= 0 and var_37_39 or var_37_39 * (utf8.len(var_37_41) / 44)) > 0 and var_37_39 < var_37_43 then
					arg_34_1.talkMaxDuration = var_37_43
					var_37_38 = var_37_38 + 0.3

					if var_37_43 + var_37_38 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_43 + var_37_38
					end
				end

				arg_34_1.text_.text = var_37_41
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_44 = var_37_38 + 0.3
			local var_37_45 = math.max(var_37_39, arg_34_1.talkMaxDuration)

			if var_37_38 + 0.3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_44 + var_37_45 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_44) / var_37_45

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_44 + var_37_45 and arg_34_1.time_ < var_37_44 + var_37_45 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				groupID = "1008",
				duration = 0.0166666666666666,
				className = "StoryTextGroupNode",
				startTime = 0.983333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "10042",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0.983333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play322011010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 322011010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play322011011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 1.175

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(322011010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 47 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 47)

				if (47 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 47)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play322011011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 322011011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play322011012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_9000

			if 0.133333333333333 < arg_46_1.time_ and arg_46_1.time_ <= 0.133333333333333 + arg_49_0 then
				arg_46_1:AudioAction("play", "effect", "se_story_16", "se_story_16_wind02", "")
			end

			if 0.333333333333333 < arg_46_1.time_ and arg_46_1.time_ <= 0.333333333333333 + arg_49_0 then
				local var_49_1 = arg_46_1.var_.effect1013

				if not arg_46_1.var_.effect1013 then
					var_49_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), manager.ui.mainCamera.transform)
					var_49_1.name = "1013"
					arg_46_1.var_.effect1013 = var_49_1
				else
					var_49_1.transform:SetParent(var_49_9000)
				end

				var_49_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_49_1.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_49_3 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_49_4 = var_49_1.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_49_0, iter_49_1 in ipairs((var_49_4:ToTable())) do
					iter_49_1.transform.localScale = Vector3.New(iter_49_1.transform.localScale.x / var_49_3 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_49_4 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_49_1.transform.localScale.y / var_49_3, iter_49_1.transform.localScale.z)
				end
			end

			local var_49_6 = 0
			local var_49_7 = 1.55

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_8 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(322011011).content)

				arg_46_1.text_.text = var_49_8

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 62 <= 0 and var_49_7 or var_49_7 * (utf8.len(var_49_8) / 62)

				if (62 <= 0 and var_49_7 or var_49_7 * (utf8.len(var_49_8) / 62)) > 0 and var_49_7 < var_49_10 then
					arg_46_1.talkMaxDuration = var_49_10

					if var_49_10 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_10 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_8
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_11 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_11 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_11

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_11 and arg_46_1.time_ < var_49_6 + var_49_11 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play322011012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 322011012
		arg_50_1.duration_ = 4.1

		local var_50_0 = {
			zh = 1.999999999999,
			ja = 4.1
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play322011013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if arg_50_1.actors_["10150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10150ui_story"))) then
				local var_53_0 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_50_1.stage_.transform)

				var_53_0.name = "10150ui_story"
				var_53_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.actors_["10150ui_story"] = var_53_0

				local var_53_1 = var_53_0:GetComponentInChildren(typeof(CharacterEffect))

				var_53_1.enabled = true

				local var_53_2 = GameObjectTools.GetOrAddComponent(var_53_0, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(false)
				end

				arg_50_1:ShowWeapon(var_53_1.transform, false)

				arg_50_1.var_["10150ui_story" .. "Animator"] = var_53_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_50_1.var_["10150ui_story" .. "Animator"].applyRootMotion = true
				arg_50_1.var_["10150ui_story" .. "LipSync"] = var_53_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_53_3 = arg_50_1.actors_["10150ui_story"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10150ui_story = var_53_3.localPosition

				local var_53_4 = GameObjectTools.GetOrAddComponent(var_53_3.gameObject, typeof(DynamicBoneHelper))

				if var_53_4 then
					var_53_4:EnableDynamicBone(false)
				end
			end

			local var_53_5 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_5 then
				var_53_3.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10150ui_story, Vector3.New(0, -1.73, -5.5), (arg_50_1.time_ - 0) / var_53_5)
				var_53_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_3.position).x, (manager.ui.mainCamera.transform.position - var_53_3.position).y, (manager.ui.mainCamera.transform.position - var_53_3.position).z)
				var_53_3.localEulerAngles.z = 0
				var_53_3.localEulerAngles.x = 0
				var_53_3.localEulerAngles = var_53_3.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_5 and arg_50_1.time_ < 0 + var_53_5 + arg_53_0 then
				var_53_3.localPosition = Vector3.New(0, -1.73, -5.5)
				var_53_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_3.position).x, (manager.ui.mainCamera.transform.position - var_53_3.position).y, (manager.ui.mainCamera.transform.position - var_53_3.position).z)
				var_53_3.localEulerAngles.z = 0
				var_53_3.localEulerAngles.x = 0
				var_53_3.localEulerAngles = var_53_3.localEulerAngles

				local var_53_6 = GameObjectTools.GetOrAddComponent(var_53_3.gameObject, typeof(DynamicBoneHelper))

				if var_53_6 then
					var_53_6:EnableDynamicBone(true)
				end
			end

			local var_53_7 = arg_50_1.actors_["10150ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_7) and arg_50_1.var_.characterEffect10150ui_story == nil then
				arg_50_1.var_.characterEffect10150ui_story = var_53_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_8 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_8 and not isNil(var_53_7) then
				if arg_50_1.var_.characterEffect10150ui_story and not isNil(var_53_7) then
					arg_50_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_8 and arg_50_1.time_ < 0 + var_53_8 + arg_53_0 and not isNil(var_53_7) and arg_50_1.var_.characterEffect10150ui_story then
				arg_50_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				if arg_50_1.var_.effect1013 then
					Object.Destroy(arg_50_1.var_.effect1013)

					arg_50_1.var_.effect1013 = nil
				end
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action2_1")
			end

			local var_53_11 = 0
			local var_53_12 = 0.2

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_11 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_13 = arg_50_1:GetWordFromCfg(322011012)
				local var_53_14 = arg_50_1:FormatText(var_53_13.content)

				arg_50_1.text_.text = var_53_14

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_16 = 8 <= 0 and var_53_12 or var_53_12 * (utf8.len(var_53_14) / 8)

				if (8 <= 0 and var_53_12 or var_53_12 * (utf8.len(var_53_14) / 8)) > 0 and var_53_12 < var_53_16 then
					arg_50_1.talkMaxDuration = var_53_16

					if var_53_16 + var_53_11 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_16 + var_53_11
					end
				end

				arg_50_1.text_.text = var_53_14
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011012", "story_v_out_322011.awb") ~= 0 then
					local var_53_17 = manager.audio:GetVoiceLength("story_v_out_322011", "322011012", "story_v_out_322011.awb") / 1000

					if var_53_17 + var_53_11 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_17 + var_53_11
					end

					if var_53_13.prefab_name ~= "" and arg_50_1.actors_[var_53_13.prefab_name] ~= nil then
						local var_53_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_13.prefab_name].transform, "story_v_out_322011", "322011012", "story_v_out_322011.awb")

						arg_50_1:RecordAudio("322011012", var_53_18)
						arg_50_1:RecordAudio("322011012", var_53_18)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_322011", "322011012", "story_v_out_322011.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_322011", "322011012", "story_v_out_322011.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_19 = math.max(var_53_12, arg_50_1.talkMaxDuration)

			if var_53_11 <= arg_50_1.time_ and arg_50_1.time_ < var_53_11 + var_53_19 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_11) / var_53_19

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_11 + var_53_19 and arg_50_1.time_ < var_53_11 + var_53_19 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play322011013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 322011013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play322011014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["10150ui_story"]) and arg_54_1.var_.characterEffect10150ui_story == nil then
				arg_54_1.var_.characterEffect10150ui_story = arg_54_1.actors_["10150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["10150ui_story"]) then
				if arg_54_1.var_.characterEffect10150ui_story and not isNil(arg_54_1.actors_["10150ui_story"]) then
					arg_54_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_0)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["10150ui_story"]) and arg_54_1.var_.characterEffect10150ui_story then
				arg_54_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			local var_57_1 = 0
			local var_57_2 = 0.875

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_3 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(322011013).content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 35 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_3) / 35)

				if (35 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_3) / 35)) > 0 and var_57_2 < var_57_5 then
					arg_54_1.talkMaxDuration = var_57_5

					if var_57_5 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + var_57_1
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_6 = math.max(var_57_2, arg_54_1.talkMaxDuration)

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_6 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_1) / var_57_6

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_1 + var_57_6 and arg_54_1.time_ < var_57_1 + var_57_6 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play322011014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 322011014
		arg_58_1.duration_ = 2.07

		local var_58_0 = {
			zh = 2.066,
			ja = 1.999999999999
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
				arg_58_0:Play322011015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10150ui_story = arg_58_1.actors_["10150ui_story"].transform.localPosition

				local var_61_0 = GameObjectTools.GetOrAddComponent(arg_58_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_61_0 then
					var_61_0:EnableDynamicBone(false)
				end
			end

			local var_61_1 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_1 then
				arg_58_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10150ui_story, Vector3.New(0, -1.73, -5.5), (arg_58_1.time_ - 0) / var_61_1)
				arg_58_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10150ui_story"].transform.position).z)
				arg_58_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["10150ui_story"].transform.localEulerAngles = arg_58_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_1 and arg_58_1.time_ < 0 + var_61_1 + arg_61_0 then
				arg_58_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, -1.73, -5.5)
				arg_58_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10150ui_story"].transform.position).z)
				arg_58_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["10150ui_story"].transform.localEulerAngles = arg_58_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_61_2 = GameObjectTools.GetOrAddComponent(arg_58_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_61_2 then
					var_61_2:EnableDynamicBone(true)
				end
			end

			local var_61_3 = arg_58_1.actors_["10150ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_3) and arg_58_1.var_.characterEffect10150ui_story == nil then
				arg_58_1.var_.characterEffect10150ui_story = var_61_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_4 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 and not isNil(var_61_3) then
				if arg_58_1.var_.characterEffect10150ui_story and not isNil(var_61_3) then
					arg_58_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 and not isNil(var_61_3) and arg_58_1.var_.characterEffect10150ui_story then
				arg_58_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action2_2")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_61_6 = 0
			local var_61_7 = 0.125

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_8 = arg_58_1:GetWordFromCfg(322011014)
				local var_61_9 = arg_58_1:FormatText(var_61_8.content)

				arg_58_1.text_.text = var_61_9

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 5 <= 0 and var_61_7 or var_61_7 * (utf8.len(var_61_9) / 5)

				if (5 <= 0 and var_61_7 or var_61_7 * (utf8.len(var_61_9) / 5)) > 0 and var_61_7 < var_61_11 then
					arg_58_1.talkMaxDuration = var_61_11

					if var_61_11 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_9
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011014", "story_v_out_322011.awb") ~= 0 then
					local var_61_12 = manager.audio:GetVoiceLength("story_v_out_322011", "322011014", "story_v_out_322011.awb") / 1000

					if var_61_12 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_6
					end

					if var_61_8.prefab_name ~= "" and arg_58_1.actors_[var_61_8.prefab_name] ~= nil then
						local var_61_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_8.prefab_name].transform, "story_v_out_322011", "322011014", "story_v_out_322011.awb")

						arg_58_1:RecordAudio("322011014", var_61_13)
						arg_58_1:RecordAudio("322011014", var_61_13)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_322011", "322011014", "story_v_out_322011.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_322011", "322011014", "story_v_out_322011.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_14 and arg_58_1.time_ < var_61_6 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play322011015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 322011015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play322011016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos10150ui_story = arg_62_1.actors_["10150ui_story"].transform.localPosition

				local var_65_0 = GameObjectTools.GetOrAddComponent(arg_62_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_65_0 then
					var_65_0:EnableDynamicBone(false)
				end
			end

			local var_65_1 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_1 then
				arg_62_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_1)
				arg_62_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["10150ui_story"].transform.position).z)
				arg_62_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["10150ui_story"].transform.localEulerAngles = arg_62_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_1 and arg_62_1.time_ < 0 + var_65_1 + arg_65_0 then
				arg_62_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["10150ui_story"].transform.position).z)
				arg_62_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["10150ui_story"].transform.localEulerAngles = arg_62_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_65_2 = GameObjectTools.GetOrAddComponent(arg_62_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(true)
				end
			end

			if 0.034000001847744 < arg_62_1.time_ and arg_62_1.time_ <= 0.034000001847744 + arg_65_0 then
				arg_62_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion05", "")
			end

			local var_65_4 = manager.ui.mainCamera.transform

			if 0.034000001847744 < arg_62_1.time_ and arg_62_1.time_ <= 0.034000001847744 + arg_65_0 then
				arg_62_1.var_.shakeOldPos = var_65_4.localPosition
			end

			local var_65_5 = 0.865999998152256

			if 0.034000001847744 <= arg_62_1.time_ and arg_62_1.time_ < 0.034000001847744 + var_65_5 then
				local var_65_6, var_65_7 = math.modf((arg_62_1.time_ - 0.034000001847744) / 0.066)

				var_65_4.localPosition = Vector3.New(var_65_7 * 0.13, var_65_7 * 0.13, var_65_7 * 0.13) + arg_62_1.var_.shakeOldPos
			end

			if arg_62_1.time_ >= 0.034000001847744 + var_65_5 and arg_62_1.time_ < 0.034000001847744 + var_65_5 + arg_65_0 then
				var_65_4.localPosition = arg_62_1.var_.shakeOldPos
			end

			local var_65_8 = 0
			local var_65_9 = 1.275

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(322011015).content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_12 = 51 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_10) / 51)

				if (51 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_10) / 51)) > 0 and var_65_9 < var_65_12 then
					arg_62_1.talkMaxDuration = var_65_12

					if var_65_12 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_12 + var_65_8
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_13 = math.max(var_65_9, arg_62_1.talkMaxDuration)

			if var_65_8 <= arg_62_1.time_ and arg_62_1.time_ < var_65_8 + var_65_13 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_8) / var_65_13

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_8 + var_65_13 and arg_62_1.time_ < var_65_8 + var_65_13 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play322011016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 322011016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play322011017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0.1 < arg_66_1.time_ and arg_66_1.time_ <= 0.1 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_11", "se_story_11_fire", "")
			end

			local var_69_1 = 0
			local var_69_2 = 1.35

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(322011016).content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 54 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 54)

				if (54 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 54)) > 0 and var_69_2 < var_69_5 then
					arg_66_1.talkMaxDuration = var_69_5

					if var_69_5 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_6 = math.max(var_69_2, arg_66_1.talkMaxDuration)

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_6 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_1) / var_69_6

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_1 + var_69_6 and arg_66_1.time_ < var_69_1 + var_69_6 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play322011017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 322011017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play322011018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0.233333333333333 < arg_70_1.time_ and arg_70_1.time_ <= 0.233333333333333 + arg_73_0 then
				arg_70_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_fireanergy2", "")
			end

			local var_73_1 = 0
			local var_73_2 = 1.375

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(322011017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 55 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 55)

				if (55 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 55)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play322011018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 322011018
		arg_74_1.duration_ = 6.47

		local var_74_0 = {
			zh = 5.999999999999,
			ja = 6.466
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play322011019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if arg_74_1.bgs_.ST0511a == nil then
				local var_77_0 = Object.Instantiate(arg_74_1.paintGo_)

				var_77_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0511a")
				var_77_0.name = "ST0511a"
				var_77_0.transform.parent = arg_74_1.stage_.transform
				var_77_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.bgs_.ST0511a = var_77_0
			end

			if 2 < arg_74_1.time_ and arg_74_1.time_ <= 2 + arg_77_0 then
				local var_77_1 = arg_74_1.bgs_.ST0511a

				arg_74_1.bgs_.ST0511a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_77_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_77_2 = var_77_1:GetComponent("SpriteRenderer")

				if var_77_2 and var_77_2.sprite then
					local var_77_3 = 2 * (var_77_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_77_1.transform.localScale = Vector3.New(var_77_3 / var_77_2.sprite.bounds.size.y < var_77_3 * manager.ui.mainCameraCom_.aspect / var_77_2.sprite.bounds.size.x and var_77_3 * manager.ui.mainCameraCom_.aspect / var_77_2.sprite.bounds.size.x or var_77_3 / var_77_2.sprite.bounds.size.y, var_77_3 / var_77_2.sprite.bounds.size.y < var_77_3 * manager.ui.mainCameraCom_.aspect / var_77_2.sprite.bounds.size.x and var_77_3 * manager.ui.mainCameraCom_.aspect / var_77_2.sprite.bounds.size.x or var_77_3 / var_77_2.sprite.bounds.size.y, 0)
				end

				for iter_77_0, iter_77_1 in pairs(arg_74_1.bgs_) do
					if iter_77_0 ~= "ST0511a" then
						iter_77_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_77_4 = 4

			if 4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.allBtn_.enabled = false
			end

			if arg_74_1.time_ >= var_77_4 + 0.3 and arg_74_1.time_ < var_77_4 + 0.3 + arg_77_0 then
				arg_74_1.allBtn_.enabled = true
			end

			local var_77_5 = 0

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_6 = 2

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 then
				local var_77_7 = Color.New(0, 0, 0)

				var_77_7.a = Mathf.Lerp(0, 1, (arg_74_1.time_ - var_77_5) / var_77_6)
				arg_74_1.mask_.color = var_77_7
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 then
				local var_77_8 = Color.New(0, 0, 0)

				var_77_8.a = 1
				arg_74_1.mask_.color = var_77_8
			end

			local var_77_9 = 2

			if 2 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_10 = 2

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_10 then
				local var_77_11 = Color.New(0, 0, 0)

				var_77_11.a = Mathf.Lerp(1, 0, (arg_74_1.time_ - var_77_9) / var_77_10)
				arg_74_1.mask_.color = var_77_11
			end

			if arg_74_1.time_ >= var_77_9 + var_77_10 and arg_74_1.time_ < var_77_9 + var_77_10 + arg_77_0 then
				local var_77_12 = Color.New(0, 0, 0)

				arg_74_1.mask_.enabled = false
				var_77_12.a = 0
				arg_74_1.mask_.color = var_77_12
			end

			local var_77_13 = arg_74_1.actors_["10150ui_story"].transform

			if 4 < arg_74_1.time_ and arg_74_1.time_ <= 4 + arg_77_0 then
				arg_74_1.var_.moveOldPos10150ui_story = var_77_13.localPosition

				local var_77_14 = GameObjectTools.GetOrAddComponent(var_77_13.gameObject, typeof(DynamicBoneHelper))

				if var_77_14 then
					var_77_14:EnableDynamicBone(false)
				end
			end

			local var_77_15 = 0.001

			if 4 <= arg_74_1.time_ and arg_74_1.time_ < 4 + var_77_15 then
				var_77_13.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10150ui_story, Vector3.New(0, -1.73, -5.5), (arg_74_1.time_ - 4) / var_77_15)
				var_77_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_13.position).x, (manager.ui.mainCamera.transform.position - var_77_13.position).y, (manager.ui.mainCamera.transform.position - var_77_13.position).z)
				var_77_13.localEulerAngles.z = 0
				var_77_13.localEulerAngles.x = 0
				var_77_13.localEulerAngles = var_77_13.localEulerAngles
			end

			if arg_74_1.time_ >= 4 + var_77_15 and arg_74_1.time_ < 4 + var_77_15 + arg_77_0 then
				var_77_13.localPosition = Vector3.New(0, -1.73, -5.5)
				var_77_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_13.position).x, (manager.ui.mainCamera.transform.position - var_77_13.position).y, (manager.ui.mainCamera.transform.position - var_77_13.position).z)
				var_77_13.localEulerAngles.z = 0
				var_77_13.localEulerAngles.x = 0
				var_77_13.localEulerAngles = var_77_13.localEulerAngles

				local var_77_16 = GameObjectTools.GetOrAddComponent(var_77_13.gameObject, typeof(DynamicBoneHelper))

				if var_77_16 then
					var_77_16:EnableDynamicBone(true)
				end
			end

			local var_77_17 = arg_74_1.actors_["10150ui_story"]

			if 4 < arg_74_1.time_ and arg_74_1.time_ <= 4 + arg_77_0 and not isNil(var_77_17) and arg_74_1.var_.characterEffect10150ui_story == nil then
				arg_74_1.var_.characterEffect10150ui_story = var_77_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_18 = 0.200000002980232

			if 4 <= arg_74_1.time_ and arg_74_1.time_ < 4 + var_77_18 and not isNil(var_77_17) then
				if arg_74_1.var_.characterEffect10150ui_story and not isNil(var_77_17) then
					arg_74_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 4 + var_77_18 and arg_74_1.time_ < 4 + var_77_18 + arg_77_0 and not isNil(var_77_17) and arg_74_1.var_.characterEffect10150ui_story then
				arg_74_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 4 < arg_74_1.time_ and arg_74_1.time_ <= 4 + arg_77_0 then
				arg_74_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 4 < arg_74_1.time_ and arg_74_1.time_ <= 4 + arg_77_0 then
				arg_74_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_77_20 = 1.98333333333333

			arg_74_1.isInRecall_ = false

			if var_77_20 < arg_74_1.time_ and arg_74_1.time_ <= var_77_20 + arg_77_0 then
				arg_74_1.screenFilterGo_:SetActive(false)

				for iter_77_2, iter_77_3 in pairs(arg_74_1.actors_) do
					for iter_77_4, iter_77_5 in ipairs((iter_77_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_77_5.color = iter_77_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_77_21 = 0.0166666666666667

			if var_77_20 <= arg_74_1.time_ and arg_74_1.time_ < var_77_20 + var_77_21 then
				arg_74_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_74_1.time_ - var_77_20) / var_77_21)
			end

			if arg_74_1.time_ >= var_77_20 + var_77_21 and arg_74_1.time_ < var_77_20 + var_77_21 + arg_77_0 then
				arg_74_1.screenFilterEffect_.weight = 0
			end

			if 0.1 < arg_74_1.time_ and arg_74_1.time_ <= 0.1 + arg_77_0 then
				arg_74_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 1.9 < arg_74_1.time_ and arg_74_1.time_ <= 1.9 + arg_77_0 then
				arg_74_1:AudioAction("play", "effect", "se_story_145", "se_story_145_horror", "")
			end

			if 1.9 < arg_74_1.time_ and arg_74_1.time_ <= 1.9 + arg_77_0 then
				arg_74_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 2.2 < arg_74_1.time_ and arg_74_1.time_ <= 2.2 + arg_77_0 then
				arg_74_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_explosion_far", "")
			end

			if arg_74_1.frameCnt_ <= 1 then
				arg_74_1.dialog_:SetActive(false)
			end

			local var_77_26 = 4
			local var_77_27 = 0.1

			if 4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_26 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_28 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_28:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_74_1.dialogCg_.alpha = arg_78_0
				end))
				var_77_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_29 = arg_74_1:GetWordFromCfg(322011018)
				local var_77_30 = arg_74_1:FormatText(var_77_29.content)

				arg_74_1.text_.text = var_77_30

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_32 = 4 <= 0 and var_77_27 or var_77_27 * (utf8.len(var_77_30) / 4)

				if (4 <= 0 and var_77_27 or var_77_27 * (utf8.len(var_77_30) / 4)) > 0 and var_77_27 < var_77_32 then
					arg_74_1.talkMaxDuration = var_77_32
					var_77_26 = var_77_26 + 0.3

					if var_77_32 + var_77_26 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_32 + var_77_26
					end
				end

				arg_74_1.text_.text = var_77_30
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011018", "story_v_out_322011.awb") ~= 0 then
					local var_77_33 = manager.audio:GetVoiceLength("story_v_out_322011", "322011018", "story_v_out_322011.awb") / 1000

					if var_77_33 + var_77_26 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_33 + var_77_26
					end

					if var_77_29.prefab_name ~= "" and arg_74_1.actors_[var_77_29.prefab_name] ~= nil then
						local var_77_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_29.prefab_name].transform, "story_v_out_322011", "322011018", "story_v_out_322011.awb")

						arg_74_1:RecordAudio("322011018", var_77_34)
						arg_74_1:RecordAudio("322011018", var_77_34)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_322011", "322011018", "story_v_out_322011.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_322011", "322011018", "story_v_out_322011.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_35 = var_77_26 + 0.3
			local var_77_36 = math.max(var_77_27, arg_74_1.talkMaxDuration)

			if var_77_26 + 0.3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_35 + var_77_36 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_35) / var_77_36

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_35 + var_77_36 and arg_74_1.time_ < var_77_35 + var_77_36 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play322011019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 322011019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play322011020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10150ui_story = arg_80_1.actors_["10150ui_story"].transform.localPosition

				local var_83_0 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_0 then
					var_83_0:EnableDynamicBone(false)
				end
			end

			local var_83_1 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_1 then
				arg_80_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_1)
				arg_80_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10150ui_story"].transform.position).z)
				arg_80_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["10150ui_story"].transform.localEulerAngles = arg_80_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_1 and arg_80_1.time_ < 0 + var_83_1 + arg_83_0 then
				arg_80_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10150ui_story"].transform.position).z)
				arg_80_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["10150ui_story"].transform.localEulerAngles = arg_80_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_83_2 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(true)
				end
			end

			local var_83_3 = 0
			local var_83_4 = 1.275

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_5 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(322011019).content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 51 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_5) / 51)

				if (51 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_5) / 51)) > 0 and var_83_4 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_3 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_3
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_4, arg_80_1.talkMaxDuration)

			if var_83_3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_3 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_3) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_3 + var_83_8 and arg_80_1.time_ < var_83_3 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play322011020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 322011020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play322011021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 1.3

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(322011020).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 52 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 52)

				if (52 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 52)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play322011021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 322011021
		arg_88_1.duration_ = 2.6

		local var_88_0 = {
			zh = 2.6,
			ja = 2.266
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
				arg_88_0:Play322011022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos10150ui_story = arg_88_1.actors_["10150ui_story"].transform.localPosition

				local var_91_0 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_0 then
					var_91_0:EnableDynamicBone(false)
				end
			end

			local var_91_1 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 then
				arg_88_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10150ui_story, Vector3.New(0, -1.73, -5.5), (arg_88_1.time_ - 0) / var_91_1)
				arg_88_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10150ui_story"].transform.position).z)
				arg_88_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["10150ui_story"].transform.localEulerAngles = arg_88_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 then
				arg_88_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, -1.73, -5.5)
				arg_88_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10150ui_story"].transform.position).z)
				arg_88_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["10150ui_story"].transform.localEulerAngles = arg_88_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_91_2 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(true)
				end
			end

			local var_91_3 = arg_88_1.actors_["10150ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect10150ui_story == nil then
				arg_88_1.var_.characterEffect10150ui_story = var_91_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_4 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 and not isNil(var_91_3) then
				if arg_88_1.var_.characterEffect10150ui_story and not isNil(var_91_3) then
					arg_88_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect10150ui_story then
				arg_88_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action3_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_91_6 = 0
			local var_91_7 = 0.2

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_8 = arg_88_1:GetWordFromCfg(322011021)
				local var_91_9 = arg_88_1:FormatText(var_91_8.content)

				arg_88_1.text_.text = var_91_9

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 8 <= 0 and var_91_7 or var_91_7 * (utf8.len(var_91_9) / 8)

				if (8 <= 0 and var_91_7 or var_91_7 * (utf8.len(var_91_9) / 8)) > 0 and var_91_7 < var_91_11 then
					arg_88_1.talkMaxDuration = var_91_11

					if var_91_11 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_11 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_9
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011021", "story_v_out_322011.awb") ~= 0 then
					local var_91_12 = manager.audio:GetVoiceLength("story_v_out_322011", "322011021", "story_v_out_322011.awb") / 1000

					if var_91_12 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_6
					end

					if var_91_8.prefab_name ~= "" and arg_88_1.actors_[var_91_8.prefab_name] ~= nil then
						local var_91_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_8.prefab_name].transform, "story_v_out_322011", "322011021", "story_v_out_322011.awb")

						arg_88_1:RecordAudio("322011021", var_91_13)
						arg_88_1:RecordAudio("322011021", var_91_13)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_322011", "322011021", "story_v_out_322011.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_322011", "322011021", "story_v_out_322011.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play322011022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 322011022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play322011023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10150ui_story = arg_92_1.actors_["10150ui_story"].transform.localPosition

				local var_95_0 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_0 then
					var_95_0:EnableDynamicBone(false)
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_1)
				arg_92_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10150ui_story"].transform.position).z)
				arg_92_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10150ui_story"].transform.localEulerAngles = arg_92_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["10150ui_story"].transform.position).z)
				arg_92_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["10150ui_story"].transform.localEulerAngles = arg_92_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_95_2 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(true)
				end
			end

			if 0.1 < arg_92_1.time_ and arg_92_1.time_ <= 0.1 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire03", "")
			end

			local var_95_4 = 0
			local var_95_5 = 1.475

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_6 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(322011022).content)

				arg_92_1.text_.text = var_95_6

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_8 = 59 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_6) / 59)

				if (59 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_6) / 59)) > 0 and var_95_5 < var_95_8 then
					arg_92_1.talkMaxDuration = var_95_8

					if var_95_8 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_6
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_9 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_9 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_9

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_9 and arg_92_1.time_ < var_95_4 + var_95_9 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322011023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 322011023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play322011024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0.333333333333333 < arg_96_1.time_ and arg_96_1.time_ <= 0.333333333333333 + arg_99_0 then
				arg_96_1:AudioAction("play", "effect", "se_story_145", "se_story_145_put_down", "")
			end

			local var_99_1 = 0
			local var_99_2 = 1.575

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(322011023).content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 63 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 63)

				if (63 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 63)) > 0 and var_99_2 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_6 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_6 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_6

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_6 and arg_96_1.time_ < var_99_1 + var_99_6 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play322011024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 322011024
		arg_100_1.duration_ = 2

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play322011025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if arg_100_1.actors_["10100ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10100ui_story"))) then
				local var_103_0 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_100_1.stage_.transform)

				var_103_0.name = "10100ui_story"
				var_103_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["10100ui_story"] = var_103_0

				local var_103_1 = var_103_0:GetComponentInChildren(typeof(CharacterEffect))

				var_103_1.enabled = true

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_0, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end

				arg_100_1:ShowWeapon(var_103_1.transform, false)

				arg_100_1.var_["10100ui_story" .. "Animator"] = var_103_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_100_1.var_["10100ui_story" .. "Animator"].applyRootMotion = true
				arg_100_1.var_["10100ui_story" .. "LipSync"] = var_103_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_103_3 = arg_100_1.actors_["10100ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10100ui_story = var_103_3.localPosition
			end

			local var_103_4 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				var_103_3.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_100_1.time_ - 0) / var_103_4)
				var_103_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_3.position).x, (manager.ui.mainCamera.transform.position - var_103_3.position).y, (manager.ui.mainCamera.transform.position - var_103_3.position).z)
				var_103_3.localEulerAngles.z = 0
				var_103_3.localEulerAngles.x = 0
				var_103_3.localEulerAngles = var_103_3.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				var_103_3.localPosition = Vector3.New(0, -1.16, -6.25)
				var_103_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_3.position).x, (manager.ui.mainCamera.transform.position - var_103_3.position).y, (manager.ui.mainCamera.transform.position - var_103_3.position).z)
				var_103_3.localEulerAngles.z = 0
				var_103_3.localEulerAngles.x = 0
				var_103_3.localEulerAngles = var_103_3.localEulerAngles
			end

			local var_103_5 = arg_100_1.actors_["10100ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_5) and arg_100_1.var_.characterEffect10100ui_story == nil then
				arg_100_1.var_.characterEffect10100ui_story = var_103_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_6 and not isNil(var_103_5) then
				if arg_100_1.var_.characterEffect10100ui_story and not isNil(var_103_5) then
					arg_100_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_6 and arg_100_1.time_ < 0 + var_103_6 + arg_103_0 and not isNil(var_103_5) and arg_100_1.var_.characterEffect10100ui_story then
				arg_100_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_103_8 = 0
			local var_103_9 = 0.075

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_10 = arg_100_1:GetWordFromCfg(322011024)
				local var_103_11 = arg_100_1:FormatText(var_103_10.content)

				arg_100_1.text_.text = var_103_11

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 3 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 3)

				if (3 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 3)) > 0 and var_103_9 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_11
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011024", "story_v_out_322011.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_322011", "322011024", "story_v_out_322011.awb") / 1000

					if var_103_14 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_8
					end

					if var_103_10.prefab_name ~= "" and arg_100_1.actors_[var_103_10.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_10.prefab_name].transform, "story_v_out_322011", "322011024", "story_v_out_322011.awb")

						arg_100_1:RecordAudio("322011024", var_103_15)
						arg_100_1:RecordAudio("322011024", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_322011", "322011024", "story_v_out_322011.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_322011", "322011024", "story_v_out_322011.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_16 and arg_100_1.time_ < var_103_8 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play322011025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 322011025
		arg_104_1.duration_ = 7.67

		local var_104_0 = {
			zh = 5.066,
			ja = 7.666
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play322011026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action5_1")
			end

			local var_107_0 = 0
			local var_107_1 = 0.7

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(322011025)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 28 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 28)

				if (28 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 28)) > 0 and var_107_1 < var_107_5 then
					arg_104_1.talkMaxDuration = var_107_5

					if var_107_5 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011025", "story_v_out_322011.awb") ~= 0 then
					local var_107_6 = manager.audio:GetVoiceLength("story_v_out_322011", "322011025", "story_v_out_322011.awb") / 1000

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end

					if var_107_2.prefab_name ~= "" and arg_104_1.actors_[var_107_2.prefab_name] ~= nil then
						local var_107_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_2.prefab_name].transform, "story_v_out_322011", "322011025", "story_v_out_322011.awb")

						arg_104_1:RecordAudio("322011025", var_107_7)
						arg_104_1:RecordAudio("322011025", var_107_7)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_322011", "322011025", "story_v_out_322011.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_322011", "322011025", "story_v_out_322011.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_8 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_8 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_8

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_8 and arg_104_1.time_ < var_107_0 + var_107_8 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play322011026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 322011026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play322011027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos10100ui_story = arg_108_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10100ui_story"].transform.position).z)
				arg_108_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["10100ui_story"].transform.localEulerAngles = arg_108_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["10100ui_story"].transform.position).z)
				arg_108_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["10100ui_story"].transform.localEulerAngles = arg_108_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if 0.233333333333333 < arg_108_1.time_ and arg_108_1.time_ <= 0.233333333333333 + arg_111_0 then
				arg_108_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_111_2 = 0
			local var_111_3 = 0.85

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_4 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(322011026).content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_6 = 34 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_4) / 34)

				if (34 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_4) / 34)) > 0 and var_111_3 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_7 and arg_108_1.time_ < var_111_2 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play322011027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 322011027
		arg_112_1.duration_ = 4.5

		local var_112_0 = {
			zh = 4.5,
			ja = 2.433
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
				arg_112_0:Play322011028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos10100ui_story = arg_112_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["10100ui_story"].transform.position).z)
				arg_112_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["10100ui_story"].transform.localEulerAngles = arg_112_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_112_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["10100ui_story"].transform.position).z)
				arg_112_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["10100ui_story"].transform.localEulerAngles = arg_112_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["10100ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect10100ui_story == nil then
				arg_112_1.var_.characterEffect10100ui_story = var_115_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 and not isNil(var_115_1) then
				if arg_112_1.var_.characterEffect10100ui_story and not isNil(var_115_1) then
					arg_112_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect10100ui_story then
				arg_112_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action5_2")
			end

			local var_115_4 = 0
			local var_115_5 = 0.325

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(322011027)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 13 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 13)

				if (13 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 13)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011027", "story_v_out_322011.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_322011", "322011027", "story_v_out_322011.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_322011", "322011027", "story_v_out_322011.awb")

						arg_112_1:RecordAudio("322011027", var_115_11)
						arg_112_1:RecordAudio("322011027", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_322011", "322011027", "story_v_out_322011.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_322011", "322011027", "story_v_out_322011.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play322011028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 322011028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play322011029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos10100ui_story = arg_116_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10100ui_story"].transform.position).z)
				arg_116_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["10100ui_story"].transform.localEulerAngles = arg_116_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10100ui_story"].transform.position).z)
				arg_116_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["10100ui_story"].transform.localEulerAngles = arg_116_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_119_1 = 0
			local var_119_2 = 1.45

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

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(322011028).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 58 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 58)

				if (58 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 58)) > 0 and var_119_2 < var_119_5 then
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

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play322011029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322011029
		arg_120_1.duration_ = 8.1

		local var_120_0 = {
			zh = 6.866,
			ja = 8.1
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
				arg_120_0:Play322011030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 2 < arg_120_1.time_ and arg_120_1.time_ <= 2 + arg_123_0 then
				local var_123_0 = arg_120_1.bgs_.STblack

				arg_120_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_123_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_123_1 = var_123_0:GetComponent("SpriteRenderer")

				if var_123_1 and var_123_1.sprite then
					local var_123_2 = 2 * (var_123_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_123_0.transform.localScale = Vector3.New(var_123_2 / var_123_1.sprite.bounds.size.y < var_123_2 * manager.ui.mainCameraCom_.aspect / var_123_1.sprite.bounds.size.x and var_123_2 * manager.ui.mainCameraCom_.aspect / var_123_1.sprite.bounds.size.x or var_123_2 / var_123_1.sprite.bounds.size.y, var_123_2 / var_123_1.sprite.bounds.size.y < var_123_2 * manager.ui.mainCameraCom_.aspect / var_123_1.sprite.bounds.size.x and var_123_2 * manager.ui.mainCameraCom_.aspect / var_123_1.sprite.bounds.size.x or var_123_2 / var_123_1.sprite.bounds.size.y, 0)
				end

				for iter_123_0, iter_123_1 in pairs(arg_120_1.bgs_) do
					if iter_123_0 ~= "STblack" then
						iter_123_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_123_3 = 4

			if 4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_3 + arg_123_0 then
				arg_120_1.allBtn_.enabled = false
			end

			if arg_120_1.time_ >= var_123_3 + 0.3 and arg_120_1.time_ < var_123_3 + 0.3 + arg_123_0 then
				arg_120_1.allBtn_.enabled = true
			end

			local var_123_4 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_5 = 2

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_5 then
				local var_123_6 = Color.New(0, 0, 0)

				var_123_6.a = Mathf.Lerp(0, 1, (arg_120_1.time_ - var_123_4) / var_123_5)
				arg_120_1.mask_.color = var_123_6
			end

			if arg_120_1.time_ >= var_123_4 + var_123_5 and arg_120_1.time_ < var_123_4 + var_123_5 + arg_123_0 then
				local var_123_7 = Color.New(0, 0, 0)

				var_123_7.a = 1
				arg_120_1.mask_.color = var_123_7
			end

			local var_123_8 = 2

			if 2 < arg_120_1.time_ and arg_120_1.time_ <= var_123_8 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_9 = 2

			if var_123_8 <= arg_120_1.time_ and arg_120_1.time_ < var_123_8 + var_123_9 then
				local var_123_10 = Color.New(0, 0, 0)

				var_123_10.a = Mathf.Lerp(1, 0, (arg_120_1.time_ - var_123_8) / var_123_9)
				arg_120_1.mask_.color = var_123_10
			end

			if arg_120_1.time_ >= var_123_8 + var_123_9 and arg_120_1.time_ < var_123_8 + var_123_9 + arg_123_0 then
				local var_123_11 = Color.New(0, 0, 0)

				arg_120_1.mask_.enabled = false
				var_123_11.a = 0
				arg_120_1.mask_.color = var_123_11
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_123_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_120_1.bgmTxt_.text ~= var_123_14 and arg_120_1.bgmTxt_.text ~= "" then
						if arg_120_1.bgmTxt2_.text ~= "" then
							arg_120_1.bgmTxt_.text = arg_120_1.bgmTxt2_.text
						end

						arg_120_1.bgmTxt2_.text = var_123_14

						arg_120_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_120_1.bgmTxt_.text = var_123_14
						arg_120_1.bgmTxt2_.text = var_123_14
					end

					if arg_120_1.bgmTimer then
						arg_120_1.bgmTimer:Stop()

						arg_120_1.bgmTimer = nil
					end

					if arg_120_1.settingData.show_music_name == 1 then
						arg_120_1.musicController:SetSelectedState("show")
						arg_120_1.musicAnimator_:Play("open", 0, 0)

						if arg_120_1.settingData.music_time ~= 0 then
							arg_120_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_120_1.settingData.music_time), function()
								if arg_120_1 == nil or isNil(arg_120_1.bgmTxt_) then
									return
								end

								arg_120_1.musicController:SetSelectedState("hide")
								arg_120_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.1 < arg_120_1.time_ and arg_120_1.time_ <= 0.1 + arg_123_0 then
				arg_120_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 0.1 < arg_120_1.time_ and arg_120_1.time_ <= 0.1 + arg_123_0 then
				arg_120_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_explosion_far", "")
			end

			if 2 < arg_120_1.time_ and arg_120_1.time_ <= 2 + arg_123_0 then
				arg_120_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_battle monster", "")
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_18 = 4
			local var_123_19 = 0.4

			if 4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_18 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_20 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_20:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_120_1.dialogCg_.alpha = arg_125_0
				end))
				var_123_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[643].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_21 = arg_120_1:GetWordFromCfg(322011029)
				local var_123_22 = arg_120_1:FormatText(var_123_21.content)

				arg_120_1.text_.text = var_123_22

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_24 = 16 <= 0 and var_123_19 or var_123_19 * (utf8.len(var_123_22) / 16)

				if (16 <= 0 and var_123_19 or var_123_19 * (utf8.len(var_123_22) / 16)) > 0 and var_123_19 < var_123_24 then
					arg_120_1.talkMaxDuration = var_123_24
					var_123_18 = var_123_18 + 0.3

					if var_123_24 + var_123_18 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_24 + var_123_18
					end
				end

				arg_120_1.text_.text = var_123_22
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011029", "story_v_out_322011.awb") ~= 0 then
					local var_123_25 = manager.audio:GetVoiceLength("story_v_out_322011", "322011029", "story_v_out_322011.awb") / 1000

					if var_123_25 + var_123_18 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_25 + var_123_18
					end

					if var_123_21.prefab_name ~= "" and arg_120_1.actors_[var_123_21.prefab_name] ~= nil then
						local var_123_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_21.prefab_name].transform, "story_v_out_322011", "322011029", "story_v_out_322011.awb")

						arg_120_1:RecordAudio("322011029", var_123_26)
						arg_120_1:RecordAudio("322011029", var_123_26)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322011", "322011029", "story_v_out_322011.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322011", "322011029", "story_v_out_322011.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_27 = var_123_18 + 0.3
			local var_123_28 = math.max(var_123_19, arg_120_1.talkMaxDuration)

			if var_123_18 + 0.3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_27 + var_123_28 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_27) / var_123_28

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_27 + var_123_28 and arg_120_1.time_ < var_123_27 + var_123_28 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play322011030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322011030
		arg_127_1.duration_ = 2

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play322011031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_130_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_127_1.stage_.transform)

				var_130_0.name = "1284ui_story"
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["1284ui_story"] = var_130_0

				local var_130_1 = var_130_0:GetComponentInChildren(typeof(CharacterEffect))

				var_130_1.enabled = true

				local var_130_2 = GameObjectTools.GetOrAddComponent(var_130_0, typeof(DynamicBoneHelper))

				if var_130_2 then
					var_130_2:EnableDynamicBone(false)
				end

				arg_127_1:ShowWeapon(var_130_1.transform, false)

				arg_127_1.var_["1284ui_story" .. "Animator"] = var_130_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_127_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_127_1.var_["1284ui_story" .. "LipSync"] = var_130_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_130_3 = arg_127_1.actors_["1284ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1284ui_story = var_130_3.localPosition

				arg_127_1:ShowWeapon(arg_127_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_3.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_127_1.time_ - 0) / var_130_4)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_3.localPosition = Vector3.New(0, -0.985, -6.22)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			local var_130_5 = arg_127_1.actors_["1284ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect1284ui_story == nil then
				arg_127_1.var_.characterEffect1284ui_story = var_130_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_6 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_6 and not isNil(var_130_5) then
				if arg_127_1.var_.characterEffect1284ui_story and not isNil(var_130_5) then
					arg_127_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_6 and arg_127_1.time_ < 0 + var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect1284ui_story then
				arg_127_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_130_8 = "2079ui_story"

			if arg_127_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_130_9 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_127_1.stage_.transform)

				var_130_9.name = var_130_8
				var_130_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_[var_130_8] = var_130_9

				local var_130_10 = var_130_9:GetComponentInChildren(typeof(CharacterEffect))

				var_130_10.enabled = true

				local var_130_11 = GameObjectTools.GetOrAddComponent(var_130_9, typeof(DynamicBoneHelper))

				if var_130_11 then
					var_130_11:EnableDynamicBone(false)
				end

				arg_127_1:ShowWeapon(var_130_10.transform, false)

				arg_127_1.var_[var_130_8 .. "Animator"] = var_130_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_127_1.var_[var_130_8 .. "Animator"].applyRootMotion = true
				arg_127_1.var_[var_130_8 .. "LipSync"] = var_130_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_130_12 = arg_127_1.actors_["2079ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_12) and arg_127_1.var_.characterEffect2079ui_story == nil then
				arg_127_1.var_.characterEffect2079ui_story = var_130_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_13 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_13 and not isNil(var_130_12) then
				if arg_127_1.var_.characterEffect2079ui_story and not isNil(var_130_12) then
					arg_127_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_127_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_13)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_13 and arg_127_1.time_ < 0 + var_130_13 + arg_130_0 and not isNil(var_130_12) and arg_127_1.var_.characterEffect2079ui_story then
				arg_127_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_127_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_130_14 = 0
			local var_130_15 = 0.15

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_16 = arg_127_1:GetWordFromCfg(322011030)
				local var_130_17 = arg_127_1:FormatText(var_130_16.content)

				arg_127_1.text_.text = var_130_17

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_19 = 6 <= 0 and var_130_15 or var_130_15 * (utf8.len(var_130_17) / 6)

				if (6 <= 0 and var_130_15 or var_130_15 * (utf8.len(var_130_17) / 6)) > 0 and var_130_15 < var_130_19 then
					arg_127_1.talkMaxDuration = var_130_19

					if var_130_19 + var_130_14 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_14
					end
				end

				arg_127_1.text_.text = var_130_17
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011030", "story_v_out_322011.awb") ~= 0 then
					local var_130_20 = manager.audio:GetVoiceLength("story_v_out_322011", "322011030", "story_v_out_322011.awb") / 1000

					if var_130_20 + var_130_14 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_20 + var_130_14
					end

					if var_130_16.prefab_name ~= "" and arg_127_1.actors_[var_130_16.prefab_name] ~= nil then
						local var_130_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_16.prefab_name].transform, "story_v_out_322011", "322011030", "story_v_out_322011.awb")

						arg_127_1:RecordAudio("322011030", var_130_21)
						arg_127_1:RecordAudio("322011030", var_130_21)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_322011", "322011030", "story_v_out_322011.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_322011", "322011030", "story_v_out_322011.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_22 = math.max(var_130_15, arg_127_1.talkMaxDuration)

			if var_130_14 <= arg_127_1.time_ and arg_127_1.time_ < var_130_14 + var_130_22 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_14) / var_130_22

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_14 + var_130_22 and arg_127_1.time_ < var_130_14 + var_130_22 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play322011031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322011031
		arg_131_1.duration_ = 5.2

		local var_131_0 = {
			zh = 2.6,
			ja = 5.2
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play322011032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if arg_131_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_134_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_131_1.stage_.transform)

				var_134_0.name = "10104ui_story"
				var_134_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["10104ui_story"] = var_134_0

				local var_134_1 = var_134_0:GetComponentInChildren(typeof(CharacterEffect))

				var_134_1.enabled = true

				local var_134_2 = GameObjectTools.GetOrAddComponent(var_134_0, typeof(DynamicBoneHelper))

				if var_134_2 then
					var_134_2:EnableDynamicBone(false)
				end

				arg_131_1:ShowWeapon(var_134_1.transform, false)

				arg_131_1.var_["10104ui_story" .. "Animator"] = var_134_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_131_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_131_1.var_["10104ui_story" .. "LipSync"] = var_134_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_134_3 = arg_131_1.actors_["10104ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10104ui_story = var_134_3.localPosition
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_3.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_131_1.time_ - 0) / var_134_4)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_3.localPosition = Vector3.New(0.99, -1.12, -5.99)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			local var_134_5 = arg_131_1.actors_["1284ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1284ui_story = var_134_5.localPosition
			end

			local var_134_6 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_6 then
				var_134_5.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_131_1.time_ - 0) / var_134_6)
				var_134_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_5.position).x, (manager.ui.mainCamera.transform.position - var_134_5.position).y, (manager.ui.mainCamera.transform.position - var_134_5.position).z)
				var_134_5.localEulerAngles.z = 0
				var_134_5.localEulerAngles.x = 0
				var_134_5.localEulerAngles = var_134_5.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_6 and arg_131_1.time_ < 0 + var_134_6 + arg_134_0 then
				var_134_5.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_134_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_5.position).x, (manager.ui.mainCamera.transform.position - var_134_5.position).y, (manager.ui.mainCamera.transform.position - var_134_5.position).z)
				var_134_5.localEulerAngles.z = 0
				var_134_5.localEulerAngles.x = 0
				var_134_5.localEulerAngles = var_134_5.localEulerAngles
			end

			local var_134_7 = arg_131_1.actors_["10104ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.characterEffect10104ui_story == nil then
				arg_131_1.var_.characterEffect10104ui_story = var_134_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_8 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_8 and not isNil(var_134_7) then
				if arg_131_1.var_.characterEffect10104ui_story and not isNil(var_134_7) then
					arg_131_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_8 and arg_131_1.time_ < 0 + var_134_8 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.characterEffect10104ui_story then
				arg_131_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_134_10 = arg_131_1.actors_["1284ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_10) and arg_131_1.var_.characterEffect1284ui_story == nil then
				arg_131_1.var_.characterEffect1284ui_story = var_134_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_11 and not isNil(var_134_10) then
				if arg_131_1.var_.characterEffect1284ui_story and not isNil(var_134_10) then
					arg_131_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_11)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_11 and arg_131_1.time_ < 0 + var_134_11 + arg_134_0 and not isNil(var_134_10) and arg_131_1.var_.characterEffect1284ui_story then
				arg_131_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_134_12 = 0
			local var_134_13 = 0.375

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_12 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_14 = arg_131_1:GetWordFromCfg(322011031)
				local var_134_15 = arg_131_1:FormatText(var_134_14.content)

				arg_131_1.text_.text = var_134_15

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_17 = 15 <= 0 and var_134_13 or var_134_13 * (utf8.len(var_134_15) / 15)

				if (15 <= 0 and var_134_13 or var_134_13 * (utf8.len(var_134_15) / 15)) > 0 and var_134_13 < var_134_17 then
					arg_131_1.talkMaxDuration = var_134_17

					if var_134_17 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_17 + var_134_12
					end
				end

				arg_131_1.text_.text = var_134_15
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011031", "story_v_out_322011.awb") ~= 0 then
					local var_134_18 = manager.audio:GetVoiceLength("story_v_out_322011", "322011031", "story_v_out_322011.awb") / 1000

					if var_134_18 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_18 + var_134_12
					end

					if var_134_14.prefab_name ~= "" and arg_131_1.actors_[var_134_14.prefab_name] ~= nil then
						local var_134_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_14.prefab_name].transform, "story_v_out_322011", "322011031", "story_v_out_322011.awb")

						arg_131_1:RecordAudio("322011031", var_134_19)
						arg_131_1:RecordAudio("322011031", var_134_19)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_322011", "322011031", "story_v_out_322011.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_322011", "322011031", "story_v_out_322011.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_20 = math.max(var_134_13, arg_131_1.talkMaxDuration)

			if var_134_12 <= arg_131_1.time_ and arg_131_1.time_ < var_134_12 + var_134_20 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_12) / var_134_20

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_12 + var_134_20 and arg_131_1.time_ < var_134_12 + var_134_20 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play322011032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322011032
		arg_135_1.duration_ = 7.37

		local var_135_0 = {
			zh = 4.233,
			ja = 7.366
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play322011033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10104ui_story = arg_135_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).z)
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles = arg_135_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_135_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).z)
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles = arg_135_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action7_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 1.9 < arg_135_1.time_ and arg_135_1.time_ <= 1.9 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_127", "se_story_127_glass", "")
			end

			local var_138_2 = 0
			local var_138_3 = 0.575

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_4 = arg_135_1:GetWordFromCfg(322011032)
				local var_138_5 = arg_135_1:FormatText(var_138_4.content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 23 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 23)

				if (23 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 23)) > 0 and var_138_3 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011032", "story_v_out_322011.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_322011", "322011032", "story_v_out_322011.awb") / 1000

					if var_138_8 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_2
					end

					if var_138_4.prefab_name ~= "" and arg_135_1.actors_[var_138_4.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_4.prefab_name].transform, "story_v_out_322011", "322011032", "story_v_out_322011.awb")

						arg_135_1:RecordAudio("322011032", var_138_9)
						arg_135_1:RecordAudio("322011032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_322011", "322011032", "story_v_out_322011.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_322011", "322011032", "story_v_out_322011.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_10 and arg_135_1.time_ < var_138_2 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play322011033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322011033
		arg_139_1.duration_ = 8

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play322011034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if arg_139_1.bgs_.L10i == nil then
				local var_142_0 = Object.Instantiate(arg_139_1.paintGo_)

				var_142_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10i")
				var_142_0.name = "L10i"
				var_142_0.transform.parent = arg_139_1.stage_.transform
				var_142_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.bgs_.L10i = var_142_0
			end

			if 1 < arg_139_1.time_ and arg_139_1.time_ <= 1 + arg_142_0 then
				local var_142_1 = arg_139_1.bgs_.L10i

				arg_139_1.bgs_.L10i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_142_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_142_2 = var_142_1:GetComponent("SpriteRenderer")

				if var_142_2 and var_142_2.sprite then
					local var_142_3 = 2 * (var_142_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_142_1.transform.localScale = Vector3.New(var_142_3 / var_142_2.sprite.bounds.size.y < var_142_3 * manager.ui.mainCameraCom_.aspect / var_142_2.sprite.bounds.size.x and var_142_3 * manager.ui.mainCameraCom_.aspect / var_142_2.sprite.bounds.size.x or var_142_3 / var_142_2.sprite.bounds.size.y, var_142_3 / var_142_2.sprite.bounds.size.y < var_142_3 * manager.ui.mainCameraCom_.aspect / var_142_2.sprite.bounds.size.x and var_142_3 * manager.ui.mainCameraCom_.aspect / var_142_2.sprite.bounds.size.x or var_142_3 / var_142_2.sprite.bounds.size.y, 0)
				end

				for iter_142_0, iter_142_1 in pairs(arg_139_1.bgs_) do
					if iter_142_0 ~= "L10i" then
						iter_142_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_142_4 = 3

			if 3 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			if arg_139_1.time_ >= var_142_4 + 0.3 and arg_139_1.time_ < var_142_4 + 0.3 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_5 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_6 = 1

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_6 then
				local var_142_7 = Color.New(0, 0, 0)

				var_142_7.a = Mathf.Lerp(0, 1, (arg_139_1.time_ - var_142_5) / var_142_6)
				arg_139_1.mask_.color = var_142_7
			end

			if arg_139_1.time_ >= var_142_5 + var_142_6 and arg_139_1.time_ < var_142_5 + var_142_6 + arg_142_0 then
				local var_142_8 = Color.New(0, 0, 0)

				var_142_8.a = 1
				arg_139_1.mask_.color = var_142_8
			end

			local var_142_9 = 1

			if 1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_10 = 2

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_10 then
				local var_142_11 = Color.New(0, 0, 0)

				var_142_11.a = Mathf.Lerp(1, 0, (arg_139_1.time_ - var_142_9) / var_142_10)
				arg_139_1.mask_.color = var_142_11
			end

			if arg_139_1.time_ >= var_142_9 + var_142_10 and arg_139_1.time_ < var_142_9 + var_142_10 + arg_142_0 then
				local var_142_12 = Color.New(0, 0, 0)

				arg_139_1.mask_.enabled = false
				var_142_12.a = 0
				arg_139_1.mask_.color = var_142_12
			end

			local var_142_13 = arg_139_1.actors_["10104ui_story"].transform

			if 1 < arg_139_1.time_ and arg_139_1.time_ <= 1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10104ui_story = var_142_13.localPosition
			end

			local var_142_14 = 0.001

			if 1 <= arg_139_1.time_ and arg_139_1.time_ < 1 + var_142_14 then
				var_142_13.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 1) / var_142_14)
				var_142_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_13.position).x, (manager.ui.mainCamera.transform.position - var_142_13.position).y, (manager.ui.mainCamera.transform.position - var_142_13.position).z)
				var_142_13.localEulerAngles.z = 0
				var_142_13.localEulerAngles.x = 0
				var_142_13.localEulerAngles = var_142_13.localEulerAngles
			end

			if arg_139_1.time_ >= 1 + var_142_14 and arg_139_1.time_ < 1 + var_142_14 + arg_142_0 then
				var_142_13.localPosition = Vector3.New(0, 100, 0)
				var_142_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_13.position).x, (manager.ui.mainCamera.transform.position - var_142_13.position).y, (manager.ui.mainCamera.transform.position - var_142_13.position).z)
				var_142_13.localEulerAngles.z = 0
				var_142_13.localEulerAngles.x = 0
				var_142_13.localEulerAngles = var_142_13.localEulerAngles
			end

			local var_142_15 = arg_139_1.actors_["1284ui_story"].transform

			if 1 < arg_139_1.time_ and arg_139_1.time_ <= 1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1284ui_story = var_142_15.localPosition
			end

			local var_142_16 = 0.001

			if 1 <= arg_139_1.time_ and arg_139_1.time_ < 1 + var_142_16 then
				var_142_15.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 1) / var_142_16)
				var_142_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_15.position).x, (manager.ui.mainCamera.transform.position - var_142_15.position).y, (manager.ui.mainCamera.transform.position - var_142_15.position).z)
				var_142_15.localEulerAngles.z = 0
				var_142_15.localEulerAngles.x = 0
				var_142_15.localEulerAngles = var_142_15.localEulerAngles
			end

			if arg_139_1.time_ >= 1 + var_142_16 and arg_139_1.time_ < 1 + var_142_16 + arg_142_0 then
				var_142_15.localPosition = Vector3.New(0, 100, 0)
				var_142_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_15.position).x, (manager.ui.mainCamera.transform.position - var_142_15.position).y, (manager.ui.mainCamera.transform.position - var_142_15.position).z)
				var_142_15.localEulerAngles.z = 0
				var_142_15.localEulerAngles.x = 0
				var_142_15.localEulerAngles = var_142_15.localEulerAngles
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_142_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_139_1.bgmTxt_.text ~= var_142_19 and arg_139_1.bgmTxt_.text ~= "" then
						if arg_139_1.bgmTxt2_.text ~= "" then
							arg_139_1.bgmTxt_.text = arg_139_1.bgmTxt2_.text
						end

						arg_139_1.bgmTxt2_.text = var_142_19

						arg_139_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_139_1.bgmTxt_.text = var_142_19
						arg_139_1.bgmTxt2_.text = var_142_19
					end

					if arg_139_1.bgmTimer then
						arg_139_1.bgmTimer:Stop()

						arg_139_1.bgmTimer = nil
					end

					if arg_139_1.settingData.show_music_name == 1 then
						arg_139_1.musicController:SetSelectedState("show")
						arg_139_1.musicAnimator_:Play("open", 0, 0)

						if arg_139_1.settingData.music_time ~= 0 then
							arg_139_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_139_1.settingData.music_time), function()
								if arg_139_1 == nil or isNil(arg_139_1.bgmTxt_) then
									return
								end

								arg_139_1.musicController:SetSelectedState("hide")
								arg_139_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_139_1.time_ and arg_139_1.time_ <= 0.433333333333333 + arg_142_0 then
				arg_139_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_142_22 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if "" ~= "" then
					if arg_139_1.bgmTxt_.text ~= var_142_22 and arg_139_1.bgmTxt_.text ~= "" then
						if arg_139_1.bgmTxt2_.text ~= "" then
							arg_139_1.bgmTxt_.text = arg_139_1.bgmTxt2_.text
						end

						arg_139_1.bgmTxt2_.text = var_142_22

						arg_139_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_139_1.bgmTxt_.text = var_142_22
						arg_139_1.bgmTxt2_.text = var_142_22
					end

					if arg_139_1.bgmTimer then
						arg_139_1.bgmTimer:Stop()

						arg_139_1.bgmTimer = nil
					end

					if arg_139_1.settingData.show_music_name == 1 then
						arg_139_1.musicController:SetSelectedState("show")
						arg_139_1.musicAnimator_:Play("open", 0, 0)

						if arg_139_1.settingData.music_time ~= 0 then
							arg_139_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_139_1.settingData.music_time), function()
								if arg_139_1 == nil or isNil(arg_139_1.bgmTxt_) then
									return
								end

								arg_139_1.musicController:SetSelectedState("hide")
								arg_139_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.0340000018477437 < arg_139_1.time_ and arg_139_1.time_ <= 0.0340000018477437 + arg_142_0 then
				arg_139_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_battle monster", "")
			end

			if 0.6 < arg_139_1.time_ and arg_139_1.time_ <= 0.6 + arg_142_0 then
				arg_139_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind_loop02", "")
			end

			if 0.44 < arg_139_1.time_ and arg_139_1.time_ <= 0.44 + arg_142_0 then
				arg_139_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "init_story", "bgm_activity_4_5_story_serious.awb")

				local var_142_27 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_story")

				if "" ~= "" then
					if arg_139_1.bgmTxt_.text ~= var_142_27 and arg_139_1.bgmTxt_.text ~= "" then
						if arg_139_1.bgmTxt2_.text ~= "" then
							arg_139_1.bgmTxt_.text = arg_139_1.bgmTxt2_.text
						end

						arg_139_1.bgmTxt2_.text = var_142_27

						arg_139_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_139_1.bgmTxt_.text = var_142_27
						arg_139_1.bgmTxt2_.text = var_142_27
					end

					if arg_139_1.bgmTimer then
						arg_139_1.bgmTimer:Stop()

						arg_139_1.bgmTimer = nil
					end

					if arg_139_1.settingData.show_music_name == 1 then
						arg_139_1.musicController:SetSelectedState("show")
						arg_139_1.musicAnimator_:Play("open", 0, 0)

						if arg_139_1.settingData.music_time ~= 0 then
							arg_139_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_139_1.settingData.music_time), function()
								if arg_139_1 == nil or isNil(arg_139_1.bgmTxt_) then
									return
								end

								arg_139_1.musicController:SetSelectedState("hide")
								arg_139_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_28 = 3
			local var_142_29 = 0.075

			if 3 < arg_139_1.time_ and arg_139_1.time_ <= var_142_28 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_30 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_30:setOnUpdate(LuaHelper.FloatAction(function(arg_146_0)
					arg_139_1.dialogCg_.alpha = arg_146_0
				end))
				var_142_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_31 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(322011033).content)

				arg_139_1.text_.text = var_142_31

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_33 = 3 <= 0 and var_142_29 or var_142_29 * (utf8.len(var_142_31) / 3)

				if (3 <= 0 and var_142_29 or var_142_29 * (utf8.len(var_142_31) / 3)) > 0 and var_142_29 < var_142_33 then
					arg_139_1.talkMaxDuration = var_142_33
					var_142_28 = var_142_28 + 0.3

					if var_142_33 + var_142_28 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_33 + var_142_28
					end
				end

				arg_139_1.text_.text = var_142_31
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_34 = var_142_28 + 0.3
			local var_142_35 = math.max(var_142_29, arg_139_1.talkMaxDuration)

			if var_142_28 + 0.3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_34 + var_142_35 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_34) / var_142_35

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_34 + var_142_35 and arg_139_1.time_ < var_142_34 + var_142_35 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play322011034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 322011034
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play322011035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				local var_151_0 = arg_148_1.var_.effect1034

				if not arg_148_1.var_.effect1034 then
					var_151_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), manager.ui.mainCamera.transform)
					var_151_0.name = "1034"
					arg_148_1.var_.effect1034 = var_151_0
				else
					var_151_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_151_0.transform.localPosition = Vector3.New(0, 0, -2)
				var_151_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_151_2 = arg_148_1.bgs_.L10i.transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPosL10i = var_151_2.localPosition
			end

			local var_151_3 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 then
				var_151_2.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPosL10i, Vector3.New(0, 1, 10), (arg_148_1.time_ - 0) / var_151_3)
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 then
				var_151_2.localPosition = Vector3.New(0, 1, 10)
			end

			local var_151_4 = arg_148_1.bgs_.L10i.transform

			if 0.034 < arg_148_1.time_ and arg_148_1.time_ <= 0.034 + arg_151_0 then
				arg_148_1.var_.moveOldPosL10i = var_151_4.localPosition
			end

			local var_151_5 = 0.982666666666667

			if 0.034 <= arg_148_1.time_ and arg_148_1.time_ < 0.034 + var_151_5 then
				var_151_4.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPosL10i, Vector3.New(0, 1, 9.5), (arg_148_1.time_ - 0.034) / var_151_5)
			end

			if arg_148_1.time_ >= 0.034 + var_151_5 and arg_148_1.time_ < 0.034 + var_151_5 + arg_151_0 then
				var_151_4.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 0.0166666666666667 < arg_148_1.time_ and arg_148_1.time_ <= 0.0166666666666667 + arg_151_0 then
				arg_148_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind_parachuting02", "")
			end

			local var_151_7 = 0
			local var_151_8 = 1.125

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_7 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_9 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(322011034).content)

				arg_148_1.text_.text = var_151_9

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 45 <= 0 and var_151_8 or var_151_8 * (utf8.len(var_151_9) / 45)

				if (45 <= 0 and var_151_8 or var_151_8 * (utf8.len(var_151_9) / 45)) > 0 and var_151_8 < var_151_11 then
					arg_148_1.talkMaxDuration = var_151_11

					if var_151_11 + var_151_7 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_11 + var_151_7
					end
				end

				arg_148_1.text_.text = var_151_9
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_8, arg_148_1.talkMaxDuration)

			if var_151_7 <= arg_148_1.time_ and arg_148_1.time_ < var_151_7 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_7) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_7 + var_151_12 and arg_148_1.time_ < var_151_7 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "L10i",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "L10i",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.982666666666667,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play322011035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 322011035
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play322011036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 1.275

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(322011035).content)

				arg_152_1.text_.text = var_155_1

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_3 = 51 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 51)

				if (51 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 51)) > 0 and var_155_0 < var_155_3 then
					arg_152_1.talkMaxDuration = var_155_3

					if var_155_3 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_3 + 0
					end
				end

				arg_152_1.text_.text = var_155_1
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_4 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_4

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play322011036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 322011036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play322011037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 1.075

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(322011036).content)

				arg_156_1.text_.text = var_159_1

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_3 = 43 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 43)

				if (43 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 43)) > 0 and var_159_0 < var_159_3 then
					arg_156_1.talkMaxDuration = var_159_3

					if var_159_3 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_3 + 0
					end
				end

				arg_156_1.text_.text = var_159_1
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_4 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_4

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play322011037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322011037
		arg_160_1.duration_ = 10.7

		local var_160_0 = {
			zh = 5.766,
			ja = 10.7
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play322011038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.675

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_160_1.callingController_:SetSelectedState("calling")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_1 = arg_160_1:GetWordFromCfg(322011037)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 27 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 27)

				if (27 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 27)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011037", "story_v_out_322011.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011037", "story_v_out_322011.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_322011", "322011037", "story_v_out_322011.awb")

						arg_160_1:RecordAudio("322011037", var_163_6)
						arg_160_1:RecordAudio("322011037", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_322011", "322011037", "story_v_out_322011.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_322011", "322011037", "story_v_out_322011.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play322011038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322011038
		arg_164_1.duration_ = 11.77

		local var_164_0 = {
			zh = 6.6,
			ja = 11.766
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play322011039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.775

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_164_1.callingController_:SetSelectedState("calling")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:GetWordFromCfg(322011038)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 31 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 31)

				if (31 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 31)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011038", "story_v_out_322011.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011038", "story_v_out_322011.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_out_322011", "322011038", "story_v_out_322011.awb")

						arg_164_1:RecordAudio("322011038", var_167_6)
						arg_164_1:RecordAudio("322011038", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_322011", "322011038", "story_v_out_322011.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_322011", "322011038", "story_v_out_322011.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play322011039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 322011039
		arg_168_1.duration_ = 11.63

		local var_168_0 = {
			zh = 9,
			ja = 11.633
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play322011040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 1.175

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_168_1.callingController_:SetSelectedState("calling")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_1 = arg_168_1:GetWordFromCfg(322011039)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 47 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 47)

				if (47 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 47)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011039", "story_v_out_322011.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011039", "story_v_out_322011.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_322011", "322011039", "story_v_out_322011.awb")

						arg_168_1:RecordAudio("322011039", var_171_6)
						arg_168_1:RecordAudio("322011039", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_322011", "322011039", "story_v_out_322011.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_322011", "322011039", "story_v_out_322011.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play322011040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 322011040
		arg_172_1.duration_ = 13.6

		local var_172_0 = {
			zh = 8.966,
			ja = 13.6
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play322011041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 1.2

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_172_1.callingController_:SetSelectedState("calling")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:GetWordFromCfg(322011040)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 48 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 48)

				if (48 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 48)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011040", "story_v_out_322011.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011040", "story_v_out_322011.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_322011", "322011040", "story_v_out_322011.awb")

						arg_172_1:RecordAudio("322011040", var_175_6)
						arg_172_1:RecordAudio("322011040", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_322011", "322011040", "story_v_out_322011.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_322011", "322011040", "story_v_out_322011.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play322011041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 322011041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play322011042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 1.75

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(322011041).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 70 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 70)

				if (70 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 70)) > 0 and var_179_0 < var_179_3 then
					arg_176_1.talkMaxDuration = var_179_3

					if var_179_3 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_3 + 0
					end
				end

				arg_176_1.text_.text = var_179_1
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_4 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_4

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play322011042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 322011042
		arg_180_1.duration_ = 9

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play322011043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if arg_180_1.bgs_.L10g == nil then
				local var_183_0 = Object.Instantiate(arg_180_1.paintGo_)

				var_183_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10g")
				var_183_0.name = "L10g"
				var_183_0.transform.parent = arg_180_1.stage_.transform
				var_183_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_180_1.bgs_.L10g = var_183_0
			end

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= 2 + arg_183_0 then
				local var_183_1 = arg_180_1.bgs_.L10g

				arg_180_1.bgs_.L10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_183_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_183_2 = var_183_1:GetComponent("SpriteRenderer")

				if var_183_2 and var_183_2.sprite then
					local var_183_3 = 2 * (var_183_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_183_1.transform.localScale = Vector3.New(var_183_3 / var_183_2.sprite.bounds.size.y < var_183_3 * manager.ui.mainCameraCom_.aspect / var_183_2.sprite.bounds.size.x and var_183_3 * manager.ui.mainCameraCom_.aspect / var_183_2.sprite.bounds.size.x or var_183_3 / var_183_2.sprite.bounds.size.y, var_183_3 / var_183_2.sprite.bounds.size.y < var_183_3 * manager.ui.mainCameraCom_.aspect / var_183_2.sprite.bounds.size.x and var_183_3 * manager.ui.mainCameraCom_.aspect / var_183_2.sprite.bounds.size.x or var_183_3 / var_183_2.sprite.bounds.size.y, 0)
				end

				for iter_183_0, iter_183_1 in pairs(arg_180_1.bgs_) do
					if iter_183_0 ~= "L10g" then
						iter_183_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_183_4 = 4

			if 4 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1.allBtn_.enabled = false
			end

			if arg_180_1.time_ >= var_183_4 + 0.3 and arg_180_1.time_ < var_183_4 + 0.3 + arg_183_0 then
				arg_180_1.allBtn_.enabled = true
			end

			local var_183_5 = 0

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1.mask_.enabled = true
				arg_180_1.mask_.raycastTarget = true

				arg_180_1:SetGaussion(false)
			end

			local var_183_6 = 2

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_6 then
				local var_183_7 = Color.New(0, 0, 0)

				var_183_7.a = Mathf.Lerp(0, 1, (arg_180_1.time_ - var_183_5) / var_183_6)
				arg_180_1.mask_.color = var_183_7
			end

			if arg_180_1.time_ >= var_183_5 + var_183_6 and arg_180_1.time_ < var_183_5 + var_183_6 + arg_183_0 then
				local var_183_8 = Color.New(0, 0, 0)

				var_183_8.a = 1
				arg_180_1.mask_.color = var_183_8
			end

			local var_183_9 = 2

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 then
				arg_180_1.mask_.enabled = true
				arg_180_1.mask_.raycastTarget = true

				arg_180_1:SetGaussion(false)
			end

			local var_183_10 = 2

			if var_183_9 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_10 then
				local var_183_11 = Color.New(0, 0, 0)

				var_183_11.a = Mathf.Lerp(1, 0, (arg_180_1.time_ - var_183_9) / var_183_10)
				arg_180_1.mask_.color = var_183_11
			end

			if arg_180_1.time_ >= var_183_9 + var_183_10 and arg_180_1.time_ < var_183_9 + var_183_10 + arg_183_0 then
				local var_183_12 = Color.New(0, 0, 0)

				arg_180_1.mask_.enabled = false
				var_183_12.a = 0
				arg_180_1.mask_.color = var_183_12
			end

			local var_183_13 = manager.ui.mainCamera.transform

			if 3.60066666851441 < arg_180_1.time_ and arg_180_1.time_ <= 3.60066666851441 + arg_183_0 then
				arg_180_1.var_.shakeOldPos = var_183_13.localPosition
			end

			local var_183_14 = 0.39933333148559

			if 3.60066666851441 <= arg_180_1.time_ and arg_180_1.time_ < 3.60066666851441 + var_183_14 then
				local var_183_15, var_183_16 = math.modf((arg_180_1.time_ - 3.60066666851441) / 0.132)

				var_183_13.localPosition = Vector3.New(var_183_16 * 0.1, var_183_16 * 0.1, var_183_16 * 0.1) + arg_180_1.var_.shakeOldPos
			end

			if arg_180_1.time_ >= 3.60066666851441 + var_183_14 and arg_180_1.time_ < 3.60066666851441 + var_183_14 + arg_183_0 then
				var_183_13.localPosition = arg_180_1.var_.shakeOldPos
			end

			if 1.53333333333333 < arg_180_1.time_ and arg_180_1.time_ <= 1.53333333333333 + arg_183_0 then
				arg_180_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 0.1 < arg_180_1.time_ and arg_180_1.time_ <= 0.1 + arg_183_0 then
				arg_180_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_wind_loop02", "")
			end

			if 3.30066666851441 < arg_180_1.time_ and arg_180_1.time_ <= 3.30066666851441 + arg_183_0 then
				arg_180_1:AudioAction("play", "effect", "se_story_side_1050", "se_story_side_1050_fall", "")
			end

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= 2 + arg_183_0 then
				if arg_180_1.var_.effect1034 then
					Object.Destroy(arg_180_1.var_.effect1034)

					arg_180_1.var_.effect1034 = nil
				end
			end

			if arg_180_1.frameCnt_ <= 1 then
				arg_180_1.dialog_:SetActive(false)
			end

			local var_183_21 = 4
			local var_183_22 = 1.225

			if 4 < arg_180_1.time_ and arg_180_1.time_ <= var_183_21 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				arg_180_1.dialog_:SetActive(true)

				arg_180_1.dialogCg_.alpha = 0

				local var_183_23 = LeanTween.value(arg_180_1.dialog_, 0, 1, 0.3)

				var_183_23:setOnUpdate(LuaHelper.FloatAction(function(arg_184_0)
					arg_180_1.dialogCg_.alpha = arg_184_0
				end))
				var_183_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_180_1.dialog_)
					var_183_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_180_1.duration_ = arg_180_1.duration_ + 0.3

				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_24 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(322011042).content)

				arg_180_1.text_.text = var_183_24

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_26 = 49 <= 0 and var_183_22 or var_183_22 * (utf8.len(var_183_24) / 49)

				if (49 <= 0 and var_183_22 or var_183_22 * (utf8.len(var_183_24) / 49)) > 0 and var_183_22 < var_183_26 then
					arg_180_1.talkMaxDuration = var_183_26
					var_183_21 = var_183_21 + 0.3

					if var_183_26 + var_183_21 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_26 + var_183_21
					end
				end

				arg_180_1.text_.text = var_183_24
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_27 = var_183_21 + 0.3
			local var_183_28 = math.max(var_183_22, arg_180_1.talkMaxDuration)

			if var_183_21 + 0.3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_27 + var_183_28 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_27) / var_183_28

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_27 + var_183_28 and arg_180_1.time_ < var_183_27 + var_183_28 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play322011043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 322011043
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play322011044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.125

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(322011043).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 5 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 5)

				if (5 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 5)) > 0 and var_189_0 < var_189_3 then
					arg_186_1.talkMaxDuration = var_189_3

					if var_189_3 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_3 + 0
					end
				end

				arg_186_1.text_.text = var_189_1
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_4 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_4

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play322011044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 322011044
		arg_190_1.duration_ = 5.83

		local var_190_0 = {
			zh = 3.5,
			ja = 5.833
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play322011045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1284ui_story = arg_190_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1284ui_story"].transform.position).z)
				arg_190_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1284ui_story"].transform.localEulerAngles = arg_190_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_190_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1284ui_story"].transform.position).z)
				arg_190_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1284ui_story"].transform.localEulerAngles = arg_190_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1284ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1284ui_story == nil then
				arg_190_1.var_.characterEffect1284ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1284ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1284ui_story then
				arg_190_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_193_4 = 0
			local var_193_5 = 0.525

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(322011044)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 21 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 21)

				if (21 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 21)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011044", "story_v_out_322011.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_322011", "322011044", "story_v_out_322011.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_322011", "322011044", "story_v_out_322011.awb")

						arg_190_1:RecordAudio("322011044", var_193_11)
						arg_190_1:RecordAudio("322011044", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_322011", "322011044", "story_v_out_322011.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_322011", "322011044", "story_v_out_322011.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play322011045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 322011045
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play322011046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1284ui_story"]) and arg_194_1.var_.characterEffect1284ui_story == nil then
				arg_194_1.var_.characterEffect1284ui_story = arg_194_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1284ui_story"]) then
				if arg_194_1.var_.characterEffect1284ui_story and not isNil(arg_194_1.actors_["1284ui_story"]) then
					arg_194_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_0)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1284ui_story"]) and arg_194_1.var_.characterEffect1284ui_story then
				arg_194_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_197_1 = 0
			local var_197_2 = 0.225

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(322011045).content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 9 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 9)

				if (9 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 9)) > 0 and var_197_2 < var_197_5 then
					arg_194_1.talkMaxDuration = var_197_5

					if var_197_5 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + var_197_1
					end
				end

				arg_194_1.text_.text = var_197_3
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_6 = math.max(var_197_2, arg_194_1.talkMaxDuration)

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_6 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_1) / var_197_6

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_1 + var_197_6 and arg_194_1.time_ < var_197_1 + var_197_6 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play322011046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 322011046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play322011047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1284ui_story = arg_198_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1284ui_story"].transform.position).z)
				arg_198_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1284ui_story"].transform.localEulerAngles = arg_198_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1284ui_story"].transform.position).z)
				arg_198_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1284ui_story"].transform.localEulerAngles = arg_198_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_198_1.time_ and arg_198_1.time_ <= 0.1 + arg_201_0 then
				arg_198_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_201_2 = 0
			local var_201_3 = 1.325

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_2 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_4 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(322011046).content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_6 = 53 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_4) / 53)

				if (53 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_4) / 53)) > 0 and var_201_3 < var_201_6 then
					arg_198_1.talkMaxDuration = var_201_6

					if var_201_6 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_2
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_3, arg_198_1.talkMaxDuration)

			if var_201_2 <= arg_198_1.time_ and arg_198_1.time_ < var_201_2 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_2) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_2 + var_201_7 and arg_198_1.time_ < var_201_2 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play322011047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 322011047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play322011048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.475

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_1 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(322011047).content)

				arg_202_1.text_.text = var_205_1

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_3 = 19 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 19)

				if (19 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 19)) > 0 and var_205_0 < var_205_3 then
					arg_202_1.talkMaxDuration = var_205_3

					if var_205_3 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_3 + 0
					end
				end

				arg_202_1.text_.text = var_205_1
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_4 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_4

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play322011048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 322011048
		arg_206_1.duration_ = 9.07

		local var_206_0 = {
			zh = 6.633,
			ja = 9.066
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play322011049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1284ui_story = arg_206_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1284ui_story"].transform.position).z)
				arg_206_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1284ui_story"].transform.localEulerAngles = arg_206_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_206_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1284ui_story"].transform.position).z)
				arg_206_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1284ui_story"].transform.localEulerAngles = arg_206_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1284ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1284ui_story == nil then
				arg_206_1.var_.characterEffect1284ui_story = var_209_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 and not isNil(var_209_1) then
				if arg_206_1.var_.characterEffect1284ui_story and not isNil(var_209_1) then
					arg_206_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1284ui_story then
				arg_206_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_2")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_209_4 = 0
			local var_209_5 = 0.8

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_6 = arg_206_1:GetWordFromCfg(322011048)
				local var_209_7 = arg_206_1:FormatText(var_209_6.content)

				arg_206_1.text_.text = var_209_7

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_9 = 32 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 32)

				if (32 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 32)) > 0 and var_209_5 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_4
					end
				end

				arg_206_1.text_.text = var_209_7
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011048", "story_v_out_322011.awb") ~= 0 then
					local var_209_10 = manager.audio:GetVoiceLength("story_v_out_322011", "322011048", "story_v_out_322011.awb") / 1000

					if var_209_10 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_4
					end

					if var_209_6.prefab_name ~= "" and arg_206_1.actors_[var_209_6.prefab_name] ~= nil then
						local var_209_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_6.prefab_name].transform, "story_v_out_322011", "322011048", "story_v_out_322011.awb")

						arg_206_1:RecordAudio("322011048", var_209_11)
						arg_206_1:RecordAudio("322011048", var_209_11)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_322011", "322011048", "story_v_out_322011.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_322011", "322011048", "story_v_out_322011.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_12 = math.max(var_209_5, arg_206_1.talkMaxDuration)

			if var_209_4 <= arg_206_1.time_ and arg_206_1.time_ < var_209_4 + var_209_12 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_4) / var_209_12

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_4 + var_209_12 and arg_206_1.time_ < var_209_4 + var_209_12 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play322011049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 322011049
		arg_210_1.duration_ = 2

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play322011050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_213_0 = 0
			local var_213_1 = 0.175

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_2 = arg_210_1:GetWordFromCfg(322011049)
				local var_213_3 = arg_210_1:FormatText(var_213_2.content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 7 <= 0 and var_213_1 or var_213_1 * (utf8.len(var_213_3) / 7)

				if (7 <= 0 and var_213_1 or var_213_1 * (utf8.len(var_213_3) / 7)) > 0 and var_213_1 < var_213_5 then
					arg_210_1.talkMaxDuration = var_213_5

					if var_213_5 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011049", "story_v_out_322011.awb") ~= 0 then
					local var_213_6 = manager.audio:GetVoiceLength("story_v_out_322011", "322011049", "story_v_out_322011.awb") / 1000

					if var_213_6 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_0
					end

					if var_213_2.prefab_name ~= "" and arg_210_1.actors_[var_213_2.prefab_name] ~= nil then
						local var_213_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_2.prefab_name].transform, "story_v_out_322011", "322011049", "story_v_out_322011.awb")

						arg_210_1:RecordAudio("322011049", var_213_7)
						arg_210_1:RecordAudio("322011049", var_213_7)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_322011", "322011049", "story_v_out_322011.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_322011", "322011049", "story_v_out_322011.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_8 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_8 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_8

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_8 and arg_210_1.time_ < var_213_0 + var_213_8 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play322011050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 322011050
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play322011051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1284ui_story = arg_214_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1284ui_story"].transform.position).z)
				arg_214_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1284ui_story"].transform.localEulerAngles = arg_214_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_214_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1284ui_story"].transform.position).z)
				arg_214_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1284ui_story"].transform.localEulerAngles = arg_214_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_217_1 = 0
			local var_217_2 = 1.75

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(322011050).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 70 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 70)

				if (70 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 70)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play322011051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 322011051
		arg_218_1.duration_ = 6.07

		local var_218_0 = {
			zh = 3.066,
			ja = 6.066
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play322011052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.25

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:GetWordFromCfg(322011051)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 10 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 10)

				if (10 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 10)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011051", "story_v_out_322011.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011051", "story_v_out_322011.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_out_322011", "322011051", "story_v_out_322011.awb")

						arg_218_1:RecordAudio("322011051", var_221_6)
						arg_218_1:RecordAudio("322011051", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_322011", "322011051", "story_v_out_322011.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_322011", "322011051", "story_v_out_322011.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play322011052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 322011052
		arg_222_1.duration_ = 2.37

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play322011053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if arg_222_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_225_0 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_222_1.stage_.transform)

				var_225_0.name = "1043ui_story"
				var_225_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_222_1.actors_["1043ui_story"] = var_225_0

				local var_225_1 = var_225_0:GetComponentInChildren(typeof(CharacterEffect))

				var_225_1.enabled = true

				local var_225_2 = GameObjectTools.GetOrAddComponent(var_225_0, typeof(DynamicBoneHelper))

				if var_225_2 then
					var_225_2:EnableDynamicBone(false)
				end

				arg_222_1:ShowWeapon(var_225_1.transform, false)

				arg_222_1.var_["1043ui_story" .. "Animator"] = var_225_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_222_1.var_["1043ui_story" .. "Animator"].applyRootMotion = true
				arg_222_1.var_["1043ui_story" .. "LipSync"] = var_225_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_225_3 = arg_222_1.actors_["1043ui_story"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1043ui_story = var_225_3.localPosition
			end

			local var_225_4 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				var_225_3.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_222_1.time_ - 0) / var_225_4)
				var_225_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_3.position).x, (manager.ui.mainCamera.transform.position - var_225_3.position).y, (manager.ui.mainCamera.transform.position - var_225_3.position).z)
				var_225_3.localEulerAngles.z = 0
				var_225_3.localEulerAngles.x = 0
				var_225_3.localEulerAngles = var_225_3.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				var_225_3.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_225_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_3.position).x, (manager.ui.mainCamera.transform.position - var_225_3.position).y, (manager.ui.mainCamera.transform.position - var_225_3.position).z)
				var_225_3.localEulerAngles.z = 0
				var_225_3.localEulerAngles.x = 0
				var_225_3.localEulerAngles = var_225_3.localEulerAngles
			end

			local var_225_5 = arg_222_1.actors_["1043ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_5) and arg_222_1.var_.characterEffect1043ui_story == nil then
				arg_222_1.var_.characterEffect1043ui_story = var_225_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_6 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_6 and not isNil(var_225_5) then
				if arg_222_1.var_.characterEffect1043ui_story and not isNil(var_225_5) then
					arg_222_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_6 and arg_222_1.time_ < 0 + var_225_6 + arg_225_0 and not isNil(var_225_5) and arg_222_1.var_.characterEffect1043ui_story then
				arg_222_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.36666666666667 < arg_222_1.time_ and arg_222_1.time_ <= 1.36666666666667 + arg_225_0 then
				arg_222_1:AudioAction("play", "effect", "se_story_145", "se_story_145_metal", "")
			end

			local var_225_9 = 0
			local var_225_10 = 0.075

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_11 = arg_222_1:GetWordFromCfg(322011052)
				local var_225_12 = arg_222_1:FormatText(var_225_11.content)

				arg_222_1.text_.text = var_225_12

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_14 = 3 <= 0 and var_225_10 or var_225_10 * (utf8.len(var_225_12) / 3)

				if (3 <= 0 and var_225_10 or var_225_10 * (utf8.len(var_225_12) / 3)) > 0 and var_225_10 < var_225_14 then
					arg_222_1.talkMaxDuration = var_225_14

					if var_225_14 + var_225_9 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_14 + var_225_9
					end
				end

				arg_222_1.text_.text = var_225_12
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011052", "story_v_out_322011.awb") ~= 0 then
					local var_225_15 = manager.audio:GetVoiceLength("story_v_out_322011", "322011052", "story_v_out_322011.awb") / 1000

					if var_225_15 + var_225_9 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_15 + var_225_9
					end

					if var_225_11.prefab_name ~= "" and arg_222_1.actors_[var_225_11.prefab_name] ~= nil then
						local var_225_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_11.prefab_name].transform, "story_v_out_322011", "322011052", "story_v_out_322011.awb")

						arg_222_1:RecordAudio("322011052", var_225_16)
						arg_222_1:RecordAudio("322011052", var_225_16)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_322011", "322011052", "story_v_out_322011.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_322011", "322011052", "story_v_out_322011.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_17 = math.max(var_225_10, arg_222_1.talkMaxDuration)

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_17 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_9) / var_225_17

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_9 + var_225_17 and arg_222_1.time_ < var_225_9 + var_225_17 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play322011053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 322011053
		arg_226_1.duration_ = 6.03

		local var_226_0 = {
			zh = 3.833,
			ja = 6.033
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play322011054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1043ui_story"]) and arg_226_1.var_.characterEffect1043ui_story == nil then
				arg_226_1.var_.characterEffect1043ui_story = arg_226_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1043ui_story"]) then
				if arg_226_1.var_.characterEffect1043ui_story and not isNil(arg_226_1.actors_["1043ui_story"]) then
					arg_226_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1043ui_story"]) and arg_226_1.var_.characterEffect1043ui_story then
				arg_226_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.325

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:GetWordFromCfg(322011053)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_6 = 13 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_4) / 13)

				if (13 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_4) / 13)) > 0 and var_229_2 < var_229_6 then
					arg_226_1.talkMaxDuration = var_229_6

					if var_229_6 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011053", "story_v_out_322011.awb") ~= 0 then
					local var_229_7 = manager.audio:GetVoiceLength("story_v_out_322011", "322011053", "story_v_out_322011.awb") / 1000

					if var_229_7 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_1
					end

					if var_229_3.prefab_name ~= "" and arg_226_1.actors_[var_229_3.prefab_name] ~= nil then
						local var_229_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_3.prefab_name].transform, "story_v_out_322011", "322011053", "story_v_out_322011.awb")

						arg_226_1:RecordAudio("322011053", var_229_8)
						arg_226_1:RecordAudio("322011053", var_229_8)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_322011", "322011053", "story_v_out_322011.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_322011", "322011053", "story_v_out_322011.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_9 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_9 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_9

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_9 and arg_226_1.time_ < var_229_1 + var_229_9 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play322011054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 322011054
		arg_230_1.duration_ = 3.6

		local var_230_0 = {
			zh = 2.5,
			ja = 3.6
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play322011055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.3

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_1 = arg_230_1:GetWordFromCfg(322011054)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 12 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 12)

				if (12 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 12)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011054", "story_v_out_322011.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011054", "story_v_out_322011.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_322011", "322011054", "story_v_out_322011.awb")

						arg_230_1:RecordAudio("322011054", var_233_6)
						arg_230_1:RecordAudio("322011054", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_322011", "322011054", "story_v_out_322011.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_322011", "322011054", "story_v_out_322011.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play322011055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 322011055
		arg_234_1.duration_ = 3.2

		local var_234_0 = {
			zh = 3.2,
			ja = 1.999999999999
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play322011056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1043ui_story = arg_234_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1043ui_story"].transform.position).z)
				arg_234_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1043ui_story"].transform.localEulerAngles = arg_234_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_234_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1043ui_story"].transform.position).z)
				arg_234_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1043ui_story"].transform.localEulerAngles = arg_234_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["1043ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1043ui_story == nil then
				arg_234_1.var_.characterEffect1043ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect1043ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1043ui_story then
				arg_234_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_237_4 = 0
			local var_237_5 = 0.2

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_6 = arg_234_1:GetWordFromCfg(322011055)
				local var_237_7 = arg_234_1:FormatText(var_237_6.content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 8 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 8)

				if (8 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 8)) > 0 and var_237_5 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011055", "story_v_out_322011.awb") ~= 0 then
					local var_237_10 = manager.audio:GetVoiceLength("story_v_out_322011", "322011055", "story_v_out_322011.awb") / 1000

					if var_237_10 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_4
					end

					if var_237_6.prefab_name ~= "" and arg_234_1.actors_[var_237_6.prefab_name] ~= nil then
						local var_237_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_6.prefab_name].transform, "story_v_out_322011", "322011055", "story_v_out_322011.awb")

						arg_234_1:RecordAudio("322011055", var_237_11)
						arg_234_1:RecordAudio("322011055", var_237_11)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_322011", "322011055", "story_v_out_322011.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_322011", "322011055", "story_v_out_322011.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_12 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_12 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_12

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_12 and arg_234_1.time_ < var_237_4 + var_237_12 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play322011056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 322011056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play322011057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1043ui_story"]) and arg_238_1.var_.characterEffect1043ui_story == nil then
				arg_238_1.var_.characterEffect1043ui_story = arg_238_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1043ui_story"]) then
				if arg_238_1.var_.characterEffect1043ui_story and not isNil(arg_238_1.actors_["1043ui_story"]) then
					arg_238_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1043ui_story"]) and arg_238_1.var_.characterEffect1043ui_story then
				arg_238_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.1

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(322011056).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 4 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 4)

				if (4 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 4)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play322011057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 322011057
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play322011058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1043ui_story = arg_242_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1043ui_story"].transform.position).z)
				arg_242_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1043ui_story"].transform.localEulerAngles = arg_242_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1043ui_story"].transform.position).z)
				arg_242_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1043ui_story"].transform.localEulerAngles = arg_242_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if 0.866666666666667 < arg_242_1.time_ and arg_242_1.time_ <= 0.866666666666667 + arg_245_0 then
				arg_242_1:AudioAction("play", "effect", "se_story_140", "se_story_140_safetybelt", "")
			end

			local var_245_2 = 0
			local var_245_3 = 1.625

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_4 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(322011057).content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_6 = 65 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_4) / 65)

				if (65 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_4) / 65)) > 0 and var_245_3 < var_245_6 then
					arg_242_1.talkMaxDuration = var_245_6

					if var_245_6 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_6 + var_245_2
					end
				end

				arg_242_1.text_.text = var_245_4
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_3, arg_242_1.talkMaxDuration)

			if var_245_2 <= arg_242_1.time_ and arg_242_1.time_ < var_245_2 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_2) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_2 + var_245_7 and arg_242_1.time_ < var_245_2 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play322011058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 322011058
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play322011059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 1.4

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(322011058).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 56 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 56)

				if (56 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 56)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play322011059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 322011059
		arg_250_1.duration_ = 2.9

		local var_250_0 = {
			zh = 2.9,
			ja = 2.8
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play322011060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1043ui_story = arg_250_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_253_0 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				arg_250_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1043ui_story"].transform.position).z)
				arg_250_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1043ui_story"].transform.localEulerAngles = arg_250_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				arg_250_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_250_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1043ui_story"].transform.position).z)
				arg_250_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1043ui_story"].transform.localEulerAngles = arg_250_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_253_1 = arg_250_1.actors_["1043ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1043ui_story == nil then
				arg_250_1.var_.characterEffect1043ui_story = var_253_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_2 and not isNil(var_253_1) then
				if arg_250_1.var_.characterEffect1043ui_story and not isNil(var_253_1) then
					arg_250_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_2 and arg_250_1.time_ < 0 + var_253_2 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1043ui_story then
				arg_250_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_253_4 = 0
			local var_253_5 = 0.2

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_6 = arg_250_1:GetWordFromCfg(322011059)
				local var_253_7 = arg_250_1:FormatText(var_253_6.content)

				arg_250_1.text_.text = var_253_7

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_9 = 8 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 8)

				if (8 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 8)) > 0 and var_253_5 < var_253_9 then
					arg_250_1.talkMaxDuration = var_253_9

					if var_253_9 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_9 + var_253_4
					end
				end

				arg_250_1.text_.text = var_253_7
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011059", "story_v_out_322011.awb") ~= 0 then
					local var_253_10 = manager.audio:GetVoiceLength("story_v_out_322011", "322011059", "story_v_out_322011.awb") / 1000

					if var_253_10 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_4
					end

					if var_253_6.prefab_name ~= "" and arg_250_1.actors_[var_253_6.prefab_name] ~= nil then
						local var_253_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_6.prefab_name].transform, "story_v_out_322011", "322011059", "story_v_out_322011.awb")

						arg_250_1:RecordAudio("322011059", var_253_11)
						arg_250_1:RecordAudio("322011059", var_253_11)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_322011", "322011059", "story_v_out_322011.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_322011", "322011059", "story_v_out_322011.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_12 = math.max(var_253_5, arg_250_1.talkMaxDuration)

			if var_253_4 <= arg_250_1.time_ and arg_250_1.time_ < var_253_4 + var_253_12 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_4) / var_253_12

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_4 + var_253_12 and arg_250_1.time_ < var_253_4 + var_253_12 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play322011060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 322011060
		arg_254_1.duration_ = 4.07

		local var_254_0 = {
			zh = 3.333,
			ja = 4.066
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play322011061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1284ui_story = arg_254_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1284ui_story"].transform.position).z)
				arg_254_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1284ui_story"].transform.localEulerAngles = arg_254_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_254_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1284ui_story"].transform.position).z)
				arg_254_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1284ui_story"].transform.localEulerAngles = arg_254_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_257_1 = arg_254_1.actors_["1043ui_story"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1043ui_story = var_257_1.localPosition
			end

			local var_257_2 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 then
				var_257_1.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1043ui_story, Vector3.New(-0.92, -1.01, -5.73), (arg_254_1.time_ - 0) / var_257_2)
				var_257_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_1.position).x, (manager.ui.mainCamera.transform.position - var_257_1.position).y, (manager.ui.mainCamera.transform.position - var_257_1.position).z)
				var_257_1.localEulerAngles.z = 0
				var_257_1.localEulerAngles.x = 0
				var_257_1.localEulerAngles = var_257_1.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 then
				var_257_1.localPosition = Vector3.New(-0.92, -1.01, -5.73)
				var_257_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_1.position).x, (manager.ui.mainCamera.transform.position - var_257_1.position).y, (manager.ui.mainCamera.transform.position - var_257_1.position).z)
				var_257_1.localEulerAngles.z = 0
				var_257_1.localEulerAngles.x = 0
				var_257_1.localEulerAngles = var_257_1.localEulerAngles
			end

			local var_257_3 = arg_254_1.actors_["1284ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_3) and arg_254_1.var_.characterEffect1284ui_story == nil then
				arg_254_1.var_.characterEffect1284ui_story = var_257_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_4 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 and not isNil(var_257_3) then
				if arg_254_1.var_.characterEffect1284ui_story and not isNil(var_257_3) then
					arg_254_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 and not isNil(var_257_3) and arg_254_1.var_.characterEffect1284ui_story then
				arg_254_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_257_6 = arg_254_1.actors_["1043ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_6) and arg_254_1.var_.characterEffect1043ui_story == nil then
				arg_254_1.var_.characterEffect1043ui_story = var_257_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_7 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 and not isNil(var_257_6) then
				if arg_254_1.var_.characterEffect1043ui_story and not isNil(var_257_6) then
					arg_254_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_7)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 and not isNil(var_257_6) and arg_254_1.var_.characterEffect1043ui_story then
				arg_254_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_257_8 = 0
			local var_257_9 = 0.25

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_8 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_10 = arg_254_1:GetWordFromCfg(322011060)
				local var_257_11 = arg_254_1:FormatText(var_257_10.content)

				arg_254_1.text_.text = var_257_11

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_13 = 10 <= 0 and var_257_9 or var_257_9 * (utf8.len(var_257_11) / 10)

				if (10 <= 0 and var_257_9 or var_257_9 * (utf8.len(var_257_11) / 10)) > 0 and var_257_9 < var_257_13 then
					arg_254_1.talkMaxDuration = var_257_13

					if var_257_13 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_8
					end
				end

				arg_254_1.text_.text = var_257_11
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011060", "story_v_out_322011.awb") ~= 0 then
					local var_257_14 = manager.audio:GetVoiceLength("story_v_out_322011", "322011060", "story_v_out_322011.awb") / 1000

					if var_257_14 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_14 + var_257_8
					end

					if var_257_10.prefab_name ~= "" and arg_254_1.actors_[var_257_10.prefab_name] ~= nil then
						local var_257_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_10.prefab_name].transform, "story_v_out_322011", "322011060", "story_v_out_322011.awb")

						arg_254_1:RecordAudio("322011060", var_257_15)
						arg_254_1:RecordAudio("322011060", var_257_15)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_322011", "322011060", "story_v_out_322011.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_322011", "322011060", "story_v_out_322011.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_16 = math.max(var_257_9, arg_254_1.talkMaxDuration)

			if var_257_8 <= arg_254_1.time_ and arg_254_1.time_ < var_257_8 + var_257_16 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_8) / var_257_16

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_8 + var_257_16 and arg_254_1.time_ < var_257_8 + var_257_16 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play322011061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 322011061
		arg_258_1.duration_ = 1

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"

			SetActive(arg_258_1.choicesGo_, true)

			for iter_259_0, iter_259_1 in ipairs(arg_258_1.choices_) do
				SetActive(iter_259_1.go, iter_259_0 <= 3)
			end

			arg_258_1.choices_[1].txt.text = arg_258_1:FormatText(StoryChoiceCfg[1398].name)
			arg_258_1.choices_[2].txt.text = arg_258_1:FormatText(StoryChoiceCfg[1399].name)
			arg_258_1.choices_[3].txt.text = arg_258_1:FormatText(StoryChoiceCfg[1400].name)
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play322011062(arg_258_1)
			end

			if arg_260_0 == 2 then
				arg_258_0:Play322011062(arg_258_1)
			end

			if arg_260_0 == 3 then
				arg_258_0:Play322011062(arg_258_1)
			end

			arg_258_1:RecordChoiceLog(322011061, 1398, 1399, 1400)
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1284ui_story"]) and arg_258_1.var_.characterEffect1284ui_story == nil then
				arg_258_1.var_.characterEffect1284ui_story = arg_258_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1284ui_story"]) then
				if arg_258_1.var_.characterEffect1284ui_story and not isNil(arg_258_1.actors_["1284ui_story"]) then
					arg_258_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_0)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1284ui_story"]) and arg_258_1.var_.characterEffect1284ui_story then
				arg_258_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_261_1 = arg_258_1.actors_["1043ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1043ui_story == nil then
				arg_258_1.var_.characterEffect1043ui_story = var_261_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 and not isNil(var_261_1) then
				if arg_258_1.var_.characterEffect1043ui_story and not isNil(var_261_1) then
					arg_258_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_2)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1043ui_story then
				arg_258_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play322011062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 322011062
		arg_262_1.duration_ = 2.2

		local var_262_0 = {
			zh = 2.2,
			ja = 2.033
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play322011063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1043ui_story = arg_262_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_265_0 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 then
				arg_262_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1043ui_story, Vector3.New(-0.92, -1.01, -5.73), (arg_262_1.time_ - 0) / var_265_0)
				arg_262_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1043ui_story"].transform.position).z)
				arg_262_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1043ui_story"].transform.localEulerAngles = arg_262_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 then
				arg_262_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(-0.92, -1.01, -5.73)
				arg_262_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1043ui_story"].transform.position).z)
				arg_262_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1043ui_story"].transform.localEulerAngles = arg_262_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_265_1 = arg_262_1.actors_["1043ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect1043ui_story == nil then
				arg_262_1.var_.characterEffect1043ui_story = var_265_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_2 and not isNil(var_265_1) then
				if arg_262_1.var_.characterEffect1043ui_story and not isNil(var_265_1) then
					arg_262_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_2 and arg_262_1.time_ < 0 + var_265_2 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect1043ui_story then
				arg_262_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_265_4 = "1043ui_story"

			if arg_262_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_265_5 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_262_1.stage_.transform)

				var_265_5.name = var_265_4
				var_265_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_262_1.actors_[var_265_4] = var_265_5

				local var_265_6 = var_265_5:GetComponentInChildren(typeof(CharacterEffect))

				var_265_6.enabled = true

				local var_265_7 = GameObjectTools.GetOrAddComponent(var_265_5, typeof(DynamicBoneHelper))

				if var_265_7 then
					var_265_7:EnableDynamicBone(false)
				end

				arg_262_1:ShowWeapon(var_265_6.transform, false)

				arg_262_1.var_[var_265_4 .. "Animator"] = var_265_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_262_1.var_[var_265_4 .. "Animator"].applyRootMotion = true
				arg_262_1.var_[var_265_4 .. "LipSync"] = var_265_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_265_8 = "1043ui_story"

			if arg_262_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_265_9 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_262_1.stage_.transform)

				var_265_9.name = var_265_8
				var_265_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_262_1.actors_[var_265_8] = var_265_9

				local var_265_10 = var_265_9:GetComponentInChildren(typeof(CharacterEffect))

				var_265_10.enabled = true

				local var_265_11 = GameObjectTools.GetOrAddComponent(var_265_9, typeof(DynamicBoneHelper))

				if var_265_11 then
					var_265_11:EnableDynamicBone(false)
				end

				arg_262_1:ShowWeapon(var_265_10.transform, false)

				arg_262_1.var_[var_265_8 .. "Animator"] = var_265_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_262_1.var_[var_265_8 .. "Animator"].applyRootMotion = true
				arg_262_1.var_[var_265_8 .. "LipSync"] = var_265_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_265_12 = "1284ui_story"

			if arg_262_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_265_13 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_262_1.stage_.transform)

				var_265_13.name = var_265_12
				var_265_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_262_1.actors_[var_265_12] = var_265_13

				local var_265_14 = var_265_13:GetComponentInChildren(typeof(CharacterEffect))

				var_265_14.enabled = true

				local var_265_15 = GameObjectTools.GetOrAddComponent(var_265_13, typeof(DynamicBoneHelper))

				if var_265_15 then
					var_265_15:EnableDynamicBone(false)
				end

				arg_262_1:ShowWeapon(var_265_14.transform, false)

				arg_262_1.var_[var_265_12 .. "Animator"] = var_265_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_262_1.var_[var_265_12 .. "Animator"].applyRootMotion = true
				arg_262_1.var_[var_265_12 .. "LipSync"] = var_265_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			local var_265_16 = 0
			local var_265_17 = 0.25

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_16 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_18 = arg_262_1:GetWordFromCfg(322011062)
				local var_265_19 = arg_262_1:FormatText(var_265_18.content)

				arg_262_1.text_.text = var_265_19

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_21 = 10 <= 0 and var_265_17 or var_265_17 * (utf8.len(var_265_19) / 10)

				if (10 <= 0 and var_265_17 or var_265_17 * (utf8.len(var_265_19) / 10)) > 0 and var_265_17 < var_265_21 then
					arg_262_1.talkMaxDuration = var_265_21

					if var_265_21 + var_265_16 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_21 + var_265_16
					end
				end

				arg_262_1.text_.text = var_265_19
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011062", "story_v_out_322011.awb") ~= 0 then
					local var_265_22 = manager.audio:GetVoiceLength("story_v_out_322011", "322011062", "story_v_out_322011.awb") / 1000

					if var_265_22 + var_265_16 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_22 + var_265_16
					end

					if var_265_18.prefab_name ~= "" and arg_262_1.actors_[var_265_18.prefab_name] ~= nil then
						local var_265_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_18.prefab_name].transform, "story_v_out_322011", "322011062", "story_v_out_322011.awb")

						arg_262_1:RecordAudio("322011062", var_265_23)
						arg_262_1:RecordAudio("322011062", var_265_23)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_322011", "322011062", "story_v_out_322011.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_322011", "322011062", "story_v_out_322011.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_24 = math.max(var_265_17, arg_262_1.talkMaxDuration)

			if var_265_16 <= arg_262_1.time_ and arg_262_1.time_ < var_265_16 + var_265_24 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_16) / var_265_24

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_16 + var_265_24 and arg_262_1.time_ < var_265_16 + var_265_24 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play322011063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 322011063
		arg_266_1.duration_ = 11.87

		local var_266_0 = {
			zh = 10.866,
			ja = 11.866
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play322011064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 1.1

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_1 = arg_266_1:GetWordFromCfg(322011063)
				local var_269_2 = arg_266_1:FormatText(var_269_1.content)

				arg_266_1.text_.text = var_269_2

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 44 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 44)

				if (44 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 44)) > 0 and var_269_0 < var_269_4 then
					arg_266_1.talkMaxDuration = var_269_4

					if var_269_4 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_4 + 0
					end
				end

				arg_266_1.text_.text = var_269_2
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011063", "story_v_out_322011.awb") ~= 0 then
					local var_269_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011063", "story_v_out_322011.awb") / 1000

					if var_269_5 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + 0
					end

					if var_269_1.prefab_name ~= "" and arg_266_1.actors_[var_269_1.prefab_name] ~= nil then
						local var_269_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_1.prefab_name].transform, "story_v_out_322011", "322011063", "story_v_out_322011.awb")

						arg_266_1:RecordAudio("322011063", var_269_6)
						arg_266_1:RecordAudio("322011063", var_269_6)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_322011", "322011063", "story_v_out_322011.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_322011", "322011063", "story_v_out_322011.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play322011064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 322011064
		arg_270_1.duration_ = 8.87

		local var_270_0 = {
			zh = 8.8,
			ja = 8.866
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play322011065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_273_0 = 0
			local var_273_1 = 0.775

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_2 = arg_270_1:GetWordFromCfg(322011064)
				local var_273_3 = arg_270_1:FormatText(var_273_2.content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 32 <= 0 and var_273_1 or var_273_1 * (utf8.len(var_273_3) / 32)

				if (32 <= 0 and var_273_1 or var_273_1 * (utf8.len(var_273_3) / 32)) > 0 and var_273_1 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011064", "story_v_out_322011.awb") ~= 0 then
					local var_273_6 = manager.audio:GetVoiceLength("story_v_out_322011", "322011064", "story_v_out_322011.awb") / 1000

					if var_273_6 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_6 + var_273_0
					end

					if var_273_2.prefab_name ~= "" and arg_270_1.actors_[var_273_2.prefab_name] ~= nil then
						local var_273_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_2.prefab_name].transform, "story_v_out_322011", "322011064", "story_v_out_322011.awb")

						arg_270_1:RecordAudio("322011064", var_273_7)
						arg_270_1:RecordAudio("322011064", var_273_7)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_322011", "322011064", "story_v_out_322011.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_322011", "322011064", "story_v_out_322011.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play322011065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 322011065
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play322011066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1043ui_story"]) and arg_274_1.var_.characterEffect1043ui_story == nil then
				arg_274_1.var_.characterEffect1043ui_story = arg_274_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1043ui_story"]) then
				if arg_274_1.var_.characterEffect1043ui_story and not isNil(arg_274_1.actors_["1043ui_story"]) then
					arg_274_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_0)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1043ui_story"]) and arg_274_1.var_.characterEffect1043ui_story then
				arg_274_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_277_1 = 0
			local var_277_2 = 0.225

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(322011065).content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 9 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 9)

				if (9 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 9)) > 0 and var_277_2 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_6 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_6 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_6

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_6 and arg_274_1.time_ < var_277_1 + var_277_6 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play322011066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 322011066
		arg_278_1.duration_ = 9

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play322011067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_9001
			local var_281_9000

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				arg_278_1.var_.moveOldPos1043ui_story = arg_278_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_281_0 = 0.001

			if 2 <= arg_278_1.time_ and arg_278_1.time_ < 2 + var_281_0 then
				arg_278_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 2) / var_281_0)
				arg_278_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1043ui_story"].transform.position).z)
				arg_278_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1043ui_story"].transform.localEulerAngles = arg_278_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 2 + var_281_0 and arg_278_1.time_ < 2 + var_281_0 + arg_281_0 then
				arg_278_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_278_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1043ui_story"].transform.position).z)
				arg_278_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1043ui_story"].transform.localEulerAngles = arg_278_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_281_1 = arg_278_1.actors_["1284ui_story"].transform

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				arg_278_1.var_.moveOldPos1284ui_story = var_281_1.localPosition
			end

			local var_281_2 = 0.001

			if 2 <= arg_278_1.time_ and arg_278_1.time_ < 2 + var_281_2 then
				var_281_1.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 2) / var_281_2)
				var_281_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_1.position).x, (manager.ui.mainCamera.transform.position - var_281_1.position).y, (manager.ui.mainCamera.transform.position - var_281_1.position).z)
				var_281_1.localEulerAngles.z = 0
				var_281_1.localEulerAngles.x = 0
				var_281_1.localEulerAngles = var_281_1.localEulerAngles
			end

			if arg_278_1.time_ >= 2 + var_281_2 and arg_278_1.time_ < 2 + var_281_2 + arg_281_0 then
				var_281_1.localPosition = Vector3.New(0, 100, 0)
				var_281_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_1.position).x, (manager.ui.mainCamera.transform.position - var_281_1.position).y, (manager.ui.mainCamera.transform.position - var_281_1.position).z)
				var_281_1.localEulerAngles.z = 0
				var_281_1.localEulerAngles.x = 0
				var_281_1.localEulerAngles = var_281_1.localEulerAngles
			end

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_3 = arg_278_1.var_.effect1066

				if not arg_278_1.var_.effect1066 then
					var_281_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_4048_loop"), manager.ui.mainCamera.transform)
					var_281_3.name = "1066"
					arg_278_1.var_.effect1066 = var_281_3
				else
					var_281_3.transform:SetParent(var_281_9001)
				end

				var_281_3.transform.localPosition = Vector3.New(-0.78, 2.06, 6.49)
				var_281_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_5 = arg_278_1.var_.effect10662

				if not arg_278_1.var_.effect10662 then
					var_281_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_281_5.name = "10662"
					arg_278_1.var_.effect10662 = var_281_5
				else
					var_281_5.transform:SetParent(var_281_9000)
				end

				var_281_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_281_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_281_7 = 2

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_7 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_8 = 0.333333333333333

			if var_281_7 <= arg_278_1.time_ and arg_278_1.time_ < var_281_7 + var_281_8 then
				local var_281_9 = Color.New(0, 0, 0)

				var_281_9.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_7) / var_281_8)
				arg_278_1.mask_.color = var_281_9
			end

			if arg_278_1.time_ >= var_281_7 + var_281_8 and arg_278_1.time_ < var_281_7 + var_281_8 + arg_281_0 then
				local var_281_10 = Color.New(0, 0, 0)

				arg_278_1.mask_.enabled = false
				var_281_10.a = 0
				arg_278_1.mask_.color = var_281_10
			end

			local var_281_11 = 4

			if 4 < arg_278_1.time_ and arg_278_1.time_ <= var_281_11 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			if arg_278_1.time_ >= var_281_11 + 0.3 and arg_278_1.time_ < var_281_11 + 0.3 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end

			local var_281_12 = 0

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_12 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_13 = 2

			if var_281_12 <= arg_278_1.time_ and arg_278_1.time_ < var_281_12 + var_281_13 then
				local var_281_14 = Color.New(0, 0, 0)

				var_281_14.a = Mathf.Lerp(0, 1, (arg_278_1.time_ - var_281_12) / var_281_13)
				arg_278_1.mask_.color = var_281_14
			end

			if arg_278_1.time_ >= var_281_12 + var_281_13 and arg_278_1.time_ < var_281_12 + var_281_13 + arg_281_0 then
				local var_281_15 = Color.New(0, 0, 0)

				var_281_15.a = 1
				arg_278_1.mask_.color = var_281_15
			end

			local var_281_16 = 2

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_16 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_17 = 2

			if var_281_16 <= arg_278_1.time_ and arg_278_1.time_ < var_281_16 + var_281_17 then
				local var_281_18 = Color.New(0, 0, 0)

				var_281_18.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_16) / var_281_17)
				arg_278_1.mask_.color = var_281_18
			end

			if arg_278_1.time_ >= var_281_16 + var_281_17 and arg_278_1.time_ < var_281_16 + var_281_17 + arg_281_0 then
				local var_281_19 = Color.New(0, 0, 0)

				arg_278_1.mask_.enabled = false
				var_281_19.a = 0
				arg_278_1.mask_.color = var_281_19
			end

			local var_281_20 = "L10l"

			if arg_278_1.bgs_.L10l == nil then
				local var_281_21 = Object.Instantiate(arg_278_1.paintGo_)

				var_281_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_281_20)
				var_281_21.name = var_281_20
				var_281_21.transform.parent = arg_278_1.stage_.transform
				var_281_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_278_1.bgs_[var_281_20] = var_281_21
			end

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_22 = arg_278_1.bgs_.L10l

				arg_278_1.bgs_.L10l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_281_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_23 = var_281_22:GetComponent("SpriteRenderer")

				if var_281_23 and var_281_23.sprite then
					local var_281_24 = 2 * (var_281_22.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_281_22.transform.localScale = Vector3.New(var_281_24 / var_281_23.sprite.bounds.size.y < var_281_24 * manager.ui.mainCameraCom_.aspect / var_281_23.sprite.bounds.size.x and var_281_24 * manager.ui.mainCameraCom_.aspect / var_281_23.sprite.bounds.size.x or var_281_24 / var_281_23.sprite.bounds.size.y, var_281_24 / var_281_23.sprite.bounds.size.y < var_281_24 * manager.ui.mainCameraCom_.aspect / var_281_23.sprite.bounds.size.x and var_281_24 * manager.ui.mainCameraCom_.aspect / var_281_23.sprite.bounds.size.x or var_281_24 / var_281_23.sprite.bounds.size.y, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "L10l" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_25 = 4
			local var_281_26 = 1

			if 4 < arg_278_1.time_ and arg_278_1.time_ <= var_281_25 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_27 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_27:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_28 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(322011066).content)

				arg_278_1.text_.text = var_281_28

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_30 = 40 <= 0 and var_281_26 or var_281_26 * (utf8.len(var_281_28) / 40)

				if (40 <= 0 and var_281_26 or var_281_26 * (utf8.len(var_281_28) / 40)) > 0 and var_281_26 < var_281_30 then
					arg_278_1.talkMaxDuration = var_281_30
					var_281_25 = var_281_25 + 0.3

					if var_281_30 + var_281_25 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_30 + var_281_25
					end
				end

				arg_278_1.text_.text = var_281_28
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_31 = var_281_25 + 0.3
			local var_281_32 = math.max(var_281_26, arg_278_1.talkMaxDuration)

			if var_281_25 + 0.3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_31 + var_281_32 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_31) / var_281_32

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_31 + var_281_32 and arg_278_1.time_ < var_281_31 + var_281_32 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play322011067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 322011067
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play322011068(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 1.8

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_1 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(322011067).content)

				arg_284_1.text_.text = var_287_1

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_3 = 72 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 72)

				if (72 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 72)) > 0 and var_287_0 < var_287_3 then
					arg_284_1.talkMaxDuration = var_287_3

					if var_287_3 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_3 + 0
					end
				end

				arg_284_1.text_.text = var_287_1
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_4 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_4

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play322011068 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 322011068
		arg_288_1.duration_ = 6.33

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play322011069(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0.633333333333333 < arg_288_1.time_ and arg_288_1.time_ <= 0.633333333333333 + arg_291_0 then
				if arg_288_1.var_.effect1066 then
					Object.Destroy(arg_288_1.var_.effect1066)

					arg_288_1.var_.effect1066 = nil
				end
			end

			if 0.633333333333333 < arg_288_1.time_ and arg_288_1.time_ <= 0.633333333333333 + arg_291_0 then
				if arg_288_1.var_.effect10662 then
					Object.Destroy(arg_288_1.var_.effect10662)

					arg_288_1.var_.effect10662 = nil
				end
			end

			local var_291_2 = 0

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.mask_.enabled = true
				arg_288_1.mask_.raycastTarget = true

				arg_288_1:SetGaussion(false)
			end

			local var_291_3 = 0.633333333333333

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_3 then
				local var_291_4 = Color.New(0, 0, 0)

				var_291_4.a = Mathf.Lerp(0, 1, (arg_288_1.time_ - var_291_2) / var_291_3)
				arg_288_1.mask_.color = var_291_4
			end

			if arg_288_1.time_ >= var_291_2 + var_291_3 and arg_288_1.time_ < var_291_2 + var_291_3 + arg_291_0 then
				local var_291_5 = Color.New(0, 0, 0)

				var_291_5.a = 1
				arg_288_1.mask_.color = var_291_5
			end

			local var_291_6 = 0.633333333333333

			if 0.633333333333333 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.mask_.enabled = true
				arg_288_1.mask_.raycastTarget = true

				arg_288_1:SetGaussion(false)
			end

			local var_291_7 = 0.7

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_7 then
				local var_291_8 = Color.New(0, 0, 0)

				var_291_8.a = Mathf.Lerp(1, 0, (arg_288_1.time_ - var_291_6) / var_291_7)
				arg_288_1.mask_.color = var_291_8
			end

			if arg_288_1.time_ >= var_291_6 + var_291_7 and arg_288_1.time_ < var_291_6 + var_291_7 + arg_291_0 then
				local var_291_9 = Color.New(0, 0, 0)

				arg_288_1.mask_.enabled = false
				var_291_9.a = 0
				arg_288_1.mask_.color = var_291_9
			end

			if 0.633333333333333 < arg_288_1.time_ and arg_288_1.time_ <= 0.633333333333333 + arg_291_0 then
				local var_291_10 = arg_288_1.bgs_.L10g

				arg_288_1.bgs_.L10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_291_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_291_11 = var_291_10:GetComponent("SpriteRenderer")

				if var_291_11 and var_291_11.sprite then
					local var_291_12 = 2 * (var_291_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_291_10.transform.localScale = Vector3.New(var_291_12 / var_291_11.sprite.bounds.size.y < var_291_12 * manager.ui.mainCameraCom_.aspect / var_291_11.sprite.bounds.size.x and var_291_12 * manager.ui.mainCameraCom_.aspect / var_291_11.sprite.bounds.size.x or var_291_12 / var_291_11.sprite.bounds.size.y, var_291_12 / var_291_11.sprite.bounds.size.y < var_291_12 * manager.ui.mainCameraCom_.aspect / var_291_11.sprite.bounds.size.x and var_291_12 * manager.ui.mainCameraCom_.aspect / var_291_11.sprite.bounds.size.x or var_291_12 / var_291_11.sprite.bounds.size.y, 0)
				end

				for iter_291_0, iter_291_1 in pairs(arg_288_1.bgs_) do
					if iter_291_0 ~= "L10g" then
						iter_291_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_288_1.frameCnt_ <= 1 then
				arg_288_1.dialog_:SetActive(false)
			end

			local var_291_13 = 1.33333333333333
			local var_291_14 = 1.125

			if 1.33333333333333 < arg_288_1.time_ and arg_288_1.time_ <= var_291_13 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0

				arg_288_1.dialog_:SetActive(true)

				arg_288_1.dialogCg_.alpha = 0

				local var_291_15 = LeanTween.value(arg_288_1.dialog_, 0, 1, 0.3)

				var_291_15:setOnUpdate(LuaHelper.FloatAction(function(arg_292_0)
					arg_288_1.dialogCg_.alpha = arg_292_0
				end))
				var_291_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_288_1.dialog_)
					var_291_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_288_1.duration_ = arg_288_1.duration_ + 0.3

				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_16 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(322011068).content)

				arg_288_1.text_.text = var_291_16

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_18 = 45 <= 0 and var_291_14 or var_291_14 * (utf8.len(var_291_16) / 45)

				if (45 <= 0 and var_291_14 or var_291_14 * (utf8.len(var_291_16) / 45)) > 0 and var_291_14 < var_291_18 then
					arg_288_1.talkMaxDuration = var_291_18
					var_291_13 = var_291_13 + 0.3

					if var_291_18 + var_291_13 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_18 + var_291_13
					end
				end

				arg_288_1.text_.text = var_291_16
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_19 = var_291_13 + 0.3
			local var_291_20 = math.max(var_291_14, arg_288_1.talkMaxDuration)

			if var_291_13 + 0.3 <= arg_288_1.time_ and arg_288_1.time_ < var_291_19 + var_291_20 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_19) / var_291_20

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_19 + var_291_20 and arg_288_1.time_ < var_291_19 + var_291_20 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play322011069 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 322011069
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play322011070(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.525

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(322011069).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 21 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 21)

				if (21 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 21)) > 0 and var_297_0 < var_297_3 then
					arg_294_1.talkMaxDuration = var_297_3

					if var_297_3 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_3 + 0
					end
				end

				arg_294_1.text_.text = var_297_1
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_4 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_4

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play322011070 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 322011070
		arg_298_1.duration_ = 5.9

		local var_298_0 = {
			zh = 5.266,
			ja = 5.9
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play322011071(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos10104ui_story = arg_298_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_301_0 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 then
				arg_298_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_298_1.time_ - 0) / var_301_0)
				arg_298_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["10104ui_story"].transform.position).z)
				arg_298_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["10104ui_story"].transform.localEulerAngles = arg_298_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 then
				arg_298_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_298_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["10104ui_story"].transform.position).z)
				arg_298_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["10104ui_story"].transform.localEulerAngles = arg_298_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_301_1 = arg_298_1.actors_["10104ui_story"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_1) and arg_298_1.var_.characterEffect10104ui_story == nil then
				arg_298_1.var_.characterEffect10104ui_story = var_301_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_2 and not isNil(var_301_1) then
				if arg_298_1.var_.characterEffect10104ui_story and not isNil(var_301_1) then
					arg_298_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= 0 + var_301_2 and arg_298_1.time_ < 0 + var_301_2 + arg_301_0 and not isNil(var_301_1) and arg_298_1.var_.characterEffect10104ui_story then
				arg_298_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_301_4 = 0
			local var_301_5 = 0.7

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_6 = arg_298_1:GetWordFromCfg(322011070)
				local var_301_7 = arg_298_1:FormatText(var_301_6.content)

				arg_298_1.text_.text = var_301_7

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_9 = 28 <= 0 and var_301_5 or var_301_5 * (utf8.len(var_301_7) / 28)

				if (28 <= 0 and var_301_5 or var_301_5 * (utf8.len(var_301_7) / 28)) > 0 and var_301_5 < var_301_9 then
					arg_298_1.talkMaxDuration = var_301_9

					if var_301_9 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_9 + var_301_4
					end
				end

				arg_298_1.text_.text = var_301_7
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011070", "story_v_out_322011.awb") ~= 0 then
					local var_301_10 = manager.audio:GetVoiceLength("story_v_out_322011", "322011070", "story_v_out_322011.awb") / 1000

					if var_301_10 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_10 + var_301_4
					end

					if var_301_6.prefab_name ~= "" and arg_298_1.actors_[var_301_6.prefab_name] ~= nil then
						local var_301_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_6.prefab_name].transform, "story_v_out_322011", "322011070", "story_v_out_322011.awb")

						arg_298_1:RecordAudio("322011070", var_301_11)
						arg_298_1:RecordAudio("322011070", var_301_11)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_322011", "322011070", "story_v_out_322011.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_322011", "322011070", "story_v_out_322011.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_12 = math.max(var_301_5, arg_298_1.talkMaxDuration)

			if var_301_4 <= arg_298_1.time_ and arg_298_1.time_ < var_301_4 + var_301_12 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_4) / var_301_12

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_4 + var_301_12 and arg_298_1.time_ < var_301_4 + var_301_12 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play322011071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 322011071
		arg_302_1.duration_ = 2.23

		local var_302_0 = {
			zh = 2.233,
			ja = 2.133
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play322011072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos10104ui_story = arg_302_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_305_0 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 then
				arg_302_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_302_1.time_ - 0) / var_305_0)
				arg_302_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["10104ui_story"].transform.position).z)
				arg_302_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["10104ui_story"].transform.localEulerAngles = arg_302_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 then
				arg_302_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_302_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["10104ui_story"].transform.position).z)
				arg_302_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["10104ui_story"].transform.localEulerAngles = arg_302_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_305_1 = 0
			local var_305_2 = 0.225

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_3 = arg_302_1:GetWordFromCfg(322011071)
				local var_305_4 = arg_302_1:FormatText(var_305_3.content)

				arg_302_1.text_.text = var_305_4

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_6 = 9 <= 0 and var_305_2 or var_305_2 * (utf8.len(var_305_4) / 9)

				if (9 <= 0 and var_305_2 or var_305_2 * (utf8.len(var_305_4) / 9)) > 0 and var_305_2 < var_305_6 then
					arg_302_1.talkMaxDuration = var_305_6

					if var_305_6 + var_305_1 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_6 + var_305_1
					end
				end

				arg_302_1.text_.text = var_305_4
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011071", "story_v_out_322011.awb") ~= 0 then
					local var_305_7 = manager.audio:GetVoiceLength("story_v_out_322011", "322011071", "story_v_out_322011.awb") / 1000

					if var_305_7 + var_305_1 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_1
					end

					if var_305_3.prefab_name ~= "" and arg_302_1.actors_[var_305_3.prefab_name] ~= nil then
						local var_305_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_3.prefab_name].transform, "story_v_out_322011", "322011071", "story_v_out_322011.awb")

						arg_302_1:RecordAudio("322011071", var_305_8)
						arg_302_1:RecordAudio("322011071", var_305_8)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_322011", "322011071", "story_v_out_322011.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_322011", "322011071", "story_v_out_322011.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_9 = math.max(var_305_2, arg_302_1.talkMaxDuration)

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_9 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_1) / var_305_9

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_1 + var_305_9 and arg_302_1.time_ < var_305_1 + var_305_9 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play322011072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 322011072
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play322011073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["10104ui_story"]) and arg_306_1.var_.characterEffect10104ui_story == nil then
				arg_306_1.var_.characterEffect10104ui_story = arg_306_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["10104ui_story"]) then
				if arg_306_1.var_.characterEffect10104ui_story and not isNil(arg_306_1.actors_["10104ui_story"]) then
					arg_306_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_306_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["10104ui_story"]) and arg_306_1.var_.characterEffect10104ui_story then
				arg_306_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_306_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_309_1 = 0
			local var_309_2 = 0.25

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(322011072).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 10 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 10)

				if (10 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 10)) > 0 and var_309_2 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_6 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_6 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_6

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_6 and arg_306_1.time_ < var_309_1 + var_309_6 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play322011073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 322011073
		arg_310_1.duration_ = 10.07

		local var_310_0 = {
			zh = 8.666,
			ja = 10.066
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play322011074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["10104ui_story"]) and arg_310_1.var_.characterEffect10104ui_story == nil then
				arg_310_1.var_.characterEffect10104ui_story = arg_310_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["10104ui_story"]) then
				if arg_310_1.var_.characterEffect10104ui_story and not isNil(arg_310_1.actors_["10104ui_story"]) then
					arg_310_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["10104ui_story"]) and arg_310_1.var_.characterEffect10104ui_story then
				arg_310_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_313_2 = 0
			local var_313_3 = 1

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_4 = arg_310_1:GetWordFromCfg(322011073)
				local var_313_5 = arg_310_1:FormatText(var_313_4.content)

				arg_310_1.text_.text = var_313_5

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_7 = 40 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 40)

				if (40 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 40)) > 0 and var_313_3 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_2
					end
				end

				arg_310_1.text_.text = var_313_5
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011073", "story_v_out_322011.awb") ~= 0 then
					local var_313_8 = manager.audio:GetVoiceLength("story_v_out_322011", "322011073", "story_v_out_322011.awb") / 1000

					if var_313_8 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_8 + var_313_2
					end

					if var_313_4.prefab_name ~= "" and arg_310_1.actors_[var_313_4.prefab_name] ~= nil then
						local var_313_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_4.prefab_name].transform, "story_v_out_322011", "322011073", "story_v_out_322011.awb")

						arg_310_1:RecordAudio("322011073", var_313_9)
						arg_310_1:RecordAudio("322011073", var_313_9)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_322011", "322011073", "story_v_out_322011.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_322011", "322011073", "story_v_out_322011.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_10 = math.max(var_313_3, arg_310_1.talkMaxDuration)

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_10 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_2) / var_313_10

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_2 + var_313_10 and arg_310_1.time_ < var_313_2 + var_313_10 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play322011074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 322011074
		arg_314_1.duration_ = 4.2

		local var_314_0 = {
			zh = 2.833,
			ja = 4.2
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play322011075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_317_0 = 0
			local var_317_1 = 0.375

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_2 = arg_314_1:GetWordFromCfg(322011074)
				local var_317_3 = arg_314_1:FormatText(var_317_2.content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 15 <= 0 and var_317_1 or var_317_1 * (utf8.len(var_317_3) / 15)

				if (15 <= 0 and var_317_1 or var_317_1 * (utf8.len(var_317_3) / 15)) > 0 and var_317_1 < var_317_5 then
					arg_314_1.talkMaxDuration = var_317_5

					if var_317_5 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011074", "story_v_out_322011.awb") ~= 0 then
					local var_317_6 = manager.audio:GetVoiceLength("story_v_out_322011", "322011074", "story_v_out_322011.awb") / 1000

					if var_317_6 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_0
					end

					if var_317_2.prefab_name ~= "" and arg_314_1.actors_[var_317_2.prefab_name] ~= nil then
						local var_317_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_2.prefab_name].transform, "story_v_out_322011", "322011074", "story_v_out_322011.awb")

						arg_314_1:RecordAudio("322011074", var_317_7)
						arg_314_1:RecordAudio("322011074", var_317_7)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_322011", "322011074", "story_v_out_322011.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_322011", "322011074", "story_v_out_322011.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_8 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_8 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_8

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_8 and arg_314_1.time_ < var_317_0 + var_317_8 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play322011075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 322011075
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play322011076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["10104ui_story"]) and arg_318_1.var_.characterEffect10104ui_story == nil then
				arg_318_1.var_.characterEffect10104ui_story = arg_318_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["10104ui_story"]) then
				if arg_318_1.var_.characterEffect10104ui_story and not isNil(arg_318_1.actors_["10104ui_story"]) then
					arg_318_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_318_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_0)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["10104ui_story"]) and arg_318_1.var_.characterEffect10104ui_story then
				arg_318_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_318_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_321_1 = 0
			local var_321_2 = 0.75

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(322011075).content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 30 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 30)

				if (30 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 30)) > 0 and var_321_2 < var_321_5 then
					arg_318_1.talkMaxDuration = var_321_5

					if var_321_5 + var_321_1 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + var_321_1
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_6 = math.max(var_321_2, arg_318_1.talkMaxDuration)

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_6 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_1) / var_321_6

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_1 + var_321_6 and arg_318_1.time_ < var_321_1 + var_321_6 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play322011076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 322011076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play322011077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos10104ui_story = arg_322_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_325_0 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 then
				arg_322_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_322_1.time_ - 0) / var_325_0)
				arg_322_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["10104ui_story"].transform.position).z)
				arg_322_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["10104ui_story"].transform.localEulerAngles = arg_322_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 then
				arg_322_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_322_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["10104ui_story"].transform.position).z)
				arg_322_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["10104ui_story"].transform.localEulerAngles = arg_322_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_325_1 = 0
			local var_325_2 = 1.425

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_3 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(322011076).content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 57 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 57)

				if (57 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 57)) > 0 and var_325_2 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_6 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_6 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_1) / var_325_6

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_1 + var_325_6 and arg_322_1.time_ < var_325_1 + var_325_6 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play322011077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 322011077
		arg_326_1.duration_ = 13.13

		local var_326_0 = {
			zh = 10.033,
			ja = 13.133
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play322011078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos10104ui_story = arg_326_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_329_0 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				arg_326_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10104ui_story"].transform.position).z)
				arg_326_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["10104ui_story"].transform.localEulerAngles = arg_326_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				arg_326_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_326_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10104ui_story"].transform.position).z)
				arg_326_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["10104ui_story"].transform.localEulerAngles = arg_326_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_329_1 = arg_326_1.actors_["10104ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect10104ui_story == nil then
				arg_326_1.var_.characterEffect10104ui_story = var_329_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_2 and not isNil(var_329_1) then
				if arg_326_1.var_.characterEffect10104ui_story and not isNil(var_329_1) then
					arg_326_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_2 and arg_326_1.time_ < 0 + var_329_2 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect10104ui_story then
				arg_326_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_329_4 = 0
			local var_329_5 = 1

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_4 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_6 = arg_326_1:GetWordFromCfg(322011077)
				local var_329_7 = arg_326_1:FormatText(var_329_6.content)

				arg_326_1.text_.text = var_329_7

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_9 = 40 <= 0 and var_329_5 or var_329_5 * (utf8.len(var_329_7) / 40)

				if (40 <= 0 and var_329_5 or var_329_5 * (utf8.len(var_329_7) / 40)) > 0 and var_329_5 < var_329_9 then
					arg_326_1.talkMaxDuration = var_329_9

					if var_329_9 + var_329_4 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_9 + var_329_4
					end
				end

				arg_326_1.text_.text = var_329_7
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011077", "story_v_out_322011.awb") ~= 0 then
					local var_329_10 = manager.audio:GetVoiceLength("story_v_out_322011", "322011077", "story_v_out_322011.awb") / 1000

					if var_329_10 + var_329_4 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_10 + var_329_4
					end

					if var_329_6.prefab_name ~= "" and arg_326_1.actors_[var_329_6.prefab_name] ~= nil then
						local var_329_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_6.prefab_name].transform, "story_v_out_322011", "322011077", "story_v_out_322011.awb")

						arg_326_1:RecordAudio("322011077", var_329_11)
						arg_326_1:RecordAudio("322011077", var_329_11)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_322011", "322011077", "story_v_out_322011.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_322011", "322011077", "story_v_out_322011.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_12 = math.max(var_329_5, arg_326_1.talkMaxDuration)

			if var_329_4 <= arg_326_1.time_ and arg_326_1.time_ < var_329_4 + var_329_12 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_4) / var_329_12

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_4 + var_329_12 and arg_326_1.time_ < var_329_4 + var_329_12 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play322011078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 322011078
		arg_330_1.duration_ = 8.53

		local var_330_0 = {
			zh = 3.833,
			ja = 8.533
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play322011079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_333_0 = 0
			local var_333_1 = 0.55

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_2 = arg_330_1:GetWordFromCfg(322011078)
				local var_333_3 = arg_330_1:FormatText(var_333_2.content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 22 <= 0 and var_333_1 or var_333_1 * (utf8.len(var_333_3) / 22)

				if (22 <= 0 and var_333_1 or var_333_1 * (utf8.len(var_333_3) / 22)) > 0 and var_333_1 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011078", "story_v_out_322011.awb") ~= 0 then
					local var_333_6 = manager.audio:GetVoiceLength("story_v_out_322011", "322011078", "story_v_out_322011.awb") / 1000

					if var_333_6 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_6 + var_333_0
					end

					if var_333_2.prefab_name ~= "" and arg_330_1.actors_[var_333_2.prefab_name] ~= nil then
						local var_333_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_2.prefab_name].transform, "story_v_out_322011", "322011078", "story_v_out_322011.awb")

						arg_330_1:RecordAudio("322011078", var_333_7)
						arg_330_1:RecordAudio("322011078", var_333_7)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_322011", "322011078", "story_v_out_322011.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_322011", "322011078", "story_v_out_322011.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_8 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_8 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_8

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_8 and arg_330_1.time_ < var_333_0 + var_333_8 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play322011079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 322011079
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play322011080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["10104ui_story"]) and arg_334_1.var_.characterEffect10104ui_story == nil then
				arg_334_1.var_.characterEffect10104ui_story = arg_334_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["10104ui_story"]) then
				if arg_334_1.var_.characterEffect10104ui_story and not isNil(arg_334_1.actors_["10104ui_story"]) then
					arg_334_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_334_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_0)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["10104ui_story"]) and arg_334_1.var_.characterEffect10104ui_story then
				arg_334_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_334_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_337_1 = 0
			local var_337_2 = 0.25

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(322011079).content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 10 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 10)

				if (10 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 10)) > 0 and var_337_2 < var_337_5 then
					arg_334_1.talkMaxDuration = var_337_5

					if var_337_5 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + var_337_1
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_6 = math.max(var_337_2, arg_334_1.talkMaxDuration)

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_6 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_1) / var_337_6

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_1 + var_337_6 and arg_334_1.time_ < var_337_1 + var_337_6 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play322011080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 322011080
		arg_338_1.duration_ = 14.53

		local var_338_0 = {
			zh = 8.2,
			ja = 14.533
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play322011081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["10104ui_story"]) and arg_338_1.var_.characterEffect10104ui_story == nil then
				arg_338_1.var_.characterEffect10104ui_story = arg_338_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["10104ui_story"]) then
				if arg_338_1.var_.characterEffect10104ui_story and not isNil(arg_338_1.actors_["10104ui_story"]) then
					arg_338_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["10104ui_story"]) and arg_338_1.var_.characterEffect10104ui_story then
				arg_338_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			local var_341_2 = 0
			local var_341_3 = 1.15

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_4 = arg_338_1:GetWordFromCfg(322011080)
				local var_341_5 = arg_338_1:FormatText(var_341_4.content)

				arg_338_1.text_.text = var_341_5

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_7 = 46 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 46)

				if (46 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 46)) > 0 and var_341_3 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_5
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011080", "story_v_out_322011.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_out_322011", "322011080", "story_v_out_322011.awb") / 1000

					if var_341_8 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_2
					end

					if var_341_4.prefab_name ~= "" and arg_338_1.actors_[var_341_4.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_4.prefab_name].transform, "story_v_out_322011", "322011080", "story_v_out_322011.awb")

						arg_338_1:RecordAudio("322011080", var_341_9)
						arg_338_1:RecordAudio("322011080", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_322011", "322011080", "story_v_out_322011.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_322011", "322011080", "story_v_out_322011.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_10 and arg_338_1.time_ < var_341_2 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play322011081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 322011081
		arg_342_1.duration_ = 5

		local var_342_0 = {
			zh = 3.466,
			ja = 5
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play322011082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.4

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_1 = arg_342_1:GetWordFromCfg(322011081)
				local var_345_2 = arg_342_1:FormatText(var_345_1.content)

				arg_342_1.text_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 16 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 16)

				if (16 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 16)) > 0 and var_345_0 < var_345_4 then
					arg_342_1.talkMaxDuration = var_345_4

					if var_345_4 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_4 + 0
					end
				end

				arg_342_1.text_.text = var_345_2
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011081", "story_v_out_322011.awb") ~= 0 then
					local var_345_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011081", "story_v_out_322011.awb") / 1000

					if var_345_5 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + 0
					end

					if var_345_1.prefab_name ~= "" and arg_342_1.actors_[var_345_1.prefab_name] ~= nil then
						local var_345_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_1.prefab_name].transform, "story_v_out_322011", "322011081", "story_v_out_322011.awb")

						arg_342_1:RecordAudio("322011081", var_345_6)
						arg_342_1:RecordAudio("322011081", var_345_6)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_322011", "322011081", "story_v_out_322011.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_322011", "322011081", "story_v_out_322011.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play322011082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 322011082
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play322011083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos10104ui_story = arg_346_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_349_0 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 then
				arg_346_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_346_1.time_ - 0) / var_349_0)
				arg_346_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10104ui_story"].transform.position).z)
				arg_346_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["10104ui_story"].transform.localEulerAngles = arg_346_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 then
				arg_346_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_346_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["10104ui_story"].transform.position).z)
				arg_346_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["10104ui_story"].transform.localEulerAngles = arg_346_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_349_1 = 0
			local var_349_2 = 1.6

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_3 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(322011082).content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 64 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 64)

				if (64 <= 0 and var_349_2 or var_349_2 * (utf8.len(var_349_3) / 64)) > 0 and var_349_2 < var_349_5 then
					arg_346_1.talkMaxDuration = var_349_5

					if var_349_5 + var_349_1 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + var_349_1
					end
				end

				arg_346_1.text_.text = var_349_3
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_6 = math.max(var_349_2, arg_346_1.talkMaxDuration)

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_6 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_1) / var_349_6

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_1 + var_349_6 and arg_346_1.time_ < var_349_1 + var_349_6 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play322011083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 322011083
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play322011084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.25

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_1 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(322011083).content)

				arg_350_1.text_.text = var_353_1

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_3 = 10 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 10)

				if (10 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 10)) > 0 and var_353_0 < var_353_3 then
					arg_350_1.talkMaxDuration = var_353_3

					if var_353_3 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_3 + 0
					end
				end

				arg_350_1.text_.text = var_353_1
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_4 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_4

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play322011084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 322011084
		arg_354_1.duration_ = 6.17

		local var_354_0 = {
			zh = 4.466,
			ja = 6.166
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play322011085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos10104ui_story = arg_354_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_357_0 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 then
				arg_354_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_354_1.time_ - 0) / var_357_0)
				arg_354_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["10104ui_story"].transform.position).z)
				arg_354_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["10104ui_story"].transform.localEulerAngles = arg_354_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 then
				arg_354_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_354_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["10104ui_story"].transform.position).z)
				arg_354_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["10104ui_story"].transform.localEulerAngles = arg_354_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_357_1 = arg_354_1.actors_["10104ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect10104ui_story == nil then
				arg_354_1.var_.characterEffect10104ui_story = var_357_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_2 and not isNil(var_357_1) then
				if arg_354_1.var_.characterEffect10104ui_story and not isNil(var_357_1) then
					arg_354_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_2 and arg_354_1.time_ < 0 + var_357_2 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect10104ui_story then
				arg_354_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_357_4 = 0
			local var_357_5 = 0.575

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_6 = arg_354_1:GetWordFromCfg(322011084)
				local var_357_7 = arg_354_1:FormatText(var_357_6.content)

				arg_354_1.text_.text = var_357_7

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_9 = 23 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 23)

				if (23 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 23)) > 0 and var_357_5 < var_357_9 then
					arg_354_1.talkMaxDuration = var_357_9

					if var_357_9 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_9 + var_357_4
					end
				end

				arg_354_1.text_.text = var_357_7
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011084", "story_v_out_322011.awb") ~= 0 then
					local var_357_10 = manager.audio:GetVoiceLength("story_v_out_322011", "322011084", "story_v_out_322011.awb") / 1000

					if var_357_10 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_4
					end

					if var_357_6.prefab_name ~= "" and arg_354_1.actors_[var_357_6.prefab_name] ~= nil then
						local var_357_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_6.prefab_name].transform, "story_v_out_322011", "322011084", "story_v_out_322011.awb")

						arg_354_1:RecordAudio("322011084", var_357_11)
						arg_354_1:RecordAudio("322011084", var_357_11)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_322011", "322011084", "story_v_out_322011.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_322011", "322011084", "story_v_out_322011.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_12 = math.max(var_357_5, arg_354_1.talkMaxDuration)

			if var_357_4 <= arg_354_1.time_ and arg_354_1.time_ < var_357_4 + var_357_12 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_4) / var_357_12

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_4 + var_357_12 and arg_354_1.time_ < var_357_4 + var_357_12 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play322011085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 322011085
		arg_358_1.duration_ = 13.3

		local var_358_0 = {
			zh = 8.666,
			ja = 13.3
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play322011086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 1.1

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:GetWordFromCfg(322011085)
				local var_361_2 = arg_358_1:FormatText(var_361_1.content)

				arg_358_1.text_.text = var_361_2

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_4 = 44 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 44)

				if (44 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 44)) > 0 and var_361_0 < var_361_4 then
					arg_358_1.talkMaxDuration = var_361_4

					if var_361_4 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_4 + 0
					end
				end

				arg_358_1.text_.text = var_361_2
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011085", "story_v_out_322011.awb") ~= 0 then
					local var_361_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011085", "story_v_out_322011.awb") / 1000

					if var_361_5 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + 0
					end

					if var_361_1.prefab_name ~= "" and arg_358_1.actors_[var_361_1.prefab_name] ~= nil then
						local var_361_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_1.prefab_name].transform, "story_v_out_322011", "322011085", "story_v_out_322011.awb")

						arg_358_1:RecordAudio("322011085", var_361_6)
						arg_358_1:RecordAudio("322011085", var_361_6)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_322011", "322011085", "story_v_out_322011.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_322011", "322011085", "story_v_out_322011.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_7 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_7 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_7

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_7 and arg_358_1.time_ < 0 + var_361_7 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play322011086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 322011086
		arg_362_1.duration_ = 9.2

		local var_362_0 = {
			zh = 9,
			ja = 9.2
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
			arg_362_1.auto_ = false
		end

		function arg_362_1.playNext_(arg_364_0)
			arg_362_1.onStoryFinished_()
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 1.1

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_1 = arg_362_1:GetWordFromCfg(322011086)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 44 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 44)

				if (44 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 44)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322011", "322011086", "story_v_out_322011.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_out_322011", "322011086", "story_v_out_322011.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_out_322011", "322011086", "story_v_out_322011.awb")

						arg_362_1:RecordAudio("322011086", var_365_6)
						arg_362_1:RecordAudio("322011086", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_322011", "322011086", "story_v_out_322011.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_322011", "322011086", "story_v_out_322011.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L10f",
		"TextureConfig/Background/ST0511a",
		"TextureConfig/Background/L10i",
		"TextureConfig/Background/L10g",
		"TextureConfig/Background/L10l"
	},
	voices = {
		"story_v_out_322011.awb"
	}
}
