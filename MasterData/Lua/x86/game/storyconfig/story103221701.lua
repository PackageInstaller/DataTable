return {
	Play322171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322171001
		arg_1_1.duration_ = 3.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L09g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L09g")
				var_4_0.name = "L09g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L09g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L09g

				arg_1_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L09g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.124999999999 and arg_1_1.time_ < var_4_4 + 0.124999999999 + arg_4_0 then
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
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_dark_L09", "")
			end

			if 0.41 < arg_1_1.time_ and arg_1_1.time_ <= 0.41 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "init_story", "bgm_activity_4_5_story_serious.awb")

				local var_4_18 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_story")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 1.999999999999
			local var_4_20 = 0.125

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_22 = arg_1_1:GetWordFromCfg(322171001)
				local var_4_23 = arg_1_1:FormatText(var_4_22.content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 5 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 5)

				if (5 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 5)) > 0 and var_4_20 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_19 = var_4_19 + 0.3

					if var_4_25 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171001", "story_v_out_322171.awb") ~= 0 then
					local var_4_26 = manager.audio:GetVoiceLength("story_v_out_322171", "322171001", "story_v_out_322171.awb") / 1000

					if var_4_26 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_19
					end

					if var_4_22.prefab_name ~= "" and arg_1_1.actors_[var_4_22.prefab_name] ~= nil then
						local var_4_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_22.prefab_name].transform, "story_v_out_322171", "322171001", "story_v_out_322171.awb")

						arg_1_1:RecordAudio("322171001", var_4_27)
						arg_1_1:RecordAudio("322171001", var_4_27)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322171", "322171001", "story_v_out_322171.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322171", "322171001", "story_v_out_322171.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_28 = var_4_19 + 0.3
			local var_4_29 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_28) / var_4_29

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322171002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322171002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322171003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 1.125

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_1 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(322171002).content)

				arg_10_1.text_.text = var_13_1

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_3 = 45 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_1) / 45)

				if (45 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_1) / 45)) > 0 and var_13_0 < var_13_3 then
					arg_10_1.talkMaxDuration = var_13_3

					if var_13_3 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_3 + 0
					end
				end

				arg_10_1.text_.text = var_13_1
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_4 = math.max(var_13_0, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_4 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - 0) / var_13_4

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_4 and arg_10_1.time_ < 0 + var_13_4 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play322171003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322171003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322171004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 1.5

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_1 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(322171003).content)

				arg_14_1.text_.text = var_17_1

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_3 = 60 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 60)

				if (60 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 60)) > 0 and var_17_0 < var_17_3 then
					arg_14_1.talkMaxDuration = var_17_3

					if var_17_3 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_3 + 0
					end
				end

				arg_14_1.text_.text = var_17_1
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_4 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_4

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play322171004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322171004
		arg_18_1.duration_ = 4.4

		local var_18_0 = {
			zh = 4.4,
			ja = 3.833
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
				arg_18_0:Play322171005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if arg_18_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_21_0 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_18_1.stage_.transform)

				var_21_0.name = "1111ui_story"
				var_21_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.actors_["1111ui_story"] = var_21_0

				local var_21_1 = var_21_0:GetComponentInChildren(typeof(CharacterEffect))

				var_21_1.enabled = true

				local var_21_2 = GameObjectTools.GetOrAddComponent(var_21_0, typeof(DynamicBoneHelper))

				if var_21_2 then
					var_21_2:EnableDynamicBone(false)
				end

				arg_18_1:ShowWeapon(var_21_1.transform, false)

				arg_18_1.var_["1111ui_story" .. "Animator"] = var_21_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_18_1.var_["1111ui_story" .. "Animator"].applyRootMotion = true
				arg_18_1.var_["1111ui_story" .. "LipSync"] = var_21_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_21_3 = arg_18_1.actors_["1111ui_story"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos1111ui_story = var_21_3.localPosition
			end

			local var_21_4 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				var_21_3.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_18_1.time_ - 0) / var_21_4)
				var_21_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_3.position).x, (manager.ui.mainCamera.transform.position - var_21_3.position).y, (manager.ui.mainCamera.transform.position - var_21_3.position).z)
				var_21_3.localEulerAngles.z = 0
				var_21_3.localEulerAngles.x = 0
				var_21_3.localEulerAngles = var_21_3.localEulerAngles
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				var_21_3.localPosition = Vector3.New(0, -0.87, -5.7)
				var_21_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_3.position).x, (manager.ui.mainCamera.transform.position - var_21_3.position).y, (manager.ui.mainCamera.transform.position - var_21_3.position).z)
				var_21_3.localEulerAngles.z = 0
				var_21_3.localEulerAngles.x = 0
				var_21_3.localEulerAngles = var_21_3.localEulerAngles
			end

			local var_21_5 = arg_18_1.actors_["1111ui_story"]

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(var_21_5) and arg_18_1.var_.characterEffect1111ui_story == nil then
				arg_18_1.var_.characterEffect1111ui_story = var_21_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_6 = 0.200000002980232

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_6 and not isNil(var_21_5) then
				if arg_18_1.var_.characterEffect1111ui_story and not isNil(var_21_5) then
					arg_18_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 0 + var_21_6 and arg_18_1.time_ < 0 + var_21_6 + arg_21_0 and not isNil(var_21_5) and arg_18_1.var_.characterEffect1111ui_story then
				arg_18_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_21_8 = 0
			local var_21_9 = 0.525

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_10 = arg_18_1:GetWordFromCfg(322171004)
				local var_21_11 = arg_18_1:FormatText(var_21_10.content)

				arg_18_1.text_.text = var_21_11

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_13 = 21 <= 0 and var_21_9 or var_21_9 * (utf8.len(var_21_11) / 21)

				if (21 <= 0 and var_21_9 or var_21_9 * (utf8.len(var_21_11) / 21)) > 0 and var_21_9 < var_21_13 then
					arg_18_1.talkMaxDuration = var_21_13

					if var_21_13 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_13 + var_21_8
					end
				end

				arg_18_1.text_.text = var_21_11
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171004", "story_v_out_322171.awb") ~= 0 then
					local var_21_14 = manager.audio:GetVoiceLength("story_v_out_322171", "322171004", "story_v_out_322171.awb") / 1000

					if var_21_14 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_14 + var_21_8
					end

					if var_21_10.prefab_name ~= "" and arg_18_1.actors_[var_21_10.prefab_name] ~= nil then
						local var_21_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_10.prefab_name].transform, "story_v_out_322171", "322171004", "story_v_out_322171.awb")

						arg_18_1:RecordAudio("322171004", var_21_15)
						arg_18_1:RecordAudio("322171004", var_21_15)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_322171", "322171004", "story_v_out_322171.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_322171", "322171004", "story_v_out_322171.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_16 = math.max(var_21_9, arg_18_1.talkMaxDuration)

			if var_21_8 <= arg_18_1.time_ and arg_18_1.time_ < var_21_8 + var_21_16 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_8) / var_21_16

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_8 + var_21_16 and arg_18_1.time_ < var_21_8 + var_21_16 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play322171005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322171005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322171006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1111ui_story = arg_22_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_25_0 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 then
				arg_22_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_22_1.time_ - 0) / var_25_0)
				arg_22_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_22_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1111ui_story"].transform.position).z)
				arg_22_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_22_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_22_1.actors_["1111ui_story"].transform.localEulerAngles = arg_22_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 then
				arg_22_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_22_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_22_1.actors_["1111ui_story"].transform.position).z)
				arg_22_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_22_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_22_1.actors_["1111ui_story"].transform.localEulerAngles = arg_22_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_25_1 = 0
			local var_25_2 = 1.725

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_3 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(322171005).content)

				arg_22_1.text_.text = var_25_3

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 69 <= 0 and var_25_2 or var_25_2 * (utf8.len(var_25_3) / 69)

				if (69 <= 0 and var_25_2 or var_25_2 * (utf8.len(var_25_3) / 69)) > 0 and var_25_2 < var_25_5 then
					arg_22_1.talkMaxDuration = var_25_5

					if var_25_5 + var_25_1 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + var_25_1
					end
				end

				arg_22_1.text_.text = var_25_3
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_6 = math.max(var_25_2, arg_22_1.talkMaxDuration)

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_6 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_1) / var_25_6

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_1 + var_25_6 and arg_22_1.time_ < var_25_1 + var_25_6 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play322171006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 322171006
		arg_26_1.duration_ = 12.53

		local var_26_0 = {
			zh = 8.133,
			ja = 12.533
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play322171007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos1111ui_story = arg_26_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_29_0 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 then
				arg_26_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_26_1.time_ - 0) / var_29_0)
				arg_26_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_26_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1111ui_story"].transform.position).z)
				arg_26_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_26_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_26_1.actors_["1111ui_story"].transform.localEulerAngles = arg_26_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 then
				arg_26_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_26_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_26_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["1111ui_story"].transform.position).z)
				arg_26_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_26_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_26_1.actors_["1111ui_story"].transform.localEulerAngles = arg_26_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_29_1 = arg_26_1.actors_["1111ui_story"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_1) and arg_26_1.var_.characterEffect1111ui_story == nil then
				arg_26_1.var_.characterEffect1111ui_story = var_29_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_2 and not isNil(var_29_1) then
				if arg_26_1.var_.characterEffect1111ui_story and not isNil(var_29_1) then
					arg_26_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_2 and arg_26_1.time_ < 0 + var_29_2 + arg_29_0 and not isNil(var_29_1) and arg_26_1.var_.characterEffect1111ui_story then
				arg_26_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_29_4 = 0
			local var_29_5 = 0.85

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_6 = arg_26_1:GetWordFromCfg(322171006)
				local var_29_7 = arg_26_1:FormatText(var_29_6.content)

				arg_26_1.text_.text = var_29_7

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_9 = 34 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 34)

				if (34 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 34)) > 0 and var_29_5 < var_29_9 then
					arg_26_1.talkMaxDuration = var_29_9

					if var_29_9 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_9 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_7
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171006", "story_v_out_322171.awb") ~= 0 then
					local var_29_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171006", "story_v_out_322171.awb") / 1000

					if var_29_10 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_4
					end

					if var_29_6.prefab_name ~= "" and arg_26_1.actors_[var_29_6.prefab_name] ~= nil then
						local var_29_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_6.prefab_name].transform, "story_v_out_322171", "322171006", "story_v_out_322171.awb")

						arg_26_1:RecordAudio("322171006", var_29_11)
						arg_26_1:RecordAudio("322171006", var_29_11)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_322171", "322171006", "story_v_out_322171.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_322171", "322171006", "story_v_out_322171.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_12 = math.max(var_29_5, arg_26_1.talkMaxDuration)

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_12 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_4) / var_29_12

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_4 + var_29_12 and arg_26_1.time_ < var_29_4 + var_29_12 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play322171007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 322171007
		arg_30_1.duration_ = 4.53

		local var_30_0 = {
			zh = 3.633,
			ja = 4.533
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
				arg_30_0:Play322171008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos1111ui_story = arg_30_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_33_0 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 then
				arg_30_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_30_1.time_ - 0) / var_33_0)
				arg_30_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_30_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1111ui_story"].transform.position).z)
				arg_30_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_30_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_30_1.actors_["1111ui_story"].transform.localEulerAngles = arg_30_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 then
				arg_30_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_30_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_30_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1111ui_story"].transform.position).z)
				arg_30_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_30_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_30_1.actors_["1111ui_story"].transform.localEulerAngles = arg_30_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_33_1 = "10131ui_story"

			if arg_30_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_33_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_30_1.stage_.transform)

				var_33_2.name = var_33_1
				var_33_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.actors_[var_33_1] = var_33_2

				local var_33_3 = var_33_2:GetComponentInChildren(typeof(CharacterEffect))

				var_33_3.enabled = true

				local var_33_4 = GameObjectTools.GetOrAddComponent(var_33_2, typeof(DynamicBoneHelper))

				if var_33_4 then
					var_33_4:EnableDynamicBone(false)
				end

				arg_30_1:ShowWeapon(var_33_3.transform, false)

				arg_30_1.var_[var_33_1 .. "Animator"] = var_33_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_30_1.var_[var_33_1 .. "Animator"].applyRootMotion = true
				arg_30_1.var_[var_33_1 .. "LipSync"] = var_33_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_33_5 = arg_30_1.actors_["10131ui_story"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos10131ui_story = var_33_5.localPosition
			end

			local var_33_6 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_6 then
				var_33_5.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_30_1.time_ - 0) / var_33_6)
				var_33_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_33_5.position).x, (manager.ui.mainCamera.transform.position - var_33_5.position).y, (manager.ui.mainCamera.transform.position - var_33_5.position).z)
				var_33_5.localEulerAngles.z = 0
				var_33_5.localEulerAngles.x = 0
				var_33_5.localEulerAngles = var_33_5.localEulerAngles
			end

			if arg_30_1.time_ >= 0 + var_33_6 and arg_30_1.time_ < 0 + var_33_6 + arg_33_0 then
				var_33_5.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_33_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_33_5.position).x, (manager.ui.mainCamera.transform.position - var_33_5.position).y, (manager.ui.mainCamera.transform.position - var_33_5.position).z)
				var_33_5.localEulerAngles.z = 0
				var_33_5.localEulerAngles.x = 0
				var_33_5.localEulerAngles = var_33_5.localEulerAngles
			end

			local var_33_7 = arg_30_1.actors_["10131ui_story"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_7) and arg_30_1.var_.characterEffect10131ui_story == nil then
				arg_30_1.var_.characterEffect10131ui_story = var_33_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_8 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_8 and not isNil(var_33_7) then
				if arg_30_1.var_.characterEffect10131ui_story and not isNil(var_33_7) then
					arg_30_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_8 and arg_30_1.time_ < 0 + var_33_8 + arg_33_0 and not isNil(var_33_7) and arg_30_1.var_.characterEffect10131ui_story then
				arg_30_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_33_10 = arg_30_1.actors_["1111ui_story"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_10) and arg_30_1.var_.characterEffect1111ui_story == nil then
				arg_30_1.var_.characterEffect1111ui_story = var_33_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_11 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_11 and not isNil(var_33_10) then
				if arg_30_1.var_.characterEffect1111ui_story and not isNil(var_33_10) then
					arg_30_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_30_1.time_ - 0) / var_33_11)
				end
			end

			if arg_30_1.time_ >= 0 + var_33_11 and arg_30_1.time_ < 0 + var_33_11 + arg_33_0 and not isNil(var_33_10) and arg_30_1.var_.characterEffect1111ui_story then
				arg_30_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_33_12 = 0
			local var_33_13 = 0.325

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_12 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_14 = arg_30_1:GetWordFromCfg(322171007)
				local var_33_15 = arg_30_1:FormatText(var_33_14.content)

				arg_30_1.text_.text = var_33_15

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_17 = 13 <= 0 and var_33_13 or var_33_13 * (utf8.len(var_33_15) / 13)

				if (13 <= 0 and var_33_13 or var_33_13 * (utf8.len(var_33_15) / 13)) > 0 and var_33_13 < var_33_17 then
					arg_30_1.talkMaxDuration = var_33_17

					if var_33_17 + var_33_12 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_17 + var_33_12
					end
				end

				arg_30_1.text_.text = var_33_15
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171007", "story_v_out_322171.awb") ~= 0 then
					local var_33_18 = manager.audio:GetVoiceLength("story_v_out_322171", "322171007", "story_v_out_322171.awb") / 1000

					if var_33_18 + var_33_12 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_18 + var_33_12
					end

					if var_33_14.prefab_name ~= "" and arg_30_1.actors_[var_33_14.prefab_name] ~= nil then
						local var_33_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_14.prefab_name].transform, "story_v_out_322171", "322171007", "story_v_out_322171.awb")

						arg_30_1:RecordAudio("322171007", var_33_19)
						arg_30_1:RecordAudio("322171007", var_33_19)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_322171", "322171007", "story_v_out_322171.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_322171", "322171007", "story_v_out_322171.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_20 = math.max(var_33_13, arg_30_1.talkMaxDuration)

			if var_33_12 <= arg_30_1.time_ and arg_30_1.time_ < var_33_12 + var_33_20 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_12) / var_33_20

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_12 + var_33_20 and arg_30_1.time_ < var_33_12 + var_33_20 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play322171008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 322171008
		arg_34_1.duration_ = 6.97

		local var_34_0 = {
			zh = 5.6,
			ja = 6.966
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play322171009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1111ui_story"]) and arg_34_1.var_.characterEffect1111ui_story == nil then
				arg_34_1.var_.characterEffect1111ui_story = arg_34_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_0 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1111ui_story"]) then
				if arg_34_1.var_.characterEffect1111ui_story and not isNil(arg_34_1.actors_["1111ui_story"]) then
					arg_34_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1111ui_story"]) and arg_34_1.var_.characterEffect1111ui_story then
				arg_34_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_37_2 = arg_34_1.actors_["10131ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.characterEffect10131ui_story == nil then
				arg_34_1.var_.characterEffect10131ui_story = var_37_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_3 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_3 and not isNil(var_37_2) then
				if arg_34_1.var_.characterEffect10131ui_story and not isNil(var_37_2) then
					arg_34_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_34_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_3)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_3 and arg_34_1.time_ < 0 + var_37_3 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.characterEffect10131ui_story then
				arg_34_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_34_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_37_4 = 0
			local var_37_5 = 0.7

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_6 = arg_34_1:GetWordFromCfg(322171008)
				local var_37_7 = arg_34_1:FormatText(var_37_6.content)

				arg_34_1.text_.text = var_37_7

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_9 = 28 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 28)

				if (28 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 28)) > 0 and var_37_5 < var_37_9 then
					arg_34_1.talkMaxDuration = var_37_9

					if var_37_9 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_4
					end
				end

				arg_34_1.text_.text = var_37_7
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171008", "story_v_out_322171.awb") ~= 0 then
					local var_37_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171008", "story_v_out_322171.awb") / 1000

					if var_37_10 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_4
					end

					if var_37_6.prefab_name ~= "" and arg_34_1.actors_[var_37_6.prefab_name] ~= nil then
						local var_37_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_6.prefab_name].transform, "story_v_out_322171", "322171008", "story_v_out_322171.awb")

						arg_34_1:RecordAudio("322171008", var_37_11)
						arg_34_1:RecordAudio("322171008", var_37_11)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_322171", "322171008", "story_v_out_322171.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_322171", "322171008", "story_v_out_322171.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_12 = math.max(var_37_5, arg_34_1.talkMaxDuration)

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_12 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_4) / var_37_12

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_4 + var_37_12 and arg_34_1.time_ < var_37_4 + var_37_12 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play322171009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 322171009
		arg_38_1.duration_ = 2.33

		local var_38_0 = {
			zh = 2.133,
			ja = 2.333
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play322171010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10131ui_story"]) and arg_38_1.var_.characterEffect10131ui_story == nil then
				arg_38_1.var_.characterEffect10131ui_story = arg_38_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10131ui_story"]) then
				if arg_38_1.var_.characterEffect10131ui_story and not isNil(arg_38_1.actors_["10131ui_story"]) then
					arg_38_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10131ui_story"]) and arg_38_1.var_.characterEffect10131ui_story then
				arg_38_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_41_2 = arg_38_1.actors_["1111ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1111ui_story == nil then
				arg_38_1.var_.characterEffect1111ui_story = var_41_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_3 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 and not isNil(var_41_2) then
				if arg_38_1.var_.characterEffect1111ui_story and not isNil(var_41_2) then
					arg_38_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_3)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1111ui_story then
				arg_38_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_41_4 = 0
			local var_41_5 = 0.225

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_6 = arg_38_1:GetWordFromCfg(322171009)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 9 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 9)

				if (9 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 9)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171009", "story_v_out_322171.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171009", "story_v_out_322171.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_322171", "322171009", "story_v_out_322171.awb")

						arg_38_1:RecordAudio("322171009", var_41_11)
						arg_38_1:RecordAudio("322171009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_322171", "322171009", "story_v_out_322171.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_322171", "322171009", "story_v_out_322171.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_12 = math.max(var_41_5, arg_38_1.talkMaxDuration)

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_12 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_4) / var_41_12

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_4 + var_41_12 and arg_38_1.time_ < var_41_4 + var_41_12 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play322171010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 322171010
		arg_42_1.duration_ = 11.63

		local var_42_0 = {
			zh = 9.233,
			ja = 11.633
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
				arg_42_0:Play322171011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1111ui_story"]) and arg_42_1.var_.characterEffect1111ui_story == nil then
				arg_42_1.var_.characterEffect1111ui_story = arg_42_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1111ui_story"]) then
				if arg_42_1.var_.characterEffect1111ui_story and not isNil(arg_42_1.actors_["1111ui_story"]) then
					arg_42_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1111ui_story"]) and arg_42_1.var_.characterEffect1111ui_story then
				arg_42_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_45_2 = arg_42_1.actors_["10131ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.characterEffect10131ui_story == nil then
				arg_42_1.var_.characterEffect10131ui_story = var_45_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_3 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_3 and not isNil(var_45_2) then
				if arg_42_1.var_.characterEffect10131ui_story and not isNil(var_45_2) then
					arg_42_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_3)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_3 and arg_42_1.time_ < 0 + var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.characterEffect10131ui_story then
				arg_42_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_45_4 = 0
			local var_45_5 = 1

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_6 = arg_42_1:GetWordFromCfg(322171010)
				local var_45_7 = arg_42_1:FormatText(var_45_6.content)

				arg_42_1.text_.text = var_45_7

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_9 = 40 <= 0 and var_45_5 or var_45_5 * (utf8.len(var_45_7) / 40)

				if (40 <= 0 and var_45_5 or var_45_5 * (utf8.len(var_45_7) / 40)) > 0 and var_45_5 < var_45_9 then
					arg_42_1.talkMaxDuration = var_45_9

					if var_45_9 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_9 + var_45_4
					end
				end

				arg_42_1.text_.text = var_45_7
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171010", "story_v_out_322171.awb") ~= 0 then
					local var_45_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171010", "story_v_out_322171.awb") / 1000

					if var_45_10 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_4
					end

					if var_45_6.prefab_name ~= "" and arg_42_1.actors_[var_45_6.prefab_name] ~= nil then
						local var_45_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_6.prefab_name].transform, "story_v_out_322171", "322171010", "story_v_out_322171.awb")

						arg_42_1:RecordAudio("322171010", var_45_11)
						arg_42_1:RecordAudio("322171010", var_45_11)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_322171", "322171010", "story_v_out_322171.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_322171", "322171010", "story_v_out_322171.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_12 = math.max(var_45_5, arg_42_1.talkMaxDuration)

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_12 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_4) / var_45_12

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_4 + var_45_12 and arg_42_1.time_ < var_45_4 + var_45_12 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play322171011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 322171011
		arg_46_1.duration_ = 3

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play322171012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1111ui_story = arg_46_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_49_0 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 then
				arg_46_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_46_1.time_ - 0) / var_49_0)
				arg_46_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1111ui_story"].transform.position).z)
				arg_46_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1111ui_story"].transform.localEulerAngles = arg_46_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 then
				arg_46_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1111ui_story"].transform.position).z)
				arg_46_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1111ui_story"].transform.localEulerAngles = arg_46_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_49_1 = arg_46_1.actors_["10131ui_story"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos10131ui_story = var_49_1.localPosition
			end

			local var_49_2 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_2 then
				var_49_1.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_46_1.time_ - 0) / var_49_2)
				var_49_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_1.position).x, (manager.ui.mainCamera.transform.position - var_49_1.position).y, (manager.ui.mainCamera.transform.position - var_49_1.position).z)
				var_49_1.localEulerAngles.z = 0
				var_49_1.localEulerAngles.x = 0
				var_49_1.localEulerAngles = var_49_1.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_2 and arg_46_1.time_ < 0 + var_49_2 + arg_49_0 then
				var_49_1.localPosition = Vector3.New(0, 100, 0)
				var_49_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_1.position).x, (manager.ui.mainCamera.transform.position - var_49_1.position).y, (manager.ui.mainCamera.transform.position - var_49_1.position).z)
				var_49_1.localEulerAngles.z = 0
				var_49_1.localEulerAngles.x = 0
				var_49_1.localEulerAngles = var_49_1.localEulerAngles
			end

			local var_49_3 = "STblack"

			if arg_46_1.bgs_.STblack == nil then
				local var_49_4 = Object.Instantiate(arg_46_1.paintGo_)

				var_49_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_49_3)
				var_49_4.name = var_49_3
				var_49_4.transform.parent = arg_46_1.stage_.transform
				var_49_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.bgs_[var_49_3] = var_49_4
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				local var_49_5 = arg_46_1.bgs_.STblack

				arg_46_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_49_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_49_6 = var_49_5:GetComponent("SpriteRenderer")

				if var_49_6 and var_49_6.sprite then
					local var_49_7 = 2 * (var_49_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_49_5.transform.localScale = Vector3.New(var_49_7 / var_49_6.sprite.bounds.size.y < var_49_7 * manager.ui.mainCameraCom_.aspect / var_49_6.sprite.bounds.size.x and var_49_7 * manager.ui.mainCameraCom_.aspect / var_49_6.sprite.bounds.size.x or var_49_7 / var_49_6.sprite.bounds.size.y, var_49_7 / var_49_6.sprite.bounds.size.y < var_49_7 * manager.ui.mainCameraCom_.aspect / var_49_6.sprite.bounds.size.x and var_49_7 * manager.ui.mainCameraCom_.aspect / var_49_6.sprite.bounds.size.x or var_49_7 / var_49_6.sprite.bounds.size.y, 0)
				end

				for iter_49_0, iter_49_1 in pairs(arg_46_1.bgs_) do
					if iter_49_0 ~= "STblack" then
						iter_49_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_49_8 = 0

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_9 = 1

			if var_49_8 <= arg_46_1.time_ and arg_46_1.time_ < var_49_8 + var_49_9 then
				local var_49_10 = Color.New(0, 0, 0)

				var_49_10.a = Mathf.Lerp(1, 0, (arg_46_1.time_ - var_49_8) / var_49_9)
				arg_46_1.mask_.color = var_49_10
			end

			if arg_46_1.time_ >= var_49_8 + var_49_9 and arg_46_1.time_ < var_49_8 + var_49_9 + arg_49_0 then
				local var_49_11 = Color.New(0, 0, 0)

				arg_46_1.mask_.enabled = false
				var_49_11.a = 0
				arg_46_1.mask_.color = var_49_11
			end

			local var_49_12 = 1
			local var_49_13 = manager.audio:GetVoiceLength("story_v_out_322171", "322171011", "story_v_out_322171.awb") / 1000

			if var_49_13 > 0 and 2 < var_49_13 and var_49_13 + var_49_12 > arg_46_1.duration_ then
				arg_46_1.duration_ = var_49_13 + var_49_12
			end

			if var_49_12 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 then
				arg_46_1:AudioAction("play", "voice", "story_v_out_322171", "322171011", "story_v_out_322171.awb")
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322171011,
				charCount = 8,
				enableLayoutChange = true,
				duration = 0.533333333333333,
				groupID = "10111",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = false,
				contentID = 419162,
				charCount = 2,
				enableLayoutChange = true,
				duration = 1,
				groupID = "1",
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
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				}
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play322171012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 322171012
		arg_50_1.duration_ = 4.5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play322171013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 3.5 < arg_50_1.time_ and arg_50_1.time_ <= 3.5 + arg_53_0 then
				arg_50_1:AudioAction("play", "effect", "se_story_145", "se_story_145_stone", "")
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322171012,
				charCount = 59,
				enableLayoutChange = true,
				duration = 3.93333333333333,
				groupID = "10121",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "10111",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play322171013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 322171013
		arg_54_1.duration_ = 12.6

		local var_54_0 = {
			zh = 12.6,
			ja = 10.6
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play322171014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_0 = 1

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				local var_57_1 = Color.New(0, 0, 0)

				var_57_1.a = Mathf.Lerp(0, 1, (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.mask_.color = var_57_1
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				local var_57_2 = Color.New(0, 0, 0)

				var_57_2.a = 1
				arg_54_1.mask_.color = var_57_2
			end

			local var_57_3 = 0.999999999999

			if 0.999999999999 < arg_54_1.time_ and arg_54_1.time_ <= var_57_3 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = true

				arg_54_1:SetGaussion(false)
			end

			local var_57_4 = 1

			if var_57_3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_3 + var_57_4 then
				local var_57_5 = Color.New(0, 0, 0)

				var_57_5.a = Mathf.Lerp(1, 0, (arg_54_1.time_ - var_57_3) / var_57_4)
				arg_54_1.mask_.color = var_57_5
			end

			if arg_54_1.time_ >= var_57_3 + var_57_4 and arg_54_1.time_ < var_57_3 + var_57_4 + arg_57_0 then
				local var_57_6 = Color.New(0, 0, 0)

				arg_54_1.mask_.enabled = false
				var_57_6.a = 0
				arg_54_1.mask_.color = var_57_6
			end

			if 0.999999999999 < arg_54_1.time_ and arg_54_1.time_ <= 0.999999999999 + arg_57_0 then
				local var_57_7 = arg_54_1.bgs_.L09g

				arg_54_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_57_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_8 = var_57_7:GetComponent("SpriteRenderer")

				if var_57_8 and var_57_8.sprite then
					local var_57_9 = 2 * (var_57_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_57_7.transform.localScale = Vector3.New(var_57_9 / var_57_8.sprite.bounds.size.y < var_57_9 * manager.ui.mainCameraCom_.aspect / var_57_8.sprite.bounds.size.x and var_57_9 * manager.ui.mainCameraCom_.aspect / var_57_8.sprite.bounds.size.x or var_57_9 / var_57_8.sprite.bounds.size.y, var_57_9 / var_57_8.sprite.bounds.size.y < var_57_9 * manager.ui.mainCameraCom_.aspect / var_57_8.sprite.bounds.size.x and var_57_9 * manager.ui.mainCameraCom_.aspect / var_57_8.sprite.bounds.size.x or var_57_9 / var_57_8.sprite.bounds.size.y, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "L09g" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_10 = arg_54_1.actors_["1111ui_story"].transform

			if 1 < arg_54_1.time_ and arg_54_1.time_ <= 1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1111ui_story = var_57_10.localPosition
			end

			local var_57_11 = 0.001

			if 1 <= arg_54_1.time_ and arg_54_1.time_ < 1 + var_57_11 then
				var_57_10.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_54_1.time_ - 1) / var_57_11)
				var_57_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_10.position).x, (manager.ui.mainCamera.transform.position - var_57_10.position).y, (manager.ui.mainCamera.transform.position - var_57_10.position).z)
				var_57_10.localEulerAngles.z = 0
				var_57_10.localEulerAngles.x = 0
				var_57_10.localEulerAngles = var_57_10.localEulerAngles
			end

			if arg_54_1.time_ >= 1 + var_57_11 and arg_54_1.time_ < 1 + var_57_11 + arg_57_0 then
				var_57_10.localPosition = Vector3.New(0, -0.87, -5.7)
				var_57_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_10.position).x, (manager.ui.mainCamera.transform.position - var_57_10.position).y, (manager.ui.mainCamera.transform.position - var_57_10.position).z)
				var_57_10.localEulerAngles.z = 0
				var_57_10.localEulerAngles.x = 0
				var_57_10.localEulerAngles = var_57_10.localEulerAngles
			end

			local var_57_12 = arg_54_1.actors_["1111ui_story"]

			if 1 < arg_54_1.time_ and arg_54_1.time_ <= 1 + arg_57_0 and not isNil(var_57_12) and arg_54_1.var_.characterEffect1111ui_story == nil then
				arg_54_1.var_.characterEffect1111ui_story = var_57_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_13 = 0.200000002980232

			if 1 <= arg_54_1.time_ and arg_54_1.time_ < 1 + var_57_13 and not isNil(var_57_12) then
				if arg_54_1.var_.characterEffect1111ui_story and not isNil(var_57_12) then
					arg_54_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 1 + var_57_13 and arg_54_1.time_ < 1 + var_57_13 + arg_57_0 and not isNil(var_57_12) and arg_54_1.var_.characterEffect1111ui_story then
				arg_54_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 1 < arg_54_1.time_ and arg_54_1.time_ <= 1 + arg_57_0 then
				arg_54_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 1 < arg_54_1.time_ and arg_54_1.time_ <= 1 + arg_57_0 then
				arg_54_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_57_15 = 1
			local var_57_16 = 1.4

			if 1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_17 = arg_54_1:GetWordFromCfg(322171013)
				local var_57_18 = arg_54_1:FormatText(var_57_17.content)

				arg_54_1.text_.text = var_57_18

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_20 = 56 <= 0 and var_57_16 or var_57_16 * (utf8.len(var_57_18) / 56)

				if (56 <= 0 and var_57_16 or var_57_16 * (utf8.len(var_57_18) / 56)) > 0 and var_57_16 < var_57_20 then
					arg_54_1.talkMaxDuration = var_57_20

					if var_57_20 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_20 + var_57_15
					end
				end

				arg_54_1.text_.text = var_57_18
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171013", "story_v_out_322171.awb") ~= 0 then
					local var_57_21 = manager.audio:GetVoiceLength("story_v_out_322171", "322171013", "story_v_out_322171.awb") / 1000

					if var_57_21 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_21 + var_57_15
					end

					if var_57_17.prefab_name ~= "" and arg_54_1.actors_[var_57_17.prefab_name] ~= nil then
						local var_57_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_17.prefab_name].transform, "story_v_out_322171", "322171013", "story_v_out_322171.awb")

						arg_54_1:RecordAudio("322171013", var_57_22)
						arg_54_1:RecordAudio("322171013", var_57_22)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_322171", "322171013", "story_v_out_322171.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_322171", "322171013", "story_v_out_322171.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_23 = math.max(var_57_16, arg_54_1.talkMaxDuration)

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_23 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_15) / var_57_23

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_15 + var_57_23 and arg_54_1.time_ < var_57_15 + var_57_23 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "1",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0.999999999999,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "10121",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0.999999999999,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play322171014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 322171014
		arg_58_1.duration_ = 2.73

		local var_58_0 = {
			zh = 1.999999999999,
			ja = 2.733
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
				arg_58_0:Play322171015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10131ui_story = arg_58_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_58_1.time_ - 0) / var_61_0)
				arg_58_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).z)
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles = arg_58_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_58_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["10131ui_story"].transform.position).z)
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["10131ui_story"].transform.localEulerAngles = arg_58_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_61_1 = arg_58_1.actors_["10131ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect10131ui_story == nil then
				arg_58_1.var_.characterEffect10131ui_story = var_61_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 and not isNil(var_61_1) then
				if arg_58_1.var_.characterEffect10131ui_story and not isNil(var_61_1) then
					arg_58_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect10131ui_story then
				arg_58_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_61_4 = arg_58_1.actors_["1111ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1111ui_story == nil then
				arg_58_1.var_.characterEffect1111ui_story = var_61_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_5 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_5 and not isNil(var_61_4) then
				if arg_58_1.var_.characterEffect1111ui_story and not isNil(var_61_4) then
					arg_58_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_5)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_5 and arg_58_1.time_ < 0 + var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1111ui_story then
				arg_58_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_61_6 = arg_58_1.actors_["1111ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1111ui_story = var_61_6.localPosition
			end

			local var_61_7 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				var_61_6.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_58_1.time_ - 0) / var_61_7)
				var_61_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_6.position).x, (manager.ui.mainCamera.transform.position - var_61_6.position).y, (manager.ui.mainCamera.transform.position - var_61_6.position).z)
				var_61_6.localEulerAngles.z = 0
				var_61_6.localEulerAngles.x = 0
				var_61_6.localEulerAngles = var_61_6.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				var_61_6.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_61_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_6.position).x, (manager.ui.mainCamera.transform.position - var_61_6.position).y, (manager.ui.mainCamera.transform.position - var_61_6.position).z)
				var_61_6.localEulerAngles.z = 0
				var_61_6.localEulerAngles.x = 0
				var_61_6.localEulerAngles = var_61_6.localEulerAngles
			end

			local var_61_8 = 0
			local var_61_9 = 0.1

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_10 = arg_58_1:GetWordFromCfg(322171014)
				local var_61_11 = arg_58_1:FormatText(var_61_10.content)

				arg_58_1.text_.text = var_61_11

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 4 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_11) / 4)

				if (4 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_11) / 4)) > 0 and var_61_9 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_8
					end
				end

				arg_58_1.text_.text = var_61_11
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171014", "story_v_out_322171.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_322171", "322171014", "story_v_out_322171.awb") / 1000

					if var_61_14 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_8
					end

					if var_61_10.prefab_name ~= "" and arg_58_1.actors_[var_61_10.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_10.prefab_name].transform, "story_v_out_322171", "322171014", "story_v_out_322171.awb")

						arg_58_1:RecordAudio("322171014", var_61_15)
						arg_58_1:RecordAudio("322171014", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_322171", "322171014", "story_v_out_322171.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_322171", "322171014", "story_v_out_322171.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_16 and arg_58_1.time_ < var_61_8 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play322171015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 322171015
		arg_62_1.duration_ = 5.53

		local var_62_0 = {
			zh = 4.366,
			ja = 5.533
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
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play322171016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1111ui_story"]) and arg_62_1.var_.characterEffect1111ui_story == nil then
				arg_62_1.var_.characterEffect1111ui_story = arg_62_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1111ui_story"]) then
				if arg_62_1.var_.characterEffect1111ui_story and not isNil(arg_62_1.actors_["1111ui_story"]) then
					arg_62_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1111ui_story"]) and arg_62_1.var_.characterEffect1111ui_story then
				arg_62_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_65_2 = arg_62_1.actors_["10131ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect10131ui_story == nil then
				arg_62_1.var_.characterEffect10131ui_story = var_65_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_3 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 and not isNil(var_65_2) then
				if arg_62_1.var_.characterEffect10131ui_story and not isNil(var_65_2) then
					arg_62_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_3)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect10131ui_story then
				arg_62_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_65_4 = 0
			local var_65_5 = 0.5

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_6 = arg_62_1:GetWordFromCfg(322171015)
				local var_65_7 = arg_62_1:FormatText(var_65_6.content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 20 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 20)

				if (20 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 20)) > 0 and var_65_5 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_4
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171015", "story_v_out_322171.awb") ~= 0 then
					local var_65_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171015", "story_v_out_322171.awb") / 1000

					if var_65_10 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_4
					end

					if var_65_6.prefab_name ~= "" and arg_62_1.actors_[var_65_6.prefab_name] ~= nil then
						local var_65_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_6.prefab_name].transform, "story_v_out_322171", "322171015", "story_v_out_322171.awb")

						arg_62_1:RecordAudio("322171015", var_65_11)
						arg_62_1:RecordAudio("322171015", var_65_11)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_322171", "322171015", "story_v_out_322171.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_322171", "322171015", "story_v_out_322171.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_5, arg_62_1.talkMaxDuration)

			if var_65_4 <= arg_62_1.time_ and arg_62_1.time_ < var_65_4 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_4) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_4 + var_65_12 and arg_62_1.time_ < var_65_4 + var_65_12 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play322171016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 322171016
		arg_66_1.duration_ = 4.6

		local var_66_0 = {
			zh = 3.966,
			ja = 4.6
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play322171017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10131ui_story"]) and arg_66_1.var_.characterEffect10131ui_story == nil then
				arg_66_1.var_.characterEffect10131ui_story = arg_66_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10131ui_story"]) then
				if arg_66_1.var_.characterEffect10131ui_story and not isNil(arg_66_1.actors_["10131ui_story"]) then
					arg_66_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10131ui_story"]) and arg_66_1.var_.characterEffect10131ui_story then
				arg_66_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_69_2 = arg_66_1.actors_["1111ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect1111ui_story == nil then
				arg_66_1.var_.characterEffect1111ui_story = var_69_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_3 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 and not isNil(var_69_2) then
				if arg_66_1.var_.characterEffect1111ui_story and not isNil(var_69_2) then
					arg_66_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_3)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect1111ui_story then
				arg_66_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_69_4 = 0
			local var_69_5 = 0.45

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(322171016)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 18 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 18)

				if (18 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 18)) > 0 and var_69_5 < var_69_9 then
					arg_66_1.talkMaxDuration = var_69_9

					if var_69_9 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171016", "story_v_out_322171.awb") ~= 0 then
					local var_69_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171016", "story_v_out_322171.awb") / 1000

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end

					if var_69_6.prefab_name ~= "" and arg_66_1.actors_[var_69_6.prefab_name] ~= nil then
						local var_69_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_6.prefab_name].transform, "story_v_out_322171", "322171016", "story_v_out_322171.awb")

						arg_66_1:RecordAudio("322171016", var_69_11)
						arg_66_1:RecordAudio("322171016", var_69_11)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_322171", "322171016", "story_v_out_322171.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_322171", "322171016", "story_v_out_322171.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_12 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_12 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_12

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_12 and arg_66_1.time_ < var_69_4 + var_69_12 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play322171017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 322171017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play322171018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["10131ui_story"]) and arg_70_1.var_.characterEffect10131ui_story == nil then
				arg_70_1.var_.characterEffect10131ui_story = arg_70_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["10131ui_story"]) then
				if arg_70_1.var_.characterEffect10131ui_story and not isNil(arg_70_1.actors_["10131ui_story"]) then
					arg_70_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10131ui_story"]) and arg_70_1.var_.characterEffect10131ui_story then
				arg_70_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_73_1 = arg_70_1.actors_["10131ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_1) and arg_70_1.var_.characterEffect10131ui_story == nil then
				arg_70_1.var_.characterEffect10131ui_story = var_73_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_2 and not isNil(var_73_1) then
				if arg_70_1.var_.characterEffect10131ui_story and not isNil(var_73_1) then
					arg_70_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_2)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_2 and arg_70_1.time_ < 0 + var_73_2 + arg_73_0 and not isNil(var_73_1) and arg_70_1.var_.characterEffect10131ui_story then
				arg_70_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_73_3 = 0
			local var_73_4 = 1.125

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_3 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_5 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(322171017).content)

				arg_70_1.text_.text = var_73_5

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_7 = 45 <= 0 and var_73_4 or var_73_4 * (utf8.len(var_73_5) / 45)

				if (45 <= 0 and var_73_4 or var_73_4 * (utf8.len(var_73_5) / 45)) > 0 and var_73_4 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_3 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_3
					end
				end

				arg_70_1.text_.text = var_73_5
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_8 = math.max(var_73_4, arg_70_1.talkMaxDuration)

			if var_73_3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_3 + var_73_8 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_3) / var_73_8

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_3 + var_73_8 and arg_70_1.time_ < var_73_3 + var_73_8 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play322171018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 322171018
		arg_74_1.duration_ = 10.1

		local var_74_0 = {
			zh = 7.166,
			ja = 10.1
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
				arg_74_0:Play322171019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1111ui_story = arg_74_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_77_0 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 then
				arg_74_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_74_1.time_ - 0) / var_77_0)
				arg_74_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1111ui_story"].transform.position).z)
				arg_74_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["1111ui_story"].transform.localEulerAngles = arg_74_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 then
				arg_74_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_74_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1111ui_story"].transform.position).z)
				arg_74_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["1111ui_story"].transform.localEulerAngles = arg_74_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_77_1 = arg_74_1.actors_["1111ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect1111ui_story == nil then
				arg_74_1.var_.characterEffect1111ui_story = var_77_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_2 and not isNil(var_77_1) then
				if arg_74_1.var_.characterEffect1111ui_story and not isNil(var_77_1) then
					arg_74_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_2 and arg_74_1.time_ < 0 + var_77_2 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect1111ui_story then
				arg_74_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_77_4 = 0
			local var_77_5 = 0.875

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_6 = arg_74_1:GetWordFromCfg(322171018)
				local var_77_7 = arg_74_1:FormatText(var_77_6.content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 35 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 35)

				if (35 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 35)) > 0 and var_77_5 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171018", "story_v_out_322171.awb") ~= 0 then
					local var_77_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171018", "story_v_out_322171.awb") / 1000

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end

					if var_77_6.prefab_name ~= "" and arg_74_1.actors_[var_77_6.prefab_name] ~= nil then
						local var_77_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_6.prefab_name].transform, "story_v_out_322171", "322171018", "story_v_out_322171.awb")

						arg_74_1:RecordAudio("322171018", var_77_11)
						arg_74_1:RecordAudio("322171018", var_77_11)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_322171", "322171018", "story_v_out_322171.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_322171", "322171018", "story_v_out_322171.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_12 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_12 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_12

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_12 and arg_74_1.time_ < var_77_4 + var_77_12 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play322171019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322171019
		arg_78_1.duration_ = 4.23

		local var_78_0 = {
			zh = 4.033,
			ja = 4.233
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play322171020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.4

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:GetWordFromCfg(322171019)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 16 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 16)

				if (16 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 16)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171019", "story_v_out_322171.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_322171", "322171019", "story_v_out_322171.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_322171", "322171019", "story_v_out_322171.awb")

						arg_78_1:RecordAudio("322171019", var_81_6)
						arg_78_1:RecordAudio("322171019", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322171", "322171019", "story_v_out_322171.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322171", "322171019", "story_v_out_322171.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play322171020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322171020
		arg_82_1.duration_ = 12.33

		local var_82_0 = {
			zh = 9.466,
			ja = 12.333
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play322171021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_85_0 = 0
			local var_85_1 = 1.1

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_2 = arg_82_1:GetWordFromCfg(322171020)
				local var_85_3 = arg_82_1:FormatText(var_85_2.content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 44 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 44)

				if (44 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 44)) > 0 and var_85_1 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171020", "story_v_out_322171.awb") ~= 0 then
					local var_85_6 = manager.audio:GetVoiceLength("story_v_out_322171", "322171020", "story_v_out_322171.awb") / 1000

					if var_85_6 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_0
					end

					if var_85_2.prefab_name ~= "" and arg_82_1.actors_[var_85_2.prefab_name] ~= nil then
						local var_85_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_2.prefab_name].transform, "story_v_out_322171", "322171020", "story_v_out_322171.awb")

						arg_82_1:RecordAudio("322171020", var_85_7)
						arg_82_1:RecordAudio("322171020", var_85_7)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322171", "322171020", "story_v_out_322171.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322171", "322171020", "story_v_out_322171.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play322171021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322171021
		arg_86_1.duration_ = 6.87

		local var_86_0 = {
			zh = 4.466,
			ja = 6.866
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play322171022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.525

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(322171021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 21 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 21)

				if (21 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 21)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171021", "story_v_out_322171.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_322171", "322171021", "story_v_out_322171.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_322171", "322171021", "story_v_out_322171.awb")

						arg_86_1:RecordAudio("322171021", var_89_6)
						arg_86_1:RecordAudio("322171021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322171", "322171021", "story_v_out_322171.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322171", "322171021", "story_v_out_322171.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play322171022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 322171022
		arg_90_1.duration_ = 8.7

		local var_90_0 = {
			zh = 7.633,
			ja = 8.7
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play322171023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["10131ui_story"]) and arg_90_1.var_.characterEffect10131ui_story == nil then
				arg_90_1.var_.characterEffect10131ui_story = arg_90_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["10131ui_story"]) then
				if arg_90_1.var_.characterEffect10131ui_story and not isNil(arg_90_1.actors_["10131ui_story"]) then
					arg_90_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10131ui_story"]) and arg_90_1.var_.characterEffect10131ui_story then
				arg_90_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_93_2 = arg_90_1.actors_["1111ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1111ui_story == nil then
				arg_90_1.var_.characterEffect1111ui_story = var_93_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_3 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.characterEffect1111ui_story and not isNil(var_93_2) then
					arg_90_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_3)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1111ui_story then
				arg_90_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_93_4 = arg_90_1.actors_["10131ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10131ui_story = var_93_4.localPosition
			end

			local var_93_5 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_5 then
				var_93_4.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_90_1.time_ - 0) / var_93_5)
				var_93_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_4.position).x, (manager.ui.mainCamera.transform.position - var_93_4.position).y, (manager.ui.mainCamera.transform.position - var_93_4.position).z)
				var_93_4.localEulerAngles.z = 0
				var_93_4.localEulerAngles.x = 0
				var_93_4.localEulerAngles = var_93_4.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_5 and arg_90_1.time_ < 0 + var_93_5 + arg_93_0 then
				var_93_4.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_93_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_4.position).x, (manager.ui.mainCamera.transform.position - var_93_4.position).y, (manager.ui.mainCamera.transform.position - var_93_4.position).z)
				var_93_4.localEulerAngles.z = 0
				var_93_4.localEulerAngles.x = 0
				var_93_4.localEulerAngles = var_93_4.localEulerAngles
			end

			local var_93_6 = arg_90_1.actors_["1111ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1111ui_story = var_93_6.localPosition
			end

			local var_93_7 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				var_93_6.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_90_1.time_ - 0) / var_93_7)
				var_93_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_6.position).x, (manager.ui.mainCamera.transform.position - var_93_6.position).y, (manager.ui.mainCamera.transform.position - var_93_6.position).z)
				var_93_6.localEulerAngles.z = 0
				var_93_6.localEulerAngles.x = 0
				var_93_6.localEulerAngles = var_93_6.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				var_93_6.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_93_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_6.position).x, (manager.ui.mainCamera.transform.position - var_93_6.position).y, (manager.ui.mainCamera.transform.position - var_93_6.position).z)
				var_93_6.localEulerAngles.z = 0
				var_93_6.localEulerAngles.x = 0
				var_93_6.localEulerAngles = var_93_6.localEulerAngles
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_93_8 = 0
			local var_93_9 = 0.85

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_10 = arg_90_1:GetWordFromCfg(322171022)
				local var_93_11 = arg_90_1:FormatText(var_93_10.content)

				arg_90_1.text_.text = var_93_11

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 34 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 34)

				if (34 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 34)) > 0 and var_93_9 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_11
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171022", "story_v_out_322171.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_322171", "322171022", "story_v_out_322171.awb") / 1000

					if var_93_14 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_8
					end

					if var_93_10.prefab_name ~= "" and arg_90_1.actors_[var_93_10.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_10.prefab_name].transform, "story_v_out_322171", "322171022", "story_v_out_322171.awb")

						arg_90_1:RecordAudio("322171022", var_93_15)
						arg_90_1:RecordAudio("322171022", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_322171", "322171022", "story_v_out_322171.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_322171", "322171022", "story_v_out_322171.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_16 and arg_90_1.time_ < var_93_8 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play322171023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 322171023
		arg_94_1.duration_ = 3.57

		local var_94_0 = {
			zh = 2.633,
			ja = 3.566
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play322171024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1111ui_story"]) and arg_94_1.var_.characterEffect1111ui_story == nil then
				arg_94_1.var_.characterEffect1111ui_story = arg_94_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1111ui_story"]) then
				if arg_94_1.var_.characterEffect1111ui_story and not isNil(arg_94_1.actors_["1111ui_story"]) then
					arg_94_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1111ui_story"]) and arg_94_1.var_.characterEffect1111ui_story then
				arg_94_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["10131ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect10131ui_story == nil then
				arg_94_1.var_.characterEffect10131ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect10131ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_94_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect10131ui_story then
				arg_94_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_94_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_97_4 = 0
			local var_97_5 = 0.375

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_6 = arg_94_1:GetWordFromCfg(322171023)
				local var_97_7 = arg_94_1:FormatText(var_97_6.content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 15 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 15)

				if (15 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 15)) > 0 and var_97_5 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171023", "story_v_out_322171.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171023", "story_v_out_322171.awb") / 1000

					if var_97_10 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_4
					end

					if var_97_6.prefab_name ~= "" and arg_94_1.actors_[var_97_6.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_6.prefab_name].transform, "story_v_out_322171", "322171023", "story_v_out_322171.awb")

						arg_94_1:RecordAudio("322171023", var_97_11)
						arg_94_1:RecordAudio("322171023", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_322171", "322171023", "story_v_out_322171.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_322171", "322171023", "story_v_out_322171.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_12 = math.max(var_97_5, arg_94_1.talkMaxDuration)

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_12 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_4) / var_97_12

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_4 + var_97_12 and arg_94_1.time_ < var_97_4 + var_97_12 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play322171024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 322171024
		arg_98_1.duration_ = 7.1

		local var_98_0 = {
			zh = 5.733,
			ja = 7.1
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play322171025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_101_0 = 0
			local var_101_1 = 0.7

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(322171024)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 28 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 28)

				if (28 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 28)) > 0 and var_101_1 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171024", "story_v_out_322171.awb") ~= 0 then
					local var_101_6 = manager.audio:GetVoiceLength("story_v_out_322171", "322171024", "story_v_out_322171.awb") / 1000

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end

					if var_101_2.prefab_name ~= "" and arg_98_1.actors_[var_101_2.prefab_name] ~= nil then
						local var_101_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_2.prefab_name].transform, "story_v_out_322171", "322171024", "story_v_out_322171.awb")

						arg_98_1:RecordAudio("322171024", var_101_7)
						arg_98_1:RecordAudio("322171024", var_101_7)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322171", "322171024", "story_v_out_322171.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322171", "322171024", "story_v_out_322171.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play322171025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 322171025
		arg_102_1.duration_ = 3.2

		local var_102_0 = {
			zh = 3.2,
			ja = 2.966
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play322171026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10131ui_story"]) and arg_102_1.var_.characterEffect10131ui_story == nil then
				arg_102_1.var_.characterEffect10131ui_story = arg_102_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10131ui_story"]) then
				if arg_102_1.var_.characterEffect10131ui_story and not isNil(arg_102_1.actors_["10131ui_story"]) then
					arg_102_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10131ui_story"]) and arg_102_1.var_.characterEffect10131ui_story then
				arg_102_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["1111ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect1111ui_story == nil then
				arg_102_1.var_.characterEffect1111ui_story = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect1111ui_story and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect1111ui_story then
				arg_102_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_105_4 = 0
			local var_105_5 = 0.2

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(322171025)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 8 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 8)

				if (8 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 8)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171025", "story_v_out_322171.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171025", "story_v_out_322171.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_322171", "322171025", "story_v_out_322171.awb")

						arg_102_1:RecordAudio("322171025", var_105_11)
						arg_102_1:RecordAudio("322171025", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_322171", "322171025", "story_v_out_322171.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_322171", "322171025", "story_v_out_322171.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play322171026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 322171026
		arg_106_1.duration_ = 4

		local var_106_0 = {
			zh = 3.3,
			ja = 4
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play322171027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1111ui_story"]) and arg_106_1.var_.characterEffect1111ui_story == nil then
				arg_106_1.var_.characterEffect1111ui_story = arg_106_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1111ui_story"]) then
				if arg_106_1.var_.characterEffect1111ui_story and not isNil(arg_106_1.actors_["1111ui_story"]) then
					arg_106_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1111ui_story"]) and arg_106_1.var_.characterEffect1111ui_story then
				arg_106_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_109_2 = arg_106_1.actors_["10131ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect10131ui_story == nil then
				arg_106_1.var_.characterEffect10131ui_story = var_109_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_3 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.characterEffect10131ui_story and not isNil(var_109_2) then
					arg_106_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_3)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect10131ui_story then
				arg_106_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_109_4 = 0
			local var_109_5 = 0.3

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(322171026)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 12 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 12)

				if (12 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 12)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171026", "story_v_out_322171.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171026", "story_v_out_322171.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_322171", "322171026", "story_v_out_322171.awb")

						arg_106_1:RecordAudio("322171026", var_109_11)
						arg_106_1:RecordAudio("322171026", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_322171", "322171026", "story_v_out_322171.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_322171", "322171026", "story_v_out_322171.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_12 and arg_106_1.time_ < var_109_4 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play322171027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 322171027
		arg_110_1.duration_ = 3.1

		local var_110_0 = {
			zh = 3.1,
			ja = 2.866
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play322171028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["10131ui_story"]) and arg_110_1.var_.characterEffect10131ui_story == nil then
				arg_110_1.var_.characterEffect10131ui_story = arg_110_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["10131ui_story"]) then
				if arg_110_1.var_.characterEffect10131ui_story and not isNil(arg_110_1.actors_["10131ui_story"]) then
					arg_110_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["10131ui_story"]) and arg_110_1.var_.characterEffect10131ui_story then
				arg_110_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_113_2 = arg_110_1.actors_["1111ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1111ui_story == nil then
				arg_110_1.var_.characterEffect1111ui_story = var_113_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_3 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.characterEffect1111ui_story and not isNil(var_113_2) then
					arg_110_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_3)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1111ui_story then
				arg_110_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_113_4 = 0
			local var_113_5 = 0.225

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(322171027)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 9 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 9)

				if (9 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 9)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171027", "story_v_out_322171.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171027", "story_v_out_322171.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_322171", "322171027", "story_v_out_322171.awb")

						arg_110_1:RecordAudio("322171027", var_113_11)
						arg_110_1:RecordAudio("322171027", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_322171", "322171027", "story_v_out_322171.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_322171", "322171027", "story_v_out_322171.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play322171028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 322171028
		arg_114_1.duration_ = 13.07

		local var_114_0 = {
			zh = 7.8,
			ja = 13.066
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play322171029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1111ui_story"]) and arg_114_1.var_.characterEffect1111ui_story == nil then
				arg_114_1.var_.characterEffect1111ui_story = arg_114_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1111ui_story"]) then
				if arg_114_1.var_.characterEffect1111ui_story and not isNil(arg_114_1.actors_["1111ui_story"]) then
					arg_114_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1111ui_story"]) and arg_114_1.var_.characterEffect1111ui_story then
				arg_114_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_117_2 = arg_114_1.actors_["10131ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect10131ui_story == nil then
				arg_114_1.var_.characterEffect10131ui_story = var_117_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_3 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.characterEffect10131ui_story and not isNil(var_117_2) then
					arg_114_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_114_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_3)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect10131ui_story then
				arg_114_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_114_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_117_4 = 0
			local var_117_5 = 0.925

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(322171028)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 37 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 37)

				if (37 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 37)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171028", "story_v_out_322171.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171028", "story_v_out_322171.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_322171", "322171028", "story_v_out_322171.awb")

						arg_114_1:RecordAudio("322171028", var_117_11)
						arg_114_1:RecordAudio("322171028", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_322171", "322171028", "story_v_out_322171.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_322171", "322171028", "story_v_out_322171.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play322171029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 322171029
		arg_118_1.duration_ = 6.07

		local var_118_0 = {
			zh = 4,
			ja = 6.066
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play322171030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.55

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:GetWordFromCfg(322171029)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 22 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 22)

				if (22 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 22)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171029", "story_v_out_322171.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_322171", "322171029", "story_v_out_322171.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_322171", "322171029", "story_v_out_322171.awb")

						arg_118_1:RecordAudio("322171029", var_121_6)
						arg_118_1:RecordAudio("322171029", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_322171", "322171029", "story_v_out_322171.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_322171", "322171029", "story_v_out_322171.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play322171030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 322171030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play322171031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1111ui_story = arg_122_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1111ui_story"].transform.position).z)
				arg_122_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1111ui_story"].transform.localEulerAngles = arg_122_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1111ui_story"].transform.position).z)
				arg_122_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1111ui_story"].transform.localEulerAngles = arg_122_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_125_1 = arg_122_1.actors_["10131ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos10131ui_story = var_125_1.localPosition
			end

			local var_125_2 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 then
				var_125_1.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_2)
				var_125_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_1.position).x, (manager.ui.mainCamera.transform.position - var_125_1.position).y, (manager.ui.mainCamera.transform.position - var_125_1.position).z)
				var_125_1.localEulerAngles.z = 0
				var_125_1.localEulerAngles.x = 0
				var_125_1.localEulerAngles = var_125_1.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 then
				var_125_1.localPosition = Vector3.New(0, 100, 0)
				var_125_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_1.position).x, (manager.ui.mainCamera.transform.position - var_125_1.position).y, (manager.ui.mainCamera.transform.position - var_125_1.position).z)
				var_125_1.localEulerAngles.z = 0
				var_125_1.localEulerAngles.x = 0
				var_125_1.localEulerAngles = var_125_1.localEulerAngles
			end

			if 0.1 < arg_122_1.time_ and arg_122_1.time_ <= 0.1 + arg_125_0 then
				arg_122_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep04", "")
			end

			local var_125_4 = 0
			local var_125_5 = 1.15

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(322171030).content)

				arg_122_1.text_.text = var_125_6

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_8 = 46 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_6) / 46)

				if (46 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_6) / 46)) > 0 and var_125_5 < var_125_8 then
					arg_122_1.talkMaxDuration = var_125_8

					if var_125_8 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_6
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_9 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_9 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_9

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_9 and arg_122_1.time_ < var_125_4 + var_125_9 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play322171031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 322171031
		arg_126_1.duration_ = 3.6

		local var_126_0 = {
			zh = 3.4,
			ja = 3.6
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play322171032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos10131ui_story = arg_126_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10131ui_story, Vector3.New(0.05, -0.96, -5.8), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10131ui_story"].transform.position).z)
				arg_126_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["10131ui_story"].transform.localEulerAngles = arg_126_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.05, -0.96, -5.8)
				arg_126_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10131ui_story"].transform.position).z)
				arg_126_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["10131ui_story"].transform.localEulerAngles = arg_126_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_129_1 = arg_126_1.actors_["10131ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect10131ui_story == nil then
				arg_126_1.var_.characterEffect10131ui_story = var_129_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 and not isNil(var_129_1) then
				if arg_126_1.var_.characterEffect10131ui_story and not isNil(var_129_1) then
					arg_126_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect10131ui_story then
				arg_126_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_2")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_129_4 = 0
			local var_129_5 = 0.3

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_6 = arg_126_1:GetWordFromCfg(322171031)
				local var_129_7 = arg_126_1:FormatText(var_129_6.content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_9 = 12 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 12)

				if (12 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 12)) > 0 and var_129_5 < var_129_9 then
					arg_126_1.talkMaxDuration = var_129_9

					if var_129_9 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_4
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171031", "story_v_out_322171.awb") ~= 0 then
					local var_129_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171031", "story_v_out_322171.awb") / 1000

					if var_129_10 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_4
					end

					if var_129_6.prefab_name ~= "" and arg_126_1.actors_[var_129_6.prefab_name] ~= nil then
						local var_129_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_6.prefab_name].transform, "story_v_out_322171", "322171031", "story_v_out_322171.awb")

						arg_126_1:RecordAudio("322171031", var_129_11)
						arg_126_1:RecordAudio("322171031", var_129_11)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_322171", "322171031", "story_v_out_322171.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_322171", "322171031", "story_v_out_322171.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_12 = math.max(var_129_5, arg_126_1.talkMaxDuration)

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_12 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_4) / var_129_12

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_4 + var_129_12 and arg_126_1.time_ < var_129_4 + var_129_12 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play322171032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 322171032
		arg_130_1.duration_ = 4.43

		local var_130_0 = {
			zh = 4.033,
			ja = 4.433
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play322171033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1111ui_story = arg_130_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1111ui_story"].transform.position).z)
				arg_130_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1111ui_story"].transform.localEulerAngles = arg_130_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_130_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1111ui_story"].transform.position).z)
				arg_130_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1111ui_story"].transform.localEulerAngles = arg_130_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_133_1 = arg_130_1.actors_["1111ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1111ui_story == nil then
				arg_130_1.var_.characterEffect1111ui_story = var_133_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_2 and not isNil(var_133_1) then
				if arg_130_1.var_.characterEffect1111ui_story and not isNil(var_133_1) then
					arg_130_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_2 and arg_130_1.time_ < 0 + var_133_2 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1111ui_story then
				arg_130_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_133_4 = arg_130_1.actors_["10131ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos10131ui_story = var_133_4.localPosition
			end

			local var_133_5 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_5 then
				var_133_4.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_5)
				var_133_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_4.position).x, (manager.ui.mainCamera.transform.position - var_133_4.position).y, (manager.ui.mainCamera.transform.position - var_133_4.position).z)
				var_133_4.localEulerAngles.z = 0
				var_133_4.localEulerAngles.x = 0
				var_133_4.localEulerAngles = var_133_4.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_5 and arg_130_1.time_ < 0 + var_133_5 + arg_133_0 then
				var_133_4.localPosition = Vector3.New(0, 100, 0)
				var_133_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_4.position).x, (manager.ui.mainCamera.transform.position - var_133_4.position).y, (manager.ui.mainCamera.transform.position - var_133_4.position).z)
				var_133_4.localEulerAngles.z = 0
				var_133_4.localEulerAngles.x = 0
				var_133_4.localEulerAngles = var_133_4.localEulerAngles
			end

			local var_133_6 = 0
			local var_133_7 = 0.375

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_8 = arg_130_1:GetWordFromCfg(322171032)
				local var_133_9 = arg_130_1:FormatText(var_133_8.content)

				arg_130_1.text_.text = var_133_9

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 15 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 15)

				if (15 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 15)) > 0 and var_133_7 < var_133_11 then
					arg_130_1.talkMaxDuration = var_133_11

					if var_133_11 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_9
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171032", "story_v_out_322171.awb") ~= 0 then
					local var_133_12 = manager.audio:GetVoiceLength("story_v_out_322171", "322171032", "story_v_out_322171.awb") / 1000

					if var_133_12 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_6
					end

					if var_133_8.prefab_name ~= "" and arg_130_1.actors_[var_133_8.prefab_name] ~= nil then
						local var_133_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_8.prefab_name].transform, "story_v_out_322171", "322171032", "story_v_out_322171.awb")

						arg_130_1:RecordAudio("322171032", var_133_13)
						arg_130_1:RecordAudio("322171032", var_133_13)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_322171", "322171032", "story_v_out_322171.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_322171", "322171032", "story_v_out_322171.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_14 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_14 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_14

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_14 and arg_130_1.time_ < var_133_6 + var_133_14 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play322171033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 322171033
		arg_134_1.duration_ = 10.23

		local var_134_0 = {
			zh = 6.3,
			ja = 10.233
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play322171034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["10131ui_story"]) and arg_134_1.var_.characterEffect10131ui_story == nil then
				arg_134_1.var_.characterEffect10131ui_story = arg_134_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["10131ui_story"]) then
				if arg_134_1.var_.characterEffect10131ui_story and not isNil(arg_134_1.actors_["10131ui_story"]) then
					arg_134_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["10131ui_story"]) and arg_134_1.var_.characterEffect10131ui_story then
				arg_134_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_137_2 = arg_134_1.actors_["1111ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1111ui_story == nil then
				arg_134_1.var_.characterEffect1111ui_story = var_137_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_3 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 and not isNil(var_137_2) then
				if arg_134_1.var_.characterEffect1111ui_story and not isNil(var_137_2) then
					arg_134_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_3)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1111ui_story then
				arg_134_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_137_4 = arg_134_1.actors_["10131ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos10131ui_story = var_137_4.localPosition
			end

			local var_137_5 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_5 then
				var_137_4.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_134_1.time_ - 0) / var_137_5)
				var_137_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_4.position).x, (manager.ui.mainCamera.transform.position - var_137_4.position).y, (manager.ui.mainCamera.transform.position - var_137_4.position).z)
				var_137_4.localEulerAngles.z = 0
				var_137_4.localEulerAngles.x = 0
				var_137_4.localEulerAngles = var_137_4.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_5 and arg_134_1.time_ < 0 + var_137_5 + arg_137_0 then
				var_137_4.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_137_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_4.position).x, (manager.ui.mainCamera.transform.position - var_137_4.position).y, (manager.ui.mainCamera.transform.position - var_137_4.position).z)
				var_137_4.localEulerAngles.z = 0
				var_137_4.localEulerAngles.x = 0
				var_137_4.localEulerAngles = var_137_4.localEulerAngles
			end

			local var_137_6 = arg_134_1.actors_["1111ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1111ui_story = var_137_6.localPosition
			end

			local var_137_7 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 then
				var_137_6.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_134_1.time_ - 0) / var_137_7)
				var_137_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_6.position).x, (manager.ui.mainCamera.transform.position - var_137_6.position).y, (manager.ui.mainCamera.transform.position - var_137_6.position).z)
				var_137_6.localEulerAngles.z = 0
				var_137_6.localEulerAngles.x = 0
				var_137_6.localEulerAngles = var_137_6.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 then
				var_137_6.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_137_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_6.position).x, (manager.ui.mainCamera.transform.position - var_137_6.position).y, (manager.ui.mainCamera.transform.position - var_137_6.position).z)
				var_137_6.localEulerAngles.z = 0
				var_137_6.localEulerAngles.x = 0
				var_137_6.localEulerAngles = var_137_6.localEulerAngles
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_137_8 = 0
			local var_137_9 = 0.675

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_8 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_10 = arg_134_1:GetWordFromCfg(322171033)
				local var_137_11 = arg_134_1:FormatText(var_137_10.content)

				arg_134_1.text_.text = var_137_11

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_13 = 27 <= 0 and var_137_9 or var_137_9 * (utf8.len(var_137_11) / 27)

				if (27 <= 0 and var_137_9 or var_137_9 * (utf8.len(var_137_11) / 27)) > 0 and var_137_9 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_8 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_8
					end
				end

				arg_134_1.text_.text = var_137_11
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171033", "story_v_out_322171.awb") ~= 0 then
					local var_137_14 = manager.audio:GetVoiceLength("story_v_out_322171", "322171033", "story_v_out_322171.awb") / 1000

					if var_137_14 + var_137_8 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_14 + var_137_8
					end

					if var_137_10.prefab_name ~= "" and arg_134_1.actors_[var_137_10.prefab_name] ~= nil then
						local var_137_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_10.prefab_name].transform, "story_v_out_322171", "322171033", "story_v_out_322171.awb")

						arg_134_1:RecordAudio("322171033", var_137_15)
						arg_134_1:RecordAudio("322171033", var_137_15)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_322171", "322171033", "story_v_out_322171.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_322171", "322171033", "story_v_out_322171.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_9, arg_134_1.talkMaxDuration)

			if var_137_8 <= arg_134_1.time_ and arg_134_1.time_ < var_137_8 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_8) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_8 + var_137_16 and arg_134_1.time_ < var_137_8 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play322171034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 322171034
		arg_138_1.duration_ = 5.27

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play322171035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				local var_141_0 = arg_138_1.bgs_.STblack

				arg_138_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_141_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_141_1 = var_141_0:GetComponent("SpriteRenderer")

				if var_141_1 and var_141_1.sprite then
					local var_141_2 = 2 * (var_141_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_141_0.transform.localScale = Vector3.New(var_141_2 / var_141_1.sprite.bounds.size.y < var_141_2 * manager.ui.mainCameraCom_.aspect / var_141_1.sprite.bounds.size.x and var_141_2 * manager.ui.mainCameraCom_.aspect / var_141_1.sprite.bounds.size.x or var_141_2 / var_141_1.sprite.bounds.size.y, var_141_2 / var_141_1.sprite.bounds.size.y < var_141_2 * manager.ui.mainCameraCom_.aspect / var_141_1.sprite.bounds.size.x and var_141_2 * manager.ui.mainCameraCom_.aspect / var_141_1.sprite.bounds.size.x or var_141_2 / var_141_1.sprite.bounds.size.y, 0)
				end

				for iter_141_0, iter_141_1 in pairs(arg_138_1.bgs_) do
					if iter_141_0 ~= "STblack" then
						iter_141_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_141_3 = 0

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_3 + arg_141_0 then
				arg_138_1.mask_.enabled = true
				arg_138_1.mask_.raycastTarget = true

				arg_138_1:SetGaussion(false)
			end

			local var_141_4 = 1

			if var_141_3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_3 + var_141_4 then
				local var_141_5 = Color.New(0, 0, 0)

				var_141_5.a = Mathf.Lerp(1, 0, (arg_138_1.time_ - var_141_3) / var_141_4)
				arg_138_1.mask_.color = var_141_5
			end

			if arg_138_1.time_ >= var_141_3 + var_141_4 and arg_138_1.time_ < var_141_3 + var_141_4 + arg_141_0 then
				local var_141_6 = Color.New(0, 0, 0)

				arg_138_1.mask_.enabled = false
				var_141_6.a = 0
				arg_138_1.mask_.color = var_141_6
			end

			local var_141_7 = arg_138_1.actors_["1111ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1111ui_story = var_141_7.localPosition
			end

			local var_141_8 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_8 then
				var_141_7.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_8)
				var_141_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_7.position).x, (manager.ui.mainCamera.transform.position - var_141_7.position).y, (manager.ui.mainCamera.transform.position - var_141_7.position).z)
				var_141_7.localEulerAngles.z = 0
				var_141_7.localEulerAngles.x = 0
				var_141_7.localEulerAngles = var_141_7.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_8 and arg_138_1.time_ < 0 + var_141_8 + arg_141_0 then
				var_141_7.localPosition = Vector3.New(0, 100, 0)
				var_141_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_7.position).x, (manager.ui.mainCamera.transform.position - var_141_7.position).y, (manager.ui.mainCamera.transform.position - var_141_7.position).z)
				var_141_7.localEulerAngles.z = 0
				var_141_7.localEulerAngles.x = 0
				var_141_7.localEulerAngles = var_141_7.localEulerAngles
			end

			local var_141_9 = arg_138_1.actors_["10131ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10131ui_story = var_141_9.localPosition
			end

			local var_141_10 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_10 then
				var_141_9.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_10)
				var_141_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_9.position).x, (manager.ui.mainCamera.transform.position - var_141_9.position).y, (manager.ui.mainCamera.transform.position - var_141_9.position).z)
				var_141_9.localEulerAngles.z = 0
				var_141_9.localEulerAngles.x = 0
				var_141_9.localEulerAngles = var_141_9.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_10 and arg_138_1.time_ < 0 + var_141_10 + arg_141_0 then
				var_141_9.localPosition = Vector3.New(0, 100, 0)
				var_141_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_9.position).x, (manager.ui.mainCamera.transform.position - var_141_9.position).y, (manager.ui.mainCamera.transform.position - var_141_9.position).z)
				var_141_9.localEulerAngles.z = 0
				var_141_9.localEulerAngles.x = 0
				var_141_9.localEulerAngles = var_141_9.localEulerAngles
			end

			local var_141_11 = 1
			local var_141_12 = manager.audio:GetVoiceLength("story_v_out_322171", "322171034", "story_v_out_322171.awb") / 1000

			if var_141_12 > 0 and 4.266 < var_141_12 and var_141_12 + var_141_11 > arg_138_1.duration_ then
				arg_138_1.duration_ = var_141_12 + var_141_11
			end

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1:AudioAction("play", "voice", "story_v_out_322171", "322171034", "story_v_out_322171.awb")
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = false,
				contentID = 419163,
				charCount = 2,
				enableLayoutChange = true,
				duration = 1,
				groupID = "3",
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
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322171034,
				charCount = 19,
				enableLayoutChange = true,
				duration = 1.26666666666667,
				groupID = "4",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play322171035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 322171035
		arg_142_1.duration_ = 1.4

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play322171036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = manager.audio:GetVoiceLength("story_v_out_322171", "322171035", "story_v_out_322171.awb") / 1000

			if var_145_0 > 0 and 1.4 < var_145_0 and var_145_0 + 0 > arg_142_1.duration_ then
				arg_142_1.duration_ = var_145_0 + 0
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:AudioAction("play", "voice", "story_v_out_322171", "322171035", "story_v_out_322171.awb")
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				groupID = "4",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322171035,
				charCount = 8,
				enableLayoutChange = true,
				duration = 0.666666666666667,
				groupID = "5",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play322171036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 322171036
		arg_146_1.duration_ = 9.3

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play322171037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = manager.audio:GetVoiceLength("story_v_out_322171", "322171036", "story_v_out_322171.awb") / 1000

			if var_149_0 > 0 and 9.3 < var_149_0 and var_149_0 + 0 > arg_146_1.duration_ then
				arg_146_1.duration_ = var_149_0 + 0
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:AudioAction("play", "voice", "story_v_out_322171", "322171036", "story_v_out_322171.awb")
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322171036,
				charCount = 39,
				enableLayoutChange = true,
				duration = 2.6,
				groupID = "6",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "5",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play322171037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 322171037
		arg_150_1.duration_ = 10.77

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play322171038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = manager.audio:GetVoiceLength("story_v_out_322171", "322171037", "story_v_out_322171.awb") / 1000

			if var_153_0 > 0 and 10.766 < var_153_0 and var_153_0 + 0 > arg_150_1.duration_ then
				arg_150_1.duration_ = var_153_0 + 0
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:AudioAction("play", "voice", "story_v_out_322171", "322171037", "story_v_out_322171.awb")
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				groupID = "6",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322171037,
				charCount = 43,
				enableLayoutChange = true,
				duration = 2.86666666666667,
				groupID = "7",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play322171038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 322171038
		arg_154_1.duration_ = 13.07

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play322171039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = manager.audio:GetVoiceLength("story_v_out_322171", "322171038", "story_v_out_322171.awb") / 1000

			if var_157_0 > 0 and 13.066 < var_157_0 and var_157_0 + 0 > arg_154_1.duration_ then
				arg_154_1.duration_ = var_157_0 + 0
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:AudioAction("play", "voice", "story_v_out_322171", "322171038", "story_v_out_322171.awb")
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				groupID = "7",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322171038,
				charCount = 55,
				enableLayoutChange = true,
				duration = 3.66666666666667,
				groupID = "8",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "7",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play322171039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 322171039
		arg_158_1.duration_ = 12.83

		local var_158_0 = {
			zh = 7.66666666666667,
			ja = 12.8326666666667
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play322171040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.mask_.enabled = true
				arg_158_1.mask_.raycastTarget = true

				arg_158_1:SetGaussion(false)
			end

			local var_161_0 = 0.666666666666667

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 then
				local var_161_1 = Color.New(0, 0, 0)

				var_161_1.a = Mathf.Lerp(0, 1, (arg_158_1.time_ - 0) / var_161_0)
				arg_158_1.mask_.color = var_161_1
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 then
				local var_161_2 = Color.New(0, 0, 0)

				var_161_2.a = 1
				arg_158_1.mask_.color = var_161_2
			end

			local var_161_3 = 0.666666666666667

			if 0.666666666666667 < arg_158_1.time_ and arg_158_1.time_ <= var_161_3 + arg_161_0 then
				arg_158_1.mask_.enabled = true
				arg_158_1.mask_.raycastTarget = true

				arg_158_1:SetGaussion(false)
			end

			local var_161_4 = 1

			if var_161_3 <= arg_158_1.time_ and arg_158_1.time_ < var_161_3 + var_161_4 then
				local var_161_5 = Color.New(0, 0, 0)

				var_161_5.a = Mathf.Lerp(1, 0, (arg_158_1.time_ - var_161_3) / var_161_4)
				arg_158_1.mask_.color = var_161_5
			end

			if arg_158_1.time_ >= var_161_3 + var_161_4 and arg_158_1.time_ < var_161_3 + var_161_4 + arg_161_0 then
				local var_161_6 = Color.New(0, 0, 0)

				arg_158_1.mask_.enabled = false
				var_161_6.a = 0
				arg_158_1.mask_.color = var_161_6
			end

			if 0.666666666666667 < arg_158_1.time_ and arg_158_1.time_ <= 0.666666666666667 + arg_161_0 then
				local var_161_7 = arg_158_1.bgs_.L09g

				arg_158_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_161_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_161_8 = var_161_7:GetComponent("SpriteRenderer")

				if var_161_8 and var_161_8.sprite then
					local var_161_9 = 2 * (var_161_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_161_7.transform.localScale = Vector3.New(var_161_9 / var_161_8.sprite.bounds.size.y < var_161_9 * manager.ui.mainCameraCom_.aspect / var_161_8.sprite.bounds.size.x and var_161_9 * manager.ui.mainCameraCom_.aspect / var_161_8.sprite.bounds.size.x or var_161_9 / var_161_8.sprite.bounds.size.y, var_161_9 / var_161_8.sprite.bounds.size.y < var_161_9 * manager.ui.mainCameraCom_.aspect / var_161_8.sprite.bounds.size.x and var_161_9 * manager.ui.mainCameraCom_.aspect / var_161_8.sprite.bounds.size.x or var_161_9 / var_161_8.sprite.bounds.size.y, 0)
				end

				for iter_161_0, iter_161_1 in pairs(arg_158_1.bgs_) do
					if iter_161_0 ~= "L09g" then
						iter_161_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_161_10 = arg_158_1.actors_["1111ui_story"].transform

			if 1.66666666666667 < arg_158_1.time_ and arg_158_1.time_ <= 1.66666666666667 + arg_161_0 then
				arg_158_1.var_.moveOldPos1111ui_story = var_161_10.localPosition
			end

			local var_161_11 = 0.001

			if 1.66666666666667 <= arg_158_1.time_ and arg_158_1.time_ < 1.66666666666667 + var_161_11 then
				var_161_10.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_158_1.time_ - 1.66666666666667) / var_161_11)
				var_161_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_10.position).x, (manager.ui.mainCamera.transform.position - var_161_10.position).y, (manager.ui.mainCamera.transform.position - var_161_10.position).z)
				var_161_10.localEulerAngles.z = 0
				var_161_10.localEulerAngles.x = 0
				var_161_10.localEulerAngles = var_161_10.localEulerAngles
			end

			if arg_158_1.time_ >= 1.66666666666667 + var_161_11 and arg_158_1.time_ < 1.66666666666667 + var_161_11 + arg_161_0 then
				var_161_10.localPosition = Vector3.New(0, -0.87, -5.7)
				var_161_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_10.position).x, (manager.ui.mainCamera.transform.position - var_161_10.position).y, (manager.ui.mainCamera.transform.position - var_161_10.position).z)
				var_161_10.localEulerAngles.z = 0
				var_161_10.localEulerAngles.x = 0
				var_161_10.localEulerAngles = var_161_10.localEulerAngles
			end

			local var_161_12 = arg_158_1.actors_["1111ui_story"]

			if 1.66666666666667 < arg_158_1.time_ and arg_158_1.time_ <= 1.66666666666667 + arg_161_0 and not isNil(var_161_12) and arg_158_1.var_.characterEffect1111ui_story == nil then
				arg_158_1.var_.characterEffect1111ui_story = var_161_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_13 = 0.200000002980232

			if 1.66666666666667 <= arg_158_1.time_ and arg_158_1.time_ < 1.66666666666667 + var_161_13 and not isNil(var_161_12) then
				if arg_158_1.var_.characterEffect1111ui_story and not isNil(var_161_12) then
					arg_158_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 1.66666666666667 + var_161_13 and arg_158_1.time_ < 1.66666666666667 + var_161_13 + arg_161_0 and not isNil(var_161_12) and arg_158_1.var_.characterEffect1111ui_story then
				arg_158_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 1.66666666666667 < arg_158_1.time_ and arg_158_1.time_ <= 1.66666666666667 + arg_161_0 then
				arg_158_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 1.66666666666667 < arg_158_1.time_ and arg_158_1.time_ <= 1.66666666666667 + arg_161_0 then
				arg_158_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_158_1.frameCnt_ <= 1 then
				arg_158_1.dialog_:SetActive(false)
			end

			local var_161_15 = 1.66666666666667
			local var_161_16 = 0.675

			if 1.66666666666667 < arg_158_1.time_ and arg_158_1.time_ <= var_161_15 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0

				arg_158_1.dialog_:SetActive(true)

				arg_158_1.dialogCg_.alpha = 0

				local var_161_17 = LeanTween.value(arg_158_1.dialog_, 0, 1, 0.3)

				var_161_17:setOnUpdate(LuaHelper.FloatAction(function(arg_162_0)
					arg_158_1.dialogCg_.alpha = arg_162_0
				end))
				var_161_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_158_1.dialog_)
					var_161_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_158_1.duration_ = arg_158_1.duration_ + 0.3

				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_18 = arg_158_1:GetWordFromCfg(322171039)
				local var_161_19 = arg_158_1:FormatText(var_161_18.content)

				arg_158_1.text_.text = var_161_19

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_21 = 27 <= 0 and var_161_16 or var_161_16 * (utf8.len(var_161_19) / 27)

				if (27 <= 0 and var_161_16 or var_161_16 * (utf8.len(var_161_19) / 27)) > 0 and var_161_16 < var_161_21 then
					arg_158_1.talkMaxDuration = var_161_21
					var_161_15 = var_161_15 + 0.3

					if var_161_21 + var_161_15 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_21 + var_161_15
					end
				end

				arg_158_1.text_.text = var_161_19
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171039", "story_v_out_322171.awb") ~= 0 then
					local var_161_22 = manager.audio:GetVoiceLength("story_v_out_322171", "322171039", "story_v_out_322171.awb") / 1000

					if var_161_22 + var_161_15 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_22 + var_161_15
					end

					if var_161_18.prefab_name ~= "" and arg_158_1.actors_[var_161_18.prefab_name] ~= nil then
						local var_161_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_18.prefab_name].transform, "story_v_out_322171", "322171039", "story_v_out_322171.awb")

						arg_158_1:RecordAudio("322171039", var_161_23)
						arg_158_1:RecordAudio("322171039", var_161_23)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_322171", "322171039", "story_v_out_322171.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_322171", "322171039", "story_v_out_322171.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_24 = var_161_15 + 0.3
			local var_161_25 = math.max(var_161_16, arg_158_1.talkMaxDuration)

			if var_161_15 + 0.3 <= arg_158_1.time_ and arg_158_1.time_ < var_161_24 + var_161_25 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_24) / var_161_25

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_24 + var_161_25 and arg_158_1.time_ < var_161_24 + var_161_25 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "8",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0.666666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "3",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0.666666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "8",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0.666666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play322171040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322171040
		arg_164_1.duration_ = 7.57

		local var_164_0 = {
			zh = 5.6,
			ja = 7.566
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
				arg_164_0:Play322171041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["10131ui_story"]) and arg_164_1.var_.characterEffect10131ui_story == nil then
				arg_164_1.var_.characterEffect10131ui_story = arg_164_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["10131ui_story"]) then
				if arg_164_1.var_.characterEffect10131ui_story and not isNil(arg_164_1.actors_["10131ui_story"]) then
					arg_164_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["10131ui_story"]) and arg_164_1.var_.characterEffect10131ui_story then
				arg_164_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_167_2 = arg_164_1.actors_["1111ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect1111ui_story == nil then
				arg_164_1.var_.characterEffect1111ui_story = var_167_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_3 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_3 and not isNil(var_167_2) then
				if arg_164_1.var_.characterEffect1111ui_story and not isNil(var_167_2) then
					arg_164_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_3)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_3 and arg_164_1.time_ < 0 + var_167_3 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect1111ui_story then
				arg_164_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_167_4 = arg_164_1.actors_["10131ui_story"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos10131ui_story = var_167_4.localPosition
			end

			local var_167_5 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_5 then
				var_167_4.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_164_1.time_ - 0) / var_167_5)
				var_167_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_4.position).x, (manager.ui.mainCamera.transform.position - var_167_4.position).y, (manager.ui.mainCamera.transform.position - var_167_4.position).z)
				var_167_4.localEulerAngles.z = 0
				var_167_4.localEulerAngles.x = 0
				var_167_4.localEulerAngles = var_167_4.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_5 and arg_164_1.time_ < 0 + var_167_5 + arg_167_0 then
				var_167_4.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_167_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_4.position).x, (manager.ui.mainCamera.transform.position - var_167_4.position).y, (manager.ui.mainCamera.transform.position - var_167_4.position).z)
				var_167_4.localEulerAngles.z = 0
				var_167_4.localEulerAngles.x = 0
				var_167_4.localEulerAngles = var_167_4.localEulerAngles
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_167_6 = arg_164_1.actors_["1111ui_story"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1111ui_story = var_167_6.localPosition
			end

			local var_167_7 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				var_167_6.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_164_1.time_ - 0) / var_167_7)
				var_167_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_6.position).x, (manager.ui.mainCamera.transform.position - var_167_6.position).y, (manager.ui.mainCamera.transform.position - var_167_6.position).z)
				var_167_6.localEulerAngles.z = 0
				var_167_6.localEulerAngles.x = 0
				var_167_6.localEulerAngles = var_167_6.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				var_167_6.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_167_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_6.position).x, (manager.ui.mainCamera.transform.position - var_167_6.position).y, (manager.ui.mainCamera.transform.position - var_167_6.position).z)
				var_167_6.localEulerAngles.z = 0
				var_167_6.localEulerAngles.x = 0
				var_167_6.localEulerAngles = var_167_6.localEulerAngles
			end

			local var_167_8 = 0
			local var_167_9 = 0.5

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_10 = arg_164_1:GetWordFromCfg(322171040)
				local var_167_11 = arg_164_1:FormatText(var_167_10.content)

				arg_164_1.text_.text = var_167_11

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_13 = 20 <= 0 and var_167_9 or var_167_9 * (utf8.len(var_167_11) / 20)

				if (20 <= 0 and var_167_9 or var_167_9 * (utf8.len(var_167_11) / 20)) > 0 and var_167_9 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_8
					end
				end

				arg_164_1.text_.text = var_167_11
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171040", "story_v_out_322171.awb") ~= 0 then
					local var_167_14 = manager.audio:GetVoiceLength("story_v_out_322171", "322171040", "story_v_out_322171.awb") / 1000

					if var_167_14 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_8
					end

					if var_167_10.prefab_name ~= "" and arg_164_1.actors_[var_167_10.prefab_name] ~= nil then
						local var_167_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_10.prefab_name].transform, "story_v_out_322171", "322171040", "story_v_out_322171.awb")

						arg_164_1:RecordAudio("322171040", var_167_15)
						arg_164_1:RecordAudio("322171040", var_167_15)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_322171", "322171040", "story_v_out_322171.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_322171", "322171040", "story_v_out_322171.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_9, arg_164_1.talkMaxDuration)

			if var_167_8 <= arg_164_1.time_ and arg_164_1.time_ < var_167_8 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_8) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_8 + var_167_16 and arg_164_1.time_ < var_167_8 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play322171041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 322171041
		arg_168_1.duration_ = 7

		local var_168_0 = {
			zh = 4.166,
			ja = 7
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
				arg_168_0:Play322171042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.475

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:GetWordFromCfg(322171041)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 19 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 19)

				if (19 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 19)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171041", "story_v_out_322171.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_322171", "322171041", "story_v_out_322171.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_322171", "322171041", "story_v_out_322171.awb")

						arg_168_1:RecordAudio("322171041", var_171_6)
						arg_168_1:RecordAudio("322171041", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_322171", "322171041", "story_v_out_322171.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_322171", "322171041", "story_v_out_322171.awb")
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
	Play322171042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 322171042
		arg_172_1.duration_ = 13.4

		local var_172_0 = {
			zh = 9.9,
			ja = 13.4
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
				arg_172_0:Play322171043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.7

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:GetWordFromCfg(322171042)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 28 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 28)

				if (28 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 28)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171042", "story_v_out_322171.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_322171", "322171042", "story_v_out_322171.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_322171", "322171042", "story_v_out_322171.awb")

						arg_172_1:RecordAudio("322171042", var_175_6)
						arg_172_1:RecordAudio("322171042", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_322171", "322171042", "story_v_out_322171.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_322171", "322171042", "story_v_out_322171.awb")
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
	Play322171043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 322171043
		arg_176_1.duration_ = 17.23

		local var_176_0 = {
			zh = 10.433,
			ja = 17.233
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play322171044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_179_0 = 0
			local var_179_1 = 1.1

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_2 = arg_176_1:GetWordFromCfg(322171043)
				local var_179_3 = arg_176_1:FormatText(var_179_2.content)

				arg_176_1.text_.text = var_179_3

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 43 <= 0 and var_179_1 or var_179_1 * (utf8.len(var_179_3) / 43)

				if (43 <= 0 and var_179_1 or var_179_1 * (utf8.len(var_179_3) / 43)) > 0 and var_179_1 < var_179_5 then
					arg_176_1.talkMaxDuration = var_179_5

					if var_179_5 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_3
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171043", "story_v_out_322171.awb") ~= 0 then
					local var_179_6 = manager.audio:GetVoiceLength("story_v_out_322171", "322171043", "story_v_out_322171.awb") / 1000

					if var_179_6 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_6 + var_179_0
					end

					if var_179_2.prefab_name ~= "" and arg_176_1.actors_[var_179_2.prefab_name] ~= nil then
						local var_179_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_2.prefab_name].transform, "story_v_out_322171", "322171043", "story_v_out_322171.awb")

						arg_176_1:RecordAudio("322171043", var_179_7)
						arg_176_1:RecordAudio("322171043", var_179_7)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_322171", "322171043", "story_v_out_322171.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_322171", "322171043", "story_v_out_322171.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_8 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_8 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_8

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_8 and arg_176_1.time_ < var_179_0 + var_179_8 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play322171044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 322171044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play322171045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10131ui_story = arg_180_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_183_0 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_180_1.time_ - 0) / var_183_0)
				arg_180_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10131ui_story"].transform.position).z)
				arg_180_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["10131ui_story"].transform.localEulerAngles = arg_180_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_180_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["10131ui_story"].transform.position).z)
				arg_180_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["10131ui_story"].transform.localEulerAngles = arg_180_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_183_1 = arg_180_1.actors_["1111ui_story"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1111ui_story = var_183_1.localPosition
			end

			local var_183_2 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_2 then
				var_183_1.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_180_1.time_ - 0) / var_183_2)
				var_183_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_1.position).x, (manager.ui.mainCamera.transform.position - var_183_1.position).y, (manager.ui.mainCamera.transform.position - var_183_1.position).z)
				var_183_1.localEulerAngles.z = 0
				var_183_1.localEulerAngles.x = 0
				var_183_1.localEulerAngles = var_183_1.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_2 and arg_180_1.time_ < 0 + var_183_2 + arg_183_0 then
				var_183_1.localPosition = Vector3.New(0, 100, 0)
				var_183_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_1.position).x, (manager.ui.mainCamera.transform.position - var_183_1.position).y, (manager.ui.mainCamera.transform.position - var_183_1.position).z)
				var_183_1.localEulerAngles.z = 0
				var_183_1.localEulerAngles.x = 0
				var_183_1.localEulerAngles = var_183_1.localEulerAngles
			end

			local var_183_3 = 0
			local var_183_4 = 1.725

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_3 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_5 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(322171044).content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 69 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_5) / 69)

				if (69 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_5) / 69)) > 0 and var_183_4 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_3 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_3
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_8 = math.max(var_183_4, arg_180_1.talkMaxDuration)

			if var_183_3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_3 + var_183_8 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_3) / var_183_8

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_3 + var_183_8 and arg_180_1.time_ < var_183_3 + var_183_8 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play322171045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 322171045
		arg_184_1.duration_ = 2.47

		local var_184_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play322171046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1111ui_story = arg_184_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_187_0 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 then
				arg_184_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_184_1.time_ - 0) / var_187_0)
				arg_184_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1111ui_story"].transform.position).z)
				arg_184_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["1111ui_story"].transform.localEulerAngles = arg_184_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 then
				arg_184_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_184_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["1111ui_story"].transform.position).z)
				arg_184_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["1111ui_story"].transform.localEulerAngles = arg_184_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_187_1 = arg_184_1.actors_["1111ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect1111ui_story == nil then
				arg_184_1.var_.characterEffect1111ui_story = var_187_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_2 and not isNil(var_187_1) then
				if arg_184_1.var_.characterEffect1111ui_story and not isNil(var_187_1) then
					arg_184_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_2 and arg_184_1.time_ < 0 + var_187_2 + arg_187_0 and not isNil(var_187_1) and arg_184_1.var_.characterEffect1111ui_story then
				arg_184_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_187_4 = 0
			local var_187_5 = 0.1

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_6 = arg_184_1:GetWordFromCfg(322171045)
				local var_187_7 = arg_184_1:FormatText(var_187_6.content)

				arg_184_1.text_.text = var_187_7

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_9 = 4 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 4)

				if (4 <= 0 and var_187_5 or var_187_5 * (utf8.len(var_187_7) / 4)) > 0 and var_187_5 < var_187_9 then
					arg_184_1.talkMaxDuration = var_187_9

					if var_187_9 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_9 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_7
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171045", "story_v_out_322171.awb") ~= 0 then
					local var_187_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171045", "story_v_out_322171.awb") / 1000

					if var_187_10 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_4
					end

					if var_187_6.prefab_name ~= "" and arg_184_1.actors_[var_187_6.prefab_name] ~= nil then
						local var_187_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_6.prefab_name].transform, "story_v_out_322171", "322171045", "story_v_out_322171.awb")

						arg_184_1:RecordAudio("322171045", var_187_11)
						arg_184_1:RecordAudio("322171045", var_187_11)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_322171", "322171045", "story_v_out_322171.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_322171", "322171045", "story_v_out_322171.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_12 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_12 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_12

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_12 and arg_184_1.time_ < var_187_4 + var_187_12 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play322171046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 322171046
		arg_188_1.duration_ = 3.23

		local var_188_0 = {
			zh = 2.266,
			ja = 3.233
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play322171047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1111ui_story = arg_188_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_191_0 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 then
				arg_188_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_188_1.time_ - 0) / var_191_0)
				arg_188_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).z)
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles = arg_188_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 then
				arg_188_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_188_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1111ui_story"].transform.position).z)
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1111ui_story"].transform.localEulerAngles = arg_188_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_191_1 = arg_188_1.actors_["1111ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_1) and arg_188_1.var_.characterEffect1111ui_story == nil then
				arg_188_1.var_.characterEffect1111ui_story = var_191_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_2 and not isNil(var_191_1) then
				if arg_188_1.var_.characterEffect1111ui_story and not isNil(var_191_1) then
					arg_188_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_2)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_2 and arg_188_1.time_ < 0 + var_191_2 + arg_191_0 and not isNil(var_191_1) and arg_188_1.var_.characterEffect1111ui_story then
				arg_188_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_191_3 = arg_188_1.actors_["10131ui_story"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10131ui_story = var_191_3.localPosition
			end

			local var_191_4 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				var_191_3.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_188_1.time_ - 0) / var_191_4)
				var_191_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_3.position).x, (manager.ui.mainCamera.transform.position - var_191_3.position).y, (manager.ui.mainCamera.transform.position - var_191_3.position).z)
				var_191_3.localEulerAngles.z = 0
				var_191_3.localEulerAngles.x = 0
				var_191_3.localEulerAngles = var_191_3.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				var_191_3.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_191_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_3.position).x, (manager.ui.mainCamera.transform.position - var_191_3.position).y, (manager.ui.mainCamera.transform.position - var_191_3.position).z)
				var_191_3.localEulerAngles.z = 0
				var_191_3.localEulerAngles.x = 0
				var_191_3.localEulerAngles = var_191_3.localEulerAngles
			end

			local var_191_5 = arg_188_1.actors_["10131ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_5) and arg_188_1.var_.characterEffect10131ui_story == nil then
				arg_188_1.var_.characterEffect10131ui_story = var_191_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_6 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_6 and not isNil(var_191_5) then
				if arg_188_1.var_.characterEffect10131ui_story and not isNil(var_191_5) then
					arg_188_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_6 and arg_188_1.time_ < 0 + var_191_6 + arg_191_0 and not isNil(var_191_5) and arg_188_1.var_.characterEffect10131ui_story then
				arg_188_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_191_8 = 0
			local var_191_9 = 0.275

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_10 = arg_188_1:GetWordFromCfg(322171046)
				local var_191_11 = arg_188_1:FormatText(var_191_10.content)

				arg_188_1.text_.text = var_191_11

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_13 = 11 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_11) / 11)

				if (11 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_11) / 11)) > 0 and var_191_9 < var_191_13 then
					arg_188_1.talkMaxDuration = var_191_13

					if var_191_13 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_8
					end
				end

				arg_188_1.text_.text = var_191_11
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171046", "story_v_out_322171.awb") ~= 0 then
					local var_191_14 = manager.audio:GetVoiceLength("story_v_out_322171", "322171046", "story_v_out_322171.awb") / 1000

					if var_191_14 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_14 + var_191_8
					end

					if var_191_10.prefab_name ~= "" and arg_188_1.actors_[var_191_10.prefab_name] ~= nil then
						local var_191_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_10.prefab_name].transform, "story_v_out_322171", "322171046", "story_v_out_322171.awb")

						arg_188_1:RecordAudio("322171046", var_191_15)
						arg_188_1:RecordAudio("322171046", var_191_15)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_322171", "322171046", "story_v_out_322171.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_322171", "322171046", "story_v_out_322171.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_16 = math.max(var_191_9, arg_188_1.talkMaxDuration)

			if var_191_8 <= arg_188_1.time_ and arg_188_1.time_ < var_191_8 + var_191_16 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_8) / var_191_16

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_8 + var_191_16 and arg_188_1.time_ < var_191_8 + var_191_16 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play322171047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 322171047
		arg_192_1.duration_ = 6.13

		local var_192_0 = {
			zh = 4.4,
			ja = 6.133
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play322171048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1111ui_story"]) and arg_192_1.var_.characterEffect1111ui_story == nil then
				arg_192_1.var_.characterEffect1111ui_story = arg_192_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1111ui_story"]) then
				if arg_192_1.var_.characterEffect1111ui_story and not isNil(arg_192_1.actors_["1111ui_story"]) then
					arg_192_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1111ui_story"]) and arg_192_1.var_.characterEffect1111ui_story then
				arg_192_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_195_2 = arg_192_1.actors_["10131ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect10131ui_story == nil then
				arg_192_1.var_.characterEffect10131ui_story = var_195_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_3 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.characterEffect10131ui_story and not isNil(var_195_2) then
					arg_192_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_192_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_3)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.characterEffect10131ui_story then
				arg_192_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_192_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_195_4 = 0
			local var_195_5 = 0.55

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_6 = arg_192_1:GetWordFromCfg(322171047)
				local var_195_7 = arg_192_1:FormatText(var_195_6.content)

				arg_192_1.text_.text = var_195_7

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_9 = 22 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 22)

				if (22 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 22)) > 0 and var_195_5 < var_195_9 then
					arg_192_1.talkMaxDuration = var_195_9

					if var_195_9 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_9 + var_195_4
					end
				end

				arg_192_1.text_.text = var_195_7
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171047", "story_v_out_322171.awb") ~= 0 then
					local var_195_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171047", "story_v_out_322171.awb") / 1000

					if var_195_10 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_4
					end

					if var_195_6.prefab_name ~= "" and arg_192_1.actors_[var_195_6.prefab_name] ~= nil then
						local var_195_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_6.prefab_name].transform, "story_v_out_322171", "322171047", "story_v_out_322171.awb")

						arg_192_1:RecordAudio("322171047", var_195_11)
						arg_192_1:RecordAudio("322171047", var_195_11)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_322171", "322171047", "story_v_out_322171.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_322171", "322171047", "story_v_out_322171.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_12 = math.max(var_195_5, arg_192_1.talkMaxDuration)

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_12 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_4) / var_195_12

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_4 + var_195_12 and arg_192_1.time_ < var_195_4 + var_195_12 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play322171048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 322171048
		arg_196_1.duration_ = 6.43

		local var_196_0 = {
			zh = 5.166,
			ja = 6.433
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play322171049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["10131ui_story"]) and arg_196_1.var_.characterEffect10131ui_story == nil then
				arg_196_1.var_.characterEffect10131ui_story = arg_196_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["10131ui_story"]) then
				if arg_196_1.var_.characterEffect10131ui_story and not isNil(arg_196_1.actors_["10131ui_story"]) then
					arg_196_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["10131ui_story"]) and arg_196_1.var_.characterEffect10131ui_story then
				arg_196_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_199_2 = arg_196_1.actors_["1111ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect1111ui_story == nil then
				arg_196_1.var_.characterEffect1111ui_story = var_199_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_3 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.characterEffect1111ui_story and not isNil(var_199_2) then
					arg_196_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_3)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect1111ui_story then
				arg_196_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_199_4 = 0
			local var_199_5 = 0.45

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_6 = arg_196_1:GetWordFromCfg(322171048)
				local var_199_7 = arg_196_1:FormatText(var_199_6.content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 18 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 18)

				if (18 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 18)) > 0 and var_199_5 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_4
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171048", "story_v_out_322171.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171048", "story_v_out_322171.awb") / 1000

					if var_199_10 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_4
					end

					if var_199_6.prefab_name ~= "" and arg_196_1.actors_[var_199_6.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_6.prefab_name].transform, "story_v_out_322171", "322171048", "story_v_out_322171.awb")

						arg_196_1:RecordAudio("322171048", var_199_11)
						arg_196_1:RecordAudio("322171048", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_322171", "322171048", "story_v_out_322171.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_322171", "322171048", "story_v_out_322171.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_5, arg_196_1.talkMaxDuration)

			if var_199_4 <= arg_196_1.time_ and arg_196_1.time_ < var_199_4 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_4) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_4 + var_199_12 and arg_196_1.time_ < var_199_4 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play322171049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 322171049
		arg_200_1.duration_ = 13.7

		local var_200_0 = {
			zh = 11,
			ja = 13.7
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play322171050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 1.05

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:GetWordFromCfg(322171049)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 42 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 42)

				if (42 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 42)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171049", "story_v_out_322171.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_322171", "322171049", "story_v_out_322171.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_322171", "322171049", "story_v_out_322171.awb")

						arg_200_1:RecordAudio("322171049", var_203_6)
						arg_200_1:RecordAudio("322171049", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_322171", "322171049", "story_v_out_322171.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_322171", "322171049", "story_v_out_322171.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play322171050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 322171050
		arg_204_1.duration_ = 13.37

		local var_204_0 = {
			zh = 13.366,
			ja = 12.5
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play322171051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 1.5

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:GetWordFromCfg(322171050)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 60 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 60)

				if (60 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 60)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171050", "story_v_out_322171.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_322171", "322171050", "story_v_out_322171.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_322171", "322171050", "story_v_out_322171.awb")

						arg_204_1:RecordAudio("322171050", var_207_6)
						arg_204_1:RecordAudio("322171050", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_322171", "322171050", "story_v_out_322171.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_322171", "322171050", "story_v_out_322171.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play322171051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 322171051
		arg_208_1.duration_ = 18.33

		local var_208_0 = {
			zh = 13.066,
			ja = 18.333
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play322171052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_1")
			end

			local var_211_0 = 0
			local var_211_1 = 1.375

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_2 = arg_208_1:GetWordFromCfg(322171051)
				local var_211_3 = arg_208_1:FormatText(var_211_2.content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 55 <= 0 and var_211_1 or var_211_1 * (utf8.len(var_211_3) / 55)

				if (55 <= 0 and var_211_1 or var_211_1 * (utf8.len(var_211_3) / 55)) > 0 and var_211_1 < var_211_5 then
					arg_208_1.talkMaxDuration = var_211_5

					if var_211_5 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171051", "story_v_out_322171.awb") ~= 0 then
					local var_211_6 = manager.audio:GetVoiceLength("story_v_out_322171", "322171051", "story_v_out_322171.awb") / 1000

					if var_211_6 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_0
					end

					if var_211_2.prefab_name ~= "" and arg_208_1.actors_[var_211_2.prefab_name] ~= nil then
						local var_211_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_2.prefab_name].transform, "story_v_out_322171", "322171051", "story_v_out_322171.awb")

						arg_208_1:RecordAudio("322171051", var_211_7)
						arg_208_1:RecordAudio("322171051", var_211_7)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_322171", "322171051", "story_v_out_322171.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_322171", "322171051", "story_v_out_322171.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_8 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_8 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_8

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_8 and arg_208_1.time_ < var_211_0 + var_211_8 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play322171052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 322171052
		arg_212_1.duration_ = 16.27

		local var_212_0 = {
			zh = 12.466,
			ja = 16.266
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play322171053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_215_0 = 0
			local var_215_1 = 1.05

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_2 = arg_212_1:GetWordFromCfg(322171052)
				local var_215_3 = arg_212_1:FormatText(var_215_2.content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 42 <= 0 and var_215_1 or var_215_1 * (utf8.len(var_215_3) / 42)

				if (42 <= 0 and var_215_1 or var_215_1 * (utf8.len(var_215_3) / 42)) > 0 and var_215_1 < var_215_5 then
					arg_212_1.talkMaxDuration = var_215_5

					if var_215_5 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_3
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171052", "story_v_out_322171.awb") ~= 0 then
					local var_215_6 = manager.audio:GetVoiceLength("story_v_out_322171", "322171052", "story_v_out_322171.awb") / 1000

					if var_215_6 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_6 + var_215_0
					end

					if var_215_2.prefab_name ~= "" and arg_212_1.actors_[var_215_2.prefab_name] ~= nil then
						local var_215_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_2.prefab_name].transform, "story_v_out_322171", "322171052", "story_v_out_322171.awb")

						arg_212_1:RecordAudio("322171052", var_215_7)
						arg_212_1:RecordAudio("322171052", var_215_7)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_322171", "322171052", "story_v_out_322171.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_322171", "322171052", "story_v_out_322171.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_8 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_8 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_8

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_8 and arg_212_1.time_ < var_215_0 + var_215_8 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play322171053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 322171053
		arg_216_1.duration_ = 2

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play322171054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1111ui_story"]) and arg_216_1.var_.characterEffect1111ui_story == nil then
				arg_216_1.var_.characterEffect1111ui_story = arg_216_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1111ui_story"]) then
				if arg_216_1.var_.characterEffect1111ui_story and not isNil(arg_216_1.actors_["1111ui_story"]) then
					arg_216_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1111ui_story"]) and arg_216_1.var_.characterEffect1111ui_story then
				arg_216_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_219_2 = arg_216_1.actors_["10131ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.characterEffect10131ui_story == nil then
				arg_216_1.var_.characterEffect10131ui_story = var_219_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_3 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_3 and not isNil(var_219_2) then
				if arg_216_1.var_.characterEffect10131ui_story and not isNil(var_219_2) then
					arg_216_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_3)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_3 and arg_216_1.time_ < 0 + var_219_3 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.characterEffect10131ui_story then
				arg_216_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_219_4 = 0
			local var_219_5 = 0.05

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_6 = arg_216_1:GetWordFromCfg(322171053)
				local var_219_7 = arg_216_1:FormatText(var_219_6.content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_9 = 2 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 2)

				if (2 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 2)) > 0 and var_219_5 < var_219_9 then
					arg_216_1.talkMaxDuration = var_219_9

					if var_219_9 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_4
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171053", "story_v_out_322171.awb") ~= 0 then
					local var_219_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171053", "story_v_out_322171.awb") / 1000

					if var_219_10 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_10 + var_219_4
					end

					if var_219_6.prefab_name ~= "" and arg_216_1.actors_[var_219_6.prefab_name] ~= nil then
						local var_219_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_6.prefab_name].transform, "story_v_out_322171", "322171053", "story_v_out_322171.awb")

						arg_216_1:RecordAudio("322171053", var_219_11)
						arg_216_1:RecordAudio("322171053", var_219_11)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_322171", "322171053", "story_v_out_322171.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_322171", "322171053", "story_v_out_322171.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_12 = math.max(var_219_5, arg_216_1.talkMaxDuration)

			if var_219_4 <= arg_216_1.time_ and arg_216_1.time_ < var_219_4 + var_219_12 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_4) / var_219_12

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_4 + var_219_12 and arg_216_1.time_ < var_219_4 + var_219_12 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play322171054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 322171054
		arg_220_1.duration_ = 18.6

		local var_220_0 = {
			zh = 7.333,
			ja = 18.6
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play322171055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_223_0 = 0
			local var_223_1 = 0.825

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_2 = arg_220_1:GetWordFromCfg(322171054)
				local var_223_3 = arg_220_1:FormatText(var_223_2.content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 33 <= 0 and var_223_1 or var_223_1 * (utf8.len(var_223_3) / 33)

				if (33 <= 0 and var_223_1 or var_223_1 * (utf8.len(var_223_3) / 33)) > 0 and var_223_1 < var_223_5 then
					arg_220_1.talkMaxDuration = var_223_5

					if var_223_5 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171054", "story_v_out_322171.awb") ~= 0 then
					local var_223_6 = manager.audio:GetVoiceLength("story_v_out_322171", "322171054", "story_v_out_322171.awb") / 1000

					if var_223_6 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_6 + var_223_0
					end

					if var_223_2.prefab_name ~= "" and arg_220_1.actors_[var_223_2.prefab_name] ~= nil then
						local var_223_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_2.prefab_name].transform, "story_v_out_322171", "322171054", "story_v_out_322171.awb")

						arg_220_1:RecordAudio("322171054", var_223_7)
						arg_220_1:RecordAudio("322171054", var_223_7)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_322171", "322171054", "story_v_out_322171.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_322171", "322171054", "story_v_out_322171.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_8 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_8 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_8

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_8 and arg_220_1.time_ < var_223_0 + var_223_8 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play322171055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 322171055
		arg_224_1.duration_ = 9.47

		local var_224_0 = {
			zh = 5.4,
			ja = 9.466
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play322171056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0.725

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_1 = arg_224_1:GetWordFromCfg(322171055)
				local var_227_2 = arg_224_1:FormatText(var_227_1.content)

				arg_224_1.text_.text = var_227_2

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 29 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 29)

				if (29 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 29)) > 0 and var_227_0 < var_227_4 then
					arg_224_1.talkMaxDuration = var_227_4

					if var_227_4 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_4 + 0
					end
				end

				arg_224_1.text_.text = var_227_2
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171055", "story_v_out_322171.awb") ~= 0 then
					local var_227_5 = manager.audio:GetVoiceLength("story_v_out_322171", "322171055", "story_v_out_322171.awb") / 1000

					if var_227_5 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + 0
					end

					if var_227_1.prefab_name ~= "" and arg_224_1.actors_[var_227_1.prefab_name] ~= nil then
						local var_227_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_1.prefab_name].transform, "story_v_out_322171", "322171055", "story_v_out_322171.awb")

						arg_224_1:RecordAudio("322171055", var_227_6)
						arg_224_1:RecordAudio("322171055", var_227_6)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_322171", "322171055", "story_v_out_322171.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_322171", "322171055", "story_v_out_322171.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_7 and arg_224_1.time_ < 0 + var_227_7 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play322171056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 322171056
		arg_228_1.duration_ = 2.4

		local var_228_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play322171057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["10131ui_story"]) and arg_228_1.var_.characterEffect10131ui_story == nil then
				arg_228_1.var_.characterEffect10131ui_story = arg_228_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["10131ui_story"]) then
				if arg_228_1.var_.characterEffect10131ui_story and not isNil(arg_228_1.actors_["10131ui_story"]) then
					arg_228_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["10131ui_story"]) and arg_228_1.var_.characterEffect10131ui_story then
				arg_228_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_231_2 = arg_228_1.actors_["1111ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1111ui_story == nil then
				arg_228_1.var_.characterEffect1111ui_story = var_231_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_3 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.characterEffect1111ui_story and not isNil(var_231_2) then
					arg_228_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_3)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1111ui_story then
				arg_228_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_231_4 = 0
			local var_231_5 = 0.2

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(322171056)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 8 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 8)

				if (8 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 8)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171056", "story_v_out_322171.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171056", "story_v_out_322171.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_out_322171", "322171056", "story_v_out_322171.awb")

						arg_228_1:RecordAudio("322171056", var_231_11)
						arg_228_1:RecordAudio("322171056", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_322171", "322171056", "story_v_out_322171.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_322171", "322171056", "story_v_out_322171.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play322171057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 322171057
		arg_232_1.duration_ = 6.9

		local var_232_0 = {
			zh = 4.033,
			ja = 6.9
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play322171058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["1111ui_story"]) and arg_232_1.var_.characterEffect1111ui_story == nil then
				arg_232_1.var_.characterEffect1111ui_story = arg_232_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_0 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["1111ui_story"]) then
				if arg_232_1.var_.characterEffect1111ui_story and not isNil(arg_232_1.actors_["1111ui_story"]) then
					arg_232_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["1111ui_story"]) and arg_232_1.var_.characterEffect1111ui_story then
				arg_232_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_235_2 = arg_232_1.actors_["10131ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_2) and arg_232_1.var_.characterEffect10131ui_story == nil then
				arg_232_1.var_.characterEffect10131ui_story = var_235_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_3 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_3 and not isNil(var_235_2) then
				if arg_232_1.var_.characterEffect10131ui_story and not isNil(var_235_2) then
					arg_232_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_232_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_3)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_3 and arg_232_1.time_ < 0 + var_235_3 + arg_235_0 and not isNil(var_235_2) and arg_232_1.var_.characterEffect10131ui_story then
				arg_232_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_232_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_235_4 = 0
			local var_235_5 = 0.425

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_6 = arg_232_1:GetWordFromCfg(322171057)
				local var_235_7 = arg_232_1:FormatText(var_235_6.content)

				arg_232_1.text_.text = var_235_7

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_9 = 17 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 17)

				if (17 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 17)) > 0 and var_235_5 < var_235_9 then
					arg_232_1.talkMaxDuration = var_235_9

					if var_235_9 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_4
					end
				end

				arg_232_1.text_.text = var_235_7
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171057", "story_v_out_322171.awb") ~= 0 then
					local var_235_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171057", "story_v_out_322171.awb") / 1000

					if var_235_10 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_4
					end

					if var_235_6.prefab_name ~= "" and arg_232_1.actors_[var_235_6.prefab_name] ~= nil then
						local var_235_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_6.prefab_name].transform, "story_v_out_322171", "322171057", "story_v_out_322171.awb")

						arg_232_1:RecordAudio("322171057", var_235_11)
						arg_232_1:RecordAudio("322171057", var_235_11)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_322171", "322171057", "story_v_out_322171.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_322171", "322171057", "story_v_out_322171.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_12 = math.max(var_235_5, arg_232_1.talkMaxDuration)

			if var_235_4 <= arg_232_1.time_ and arg_232_1.time_ < var_235_4 + var_235_12 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_4) / var_235_12

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_4 + var_235_12 and arg_232_1.time_ < var_235_4 + var_235_12 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play322171058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 322171058
		arg_236_1.duration_ = 13.47

		local var_236_0 = {
			zh = 10.3,
			ja = 13.466
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play322171059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 1.225

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_1 = arg_236_1:GetWordFromCfg(322171058)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 49 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 49)

				if (49 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 49)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171058", "story_v_out_322171.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_322171", "322171058", "story_v_out_322171.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_322171", "322171058", "story_v_out_322171.awb")

						arg_236_1:RecordAudio("322171058", var_239_6)
						arg_236_1:RecordAudio("322171058", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_322171", "322171058", "story_v_out_322171.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_322171", "322171058", "story_v_out_322171.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play322171059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 322171059
		arg_240_1.duration_ = 8.53

		local var_240_0 = {
			zh = 5.333,
			ja = 8.533
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play322171060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_243_0 = 0
			local var_243_1 = 0.675

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(322171059)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 27 <= 0 and var_243_1 or var_243_1 * (utf8.len(var_243_3) / 27)

				if (27 <= 0 and var_243_1 or var_243_1 * (utf8.len(var_243_3) / 27)) > 0 and var_243_1 < var_243_5 then
					arg_240_1.talkMaxDuration = var_243_5

					if var_243_5 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171059", "story_v_out_322171.awb") ~= 0 then
					local var_243_6 = manager.audio:GetVoiceLength("story_v_out_322171", "322171059", "story_v_out_322171.awb") / 1000

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end

					if var_243_2.prefab_name ~= "" and arg_240_1.actors_[var_243_2.prefab_name] ~= nil then
						local var_243_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_2.prefab_name].transform, "story_v_out_322171", "322171059", "story_v_out_322171.awb")

						arg_240_1:RecordAudio("322171059", var_243_7)
						arg_240_1:RecordAudio("322171059", var_243_7)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_322171", "322171059", "story_v_out_322171.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_322171", "322171059", "story_v_out_322171.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_8 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_8 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_8

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_8 and arg_240_1.time_ < var_243_0 + var_243_8 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play322171060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 322171060
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play322171061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1111ui_story = arg_244_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1111ui_story"].transform.position).z)
				arg_244_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1111ui_story"].transform.localEulerAngles = arg_244_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_244_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1111ui_story"].transform.position).z)
				arg_244_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1111ui_story"].transform.localEulerAngles = arg_244_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["10131ui_story"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos10131ui_story = var_247_1.localPosition
			end

			local var_247_2 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 then
				var_247_1.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_2)
				var_247_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_1.position).x, (manager.ui.mainCamera.transform.position - var_247_1.position).y, (manager.ui.mainCamera.transform.position - var_247_1.position).z)
				var_247_1.localEulerAngles.z = 0
				var_247_1.localEulerAngles.x = 0
				var_247_1.localEulerAngles = var_247_1.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 then
				var_247_1.localPosition = Vector3.New(0, 100, 0)
				var_247_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_1.position).x, (manager.ui.mainCamera.transform.position - var_247_1.position).y, (manager.ui.mainCamera.transform.position - var_247_1.position).z)
				var_247_1.localEulerAngles.z = 0
				var_247_1.localEulerAngles.x = 0
				var_247_1.localEulerAngles = var_247_1.localEulerAngles
			end

			if 0.1 < arg_244_1.time_ and arg_244_1.time_ <= 0.1 + arg_247_0 then
				arg_244_1:AudioAction("play", "effect", "se_story_138", "se_story_138_clap", "")
			end

			local var_247_4 = 0
			local var_247_5 = 0.7

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_6 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(322171060).content)

				arg_244_1.text_.text = var_247_6

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_8 = 28 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_6) / 28)

				if (28 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_6) / 28)) > 0 and var_247_5 < var_247_8 then
					arg_244_1.talkMaxDuration = var_247_8

					if var_247_8 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_6
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_9 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_9 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_9

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_9 and arg_244_1.time_ < var_247_4 + var_247_9 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play322171061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 322171061
		arg_248_1.duration_ = 7.8

		local var_248_0 = {
			zh = 5.5,
			ja = 7.8
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play322171062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1111ui_story = arg_248_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1111ui_story"].transform.position).z)
				arg_248_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1111ui_story"].transform.localEulerAngles = arg_248_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_248_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1111ui_story"].transform.position).z)
				arg_248_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1111ui_story"].transform.localEulerAngles = arg_248_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["1111ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1111ui_story == nil then
				arg_248_1.var_.characterEffect1111ui_story = var_251_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_2 and not isNil(var_251_1) then
				if arg_248_1.var_.characterEffect1111ui_story and not isNil(var_251_1) then
					arg_248_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_2 and arg_248_1.time_ < 0 + var_251_2 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1111ui_story then
				arg_248_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_251_4 = 0
			local var_251_5 = 0.575

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_6 = arg_248_1:GetWordFromCfg(322171061)
				local var_251_7 = arg_248_1:FormatText(var_251_6.content)

				arg_248_1.text_.text = var_251_7

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_9 = 23 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 23)

				if (23 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 23)) > 0 and var_251_5 < var_251_9 then
					arg_248_1.talkMaxDuration = var_251_9

					if var_251_9 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_9 + var_251_4
					end
				end

				arg_248_1.text_.text = var_251_7
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171061", "story_v_out_322171.awb") ~= 0 then
					local var_251_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171061", "story_v_out_322171.awb") / 1000

					if var_251_10 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_10 + var_251_4
					end

					if var_251_6.prefab_name ~= "" and arg_248_1.actors_[var_251_6.prefab_name] ~= nil then
						local var_251_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_6.prefab_name].transform, "story_v_out_322171", "322171061", "story_v_out_322171.awb")

						arg_248_1:RecordAudio("322171061", var_251_11)
						arg_248_1:RecordAudio("322171061", var_251_11)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_322171", "322171061", "story_v_out_322171.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_322171", "322171061", "story_v_out_322171.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_12 = math.max(var_251_5, arg_248_1.talkMaxDuration)

			if var_251_4 <= arg_248_1.time_ and arg_248_1.time_ < var_251_4 + var_251_12 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_4) / var_251_12

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_4 + var_251_12 and arg_248_1.time_ < var_251_4 + var_251_12 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play322171062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 322171062
		arg_252_1.duration_ = 2.63

		local var_252_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play322171063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10131ui_story = arg_252_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_255_0 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				arg_252_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10131ui_story"].transform.position).z)
				arg_252_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10131ui_story"].transform.localEulerAngles = arg_252_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				arg_252_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_252_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10131ui_story"].transform.position).z)
				arg_252_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10131ui_story"].transform.localEulerAngles = arg_252_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_255_1 = arg_252_1.actors_["10131ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_1) and arg_252_1.var_.characterEffect10131ui_story == nil then
				arg_252_1.var_.characterEffect10131ui_story = var_255_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_2 and not isNil(var_255_1) then
				if arg_252_1.var_.characterEffect10131ui_story and not isNil(var_255_1) then
					arg_252_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_2 and arg_252_1.time_ < 0 + var_255_2 + arg_255_0 and not isNil(var_255_1) and arg_252_1.var_.characterEffect10131ui_story then
				arg_252_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_255_4 = arg_252_1.actors_["1111ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_4) and arg_252_1.var_.characterEffect1111ui_story == nil then
				arg_252_1.var_.characterEffect1111ui_story = var_255_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_5 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_5 and not isNil(var_255_4) then
				if arg_252_1.var_.characterEffect1111ui_story and not isNil(var_255_4) then
					arg_252_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_5)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_5 and arg_252_1.time_ < 0 + var_255_5 + arg_255_0 and not isNil(var_255_4) and arg_252_1.var_.characterEffect1111ui_story then
				arg_252_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_255_6 = arg_252_1.actors_["1111ui_story"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1111ui_story = var_255_6.localPosition
			end

			local var_255_7 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				var_255_6.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_252_1.time_ - 0) / var_255_7)
				var_255_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_6.position).x, (manager.ui.mainCamera.transform.position - var_255_6.position).y, (manager.ui.mainCamera.transform.position - var_255_6.position).z)
				var_255_6.localEulerAngles.z = 0
				var_255_6.localEulerAngles.x = 0
				var_255_6.localEulerAngles = var_255_6.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				var_255_6.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_255_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_6.position).x, (manager.ui.mainCamera.transform.position - var_255_6.position).y, (manager.ui.mainCamera.transform.position - var_255_6.position).z)
				var_255_6.localEulerAngles.z = 0
				var_255_6.localEulerAngles.x = 0
				var_255_6.localEulerAngles = var_255_6.localEulerAngles
			end

			local var_255_8 = 0
			local var_255_9 = 0.075

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_10 = arg_252_1:GetWordFromCfg(322171062)
				local var_255_11 = arg_252_1:FormatText(var_255_10.content)

				arg_252_1.text_.text = var_255_11

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_13 = 3 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 3)

				if (3 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 3)) > 0 and var_255_9 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_8
					end
				end

				arg_252_1.text_.text = var_255_11
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171062", "story_v_out_322171.awb") ~= 0 then
					local var_255_14 = manager.audio:GetVoiceLength("story_v_out_322171", "322171062", "story_v_out_322171.awb") / 1000

					if var_255_14 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_14 + var_255_8
					end

					if var_255_10.prefab_name ~= "" and arg_252_1.actors_[var_255_10.prefab_name] ~= nil then
						local var_255_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_10.prefab_name].transform, "story_v_out_322171", "322171062", "story_v_out_322171.awb")

						arg_252_1:RecordAudio("322171062", var_255_15)
						arg_252_1:RecordAudio("322171062", var_255_15)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_322171", "322171062", "story_v_out_322171.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_322171", "322171062", "story_v_out_322171.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_16 = math.max(var_255_9, arg_252_1.talkMaxDuration)

			if var_255_8 <= arg_252_1.time_ and arg_252_1.time_ < var_255_8 + var_255_16 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_8) / var_255_16

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_8 + var_255_16 and arg_252_1.time_ < var_255_8 + var_255_16 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play322171063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 322171063
		arg_256_1.duration_ = 7.1

		local var_256_0 = {
			zh = 5.8,
			ja = 7.1
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play322171064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1111ui_story"]) and arg_256_1.var_.characterEffect1111ui_story == nil then
				arg_256_1.var_.characterEffect1111ui_story = arg_256_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1111ui_story"]) then
				if arg_256_1.var_.characterEffect1111ui_story and not isNil(arg_256_1.actors_["1111ui_story"]) then
					arg_256_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1111ui_story"]) and arg_256_1.var_.characterEffect1111ui_story then
				arg_256_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_259_2 = arg_256_1.actors_["10131ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.characterEffect10131ui_story == nil then
				arg_256_1.var_.characterEffect10131ui_story = var_259_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_3 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_3 and not isNil(var_259_2) then
				if arg_256_1.var_.characterEffect10131ui_story and not isNil(var_259_2) then
					arg_256_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_256_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_3)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_3 and arg_256_1.time_ < 0 + var_259_3 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.characterEffect10131ui_story then
				arg_256_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_256_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_259_4 = 0
			local var_259_5 = 0.5

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:GetWordFromCfg(322171063)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_9 = 20 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 20)

				if (20 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 20)) > 0 and var_259_5 < var_259_9 then
					arg_256_1.talkMaxDuration = var_259_9

					if var_259_9 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_9 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171063", "story_v_out_322171.awb") ~= 0 then
					local var_259_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171063", "story_v_out_322171.awb") / 1000

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end

					if var_259_6.prefab_name ~= "" and arg_256_1.actors_[var_259_6.prefab_name] ~= nil then
						local var_259_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_6.prefab_name].transform, "story_v_out_322171", "322171063", "story_v_out_322171.awb")

						arg_256_1:RecordAudio("322171063", var_259_11)
						arg_256_1:RecordAudio("322171063", var_259_11)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_322171", "322171063", "story_v_out_322171.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_322171", "322171063", "story_v_out_322171.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_12 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_12 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_12

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_12 and arg_256_1.time_ < var_259_4 + var_259_12 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play322171064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 322171064
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play322171065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1111ui_story = arg_260_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_263_0 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 then
				arg_260_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_260_1.time_ - 0) / var_263_0)
				arg_260_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1111ui_story"].transform.position).z)
				arg_260_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1111ui_story"].transform.localEulerAngles = arg_260_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 then
				arg_260_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1111ui_story"].transform.position).z)
				arg_260_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1111ui_story"].transform.localEulerAngles = arg_260_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_263_1 = arg_260_1.actors_["10131ui_story"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10131ui_story = var_263_1.localPosition
			end

			local var_263_2 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_2 then
				var_263_1.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_260_1.time_ - 0) / var_263_2)
				var_263_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_1.position).x, (manager.ui.mainCamera.transform.position - var_263_1.position).y, (manager.ui.mainCamera.transform.position - var_263_1.position).z)
				var_263_1.localEulerAngles.z = 0
				var_263_1.localEulerAngles.x = 0
				var_263_1.localEulerAngles = var_263_1.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_2 and arg_260_1.time_ < 0 + var_263_2 + arg_263_0 then
				var_263_1.localPosition = Vector3.New(0, 100, 0)
				var_263_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_1.position).x, (manager.ui.mainCamera.transform.position - var_263_1.position).y, (manager.ui.mainCamera.transform.position - var_263_1.position).z)
				var_263_1.localEulerAngles.z = 0
				var_263_1.localEulerAngles.x = 0
				var_263_1.localEulerAngles = var_263_1.localEulerAngles
			end

			if 0.933333333333333 < arg_260_1.time_ and arg_260_1.time_ <= 0.933333333333333 + arg_263_0 then
				arg_260_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_fall", "")
			end

			local var_263_4 = 0
			local var_263_5 = 1.525

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_6 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(322171064).content)

				arg_260_1.text_.text = var_263_6

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_8 = 61 <= 0 and var_263_5 or var_263_5 * (utf8.len(var_263_6) / 61)

				if (61 <= 0 and var_263_5 or var_263_5 * (utf8.len(var_263_6) / 61)) > 0 and var_263_5 < var_263_8 then
					arg_260_1.talkMaxDuration = var_263_8

					if var_263_8 + var_263_4 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_4
					end
				end

				arg_260_1.text_.text = var_263_6
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_9 = math.max(var_263_5, arg_260_1.talkMaxDuration)

			if var_263_4 <= arg_260_1.time_ and arg_260_1.time_ < var_263_4 + var_263_9 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_4) / var_263_9

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_4 + var_263_9 and arg_260_1.time_ < var_263_4 + var_263_9 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play322171065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 322171065
		arg_264_1.duration_ = 5.53

		local var_264_0 = {
			zh = 3.5,
			ja = 5.533
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
			arg_264_1.auto_ = false
		end

		function arg_264_1.playNext_(arg_266_0)
			arg_264_1.onStoryFinished_()
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1111ui_story"]) and arg_264_1.var_.characterEffect1111ui_story == nil then
				arg_264_1.var_.characterEffect1111ui_story = arg_264_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1111ui_story"]) then
				if arg_264_1.var_.characterEffect1111ui_story and not isNil(arg_264_1.actors_["1111ui_story"]) then
					arg_264_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1111ui_story"]) and arg_264_1.var_.characterEffect1111ui_story then
				arg_264_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_267_2 = arg_264_1.actors_["1111ui_story"].transform

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1111ui_story = var_267_2.localPosition
			end

			local var_267_3 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_3 then
				var_267_2.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_264_1.time_ - 0) / var_267_3)
				var_267_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_2.position).x, (manager.ui.mainCamera.transform.position - var_267_2.position).y, (manager.ui.mainCamera.transform.position - var_267_2.position).z)
				var_267_2.localEulerAngles.z = 0
				var_267_2.localEulerAngles.x = 0
				var_267_2.localEulerAngles = var_267_2.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_3 and arg_264_1.time_ < 0 + var_267_3 + arg_267_0 then
				var_267_2.localPosition = Vector3.New(0, -0.87, -5.7)
				var_267_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_2.position).x, (manager.ui.mainCamera.transform.position - var_267_2.position).y, (manager.ui.mainCamera.transform.position - var_267_2.position).z)
				var_267_2.localEulerAngles.z = 0
				var_267_2.localEulerAngles.x = 0
				var_267_2.localEulerAngles = var_267_2.localEulerAngles
			end

			local var_267_4 = 0
			local var_267_5 = 0.4

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_6 = arg_264_1:GetWordFromCfg(322171065)
				local var_267_7 = arg_264_1:FormatText(var_267_6.content)

				arg_264_1.text_.text = var_267_7

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_9 = 16 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 16)

				if (16 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 16)) > 0 and var_267_5 < var_267_9 then
					arg_264_1.talkMaxDuration = var_267_9

					if var_267_9 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_9 + var_267_4
					end
				end

				arg_264_1.text_.text = var_267_7
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322171", "322171065", "story_v_out_322171.awb") ~= 0 then
					local var_267_10 = manager.audio:GetVoiceLength("story_v_out_322171", "322171065", "story_v_out_322171.awb") / 1000

					if var_267_10 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_4
					end

					if var_267_6.prefab_name ~= "" and arg_264_1.actors_[var_267_6.prefab_name] ~= nil then
						local var_267_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_6.prefab_name].transform, "story_v_out_322171", "322171065", "story_v_out_322171.awb")

						arg_264_1:RecordAudio("322171065", var_267_11)
						arg_264_1:RecordAudio("322171065", var_267_11)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_322171", "322171065", "story_v_out_322171.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_322171", "322171065", "story_v_out_322171.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_12 = math.max(var_267_5, arg_264_1.talkMaxDuration)

			if var_267_4 <= arg_264_1.time_ and arg_264_1.time_ < var_267_4 + var_267_12 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_4) / var_267_12

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_4 + var_267_12 and arg_264_1.time_ < var_267_4 + var_267_12 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L09g",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_322171.awb"
	}
}
