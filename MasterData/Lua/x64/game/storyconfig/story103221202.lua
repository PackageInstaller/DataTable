return {
	Play322122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322122001
		arg_1_1.duration_ = 7.57

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2 + 0.3 and arg_1_1.time_ < 2 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 2.1 < arg_1_1.time_ and arg_1_1.time_ <= 2.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_whoosh", "")
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_4 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_4

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_4
						arg_1_1.bgmTxt2_.text = var_4_4
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_4_7 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_7 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_7

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_7
						arg_1_1.bgmTxt2_.text = var_4_7
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

			local var_4_8 = manager.ui.mainCamera.transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_8.localPosition
			end

			local var_4_9 = 0.4

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_9 then
				local var_4_10, var_4_11 = math.modf((arg_1_1.time_ - 2) / 0.066)

				var_4_8.localPosition = Vector3.New(var_4_11 * 0.13, var_4_11 * 0.13, var_4_11 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 2 + var_4_9 and arg_1_1.time_ < 2 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_12 = "MS2201"

			if arg_1_1.bgs_.MS2201 == nil then
				local var_4_13 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_12)
				var_4_13.name = var_4_12
				var_4_13.transform.parent = arg_1_1.stage_.transform
				var_4_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_12] = var_4_13
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_14 = arg_1_1.bgs_.MS2201

				arg_1_1.bgs_.MS2201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = 2 * (var_4_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_14.transform.localScale = Vector3.New(var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "MS2201" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_17 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_18 = 2

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_17) / var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_20.a = 0
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_21 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_22 = 0.166666666666667

			if var_4_21 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				local var_4_23 = Color.New(1, 1, 1)

				var_4_23.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_21) / var_4_22)
				arg_1_1.mask_.color = var_4_23
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				local var_4_24 = Color.New(1, 1, 1)

				var_4_24.a = 1
				arg_1_1.mask_.color = var_4_24
			end

			local var_4_25 = 2.16666666666667

			if 2.16666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_26 = 0.166666666666667

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				local var_4_27 = Color.New(1, 1, 1)

				var_4_27.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_25) / var_4_26)
				arg_1_1.mask_.color = var_4_27
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				local var_4_28 = Color.New(1, 1, 1)

				arg_1_1.mask_.enabled = false
				var_4_28.a = 0
				arg_1_1.mask_.color = var_4_28
			end

			if 2.16666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 2.16666666666667 + arg_4_0 then
				local var_4_29 = arg_1_1.var_.effect2002

				if not arg_1_1.var_.effect2002 then
					var_4_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ss1043"), manager.ui.mainCamera.transform)
					var_4_29.name = "2002"
					arg_1_1.var_.effect2002 = var_4_29
				else
					var_4_29.transform:SetParent(var_4_9000)
				end

				var_4_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_31 = arg_1_1.bgs_.MS2201.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2201 = var_4_31.localPosition
			end

			local var_4_32 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_32 then
				var_4_31.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2201, Vector3.New(1, 1, 7), (arg_1_1.time_ - 0) / var_4_32)
			end

			if arg_1_1.time_ >= 0 + var_4_32 and arg_1_1.time_ < 0 + var_4_32 + arg_4_0 then
				var_4_31.localPosition = Vector3.New(1, 1, 7)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2.56666666666667
			local var_4_34 = 0.45

			if 2.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(322122001).content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 18 <= 0 and var_4_34 or var_4_34 * (utf8.len(var_4_36) / 18)

				if (18 <= 0 and var_4_34 or var_4_34 * (utf8.len(var_4_36) / 18)) > 0 and var_4_34 < var_4_38 then
					arg_1_1.talkMaxDuration = var_4_38
					var_4_33 = var_4_33 + 0.3

					if var_4_38 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_36
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_39 = var_4_33 + 0.3
			local var_4_40 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_33 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_39) / var_4_40

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2201",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, 1, 8),
					endPos = Vector3.New(1, 1, 7),
					easeType = LeanTweenType.easeOutCirc
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322122002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322122002
		arg_9_1.duration_ = 5.45

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322122003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.45

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(322122002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 58 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 58)

				if (58 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 58)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play322122003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322122003
		arg_13_1.duration_ = 4.57

		local var_13_0 = {
			zh = 1.466,
			ja = 4.566
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
				arg_13_0:Play322122004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.125

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(322122003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 5 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 5)

				if (5 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 5)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122003", "story_v_out_322122.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122003", "story_v_out_322122.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_322122", "322122003", "story_v_out_322122.awb")

						arg_13_1:RecordAudio("322122003", var_16_6)
						arg_13_1:RecordAudio("322122003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322122", "322122003", "story_v_out_322122.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322122", "322122003", "story_v_out_322122.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play322122004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322122004
		arg_17_1.duration_ = 9.63

		local var_17_0 = {
			zh = 6.833,
			ja = 9.633
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play322122005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.55

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(322122004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 22 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 22)

				if (22 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 22)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122004", "story_v_out_322122.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122004", "story_v_out_322122.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_322122", "322122004", "story_v_out_322122.awb")

						arg_17_1:RecordAudio("322122004", var_20_6)
						arg_17_1:RecordAudio("322122004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322122", "322122004", "story_v_out_322122.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322122", "322122004", "story_v_out_322122.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play322122005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322122005
		arg_21_1.duration_ = 3.4

		local var_21_0 = {
			zh = 3.4,
			ja = 3
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322122006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(322122005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 11 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 11)

				if (11 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 11)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122005", "story_v_out_322122.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122005", "story_v_out_322122.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_322122", "322122005", "story_v_out_322122.awb")

						arg_21_1:RecordAudio("322122005", var_24_6)
						arg_21_1:RecordAudio("322122005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_322122", "322122005", "story_v_out_322122.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_322122", "322122005", "story_v_out_322122.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play322122006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322122006
		arg_25_1.duration_ = 10.73

		local var_25_0 = {
			zh = 5.766,
			ja = 10.733
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
				arg_25_0:Play322122007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(322122006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 17)

				if (17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 17)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122006", "story_v_out_322122.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122006", "story_v_out_322122.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_322122", "322122006", "story_v_out_322122.awb")

						arg_25_1:RecordAudio("322122006", var_28_6)
						arg_25_1:RecordAudio("322122006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322122", "322122006", "story_v_out_322122.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322122", "322122006", "story_v_out_322122.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play322122007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322122007
		arg_29_1.duration_ = 9.87

		local var_29_0 = {
			zh = 5.466,
			ja = 9.866
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play322122008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.275

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(322122007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 11 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 11)

				if (11 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 11)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122007", "story_v_out_322122.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122007", "story_v_out_322122.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_322122", "322122007", "story_v_out_322122.awb")

						arg_29_1:RecordAudio("322122007", var_32_6)
						arg_29_1:RecordAudio("322122007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322122", "322122007", "story_v_out_322122.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322122", "322122007", "story_v_out_322122.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322122008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322122008
		arg_33_1.duration_ = 6.33

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322122009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_9000

			if 1.33333333333333 < arg_33_1.time_ and arg_33_1.time_ <= 1.33333333333333 + arg_36_0 then
				arg_33_1:AudioAction("play", "effect", "se_story_10", "se_story_10_disappear", "")
			end

			if 1.33333333333333 < arg_33_1.time_ and arg_33_1.time_ <= 1.33333333333333 + arg_36_0 then
				local var_36_1 = arg_33_1.var_.effect2008

				if not arg_33_1.var_.effect2008 then
					var_36_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suipian_in"), manager.ui.mainCamera.transform)
					var_36_1.name = "2008"
					arg_33_1.var_.effect2008 = var_36_1
				else
					var_36_1.transform:SetParent(var_36_9000)
				end

				var_36_1.transform.localPosition = Vector3.New(0, 0, -2.79)
				var_36_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				if arg_33_1.var_.effect2002 then
					Object.Destroy(arg_33_1.var_.effect2002)

					arg_33_1.var_.effect2002 = nil
				end
			end

			local var_36_4 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = false

				arg_33_1:SetGaussion(false)
			end

			local var_36_5 = 1.33333333333333

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_5 then
				local var_36_6 = Color.New(0, 0, 0)

				var_36_6.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_4) / var_36_5)
				arg_33_1.mask_.color = var_36_6
			end

			if arg_33_1.time_ >= var_36_4 + var_36_5 and arg_33_1.time_ < var_36_4 + var_36_5 + arg_36_0 then
				local var_36_7 = Color.New(0, 0, 0)

				arg_33_1.mask_.enabled = false
				var_36_7.a = 0
				arg_33_1.mask_.color = var_36_7
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_8 = 1.33333333333333
			local var_36_9 = 1.175

			if 1.33333333333333 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_10 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_10:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_11 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(322122008).content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 47 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 47)

				if (47 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 47)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13
					var_36_8 = var_36_8 + 0.3

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = var_36_8 + 0.3
			local var_36_15 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_14) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_14 + var_36_15 and arg_33_1.time_ < var_36_14 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322122009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 322122009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play322122010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 1.2

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(322122009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 48 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 48)

				if (48 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 48)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play322122010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 322122010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play322122011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0.1 < arg_43_1.time_ and arg_43_1.time_ <= 0.1 + arg_46_0 then
				arg_43_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_46_1 = 0
			local var_46_2 = 1.675

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(322122010).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 67 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 67)

				if (67 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 67)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play322122011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 322122011
		arg_47_1.duration_ = 6.1

		local var_47_0 = {
			zh = 1.7,
			ja = 6.1
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play322122012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.225

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(322122011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 9 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 9)

				if (9 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 9)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122011", "story_v_out_322122.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122011", "story_v_out_322122.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_322122", "322122011", "story_v_out_322122.awb")

						arg_47_1:RecordAudio("322122011", var_50_6)
						arg_47_1:RecordAudio("322122011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_322122", "322122011", "story_v_out_322122.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_322122", "322122011", "story_v_out_322122.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play322122012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 322122012
		arg_51_1.duration_ = 9.5

		local var_51_0 = {
			zh = 9.5,
			ja = 8.2
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play322122013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.575

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(322122012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 23 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 23)

				if (23 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 23)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122012", "story_v_out_322122.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122012", "story_v_out_322122.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_322122", "322122012", "story_v_out_322122.awb")

						arg_51_1:RecordAudio("322122012", var_54_6)
						arg_51_1:RecordAudio("322122012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_322122", "322122012", "story_v_out_322122.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_322122", "322122012", "story_v_out_322122.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play322122013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 322122013
		arg_55_1.duration_ = 5.67

		local var_55_0 = {
			zh = 5.666,
			ja = 5.166
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play322122014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.475

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(322122013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 19 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 19)

				if (19 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 19)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122013", "story_v_out_322122.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122013", "story_v_out_322122.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_322122", "322122013", "story_v_out_322122.awb")

						arg_55_1:RecordAudio("322122013", var_58_6)
						arg_55_1:RecordAudio("322122013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_322122", "322122013", "story_v_out_322122.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_322122", "322122013", "story_v_out_322122.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play322122014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 322122014
		arg_59_1.duration_ = 7.8

		local var_59_0 = {
			zh = 6.366,
			ja = 7.8
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play322122015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.525

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(322122014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 21 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 21)

				if (21 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 21)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122014", "story_v_out_322122.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122014", "story_v_out_322122.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_322122", "322122014", "story_v_out_322122.awb")

						arg_59_1:RecordAudio("322122014", var_62_6)
						arg_59_1:RecordAudio("322122014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_322122", "322122014", "story_v_out_322122.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_322122", "322122014", "story_v_out_322122.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play322122015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 322122015
		arg_63_1.duration_ = 7.37

		local var_63_0 = {
			zh = 7.166,
			ja = 7.366
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play322122016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.35

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(322122015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 14 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 14)

				if (14 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 14)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122015", "story_v_out_322122.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122015", "story_v_out_322122.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_322122", "322122015", "story_v_out_322122.awb")

						arg_63_1:RecordAudio("322122015", var_66_6)
						arg_63_1:RecordAudio("322122015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_322122", "322122015", "story_v_out_322122.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_322122", "322122015", "story_v_out_322122.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play322122016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322122016
		arg_67_1.duration_ = 5.97

		local var_67_0 = {
			zh = 5.966,
			ja = 3.666
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play322122017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.225

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(322122016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 9 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 9)

				if (9 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 9)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122016", "story_v_out_322122.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122016", "story_v_out_322122.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_322122", "322122016", "story_v_out_322122.awb")

						arg_67_1:RecordAudio("322122016", var_70_6)
						arg_67_1:RecordAudio("322122016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_322122", "322122016", "story_v_out_322122.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_322122", "322122016", "story_v_out_322122.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play322122017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322122017
		arg_71_1.duration_ = 5.43

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play322122018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.bgs_.STblack == nil then
				local var_74_0 = Object.Instantiate(arg_71_1.paintGo_)

				var_74_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_74_0.name = "STblack"
				var_74_0.transform.parent = arg_71_1.stage_.transform
				var_74_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.bgs_.STblack = var_74_0
			end

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= 2 + arg_74_0 then
				local var_74_1 = arg_71_1.bgs_.STblack

				arg_71_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_2 = var_74_1:GetComponent("SpriteRenderer")

				if var_74_2 and var_74_2.sprite then
					local var_74_3 = 2 * (var_74_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_1.transform.localScale = Vector3.New(var_74_3 / var_74_2.sprite.bounds.size.y < var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x and var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x or var_74_3 / var_74_2.sprite.bounds.size.y, var_74_3 / var_74_2.sprite.bounds.size.y < var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x and var_74_3 * manager.ui.mainCameraCom_.aspect / var_74_2.sprite.bounds.size.x or var_74_3 / var_74_2.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "STblack" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_4 = 4

			if 4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			if arg_71_1.time_ >= var_74_4 + 0.3 and arg_71_1.time_ < var_74_4 + 0.3 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			local var_74_5 = 0

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_6 = 2

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_6 then
				local var_74_7 = Color.New(0, 0, 0)

				var_74_7.a = Mathf.Lerp(0, 1, (arg_71_1.time_ - var_74_5) / var_74_6)
				arg_71_1.mask_.color = var_74_7
			end

			if arg_71_1.time_ >= var_74_5 + var_74_6 and arg_71_1.time_ < var_74_5 + var_74_6 + arg_74_0 then
				local var_74_8 = Color.New(0, 0, 0)

				var_74_8.a = 1
				arg_71_1.mask_.color = var_74_8
			end

			local var_74_9 = 2

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_10 = 2

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_10 then
				local var_74_11 = Color.New(0, 0, 0)

				var_74_11.a = Mathf.Lerp(1, 0, (arg_71_1.time_ - var_74_9) / var_74_10)
				arg_71_1.mask_.color = var_74_11
			end

			if arg_71_1.time_ >= var_74_9 + var_74_10 and arg_71_1.time_ < var_74_9 + var_74_10 + arg_74_0 then
				local var_74_12 = Color.New(0, 0, 0)

				arg_71_1.mask_.enabled = false
				var_74_12.a = 0
				arg_71_1.mask_.color = var_74_12
			end

			if 4.13333333333333 < arg_71_1.time_ and arg_71_1.time_ <= 4.13333333333333 + arg_74_0 then
				arg_71_1:AudioAction("play", "effect", "se_story_145", "se_story_145_monster_scream01", "")
			end

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= 2 + arg_74_0 then
				arg_71_1.fswbg_:SetActive(true)
				arg_71_1.dialog_:SetActive(false)

				arg_71_1.fswtw_.percent = 0
				arg_71_1.fswt_.text = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(322122017).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.fswt_)

				arg_71_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_71_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_71_1.fswtw_:SetDirty()

				arg_71_1.typewritterCharCountI18N = 0

				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_14 = 3.23333333333333

			if 3.23333333333333 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.var_.oldValueTypewriter = arg_71_1.fswtw_.percent

				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_15 = 33
			local var_74_16 = 2.2
			local var_74_17, var_74_18 = arg_71_1:GetPercentByPara(arg_71_1:FormatText(arg_71_1:GetWordFromCfg(322122017).content), 1)

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				local var_74_19 = var_74_15 <= 0 and var_74_16 or var_74_16 * ((var_74_18 - arg_71_1.typewritterCharCountI18N) / var_74_15)

				if (var_74_15 <= 0 and var_74_16 or var_74_16 * ((var_74_18 - arg_71_1.typewritterCharCountI18N) / var_74_15)) > 0 and var_74_16 < var_74_19 then
					arg_71_1.talkMaxDuration = var_74_19

					if var_74_19 + var_74_14 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_14
					end
				end
			end

			local var_74_20 = math.max(2.2, arg_71_1.talkMaxDuration)

			if var_74_14 <= arg_71_1.time_ and arg_71_1.time_ < var_74_14 + var_74_20 then
				arg_71_1.fswtw_.percent = Mathf.Lerp(arg_71_1.var_.oldValueTypewriter, var_74_17, (arg_71_1.time_ - var_74_14) / var_74_20)
				arg_71_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_71_1.fswtw_:SetDirty()
			end

			if arg_71_1.time_ >= var_74_14 + var_74_20 and arg_71_1.time_ < var_74_14 + var_74_20 + arg_74_0 then
				arg_71_1.fswtw_.percent = var_74_17

				arg_71_1.fswtw_:SetDirty()
				arg_71_1:ShowNextGo(true)

				arg_71_1.typewritterCharCountI18N = var_74_18
			end

			if 2.01666666666667 < arg_71_1.time_ and arg_71_1.time_ <= 2.01666666666667 + arg_74_0 then
				local var_74_21 = arg_71_1.fswbg_.transform:Find("textbox/adapt/content") or arg_71_1.fswbg_.transform:Find("textbox/content")
				local var_74_22 = arg_71_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_74_23 = var_74_21:GetComponent("RectTransform")

				var_74_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_74_23.offsetMin = Vector2.New(0, 0)
				var_74_23.offsetMax = Vector2.New(0, 0)
			end

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= 2 + arg_74_0 then
				if arg_71_1.var_.effect2008 then
					Object.Destroy(arg_71_1.var_.effect2008)

					arg_71_1.var_.effect2008 = nil
				end
			end

			if 2.01666666666667 < arg_71_1.time_ and arg_71_1.time_ <= 2.01666666666667 + arg_74_0 then
				if arg_71_1.var_.effect2002 then
					Object.Destroy(arg_71_1.var_.effect2002)

					arg_71_1.var_.effect2002 = nil
				end
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play322122018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322122018
		arg_75_1.duration_ = 2.3

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play322122019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.fswbg_:SetActive(true)
				arg_75_1.dialog_:SetActive(false)

				arg_75_1.fswtw_.percent = 0
				arg_75_1.fswt_.text = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(322122018).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.fswt_)

				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_75_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_75_1.fswtw_:SetDirty()

				arg_75_1.typewritterCharCountI18N = 0

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.var_.oldValueTypewriter = arg_75_1.fswtw_.percent

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_1 = 20
			local var_78_2 = 1.33333333333333
			local var_78_3, var_78_4 = arg_75_1:GetPercentByPara(arg_75_1:FormatText(arg_75_1:GetWordFromCfg(322122018).content), 1)

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				local var_78_5 = var_78_1 <= 0 and var_78_2 or var_78_2 * ((var_78_4 - arg_75_1.typewritterCharCountI18N) / var_78_1)

				if (var_78_1 <= 0 and var_78_2 or var_78_2 * ((var_78_4 - arg_75_1.typewritterCharCountI18N) / var_78_1)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_0
					end
				end
			end

			local var_78_6 = math.max(1.33333333333333, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_6 then
				arg_75_1.fswtw_.percent = Mathf.Lerp(arg_75_1.var_.oldValueTypewriter, var_78_3, (arg_75_1.time_ - var_78_0) / var_78_6)
				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_75_1.fswtw_:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_6 and arg_75_1.time_ < var_78_0 + var_78_6 + arg_78_0 then
				arg_75_1.fswtw_.percent = var_78_3

				arg_75_1.fswtw_:SetDirty()
				arg_75_1:ShowNextGo(true)

				arg_75_1.typewritterCharCountI18N = var_78_4
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play322122019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322122019
		arg_79_1.duration_ = 7

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play322122020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if arg_79_1.bgs_.L14f == nil then
				local var_82_0 = Object.Instantiate(arg_79_1.paintGo_)

				var_82_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L14f")
				var_82_0.name = "L14f"
				var_82_0.transform.parent = arg_79_1.stage_.transform
				var_82_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.bgs_.L14f = var_82_0
			end

			if 1 < arg_79_1.time_ and arg_79_1.time_ <= 1 + arg_82_0 then
				local var_82_1 = arg_79_1.bgs_.L14f

				arg_79_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_82_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_2 = var_82_1:GetComponent("SpriteRenderer")

				if var_82_2 and var_82_2.sprite then
					local var_82_3 = 2 * (var_82_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_82_1.transform.localScale = Vector3.New(var_82_3 / var_82_2.sprite.bounds.size.y < var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x and var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x or var_82_3 / var_82_2.sprite.bounds.size.y, var_82_3 / var_82_2.sprite.bounds.size.y < var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x and var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x or var_82_3 / var_82_2.sprite.bounds.size.y, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "L14f" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_4 = 2

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= var_82_4 + 0.3 and arg_79_1.time_ < var_82_4 + 0.3 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_5 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_6 = 1

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 then
				local var_82_7 = Color.New(0, 0, 0)

				var_82_7.a = Mathf.Lerp(0, 1, (arg_79_1.time_ - var_82_5) / var_82_6)
				arg_79_1.mask_.color = var_82_7
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 then
				local var_82_8 = Color.New(0, 0, 0)

				var_82_8.a = 1
				arg_79_1.mask_.color = var_82_8
			end

			local var_82_9 = 1

			if 1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_10 = 1

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_10 then
				local var_82_11 = Color.New(0, 0, 0)

				var_82_11.a = Mathf.Lerp(1, 0, (arg_79_1.time_ - var_82_9) / var_82_10)
				arg_79_1.mask_.color = var_82_11
			end

			if arg_79_1.time_ >= var_82_9 + var_82_10 and arg_79_1.time_ < var_82_9 + var_82_10 + arg_82_0 then
				local var_82_12 = Color.New(0, 0, 0)

				arg_79_1.mask_.enabled = false
				var_82_12.a = 0
				arg_79_1.mask_.color = var_82_12
			end

			if 1 < arg_79_1.time_ and arg_79_1.time_ <= 1 + arg_82_0 then
				arg_79_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 1 < arg_79_1.time_ and arg_79_1.time_ <= 1 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 1 < arg_79_1.time_ and arg_79_1.time_ <= 1 + arg_82_0 then
				arg_79_1.fswbg_:SetActive(false)
				arg_79_1.dialog_:SetActive(false)
				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_79_1:ShowNextGo(false)
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_15 = 2
			local var_82_16 = 0.2

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_17 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_17:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_18 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(322122019).content)

				arg_79_1.text_.text = var_82_18

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_20 = 8 <= 0 and var_82_16 or var_82_16 * (utf8.len(var_82_18) / 8)

				if (8 <= 0 and var_82_16 or var_82_16 * (utf8.len(var_82_18) / 8)) > 0 and var_82_16 < var_82_20 then
					arg_79_1.talkMaxDuration = var_82_20
					var_82_15 = var_82_15 + 0.3

					if var_82_20 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_20 + var_82_15
					end
				end

				arg_79_1.text_.text = var_82_18
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_21 = var_82_15 + 0.3
			local var_82_22 = math.max(var_82_16, arg_79_1.talkMaxDuration)

			if var_82_15 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_22 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_21) / var_82_22

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_21 + var_82_22 and arg_79_1.time_ < var_82_21 + var_82_22 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play322122020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 322122020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play322122021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 1.175

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(322122020).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 47 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 47)

				if (47 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 47)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play322122021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 322122021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play322122022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.15

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(322122021).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 46 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 46)

				if (46 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 46)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play322122022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322122022
		arg_93_1.duration_ = 3.4

		local var_93_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play322122023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_96_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_93_1.stage_.transform)

				var_96_0.name = "1156ui_story"
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["1156ui_story"] = var_96_0

				local var_96_1 = var_96_0:GetComponentInChildren(typeof(CharacterEffect))

				var_96_1.enabled = true

				local var_96_2 = GameObjectTools.GetOrAddComponent(var_96_0, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_1.transform, false)

				arg_93_1.var_["1156ui_story" .. "Animator"] = var_96_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_93_1.var_["1156ui_story" .. "LipSync"] = var_96_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_3 = arg_93_1.actors_["1156ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1156ui_story = var_96_3.localPosition
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_3.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_93_1.time_ - 0) / var_96_4)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_3.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			local var_96_5 = arg_93_1.actors_["1156ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1156ui_story == nil then
				arg_93_1.var_.characterEffect1156ui_story = var_96_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_6 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.characterEffect1156ui_story and not isNil(var_96_5) then
					arg_93_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1156ui_story then
				arg_93_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action2_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_96_8 = 0
			local var_96_9 = 0.225

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(322122022)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 9 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 9)

				if (9 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 9)) > 0 and var_96_9 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122022", "story_v_out_322122.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_322122", "322122022", "story_v_out_322122.awb") / 1000

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_322122", "322122022", "story_v_out_322122.awb")

						arg_93_1:RecordAudio("322122022", var_96_15)
						arg_93_1:RecordAudio("322122022", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322122", "322122022", "story_v_out_322122.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322122", "322122022", "story_v_out_322122.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_16 and arg_93_1.time_ < var_96_8 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play322122023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322122023
		arg_97_1.duration_ = 10.97

		local var_97_0 = {
			zh = 7.3,
			ja = 10.966
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322122024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if arg_97_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_100_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_97_1.stage_.transform)

				var_100_0.name = "404001ui_story"
				var_100_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["404001ui_story"] = var_100_0

				local var_100_1 = var_100_0:GetComponentInChildren(typeof(CharacterEffect))

				var_100_1.enabled = true

				local var_100_2 = GameObjectTools.GetOrAddComponent(var_100_0, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(false)
				end

				arg_97_1:ShowWeapon(var_100_1.transform, false)

				arg_97_1.var_["404001ui_story" .. "Animator"] = var_100_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_97_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_97_1.var_["404001ui_story" .. "LipSync"] = var_100_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_100_3 = arg_97_1.actors_["404001ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos404001ui_story = var_100_3.localPosition
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_97_1.time_ - 0) / var_100_4)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(0.8, -1.55, -5.5)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			local var_100_5 = arg_97_1.actors_["404001ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect404001ui_story == nil then
				arg_97_1.var_.characterEffect404001ui_story = var_100_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.characterEffect404001ui_story and not isNil(var_100_5) then
					arg_97_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect404001ui_story then
				arg_97_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_100_8 = arg_97_1.actors_["1156ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.characterEffect1156ui_story == nil then
				arg_97_1.var_.characterEffect1156ui_story = var_100_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_9 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_9 and not isNil(var_100_8) then
				if arg_97_1.var_.characterEffect1156ui_story and not isNil(var_100_8) then
					arg_97_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_9)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_9 and arg_97_1.time_ < 0 + var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.characterEffect1156ui_story then
				arg_97_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_100_10 = 0
			local var_100_11 = 0.85

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_12 = arg_97_1:GetWordFromCfg(322122023)
				local var_100_13 = arg_97_1:FormatText(var_100_12.content)

				arg_97_1.text_.text = var_100_13

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_15 = 34 <= 0 and var_100_11 or var_100_11 * (utf8.len(var_100_13) / 34)

				if (34 <= 0 and var_100_11 or var_100_11 * (utf8.len(var_100_13) / 34)) > 0 and var_100_11 < var_100_15 then
					arg_97_1.talkMaxDuration = var_100_15

					if var_100_15 + var_100_10 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_15 + var_100_10
					end
				end

				arg_97_1.text_.text = var_100_13
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122023", "story_v_out_322122.awb") ~= 0 then
					local var_100_16 = manager.audio:GetVoiceLength("story_v_out_322122", "322122023", "story_v_out_322122.awb") / 1000

					if var_100_16 + var_100_10 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_16 + var_100_10
					end

					if var_100_12.prefab_name ~= "" and arg_97_1.actors_[var_100_12.prefab_name] ~= nil then
						local var_100_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_12.prefab_name].transform, "story_v_out_322122", "322122023", "story_v_out_322122.awb")

						arg_97_1:RecordAudio("322122023", var_100_17)
						arg_97_1:RecordAudio("322122023", var_100_17)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_322122", "322122023", "story_v_out_322122.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_322122", "322122023", "story_v_out_322122.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_18 = math.max(var_100_11, arg_97_1.talkMaxDuration)

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_18 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_10) / var_100_18

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_10 + var_100_18 and arg_97_1.time_ < var_100_10 + var_100_18 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play322122024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322122024
		arg_101_1.duration_ = 4.4

		local var_101_0 = {
			zh = 3.1,
			ja = 4.4
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play322122025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.4

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(322122024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 16 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 16)

				if (16 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 16)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122024", "story_v_out_322122.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122024", "story_v_out_322122.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_322122", "322122024", "story_v_out_322122.awb")

						arg_101_1:RecordAudio("322122024", var_104_6)
						arg_101_1:RecordAudio("322122024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322122", "322122024", "story_v_out_322122.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322122", "322122024", "story_v_out_322122.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play322122025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322122025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322122026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos404001ui_story = arg_105_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["404001ui_story"].transform.position).z)
				arg_105_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["404001ui_story"].transform.localEulerAngles = arg_105_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["404001ui_story"].transform.position).z)
				arg_105_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["404001ui_story"].transform.localEulerAngles = arg_105_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1156ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1156ui_story = var_108_1.localPosition
			end

			local var_108_2 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 then
				var_108_1.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_2)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 then
				var_108_1.localPosition = Vector3.New(0, 100, 0)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			local var_108_3 = 0
			local var_108_4 = 1.575

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(322122025).content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 63 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 63)

				if (63 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 63)) > 0 and var_108_4 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_3 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_3
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_4, arg_105_1.talkMaxDuration)

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_3) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_3 + var_108_8 and arg_105_1.time_ < var_108_3 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play322122026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322122026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play322122027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.325

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(322122026).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 53 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 53)

				if (53 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 53)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play322122027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322122027
		arg_113_1.duration_ = 3.5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322122028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if arg_113_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_116_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_113_1.stage_.transform)

				var_116_0.name = "10104ui_story"
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["10104ui_story"] = var_116_0

				local var_116_1 = var_116_0:GetComponentInChildren(typeof(CharacterEffect))

				var_116_1.enabled = true

				local var_116_2 = GameObjectTools.GetOrAddComponent(var_116_0, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(false)
				end

				arg_113_1:ShowWeapon(var_116_1.transform, false)

				arg_113_1.var_["10104ui_story" .. "Animator"] = var_116_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_113_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_113_1.var_["10104ui_story" .. "LipSync"] = var_116_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_116_3 = arg_113_1.actors_["10104ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10104ui_story = var_116_3.localPosition
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_113_1.time_ - 0) / var_116_4)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			local var_116_5 = arg_113_1.actors_["10104ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect10104ui_story == nil then
				arg_113_1.var_.characterEffect10104ui_story = var_116_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_6 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 and not isNil(var_116_5) then
				if arg_113_1.var_.characterEffect10104ui_story and not isNil(var_116_5) then
					arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect10104ui_story then
				arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				if arg_113_1.var_.characterEffect10104ui_story == nil then
					arg_113_1.var_.characterEffect10104ui_story = arg_113_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_116_8 = arg_113_1.var_.characterEffect10104ui_story

				arg_113_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_116_8.interferenceEffect.enabled = true
				var_116_8.interferenceEffect.noise = 0
				var_116_8.interferenceEffect.simTimeScale = 1
				var_116_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				if arg_113_1.var_.characterEffect10104ui_story == nil then
					arg_113_1.var_.characterEffect10104ui_story = arg_113_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_113_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_116_10 = 0
			local var_116_11 = 0.175

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_12 = arg_113_1:GetWordFromCfg(322122027)
				local var_116_13 = arg_113_1:FormatText(var_116_12.content)

				arg_113_1.text_.text = var_116_13

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_15 = 7 <= 0 and var_116_11 or var_116_11 * (utf8.len(var_116_13) / 7)

				if (7 <= 0 and var_116_11 or var_116_11 * (utf8.len(var_116_13) / 7)) > 0 and var_116_11 < var_116_15 then
					arg_113_1.talkMaxDuration = var_116_15

					if var_116_15 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_15 + var_116_10
					end
				end

				arg_113_1.text_.text = var_116_13
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122027", "story_v_out_322122.awb") ~= 0 then
					local var_116_16 = manager.audio:GetVoiceLength("story_v_out_322122", "322122027", "story_v_out_322122.awb") / 1000

					if var_116_16 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_16 + var_116_10
					end

					if var_116_12.prefab_name ~= "" and arg_113_1.actors_[var_116_12.prefab_name] ~= nil then
						local var_116_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_12.prefab_name].transform, "story_v_out_322122", "322122027", "story_v_out_322122.awb")

						arg_113_1:RecordAudio("322122027", var_116_17)
						arg_113_1:RecordAudio("322122027", var_116_17)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_322122", "322122027", "story_v_out_322122.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_322122", "322122027", "story_v_out_322122.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_18 = math.max(var_116_11, arg_113_1.talkMaxDuration)

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_18 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_10) / var_116_18

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_10 + var_116_18 and arg_113_1.time_ < var_116_10 + var_116_18 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play322122028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322122028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322122029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10104ui_story"]) and arg_117_1.var_.characterEffect10104ui_story == nil then
				arg_117_1.var_.characterEffect10104ui_story = arg_117_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10104ui_story"]) then
				if arg_117_1.var_.characterEffect10104ui_story and not isNil(arg_117_1.actors_["10104ui_story"]) then
					arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10104ui_story"]) and arg_117_1.var_.characterEffect10104ui_story then
				arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.225

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(322122028).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 9 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 9)

				if (9 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 9)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play322122029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322122029
		arg_121_1.duration_ = 8.2

		local var_121_0 = {
			zh = 4.733,
			ja = 8.2
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play322122030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10104ui_story = arg_121_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).z)
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles = arg_121_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_121_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).z)
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles = arg_121_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["10104ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10104ui_story == nil then
				arg_121_1.var_.characterEffect10104ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10104ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10104ui_story then
				arg_121_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				if arg_121_1.var_.characterEffect10104ui_story == nil then
					arg_121_1.var_.characterEffect10104ui_story = arg_121_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_124_4 = arg_121_1.var_.characterEffect10104ui_story

				arg_121_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_124_4.interferenceEffect.enabled = true
				var_124_4.interferenceEffect.noise = 0
				var_124_4.interferenceEffect.simTimeScale = 1
				var_124_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				if arg_121_1.var_.characterEffect10104ui_story == nil then
					arg_121_1.var_.characterEffect10104ui_story = arg_121_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_121_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_124_6 = 0
			local var_124_7 = 0.6

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(322122029)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 24 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 24)

				if (24 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 24)) > 0 and var_124_7 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122029", "story_v_out_322122.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_out_322122", "322122029", "story_v_out_322122.awb") / 1000

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end

					if var_124_8.prefab_name ~= "" and arg_121_1.actors_[var_124_8.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_8.prefab_name].transform, "story_v_out_322122", "322122029", "story_v_out_322122.awb")

						arg_121_1:RecordAudio("322122029", var_124_13)
						arg_121_1:RecordAudio("322122029", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322122", "322122029", "story_v_out_322122.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322122", "322122029", "story_v_out_322122.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play322122030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322122030
		arg_125_1.duration_ = 3.9

		local var_125_0 = {
			zh = 3.9,
			ja = 3.1
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play322122031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos404001ui_story = arg_125_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).z)
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles = arg_125_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_125_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["404001ui_story"].transform.position).z)
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["404001ui_story"].transform.localEulerAngles = arg_125_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["10104ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10104ui_story = var_128_1.localPosition
			end

			local var_128_2 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 then
				var_128_1.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_125_1.time_ - 0) / var_128_2)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 then
				var_128_1.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			local var_128_3 = arg_125_1.actors_["404001ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_3) and arg_125_1.var_.characterEffect404001ui_story == nil then
				arg_125_1.var_.characterEffect404001ui_story = var_128_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_4 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 and not isNil(var_128_3) then
				if arg_125_1.var_.characterEffect404001ui_story and not isNil(var_128_3) then
					arg_125_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 and not isNil(var_128_3) and arg_125_1.var_.characterEffect404001ui_story then
				arg_125_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_128_6 = arg_125_1.actors_["10104ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect10104ui_story == nil then
				arg_125_1.var_.characterEffect10104ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_7 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 and not isNil(var_128_6) then
				if arg_125_1.var_.characterEffect10104ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_7)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect10104ui_story then
				arg_125_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_128_8 = 0
			local var_128_9 = 0.425

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(322122030)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 17 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 17)

				if (17 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 17)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122030", "story_v_out_322122.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_322122", "322122030", "story_v_out_322122.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_322122", "322122030", "story_v_out_322122.awb")

						arg_125_1:RecordAudio("322122030", var_128_15)
						arg_125_1:RecordAudio("322122030", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_322122", "322122030", "story_v_out_322122.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_322122", "322122030", "story_v_out_322122.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_125_1:InitPlayNodeList()
	end,
	Play322122031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 322122031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play322122032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["404001ui_story"]) and arg_129_1.var_.characterEffect404001ui_story == nil then
				arg_129_1.var_.characterEffect404001ui_story = arg_129_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["404001ui_story"]) then
				if arg_129_1.var_.characterEffect404001ui_story and not isNil(arg_129_1.actors_["404001ui_story"]) then
					arg_129_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_129_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["404001ui_story"]) and arg_129_1.var_.characterEffect404001ui_story then
				arg_129_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_129_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 1.175

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(322122031).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 47 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 47)

				if (47 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 47)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play322122032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 322122032
		arg_133_1.duration_ = 5.47

		local var_133_0 = {
			zh = 3.499999999999,
			ja = 5.466
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play322122033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10104ui_story = arg_133_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10104ui_story"].transform.position).z)
				arg_133_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10104ui_story"].transform.localEulerAngles = arg_133_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				arg_133_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10104ui_story"].transform.position).z)
				arg_133_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10104ui_story"].transform.localEulerAngles = arg_133_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["10104ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10104ui_story == nil then
				arg_133_1.var_.characterEffect10104ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect10104ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10104ui_story then
				arg_133_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				if arg_133_1.var_.characterEffect10104ui_story == nil then
					arg_133_1.var_.characterEffect10104ui_story = arg_133_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_136_4 = arg_133_1.var_.characterEffect10104ui_story

				arg_133_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_136_4.interferenceEffect.enabled = true
				var_136_4.interferenceEffect.noise = 0
				var_136_4.interferenceEffect.simTimeScale = 1
				var_136_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				if arg_133_1.var_.characterEffect10104ui_story == nil then
					arg_133_1.var_.characterEffect10104ui_story = arg_133_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_133_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_136_6 = 0
			local var_136_7 = 0.325

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(322122032)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 13 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 13)

				if (13 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 13)) > 0 and var_136_7 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122032", "story_v_out_322122.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_322122", "322122032", "story_v_out_322122.awb") / 1000

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_out_322122", "322122032", "story_v_out_322122.awb")

						arg_133_1:RecordAudio("322122032", var_136_13)
						arg_133_1:RecordAudio("322122032", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_322122", "322122032", "story_v_out_322122.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_322122", "322122032", "story_v_out_322122.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play322122033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 322122033
		arg_137_1.duration_ = 3.2

		local var_137_0 = {
			zh = 2.866,
			ja = 3.2
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play322122034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos404001ui_story = arg_137_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["404001ui_story"].transform.position).z)
				arg_137_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["404001ui_story"].transform.localEulerAngles = arg_137_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_137_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["404001ui_story"].transform.position).z)
				arg_137_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["404001ui_story"].transform.localEulerAngles = arg_137_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["404001ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect404001ui_story == nil then
				arg_137_1.var_.characterEffect404001ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect404001ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect404001ui_story then
				arg_137_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_140_4 = arg_137_1.actors_["10104ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect10104ui_story == nil then
				arg_137_1.var_.characterEffect10104ui_story = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_5 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 and not isNil(var_140_4) then
				if arg_137_1.var_.characterEffect10104ui_story and not isNil(var_140_4) then
					arg_137_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_5)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect10104ui_story then
				arg_137_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_140_6 = 0
			local var_140_7 = 0.275

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(322122033)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 11 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 11)

				if (11 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 11)) > 0 and var_140_7 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122033", "story_v_out_322122.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_322122", "322122033", "story_v_out_322122.awb") / 1000

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_322122", "322122033", "story_v_out_322122.awb")

						arg_137_1:RecordAudio("322122033", var_140_13)
						arg_137_1:RecordAudio("322122033", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_322122", "322122033", "story_v_out_322122.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_322122", "322122033", "story_v_out_322122.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play322122034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 322122034
		arg_141_1.duration_ = 3.5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play322122035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10104ui_story"]) and arg_141_1.var_.characterEffect10104ui_story == nil then
				arg_141_1.var_.characterEffect10104ui_story = arg_141_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10104ui_story"]) then
				if arg_141_1.var_.characterEffect10104ui_story and not isNil(arg_141_1.actors_["10104ui_story"]) then
					arg_141_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10104ui_story"]) and arg_141_1.var_.characterEffect10104ui_story then
				arg_141_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_144_2 = arg_141_1.actors_["404001ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect404001ui_story == nil then
				arg_141_1.var_.characterEffect404001ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect404001ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_141_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect404001ui_story then
				arg_141_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_141_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				if arg_141_1.var_.characterEffect10104ui_story == nil then
					arg_141_1.var_.characterEffect10104ui_story = arg_141_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_144_4 = arg_141_1.var_.characterEffect10104ui_story

				arg_141_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_144_4.interferenceEffect.enabled = true
				var_144_4.interferenceEffect.noise = 0
				var_144_4.interferenceEffect.simTimeScale = 1
				var_144_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				if arg_141_1.var_.characterEffect10104ui_story == nil then
					arg_141_1.var_.characterEffect10104ui_story = arg_141_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_141_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_144_6 = 0
			local var_144_7 = 0.075

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:GetWordFromCfg(322122034)
				local var_144_9 = arg_141_1:FormatText(var_144_8.content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 3 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 3)

				if (3 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 3)) > 0 and var_144_7 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122034", "story_v_out_322122.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_out_322122", "322122034", "story_v_out_322122.awb") / 1000

					if var_144_12 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_6
					end

					if var_144_8.prefab_name ~= "" and arg_141_1.actors_[var_144_8.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_8.prefab_name].transform, "story_v_out_322122", "322122034", "story_v_out_322122.awb")

						arg_141_1:RecordAudio("322122034", var_144_13)
						arg_141_1:RecordAudio("322122034", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322122", "322122034", "story_v_out_322122.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322122", "322122034", "story_v_out_322122.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play322122035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 322122035
		arg_145_1.duration_ = 2.4

		local var_145_0 = {
			zh = 2.133,
			ja = 2.4
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play322122036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_148_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_145_1.stage_.transform)

				var_148_0.name = "1284ui_story"
				var_148_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1284ui_story"] = var_148_0

				local var_148_1 = var_148_0:GetComponentInChildren(typeof(CharacterEffect))

				var_148_1.enabled = true

				local var_148_2 = GameObjectTools.GetOrAddComponent(var_148_0, typeof(DynamicBoneHelper))

				if var_148_2 then
					var_148_2:EnableDynamicBone(false)
				end

				arg_145_1:ShowWeapon(var_148_1.transform, false)

				arg_145_1.var_["1284ui_story" .. "Animator"] = var_148_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_145_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_145_1.var_["1284ui_story" .. "LipSync"] = var_148_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_148_3 = arg_145_1.actors_["1284ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1284ui_story = var_148_3.localPosition
			end

			local var_148_4 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_3.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_145_1.time_ - 0) / var_148_4)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_3.localPosition = Vector3.New(0.7, -0.985, -6.22)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			local var_148_5 = arg_145_1.actors_["1284ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1284ui_story == nil then
				arg_145_1.var_.characterEffect1284ui_story = var_148_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.characterEffect1284ui_story and not isNil(var_148_5) then
					arg_145_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1284ui_story then
				arg_145_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_148_8 = arg_145_1.actors_["10104ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_8) and arg_145_1.var_.characterEffect10104ui_story == nil then
				arg_145_1.var_.characterEffect10104ui_story = var_148_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_9 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_9 and not isNil(var_148_8) then
				if arg_145_1.var_.characterEffect10104ui_story and not isNil(var_148_8) then
					arg_145_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_9)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_9 and arg_145_1.time_ < 0 + var_148_9 + arg_148_0 and not isNil(var_148_8) and arg_145_1.var_.characterEffect10104ui_story then
				arg_145_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva", "EmotionTimelineAnimator")
			end

			local var_148_10 = arg_145_1.actors_["404001ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos404001ui_story = var_148_10.localPosition
			end

			local var_148_11 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_11 then
				var_148_10.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_11)
				var_148_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_10.position).x, (manager.ui.mainCamera.transform.position - var_148_10.position).y, (manager.ui.mainCamera.transform.position - var_148_10.position).z)
				var_148_10.localEulerAngles.z = 0
				var_148_10.localEulerAngles.x = 0
				var_148_10.localEulerAngles = var_148_10.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_11 and arg_145_1.time_ < 0 + var_148_11 + arg_148_0 then
				var_148_10.localPosition = Vector3.New(0, 100, 0)
				var_148_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_10.position).x, (manager.ui.mainCamera.transform.position - var_148_10.position).y, (manager.ui.mainCamera.transform.position - var_148_10.position).z)
				var_148_10.localEulerAngles.z = 0
				var_148_10.localEulerAngles.x = 0
				var_148_10.localEulerAngles = var_148_10.localEulerAngles
			end

			local var_148_12 = 0
			local var_148_13 = 0.25

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_14 = arg_145_1:GetWordFromCfg(322122035)
				local var_148_15 = arg_145_1:FormatText(var_148_14.content)

				arg_145_1.text_.text = var_148_15

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 10 <= 0 and var_148_13 or var_148_13 * (utf8.len(var_148_15) / 10)

				if (10 <= 0 and var_148_13 or var_148_13 * (utf8.len(var_148_15) / 10)) > 0 and var_148_13 < var_148_17 then
					arg_145_1.talkMaxDuration = var_148_17

					if var_148_17 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_17 + var_148_12
					end
				end

				arg_145_1.text_.text = var_148_15
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122035", "story_v_out_322122.awb") ~= 0 then
					local var_148_18 = manager.audio:GetVoiceLength("story_v_out_322122", "322122035", "story_v_out_322122.awb") / 1000

					if var_148_18 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_18 + var_148_12
					end

					if var_148_14.prefab_name ~= "" and arg_145_1.actors_[var_148_14.prefab_name] ~= nil then
						local var_148_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_14.prefab_name].transform, "story_v_out_322122", "322122035", "story_v_out_322122.awb")

						arg_145_1:RecordAudio("322122035", var_148_19)
						arg_145_1:RecordAudio("322122035", var_148_19)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_322122", "322122035", "story_v_out_322122.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_322122", "322122035", "story_v_out_322122.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_20 = math.max(var_148_13, arg_145_1.talkMaxDuration)

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_20 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_12) / var_148_20

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_12 + var_148_20 and arg_145_1.time_ < var_148_12 + var_148_20 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play322122036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322122036
		arg_149_1.duration_ = 3.5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play322122037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10104ui_story"]) and arg_149_1.var_.characterEffect10104ui_story == nil then
				arg_149_1.var_.characterEffect10104ui_story = arg_149_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10104ui_story"]) then
				if arg_149_1.var_.characterEffect10104ui_story and not isNil(arg_149_1.actors_["10104ui_story"]) then
					arg_149_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10104ui_story"]) and arg_149_1.var_.characterEffect10104ui_story then
				arg_149_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_152_2 = arg_149_1.actors_["1284ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1284ui_story == nil then
				arg_149_1.var_.characterEffect1284ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1284ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1284ui_story then
				arg_149_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				if arg_149_1.var_.characterEffect10104ui_story == nil then
					arg_149_1.var_.characterEffect10104ui_story = arg_149_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_152_4 = arg_149_1.var_.characterEffect10104ui_story

				arg_149_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_152_4.interferenceEffect.enabled = true
				var_152_4.interferenceEffect.noise = 0
				var_152_4.interferenceEffect.simTimeScale = 1
				var_152_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				if arg_149_1.var_.characterEffect10104ui_story == nil then
					arg_149_1.var_.characterEffect10104ui_story = arg_149_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_149_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_152_6 = 0
			local var_152_7 = 0.375

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(322122036)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 15 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 15)

				if (15 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 15)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122036", "story_v_out_322122.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_322122", "322122036", "story_v_out_322122.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_322122", "322122036", "story_v_out_322122.awb")

						arg_149_1:RecordAudio("322122036", var_152_13)
						arg_149_1:RecordAudio("322122036", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322122", "322122036", "story_v_out_322122.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322122", "322122036", "story_v_out_322122.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play322122037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322122037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play322122038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10104ui_story = arg_153_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10104ui_story"].transform.position).z)
				arg_153_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10104ui_story"].transform.localEulerAngles = arg_153_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10104ui_story"].transform.position).z)
				arg_153_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10104ui_story"].transform.localEulerAngles = arg_153_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1284ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1284ui_story = var_156_1.localPosition
			end

			local var_156_2 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 then
				var_156_1.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_2)
				var_156_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_1.position).x, (manager.ui.mainCamera.transform.position - var_156_1.position).y, (manager.ui.mainCamera.transform.position - var_156_1.position).z)
				var_156_1.localEulerAngles.z = 0
				var_156_1.localEulerAngles.x = 0
				var_156_1.localEulerAngles = var_156_1.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 then
				var_156_1.localPosition = Vector3.New(0, 100, 0)
				var_156_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_1.position).x, (manager.ui.mainCamera.transform.position - var_156_1.position).y, (manager.ui.mainCamera.transform.position - var_156_1.position).z)
				var_156_1.localEulerAngles.z = 0
				var_156_1.localEulerAngles.x = 0
				var_156_1.localEulerAngles = var_156_1.localEulerAngles
			end

			local var_156_3 = 0
			local var_156_4 = 1.275

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_3 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_5 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(322122037).content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_7 = 51 <= 0 and var_156_4 or var_156_4 * (utf8.len(var_156_5) / 51)

				if (51 <= 0 and var_156_4 or var_156_4 * (utf8.len(var_156_5) / 51)) > 0 and var_156_4 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_3 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_3
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_8 = math.max(var_156_4, arg_153_1.talkMaxDuration)

			if var_156_3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_3 + var_156_8 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_3) / var_156_8

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_3 + var_156_8 and arg_153_1.time_ < var_156_3 + var_156_8 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play322122038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 322122038
		arg_157_1.duration_ = 2

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play322122039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1156ui_story = arg_157_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).z)
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles = arg_157_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_157_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1156ui_story"].transform.position).z)
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1156ui_story"].transform.localEulerAngles = arg_157_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1156ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1156ui_story == nil then
				arg_157_1.var_.characterEffect1156ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1156ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1156ui_story then
				arg_157_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_160_4 = 0
			local var_160_5 = 0.1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(322122038)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 4 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 4)

				if (4 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 4)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122038", "story_v_out_322122.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_322122", "322122038", "story_v_out_322122.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_322122", "322122038", "story_v_out_322122.awb")

						arg_157_1:RecordAudio("322122038", var_160_11)
						arg_157_1:RecordAudio("322122038", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_322122", "322122038", "story_v_out_322122.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_322122", "322122038", "story_v_out_322122.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play322122039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 322122039
		arg_161_1.duration_ = 2

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play322122040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if arg_161_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_164_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_161_1.stage_.transform)

				var_164_0.name = "1211ui_story"
				var_164_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1211ui_story"] = var_164_0

				local var_164_1 = var_164_0:GetComponentInChildren(typeof(CharacterEffect))

				var_164_1.enabled = true

				local var_164_2 = GameObjectTools.GetOrAddComponent(var_164_0, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(false)
				end

				arg_161_1:ShowWeapon(var_164_1.transform, false)

				arg_161_1.var_["1211ui_story" .. "Animator"] = var_164_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_161_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_161_1.var_["1211ui_story" .. "LipSync"] = var_164_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_164_3 = arg_161_1.actors_["1211ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1211ui_story = var_164_3.localPosition
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_3.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_161_1.time_ - 0) / var_164_4)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_3.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			local var_164_5 = arg_161_1.actors_["1211ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1211ui_story == nil then
				arg_161_1.var_.characterEffect1211ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.characterEffect1211ui_story and not isNil(var_164_5) then
					arg_161_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1211ui_story then
				arg_161_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_164_8 = arg_161_1.actors_["1156ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.characterEffect1156ui_story == nil then
				arg_161_1.var_.characterEffect1156ui_story = var_164_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_9 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_9 and not isNil(var_164_8) then
				if arg_161_1.var_.characterEffect1156ui_story and not isNil(var_164_8) then
					arg_161_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_9)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_9 and arg_161_1.time_ < 0 + var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.characterEffect1156ui_story then
				arg_161_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_164_10 = 0
			local var_164_11 = 0.075

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_12 = arg_161_1:GetWordFromCfg(322122039)
				local var_164_13 = arg_161_1:FormatText(var_164_12.content)

				arg_161_1.text_.text = var_164_13

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 3 <= 0 and var_164_11 or var_164_11 * (utf8.len(var_164_13) / 3)

				if (3 <= 0 and var_164_11 or var_164_11 * (utf8.len(var_164_13) / 3)) > 0 and var_164_11 < var_164_15 then
					arg_161_1.talkMaxDuration = var_164_15

					if var_164_15 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_15 + var_164_10
					end
				end

				arg_161_1.text_.text = var_164_13
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122039", "story_v_out_322122.awb") ~= 0 then
					local var_164_16 = manager.audio:GetVoiceLength("story_v_out_322122", "322122039", "story_v_out_322122.awb") / 1000

					if var_164_16 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_16 + var_164_10
					end

					if var_164_12.prefab_name ~= "" and arg_161_1.actors_[var_164_12.prefab_name] ~= nil then
						local var_164_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_12.prefab_name].transform, "story_v_out_322122", "322122039", "story_v_out_322122.awb")

						arg_161_1:RecordAudio("322122039", var_164_17)
						arg_161_1:RecordAudio("322122039", var_164_17)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_322122", "322122039", "story_v_out_322122.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_322122", "322122039", "story_v_out_322122.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_18 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_18 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_10) / var_164_18

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_10 + var_164_18 and arg_161_1.time_ < var_164_10 + var_164_18 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play322122040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 322122040
		arg_165_1.duration_ = 2

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play322122041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos404001ui_story = arg_165_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).z)
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles = arg_165_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_165_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).z)
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles = arg_165_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1211ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1211ui_story = var_168_1.localPosition
			end

			local var_168_2 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 then
				var_168_1.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_2)
				var_168_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_1.position).x, (manager.ui.mainCamera.transform.position - var_168_1.position).y, (manager.ui.mainCamera.transform.position - var_168_1.position).z)
				var_168_1.localEulerAngles.z = 0
				var_168_1.localEulerAngles.x = 0
				var_168_1.localEulerAngles = var_168_1.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 then
				var_168_1.localPosition = Vector3.New(0, 100, 0)
				var_168_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_1.position).x, (manager.ui.mainCamera.transform.position - var_168_1.position).y, (manager.ui.mainCamera.transform.position - var_168_1.position).z)
				var_168_1.localEulerAngles.z = 0
				var_168_1.localEulerAngles.x = 0
				var_168_1.localEulerAngles = var_168_1.localEulerAngles
			end

			local var_168_3 = arg_165_1.actors_["1156ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1156ui_story = var_168_3.localPosition
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_3.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_4)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_3.localPosition = Vector3.New(0, 100, 0)
				var_168_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_3.position).x, (manager.ui.mainCamera.transform.position - var_168_3.position).y, (manager.ui.mainCamera.transform.position - var_168_3.position).z)
				var_168_3.localEulerAngles.z = 0
				var_168_3.localEulerAngles.x = 0
				var_168_3.localEulerAngles = var_168_3.localEulerAngles
			end

			local var_168_5 = arg_165_1.actors_["404001ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect404001ui_story == nil then
				arg_165_1.var_.characterEffect404001ui_story = var_168_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_6 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.characterEffect404001ui_story and not isNil(var_168_5) then
					arg_165_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect404001ui_story then
				arg_165_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_168_8 = arg_165_1.actors_["1211ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.characterEffect1211ui_story == nil then
				arg_165_1.var_.characterEffect1211ui_story = var_168_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_9 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_9 and not isNil(var_168_8) then
				if arg_165_1.var_.characterEffect1211ui_story and not isNil(var_168_8) then
					arg_165_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_9)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_9 and arg_165_1.time_ < 0 + var_168_9 + arg_168_0 and not isNil(var_168_8) and arg_165_1.var_.characterEffect1211ui_story then
				arg_165_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva", "EmotionTimelineAnimator")
			end

			local var_168_10 = 0
			local var_168_11 = 0.125

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_12 = arg_165_1:GetWordFromCfg(322122040)
				local var_168_13 = arg_165_1:FormatText(var_168_12.content)

				arg_165_1.text_.text = var_168_13

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_15 = 5 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 5)

				if (5 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 5)) > 0 and var_168_11 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_10
					end
				end

				arg_165_1.text_.text = var_168_13
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122040", "story_v_out_322122.awb") ~= 0 then
					local var_168_16 = manager.audio:GetVoiceLength("story_v_out_322122", "322122040", "story_v_out_322122.awb") / 1000

					if var_168_16 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_16 + var_168_10
					end

					if var_168_12.prefab_name ~= "" and arg_165_1.actors_[var_168_12.prefab_name] ~= nil then
						local var_168_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_12.prefab_name].transform, "story_v_out_322122", "322122040", "story_v_out_322122.awb")

						arg_165_1:RecordAudio("322122040", var_168_17)
						arg_165_1:RecordAudio("322122040", var_168_17)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_322122", "322122040", "story_v_out_322122.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_322122", "322122040", "story_v_out_322122.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_18 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_18 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_10) / var_168_18

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_10 + var_168_18 and arg_165_1.time_ < var_168_10 + var_168_18 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play322122041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 322122041
		arg_169_1.duration_ = 9

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play322122042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if arg_169_1.bgs_.MS2203 == nil then
				local var_172_0 = Object.Instantiate(arg_169_1.paintGo_)

				var_172_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2203")
				var_172_0.name = "MS2203"
				var_172_0.transform.parent = arg_169_1.stage_.transform
				var_172_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.bgs_.MS2203 = var_172_0
			end

			if 2 < arg_169_1.time_ and arg_169_1.time_ <= 2 + arg_172_0 then
				local var_172_1 = arg_169_1.bgs_.MS2203

				arg_169_1.bgs_.MS2203.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_172_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_172_2 = var_172_1:GetComponent("SpriteRenderer")

				if var_172_2 and var_172_2.sprite then
					local var_172_3 = 2 * (var_172_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_172_1.transform.localScale = Vector3.New(var_172_3 / var_172_2.sprite.bounds.size.y < var_172_3 * manager.ui.mainCameraCom_.aspect / var_172_2.sprite.bounds.size.x and var_172_3 * manager.ui.mainCameraCom_.aspect / var_172_2.sprite.bounds.size.x or var_172_3 / var_172_2.sprite.bounds.size.y, var_172_3 / var_172_2.sprite.bounds.size.y < var_172_3 * manager.ui.mainCameraCom_.aspect / var_172_2.sprite.bounds.size.x and var_172_3 * manager.ui.mainCameraCom_.aspect / var_172_2.sprite.bounds.size.x or var_172_3 / var_172_2.sprite.bounds.size.y, 0)
				end

				for iter_172_0, iter_172_1 in pairs(arg_169_1.bgs_) do
					if iter_172_0 ~= "MS2203" then
						iter_172_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_172_4 = 3.999999999999

			if 3.999999999999 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			if arg_169_1.time_ >= var_172_4 + 0.3 and arg_169_1.time_ < var_172_4 + 0.3 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			local var_172_5 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_6 = 2

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_6 then
				local var_172_7 = Color.New(0, 0, 0)

				var_172_7.a = Mathf.Lerp(0, 1, (arg_169_1.time_ - var_172_5) / var_172_6)
				arg_169_1.mask_.color = var_172_7
			end

			if arg_169_1.time_ >= var_172_5 + var_172_6 and arg_169_1.time_ < var_172_5 + var_172_6 + arg_172_0 then
				local var_172_8 = Color.New(0, 0, 0)

				var_172_8.a = 1
				arg_169_1.mask_.color = var_172_8
			end

			local var_172_9 = 2

			if 2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_10 = 2

			if var_172_9 <= arg_169_1.time_ and arg_169_1.time_ < var_172_9 + var_172_10 then
				local var_172_11 = Color.New(0, 0, 0)

				var_172_11.a = Mathf.Lerp(1, 0, (arg_169_1.time_ - var_172_9) / var_172_10)
				arg_169_1.mask_.color = var_172_11
			end

			if arg_169_1.time_ >= var_172_9 + var_172_10 and arg_169_1.time_ < var_172_9 + var_172_10 + arg_172_0 then
				local var_172_12 = Color.New(0, 0, 0)

				arg_169_1.mask_.enabled = false
				var_172_12.a = 0
				arg_169_1.mask_.color = var_172_12
			end

			local var_172_13 = arg_169_1.actors_["404001ui_story"].transform

			if 1.96599999815226 < arg_169_1.time_ and arg_169_1.time_ <= 1.96599999815226 + arg_172_0 then
				arg_169_1.var_.moveOldPos404001ui_story = var_172_13.localPosition
			end

			local var_172_14 = 0.001

			if 1.96599999815226 <= arg_169_1.time_ and arg_169_1.time_ < 1.96599999815226 + var_172_14 then
				var_172_13.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 1.96599999815226) / var_172_14)
				var_172_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_13.position).x, (manager.ui.mainCamera.transform.position - var_172_13.position).y, (manager.ui.mainCamera.transform.position - var_172_13.position).z)
				var_172_13.localEulerAngles.z = 0
				var_172_13.localEulerAngles.x = 0
				var_172_13.localEulerAngles = var_172_13.localEulerAngles
			end

			if arg_169_1.time_ >= 1.96599999815226 + var_172_14 and arg_169_1.time_ < 1.96599999815226 + var_172_14 + arg_172_0 then
				var_172_13.localPosition = Vector3.New(0, 100, 0)
				var_172_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_13.position).x, (manager.ui.mainCamera.transform.position - var_172_13.position).y, (manager.ui.mainCamera.transform.position - var_172_13.position).z)
				var_172_13.localEulerAngles.z = 0
				var_172_13.localEulerAngles.x = 0
				var_172_13.localEulerAngles = var_172_13.localEulerAngles
			end

			local var_172_15 = arg_169_1.actors_["404001ui_story"]

			if 1.96599999815226 < arg_169_1.time_ and arg_169_1.time_ <= 1.96599999815226 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.characterEffect404001ui_story == nil then
				arg_169_1.var_.characterEffect404001ui_story = var_172_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_16 = 0.034000001847744

			if 1.96599999815226 <= arg_169_1.time_ and arg_169_1.time_ < 1.96599999815226 + var_172_16 and not isNil(var_172_15) then
				if arg_169_1.var_.characterEffect404001ui_story and not isNil(var_172_15) then
					arg_169_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_169_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 1.96599999815226) / var_172_16)
				end
			end

			if arg_169_1.time_ >= 1.96599999815226 + var_172_16 and arg_169_1.time_ < 1.96599999815226 + var_172_16 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.characterEffect404001ui_story then
				arg_169_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_169_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_169_1.time_ and arg_169_1.time_ <= 0.1 + arg_172_0 then
				arg_169_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 1.53333333333333 < arg_169_1.time_ and arg_169_1.time_ <= 1.53333333333333 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_172_19 = arg_169_1.bgs_.MS2203.transform

			if 2 < arg_169_1.time_ and arg_169_1.time_ <= 2 + arg_172_0 then
				arg_169_1.var_.moveOldPosMS2203 = var_172_19.localPosition
			end

			local var_172_20 = 2

			if 2 <= arg_169_1.time_ and arg_169_1.time_ < 2 + var_172_20 then
				var_172_19.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPosMS2203, Vector3.New(0, 1, 9), (arg_169_1.time_ - 2) / var_172_20)
			end

			if arg_169_1.time_ >= 2 + var_172_20 and arg_169_1.time_ < 2 + var_172_20 + arg_172_0 then
				var_172_19.localPosition = Vector3.New(0, 1, 9)
			end

			if 1.9 < arg_169_1.time_ and arg_169_1.time_ <= 1.9 + arg_172_0 then
				if arg_169_1.var_.effect2041 then
					Object.Destroy(arg_169_1.var_.effect2041)

					arg_169_1.var_.effect2041 = nil
				end
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_22 = 3.999999999999
			local var_172_23 = 0.775

			if 3.999999999999 < arg_169_1.time_ and arg_169_1.time_ <= var_172_22 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_24 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_24:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_25 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(322122041).content)

				arg_169_1.text_.text = var_172_25

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_27 = 31 <= 0 and var_172_23 or var_172_23 * (utf8.len(var_172_25) / 31)

				if (31 <= 0 and var_172_23 or var_172_23 * (utf8.len(var_172_25) / 31)) > 0 and var_172_23 < var_172_27 then
					arg_169_1.talkMaxDuration = var_172_27
					var_172_22 = var_172_22 + 0.3

					if var_172_27 + var_172_22 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_27 + var_172_22
					end
				end

				arg_169_1.text_.text = var_172_25
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_28 = var_172_22 + 0.3
			local var_172_29 = math.max(var_172_23, arg_169_1.talkMaxDuration)

			if var_172_22 + 0.3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_28 + var_172_29 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_28) / var_172_29

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_28 + var_172_29 and arg_169_1.time_ < var_172_28 + var_172_29 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2203",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play322122042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322122042
		arg_175_1.duration_ = 6.8

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play322122043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_9000

			if 1.02759986349071 < arg_175_1.time_ and arg_175_1.time_ <= 1.02759986349071 + arg_178_0 then
				arg_175_1:AudioAction("play", "effect", "se_story_3", "se_story_3_windspear", "")
			end

			if 1.02759986349071 < arg_175_1.time_ and arg_175_1.time_ <= 1.02759986349071 + arg_178_0 then
				local var_178_1 = arg_175_1.var_.effect2042

				if not arg_175_1.var_.effect2042 then
					var_178_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_178_1.name = "2042"
					arg_175_1.var_.effect2042 = var_178_1
				else
					var_178_1.transform:SetParent(var_178_9000)
				end

				var_178_1.transform.localPosition = Vector3.New(-5.06, -1.87, -0.29)
				var_178_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.13333333333333 < arg_175_1.time_ and arg_175_1.time_ <= 3.13333333333333 + arg_178_0 then
				if arg_175_1.var_.effect2042 then
					Object.Destroy(arg_175_1.var_.effect2042)

					arg_175_1.var_.effect2042 = nil
				end
			end

			local var_178_4 = manager.ui.mainCamera.transform

			if 1.02759986349071 < arg_175_1.time_ and arg_175_1.time_ <= 1.02759986349071 + arg_178_0 then
				arg_175_1.var_.shakeOldPos = var_178_4.localPosition
			end

			local var_178_5 = 0.305733469842622

			if 1.02759986349071 <= arg_175_1.time_ and arg_175_1.time_ < 1.02759986349071 + var_178_5 then
				local var_178_6, var_178_7 = math.modf((arg_175_1.time_ - 1.02759986349071) / 0.066)

				var_178_4.localPosition = Vector3.New(var_178_7 * 0.13, var_178_7 * 0.13, var_178_7 * 0.13) + arg_175_1.var_.shakeOldPos
			end

			if arg_175_1.time_ >= 1.02759986349071 + var_178_5 and arg_175_1.time_ < 1.02759986349071 + var_178_5 + arg_178_0 then
				var_178_4.localPosition = arg_175_1.var_.shakeOldPos
			end

			local var_178_8 = arg_175_1.bgs_.MS2203.transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPosMS2203 = var_178_8.localPosition
			end

			local var_178_9 = 1.02759986349071

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_9 then
				var_178_8.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPosMS2203, Vector3.New(-1, 0.45, 8), (arg_175_1.time_ - 0) / var_178_9)
			end

			if arg_175_1.time_ >= 0 + var_178_9 and arg_175_1.time_ < 0 + var_178_9 + arg_178_0 then
				var_178_8.localPosition = Vector3.New(-1, 0.45, 8)
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_10 = 1.8
			local var_178_11 = 1.3

			if 1.8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_12 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_12:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_13 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(322122042).content)

				arg_175_1.text_.text = var_178_13

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_15 = 52 <= 0 and var_178_11 or var_178_11 * (utf8.len(var_178_13) / 52)

				if (52 <= 0 and var_178_11 or var_178_11 * (utf8.len(var_178_13) / 52)) > 0 and var_178_11 < var_178_15 then
					arg_175_1.talkMaxDuration = var_178_15
					var_178_10 = var_178_10 + 0.3

					if var_178_15 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_10
					end
				end

				arg_175_1.text_.text = var_178_13
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = var_178_10 + 0.3
			local var_178_17 = math.max(var_178_11, arg_175_1.talkMaxDuration)

			if var_178_10 + 0.3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_16) / var_178_17

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2203",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.02759986349071,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(-1, 0.45, 8),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play322122043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 322122043
		arg_181_1.duration_ = 2.2

		local var_181_0 = {
			zh = 2.2,
			ja = 2.149999999999
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play322122044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.15

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(322122043)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 6 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 6)

				if (6 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 6)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122043", "story_v_out_322122.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122043", "story_v_out_322122.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_322122", "322122043", "story_v_out_322122.awb")

						arg_181_1:RecordAudio("322122043", var_184_6)
						arg_181_1:RecordAudio("322122043", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_322122", "322122043", "story_v_out_322122.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_322122", "322122043", "story_v_out_322122.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play322122044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 322122044
		arg_185_1.duration_ = 7.53

		local var_185_0 = {
			zh = 5.8,
			ja = 7.533
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
			arg_185_1.auto_ = false
		end

		function arg_185_1.playNext_(arg_187_0)
			arg_185_1.onStoryFinished_()
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.5

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(322122044)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 20 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 20)

				if (20 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 20)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322122", "322122044", "story_v_out_322122.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_322122", "322122044", "story_v_out_322122.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_322122", "322122044", "story_v_out_322122.awb")

						arg_185_1:RecordAudio("322122044", var_188_6)
						arg_185_1:RecordAudio("322122044", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_322122", "322122044", "story_v_out_322122.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_322122", "322122044", "story_v_out_322122.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/MS2201",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L14f",
		"TextureConfig/Background/MS2203"
	},
	voices = {
		"story_v_out_322122.awb"
	}
}
