return {
	Play321371001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321371001
		arg_1_1.duration_ = 4.4

		local var_1_0 = {
			zh = 3.5,
			ja = 4.4
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
				arg_1_0:Play321371002(arg_1_1)
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_18 = arg_1_1:GetWordFromCfg(321371001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 7 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 7)

				if (7 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 7)) > 0 and var_4_16 < var_4_21 then
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

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371001", "story_v_out_321371.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_321371", "321371001", "story_v_out_321371.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_321371", "321371001", "story_v_out_321371.awb")

						arg_1_1:RecordAudio("321371001", var_4_23)
						arg_1_1:RecordAudio("321371001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321371", "321371001", "story_v_out_321371.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321371", "321371001", "story_v_out_321371.awb")
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
	Play321371002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321371002
		arg_9_1.duration_ = 3.97

		local var_9_0 = {
			zh = 3.966,
			ja = 3.1
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321371003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.425

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(321371002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 17 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 17)

				if (17 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 17)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371002", "story_v_out_321371.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371002", "story_v_out_321371.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_321371", "321371002", "story_v_out_321371.awb")

						arg_9_1:RecordAudio("321371002", var_12_6)
						arg_9_1:RecordAudio("321371002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_321371", "321371002", "story_v_out_321371.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_321371", "321371002", "story_v_out_321371.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play321371003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321371003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321371004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.425

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(321371003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 57 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 57)

				if (57 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 57)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play321371004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321371004
		arg_17_1.duration_ = 4.3

		local var_17_0 = {
			zh = 3.466,
			ja = 4.3
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
				arg_17_0:Play321371005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1111ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1111ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1111ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1111ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1111ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1111ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1111ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1111ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1111ui_story == nil then
				arg_17_1.var_.characterEffect1111ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1111ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1111ui_story then
				arg_17_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_20_8 = 0
			local var_20_9 = 0.3

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(321371004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 12 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 12)

				if (12 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 12)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371004", "story_v_out_321371.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_321371", "321371004", "story_v_out_321371.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_321371", "321371004", "story_v_out_321371.awb")

						arg_17_1:RecordAudio("321371004", var_20_15)
						arg_17_1:RecordAudio("321371004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321371", "321371004", "story_v_out_321371.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321371", "321371004", "story_v_out_321371.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play321371005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321371005
		arg_21_1.duration_ = 2

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321371006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "10131ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["10131ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["10131ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["10131ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["10131ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["10131ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10131ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["10131ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect10131ui_story == nil then
				arg_21_1.var_.characterEffect10131ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect10131ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect10131ui_story then
				arg_21_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_24_8 = arg_21_1.actors_["1111ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect1111ui_story == nil then
				arg_21_1.var_.characterEffect1111ui_story = var_24_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_9 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 and not isNil(var_24_8) then
				if arg_21_1.var_.characterEffect1111ui_story and not isNil(var_24_8) then
					arg_21_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_9)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect1111ui_story then
				arg_21_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_24_10 = 0
			local var_24_11 = 0.075

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:GetWordFromCfg(321371005)
				local var_24_13 = arg_21_1:FormatText(var_24_12.content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 3 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 3)

				if (3 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 3)) > 0 and var_24_11 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371005", "story_v_out_321371.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_321371", "321371005", "story_v_out_321371.awb") / 1000

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end

					if var_24_12.prefab_name ~= "" and arg_21_1.actors_[var_24_12.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_12.prefab_name].transform, "story_v_out_321371", "321371005", "story_v_out_321371.awb")

						arg_21_1:RecordAudio("321371005", var_24_17)
						arg_21_1:RecordAudio("321371005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321371", "321371005", "story_v_out_321371.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321371", "321371005", "story_v_out_321371.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_18 and arg_21_1.time_ < var_24_10 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play321371006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321371006
		arg_25_1.duration_ = 5.3

		local var_25_0 = {
			zh = 4.833,
			ja = 5.3
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
				arg_25_0:Play321371007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1111ui_story = arg_25_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).z)
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles = arg_25_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_25_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).z)
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles = arg_25_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1111ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1111ui_story == nil then
				arg_25_1.var_.characterEffect1111ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1111ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1111ui_story then
				arg_25_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_28_4 = arg_25_1.actors_["10131ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect10131ui_story == nil then
				arg_25_1.var_.characterEffect10131ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_5 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_4) then
				if arg_25_1.var_.characterEffect10131ui_story and not isNil(var_28_4) then
					arg_25_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_5)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect10131ui_story then
				arg_25_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_28_6 = 0
			local var_28_7 = 0.475

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(321371006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 19 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 19)

				if (19 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 19)) > 0 and var_28_7 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371006", "story_v_out_321371.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371006", "story_v_out_321371.awb") / 1000

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_out_321371", "321371006", "story_v_out_321371.awb")

						arg_25_1:RecordAudio("321371006", var_28_13)
						arg_25_1:RecordAudio("321371006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321371", "321371006", "story_v_out_321371.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321371", "321371006", "story_v_out_321371.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play321371007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321371007
		arg_29_1.duration_ = 6.83

		local var_29_0 = {
			zh = 5.733,
			ja = 6.833
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
				arg_29_0:Play321371008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1111ui_story = arg_29_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1111ui_story"].transform.position).z)
				arg_29_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1111ui_story"].transform.localEulerAngles = arg_29_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_29_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1111ui_story"].transform.position).z)
				arg_29_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1111ui_story"].transform.localEulerAngles = arg_29_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_1 = 0
			local var_32_2 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(321371007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 29 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 29)

				if (29 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 29)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371007", "story_v_out_321371.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_321371", "321371007", "story_v_out_321371.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_321371", "321371007", "story_v_out_321371.awb")

						arg_29_1:RecordAudio("321371007", var_32_8)
						arg_29_1:RecordAudio("321371007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321371", "321371007", "story_v_out_321371.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321371", "321371007", "story_v_out_321371.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_9 and arg_29_1.time_ < var_32_1 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play321371008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321371008
		arg_33_1.duration_ = 8.07

		local var_33_0 = {
			zh = 5.7,
			ja = 8.066
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play321371009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1111ui_story = arg_33_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).z)
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles = arg_33_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_33_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).z)
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles = arg_33_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_36_1 = 0
			local var_36_2 = 0.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(321371008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 24 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 24)

				if (24 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 24)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371008", "story_v_out_321371.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_321371", "321371008", "story_v_out_321371.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_321371", "321371008", "story_v_out_321371.awb")

						arg_33_1:RecordAudio("321371008", var_36_8)
						arg_33_1:RecordAudio("321371008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321371", "321371008", "story_v_out_321371.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321371", "321371008", "story_v_out_321371.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play321371009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321371009
		arg_37_1.duration_ = 3.9

		local var_37_0 = {
			zh = 2.866,
			ja = 3.9
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
				arg_37_0:Play321371010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10131ui_story = arg_37_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).z)
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles = arg_37_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_37_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).z)
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles = arg_37_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10131ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10131ui_story == nil then
				arg_37_1.var_.characterEffect10131ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10131ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10131ui_story then
				arg_37_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["1111ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1111ui_story == nil then
				arg_37_1.var_.characterEffect1111ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect1111ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1111ui_story then
				arg_37_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131actionlink/10131action456")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_40_6 = 0
			local var_40_7 = 0.35

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(321371009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 14 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 14)

				if (14 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 14)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371009", "story_v_out_321371.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371009", "story_v_out_321371.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_321371", "321371009", "story_v_out_321371.awb")

						arg_37_1:RecordAudio("321371009", var_40_13)
						arg_37_1:RecordAudio("321371009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321371", "321371009", "story_v_out_321371.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321371", "321371009", "story_v_out_321371.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play321371010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321371010
		arg_41_1.duration_ = 3.47

		local var_41_0 = {
			zh = 2.66633333333333,
			ja = 3.46633333333333
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play321371011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1111ui_story = arg_41_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).z)
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles = arg_41_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_41_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).z)
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles = arg_41_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1111ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1111ui_story == nil then
				arg_41_1.var_.characterEffect1111ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1111ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1111ui_story then
				arg_41_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["10131ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect10131ui_story == nil then
				arg_41_1.var_.characterEffect10131ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect10131ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect10131ui_story then
				arg_41_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_44_6 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_6 + 0.908333333333333 and arg_41_1.time_ < var_44_6 + 0.908333333333333 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_7 = 0.733333333333333
			local var_44_8 = 0.175

			if 0.733333333333333 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_9 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_9:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(321371010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 7 <= 0 and var_44_8 or var_44_8 * (utf8.len(var_44_11) / 7)

				if (7 <= 0 and var_44_8 or var_44_8 * (utf8.len(var_44_11) / 7)) > 0 and var_44_8 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13
					var_44_7 = var_44_7 + 0.3

					if var_44_13 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_7
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371010", "story_v_out_321371.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_321371", "321371010", "story_v_out_321371.awb") / 1000

					if var_44_14 + var_44_7 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_7
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_321371", "321371010", "story_v_out_321371.awb")

						arg_41_1:RecordAudio("321371010", var_44_15)
						arg_41_1:RecordAudio("321371010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321371", "321371010", "story_v_out_321371.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321371", "321371010", "story_v_out_321371.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = var_44_7 + 0.3
			local var_44_17 = math.max(var_44_8, arg_41_1.talkMaxDuration)

			if var_44_7 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_16) / var_44_17

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play321371011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321371011
		arg_47_1.duration_ = 5.03

		local var_47_0 = {
			zh = 3.9,
			ja = 5.033
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
				arg_47_0:Play321371012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10131ui_story = arg_47_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10131ui_story"].transform.position).z)
				arg_47_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10131ui_story"].transform.localEulerAngles = arg_47_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_47_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10131ui_story"].transform.position).z)
				arg_47_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10131ui_story"].transform.localEulerAngles = arg_47_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["10131ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10131ui_story == nil then
				arg_47_1.var_.characterEffect10131ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect10131ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10131ui_story then
				arg_47_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_50_4 = arg_47_1.actors_["1111ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1111ui_story == nil then
				arg_47_1.var_.characterEffect1111ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_5 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.characterEffect1111ui_story and not isNil(var_50_4) then
					arg_47_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_5)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1111ui_story then
				arg_47_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_50_6 = 0
			local var_50_7 = 0.45

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_8 = arg_47_1:GetWordFromCfg(321371011)
				local var_50_9 = arg_47_1:FormatText(var_50_8.content)

				arg_47_1.text_.text = var_50_9

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 18 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_9) / 18)

				if (18 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_9) / 18)) > 0 and var_50_7 < var_50_11 then
					arg_47_1.talkMaxDuration = var_50_11

					if var_50_11 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_9
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371011", "story_v_out_321371.awb") ~= 0 then
					local var_50_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371011", "story_v_out_321371.awb") / 1000

					if var_50_12 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_6
					end

					if var_50_8.prefab_name ~= "" and arg_47_1.actors_[var_50_8.prefab_name] ~= nil then
						local var_50_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_8.prefab_name].transform, "story_v_out_321371", "321371011", "story_v_out_321371.awb")

						arg_47_1:RecordAudio("321371011", var_50_13)
						arg_47_1:RecordAudio("321371011", var_50_13)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_321371", "321371011", "story_v_out_321371.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_321371", "321371011", "story_v_out_321371.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_14 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_14 and arg_47_1.time_ < var_50_6 + var_50_14 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play321371012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321371012
		arg_51_1.duration_ = 9.63

		local var_51_0 = {
			zh = 7.9,
			ja = 9.633
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
				arg_51_0:Play321371013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.975

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(321371012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 39 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 39)

				if (39 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 39)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371012", "story_v_out_321371.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371012", "story_v_out_321371.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_321371", "321371012", "story_v_out_321371.awb")

						arg_51_1:RecordAudio("321371012", var_54_6)
						arg_51_1:RecordAudio("321371012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_321371", "321371012", "story_v_out_321371.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_321371", "321371012", "story_v_out_321371.awb")
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
	Play321371013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321371013
		arg_55_1.duration_ = 7.83

		local var_55_0 = {
			zh = 5.4,
			ja = 7.833
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
				arg_55_0:Play321371014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1111ui_story = arg_55_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).z)
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles = arg_55_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_55_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1111ui_story"].transform.position).z)
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1111ui_story"].transform.localEulerAngles = arg_55_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1111ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1111ui_story == nil then
				arg_55_1.var_.characterEffect1111ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1111ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1111ui_story then
				arg_55_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_58_4 = arg_55_1.actors_["10131ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect10131ui_story == nil then
				arg_55_1.var_.characterEffect10131ui_story = var_58_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_5 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_5 and not isNil(var_58_4) then
				if arg_55_1.var_.characterEffect10131ui_story and not isNil(var_58_4) then
					arg_55_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_5)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_5 and arg_55_1.time_ < 0 + var_58_5 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect10131ui_story then
				arg_55_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_58_6 = 0
			local var_58_7 = 0.65

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_8 = arg_55_1:GetWordFromCfg(321371013)
				local var_58_9 = arg_55_1:FormatText(var_58_8.content)

				arg_55_1.text_.text = var_58_9

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 26 <= 0 and var_58_7 or var_58_7 * (utf8.len(var_58_9) / 26)

				if (26 <= 0 and var_58_7 or var_58_7 * (utf8.len(var_58_9) / 26)) > 0 and var_58_7 < var_58_11 then
					arg_55_1.talkMaxDuration = var_58_11

					if var_58_11 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_9
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371013", "story_v_out_321371.awb") ~= 0 then
					local var_58_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371013", "story_v_out_321371.awb") / 1000

					if var_58_12 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_6
					end

					if var_58_8.prefab_name ~= "" and arg_55_1.actors_[var_58_8.prefab_name] ~= nil then
						local var_58_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_8.prefab_name].transform, "story_v_out_321371", "321371013", "story_v_out_321371.awb")

						arg_55_1:RecordAudio("321371013", var_58_13)
						arg_55_1:RecordAudio("321371013", var_58_13)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_321371", "321371013", "story_v_out_321371.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_321371", "321371013", "story_v_out_321371.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_14 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_14 and arg_55_1.time_ < var_58_6 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play321371014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321371014
		arg_59_1.duration_ = 6

		local var_59_0 = {
			zh = 5.8,
			ja = 6
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
				arg_59_0:Play321371015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.775

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(321371014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 31 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 31)

				if (31 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 31)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371014", "story_v_out_321371.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371014", "story_v_out_321371.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_321371", "321371014", "story_v_out_321371.awb")

						arg_59_1:RecordAudio("321371014", var_62_6)
						arg_59_1:RecordAudio("321371014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_321371", "321371014", "story_v_out_321371.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_321371", "321371014", "story_v_out_321371.awb")
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
	Play321371015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321371015
		arg_63_1.duration_ = 11.07

		local var_63_0 = {
			zh = 7.6,
			ja = 11.066
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
				arg_63_0:Play321371016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.85

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(321371015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 34 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 34)

				if (34 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 34)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371015", "story_v_out_321371.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371015", "story_v_out_321371.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_321371", "321371015", "story_v_out_321371.awb")

						arg_63_1:RecordAudio("321371015", var_66_6)
						arg_63_1:RecordAudio("321371015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_321371", "321371015", "story_v_out_321371.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_321371", "321371015", "story_v_out_321371.awb")
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
	Play321371016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321371016
		arg_67_1.duration_ = 5.67

		local var_67_0 = {
			zh = 5.666,
			ja = 4.733
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
				arg_67_0:Play321371017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1111ui_story = arg_67_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1111ui_story"].transform.position).z)
				arg_67_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1111ui_story"].transform.localEulerAngles = arg_67_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_67_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1111ui_story"].transform.position).z)
				arg_67_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1111ui_story"].transform.localEulerAngles = arg_67_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_70_1 = 0
			local var_70_2 = 0.65

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(321371016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 26 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 26)

				if (26 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 26)) > 0 and var_70_2 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371016", "story_v_out_321371.awb") ~= 0 then
					local var_70_7 = manager.audio:GetVoiceLength("story_v_out_321371", "321371016", "story_v_out_321371.awb") / 1000

					if var_70_7 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_1
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_321371", "321371016", "story_v_out_321371.awb")

						arg_67_1:RecordAudio("321371016", var_70_8)
						arg_67_1:RecordAudio("321371016", var_70_8)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_321371", "321371016", "story_v_out_321371.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_321371", "321371016", "story_v_out_321371.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_9 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_9 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_9

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_9 and arg_67_1.time_ < var_70_1 + var_70_9 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play321371017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321371017
		arg_71_1.duration_ = 4.67

		local var_71_0 = {
			zh = 3.233,
			ja = 4.666
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play321371018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10131ui_story = arg_71_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10131ui_story"].transform.position).z)
				arg_71_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10131ui_story"].transform.localEulerAngles = arg_71_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_71_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10131ui_story"].transform.position).z)
				arg_71_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10131ui_story"].transform.localEulerAngles = arg_71_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["10131ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10131ui_story == nil then
				arg_71_1.var_.characterEffect10131ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect10131ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10131ui_story then
				arg_71_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_74_4 = arg_71_1.actors_["1111ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1111ui_story == nil then
				arg_71_1.var_.characterEffect1111ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_5 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 and not isNil(var_74_4) then
				if arg_71_1.var_.characterEffect1111ui_story and not isNil(var_74_4) then
					arg_71_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_5)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1111ui_story then
				arg_71_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_74_6 = 0
			local var_74_7 = 0.275

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(321371017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 11 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 11)

				if (11 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 11)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371017", "story_v_out_321371.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371017", "story_v_out_321371.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_321371", "321371017", "story_v_out_321371.awb")

						arg_71_1:RecordAudio("321371017", var_74_13)
						arg_71_1:RecordAudio("321371017", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_321371", "321371017", "story_v_out_321371.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_321371", "321371017", "story_v_out_321371.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play321371018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321371018
		arg_75_1.duration_ = 6.5

		local var_75_0 = {
			zh = 5.6,
			ja = 6.5
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play321371019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1111ui_story = arg_75_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).z)
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles = arg_75_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_75_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).z)
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles = arg_75_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["1111ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1111ui_story == nil then
				arg_75_1.var_.characterEffect1111ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect1111ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1111ui_story then
				arg_75_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_78_4 = arg_75_1.actors_["10131ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect10131ui_story == nil then
				arg_75_1.var_.characterEffect10131ui_story = var_78_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_5 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 and not isNil(var_78_4) then
				if arg_75_1.var_.characterEffect10131ui_story and not isNil(var_78_4) then
					arg_75_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_5)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect10131ui_story then
				arg_75_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2", "EmotionTimelineAnimator")
			end

			local var_78_6 = 0
			local var_78_7 = 0.65

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:GetWordFromCfg(321371018)
				local var_78_9 = arg_75_1:FormatText(var_78_8.content)

				arg_75_1.text_.text = var_78_9

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 26 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_9) / 26)

				if (26 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_9) / 26)) > 0 and var_78_7 < var_78_11 then
					arg_75_1.talkMaxDuration = var_78_11

					if var_78_11 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_9
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371018", "story_v_out_321371.awb") ~= 0 then
					local var_78_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371018", "story_v_out_321371.awb") / 1000

					if var_78_12 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_6
					end

					if var_78_8.prefab_name ~= "" and arg_75_1.actors_[var_78_8.prefab_name] ~= nil then
						local var_78_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_8.prefab_name].transform, "story_v_out_321371", "321371018", "story_v_out_321371.awb")

						arg_75_1:RecordAudio("321371018", var_78_13)
						arg_75_1:RecordAudio("321371018", var_78_13)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_321371", "321371018", "story_v_out_321371.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_321371", "321371018", "story_v_out_321371.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_14 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_14

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_14 and arg_75_1.time_ < var_78_6 + var_78_14 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play321371019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321371019
		arg_79_1.duration_ = 4.07

		local var_79_0 = {
			zh = 3.466,
			ja = 4.066
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play321371020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["10131ui_story"]) and arg_79_1.var_.characterEffect10131ui_story == nil then
				arg_79_1.var_.characterEffect10131ui_story = arg_79_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["10131ui_story"]) then
				if arg_79_1.var_.characterEffect10131ui_story and not isNil(arg_79_1.actors_["10131ui_story"]) then
					arg_79_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["10131ui_story"]) and arg_79_1.var_.characterEffect10131ui_story then
				arg_79_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_82_2 = arg_79_1.actors_["1111ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1111ui_story == nil then
				arg_79_1.var_.characterEffect1111ui_story = var_82_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_3 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.characterEffect1111ui_story and not isNil(var_82_2) then
					arg_79_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_3)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1111ui_story then
				arg_79_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_82_4 = 0
			local var_82_5 = 0.4

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(321371019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 16 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 16)

				if (16 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 16)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371019", "story_v_out_321371.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371019", "story_v_out_321371.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_321371", "321371019", "story_v_out_321371.awb")

						arg_79_1:RecordAudio("321371019", var_82_11)
						arg_79_1:RecordAudio("321371019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_321371", "321371019", "story_v_out_321371.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_321371", "321371019", "story_v_out_321371.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play321371020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321371020
		arg_83_1.duration_ = 6.83

		local var_83_0 = {
			zh = 6.833,
			ja = 6.133
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321371021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1111ui_story"]) and arg_83_1.var_.characterEffect1111ui_story == nil then
				arg_83_1.var_.characterEffect1111ui_story = arg_83_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1111ui_story"]) then
				if arg_83_1.var_.characterEffect1111ui_story and not isNil(arg_83_1.actors_["1111ui_story"]) then
					arg_83_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1111ui_story"]) and arg_83_1.var_.characterEffect1111ui_story then
				arg_83_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_86_2 = arg_83_1.actors_["10131ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect10131ui_story == nil then
				arg_83_1.var_.characterEffect10131ui_story = var_86_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_3 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.characterEffect10131ui_story and not isNil(var_86_2) then
					arg_83_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_3)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect10131ui_story then
				arg_83_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_86_4 = 0
			local var_86_5 = 0.75

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:GetWordFromCfg(321371020)
				local var_86_7 = arg_83_1:FormatText(var_86_6.content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 30 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 30)

				if (30 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 30)) > 0 and var_86_5 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371020", "story_v_out_321371.awb") ~= 0 then
					local var_86_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371020", "story_v_out_321371.awb") / 1000

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end

					if var_86_6.prefab_name ~= "" and arg_83_1.actors_[var_86_6.prefab_name] ~= nil then
						local var_86_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_6.prefab_name].transform, "story_v_out_321371", "321371020", "story_v_out_321371.awb")

						arg_83_1:RecordAudio("321371020", var_86_11)
						arg_83_1:RecordAudio("321371020", var_86_11)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_321371", "321371020", "story_v_out_321371.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_321371", "321371020", "story_v_out_321371.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_12 and arg_83_1.time_ < var_86_4 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play321371021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321371021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321371022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1111ui_story = arg_87_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1111ui_story"].transform.position).z)
				arg_87_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1111ui_story"].transform.localEulerAngles = arg_87_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1111ui_story"].transform.position).z)
				arg_87_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1111ui_story"].transform.localEulerAngles = arg_87_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["10131ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10131ui_story = var_90_1.localPosition
			end

			local var_90_2 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 then
				var_90_1.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_2)
				var_90_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_1.position).x, (manager.ui.mainCamera.transform.position - var_90_1.position).y, (manager.ui.mainCamera.transform.position - var_90_1.position).z)
				var_90_1.localEulerAngles.z = 0
				var_90_1.localEulerAngles.x = 0
				var_90_1.localEulerAngles = var_90_1.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 then
				var_90_1.localPosition = Vector3.New(0, 100, 0)
				var_90_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_1.position).x, (manager.ui.mainCamera.transform.position - var_90_1.position).y, (manager.ui.mainCamera.transform.position - var_90_1.position).z)
				var_90_1.localEulerAngles.z = 0
				var_90_1.localEulerAngles.x = 0
				var_90_1.localEulerAngles = var_90_1.localEulerAngles
			end

			local var_90_3 = arg_87_1.actors_["1111ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_3) and arg_87_1.var_.characterEffect1111ui_story == nil then
				arg_87_1.var_.characterEffect1111ui_story = var_90_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_4 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 and not isNil(var_90_3) then
				if arg_87_1.var_.characterEffect1111ui_story and not isNil(var_90_3) then
					arg_87_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_4)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 and not isNil(var_90_3) and arg_87_1.var_.characterEffect1111ui_story then
				arg_87_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_90_5 = 0
			local var_90_6 = 0.925

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_7 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(321371021).content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 37 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_7) / 37)

				if (37 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_7) / 37)) > 0 and var_90_6 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_5
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_6, arg_87_1.talkMaxDuration)

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_5) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_5 + var_90_10 and arg_87_1.time_ < var_90_5 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play321371022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321371022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play321371023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0.05 < arg_91_1.time_ and arg_91_1.time_ <= 0.05 + arg_94_0 then
				arg_91_1:AudioAction("play", "effect", "se_story_141", "se_story_141_sword_aim", "")
			end

			local var_94_1 = 0
			local var_94_2 = 1.025

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(321371022).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 41 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 41)

				if (41 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 41)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play321371023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321371023
		arg_95_1.duration_ = 5.3

		local var_95_0 = {
			zh = 5,
			ja = 5.3
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play321371024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1111ui_story = arg_95_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1111ui_story"].transform.position).z)
				arg_95_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1111ui_story"].transform.localEulerAngles = arg_95_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_95_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1111ui_story"].transform.position).z)
				arg_95_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1111ui_story"].transform.localEulerAngles = arg_95_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1111ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1111ui_story == nil then
				arg_95_1.var_.characterEffect1111ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1111ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1111ui_story then
				arg_95_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_98_4 = 0
			local var_98_5 = 0.55

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(321371023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 22 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 22)

				if (22 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 22)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371023", "story_v_out_321371.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371023", "story_v_out_321371.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_321371", "321371023", "story_v_out_321371.awb")

						arg_95_1:RecordAudio("321371023", var_98_11)
						arg_95_1:RecordAudio("321371023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321371", "321371023", "story_v_out_321371.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321371", "321371023", "story_v_out_321371.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play321371024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321371024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321371025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1111ui_story = arg_99_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1111ui_story"].transform.position).z)
				arg_99_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1111ui_story"].transform.localEulerAngles = arg_99_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1111ui_story"].transform.position).z)
				arg_99_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1111ui_story"].transform.localEulerAngles = arg_99_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1111ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1111ui_story == nil then
				arg_99_1.var_.characterEffect1111ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1111ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_2)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1111ui_story then
				arg_99_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_102_3 = 0
			local var_102_4 = 0.775

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_5 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(321371024).content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 31 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 31)

				if (31 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 31)) > 0 and var_102_4 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_3
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_4, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_3) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_8 and arg_99_1.time_ < var_102_3 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play321371025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321371025
		arg_103_1.duration_ = 7.87

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play321371026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_9000

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_0 = 1.4

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				local var_106_1 = Color.New(1, 1, 1)

				var_106_1.a = Mathf.Lerp(0, 1, (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.mask_.color = var_106_1
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				local var_106_2 = Color.New(1, 1, 1)

				var_106_2.a = 1
				arg_103_1.mask_.color = var_106_2
			end

			local var_106_3 = 1.4

			if 1.4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_4 = 1.6

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_4 then
				local var_106_5 = Color.New(1, 1, 1)

				var_106_5.a = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_3) / var_106_4)
				arg_103_1.mask_.color = var_106_5
			end

			if arg_103_1.time_ >= var_106_3 + var_106_4 and arg_103_1.time_ < var_106_3 + var_106_4 + arg_106_0 then
				local var_106_6 = Color.New(1, 1, 1)

				arg_103_1.mask_.enabled = false
				var_106_6.a = 0
				arg_103_1.mask_.color = var_106_6
			end

			if 1.4 < arg_103_1.time_ and arg_103_1.time_ <= 1.4 + arg_106_0 then
				local var_106_7 = arg_103_1.var_.effectsuipian1

				if not arg_103_1.var_.effectsuipian1 then
					var_106_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), manager.ui.mainCamera.transform)
					var_106_7.name = "suipian1"
					arg_103_1.var_.effectsuipian1 = var_106_7
				else
					var_106_7.transform:SetParent(var_106_9000)
				end

				var_106_7.transform.localPosition = Vector3.New(0, 0, -10)
				var_106_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_106_9 = arg_103_1.bgs_.L09g.transform

			if 1.4 < arg_103_1.time_ and arg_103_1.time_ <= 1.4 + arg_106_0 then
				arg_103_1.var_.moveOldPosL09g = var_106_9.localPosition
			end

			local var_106_10 = 0.001

			if 1.4 <= arg_103_1.time_ and arg_103_1.time_ < 1.4 + var_106_10 then
				var_106_9.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPosL09g, Vector3.New(0, 1, 10), (arg_103_1.time_ - 1.4) / var_106_10)
			end

			if arg_103_1.time_ >= 1.4 + var_106_10 and arg_103_1.time_ < 1.4 + var_106_10 + arg_106_0 then
				var_106_9.localPosition = Vector3.New(0, 1, 10)
			end

			local var_106_11 = arg_103_1.bgs_.L09g.transform

			if 1.434 < arg_103_1.time_ and arg_103_1.time_ <= 1.434 + arg_106_0 then
				arg_103_1.var_.moveOldPosL09g = var_106_11.localPosition
			end

			local var_106_12 = 2.13266666666667

			if 1.434 <= arg_103_1.time_ and arg_103_1.time_ < 1.434 + var_106_12 then
				var_106_11.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPosL09g, Vector3.New(0, 1, 9.5), (arg_103_1.time_ - 1.434) / var_106_12)
			end

			if arg_103_1.time_ >= 1.434 + var_106_12 and arg_103_1.time_ < 1.434 + var_106_12 + arg_106_0 then
				var_106_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 1.36733333333333 < arg_103_1.time_ and arg_103_1.time_ <= 1.36733333333333 + arg_106_0 then
				local var_106_13 = arg_103_1.bgs_.L09g

				arg_103_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_106_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_14 = var_106_13:GetComponent("SpriteRenderer")

				if var_106_14 and var_106_14.sprite then
					local var_106_15 = 2 * (var_106_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_106_13.transform.localScale = Vector3.New(var_106_15 / var_106_14.sprite.bounds.size.y < var_106_15 * manager.ui.mainCameraCom_.aspect / var_106_14.sprite.bounds.size.x and var_106_15 * manager.ui.mainCameraCom_.aspect / var_106_14.sprite.bounds.size.x or var_106_15 / var_106_14.sprite.bounds.size.y, var_106_15 / var_106_14.sprite.bounds.size.y < var_106_15 * manager.ui.mainCameraCom_.aspect / var_106_14.sprite.bounds.size.x and var_106_15 * manager.ui.mainCameraCom_.aspect / var_106_14.sprite.bounds.size.x or var_106_15 / var_106_14.sprite.bounds.size.y, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "L09g" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_16 = 2.7

			if 2.7 < arg_103_1.time_ and arg_103_1.time_ <= var_106_16 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			if arg_103_1.time_ >= var_106_16 + 0.933333333333333 and arg_103_1.time_ < var_106_16 + 0.933333333333333 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_140", "se_story_140_reaction", "")
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_18 = 2.86666666666667
			local var_106_19 = 1.2

			if 2.86666666666667 < arg_103_1.time_ and arg_103_1.time_ <= var_106_18 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_20 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_20:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_21 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(321371025).content)

				arg_103_1.text_.text = var_106_21

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_23 = 48 <= 0 and var_106_19 or var_106_19 * (utf8.len(var_106_21) / 48)

				if (48 <= 0 and var_106_19 or var_106_19 * (utf8.len(var_106_21) / 48)) > 0 and var_106_19 < var_106_23 then
					arg_103_1.talkMaxDuration = var_106_23
					var_106_18 = var_106_18 + 0.3

					if var_106_23 + var_106_18 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_18
					end
				end

				arg_103_1.text_.text = var_106_21
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_24 = var_106_18 + 0.3
			local var_106_25 = math.max(var_106_19, arg_103_1.talkMaxDuration)

			if var_106_18 + 0.3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_24 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_24) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_24 + var_106_25 and arg_103_1.time_ < var_106_24 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "L09g",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "L09g",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.13266666666667,
				className = "StoryMoveNode",
				startTime = 1.434,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play321371026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321371026
		arg_109_1.duration_ = 1.7

		local var_109_0 = {
			zh = 1.466,
			ja = 1.7
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321371027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1111ui_story = arg_109_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1111ui_story"].transform.position).z)
				arg_109_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1111ui_story"].transform.localEulerAngles = arg_109_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_109_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1111ui_story"].transform.position).z)
				arg_109_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1111ui_story"].transform.localEulerAngles = arg_109_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1111ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1111ui_story == nil then
				arg_109_1.var_.characterEffect1111ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1111ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1111ui_story then
				arg_109_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_112_4 = 0
			local var_112_5 = 0.15

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(321371026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 6 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 6)

				if (6 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 6)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371026", "story_v_out_321371.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371026", "story_v_out_321371.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_321371", "321371026", "story_v_out_321371.awb")

						arg_109_1:RecordAudio("321371026", var_112_11)
						arg_109_1:RecordAudio("321371026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_321371", "321371026", "story_v_out_321371.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_321371", "321371026", "story_v_out_321371.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play321371027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321371027
		arg_113_1.duration_ = 7.07

		local var_113_0 = {
			zh = 7.066,
			ja = 6.6
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play321371028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10131ui_story = arg_113_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10131ui_story"].transform.position).z)
				arg_113_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10131ui_story"].transform.localEulerAngles = arg_113_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_113_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10131ui_story"].transform.position).z)
				arg_113_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10131ui_story"].transform.localEulerAngles = arg_113_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10131ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10131ui_story == nil then
				arg_113_1.var_.characterEffect10131ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10131ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10131ui_story then
				arg_113_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_116_4 = arg_113_1.actors_["1111ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1111ui_story == nil then
				arg_113_1.var_.characterEffect1111ui_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_5 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 and not isNil(var_116_4) then
				if arg_113_1.var_.characterEffect1111ui_story and not isNil(var_116_4) then
					arg_113_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_5)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1111ui_story then
				arg_113_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_116_6 = 0
			local var_116_7 = 0.7

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(321371027)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 28 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 28)

				if (28 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 28)) > 0 and var_116_7 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371027", "story_v_out_321371.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371027", "story_v_out_321371.awb") / 1000

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end

					if var_116_8.prefab_name ~= "" and arg_113_1.actors_[var_116_8.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_8.prefab_name].transform, "story_v_out_321371", "321371027", "story_v_out_321371.awb")

						arg_113_1:RecordAudio("321371027", var_116_13)
						arg_113_1:RecordAudio("321371027", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_321371", "321371027", "story_v_out_321371.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_321371", "321371027", "story_v_out_321371.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play321371028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321371028
		arg_117_1.duration_ = 2.5

		local var_117_0 = {
			zh = 2.3,
			ja = 2.5
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play321371029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1111ui_story = arg_117_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1111ui_story"].transform.position).z)
				arg_117_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1111ui_story"].transform.localEulerAngles = arg_117_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_117_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1111ui_story"].transform.position).z)
				arg_117_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1111ui_story"].transform.localEulerAngles = arg_117_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1111ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1111ui_story == nil then
				arg_117_1.var_.characterEffect1111ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1111ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1111ui_story then
				arg_117_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_120_4 = arg_117_1.actors_["10131ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect10131ui_story == nil then
				arg_117_1.var_.characterEffect10131ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_5 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 and not isNil(var_120_4) then
				if arg_117_1.var_.characterEffect10131ui_story and not isNil(var_120_4) then
					arg_117_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_5)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect10131ui_story then
				arg_117_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_120_6 = 0
			local var_120_7 = 0.25

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(321371028)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 10 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 10)

				if (10 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 10)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371028", "story_v_out_321371.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371028", "story_v_out_321371.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_321371", "321371028", "story_v_out_321371.awb")

						arg_117_1:RecordAudio("321371028", var_120_13)
						arg_117_1:RecordAudio("321371028", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321371", "321371028", "story_v_out_321371.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321371", "321371028", "story_v_out_321371.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play321371029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 321371029
		arg_121_1.duration_ = 4.4

		local var_121_0 = {
			zh = 4.1,
			ja = 4.4
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
				arg_121_0:Play321371030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10131ui_story = arg_121_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).z)
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles = arg_121_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_121_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).z)
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles = arg_121_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["10131ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10131ui_story == nil then
				arg_121_1.var_.characterEffect10131ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10131ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10131ui_story then
				arg_121_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_124_4 = arg_121_1.actors_["1111ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1111ui_story == nil then
				arg_121_1.var_.characterEffect1111ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_5 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 and not isNil(var_124_4) then
				if arg_121_1.var_.characterEffect1111ui_story and not isNil(var_124_4) then
					arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_5)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1111ui_story then
				arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_124_6 = 0
			local var_124_7 = 0.475

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(321371029)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 19 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 19)

				if (19 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 19)) > 0 and var_124_7 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371029", "story_v_out_321371.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371029", "story_v_out_321371.awb") / 1000

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end

					if var_124_8.prefab_name ~= "" and arg_121_1.actors_[var_124_8.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_8.prefab_name].transform, "story_v_out_321371", "321371029", "story_v_out_321371.awb")

						arg_121_1:RecordAudio("321371029", var_124_13)
						arg_121_1:RecordAudio("321371029", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_321371", "321371029", "story_v_out_321371.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_321371", "321371029", "story_v_out_321371.awb")
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
				actorName = "10131ui_story",
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
	Play321371030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 321371030
		arg_125_1.duration_ = 12.47

		local var_125_0 = {
			zh = 9.6,
			ja = 12.466
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
				arg_125_0:Play321371031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.875

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(321371030)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 35 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 35)

				if (35 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 35)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371030", "story_v_out_321371.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371030", "story_v_out_321371.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_321371", "321371030", "story_v_out_321371.awb")

						arg_125_1:RecordAudio("321371030", var_128_6)
						arg_125_1:RecordAudio("321371030", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_321371", "321371030", "story_v_out_321371.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_321371", "321371030", "story_v_out_321371.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play321371031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321371031
		arg_129_1.duration_ = 2.4

		local var_129_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play321371032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_132_0 = 0
			local var_132_1 = 0.125

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(321371031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 5 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 5)

				if (5 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 5)) > 0 and var_132_1 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371031", "story_v_out_321371.awb") ~= 0 then
					local var_132_6 = manager.audio:GetVoiceLength("story_v_out_321371", "321371031", "story_v_out_321371.awb") / 1000

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end

					if var_132_2.prefab_name ~= "" and arg_129_1.actors_[var_132_2.prefab_name] ~= nil then
						local var_132_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_2.prefab_name].transform, "story_v_out_321371", "321371031", "story_v_out_321371.awb")

						arg_129_1:RecordAudio("321371031", var_132_7)
						arg_129_1:RecordAudio("321371031", var_132_7)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_321371", "321371031", "story_v_out_321371.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_321371", "321371031", "story_v_out_321371.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play321371032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321371032
		arg_133_1.duration_ = 4.63

		local var_133_0 = {
			zh = 2.3,
			ja = 4.633
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
				arg_133_0:Play321371033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1111ui_story = arg_133_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1111ui_story"].transform.position).z)
				arg_133_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1111ui_story"].transform.localEulerAngles = arg_133_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_133_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1111ui_story"].transform.position).z)
				arg_133_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1111ui_story"].transform.localEulerAngles = arg_133_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1111ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1111ui_story == nil then
				arg_133_1.var_.characterEffect1111ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1111ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1111ui_story then
				arg_133_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["10131ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect10131ui_story == nil then
				arg_133_1.var_.characterEffect10131ui_story = var_136_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_5 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 and not isNil(var_136_4) then
				if arg_133_1.var_.characterEffect10131ui_story and not isNil(var_136_4) then
					arg_133_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_5)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect10131ui_story then
				arg_133_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_136_6 = 0
			local var_136_7 = 0.25

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(321371032)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 10 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 10)

				if (10 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 10)) > 0 and var_136_7 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371032", "story_v_out_321371.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371032", "story_v_out_321371.awb") / 1000

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_out_321371", "321371032", "story_v_out_321371.awb")

						arg_133_1:RecordAudio("321371032", var_136_13)
						arg_133_1:RecordAudio("321371032", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_321371", "321371032", "story_v_out_321371.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_321371", "321371032", "story_v_out_321371.awb")
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
				actorName = "1111ui_story",
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
	Play321371033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321371033
		arg_137_1.duration_ = 12

		local var_137_0 = {
			zh = 7.9,
			ja = 12
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
				arg_137_0:Play321371034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10131ui_story = arg_137_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10131ui_story"].transform.position).z)
				arg_137_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10131ui_story"].transform.localEulerAngles = arg_137_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_137_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10131ui_story"].transform.position).z)
				arg_137_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10131ui_story"].transform.localEulerAngles = arg_137_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["10131ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10131ui_story == nil then
				arg_137_1.var_.characterEffect10131ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect10131ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10131ui_story then
				arg_137_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_140_4 = arg_137_1.actors_["1111ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1111ui_story == nil then
				arg_137_1.var_.characterEffect1111ui_story = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_5 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 and not isNil(var_140_4) then
				if arg_137_1.var_.characterEffect1111ui_story and not isNil(var_140_4) then
					arg_137_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_5)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect1111ui_story then
				arg_137_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_140_6 = 0
			local var_140_7 = 0.9

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(321371033)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 36 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 36)

				if (36 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 36)) > 0 and var_140_7 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371033", "story_v_out_321371.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371033", "story_v_out_321371.awb") / 1000

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_321371", "321371033", "story_v_out_321371.awb")

						arg_137_1:RecordAudio("321371033", var_140_13)
						arg_137_1:RecordAudio("321371033", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_321371", "321371033", "story_v_out_321371.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_321371", "321371033", "story_v_out_321371.awb")
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
				actorName = "10131ui_story",
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
	Play321371034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 321371034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play321371035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				if arg_141_1.var_.effectsuipian1 then
					Object.Destroy(arg_141_1.var_.effectsuipian1)

					arg_141_1.var_.effectsuipian1 = nil
				end
			end

			local var_144_1 = arg_141_1.actors_["10131ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10131ui_story == nil then
				arg_141_1.var_.characterEffect10131ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect10131ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_2)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10131ui_story then
				arg_141_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_144_3 = arg_141_1.actors_["1111ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect1111ui_story == nil then
				arg_141_1.var_.characterEffect1111ui_story = var_144_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 and not isNil(var_144_3) then
				if arg_141_1.var_.characterEffect1111ui_story and not isNil(var_144_3) then
					arg_141_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_4)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect1111ui_story then
				arg_141_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_144_5 = 0
			local var_144_6 = 0.925

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(321371034).content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 37 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_7) / 37)

				if (37 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_7) / 37)) > 0 and var_144_6 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_10 and arg_141_1.time_ < var_144_5 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play321371035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 321371035
		arg_145_1.duration_ = 8.23

		local var_145_0 = {
			zh = 7.4,
			ja = 8.233
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
				arg_145_0:Play321371036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10131ui_story = arg_145_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10131ui_story"].transform.position).z)
				arg_145_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10131ui_story"].transform.localEulerAngles = arg_145_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_145_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10131ui_story"].transform.position).z)
				arg_145_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10131ui_story"].transform.localEulerAngles = arg_145_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["10131ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10131ui_story == nil then
				arg_145_1.var_.characterEffect10131ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect10131ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10131ui_story then
				arg_145_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_4 = 0
			local var_148_5 = 0.775

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(321371035)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 31 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 31)

				if (31 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 31)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371035", "story_v_out_321371.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371035", "story_v_out_321371.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_321371", "321371035", "story_v_out_321371.awb")

						arg_145_1:RecordAudio("321371035", var_148_11)
						arg_145_1:RecordAudio("321371035", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_321371", "321371035", "story_v_out_321371.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_321371", "321371035", "story_v_out_321371.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play321371036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 321371036
		arg_149_1.duration_ = 3.77

		local var_149_0 = {
			zh = 2.566,
			ja = 3.766
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play321371037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1111ui_story = arg_149_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).z)
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles = arg_149_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_149_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1111ui_story"].transform.position).z)
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1111ui_story"].transform.localEulerAngles = arg_149_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1111ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1111ui_story == nil then
				arg_149_1.var_.characterEffect1111ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1111ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1111ui_story then
				arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["10131ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10131ui_story == nil then
				arg_149_1.var_.characterEffect10131ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_5 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 and not isNil(var_152_4) then
				if arg_149_1.var_.characterEffect10131ui_story and not isNil(var_152_4) then
					arg_149_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_5)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10131ui_story then
				arg_149_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_152_6 = 0
			local var_152_7 = 0.35

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(321371036)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 14 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 14)

				if (14 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 14)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371036", "story_v_out_321371.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371036", "story_v_out_321371.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_321371", "321371036", "story_v_out_321371.awb")

						arg_149_1:RecordAudio("321371036", var_152_13)
						arg_149_1:RecordAudio("321371036", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_321371", "321371036", "story_v_out_321371.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_321371", "321371036", "story_v_out_321371.awb")
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

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play321371037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 321371037
		arg_153_1.duration_ = 14.37

		local var_153_0 = {
			zh = 12.733,
			ja = 14.366
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play321371038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10131ui_story"]) and arg_153_1.var_.characterEffect10131ui_story == nil then
				arg_153_1.var_.characterEffect10131ui_story = arg_153_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10131ui_story"]) then
				if arg_153_1.var_.characterEffect10131ui_story and not isNil(arg_153_1.actors_["10131ui_story"]) then
					arg_153_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10131ui_story"]) and arg_153_1.var_.characterEffect10131ui_story then
				arg_153_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_156_2 = arg_153_1.actors_["1111ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1111ui_story == nil then
				arg_153_1.var_.characterEffect1111ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect1111ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1111ui_story then
				arg_153_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_156_4 = 0
			local var_156_5 = 1.225

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(321371037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 49 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 49)

				if (49 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 49)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371037", "story_v_out_321371.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371037", "story_v_out_321371.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_321371", "321371037", "story_v_out_321371.awb")

						arg_153_1:RecordAudio("321371037", var_156_11)
						arg_153_1:RecordAudio("321371037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_321371", "321371037", "story_v_out_321371.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_321371", "321371037", "story_v_out_321371.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play321371038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321371038
		arg_157_1.duration_ = 6.67

		local var_157_0 = {
			zh = 4.733,
			ja = 6.666
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play321371039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_160_0 = 0
			local var_160_1 = 0.35

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(321371038)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 14 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 14)

				if (14 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 14)) > 0 and var_160_1 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371038", "story_v_out_321371.awb") ~= 0 then
					local var_160_6 = manager.audio:GetVoiceLength("story_v_out_321371", "321371038", "story_v_out_321371.awb") / 1000

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end

					if var_160_2.prefab_name ~= "" and arg_157_1.actors_[var_160_2.prefab_name] ~= nil then
						local var_160_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_2.prefab_name].transform, "story_v_out_321371", "321371038", "story_v_out_321371.awb")

						arg_157_1:RecordAudio("321371038", var_160_7)
						arg_157_1:RecordAudio("321371038", var_160_7)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_321371", "321371038", "story_v_out_321371.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_321371", "321371038", "story_v_out_321371.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play321371039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321371039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play321371040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10131ui_story = arg_161_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10131ui_story"].transform.position).z)
				arg_161_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10131ui_story"].transform.localEulerAngles = arg_161_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10131ui_story"].transform.position).z)
				arg_161_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10131ui_story"].transform.localEulerAngles = arg_161_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1111ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1111ui_story = var_164_1.localPosition
			end

			local var_164_2 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 then
				var_164_1.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_2)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 then
				var_164_1.localPosition = Vector3.New(0, 100, 0)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			local var_164_3 = arg_161_1.actors_["10131ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect10131ui_story == nil then
				arg_161_1.var_.characterEffect10131ui_story = var_164_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_4 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 and not isNil(var_164_3) then
				if arg_161_1.var_.characterEffect10131ui_story and not isNil(var_164_3) then
					arg_161_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_4)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect10131ui_story then
				arg_161_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_164_5 = 0
			local var_164_6 = 0.925

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_7 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(321371039).content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 37 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_7) / 37)

				if (37 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_7) / 37)) > 0 and var_164_6 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_5
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_6, arg_161_1.talkMaxDuration)

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_5) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_5 + var_164_10 and arg_161_1.time_ < var_164_5 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play321371040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321371040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play321371041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0.05 < arg_165_1.time_ and arg_165_1.time_ <= 0.05 + arg_168_0 then
				arg_165_1:AudioAction("play", "effect", "se_story_141", "se_story_141_snake07", "")
			end

			local var_168_1 = 0
			local var_168_2 = 0.7

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(321371040).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 28 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 28)

				if (28 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 28)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play321371041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321371041
		arg_169_1.duration_ = 6.23

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play321371042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_9001
			local var_172_9000

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_172_0 = 1

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				local var_172_1, var_172_2 = math.modf((arg_169_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_172_2 * 0.13, var_172_2 * 0.13, var_172_2 * 0.13) + arg_169_1.var_.shakeOldPos
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				manager.ui.mainCamera.transform.localPosition = arg_169_1.var_.shakeOldPos
			end

			local var_172_3 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			if arg_169_1.time_ >= var_172_3 + 1.73333333333333 and arg_169_1.time_ < var_172_3 + 1.73333333333333 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				local var_172_4 = arg_169_1.var_.effectsuipianjingzhu1

				if not arg_169_1.var_.effectsuipianjingzhu1 then
					var_172_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), manager.ui.mainCamera.transform)
					var_172_4.name = "suipianjingzhu1"
					arg_169_1.var_.effectsuipianjingzhu1 = var_172_4
				else
					var_172_4.transform:SetParent(var_172_9001)
				end

				var_172_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_172_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.5 < arg_169_1.time_ and arg_169_1.time_ <= 1.5 + arg_172_0 then
				if arg_169_1.var_.effectsuipianjingzhu1 then
					Object.Destroy(arg_169_1.var_.effectsuipianjingzhu1)

					arg_169_1.var_.effectsuipianjingzhu1 = nil
				end
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				local var_172_7 = arg_169_1.var_.effect1041

				if not arg_169_1.var_.effect1041 then
					var_172_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_posui"), manager.ui.mainCamera.transform)
					var_172_7.name = "1041"
					arg_169_1.var_.effect1041 = var_172_7
				else
					var_172_7.transform:SetParent(var_172_9000)
				end

				var_172_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_172_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.63333333333333 < arg_169_1.time_ and arg_169_1.time_ <= 2.63333333333333 + arg_172_0 then
				if arg_169_1.var_.effect1041 then
					Object.Destroy(arg_169_1.var_.effect1041)

					arg_169_1.var_.effect1041 = nil
				end
			end

			if 2.33333333333333 < arg_169_1.time_ and arg_169_1.time_ <= 2.33333333333333 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "se_story_140", "se_story_140_scythe5", "")
			end

			if 0.05 < arg_169_1.time_ and arg_169_1.time_ <= 0.05 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "se_story_140", "se_story_140_glass", "")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_12 = 1.23333333333333
			local var_172_13 = 1.4

			if 1.23333333333333 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_14 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_14:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_15 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(321371041).content)

				arg_169_1.text_.text = var_172_15

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_17 = 56 <= 0 and var_172_13 or var_172_13 * (utf8.len(var_172_15) / 56)

				if (56 <= 0 and var_172_13 or var_172_13 * (utf8.len(var_172_15) / 56)) > 0 and var_172_13 < var_172_17 then
					arg_169_1.talkMaxDuration = var_172_17
					var_172_12 = var_172_12 + 0.3

					if var_172_17 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_17 + var_172_12
					end
				end

				arg_169_1.text_.text = var_172_15
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_18 = var_172_12 + 0.3
			local var_172_19 = math.max(var_172_13, arg_169_1.talkMaxDuration)

			if var_172_12 + 0.3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_18 + var_172_19 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_18) / var_172_19

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_18 + var_172_19 and arg_169_1.time_ < var_172_18 + var_172_19 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play321371042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 321371042
		arg_175_1.duration_ = 10.37

		local var_175_0 = {
			zh = 10.366,
			ja = 9.733
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
				arg_175_0:Play321371043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if arg_175_1.bgs_.ST0506a == nil then
				local var_178_0 = Object.Instantiate(arg_175_1.paintGo_)

				var_178_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0506a")
				var_178_0.name = "ST0506a"
				var_178_0.transform.parent = arg_175_1.stage_.transform
				var_178_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.bgs_.ST0506a = var_178_0
			end

			if 2 < arg_175_1.time_ and arg_175_1.time_ <= 2 + arg_178_0 then
				local var_178_1 = arg_175_1.bgs_.ST0506a

				arg_175_1.bgs_.ST0506a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_178_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_2 = var_178_1:GetComponent("SpriteRenderer")

				if var_178_2 and var_178_2.sprite then
					local var_178_3 = 2 * (var_178_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_178_1.transform.localScale = Vector3.New(var_178_3 / var_178_2.sprite.bounds.size.y < var_178_3 * manager.ui.mainCameraCom_.aspect / var_178_2.sprite.bounds.size.x and var_178_3 * manager.ui.mainCameraCom_.aspect / var_178_2.sprite.bounds.size.x or var_178_3 / var_178_2.sprite.bounds.size.y, var_178_3 / var_178_2.sprite.bounds.size.y < var_178_3 * manager.ui.mainCameraCom_.aspect / var_178_2.sprite.bounds.size.x and var_178_3 * manager.ui.mainCameraCom_.aspect / var_178_2.sprite.bounds.size.x or var_178_3 / var_178_2.sprite.bounds.size.y, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "ST0506a" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_4 = 4

			if 4 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= var_178_4 + 0.3 and arg_175_1.time_ < var_178_4 + 0.3 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_5 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_6 = 2

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_6 then
				local var_178_7 = Color.New(0, 0, 0)

				var_178_7.a = Mathf.Lerp(0, 1, (arg_175_1.time_ - var_178_5) / var_178_6)
				arg_175_1.mask_.color = var_178_7
			end

			if arg_175_1.time_ >= var_178_5 + var_178_6 and arg_175_1.time_ < var_178_5 + var_178_6 + arg_178_0 then
				local var_178_8 = Color.New(0, 0, 0)

				var_178_8.a = 1
				arg_175_1.mask_.color = var_178_8
			end

			local var_178_9 = 2

			if 2 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_10 = 2

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_10 then
				local var_178_11 = Color.New(0, 0, 0)

				var_178_11.a = Mathf.Lerp(1, 0, (arg_175_1.time_ - var_178_9) / var_178_10)
				arg_175_1.mask_.color = var_178_11
			end

			if arg_175_1.time_ >= var_178_9 + var_178_10 and arg_175_1.time_ < var_178_9 + var_178_10 + arg_178_0 then
				local var_178_12 = Color.New(0, 0, 0)

				arg_175_1.mask_.enabled = false
				var_178_12.a = 0
				arg_175_1.mask_.color = var_178_12
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_13 = 4
			local var_178_14 = 0.425

			if 4 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_15 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_15:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_16 = arg_175_1:GetWordFromCfg(321371042)
				local var_178_17 = arg_175_1:FormatText(var_178_16.content)

				arg_175_1.text_.text = var_178_17

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_19 = 17 <= 0 and var_178_14 or var_178_14 * (utf8.len(var_178_17) / 17)

				if (17 <= 0 and var_178_14 or var_178_14 * (utf8.len(var_178_17) / 17)) > 0 and var_178_14 < var_178_19 then
					arg_175_1.talkMaxDuration = var_178_19
					var_178_13 = var_178_13 + 0.3

					if var_178_19 + var_178_13 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_19 + var_178_13
					end
				end

				arg_175_1.text_.text = var_178_17
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371042", "story_v_out_321371.awb") ~= 0 then
					local var_178_20 = manager.audio:GetVoiceLength("story_v_out_321371", "321371042", "story_v_out_321371.awb") / 1000

					if var_178_20 + var_178_13 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_20 + var_178_13
					end

					if var_178_16.prefab_name ~= "" and arg_175_1.actors_[var_178_16.prefab_name] ~= nil then
						local var_178_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_16.prefab_name].transform, "story_v_out_321371", "321371042", "story_v_out_321371.awb")

						arg_175_1:RecordAudio("321371042", var_178_21)
						arg_175_1:RecordAudio("321371042", var_178_21)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_321371", "321371042", "story_v_out_321371.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_321371", "321371042", "story_v_out_321371.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_22 = var_178_13 + 0.3
			local var_178_23 = math.max(var_178_14, arg_175_1.talkMaxDuration)

			if var_178_13 + 0.3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_22 + var_178_23 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_22) / var_178_23

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_22 + var_178_23 and arg_175_1.time_ < var_178_22 + var_178_23 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play321371043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321371043
		arg_181_1.duration_ = 10.93

		local var_181_0 = {
			zh = 10.266,
			ja = 10.933
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
				arg_181_0:Play321371044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.85

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:GetWordFromCfg(321371043)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 34 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 34)

				if (34 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 34)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371043", "story_v_out_321371.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371043", "story_v_out_321371.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_321371", "321371043", "story_v_out_321371.awb")

						arg_181_1:RecordAudio("321371043", var_184_6)
						arg_181_1:RecordAudio("321371043", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321371", "321371043", "story_v_out_321371.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321371", "321371043", "story_v_out_321371.awb")
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
	Play321371044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321371044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play321371045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0.05 < arg_185_1.time_ and arg_185_1.time_ <= 0.05 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_chair", "")
			end

			local var_188_1 = 0
			local var_188_2 = 1

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(321371044).content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 40 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 40)

				if (40 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 40)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_6 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_6 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_6

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_6 and arg_185_1.time_ < var_188_1 + var_188_6 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play321371045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321371045
		arg_189_1.duration_ = 3

		local var_189_0 = {
			zh = 1.366,
			ja = 3
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play321371046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.15

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1213].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(321371045)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 6 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 6)

				if (6 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 6)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371045", "story_v_out_321371.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371045", "story_v_out_321371.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_321371", "321371045", "story_v_out_321371.awb")

						arg_189_1:RecordAudio("321371045", var_192_6)
						arg_189_1:RecordAudio("321371045", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321371", "321371045", "story_v_out_321371.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321371", "321371045", "story_v_out_321371.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play321371046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321371046
		arg_193_1.duration_ = 8.03

		local var_193_0 = {
			zh = 8.033,
			ja = 7.5
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play321371047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.65

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:GetWordFromCfg(321371046)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 26 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 26)

				if (26 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 26)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371046", "story_v_out_321371.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371046", "story_v_out_321371.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_321371", "321371046", "story_v_out_321371.awb")

						arg_193_1:RecordAudio("321371046", var_196_6)
						arg_193_1:RecordAudio("321371046", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_321371", "321371046", "story_v_out_321371.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_321371", "321371046", "story_v_out_321371.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play321371047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321371047
		arg_197_1.duration_ = 5.97

		local var_197_0 = {
			zh = 3.866,
			ja = 5.966
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play321371048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.375

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(321371047)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 15 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 15)

				if (15 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 15)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371047", "story_v_out_321371.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371047", "story_v_out_321371.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_321371", "321371047", "story_v_out_321371.awb")

						arg_197_1:RecordAudio("321371047", var_200_6)
						arg_197_1:RecordAudio("321371047", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321371", "321371047", "story_v_out_321371.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321371", "321371047", "story_v_out_321371.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play321371048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321371048
		arg_201_1.duration_ = 7.07

		local var_201_0 = {
			zh = 7.066,
			ja = 7.033
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play321371049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.625

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:GetWordFromCfg(321371048)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 25 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 25)

				if (25 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 25)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371048", "story_v_out_321371.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371048", "story_v_out_321371.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_321371", "321371048", "story_v_out_321371.awb")

						arg_201_1:RecordAudio("321371048", var_204_6)
						arg_201_1:RecordAudio("321371048", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321371", "321371048", "story_v_out_321371.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321371", "321371048", "story_v_out_321371.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play321371049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321371049
		arg_205_1.duration_ = 7.3

		local var_205_0 = {
			zh = 3,
			ja = 7.3
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play321371050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.325

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1213].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:GetWordFromCfg(321371049)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 13 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 13)

				if (13 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 13)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371049", "story_v_out_321371.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371049", "story_v_out_321371.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_321371", "321371049", "story_v_out_321371.awb")

						arg_205_1:RecordAudio("321371049", var_208_6)
						arg_205_1:RecordAudio("321371049", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_321371", "321371049", "story_v_out_321371.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_321371", "321371049", "story_v_out_321371.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play321371050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321371050
		arg_209_1.duration_ = 16.63

		local var_209_0 = {
			zh = 13.566,
			ja = 16.633
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play321371051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.95

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:GetWordFromCfg(321371050)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 38 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 38)

				if (38 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 38)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371050", "story_v_out_321371.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371050", "story_v_out_321371.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_321371", "321371050", "story_v_out_321371.awb")

						arg_209_1:RecordAudio("321371050", var_212_6)
						arg_209_1:RecordAudio("321371050", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_321371", "321371050", "story_v_out_321371.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_321371", "321371050", "story_v_out_321371.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play321371051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321371051
		arg_213_1.duration_ = 14.53

		local var_213_0 = {
			zh = 10.066,
			ja = 14.533
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play321371052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.725

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:GetWordFromCfg(321371051)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 29 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 29)

				if (29 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 29)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371051", "story_v_out_321371.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371051", "story_v_out_321371.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_321371", "321371051", "story_v_out_321371.awb")

						arg_213_1:RecordAudio("321371051", var_216_6)
						arg_213_1:RecordAudio("321371051", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_321371", "321371051", "story_v_out_321371.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_321371", "321371051", "story_v_out_321371.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play321371052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321371052
		arg_217_1.duration_ = 11.67

		local var_217_0 = {
			zh = 11.666,
			ja = 11
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play321371053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.825

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:GetWordFromCfg(321371052)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 33 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 33)

				if (33 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 33)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371052", "story_v_out_321371.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371052", "story_v_out_321371.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_321371", "321371052", "story_v_out_321371.awb")

						arg_217_1:RecordAudio("321371052", var_220_6)
						arg_217_1:RecordAudio("321371052", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_321371", "321371052", "story_v_out_321371.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_321371", "321371052", "story_v_out_321371.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play321371053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321371053
		arg_221_1.duration_ = 5.67

		local var_221_0 = {
			zh = 5.666,
			ja = 5.433
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play321371054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.425

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:GetWordFromCfg(321371053)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 17 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 17)

				if (17 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 17)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371053", "story_v_out_321371.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371053", "story_v_out_321371.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_321371", "321371053", "story_v_out_321371.awb")

						arg_221_1:RecordAudio("321371053", var_224_6)
						arg_221_1:RecordAudio("321371053", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_321371", "321371053", "story_v_out_321371.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_321371", "321371053", "story_v_out_321371.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play321371054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 321371054
		arg_225_1.duration_ = 4.6

		local var_225_0 = {
			zh = 4.6,
			ja = 1.533
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play321371055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.175

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:GetWordFromCfg(321371054)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 7 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 7)

				if (7 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 7)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371054", "story_v_out_321371.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371054", "story_v_out_321371.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_321371", "321371054", "story_v_out_321371.awb")

						arg_225_1:RecordAudio("321371054", var_228_6)
						arg_225_1:RecordAudio("321371054", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_321371", "321371054", "story_v_out_321371.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_321371", "321371054", "story_v_out_321371.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play321371055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 321371055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play321371056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0.433333333333333 < arg_229_1.time_ and arg_229_1.time_ <= 0.433333333333333 + arg_232_0 then
				arg_229_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_back", "")
			end

			local var_232_1 = 0
			local var_232_2 = 1.6

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(321371055).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 64 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 64)

				if (64 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 64)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play321371056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 321371056
		arg_233_1.duration_ = 3.33

		local var_233_0 = {
			zh = 1.7,
			ja = 3.333
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play321371057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.15

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1213].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:GetWordFromCfg(321371056)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 6 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 6)

				if (6 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 6)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371056", "story_v_out_321371.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371056", "story_v_out_321371.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_321371", "321371056", "story_v_out_321371.awb")

						arg_233_1:RecordAudio("321371056", var_236_6)
						arg_233_1:RecordAudio("321371056", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_321371", "321371056", "story_v_out_321371.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_321371", "321371056", "story_v_out_321371.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play321371057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 321371057
		arg_237_1.duration_ = 2

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play321371058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if arg_237_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_240_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_237_1.stage_.transform)

				var_240_0.name = "1037ui_story"
				var_240_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["1037ui_story"] = var_240_0

				local var_240_1 = var_240_0:GetComponentInChildren(typeof(CharacterEffect))

				var_240_1.enabled = true

				local var_240_2 = GameObjectTools.GetOrAddComponent(var_240_0, typeof(DynamicBoneHelper))

				if var_240_2 then
					var_240_2:EnableDynamicBone(false)
				end

				arg_237_1:ShowWeapon(var_240_1.transform, false)

				arg_237_1.var_["1037ui_story" .. "Animator"] = var_240_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_237_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_237_1.var_["1037ui_story" .. "LipSync"] = var_240_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_240_3 = arg_237_1.actors_["1037ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_3) and arg_237_1.var_.characterEffect1037ui_story == nil then
				arg_237_1.var_.characterEffect1037ui_story = var_240_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_4 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 and not isNil(var_240_3) then
				if arg_237_1.var_.characterEffect1037ui_story and not isNil(var_240_3) then
					arg_237_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 and not isNil(var_240_3) and arg_237_1.var_.characterEffect1037ui_story then
				arg_237_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_240_6 = "1043ui_story"

			if arg_237_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_240_7 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_237_1.stage_.transform)

				var_240_7.name = var_240_6
				var_240_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_[var_240_6] = var_240_7

				local var_240_8 = var_240_7:GetComponentInChildren(typeof(CharacterEffect))

				var_240_8.enabled = true

				local var_240_9 = GameObjectTools.GetOrAddComponent(var_240_7, typeof(DynamicBoneHelper))

				if var_240_9 then
					var_240_9:EnableDynamicBone(false)
				end

				arg_237_1:ShowWeapon(var_240_8.transform, false)

				arg_237_1.var_[var_240_6 .. "Animator"] = var_240_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_237_1.var_[var_240_6 .. "Animator"].applyRootMotion = true
				arg_237_1.var_[var_240_6 .. "LipSync"] = var_240_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_240_10 = arg_237_1.actors_["1043ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1043ui_story = var_240_10.localPosition
			end

			local var_240_11 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_11 then
				var_240_10.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_237_1.time_ - 0) / var_240_11)
				var_240_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_10.position).x, (manager.ui.mainCamera.transform.position - var_240_10.position).y, (manager.ui.mainCamera.transform.position - var_240_10.position).z)
				var_240_10.localEulerAngles.z = 0
				var_240_10.localEulerAngles.x = 0
				var_240_10.localEulerAngles = var_240_10.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_11 and arg_237_1.time_ < 0 + var_240_11 + arg_240_0 then
				var_240_10.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_240_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_10.position).x, (manager.ui.mainCamera.transform.position - var_240_10.position).y, (manager.ui.mainCamera.transform.position - var_240_10.position).z)
				var_240_10.localEulerAngles.z = 0
				var_240_10.localEulerAngles.x = 0
				var_240_10.localEulerAngles = var_240_10.localEulerAngles
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_240_12 = 0
			local var_240_13 = 0.05

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_12 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_14 = arg_237_1:GetWordFromCfg(321371057)
				local var_240_15 = arg_237_1:FormatText(var_240_14.content)

				arg_237_1.text_.text = var_240_15

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_17 = 2 <= 0 and var_240_13 or var_240_13 * (utf8.len(var_240_15) / 2)

				if (2 <= 0 and var_240_13 or var_240_13 * (utf8.len(var_240_15) / 2)) > 0 and var_240_13 < var_240_17 then
					arg_237_1.talkMaxDuration = var_240_17

					if var_240_17 + var_240_12 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_17 + var_240_12
					end
				end

				arg_237_1.text_.text = var_240_15
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371057", "story_v_out_321371.awb") ~= 0 then
					local var_240_18 = manager.audio:GetVoiceLength("story_v_out_321371", "321371057", "story_v_out_321371.awb") / 1000

					if var_240_18 + var_240_12 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_18 + var_240_12
					end

					if var_240_14.prefab_name ~= "" and arg_237_1.actors_[var_240_14.prefab_name] ~= nil then
						local var_240_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_14.prefab_name].transform, "story_v_out_321371", "321371057", "story_v_out_321371.awb")

						arg_237_1:RecordAudio("321371057", var_240_19)
						arg_237_1:RecordAudio("321371057", var_240_19)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_321371", "321371057", "story_v_out_321371.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_321371", "321371057", "story_v_out_321371.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_20 = math.max(var_240_13, arg_237_1.talkMaxDuration)

			if var_240_12 <= arg_237_1.time_ and arg_237_1.time_ < var_240_12 + var_240_20 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_12) / var_240_20

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_12 + var_240_20 and arg_237_1.time_ < var_240_12 + var_240_20 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play321371058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 321371058
		arg_241_1.duration_ = 5.63

		local var_241_0 = {
			zh = 4.7,
			ja = 5.633
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play321371059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1037ui_story"]) and arg_241_1.var_.characterEffect1037ui_story == nil then
				arg_241_1.var_.characterEffect1037ui_story = arg_241_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1037ui_story"]) then
				if arg_241_1.var_.characterEffect1037ui_story and not isNil(arg_241_1.actors_["1037ui_story"]) then
					arg_241_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1037ui_story"]) and arg_241_1.var_.characterEffect1037ui_story then
				arg_241_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_244_1 = arg_241_1.actors_["1043ui_story"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1043ui_story = var_244_1.localPosition
			end

			local var_244_2 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 then
				var_244_1.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_2)
				var_244_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_1.position).x, (manager.ui.mainCamera.transform.position - var_244_1.position).y, (manager.ui.mainCamera.transform.position - var_244_1.position).z)
				var_244_1.localEulerAngles.z = 0
				var_244_1.localEulerAngles.x = 0
				var_244_1.localEulerAngles = var_244_1.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 then
				var_244_1.localPosition = Vector3.New(0, 100, 0)
				var_244_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_1.position).x, (manager.ui.mainCamera.transform.position - var_244_1.position).y, (manager.ui.mainCamera.transform.position - var_244_1.position).z)
				var_244_1.localEulerAngles.z = 0
				var_244_1.localEulerAngles.x = 0
				var_244_1.localEulerAngles = var_244_1.localEulerAngles
			end

			local var_244_3 = 0
			local var_244_4 = 0.3

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_5 = arg_241_1:GetWordFromCfg(321371058)
				local var_244_6 = arg_241_1:FormatText(var_244_5.content)

				arg_241_1.text_.text = var_244_6

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_8 = 12 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_6) / 12)

				if (12 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_6) / 12)) > 0 and var_244_4 < var_244_8 then
					arg_241_1.talkMaxDuration = var_244_8

					if var_244_8 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_3
					end
				end

				arg_241_1.text_.text = var_244_6
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371058", "story_v_out_321371.awb") ~= 0 then
					local var_244_9 = manager.audio:GetVoiceLength("story_v_out_321371", "321371058", "story_v_out_321371.awb") / 1000

					if var_244_9 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_3
					end

					if var_244_5.prefab_name ~= "" and arg_241_1.actors_[var_244_5.prefab_name] ~= nil then
						local var_244_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_5.prefab_name].transform, "story_v_out_321371", "321371058", "story_v_out_321371.awb")

						arg_241_1:RecordAudio("321371058", var_244_10)
						arg_241_1:RecordAudio("321371058", var_244_10)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_321371", "321371058", "story_v_out_321371.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_321371", "321371058", "story_v_out_321371.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_11 = math.max(var_244_4, arg_241_1.talkMaxDuration)

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_11 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_3) / var_244_11

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_3 + var_244_11 and arg_241_1.time_ < var_244_3 + var_244_11 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play321371059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 321371059
		arg_245_1.duration_ = 6.57

		local var_245_0 = {
			zh = 4.066,
			ja = 6.566
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play321371060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.425

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1213].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:GetWordFromCfg(321371059)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 17 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 17)

				if (17 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 17)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371059", "story_v_out_321371.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371059", "story_v_out_321371.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_321371", "321371059", "story_v_out_321371.awb")

						arg_245_1:RecordAudio("321371059", var_248_6)
						arg_245_1:RecordAudio("321371059", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_321371", "321371059", "story_v_out_321371.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_321371", "321371059", "story_v_out_321371.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play321371060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 321371060
		arg_249_1.duration_ = 10.1

		local var_249_0 = {
			zh = 8.1,
			ja = 10.1
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play321371061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.8

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1213].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_1 = arg_249_1:GetWordFromCfg(321371060)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 32 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 32)

				if (32 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 32)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371060", "story_v_out_321371.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371060", "story_v_out_321371.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_321371", "321371060", "story_v_out_321371.awb")

						arg_249_1:RecordAudio("321371060", var_252_6)
						arg_249_1:RecordAudio("321371060", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_321371", "321371060", "story_v_out_321371.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_321371", "321371060", "story_v_out_321371.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play321371061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 321371061
		arg_253_1.duration_ = 6

		local var_253_0 = {
			zh = 6,
			ja = 5.733
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
				arg_253_0:Play321371062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.4

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:GetWordFromCfg(321371061)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 16 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 16)

				if (16 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 16)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371061", "story_v_out_321371.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371061", "story_v_out_321371.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_321371", "321371061", "story_v_out_321371.awb")

						arg_253_1:RecordAudio("321371061", var_256_6)
						arg_253_1:RecordAudio("321371061", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_321371", "321371061", "story_v_out_321371.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_321371", "321371061", "story_v_out_321371.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play321371062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 321371062
		arg_257_1.duration_ = 4.77

		local var_257_0 = {
			zh = 3.733,
			ja = 4.766
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play321371063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.375

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1213].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(321371062)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 15 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 15)

				if (15 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 15)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371062", "story_v_out_321371.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371062", "story_v_out_321371.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_321371", "321371062", "story_v_out_321371.awb")

						arg_257_1:RecordAudio("321371062", var_260_6)
						arg_257_1:RecordAudio("321371062", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_321371", "321371062", "story_v_out_321371.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_321371", "321371062", "story_v_out_321371.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play321371063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 321371063
		arg_261_1.duration_ = 9.9

		local var_261_0 = {
			zh = 9.9,
			ja = 7.566
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play321371064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.75

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1213].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:GetWordFromCfg(321371063)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 30 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 30)

				if (30 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 30)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371063", "story_v_out_321371.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371063", "story_v_out_321371.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_321371", "321371063", "story_v_out_321371.awb")

						arg_261_1:RecordAudio("321371063", var_264_6)
						arg_261_1:RecordAudio("321371063", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_321371", "321371063", "story_v_out_321371.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_321371", "321371063", "story_v_out_321371.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play321371064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 321371064
		arg_265_1.duration_ = 5.82

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play321371065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				local var_268_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_268_0 then
					var_268_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_268_0.radialBlurScale = 0.6
					var_268_0.radialBlurGradient = 1
					var_268_0.radialBlurIntensity = 1

					if nil then
						var_268_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_268_1 = 2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				local var_268_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_268_2 then
					var_268_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_268_2.radialBlurScale = Mathf.Lerp(0.6, 0, (arg_265_1.time_ - 0) / var_268_1)
					var_268_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_265_1.time_ - 0) / var_268_1)
					var_268_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_265_1.time_ - 0) / var_268_1)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				local var_268_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_268_3 then
					var_268_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_268_3.radialBlurScale = 0
					var_268_3.radialBlurGradient = 1
					var_268_3.radialBlurIntensity = 1
				end
			end

			local var_268_4 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			if arg_265_1.time_ >= var_268_4 + 0.825 and arg_265_1.time_ < var_268_4 + 0.825 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_5 = 0.825
			local var_268_6 = 1.175

			if 0.825 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_7 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_7:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_8 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(321371064).content)

				arg_265_1.text_.text = var_268_8

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_10 = 47 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 47)

				if (47 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 47)) > 0 and var_268_6 < var_268_10 then
					arg_265_1.talkMaxDuration = var_268_10
					var_268_5 = var_268_5 + 0.3

					if var_268_10 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_8
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_11 = var_268_5 + 0.3
			local var_268_12 = math.max(var_268_6, arg_265_1.talkMaxDuration)

			if var_268_5 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_11 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_11) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_11 + var_268_12 and arg_265_1.time_ < var_268_11 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play321371065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 321371065
		arg_271_1.duration_ = 5.37

		local var_271_0 = {
			zh = 3.1,
			ja = 5.366
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play321371066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.2

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:GetWordFromCfg(321371065)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 8 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 8)

				if (8 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 8)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371065", "story_v_out_321371.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371065", "story_v_out_321371.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_321371", "321371065", "story_v_out_321371.awb")

						arg_271_1:RecordAudio("321371065", var_274_6)
						arg_271_1:RecordAudio("321371065", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_321371", "321371065", "story_v_out_321371.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_321371", "321371065", "story_v_out_321371.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play321371066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 321371066
		arg_275_1.duration_ = 5.87

		local var_275_0 = {
			zh = 5.866,
			ja = 5.6
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play321371067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.35

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_1 = arg_275_1:GetWordFromCfg(321371066)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 14 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 14)

				if (14 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 14)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371066", "story_v_out_321371.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371066", "story_v_out_321371.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_321371", "321371066", "story_v_out_321371.awb")

						arg_275_1:RecordAudio("321371066", var_278_6)
						arg_275_1:RecordAudio("321371066", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_321371", "321371066", "story_v_out_321371.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_321371", "321371066", "story_v_out_321371.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play321371067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 321371067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play321371068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.95

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(321371067).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 38 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 38)

				if (38 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 38)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play321371068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 321371068
		arg_283_1.duration_ = 6.23

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play321371069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				local var_286_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_286_0 then
					var_286_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_286_0.radialBlurScale = 0.854
					var_286_0.radialBlurGradient = 1
					var_286_0.radialBlurIntensity = 1

					if nil then
						var_286_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_286_1 = 1.33333333333333

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_1 then
				local var_286_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_286_2 then
					var_286_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_286_2.radialBlurScale = Mathf.Lerp(0.854, 0.97, (arg_283_1.time_ - 0) / var_286_1)
					var_286_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_283_1.time_ - 0) / var_286_1)
					var_286_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_283_1.time_ - 0) / var_286_1)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_1 and arg_283_1.time_ < 0 + var_286_1 + arg_286_0 then
				local var_286_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_286_3 then
					var_286_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_286_3.radialBlurScale = 0.97
					var_286_3.radialBlurGradient = 1
					var_286_3.radialBlurIntensity = 1
				end
			end

			local var_286_4 = 0

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			if arg_283_1.time_ >= var_286_4 + 1.9 and arg_283_1.time_ < var_286_4 + 1.9 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:AudioAction("play", "effect", "se_story_141", "se_story_141_unreal", "")
			end

			local var_286_6 = 1.23333333333333
			local var_286_7 = 1.65

			if 1.23333333333333 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_8 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(321371068).content)

				arg_283_1.text_.text = var_286_8

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_10 = 66 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_8) / 66)

				if (66 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_8) / 66)) > 0 and var_286_7 < var_286_10 then
					arg_283_1.talkMaxDuration = var_286_10

					if var_286_10 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_8
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_11 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_11 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_11

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_11 and arg_283_1.time_ < var_286_6 + var_286_11 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play321371069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 321371069
		arg_287_1.duration_ = 3.07

		local var_287_0 = {
			zh = 2.8,
			ja = 3.066
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play321371070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.3

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:GetWordFromCfg(321371069)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 12 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 12)

				if (12 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 12)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371069", "story_v_out_321371.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371069", "story_v_out_321371.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_321371", "321371069", "story_v_out_321371.awb")

						arg_287_1:RecordAudio("321371069", var_290_6)
						arg_287_1:RecordAudio("321371069", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_321371", "321371069", "story_v_out_321371.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_321371", "321371069", "story_v_out_321371.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play321371070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 321371070
		arg_291_1.duration_ = 3.23

		local var_291_0 = {
			zh = 1.266,
			ja = 3.233
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play321371071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.125

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_1 = arg_291_1:GetWordFromCfg(321371070)
				local var_294_2 = arg_291_1:FormatText(var_294_1.content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 5 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 5)

				if (5 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 5)) > 0 and var_294_0 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + 0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371070", "story_v_out_321371.awb") ~= 0 then
					local var_294_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371070", "story_v_out_321371.awb") / 1000

					if var_294_5 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + 0
					end

					if var_294_1.prefab_name ~= "" and arg_291_1.actors_[var_294_1.prefab_name] ~= nil then
						local var_294_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_1.prefab_name].transform, "story_v_out_321371", "321371070", "story_v_out_321371.awb")

						arg_291_1:RecordAudio("321371070", var_294_6)
						arg_291_1:RecordAudio("321371070", var_294_6)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_321371", "321371070", "story_v_out_321371.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_321371", "321371070", "story_v_out_321371.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play321371071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 321371071
		arg_295_1.duration_ = 8.63

		local var_295_0 = {
			zh = 4.733,
			ja = 8.633
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play321371072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.65

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:GetWordFromCfg(321371071)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 26 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 26)

				if (26 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 26)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371071", "story_v_out_321371.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371071", "story_v_out_321371.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_321371", "321371071", "story_v_out_321371.awb")

						arg_295_1:RecordAudio("321371071", var_298_6)
						arg_295_1:RecordAudio("321371071", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_321371", "321371071", "story_v_out_321371.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_321371", "321371071", "story_v_out_321371.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play321371072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 321371072
		arg_299_1.duration_ = 5.17

		local var_299_0 = {
			zh = 2.9,
			ja = 5.166
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play321371073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.275

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_1 = arg_299_1:GetWordFromCfg(321371072)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 11 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 11)

				if (11 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 11)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371072", "story_v_out_321371.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371072", "story_v_out_321371.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_321371", "321371072", "story_v_out_321371.awb")

						arg_299_1:RecordAudio("321371072", var_302_6)
						arg_299_1:RecordAudio("321371072", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_321371", "321371072", "story_v_out_321371.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_321371", "321371072", "story_v_out_321371.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play321371073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 321371073
		arg_303_1.duration_ = 6.73

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play321371074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1037ui_story"]) and arg_303_1.var_.characterEffect1037ui_story == nil then
				arg_303_1.var_.characterEffect1037ui_story = arg_303_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1037ui_story"]) then
				if arg_303_1.var_.characterEffect1037ui_story and not isNil(arg_303_1.actors_["1037ui_story"]) then
					arg_303_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1037ui_story"]) and arg_303_1.var_.characterEffect1037ui_story then
				arg_303_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_306_1

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				local var_306_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_306_2 then
					var_306_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_306_2.radialBlurScale = 0
					var_306_2.radialBlurGradient = 1
					var_306_2.radialBlurIntensity = 1

					if var_306_1 then
						var_306_2.radialBlurTarget = var_306_1.transform
					end
				end
			end

			local var_306_3 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_3 then
				local var_306_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_306_4 then
					var_306_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_306_4.radialBlurScale = Mathf.Lerp(0, 0, (arg_303_1.time_ - 0) / var_306_3)
					var_306_4.radialBlurGradient = Mathf.Lerp(1, 1, (arg_303_1.time_ - 0) / var_306_3)
					var_306_4.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_303_1.time_ - 0) / var_306_3)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_3 and arg_303_1.time_ < 0 + var_306_3 + arg_306_0 then
				local var_306_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_306_5 then
					var_306_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_306_5.radialBlurScale = 0
					var_306_5.radialBlurGradient = 1
					var_306_5.radialBlurIntensity = 1
				end
			end

			local var_306_6 = 0

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = true

				arg_303_1:SetGaussion(false)
			end

			local var_306_7 = 2

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_7 then
				local var_306_8 = Color.New(1, 1, 1)

				var_306_8.a = Mathf.Lerp(1, 0, (arg_303_1.time_ - var_306_6) / var_306_7)
				arg_303_1.mask_.color = var_306_8
			end

			if arg_303_1.time_ >= var_306_6 + var_306_7 and arg_303_1.time_ < var_306_6 + var_306_7 + arg_306_0 then
				local var_306_9 = Color.New(1, 1, 1)

				arg_303_1.mask_.enabled = false
				var_306_9.a = 0
				arg_303_1.mask_.color = var_306_9
			end

			if arg_303_1.frameCnt_ <= 1 then
				arg_303_1.dialog_:SetActive(false)
			end

			local var_306_10 = 1.73333333333333
			local var_306_11 = 1.325

			if 1.73333333333333 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0

				arg_303_1.dialog_:SetActive(true)

				arg_303_1.dialogCg_.alpha = 0

				local var_306_12 = LeanTween.value(arg_303_1.dialog_, 0, 1, 0.3)

				var_306_12:setOnUpdate(LuaHelper.FloatAction(function(arg_307_0)
					arg_303_1.dialogCg_.alpha = arg_307_0
				end))
				var_306_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_303_1.dialog_)
					var_306_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_303_1.duration_ = arg_303_1.duration_ + 0.3

				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_13 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(321371073).content)

				arg_303_1.text_.text = var_306_13

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_15 = 53 <= 0 and var_306_11 or var_306_11 * (utf8.len(var_306_13) / 53)

				if (53 <= 0 and var_306_11 or var_306_11 * (utf8.len(var_306_13) / 53)) > 0 and var_306_11 < var_306_15 then
					arg_303_1.talkMaxDuration = var_306_15
					var_306_10 = var_306_10 + 0.3

					if var_306_15 + var_306_10 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_15 + var_306_10
					end
				end

				arg_303_1.text_.text = var_306_13
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_16 = var_306_10 + 0.3
			local var_306_17 = math.max(var_306_11, arg_303_1.talkMaxDuration)

			if var_306_10 + 0.3 <= arg_303_1.time_ and arg_303_1.time_ < var_306_16 + var_306_17 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_16) / var_306_17

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_16 + var_306_17 and arg_303_1.time_ < var_306_16 + var_306_17 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play321371074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 321371074
		arg_309_1.duration_ = 4.93

		local var_309_0 = {
			zh = 4.933,
			ja = 4.666
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play321371075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1043ui_story = arg_309_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1043ui_story"].transform.position).z)
				arg_309_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1043ui_story"].transform.localEulerAngles = arg_309_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_309_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1043ui_story"].transform.position).z)
				arg_309_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1043ui_story"].transform.localEulerAngles = arg_309_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1043ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1043ui_story == nil then
				arg_309_1.var_.characterEffect1043ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1043ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1043ui_story then
				arg_309_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_312_4 = 0
			local var_312_5 = 0.525

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(321371074)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 21 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 21)

				if (21 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 21)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371074", "story_v_out_321371.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371074", "story_v_out_321371.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_321371", "321371074", "story_v_out_321371.awb")

						arg_309_1:RecordAudio("321371074", var_312_11)
						arg_309_1:RecordAudio("321371074", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_321371", "321371074", "story_v_out_321371.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_321371", "321371074", "story_v_out_321371.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
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

		arg_309_1:InitPlayNodeList()
	end,
	Play321371075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 321371075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play321371076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1043ui_story = arg_313_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).z)
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles = arg_313_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1043ui_story"].transform.position).z)
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1043ui_story"].transform.localEulerAngles = arg_313_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1043ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1043ui_story == nil then
				arg_313_1.var_.characterEffect1043ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1043ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_2)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1043ui_story then
				arg_313_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_316_3 = 0
			local var_316_4 = 0.675

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_3 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_5 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(321371075).content)

				arg_313_1.text_.text = var_316_5

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_7 = 27 <= 0 and var_316_4 or var_316_4 * (utf8.len(var_316_5) / 27)

				if (27 <= 0 and var_316_4 or var_316_4 * (utf8.len(var_316_5) / 27)) > 0 and var_316_4 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_3 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_3
					end
				end

				arg_313_1.text_.text = var_316_5
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_8 = math.max(var_316_4, arg_313_1.talkMaxDuration)

			if var_316_3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_3 + var_316_8 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_3) / var_316_8

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_3 + var_316_8 and arg_313_1.time_ < var_316_3 + var_316_8 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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

		arg_313_1:InitPlayNodeList()
	end,
	Play321371076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 321371076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play321371077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1.225

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

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(321371076).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 49 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 49)

				if (49 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 49)) > 0 and var_320_0 < var_320_3 then
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
	Play321371077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 321371077
		arg_321_1.duration_ = 6.63

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play321371078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				local var_324_0 = arg_321_1.var_.effectzhongnu1

				if not arg_321_1.var_.effectzhongnu1 then
					var_324_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_324_0.name = "zhongnu1"
					arg_321_1.var_.effectzhongnu1 = var_324_0
				else
					var_324_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_324_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_324_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_321_1.time_ and arg_321_1.time_ <= 2 + arg_324_0 then
				if arg_321_1.var_.effectzhongnu1 then
					Object.Destroy(arg_321_1.var_.effectzhongnu1)

					arg_321_1.var_.effectzhongnu1 = nil
				end
			end

			local var_324_3 = manager.ui.mainCamera.transform

			if 0.0666666666666667 < arg_321_1.time_ and arg_321_1.time_ <= 0.0666666666666667 + arg_324_0 then
				arg_321_1.var_.shakeOldPos = var_324_3.localPosition
			end

			local var_324_4 = 0.333333333333333

			if 0.0666666666666667 <= arg_321_1.time_ and arg_321_1.time_ < 0.0666666666666667 + var_324_4 then
				local var_324_5, var_324_6 = math.modf((arg_321_1.time_ - 0.0666666666666667) / 0.066)

				var_324_3.localPosition = Vector3.New(var_324_6 * 0.13, var_324_6 * 0.13, var_324_6 * 0.13) + arg_321_1.var_.shakeOldPos
			end

			if arg_321_1.time_ >= 0.0666666666666667 + var_324_4 and arg_321_1.time_ < 0.0666666666666667 + var_324_4 + arg_324_0 then
				var_324_3.localPosition = arg_321_1.var_.shakeOldPos
			end

			local var_324_7 = 0

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_7 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			if arg_321_1.time_ >= var_324_7 + 2 and arg_321_1.time_ < var_324_7 + 2 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end

			if 0.05 < arg_321_1.time_ and arg_321_1.time_ <= 0.05 + arg_324_0 then
				arg_321_1:AudioAction("play", "effect", "se_story_141", "se_story_141_crossbow", "")
			end

			if arg_321_1.frameCnt_ <= 1 then
				arg_321_1.dialog_:SetActive(false)
			end

			local var_324_9 = 1.63333333333333
			local var_324_10 = 1.425

			if 1.63333333333333 < arg_321_1.time_ and arg_321_1.time_ <= var_324_9 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				arg_321_1.dialog_:SetActive(true)

				arg_321_1.dialogCg_.alpha = 0

				local var_324_11 = LeanTween.value(arg_321_1.dialog_, 0, 1, 0.3)

				var_324_11:setOnUpdate(LuaHelper.FloatAction(function(arg_325_0)
					arg_321_1.dialogCg_.alpha = arg_325_0
				end))
				var_324_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_321_1.dialog_)
					var_324_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_321_1.duration_ = arg_321_1.duration_ + 0.3

				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_12 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(321371077).content)

				arg_321_1.text_.text = var_324_12

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_14 = 57 <= 0 and var_324_10 or var_324_10 * (utf8.len(var_324_12) / 57)

				if (57 <= 0 and var_324_10 or var_324_10 * (utf8.len(var_324_12) / 57)) > 0 and var_324_10 < var_324_14 then
					arg_321_1.talkMaxDuration = var_324_14
					var_324_9 = var_324_9 + 0.3

					if var_324_14 + var_324_9 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_14 + var_324_9
					end
				end

				arg_321_1.text_.text = var_324_12
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_15 = var_324_9 + 0.3
			local var_324_16 = math.max(var_324_10, arg_321_1.talkMaxDuration)

			if var_324_9 + 0.3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_16 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_16

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_16 and arg_321_1.time_ < var_324_15 + var_324_16 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play321371078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 321371078
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play321371079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0.566666666666667 < arg_327_1.time_ and arg_327_1.time_ <= 0.566666666666667 + arg_330_0 then
				arg_327_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_whoosh", "")
			end

			local var_330_1 = 0
			local var_330_2 = 0.825

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(321371078).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 33 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 33)

				if (33 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 33)) > 0 and var_330_2 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_6 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_6 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_6

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_6 and arg_327_1.time_ < var_330_1 + var_330_6 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play321371079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 321371079
		arg_331_1.duration_ = 6.67

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play321371080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				local var_334_0 = arg_331_1.var_.effectqiangbiposui1

				if not arg_331_1.var_.effectqiangbiposui1 then
					var_334_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_334_0.name = "qiangbiposui1"
					arg_331_1.var_.effectqiangbiposui1 = var_334_0
				else
					var_334_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_334_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_334_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_331_1.time_ and arg_331_1.time_ <= 2 + arg_334_0 then
				if arg_331_1.var_.effectqiangbiposui1 then
					Object.Destroy(arg_331_1.var_.effectqiangbiposui1)

					arg_331_1.var_.effectqiangbiposui1 = nil
				end
			end

			local var_334_3 = manager.ui.mainCamera.transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.shakeOldPos = var_334_3.localPosition
			end

			local var_334_4 = 1.43333333333333

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				local var_334_5, var_334_6 = math.modf((arg_331_1.time_ - 0) / 0.066)

				var_334_3.localPosition = Vector3.New(var_334_6 * 0.13, var_334_6 * 0.13, var_334_6 * 0.13) + arg_331_1.var_.shakeOldPos
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				var_334_3.localPosition = arg_331_1.var_.shakeOldPos
			end

			local var_334_7 = 0

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_7 + arg_334_0 then
				arg_331_1.allBtn_.enabled = false
			end

			if arg_331_1.time_ >= var_334_7 + 1.43333333333333 and arg_331_1.time_ < var_334_7 + 1.43333333333333 + arg_334_0 then
				arg_331_1.allBtn_.enabled = true
			end

			if 0.05 < arg_331_1.time_ and arg_331_1.time_ <= 0.05 + arg_334_0 then
				arg_331_1:AudioAction("play", "effect", "se_story_141", "se_story_141_wall_destroy", "")
			end

			if arg_331_1.frameCnt_ <= 1 then
				arg_331_1.dialog_:SetActive(false)
			end

			local var_334_9 = 1.66666666666667
			local var_334_10 = 1.35

			if 1.66666666666667 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0

				arg_331_1.dialog_:SetActive(true)

				arg_331_1.dialogCg_.alpha = 0

				local var_334_11 = LeanTween.value(arg_331_1.dialog_, 0, 1, 0.3)

				var_334_11:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_331_1.dialogCg_.alpha = arg_335_0
				end))
				var_334_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_331_1.dialog_)
					var_334_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_331_1.duration_ = arg_331_1.duration_ + 0.3

				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_12 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(321371079).content)

				arg_331_1.text_.text = var_334_12

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_14 = 54 <= 0 and var_334_10 or var_334_10 * (utf8.len(var_334_12) / 54)

				if (54 <= 0 and var_334_10 or var_334_10 * (utf8.len(var_334_12) / 54)) > 0 and var_334_10 < var_334_14 then
					arg_331_1.talkMaxDuration = var_334_14
					var_334_9 = var_334_9 + 0.3

					if var_334_14 + var_334_9 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_9
					end
				end

				arg_331_1.text_.text = var_334_12
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_15 = var_334_9 + 0.3
			local var_334_16 = math.max(var_334_10, arg_331_1.talkMaxDuration)

			if var_334_9 + 0.3 <= arg_331_1.time_ and arg_331_1.time_ < var_334_15 + var_334_16 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_15) / var_334_16

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_15 + var_334_16 and arg_331_1.time_ < var_334_15 + var_334_16 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play321371080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 321371080
		arg_337_1.duration_ = 3.27

		local var_337_0 = {
			zh = 2.333,
			ja = 3.266
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play321371081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.25

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_1 = arg_337_1:GetWordFromCfg(321371080)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 10 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 10)

				if (10 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 10)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371080", "story_v_out_321371.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371080", "story_v_out_321371.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_321371", "321371080", "story_v_out_321371.awb")

						arg_337_1:RecordAudio("321371080", var_340_6)
						arg_337_1:RecordAudio("321371080", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_321371", "321371080", "story_v_out_321371.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_321371", "321371080", "story_v_out_321371.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play321371081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 321371081
		arg_341_1.duration_ = 4.93

		local var_341_0 = {
			zh = 4.3,
			ja = 4.933
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play321371082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1043ui_story = arg_341_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1043ui_story"].transform.position).z)
				arg_341_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1043ui_story"].transform.localEulerAngles = arg_341_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_341_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1043ui_story"].transform.position).z)
				arg_341_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1043ui_story"].transform.localEulerAngles = arg_341_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1043ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1043ui_story == nil then
				arg_341_1.var_.characterEffect1043ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1043ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1043ui_story then
				arg_341_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action8_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_344_4 = 0
			local var_344_5 = 0.45

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(321371081)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 18 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 18)

				if (18 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 18)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371081", "story_v_out_321371.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371081", "story_v_out_321371.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_321371", "321371081", "story_v_out_321371.awb")

						arg_341_1:RecordAudio("321371081", var_344_11)
						arg_341_1:RecordAudio("321371081", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_321371", "321371081", "story_v_out_321371.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_321371", "321371081", "story_v_out_321371.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play321371082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 321371082
		arg_345_1.duration_ = 7.5

		local var_345_0 = {
			zh = 7.5,
			ja = 7.4
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play321371083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 1.999999999999 < arg_345_1.time_ and arg_345_1.time_ <= 1.999999999999 + arg_348_0 then
				local var_348_0 = arg_345_1.bgs_.L09g

				arg_345_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_348_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_1 = var_348_0:GetComponent("SpriteRenderer")

				if var_348_1 and var_348_1.sprite then
					local var_348_2 = 2 * (var_348_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_348_0.transform.localScale = Vector3.New(var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "L09g" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_3 = 3.999999999999

			if 3.999999999999 < arg_345_1.time_ and arg_345_1.time_ <= var_348_3 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			if arg_345_1.time_ >= var_348_3 + 0.3 and arg_345_1.time_ < var_348_3 + 0.3 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_4 = 0

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_5 = 2

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_5 then
				local var_348_6 = Color.New(0, 0, 0)

				var_348_6.a = Mathf.Lerp(0, 1, (arg_345_1.time_ - var_348_4) / var_348_5)
				arg_345_1.mask_.color = var_348_6
			end

			if arg_345_1.time_ >= var_348_4 + var_348_5 and arg_345_1.time_ < var_348_4 + var_348_5 + arg_348_0 then
				local var_348_7 = Color.New(0, 0, 0)

				var_348_7.a = 1
				arg_345_1.mask_.color = var_348_7
			end

			local var_348_8 = 2

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_9 = 2

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_9 then
				local var_348_10 = Color.New(0, 0, 0)

				var_348_10.a = Mathf.Lerp(1, 0, (arg_345_1.time_ - var_348_8) / var_348_9)
				arg_345_1.mask_.color = var_348_10
			end

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 then
				local var_348_11 = Color.New(0, 0, 0)

				arg_345_1.mask_.enabled = false
				var_348_11.a = 0
				arg_345_1.mask_.color = var_348_11
			end

			local var_348_12 = arg_345_1.actors_["1043ui_story"].transform

			if 1.96599999815226 < arg_345_1.time_ and arg_345_1.time_ <= 1.96599999815226 + arg_348_0 then
				arg_345_1.var_.moveOldPos1043ui_story = var_348_12.localPosition
			end

			local var_348_13 = 0.001

			if 1.96599999815226 <= arg_345_1.time_ and arg_345_1.time_ < 1.96599999815226 + var_348_13 then
				var_348_12.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 1.96599999815226) / var_348_13)
				var_348_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_12.position).x, (manager.ui.mainCamera.transform.position - var_348_12.position).y, (manager.ui.mainCamera.transform.position - var_348_12.position).z)
				var_348_12.localEulerAngles.z = 0
				var_348_12.localEulerAngles.x = 0
				var_348_12.localEulerAngles = var_348_12.localEulerAngles
			end

			if arg_345_1.time_ >= 1.96599999815226 + var_348_13 and arg_345_1.time_ < 1.96599999815226 + var_348_13 + arg_348_0 then
				var_348_12.localPosition = Vector3.New(0, 100, 0)
				var_348_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_12.position).x, (manager.ui.mainCamera.transform.position - var_348_12.position).y, (manager.ui.mainCamera.transform.position - var_348_12.position).z)
				var_348_12.localEulerAngles.z = 0
				var_348_12.localEulerAngles.x = 0
				var_348_12.localEulerAngles = var_348_12.localEulerAngles
			end

			local var_348_14 = arg_345_1.actors_["1043ui_story"]

			if 1.96599999815226 < arg_345_1.time_ and arg_345_1.time_ <= 1.96599999815226 + arg_348_0 and not isNil(var_348_14) and arg_345_1.var_.characterEffect1043ui_story == nil then
				arg_345_1.var_.characterEffect1043ui_story = var_348_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_15 = 0.034000001847744

			if 1.96599999815226 <= arg_345_1.time_ and arg_345_1.time_ < 1.96599999815226 + var_348_15 and not isNil(var_348_14) then
				if arg_345_1.var_.characterEffect1043ui_story and not isNil(var_348_14) then
					arg_345_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 1.96599999815226) / var_348_15)
				end
			end

			if arg_345_1.time_ >= 1.96599999815226 + var_348_15 and arg_345_1.time_ < 1.96599999815226 + var_348_15 + arg_348_0 and not isNil(var_348_14) and arg_345_1.var_.characterEffect1043ui_story then
				arg_345_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_348_16 = arg_345_1.actors_["1111ui_story"].transform

			if 3.8 < arg_345_1.time_ and arg_345_1.time_ <= 3.8 + arg_348_0 then
				arg_345_1.var_.moveOldPos1111ui_story = var_348_16.localPosition
			end

			local var_348_17 = 0.001

			if 3.8 <= arg_345_1.time_ and arg_345_1.time_ < 3.8 + var_348_17 then
				var_348_16.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_345_1.time_ - 3.8) / var_348_17)
				var_348_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_16.position).x, (manager.ui.mainCamera.transform.position - var_348_16.position).y, (manager.ui.mainCamera.transform.position - var_348_16.position).z)
				var_348_16.localEulerAngles.z = 0
				var_348_16.localEulerAngles.x = 0
				var_348_16.localEulerAngles = var_348_16.localEulerAngles
			end

			if arg_345_1.time_ >= 3.8 + var_348_17 and arg_345_1.time_ < 3.8 + var_348_17 + arg_348_0 then
				var_348_16.localPosition = Vector3.New(0, -0.87, -5.7)
				var_348_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_16.position).x, (manager.ui.mainCamera.transform.position - var_348_16.position).y, (manager.ui.mainCamera.transform.position - var_348_16.position).z)
				var_348_16.localEulerAngles.z = 0
				var_348_16.localEulerAngles.x = 0
				var_348_16.localEulerAngles = var_348_16.localEulerAngles
			end

			local var_348_18 = arg_345_1.actors_["1111ui_story"]

			if 3.8 < arg_345_1.time_ and arg_345_1.time_ <= 3.8 + arg_348_0 and not isNil(var_348_18) and arg_345_1.var_.characterEffect1111ui_story == nil then
				arg_345_1.var_.characterEffect1111ui_story = var_348_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_19 = 0.200000002980232

			if 3.8 <= arg_345_1.time_ and arg_345_1.time_ < 3.8 + var_348_19 and not isNil(var_348_18) then
				if arg_345_1.var_.characterEffect1111ui_story and not isNil(var_348_18) then
					arg_345_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 3.8 + var_348_19 and arg_345_1.time_ < 3.8 + var_348_19 + arg_348_0 and not isNil(var_348_18) and arg_345_1.var_.characterEffect1111ui_story then
				arg_345_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 3.8 < arg_345_1.time_ and arg_345_1.time_ <= 3.8 + arg_348_0 then
				arg_345_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action7_2")
			end

			if 3.8 < arg_345_1.time_ and arg_345_1.time_ <= 3.8 + arg_348_0 then
				arg_345_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_21 = 4
			local var_348_22 = 0.325

			if 4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_21 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_23 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_23:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_24 = arg_345_1:GetWordFromCfg(321371082)
				local var_348_25 = arg_345_1:FormatText(var_348_24.content)

				arg_345_1.text_.text = var_348_25

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_27 = 13 <= 0 and var_348_22 or var_348_22 * (utf8.len(var_348_25) / 13)

				if (13 <= 0 and var_348_22 or var_348_22 * (utf8.len(var_348_25) / 13)) > 0 and var_348_22 < var_348_27 then
					arg_345_1.talkMaxDuration = var_348_27
					var_348_21 = var_348_21 + 0.3

					if var_348_27 + var_348_21 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_27 + var_348_21
					end
				end

				arg_345_1.text_.text = var_348_25
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371082", "story_v_out_321371.awb") ~= 0 then
					local var_348_28 = manager.audio:GetVoiceLength("story_v_out_321371", "321371082", "story_v_out_321371.awb") / 1000

					if var_348_28 + var_348_21 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_28 + var_348_21
					end

					if var_348_24.prefab_name ~= "" and arg_345_1.actors_[var_348_24.prefab_name] ~= nil then
						local var_348_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_24.prefab_name].transform, "story_v_out_321371", "321371082", "story_v_out_321371.awb")

						arg_345_1:RecordAudio("321371082", var_348_29)
						arg_345_1:RecordAudio("321371082", var_348_29)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_321371", "321371082", "story_v_out_321371.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_321371", "321371082", "story_v_out_321371.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_30 = var_348_21 + 0.3
			local var_348_31 = math.max(var_348_22, arg_345_1.talkMaxDuration)

			if var_348_21 + 0.3 <= arg_345_1.time_ and arg_345_1.time_ < var_348_30 + var_348_31 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_30) / var_348_31

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_30 + var_348_31 and arg_345_1.time_ < var_348_30 + var_348_31 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play321371083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 321371083
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play321371084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1111ui_story = arg_351_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).z)
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles = arg_351_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_351_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).z)
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles = arg_351_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_354_1 = arg_351_1.actors_["1111ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1111ui_story == nil then
				arg_351_1.var_.characterEffect1111ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect1111ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_2)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1111ui_story then
				arg_351_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_354_3 = 0
			local var_354_4 = 0.8

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_3 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_5 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(321371083).content)

				arg_351_1.text_.text = var_354_5

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_7 = 32 <= 0 and var_354_4 or var_354_4 * (utf8.len(var_354_5) / 32)

				if (32 <= 0 and var_354_4 or var_354_4 * (utf8.len(var_354_5) / 32)) > 0 and var_354_4 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_3 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_3
					end
				end

				arg_351_1.text_.text = var_354_5
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_8 = math.max(var_354_4, arg_351_1.talkMaxDuration)

			if var_354_3 <= arg_351_1.time_ and arg_351_1.time_ < var_354_3 + var_354_8 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_3) / var_354_8

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_3 + var_354_8 and arg_351_1.time_ < var_354_3 + var_354_8 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
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

		arg_351_1:InitPlayNodeList()
	end,
	Play321371084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 321371084
		arg_355_1.duration_ = 5.33

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play321371085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_9000

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				local var_358_0 = arg_355_1.var_.effect498

				if not arg_355_1.var_.effect498 then
					var_358_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_358_0.name = "498"
					arg_355_1.var_.effect498 = var_358_0
				else
					var_358_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_358_0.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_358_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_358_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_358_0, iter_358_1 in ipairs((var_358_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_358_1.transform.localScale = Vector3.New(iter_358_1.transform.localScale.x / var_358_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_358_1.transform.localScale.y / var_358_2, iter_358_1.transform.localScale.z)
				end
			end

			if 0.875 < arg_355_1.time_ and arg_355_1.time_ <= 0.875 + arg_358_0 then
				if arg_355_1.var_.effect498 then
					Object.Destroy(arg_355_1.var_.effect498)

					arg_355_1.var_.effect498 = nil
				end
			end

			local var_358_5 = 0

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 then
				arg_355_1.allBtn_.enabled = false
			end

			if arg_355_1.time_ >= var_358_5 + 0.875 and arg_355_1.time_ < var_358_5 + 0.875 + arg_358_0 then
				arg_355_1.allBtn_.enabled = true
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				local var_358_6 = arg_355_1.var_.effecttankai1

				if not arg_355_1.var_.effecttankai1 then
					var_358_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_358_6.name = "tankai1"
					arg_355_1.var_.effecttankai1 = var_358_6
				else
					var_358_6.transform:SetParent(var_358_9000)
				end

				var_358_6.transform.localPosition = Vector3.New(0, 0, -1)
				var_358_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_355_1.time_ and arg_355_1.time_ <= 1 + arg_358_0 then
				if arg_355_1.var_.effecttankai1 then
					Object.Destroy(arg_355_1.var_.effecttankai1)

					arg_355_1.var_.effecttankai1 = nil
				end
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_sword01", "")
			end

			local var_358_10 = 0.333333333333333
			local var_358_11 = 0.975

			if 0.333333333333333 < arg_355_1.time_ and arg_355_1.time_ <= var_358_10 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_12 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(321371084).content)

				arg_355_1.text_.text = var_358_12

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_14 = 39 <= 0 and var_358_11 or var_358_11 * (utf8.len(var_358_12) / 39)

				if (39 <= 0 and var_358_11 or var_358_11 * (utf8.len(var_358_12) / 39)) > 0 and var_358_11 < var_358_14 then
					arg_355_1.talkMaxDuration = var_358_14

					if var_358_14 + var_358_10 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_10
					end
				end

				arg_355_1.text_.text = var_358_12
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_15 = math.max(var_358_11, arg_355_1.talkMaxDuration)

			if var_358_10 <= arg_355_1.time_ and arg_355_1.time_ < var_358_10 + var_358_15 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_10) / var_358_15

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_10 + var_358_15 and arg_355_1.time_ < var_358_10 + var_358_15 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play321371085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 321371085
		arg_359_1.duration_ = 2

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play321371086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1111ui_story = arg_359_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).z)
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles = arg_359_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_359_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).z)
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles = arg_359_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["1111ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1111ui_story == nil then
				arg_359_1.var_.characterEffect1111ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect1111ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1111ui_story then
				arg_359_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_362_4 = 0
			local var_362_5 = 0.15

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(321371085)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 6 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 6)

				if (6 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 6)) > 0 and var_362_5 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371085", "story_v_out_321371.awb") ~= 0 then
					local var_362_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371085", "story_v_out_321371.awb") / 1000

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end

					if var_362_6.prefab_name ~= "" and arg_359_1.actors_[var_362_6.prefab_name] ~= nil then
						local var_362_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_6.prefab_name].transform, "story_v_out_321371", "321371085", "story_v_out_321371.awb")

						arg_359_1:RecordAudio("321371085", var_362_11)
						arg_359_1:RecordAudio("321371085", var_362_11)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_321371", "321371085", "story_v_out_321371.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_321371", "321371085", "story_v_out_321371.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_12 and arg_359_1.time_ < var_362_4 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
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

		arg_359_1:InitPlayNodeList()
	end,
	Play321371086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 321371086
		arg_363_1.duration_ = 4.8

		local var_363_0 = {
			zh = 3,
			ja = 4.8
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play321371087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1111ui_story"]) and arg_363_1.var_.characterEffect1111ui_story == nil then
				arg_363_1.var_.characterEffect1111ui_story = arg_363_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1111ui_story"]) then
				if arg_363_1.var_.characterEffect1111ui_story and not isNil(arg_363_1.actors_["1111ui_story"]) then
					arg_363_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1111ui_story"]) and arg_363_1.var_.characterEffect1111ui_story then
				arg_363_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_366_1 = 0
			local var_366_2 = 0.4

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:GetWordFromCfg(321371086)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_6 = 16 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_4) / 16)

				if (16 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_4) / 16)) > 0 and var_366_2 < var_366_6 then
					arg_363_1.talkMaxDuration = var_366_6

					if var_366_6 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_6 + var_366_1
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371086", "story_v_out_321371.awb") ~= 0 then
					local var_366_7 = manager.audio:GetVoiceLength("story_v_out_321371", "321371086", "story_v_out_321371.awb") / 1000

					if var_366_7 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_1
					end

					if var_366_3.prefab_name ~= "" and arg_363_1.actors_[var_366_3.prefab_name] ~= nil then
						local var_366_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_3.prefab_name].transform, "story_v_out_321371", "321371086", "story_v_out_321371.awb")

						arg_363_1:RecordAudio("321371086", var_366_8)
						arg_363_1:RecordAudio("321371086", var_366_8)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_321371", "321371086", "story_v_out_321371.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_321371", "321371086", "story_v_out_321371.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_9 = math.max(var_366_2, arg_363_1.talkMaxDuration)

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_9 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_1) / var_366_9

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_1 + var_366_9 and arg_363_1.time_ < var_366_1 + var_366_9 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play321371087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 321371087
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play321371088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10131ui_story = arg_367_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10131ui_story"].transform.position).z)
				arg_367_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["10131ui_story"].transform.localEulerAngles = arg_367_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_367_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10131ui_story"].transform.position).z)
				arg_367_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["10131ui_story"].transform.localEulerAngles = arg_367_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["1111ui_story"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1111ui_story = var_370_1.localPosition
			end

			local var_370_2 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 then
				var_370_1.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_367_1.time_ - 0) / var_370_2)
				var_370_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_1.position).x, (manager.ui.mainCamera.transform.position - var_370_1.position).y, (manager.ui.mainCamera.transform.position - var_370_1.position).z)
				var_370_1.localEulerAngles.z = 0
				var_370_1.localEulerAngles.x = 0
				var_370_1.localEulerAngles = var_370_1.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 then
				var_370_1.localPosition = Vector3.New(0, 100, 0)
				var_370_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_1.position).x, (manager.ui.mainCamera.transform.position - var_370_1.position).y, (manager.ui.mainCamera.transform.position - var_370_1.position).z)
				var_370_1.localEulerAngles.z = 0
				var_370_1.localEulerAngles.x = 0
				var_370_1.localEulerAngles = var_370_1.localEulerAngles
			end

			local var_370_3 = 0
			local var_370_4 = 1.525

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_3 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_5 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(321371087).content)

				arg_367_1.text_.text = var_370_5

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_7 = 61 <= 0 and var_370_4 or var_370_4 * (utf8.len(var_370_5) / 61)

				if (61 <= 0 and var_370_4 or var_370_4 * (utf8.len(var_370_5) / 61)) > 0 and var_370_4 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_3 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_3
					end
				end

				arg_367_1.text_.text = var_370_5
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_8 = math.max(var_370_4, arg_367_1.talkMaxDuration)

			if var_370_3 <= arg_367_1.time_ and arg_367_1.time_ < var_370_3 + var_370_8 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_3) / var_370_8

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_3 + var_370_8 and arg_367_1.time_ < var_370_3 + var_370_8 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
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

		arg_367_1:InitPlayNodeList()
	end,
	Play321371088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 321371088
		arg_371_1.duration_ = 4.27

		local var_371_0 = {
			zh = 4.266,
			ja = 4.2
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play321371089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1111ui_story = arg_371_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1111ui_story"].transform.position).z)
				arg_371_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1111ui_story"].transform.localEulerAngles = arg_371_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_371_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1111ui_story"].transform.position).z)
				arg_371_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1111ui_story"].transform.localEulerAngles = arg_371_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1111ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1111ui_story == nil then
				arg_371_1.var_.characterEffect1111ui_story = var_374_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 and not isNil(var_374_1) then
				if arg_371_1.var_.characterEffect1111ui_story and not isNil(var_374_1) then
					arg_371_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1111ui_story then
				arg_371_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_374_4 = 0
			local var_374_5 = 0.5

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_6 = arg_371_1:GetWordFromCfg(321371088)
				local var_374_7 = arg_371_1:FormatText(var_374_6.content)

				arg_371_1.text_.text = var_374_7

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 20 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 20)

				if (20 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 20)) > 0 and var_374_5 < var_374_9 then
					arg_371_1.talkMaxDuration = var_374_9

					if var_374_9 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_7
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371088", "story_v_out_321371.awb") ~= 0 then
					local var_374_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371088", "story_v_out_321371.awb") / 1000

					if var_374_10 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_4
					end

					if var_374_6.prefab_name ~= "" and arg_371_1.actors_[var_374_6.prefab_name] ~= nil then
						local var_374_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_6.prefab_name].transform, "story_v_out_321371", "321371088", "story_v_out_321371.awb")

						arg_371_1:RecordAudio("321371088", var_374_11)
						arg_371_1:RecordAudio("321371088", var_374_11)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_321371", "321371088", "story_v_out_321371.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_321371", "321371088", "story_v_out_321371.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_12 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_12 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_4) / var_374_12

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_4 + var_374_12 and arg_371_1.time_ < var_374_4 + var_374_12 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
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

		arg_371_1:InitPlayNodeList()
	end,
	Play321371089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 321371089
		arg_375_1.duration_ = 8.7

		local var_375_0 = {
			zh = 6.9,
			ja = 8.7
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play321371090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.7

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:GetWordFromCfg(321371089)
				local var_378_2 = arg_375_1:FormatText(var_378_1.content)

				arg_375_1.text_.text = var_378_2

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_4 = 28 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 28)

				if (28 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 28)) > 0 and var_378_0 < var_378_4 then
					arg_375_1.talkMaxDuration = var_378_4

					if var_378_4 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_4 + 0
					end
				end

				arg_375_1.text_.text = var_378_2
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371089", "story_v_out_321371.awb") ~= 0 then
					local var_378_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371089", "story_v_out_321371.awb") / 1000

					if var_378_5 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + 0
					end

					if var_378_1.prefab_name ~= "" and arg_375_1.actors_[var_378_1.prefab_name] ~= nil then
						local var_378_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_1.prefab_name].transform, "story_v_out_321371", "321371089", "story_v_out_321371.awb")

						arg_375_1:RecordAudio("321371089", var_378_6)
						arg_375_1:RecordAudio("321371089", var_378_6)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_321371", "321371089", "story_v_out_321371.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_321371", "321371089", "story_v_out_321371.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_7 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_7

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play321371090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 321371090
		arg_379_1.duration_ = 7

		local var_379_0 = {
			zh = 6.6,
			ja = 7
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play321371091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1111ui_story = arg_379_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).z)
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles = arg_379_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_379_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1111ui_story"].transform.position).z)
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1111ui_story"].transform.localEulerAngles = arg_379_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			local var_382_1 = 0
			local var_382_2 = 0.75

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_3 = arg_379_1:GetWordFromCfg(321371090)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_6 = 30 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_4) / 30)

				if (30 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_4) / 30)) > 0 and var_382_2 < var_382_6 then
					arg_379_1.talkMaxDuration = var_382_6

					if var_382_6 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_6 + var_382_1
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371090", "story_v_out_321371.awb") ~= 0 then
					local var_382_7 = manager.audio:GetVoiceLength("story_v_out_321371", "321371090", "story_v_out_321371.awb") / 1000

					if var_382_7 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_1
					end

					if var_382_3.prefab_name ~= "" and arg_379_1.actors_[var_382_3.prefab_name] ~= nil then
						local var_382_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_3.prefab_name].transform, "story_v_out_321371", "321371090", "story_v_out_321371.awb")

						arg_379_1:RecordAudio("321371090", var_382_8)
						arg_379_1:RecordAudio("321371090", var_382_8)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_321371", "321371090", "story_v_out_321371.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_321371", "321371090", "story_v_out_321371.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_9 = math.max(var_382_2, arg_379_1.talkMaxDuration)

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_9 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_1) / var_382_9

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_1 + var_382_9 and arg_379_1.time_ < var_382_1 + var_382_9 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play321371091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 321371091
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play321371092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1111ui_story = arg_383_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).z)
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles = arg_383_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1111ui_story"].transform.position).z)
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1111ui_story"].transform.localEulerAngles = arg_383_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_386_1 = arg_383_1.actors_["1111ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1111ui_story == nil then
				arg_383_1.var_.characterEffect1111ui_story = var_386_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_2 and not isNil(var_386_1) then
				if arg_383_1.var_.characterEffect1111ui_story and not isNil(var_386_1) then
					arg_383_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_2)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_2 and arg_383_1.time_ < 0 + var_386_2 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1111ui_story then
				arg_383_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_386_3 = 0
			local var_386_4 = 0.475

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_3 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_5 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(321371091).content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 19 <= 0 and var_386_4 or var_386_4 * (utf8.len(var_386_5) / 19)

				if (19 <= 0 and var_386_4 or var_386_4 * (utf8.len(var_386_5) / 19)) > 0 and var_386_4 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_3 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_3
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_8 = math.max(var_386_4, arg_383_1.talkMaxDuration)

			if var_386_3 <= arg_383_1.time_ and arg_383_1.time_ < var_386_3 + var_386_8 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_3) / var_386_8

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_3 + var_386_8 and arg_383_1.time_ < var_386_3 + var_386_8 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
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

		arg_383_1:InitPlayNodeList()
	end,
	Play321371092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 321371092
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play321371093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 1.625

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(321371092).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 65 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 65)

				if (65 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 65)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play321371093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 321371093
		arg_391_1.duration_ = 2.93

		local var_391_0 = {
			zh = 2.933,
			ja = 1.999999999999
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play321371094(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1111ui_story = arg_391_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1111ui_story"].transform.position).z)
				arg_391_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1111ui_story"].transform.localEulerAngles = arg_391_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_391_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1111ui_story"].transform.position).z)
				arg_391_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1111ui_story"].transform.localEulerAngles = arg_391_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_394_1 = arg_391_1.actors_["1111ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1111ui_story == nil then
				arg_391_1.var_.characterEffect1111ui_story = var_394_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_2 and not isNil(var_394_1) then
				if arg_391_1.var_.characterEffect1111ui_story and not isNil(var_394_1) then
					arg_391_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_2 and arg_391_1.time_ < 0 + var_394_2 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1111ui_story then
				arg_391_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action445")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_394_4 = 0
			local var_394_5 = 0.15

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_4 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_6 = arg_391_1:GetWordFromCfg(321371093)
				local var_394_7 = arg_391_1:FormatText(var_394_6.content)

				arg_391_1.text_.text = var_394_7

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_9 = 6 <= 0 and var_394_5 or var_394_5 * (utf8.len(var_394_7) / 6)

				if (6 <= 0 and var_394_5 or var_394_5 * (utf8.len(var_394_7) / 6)) > 0 and var_394_5 < var_394_9 then
					arg_391_1.talkMaxDuration = var_394_9

					if var_394_9 + var_394_4 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_9 + var_394_4
					end
				end

				arg_391_1.text_.text = var_394_7
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371093", "story_v_out_321371.awb") ~= 0 then
					local var_394_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371093", "story_v_out_321371.awb") / 1000

					if var_394_10 + var_394_4 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_10 + var_394_4
					end

					if var_394_6.prefab_name ~= "" and arg_391_1.actors_[var_394_6.prefab_name] ~= nil then
						local var_394_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_6.prefab_name].transform, "story_v_out_321371", "321371093", "story_v_out_321371.awb")

						arg_391_1:RecordAudio("321371093", var_394_11)
						arg_391_1:RecordAudio("321371093", var_394_11)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_321371", "321371093", "story_v_out_321371.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_321371", "321371093", "story_v_out_321371.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_12 = math.max(var_394_5, arg_391_1.talkMaxDuration)

			if var_394_4 <= arg_391_1.time_ and arg_391_1.time_ < var_394_4 + var_394_12 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_4) / var_394_12

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_4 + var_394_12 and arg_391_1.time_ < var_394_4 + var_394_12 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
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

		arg_391_1:InitPlayNodeList()
	end,
	Play321371094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 321371094
		arg_395_1.duration_ = 7

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play321371095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_9003
			local var_398_9002
			local var_398_9001
			local var_398_9000

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1111ui_story = arg_395_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).z)
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles = arg_395_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_395_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).z)
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles = arg_395_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["1111ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1111ui_story == nil then
				arg_395_1.var_.characterEffect1111ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.034000001847744

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect1111ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_2)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1111ui_story then
				arg_395_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_395_1.time_ and arg_395_1.time_ <= 1.2 + arg_398_0 then
				local var_398_3 = arg_395_1.var_.effectchenai1

				if not arg_395_1.var_.effectchenai1 then
					var_398_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_mist_in"), manager.ui.mainCamera.transform)
					var_398_3.name = "chenai1"
					arg_395_1.var_.effectchenai1 = var_398_3
				else
					var_398_3.transform:SetParent(var_398_9003)
				end

				var_398_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_398_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_395_1.time_ and arg_395_1.time_ <= 1.2 + arg_398_0 then
				local var_398_5 = arg_395_1.var_.effectchenai4

				if not arg_395_1.var_.effectchenai4 then
					var_398_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), manager.ui.mainCamera.transform)
					var_398_5.name = "chenai4"
					arg_395_1.var_.effectchenai4 = var_398_5
				else
					var_398_5.transform:SetParent(var_398_9002)
				end

				var_398_5.transform.localPosition = Vector3.New(0, 0, -5.34)
				var_398_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_398_7 = manager.ui.mainCamera.transform

			if 1.2 < arg_395_1.time_ and arg_395_1.time_ <= 1.2 + arg_398_0 then
				arg_395_1.var_.shakeOldPos = var_398_7.localPosition
			end

			local var_398_8 = 1.5

			if 1.2 <= arg_395_1.time_ and arg_395_1.time_ < 1.2 + var_398_8 then
				local var_398_9, var_398_10 = math.modf((arg_395_1.time_ - 1.2) / 0.066)

				var_398_7.localPosition = Vector3.New(var_398_10 * 0.13, var_398_10 * 0.13, var_398_10 * 0.13) + arg_395_1.var_.shakeOldPos
			end

			if arg_395_1.time_ >= 1.2 + var_398_8 and arg_395_1.time_ < 1.2 + var_398_8 + arg_398_0 then
				var_398_7.localPosition = arg_395_1.var_.shakeOldPos
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				local var_398_11 = arg_395_1.var_.effectbiaocengjingxiang

				if not arg_395_1.var_.effectbiaocengjingxiang then
					var_398_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_398_11.name = "biaocengjingxiang"
					arg_395_1.var_.effectbiaocengjingxiang = var_398_11
				else
					var_398_11.transform:SetParent(var_398_9001)
				end

				var_398_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_398_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_395_1.time_ and arg_395_1.time_ <= 1.2 + arg_398_0 then
				local var_398_13 = arg_395_1.var_.effectbiaocengjingxiang2

				if not arg_395_1.var_.effectbiaocengjingxiang2 then
					var_398_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_398_13.name = "biaocengjingxiang2"
					arg_395_1.var_.effectbiaocengjingxiang2 = var_398_13
				else
					var_398_13.transform:SetParent(var_398_9000)
				end

				var_398_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_398_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.9 < arg_395_1.time_ and arg_395_1.time_ <= 1.9 + arg_398_0 then
				if arg_395_1.var_.effectbiaocengjingxiang2 then
					Object.Destroy(arg_395_1.var_.effectbiaocengjingxiang2)

					arg_395_1.var_.effectbiaocengjingxiang2 = nil
				end
			end

			if 1.2 < arg_395_1.time_ and arg_395_1.time_ <= 1.2 + arg_398_0 then
				if arg_395_1.var_.effectbiaocengjingxiang then
					Object.Destroy(arg_395_1.var_.effectbiaocengjingxiang)

					arg_395_1.var_.effectbiaocengjingxiang = nil
				end
			end

			local var_398_17 = 0

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_17 + arg_398_0 then
				arg_395_1.allBtn_.enabled = false
			end

			if arg_395_1.time_ >= var_398_17 + 1.7 and arg_395_1.time_ < var_398_17 + 1.7 + arg_398_0 then
				arg_395_1.allBtn_.enabled = true
			end

			if 1.2 < arg_395_1.time_ and arg_395_1.time_ <= 1.2 + arg_398_0 then
				arg_395_1:AudioAction("play", "effect", "se_story_141", "se_story_141_hit", "")
			end

			if arg_395_1.frameCnt_ <= 1 then
				arg_395_1.dialog_:SetActive(false)
			end

			local var_398_19 = 2
			local var_398_20 = 1.55

			if 2 < arg_395_1.time_ and arg_395_1.time_ <= var_398_19 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0

				arg_395_1.dialog_:SetActive(true)

				arg_395_1.dialogCg_.alpha = 0

				local var_398_21 = LeanTween.value(arg_395_1.dialog_, 0, 1, 0.3)

				var_398_21:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_395_1.dialogCg_.alpha = arg_399_0
				end))
				var_398_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_395_1.dialog_)
					var_398_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_395_1.duration_ = arg_395_1.duration_ + 0.3

				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_22 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(321371094).content)

				arg_395_1.text_.text = var_398_22

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_24 = 62 <= 0 and var_398_20 or var_398_20 * (utf8.len(var_398_22) / 62)

				if (62 <= 0 and var_398_20 or var_398_20 * (utf8.len(var_398_22) / 62)) > 0 and var_398_20 < var_398_24 then
					arg_395_1.talkMaxDuration = var_398_24
					var_398_19 = var_398_19 + 0.3

					if var_398_24 + var_398_19 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_24 + var_398_19
					end
				end

				arg_395_1.text_.text = var_398_22
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_25 = var_398_19 + 0.3
			local var_398_26 = math.max(var_398_20, arg_395_1.talkMaxDuration)

			if var_398_19 + 0.3 <= arg_395_1.time_ and arg_395_1.time_ < var_398_25 + var_398_26 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_25) / var_398_26

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_25 + var_398_26 and arg_395_1.time_ < var_398_25 + var_398_26 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
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

		arg_395_1:InitPlayNodeList()
	end,
	Play321371095 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 321371095
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play321371096(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 1.275

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(321371095).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 51 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 51)

				if (51 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 51)) > 0 and var_404_0 < var_404_3 then
					arg_401_1.talkMaxDuration = var_404_3

					if var_404_3 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_3 + 0
					end
				end

				arg_401_1.text_.text = var_404_1
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_4 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_4

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play321371096 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 321371096
		arg_405_1.duration_ = 5.77

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play321371097(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_408_0 = 0.766666666666667

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				local var_408_1, var_408_2 = math.modf((arg_405_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_408_2 * 0.13, var_408_2 * 0.13, var_408_2 * 0.13) + arg_405_1.var_.shakeOldPos
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				manager.ui.mainCamera.transform.localPosition = arg_405_1.var_.shakeOldPos
			end

			local var_408_3 = 0

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_3 + arg_408_0 then
				arg_405_1.allBtn_.enabled = false
			end

			if arg_405_1.time_ >= var_408_3 + 1.1 and arg_405_1.time_ < var_408_3 + 1.1 + arg_408_0 then
				arg_405_1.allBtn_.enabled = true
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				if arg_405_1.var_.effectchenai1 then
					Object.Destroy(arg_405_1.var_.effectchenai1)

					arg_405_1.var_.effectchenai1 = nil
				end
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				if arg_405_1.var_.effectchenai4 then
					Object.Destroy(arg_405_1.var_.effectchenai4)

					arg_405_1.var_.effectchenai4 = nil
				end
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_141", "se_story_141_snake04", "")
			end

			if arg_405_1.frameCnt_ <= 1 then
				arg_405_1.dialog_:SetActive(false)
			end

			local var_408_7 = 0.766666666666667
			local var_408_8 = 1.15

			if 0.766666666666667 < arg_405_1.time_ and arg_405_1.time_ <= var_408_7 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				arg_405_1.dialog_:SetActive(true)

				arg_405_1.dialogCg_.alpha = 0

				local var_408_9 = LeanTween.value(arg_405_1.dialog_, 0, 1, 0.3)

				var_408_9:setOnUpdate(LuaHelper.FloatAction(function(arg_409_0)
					arg_405_1.dialogCg_.alpha = arg_409_0
				end))
				var_408_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_405_1.dialog_)
					var_408_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_405_1.duration_ = arg_405_1.duration_ + 0.3

				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_10 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(321371096).content)

				arg_405_1.text_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_12 = 46 <= 0 and var_408_8 or var_408_8 * (utf8.len(var_408_10) / 46)

				if (46 <= 0 and var_408_8 or var_408_8 * (utf8.len(var_408_10) / 46)) > 0 and var_408_8 < var_408_12 then
					arg_405_1.talkMaxDuration = var_408_12
					var_408_7 = var_408_7 + 0.3

					if var_408_12 + var_408_7 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_12 + var_408_7
					end
				end

				arg_405_1.text_.text = var_408_10
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_13 = var_408_7 + 0.3
			local var_408_14 = math.max(var_408_8, arg_405_1.talkMaxDuration)

			if var_408_7 + 0.3 <= arg_405_1.time_ and arg_405_1.time_ < var_408_13 + var_408_14 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_13) / var_408_14

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_13 + var_408_14 and arg_405_1.time_ < var_408_13 + var_408_14 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play321371097 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 321371097
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play321371098(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.9

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(321371097).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 36 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 36)

				if (36 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 36)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play321371098 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 321371098
		arg_415_1.duration_ = 2.13

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play321371099(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_0 = 1

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 then
				local var_418_1 = Color.New(0, 0, 0)

				var_418_1.a = Mathf.Lerp(0, 1, (arg_415_1.time_ - 0) / var_418_0)
				arg_415_1.mask_.color = var_418_1
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 then
				local var_418_2 = Color.New(0, 0, 0)

				var_418_2.a = 1
				arg_415_1.mask_.color = var_418_2
			end

			local var_418_3 = 1

			if 1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_3 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_4 = 1

			if var_418_3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_3 + var_418_4 then
				local var_418_5 = Color.New(0, 0, 0)

				var_418_5.a = Mathf.Lerp(1, 0, (arg_415_1.time_ - var_418_3) / var_418_4)
				arg_415_1.mask_.color = var_418_5
			end

			if arg_415_1.time_ >= var_418_3 + var_418_4 and arg_415_1.time_ < var_418_3 + var_418_4 + arg_418_0 then
				local var_418_6 = Color.New(0, 0, 0)

				arg_415_1.mask_.enabled = false
				var_418_6.a = 0
				arg_415_1.mask_.color = var_418_6
			end

			local var_418_7 = "STblack"

			if arg_415_1.bgs_.STblack == nil then
				local var_418_8 = Object.Instantiate(arg_415_1.paintGo_)

				var_418_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_418_7)
				var_418_8.name = var_418_7
				var_418_8.transform.parent = arg_415_1.stage_.transform
				var_418_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_415_1.bgs_[var_418_7] = var_418_8
			end

			if 1 < arg_415_1.time_ and arg_415_1.time_ <= 1 + arg_418_0 then
				local var_418_9 = arg_415_1.bgs_.STblack

				arg_415_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_418_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_10 = var_418_9:GetComponent("SpriteRenderer")

				if var_418_10 and var_418_10.sprite then
					local var_418_11 = 2 * (var_418_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_418_9.transform.localScale = Vector3.New(var_418_11 / var_418_10.sprite.bounds.size.y < var_418_11 * manager.ui.mainCameraCom_.aspect / var_418_10.sprite.bounds.size.x and var_418_11 * manager.ui.mainCameraCom_.aspect / var_418_10.sprite.bounds.size.x or var_418_11 / var_418_10.sprite.bounds.size.y, var_418_11 / var_418_10.sprite.bounds.size.y < var_418_11 * manager.ui.mainCameraCom_.aspect / var_418_10.sprite.bounds.size.x and var_418_11 * manager.ui.mainCameraCom_.aspect / var_418_10.sprite.bounds.size.x or var_418_11 / var_418_10.sprite.bounds.size.y, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "STblack" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_415_1.time_ and arg_415_1.time_ <= 1 + arg_418_0 then
				arg_415_1.fswbg_:SetActive(true)
				arg_415_1.dialog_:SetActive(false)

				arg_415_1.fswtw_.percent = 0
				arg_415_1.fswt_.text = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(321371098).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.fswt_)

				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_415_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_415_1.fswtw_:SetDirty()

				arg_415_1.typewritterCharCountI18N = 0

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_12 = 1.06666666666667

			if 1.06666666666667 < arg_415_1.time_ and arg_415_1.time_ <= var_418_12 + arg_418_0 then
				arg_415_1.var_.oldValueTypewriter = arg_415_1.fswtw_.percent

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_13 = 16
			local var_418_14 = 1.06666666666667
			local var_418_15, var_418_16 = arg_415_1:GetPercentByPara(arg_415_1:FormatText(arg_415_1:GetWordFromCfg(321371098).content), 1)

			if var_418_12 < arg_415_1.time_ and arg_415_1.time_ <= var_418_12 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				local var_418_17 = var_418_13 <= 0 and var_418_14 or var_418_14 * ((var_418_16 - arg_415_1.typewritterCharCountI18N) / var_418_13)

				if (var_418_13 <= 0 and var_418_14 or var_418_14 * ((var_418_16 - arg_415_1.typewritterCharCountI18N) / var_418_13)) > 0 and var_418_14 < var_418_17 then
					arg_415_1.talkMaxDuration = var_418_17

					if var_418_17 + var_418_12 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_17 + var_418_12
					end
				end
			end

			local var_418_18 = math.max(1.06666666666667, arg_415_1.talkMaxDuration)

			if var_418_12 <= arg_415_1.time_ and arg_415_1.time_ < var_418_12 + var_418_18 then
				arg_415_1.fswtw_.percent = Mathf.Lerp(arg_415_1.var_.oldValueTypewriter, var_418_15, (arg_415_1.time_ - var_418_12) / var_418_18)
				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_415_1.fswtw_:SetDirty()
			end

			if arg_415_1.time_ >= var_418_12 + var_418_18 and arg_415_1.time_ < var_418_12 + var_418_18 + arg_418_0 then
				arg_415_1.fswtw_.percent = var_418_15

				arg_415_1.fswtw_:SetDirty()
				arg_415_1:ShowNextGo(true)

				arg_415_1.typewritterCharCountI18N = var_418_16
			end

			if 1 < arg_415_1.time_ and arg_415_1.time_ <= 1 + arg_418_0 then
				local var_418_19 = arg_415_1.fswbg_.transform:Find("textbox/adapt/content") or arg_415_1.fswbg_.transform:Find("textbox/content")
				local var_418_20 = arg_415_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_418_21 = var_418_19:GetComponent("RectTransform")

				var_418_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_418_21.offsetMin = Vector2.New(0, 0)
				var_418_21.offsetMax = Vector2.New(0, 0)
			end

			local var_418_22 = 1
			local var_418_23 = manager.audio:GetVoiceLength("story_v_out_321371", "321371098", "story_v_out_321371.awb") / 1000

			if var_418_23 > 0 and 1 < var_418_23 and var_418_23 + var_418_22 > arg_415_1.duration_ then
				arg_415_1.duration_ = var_418_23 + var_418_22
			end

			if var_418_22 < arg_415_1.time_ and arg_415_1.time_ <= var_418_22 + arg_418_0 then
				arg_415_1:AudioAction("play", "voice", "story_v_out_321371", "321371098", "story_v_out_321371.awb")
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play321371099 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 321371099
		arg_419_1.duration_ = 5.3

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play321371100(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.fswbg_:SetActive(true)
				arg_419_1.dialog_:SetActive(false)

				arg_419_1.fswtw_.percent = 0
				arg_419_1.fswt_.text = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(321371099).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.fswt_)

				arg_419_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_419_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_419_1.fswtw_:SetDirty()

				arg_419_1.typewritterCharCountI18N = 0

				SetActive(arg_419_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_419_1:ShowNextGo(false)
			end

			local var_422_0 = 0.0666666666666667

			if 0.0666666666666667 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.var_.oldValueTypewriter = arg_419_1.fswtw_.percent

				SetActive(arg_419_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_419_1:ShowNextGo(false)
			end

			local var_422_1 = 34
			local var_422_2 = 2.26666666666667
			local var_422_3, var_422_4 = arg_419_1:GetPercentByPara(arg_419_1:FormatText(arg_419_1:GetWordFromCfg(321371099).content), 1)

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0

				local var_422_5 = var_422_1 <= 0 and var_422_2 or var_422_2 * ((var_422_4 - arg_419_1.typewritterCharCountI18N) / var_422_1)

				if (var_422_1 <= 0 and var_422_2 or var_422_2 * ((var_422_4 - arg_419_1.typewritterCharCountI18N) / var_422_1)) > 0 and var_422_2 < var_422_5 then
					arg_419_1.talkMaxDuration = var_422_5

					if var_422_5 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + var_422_0
					end
				end
			end

			local var_422_6 = math.max(2.26666666666667, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_6 then
				arg_419_1.fswtw_.percent = Mathf.Lerp(arg_419_1.var_.oldValueTypewriter, var_422_3, (arg_419_1.time_ - var_422_0) / var_422_6)
				arg_419_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_419_1.fswtw_:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_6 and arg_419_1.time_ < var_422_0 + var_422_6 + arg_422_0 then
				arg_419_1.fswtw_.percent = var_422_3

				arg_419_1.fswtw_:SetDirty()
				arg_419_1:ShowNextGo(true)

				arg_419_1.typewritterCharCountI18N = var_422_4
			end

			local var_422_7 = 0
			local var_422_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371099", "story_v_out_321371.awb") / 1000

			if var_422_8 > 0 and 5.3 < var_422_8 and var_422_8 + var_422_7 > arg_419_1.duration_ then
				arg_419_1.duration_ = var_422_8 + var_422_7
			end

			if var_422_7 < arg_419_1.time_ and arg_419_1.time_ <= var_422_7 + arg_422_0 then
				arg_419_1:AudioAction("play", "voice", "story_v_out_321371", "321371099", "story_v_out_321371.awb")
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play321371100 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 321371100
		arg_423_1.duration_ = 7

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play321371101(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1111ui_story = arg_423_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1111ui_story"].transform.position).z)
				arg_423_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1111ui_story"].transform.localEulerAngles = arg_423_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_423_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1111ui_story"].transform.position).z)
				arg_423_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1111ui_story"].transform.localEulerAngles = arg_423_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_426_1 = arg_423_1.actors_["1111ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1111ui_story == nil then
				arg_423_1.var_.characterEffect1111ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1111ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_2)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1111ui_story then
				arg_423_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_426_3 = 0

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_3 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_4 = 1

			if var_426_3 <= arg_423_1.time_ and arg_423_1.time_ < var_426_3 + var_426_4 then
				local var_426_5 = Color.New(0, 0, 0)

				var_426_5.a = Mathf.Lerp(0, 1, (arg_423_1.time_ - var_426_3) / var_426_4)
				arg_423_1.mask_.color = var_426_5
			end

			if arg_423_1.time_ >= var_426_3 + var_426_4 and arg_423_1.time_ < var_426_3 + var_426_4 + arg_426_0 then
				local var_426_6 = Color.New(0, 0, 0)

				var_426_6.a = 1
				arg_423_1.mask_.color = var_426_6
			end

			local var_426_7 = 1

			if 1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_7 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_8 = 1

			if var_426_7 <= arg_423_1.time_ and arg_423_1.time_ < var_426_7 + var_426_8 then
				local var_426_9 = Color.New(0, 0, 0)

				var_426_9.a = Mathf.Lerp(1, 0, (arg_423_1.time_ - var_426_7) / var_426_8)
				arg_423_1.mask_.color = var_426_9
			end

			if arg_423_1.time_ >= var_426_7 + var_426_8 and arg_423_1.time_ < var_426_7 + var_426_8 + arg_426_0 then
				local var_426_10 = Color.New(0, 0, 0)

				arg_423_1.mask_.enabled = false
				var_426_10.a = 0
				arg_423_1.mask_.color = var_426_10
			end

			if 1 < arg_423_1.time_ and arg_423_1.time_ <= 1 + arg_426_0 then
				local var_426_11 = arg_423_1.bgs_.L09g

				arg_423_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_426_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_426_12 = var_426_11:GetComponent("SpriteRenderer")

				if var_426_12 and var_426_12.sprite then
					local var_426_13 = 2 * (var_426_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_426_11.transform.localScale = Vector3.New(var_426_13 / var_426_12.sprite.bounds.size.y < var_426_13 * manager.ui.mainCameraCom_.aspect / var_426_12.sprite.bounds.size.x and var_426_13 * manager.ui.mainCameraCom_.aspect / var_426_12.sprite.bounds.size.x or var_426_13 / var_426_12.sprite.bounds.size.y, var_426_13 / var_426_12.sprite.bounds.size.y < var_426_13 * manager.ui.mainCameraCom_.aspect / var_426_12.sprite.bounds.size.x and var_426_13 * manager.ui.mainCameraCom_.aspect / var_426_12.sprite.bounds.size.x or var_426_13 / var_426_12.sprite.bounds.size.y, 0)
				end

				for iter_426_0, iter_426_1 in pairs(arg_423_1.bgs_) do
					if iter_426_0 ~= "L09g" then
						iter_426_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_426_14

			if 1 < arg_423_1.time_ and arg_423_1.time_ <= 1 + arg_426_0 then
				local var_426_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_426_15 then
					var_426_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_426_15.radialBlurScale = 0
					var_426_15.radialBlurGradient = 1
					var_426_15.radialBlurIntensity = 1

					if var_426_14 then
						var_426_15.radialBlurTarget = var_426_14.transform
					end
				end
			end

			local var_426_16 = 2

			if 1 <= arg_423_1.time_ and arg_423_1.time_ < 1 + var_426_16 then
				local var_426_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_426_17 then
					var_426_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_426_17.radialBlurScale = Mathf.Lerp(0, 0.75, (arg_423_1.time_ - 1) / var_426_16)
					var_426_17.radialBlurGradient = Mathf.Lerp(1, 1, (arg_423_1.time_ - 1) / var_426_16)
					var_426_17.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_423_1.time_ - 1) / var_426_16)
				end
			end

			if arg_423_1.time_ >= 1 + var_426_16 and arg_423_1.time_ < 1 + var_426_16 + arg_426_0 then
				local var_426_18 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_426_18 then
					var_426_18.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_426_18.radialBlurScale = 0.75
					var_426_18.radialBlurGradient = 1
					var_426_18.radialBlurIntensity = 1
				end
			end

			if 0.933333333333333 < arg_423_1.time_ and arg_423_1.time_ <= 0.933333333333333 + arg_426_0 then
				arg_423_1.fswbg_:SetActive(false)
				arg_423_1.dialog_:SetActive(false)
				SetActive(arg_423_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_423_1:ShowNextGo(false)
			end

			if 1.16666666666667 < arg_423_1.time_ and arg_423_1.time_ <= 1.16666666666667 + arg_426_0 then
				arg_423_1:AudioAction("play", "effect", "se_story_141", "se_story_141_snake08", "")
			end

			local var_426_20 = 1.999999999999
			local var_426_21 = 0.675

			if 1.999999999999 < arg_423_1.time_ and arg_423_1.time_ <= var_426_20 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_22 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(321371100).content)

				arg_423_1.text_.text = var_426_22

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_24 = 27 <= 0 and var_426_21 or var_426_21 * (utf8.len(var_426_22) / 27)

				if (27 <= 0 and var_426_21 or var_426_21 * (utf8.len(var_426_22) / 27)) > 0 and var_426_21 < var_426_24 then
					arg_423_1.talkMaxDuration = var_426_24

					if var_426_24 + var_426_20 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_24 + var_426_20
					end
				end

				arg_423_1.text_.text = var_426_22
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_25 = math.max(var_426_21, arg_423_1.talkMaxDuration)

			if var_426_20 <= arg_423_1.time_ and arg_423_1.time_ < var_426_20 + var_426_25 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_20) / var_426_25

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_20 + var_426_25 and arg_423_1.time_ < var_426_20 + var_426_25 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
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

		arg_423_1:InitPlayNodeList()
	end,
	Play321371101 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 321371101
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play321371102(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 1.4

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_1 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(321371101).content)

				arg_427_1.text_.text = var_430_1

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_3 = 56 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 56)

				if (56 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 56)) > 0 and var_430_0 < var_430_3 then
					arg_427_1.talkMaxDuration = var_430_3

					if var_430_3 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_3 + 0
					end
				end

				arg_427_1.text_.text = var_430_1
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_4 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_4

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play321371102 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 321371102
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play321371103(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.075

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(321371102).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 43 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 43)

				if (43 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 43)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play321371103 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 321371103
		arg_435_1.duration_ = 8.47

		local var_435_0 = {
			zh = 8.466,
			ja = 6.8
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
				arg_435_0:Play321371104(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.55

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_1 = arg_435_1:GetWordFromCfg(321371103)
				local var_438_2 = arg_435_1:FormatText(var_438_1.content)

				arg_435_1.text_.text = var_438_2

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_4 = 22 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 22)

				if (22 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 22)) > 0 and var_438_0 < var_438_4 then
					arg_435_1.talkMaxDuration = var_438_4

					if var_438_4 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_4 + 0
					end
				end

				arg_435_1.text_.text = var_438_2
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371103", "story_v_out_321371.awb") ~= 0 then
					local var_438_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371103", "story_v_out_321371.awb") / 1000

					if var_438_5 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + 0
					end

					if var_438_1.prefab_name ~= "" and arg_435_1.actors_[var_438_1.prefab_name] ~= nil then
						local var_438_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_1.prefab_name].transform, "story_v_out_321371", "321371103", "story_v_out_321371.awb")

						arg_435_1:RecordAudio("321371103", var_438_6)
						arg_435_1:RecordAudio("321371103", var_438_6)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_321371", "321371103", "story_v_out_321371.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_321371", "321371103", "story_v_out_321371.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_7 and arg_435_1.time_ < 0 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play321371104 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 321371104
		arg_439_1.duration_ = 5.47

		local var_439_0 = {
			zh = 4.533,
			ja = 5.466
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play321371105(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.425

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_1 = arg_439_1:GetWordFromCfg(321371104)
				local var_442_2 = arg_439_1:FormatText(var_442_1.content)

				arg_439_1.text_.text = var_442_2

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 17 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 17)

				if (17 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 17)) > 0 and var_442_0 < var_442_4 then
					arg_439_1.talkMaxDuration = var_442_4

					if var_442_4 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_4 + 0
					end
				end

				arg_439_1.text_.text = var_442_2
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371104", "story_v_out_321371.awb") ~= 0 then
					local var_442_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371104", "story_v_out_321371.awb") / 1000

					if var_442_5 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + 0
					end

					if var_442_1.prefab_name ~= "" and arg_439_1.actors_[var_442_1.prefab_name] ~= nil then
						local var_442_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_1.prefab_name].transform, "story_v_out_321371", "321371104", "story_v_out_321371.awb")

						arg_439_1:RecordAudio("321371104", var_442_6)
						arg_439_1:RecordAudio("321371104", var_442_6)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_321371", "321371104", "story_v_out_321371.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_321371", "321371104", "story_v_out_321371.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_7 and arg_439_1.time_ < 0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play321371105 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 321371105
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play321371106(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos10131ui_story = arg_443_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["10131ui_story"].transform.position).z)
				arg_443_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["10131ui_story"].transform.localEulerAngles = arg_443_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_443_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["10131ui_story"].transform.position).z)
				arg_443_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["10131ui_story"].transform.localEulerAngles = arg_443_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_446_1 = arg_443_1.actors_["1111ui_story"].transform

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1111ui_story = var_446_1.localPosition
			end

			local var_446_2 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_2 then
				var_446_1.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_443_1.time_ - 0) / var_446_2)
				var_446_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_446_1.position).x, (manager.ui.mainCamera.transform.position - var_446_1.position).y, (manager.ui.mainCamera.transform.position - var_446_1.position).z)
				var_446_1.localEulerAngles.z = 0
				var_446_1.localEulerAngles.x = 0
				var_446_1.localEulerAngles = var_446_1.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_2 and arg_443_1.time_ < 0 + var_446_2 + arg_446_0 then
				var_446_1.localPosition = Vector3.New(0, 100, 0)
				var_446_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_446_1.position).x, (manager.ui.mainCamera.transform.position - var_446_1.position).y, (manager.ui.mainCamera.transform.position - var_446_1.position).z)
				var_446_1.localEulerAngles.z = 0
				var_446_1.localEulerAngles.x = 0
				var_446_1.localEulerAngles = var_446_1.localEulerAngles
			end

			local var_446_3 = arg_443_1.actors_["10131ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_3) and arg_443_1.var_.characterEffect10131ui_story == nil then
				arg_443_1.var_.characterEffect10131ui_story = var_446_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_4 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 and not isNil(var_446_3) then
				if arg_443_1.var_.characterEffect10131ui_story and not isNil(var_446_3) then
					arg_443_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_443_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_443_1.time_ - 0) / var_446_4)
				end
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 and not isNil(var_446_3) and arg_443_1.var_.characterEffect10131ui_story then
				arg_443_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_443_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_446_5 = 0
			local var_446_6 = 0.525

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_5 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_7 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(321371105).content)

				arg_443_1.text_.text = var_446_7

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_9 = 21 <= 0 and var_446_6 or var_446_6 * (utf8.len(var_446_7) / 21)

				if (21 <= 0 and var_446_6 or var_446_6 * (utf8.len(var_446_7) / 21)) > 0 and var_446_6 < var_446_9 then
					arg_443_1.talkMaxDuration = var_446_9

					if var_446_9 + var_446_5 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_9 + var_446_5
					end
				end

				arg_443_1.text_.text = var_446_7
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_10 = math.max(var_446_6, arg_443_1.talkMaxDuration)

			if var_446_5 <= arg_443_1.time_ and arg_443_1.time_ < var_446_5 + var_446_10 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_5) / var_446_10

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_5 + var_446_10 and arg_443_1.time_ < var_446_5 + var_446_10 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
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

		arg_443_1:InitPlayNodeList()
	end,
	Play321371106 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 321371106
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play321371107(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 1.25

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_1 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(321371106).content)

				arg_447_1.text_.text = var_450_1

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_3 = 50 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 50)

				if (50 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 50)) > 0 and var_450_0 < var_450_3 then
					arg_447_1.talkMaxDuration = var_450_3

					if var_450_3 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_3 + 0
					end
				end

				arg_447_1.text_.text = var_450_1
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_4 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_4

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play321371107 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 321371107
		arg_451_1.duration_ = 4.77

		local var_451_0 = {
			zh = 4.766,
			ja = 3.6
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
				arg_451_0:Play321371108(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1111ui_story = arg_451_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_454_0 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 then
				arg_451_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_451_1.time_ - 0) / var_454_0)
				arg_451_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1111ui_story"].transform.position).z)
				arg_451_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1111ui_story"].transform.localEulerAngles = arg_451_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 then
				arg_451_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_451_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1111ui_story"].transform.position).z)
				arg_451_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1111ui_story"].transform.localEulerAngles = arg_451_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_454_1 = arg_451_1.actors_["1111ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1111ui_story == nil then
				arg_451_1.var_.characterEffect1111ui_story = var_454_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_2 and not isNil(var_454_1) then
				if arg_451_1.var_.characterEffect1111ui_story and not isNil(var_454_1) then
					arg_451_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_2 and arg_451_1.time_ < 0 + var_454_2 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1111ui_story then
				arg_451_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_454_4 = 0
			local var_454_5 = 0.35

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_6 = arg_451_1:GetWordFromCfg(321371107)
				local var_454_7 = arg_451_1:FormatText(var_454_6.content)

				arg_451_1.text_.text = var_454_7

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_9 = 14 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 14)

				if (14 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 14)) > 0 and var_454_5 < var_454_9 then
					arg_451_1.talkMaxDuration = var_454_9

					if var_454_9 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_9 + var_454_4
					end
				end

				arg_451_1.text_.text = var_454_7
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371107", "story_v_out_321371.awb") ~= 0 then
					local var_454_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371107", "story_v_out_321371.awb") / 1000

					if var_454_10 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_10 + var_454_4
					end

					if var_454_6.prefab_name ~= "" and arg_451_1.actors_[var_454_6.prefab_name] ~= nil then
						local var_454_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_6.prefab_name].transform, "story_v_out_321371", "321371107", "story_v_out_321371.awb")

						arg_451_1:RecordAudio("321371107", var_454_11)
						arg_451_1:RecordAudio("321371107", var_454_11)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_321371", "321371107", "story_v_out_321371.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_321371", "321371107", "story_v_out_321371.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_12 = math.max(var_454_5, arg_451_1.talkMaxDuration)

			if var_454_4 <= arg_451_1.time_ and arg_451_1.time_ < var_454_4 + var_454_12 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_4) / var_454_12

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_4 + var_454_12 and arg_451_1.time_ < var_454_4 + var_454_12 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
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

		arg_451_1:InitPlayNodeList()
	end,
	Play321371108 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 321371108
		arg_455_1.duration_ = 4.77

		local var_455_0 = {
			zh = 4.4,
			ja = 4.766
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play321371109(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(arg_455_1.actors_["1111ui_story"]) and arg_455_1.var_.characterEffect1111ui_story == nil then
				arg_455_1.var_.characterEffect1111ui_story = arg_455_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_0 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 and not isNil(arg_455_1.actors_["1111ui_story"]) then
				if arg_455_1.var_.characterEffect1111ui_story and not isNil(arg_455_1.actors_["1111ui_story"]) then
					arg_455_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_455_1.time_ - 0) / var_458_0)
				end
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 and not isNil(arg_455_1.actors_["1111ui_story"]) and arg_455_1.var_.characterEffect1111ui_story then
				arg_455_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_458_1 = 0
			local var_458_2 = 0.45

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_3 = arg_455_1:GetWordFromCfg(321371108)
				local var_458_4 = arg_455_1:FormatText(var_458_3.content)

				arg_455_1.text_.text = var_458_4

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_6 = 18 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_4) / 18)

				if (18 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_4) / 18)) > 0 and var_458_2 < var_458_6 then
					arg_455_1.talkMaxDuration = var_458_6

					if var_458_6 + var_458_1 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_6 + var_458_1
					end
				end

				arg_455_1.text_.text = var_458_4
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371108", "story_v_out_321371.awb") ~= 0 then
					local var_458_7 = manager.audio:GetVoiceLength("story_v_out_321371", "321371108", "story_v_out_321371.awb") / 1000

					if var_458_7 + var_458_1 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_1
					end

					if var_458_3.prefab_name ~= "" and arg_455_1.actors_[var_458_3.prefab_name] ~= nil then
						local var_458_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_3.prefab_name].transform, "story_v_out_321371", "321371108", "story_v_out_321371.awb")

						arg_455_1:RecordAudio("321371108", var_458_8)
						arg_455_1:RecordAudio("321371108", var_458_8)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_321371", "321371108", "story_v_out_321371.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_321371", "321371108", "story_v_out_321371.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_9 = math.max(var_458_2, arg_455_1.talkMaxDuration)

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_9 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_1) / var_458_9

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_1 + var_458_9 and arg_455_1.time_ < var_458_1 + var_458_9 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play321371109 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 321371109
		arg_459_1.duration_ = 5.2

		local var_459_0 = {
			zh = 3.3,
			ja = 5.2
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play321371110(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["1111ui_story"]) and arg_459_1.var_.characterEffect1111ui_story == nil then
				arg_459_1.var_.characterEffect1111ui_story = arg_459_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_0 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["1111ui_story"]) then
				if arg_459_1.var_.characterEffect1111ui_story and not isNil(arg_459_1.actors_["1111ui_story"]) then
					arg_459_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["1111ui_story"]) and arg_459_1.var_.characterEffect1111ui_story then
				arg_459_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_462_2 = arg_459_1.actors_["10131ui_story"]

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(var_462_2) and arg_459_1.var_.characterEffect10131ui_story == nil then
				arg_459_1.var_.characterEffect10131ui_story = var_462_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_3 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_3 and not isNil(var_462_2) then
				if arg_459_1.var_.characterEffect10131ui_story and not isNil(var_462_2) then
					arg_459_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_459_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_459_1.time_ - 0) / var_462_3)
				end
			end

			if arg_459_1.time_ >= 0 + var_462_3 and arg_459_1.time_ < 0 + var_462_3 + arg_462_0 and not isNil(var_462_2) and arg_459_1.var_.characterEffect10131ui_story then
				arg_459_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_459_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_462_4 = 0
			local var_462_5 = 0.35

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_6 = arg_459_1:GetWordFromCfg(321371109)
				local var_462_7 = arg_459_1:FormatText(var_462_6.content)

				arg_459_1.text_.text = var_462_7

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_9 = 14 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 14)

				if (14 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 14)) > 0 and var_462_5 < var_462_9 then
					arg_459_1.talkMaxDuration = var_462_9

					if var_462_9 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_9 + var_462_4
					end
				end

				arg_459_1.text_.text = var_462_7
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371109", "story_v_out_321371.awb") ~= 0 then
					local var_462_10 = manager.audio:GetVoiceLength("story_v_out_321371", "321371109", "story_v_out_321371.awb") / 1000

					if var_462_10 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_10 + var_462_4
					end

					if var_462_6.prefab_name ~= "" and arg_459_1.actors_[var_462_6.prefab_name] ~= nil then
						local var_462_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_6.prefab_name].transform, "story_v_out_321371", "321371109", "story_v_out_321371.awb")

						arg_459_1:RecordAudio("321371109", var_462_11)
						arg_459_1:RecordAudio("321371109", var_462_11)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_321371", "321371109", "story_v_out_321371.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_321371", "321371109", "story_v_out_321371.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_12 = math.max(var_462_5, arg_459_1.talkMaxDuration)

			if var_462_4 <= arg_459_1.time_ and arg_459_1.time_ < var_462_4 + var_462_12 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_4) / var_462_12

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_4 + var_462_12 and arg_459_1.time_ < var_462_4 + var_462_12 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play321371110 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 321371110
		arg_463_1.duration_ = 1.53

		local var_463_0 = {
			zh = 1.033,
			ja = 1.533
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play321371111(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(arg_463_1.actors_["1111ui_story"]) and arg_463_1.var_.characterEffect1111ui_story == nil then
				arg_463_1.var_.characterEffect1111ui_story = arg_463_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_0 = 0.200000002980232

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 and not isNil(arg_463_1.actors_["1111ui_story"]) then
				if arg_463_1.var_.characterEffect1111ui_story and not isNil(arg_463_1.actors_["1111ui_story"]) then
					arg_463_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_463_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_463_1.time_ - 0) / var_466_0)
				end
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["1111ui_story"]) and arg_463_1.var_.characterEffect1111ui_story then
				arg_463_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_463_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_466_1 = 0
			local var_466_2 = 0.075

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_3 = arg_463_1:GetWordFromCfg(321371110)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_6 = 3 <= 0 and var_466_2 or var_466_2 * (utf8.len(var_466_4) / 3)

				if (3 <= 0 and var_466_2 or var_466_2 * (utf8.len(var_466_4) / 3)) > 0 and var_466_2 < var_466_6 then
					arg_463_1.talkMaxDuration = var_466_6

					if var_466_6 + var_466_1 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_6 + var_466_1
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371110", "story_v_out_321371.awb") ~= 0 then
					local var_466_7 = manager.audio:GetVoiceLength("story_v_out_321371", "321371110", "story_v_out_321371.awb") / 1000

					if var_466_7 + var_466_1 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_1
					end

					if var_466_3.prefab_name ~= "" and arg_463_1.actors_[var_466_3.prefab_name] ~= nil then
						local var_466_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_3.prefab_name].transform, "story_v_out_321371", "321371110", "story_v_out_321371.awb")

						arg_463_1:RecordAudio("321371110", var_466_8)
						arg_463_1:RecordAudio("321371110", var_466_8)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_321371", "321371110", "story_v_out_321371.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_321371", "321371110", "story_v_out_321371.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_9 = math.max(var_466_2, arg_463_1.talkMaxDuration)

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_9 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_1) / var_466_9

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_1 + var_466_9 and arg_463_1.time_ < var_466_1 + var_466_9 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play321371111 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 321371111
		arg_467_1.duration_ = 11.13

		local var_467_0 = {
			zh = 8.333,
			ja = 11.133
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play321371112(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPos1111ui_story = arg_467_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_470_0 = 0.001

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 then
				arg_467_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_467_1.time_ - 0) / var_470_0)
				arg_467_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_467_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1111ui_story"].transform.position).z)
				arg_467_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_467_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_467_1.actors_["1111ui_story"].transform.localEulerAngles = arg_467_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 then
				arg_467_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_467_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_467_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1111ui_story"].transform.position).z)
				arg_467_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_467_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_467_1.actors_["1111ui_story"].transform.localEulerAngles = arg_467_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_470_1 = arg_467_1.actors_["1111ui_story"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_1) and arg_467_1.var_.characterEffect1111ui_story == nil then
				arg_467_1.var_.characterEffect1111ui_story = var_470_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_2 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_2 and not isNil(var_470_1) then
				if arg_467_1.var_.characterEffect1111ui_story and not isNil(var_470_1) then
					arg_467_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= 0 + var_470_2 and arg_467_1.time_ < 0 + var_470_2 + arg_470_0 and not isNil(var_470_1) and arg_467_1.var_.characterEffect1111ui_story then
				arg_467_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_470_4 = arg_467_1.actors_["10131ui_story"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_4) and arg_467_1.var_.characterEffect10131ui_story == nil then
				arg_467_1.var_.characterEffect10131ui_story = var_470_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_5 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_5 and not isNil(var_470_4) then
				if arg_467_1.var_.characterEffect10131ui_story and not isNil(var_470_4) then
					arg_467_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_467_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_467_1.time_ - 0) / var_470_5)
				end
			end

			if arg_467_1.time_ >= 0 + var_470_5 and arg_467_1.time_ < 0 + var_470_5 + arg_470_0 and not isNil(var_470_4) and arg_467_1.var_.characterEffect10131ui_story then
				arg_467_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_467_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action446")
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_470_6 = 0
			local var_470_7 = 0.775

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_6 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_8 = arg_467_1:GetWordFromCfg(321371111)
				local var_470_9 = arg_467_1:FormatText(var_470_8.content)

				arg_467_1.text_.text = var_470_9

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_11 = 31 <= 0 and var_470_7 or var_470_7 * (utf8.len(var_470_9) / 31)

				if (31 <= 0 and var_470_7 or var_470_7 * (utf8.len(var_470_9) / 31)) > 0 and var_470_7 < var_470_11 then
					arg_467_1.talkMaxDuration = var_470_11

					if var_470_11 + var_470_6 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_11 + var_470_6
					end
				end

				arg_467_1.text_.text = var_470_9
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371111", "story_v_out_321371.awb") ~= 0 then
					local var_470_12 = manager.audio:GetVoiceLength("story_v_out_321371", "321371111", "story_v_out_321371.awb") / 1000

					if var_470_12 + var_470_6 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_12 + var_470_6
					end

					if var_470_8.prefab_name ~= "" and arg_467_1.actors_[var_470_8.prefab_name] ~= nil then
						local var_470_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_8.prefab_name].transform, "story_v_out_321371", "321371111", "story_v_out_321371.awb")

						arg_467_1:RecordAudio("321371111", var_470_13)
						arg_467_1:RecordAudio("321371111", var_470_13)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_321371", "321371111", "story_v_out_321371.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_321371", "321371111", "story_v_out_321371.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_14 = math.max(var_470_7, arg_467_1.talkMaxDuration)

			if var_470_6 <= arg_467_1.time_ and arg_467_1.time_ < var_470_6 + var_470_14 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_6) / var_470_14

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_6 + var_470_14 and arg_467_1.time_ < var_470_6 + var_470_14 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
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

		arg_467_1:InitPlayNodeList()
	end,
	Play321371112 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 321371112
		arg_471_1.duration_ = 8

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play321371113(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_9001
			local var_474_9000

			if arg_471_1.bgs_.MS2112 == nil then
				local var_474_0 = Object.Instantiate(arg_471_1.paintGo_)

				var_474_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2112")
				var_474_0.name = "MS2112"
				var_474_0.transform.parent = arg_471_1.stage_.transform
				var_474_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_471_1.bgs_.MS2112 = var_474_0
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				local var_474_1 = arg_471_1.bgs_.MS2112

				arg_471_1.bgs_.MS2112.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_474_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_474_2 = var_474_1:GetComponent("SpriteRenderer")

				if var_474_2 and var_474_2.sprite then
					local var_474_3 = 2 * (var_474_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_474_1.transform.localScale = Vector3.New(var_474_3 / var_474_2.sprite.bounds.size.y < var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x and var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x or var_474_3 / var_474_2.sprite.bounds.size.y, var_474_3 / var_474_2.sprite.bounds.size.y < var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x and var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x or var_474_3 / var_474_2.sprite.bounds.size.y, 0)
				end

				for iter_474_0, iter_474_1 in pairs(arg_471_1.bgs_) do
					if iter_474_0 ~= "MS2112" then
						iter_474_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_474_4 = 1.999999999999

			if 1.999999999999 < arg_471_1.time_ and arg_471_1.time_ <= var_474_4 + arg_474_0 then
				arg_471_1.allBtn_.enabled = false
			end

			if arg_471_1.time_ >= var_474_4 + 0.3 and arg_471_1.time_ < var_474_4 + 0.3 + arg_474_0 then
				arg_471_1.allBtn_.enabled = true
			end

			local var_474_5 = 0

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_5 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_6 = 2

			if var_474_5 <= arg_471_1.time_ and arg_471_1.time_ < var_474_5 + var_474_6 then
				local var_474_7 = Color.New(1, 1, 1)

				var_474_7.a = Mathf.Lerp(1, 0, (arg_471_1.time_ - var_474_5) / var_474_6)
				arg_471_1.mask_.color = var_474_7
			end

			if arg_471_1.time_ >= var_474_5 + var_474_6 and arg_471_1.time_ < var_474_5 + var_474_6 + arg_474_0 then
				local var_474_8 = Color.New(1, 1, 1)

				arg_471_1.mask_.enabled = false
				var_474_8.a = 0
				arg_471_1.mask_.color = var_474_8
			end

			if 0.2 < arg_471_1.time_ and arg_471_1.time_ <= 0.2 + arg_474_0 then
				local var_474_9 = arg_471_1.var_.effectmingwangshenghun1

				if not arg_471_1.var_.effectmingwangshenghun1 then
					var_474_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), manager.ui.mainCamera.transform)
					var_474_9.name = "mingwangshenghun1"
					arg_471_1.var_.effectmingwangshenghun1 = var_474_9
				else
					var_474_9.transform:SetParent(var_474_9001)
				end

				var_474_9.transform.localPosition = Vector3.New(0, 0, 0.52)
				var_474_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5.2 < arg_471_1.time_ and arg_471_1.time_ <= 5.2 + arg_474_0 then
				if arg_471_1.var_.effectmingwangshenghun1 then
					Object.Destroy(arg_471_1.var_.effectmingwangshenghun1)

					arg_471_1.var_.effectmingwangshenghun1 = nil
				end
			end

			local var_474_12 = arg_471_1.bgs_.MS2112.transform

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPosMS2112 = var_474_12.localPosition
			end

			local var_474_13 = 0.1

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_13 then
				var_474_12.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPosMS2112, Vector3.New(0, 0.1, 5), (arg_471_1.time_ - 0) / var_474_13)
			end

			if arg_471_1.time_ >= 0 + var_474_13 and arg_471_1.time_ < 0 + var_474_13 + arg_474_0 then
				var_474_12.localPosition = Vector3.New(0, 0.1, 5)
			end

			local var_474_14 = arg_471_1.bgs_.MS2112.transform

			if 0.1 < arg_471_1.time_ and arg_471_1.time_ <= 0.1 + arg_474_0 then
				arg_471_1.var_.moveOldPosMS2112 = var_474_14.localPosition
			end

			local var_474_15 = 2.9

			if 0.1 <= arg_471_1.time_ and arg_471_1.time_ < 0.1 + var_474_15 then
				var_474_14.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPosMS2112, Vector3.New(0, 0.1, 5.5), (arg_471_1.time_ - 0.1) / var_474_15)
			end

			if arg_471_1.time_ >= 0.1 + var_474_15 and arg_471_1.time_ < 0.1 + var_474_15 + arg_474_0 then
				var_474_14.localPosition = Vector3.New(0, 0.1, 5.5)
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				local var_474_16 = arg_471_1.var_.effectmingwangshenghun2

				if not arg_471_1.var_.effectmingwangshenghun2 then
					var_474_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), manager.ui.mainCamera.transform)
					var_474_16.name = "mingwangshenghun2"
					arg_471_1.var_.effectmingwangshenghun2 = var_474_16
				else
					var_474_16.transform:SetParent(var_474_9000)
				end

				var_474_16.transform.localPosition = Vector3.New(0, 0, -10.76)
				var_474_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_474_18 = arg_471_1.actors_["1111ui_story"].transform

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos1111ui_story = var_474_18.localPosition
			end

			local var_474_19 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_19 then
				var_474_18.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_471_1.time_ - 0) / var_474_19)
				var_474_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_18.position).x, (manager.ui.mainCamera.transform.position - var_474_18.position).y, (manager.ui.mainCamera.transform.position - var_474_18.position).z)
				var_474_18.localEulerAngles.z = 0
				var_474_18.localEulerAngles.x = 0
				var_474_18.localEulerAngles = var_474_18.localEulerAngles
			end

			if arg_471_1.time_ >= 0 + var_474_19 and arg_471_1.time_ < 0 + var_474_19 + arg_474_0 then
				var_474_18.localPosition = Vector3.New(0, 100, 0)
				var_474_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_18.position).x, (manager.ui.mainCamera.transform.position - var_474_18.position).y, (manager.ui.mainCamera.transform.position - var_474_18.position).z)
				var_474_18.localEulerAngles.z = 0
				var_474_18.localEulerAngles.x = 0
				var_474_18.localEulerAngles = var_474_18.localEulerAngles
			end

			if 0.2 < arg_471_1.time_ and arg_471_1.time_ <= 0.2 + arg_474_0 then
				arg_471_1:AudioAction("play", "effect", "se_story_141", "se_story_141_scythe", "")
			end

			if arg_471_1.frameCnt_ <= 1 then
				arg_471_1.dialog_:SetActive(false)
			end

			local var_474_21 = 3
			local var_474_22 = 1.225

			if 3 < arg_471_1.time_ and arg_471_1.time_ <= var_474_21 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0

				arg_471_1.dialog_:SetActive(true)

				arg_471_1.dialogCg_.alpha = 0

				local var_474_23 = LeanTween.value(arg_471_1.dialog_, 0, 1, 0.3)

				var_474_23:setOnUpdate(LuaHelper.FloatAction(function(arg_475_0)
					arg_471_1.dialogCg_.alpha = arg_475_0
				end))
				var_474_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_471_1.dialog_)
					var_474_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_471_1.duration_ = arg_471_1.duration_ + 0.3

				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_24 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(321371112).content)

				arg_471_1.text_.text = var_474_24

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_26 = 49 <= 0 and var_474_22 or var_474_22 * (utf8.len(var_474_24) / 49)

				if (49 <= 0 and var_474_22 or var_474_22 * (utf8.len(var_474_24) / 49)) > 0 and var_474_22 < var_474_26 then
					arg_471_1.talkMaxDuration = var_474_26
					var_474_21 = var_474_21 + 0.3

					if var_474_26 + var_474_21 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_26 + var_474_21
					end
				end

				arg_471_1.text_.text = var_474_24
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_27 = var_474_21 + 0.3
			local var_474_28 = math.max(var_474_22, arg_471_1.talkMaxDuration)

			if var_474_21 + 0.3 <= arg_471_1.time_ and arg_471_1.time_ < var_474_27 + var_474_28 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_27) / var_474_28

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_27 + var_474_28 and arg_471_1.time_ < var_474_27 + var_474_28 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.9,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
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

		arg_471_1:InitPlayNodeList()
	end,
	Play321371113 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 321371113
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play321371114(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0.05 < arg_477_1.time_ and arg_477_1.time_ <= 0.05 + arg_480_0 then
				arg_477_1:AudioAction("play", "effect", "se_story_141", "se_story_141_energy", "")
			end

			local var_480_1 = 0
			local var_480_2 = 0.8

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_3 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(321371113).content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 32 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 32)

				if (32 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 32)) > 0 and var_480_2 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_1 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_1
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_6 = math.max(var_480_2, arg_477_1.talkMaxDuration)

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_6 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_1) / var_480_6

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_1 + var_480_6 and arg_477_1.time_ < var_480_1 + var_480_6 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play321371114 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 321371114
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play321371115(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.975

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(321371114).content)

				arg_481_1.text_.text = var_484_1

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_3 = 39 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 39)

				if (39 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 39)) > 0 and var_484_0 < var_484_3 then
					arg_481_1.talkMaxDuration = var_484_3

					if var_484_3 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_3 + 0
					end
				end

				arg_481_1.text_.text = var_484_1
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_4 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_4

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play321371115 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 321371115
		arg_485_1.duration_ = 10.37

		local var_485_0 = {
			zh = 10.366,
			ja = 6.9
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
				arg_485_0:Play321371116(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["1111ui_story"]) and arg_485_1.var_.characterEffect1111ui_story == nil then
				arg_485_1.var_.characterEffect1111ui_story = arg_485_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["1111ui_story"]) then
				if arg_485_1.var_.characterEffect1111ui_story and not isNil(arg_485_1.actors_["1111ui_story"]) then
					arg_485_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["1111ui_story"]) and arg_485_1.var_.characterEffect1111ui_story then
				arg_485_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_488_2 = 0
			local var_488_3 = 0.85

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_4 = arg_485_1:GetWordFromCfg(321371115)
				local var_488_5 = arg_485_1:FormatText(var_488_4.content)

				arg_485_1.text_.text = var_488_5

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 34 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 34)

				if (34 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 34)) > 0 and var_488_3 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_5
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371115", "story_v_out_321371.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371115", "story_v_out_321371.awb") / 1000

					if var_488_8 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_2
					end

					if var_488_4.prefab_name ~= "" and arg_485_1.actors_[var_488_4.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_4.prefab_name].transform, "story_v_out_321371", "321371115", "story_v_out_321371.awb")

						arg_485_1:RecordAudio("321371115", var_488_9)
						arg_485_1:RecordAudio("321371115", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_321371", "321371115", "story_v_out_321371.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_321371", "321371115", "story_v_out_321371.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_10 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_10 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_10

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_10 and arg_485_1.time_ < var_488_2 + var_488_10 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play321371116 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 321371116
		arg_489_1.duration_ = 7.03

		local var_489_0 = {
			zh = 7.033,
			ja = 6.066
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play321371117(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.675

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_1 = arg_489_1:GetWordFromCfg(321371116)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 27 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 27)

				if (27 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 27)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371116", "story_v_out_321371.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371116", "story_v_out_321371.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_out_321371", "321371116", "story_v_out_321371.awb")

						arg_489_1:RecordAudio("321371116", var_492_6)
						arg_489_1:RecordAudio("321371116", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_321371", "321371116", "story_v_out_321371.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_321371", "321371116", "story_v_out_321371.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play321371117 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 321371117
		arg_493_1.duration_ = 7.5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play321371118(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0.5 < arg_493_1.time_ and arg_493_1.time_ <= 0.5 + arg_496_0 then
				arg_493_1.var_.moveOldPosMS2112 = arg_493_1.bgs_.MS2112.transform.localPosition
			end

			local var_496_0 = 0.001

			if 0.5 <= arg_493_1.time_ and arg_493_1.time_ < 0.5 + var_496_0 then
				arg_493_1.bgs_.MS2112.transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPosMS2112, Vector3.New(0, 1, 9.5), (arg_493_1.time_ - 0.5) / var_496_0)
			end

			if arg_493_1.time_ >= 0.5 + var_496_0 and arg_493_1.time_ < 0.5 + var_496_0 + arg_496_0 then
				arg_493_1.bgs_.MS2112.transform.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_496_1 = arg_493_1.bgs_.MS2112.transform

			if 0.516666666666667 < arg_493_1.time_ and arg_493_1.time_ <= 0.516666666666667 + arg_496_0 then
				arg_493_1.var_.moveOldPosMS2112 = var_496_1.localPosition
			end

			local var_496_2 = 1.98333333333333

			if 0.516666666666667 <= arg_493_1.time_ and arg_493_1.time_ < 0.516666666666667 + var_496_2 then
				var_496_1.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPosMS2112, Vector3.New(0, 1, 10), (arg_493_1.time_ - 0.516666666666667) / var_496_2)
			end

			if arg_493_1.time_ >= 0.516666666666667 + var_496_2 and arg_493_1.time_ < 0.516666666666667 + var_496_2 + arg_496_0 then
				var_496_1.localPosition = Vector3.New(0, 1, 10)
			end

			local var_496_3 = 0

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_3 + arg_496_0 then
				arg_493_1.allBtn_.enabled = false
			end

			if arg_493_1.time_ >= var_496_3 + 2.5 and arg_493_1.time_ < var_496_3 + 2.5 + arg_496_0 then
				arg_493_1.allBtn_.enabled = true
			end

			local var_496_4 = 0

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_5 = 0.5

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_5 then
				local var_496_6 = Color.New(0, 0, 0)

				var_496_6.a = Mathf.Lerp(0, 1, (arg_493_1.time_ - var_496_4) / var_496_5)
				arg_493_1.mask_.color = var_496_6
			end

			if arg_493_1.time_ >= var_496_4 + var_496_5 and arg_493_1.time_ < var_496_4 + var_496_5 + arg_496_0 then
				local var_496_7 = Color.New(0, 0, 0)

				var_496_7.a = 1
				arg_493_1.mask_.color = var_496_7
			end

			local var_496_8 = 0.5

			if 0.5 < arg_493_1.time_ and arg_493_1.time_ <= var_496_8 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_9 = 0.5999999

			if var_496_8 <= arg_493_1.time_ and arg_493_1.time_ < var_496_8 + var_496_9 then
				local var_496_10 = Color.New(0, 0, 0)

				var_496_10.a = Mathf.Lerp(1, 0, (arg_493_1.time_ - var_496_8) / var_496_9)
				arg_493_1.mask_.color = var_496_10
			end

			if arg_493_1.time_ >= var_496_8 + var_496_9 and arg_493_1.time_ < var_496_8 + var_496_9 + arg_496_0 then
				local var_496_11 = Color.New(0, 0, 0)

				arg_493_1.mask_.enabled = false
				var_496_11.a = 0
				arg_493_1.mask_.color = var_496_11
			end

			if 3 < arg_493_1.time_ and arg_493_1.time_ <= 3 + arg_496_0 then
				arg_493_1:AudioAction("play", "effect", "se_story_141", "se_story_141_sword wing01", "")
			end

			local var_496_13 = 2.5
			local var_496_14 = 1

			if 2.5 < arg_493_1.time_ and arg_493_1.time_ <= var_496_13 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_15 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(321371117).content)

				arg_493_1.text_.text = var_496_15

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_17 = 40 <= 0 and var_496_14 or var_496_14 * (utf8.len(var_496_15) / 40)

				if (40 <= 0 and var_496_14 or var_496_14 * (utf8.len(var_496_15) / 40)) > 0 and var_496_14 < var_496_17 then
					arg_493_1.talkMaxDuration = var_496_17

					if var_496_17 + var_496_13 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_17 + var_496_13
					end
				end

				arg_493_1.text_.text = var_496_15
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_18 = math.max(var_496_14, arg_493_1.talkMaxDuration)

			if var_496_13 <= arg_493_1.time_ and arg_493_1.time_ < var_496_13 + var_496_18 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_13) / var_496_18

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_13 + var_496_18 and arg_493_1.time_ < var_496_13 + var_496_18 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.98333333333333,
				className = "StoryMoveNode",
				startTime = 0.516666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play321371118 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 321371118
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play321371119(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0.166666666666667 < arg_497_1.time_ and arg_497_1.time_ <= 0.166666666666667 + arg_500_0 then
				arg_497_1:AudioAction("play", "effect", "se_story_141", "se_story_141_sword wing02", "")
			end

			local var_500_1 = 0
			local var_500_2 = 1.625

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_3 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(321371118).content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 65 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 65)

				if (65 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 65)) > 0 and var_500_2 < var_500_5 then
					arg_497_1.talkMaxDuration = var_500_5

					if var_500_5 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_6 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_6 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_6

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_6 and arg_497_1.time_ < var_500_1 + var_500_6 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play321371119 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 321371119
		arg_501_1.duration_ = 6.8

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play321371120(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_9000

			if 0.1 < arg_501_1.time_ and arg_501_1.time_ <= 0.1 + arg_504_0 then
				arg_501_1.var_.moveOldPosMS2112 = arg_501_1.bgs_.MS2112.transform.localPosition
			end

			local var_504_0 = 0.001

			if 0.1 <= arg_501_1.time_ and arg_501_1.time_ < 0.1 + var_504_0 then
				arg_501_1.bgs_.MS2112.transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPosMS2112, Vector3.New(0, 1, 6), (arg_501_1.time_ - 0.1) / var_504_0)
			end

			if arg_501_1.time_ >= 0.1 + var_504_0 and arg_501_1.time_ < 0.1 + var_504_0 + arg_504_0 then
				arg_501_1.bgs_.MS2112.transform.localPosition = Vector3.New(0, 1, 6)
			end

			local var_504_1 = arg_501_1.bgs_.MS2112.transform

			if 0.134 < arg_501_1.time_ and arg_501_1.time_ <= 0.134 + arg_504_0 then
				arg_501_1.var_.moveOldPosMS2112 = var_504_1.localPosition
			end

			local var_504_2 = 2.39933333333333

			if 0.134 <= arg_501_1.time_ and arg_501_1.time_ < 0.134 + var_504_2 then
				var_504_1.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPosMS2112, Vector3.New(0, 0.55, 6), (arg_501_1.time_ - 0.134) / var_504_2)
			end

			if arg_501_1.time_ >= 0.134 + var_504_2 and arg_501_1.time_ < 0.134 + var_504_2 + arg_504_0 then
				var_504_1.localPosition = Vector3.New(0, 0.55, 6)
			end

			local var_504_3 = 0

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_3 + arg_504_0 then
				arg_501_1.allBtn_.enabled = false
			end

			if arg_501_1.time_ >= var_504_3 + 2.13333333333333 and arg_501_1.time_ < var_504_3 + 2.13333333333333 + arg_504_0 then
				arg_501_1.allBtn_.enabled = true
			end

			local var_504_4 = manager.ui.mainCamera.transform

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.shakeOldPos = var_504_4.localPosition
			end

			local var_504_5 = 1.1

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_5 then
				local var_504_6, var_504_7 = math.modf((arg_501_1.time_ - 0) / 0.066)

				var_504_4.localPosition = Vector3.New(var_504_7 * 0.13, var_504_7 * 0.13, var_504_7 * 0.13) + arg_501_1.var_.shakeOldPos
			end

			if arg_501_1.time_ >= 0 + var_504_5 and arg_501_1.time_ < 0 + var_504_5 + arg_504_0 then
				var_504_4.localPosition = arg_501_1.var_.shakeOldPos
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				local var_504_8 = arg_501_1.var_.effect8851

				if not arg_501_1.var_.effect8851 then
					var_504_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_504_8.name = "8851"
					arg_501_1.var_.effect8851 = var_504_8
				else
					var_504_8.transform:SetParent(var_504_9000)
				end

				var_504_8.transform.localPosition = Vector3.New(0.06, 0, -5.86)
				var_504_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_504_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_504_0, iter_504_1 in ipairs((var_504_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_504_1.transform.localScale = Vector3.New(iter_504_1.transform.localScale.x / var_504_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_504_1.transform.localScale.y / var_504_10, iter_504_1.transform.localScale.z)
				end
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				if arg_501_1.var_.effectmingwangshenghun2 then
					Object.Destroy(arg_501_1.var_.effectmingwangshenghun2)

					arg_501_1.var_.effectmingwangshenghun2 = nil
				end
			end

			local var_504_13 = 0

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_13 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_14 = 0.1

			if var_504_13 <= arg_501_1.time_ and arg_501_1.time_ < var_504_13 + var_504_14 then
				local var_504_15 = Color.New(1, 1, 1)

				var_504_15.a = Mathf.Lerp(0, 1, (arg_501_1.time_ - var_504_13) / var_504_14)
				arg_501_1.mask_.color = var_504_15
			end

			if arg_501_1.time_ >= var_504_13 + var_504_14 and arg_501_1.time_ < var_504_13 + var_504_14 + arg_504_0 then
				local var_504_16 = Color.New(1, 1, 1)

				var_504_16.a = 1
				arg_501_1.mask_.color = var_504_16
			end

			local var_504_17 = 0.1

			if 0.1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_17 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_18 = 0.2

			if var_504_17 <= arg_501_1.time_ and arg_501_1.time_ < var_504_17 + var_504_18 then
				local var_504_19 = Color.New(1, 1, 1)

				var_504_19.a = Mathf.Lerp(1, 0, (arg_501_1.time_ - var_504_17) / var_504_18)
				arg_501_1.mask_.color = var_504_19
			end

			if arg_501_1.time_ >= var_504_17 + var_504_18 and arg_501_1.time_ < var_504_17 + var_504_18 + arg_504_0 then
				local var_504_20 = Color.New(1, 1, 1)

				arg_501_1.mask_.enabled = false
				var_504_20.a = 0
				arg_501_1.mask_.color = var_504_20
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:AudioAction("play", "effect", "se_story_141", "se_story_141_ring", "")
			end

			if arg_501_1.frameCnt_ <= 1 then
				arg_501_1.dialog_:SetActive(false)
			end

			local var_504_22 = 1.8
			local var_504_23 = 1.35

			if 1.8 < arg_501_1.time_ and arg_501_1.time_ <= var_504_22 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0

				arg_501_1.dialog_:SetActive(true)

				arg_501_1.dialogCg_.alpha = 0

				local var_504_24 = LeanTween.value(arg_501_1.dialog_, 0, 1, 0.3)

				var_504_24:setOnUpdate(LuaHelper.FloatAction(function(arg_505_0)
					arg_501_1.dialogCg_.alpha = arg_505_0
				end))
				var_504_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_501_1.dialog_)
					var_504_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_501_1.duration_ = arg_501_1.duration_ + 0.3

				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_25 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(321371119).content)

				arg_501_1.text_.text = var_504_25

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_27 = 54 <= 0 and var_504_23 or var_504_23 * (utf8.len(var_504_25) / 54)

				if (54 <= 0 and var_504_23 or var_504_23 * (utf8.len(var_504_25) / 54)) > 0 and var_504_23 < var_504_27 then
					arg_501_1.talkMaxDuration = var_504_27
					var_504_22 = var_504_22 + 0.3

					if var_504_27 + var_504_22 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_27 + var_504_22
					end
				end

				arg_501_1.text_.text = var_504_25
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_28 = var_504_22 + 0.3
			local var_504_29 = math.max(var_504_23, arg_501_1.talkMaxDuration)

			if var_504_22 + 0.3 <= arg_501_1.time_ and arg_501_1.time_ < var_504_28 + var_504_29 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_28) / var_504_29

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_28 + var_504_29 and arg_501_1.time_ < var_504_28 + var_504_29 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.39933333333333,
				className = "StoryMoveNode",
				startTime = 0.134,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play321371120 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 321371120
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play321371121(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 1.25

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(321371120).content)

				arg_507_1.text_.text = var_510_1

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_3 = 50 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 50)

				if (50 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 50)) > 0 and var_510_0 < var_510_3 then
					arg_507_1.talkMaxDuration = var_510_3

					if var_510_3 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_3 + 0
					end
				end

				arg_507_1.text_.text = var_510_1
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_4 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_4

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play321371121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 321371121
		arg_511_1.duration_ = 5.77

		local var_511_0 = {
			zh = 4.333,
			ja = 5.766
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play321371122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["1111ui_story"]) and arg_511_1.var_.characterEffect1111ui_story == nil then
				arg_511_1.var_.characterEffect1111ui_story = arg_511_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_0 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["1111ui_story"]) then
				if arg_511_1.var_.characterEffect1111ui_story and not isNil(arg_511_1.actors_["1111ui_story"]) then
					arg_511_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["1111ui_story"]) and arg_511_1.var_.characterEffect1111ui_story then
				arg_511_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_514_2 = 0
			local var_514_3 = 0.4

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_2 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_4 = arg_511_1:GetWordFromCfg(321371121)
				local var_514_5 = arg_511_1:FormatText(var_514_4.content)

				arg_511_1.text_.text = var_514_5

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_7 = 16 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_5) / 16)

				if (16 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_5) / 16)) > 0 and var_514_3 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_2
					end
				end

				arg_511_1.text_.text = var_514_5
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371121", "story_v_out_321371.awb") ~= 0 then
					local var_514_8 = manager.audio:GetVoiceLength("story_v_out_321371", "321371121", "story_v_out_321371.awb") / 1000

					if var_514_8 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_8 + var_514_2
					end

					if var_514_4.prefab_name ~= "" and arg_511_1.actors_[var_514_4.prefab_name] ~= nil then
						local var_514_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_4.prefab_name].transform, "story_v_out_321371", "321371121", "story_v_out_321371.awb")

						arg_511_1:RecordAudio("321371121", var_514_9)
						arg_511_1:RecordAudio("321371121", var_514_9)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_321371", "321371121", "story_v_out_321371.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_321371", "321371121", "story_v_out_321371.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_10 = math.max(var_514_3, arg_511_1.talkMaxDuration)

			if var_514_2 <= arg_511_1.time_ and arg_511_1.time_ < var_514_2 + var_514_10 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_2) / var_514_10

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_2 + var_514_10 and arg_511_1.time_ < var_514_2 + var_514_10 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play321371122 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 321371122
		arg_515_1.duration_ = 4.2

		local var_515_0 = {
			zh = 4.2,
			ja = 1.933
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play321371123(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0.35

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_1 = arg_515_1:GetWordFromCfg(321371122)
				local var_518_2 = arg_515_1:FormatText(var_518_1.content)

				arg_515_1.text_.text = var_518_2

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_4 = 14 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 14)

				if (14 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 14)) > 0 and var_518_0 < var_518_4 then
					arg_515_1.talkMaxDuration = var_518_4

					if var_518_4 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_4 + 0
					end
				end

				arg_515_1.text_.text = var_518_2
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371122", "story_v_out_321371.awb") ~= 0 then
					local var_518_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371122", "story_v_out_321371.awb") / 1000

					if var_518_5 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + 0
					end

					if var_518_1.prefab_name ~= "" and arg_515_1.actors_[var_518_1.prefab_name] ~= nil then
						local var_518_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_1.prefab_name].transform, "story_v_out_321371", "321371122", "story_v_out_321371.awb")

						arg_515_1:RecordAudio("321371122", var_518_6)
						arg_515_1:RecordAudio("321371122", var_518_6)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_321371", "321371122", "story_v_out_321371.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_321371", "321371122", "story_v_out_321371.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_7 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_7

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play321371123 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 321371123
		arg_519_1.duration_ = 5.4

		local var_519_0 = {
			zh = 5.4,
			ja = 4
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
			arg_519_1.auto_ = false
		end

		function arg_519_1.playNext_(arg_521_0)
			arg_519_1.onStoryFinished_()
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0.3

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_1 = arg_519_1:GetWordFromCfg(321371123)
				local var_522_2 = arg_519_1:FormatText(var_522_1.content)

				arg_519_1.text_.text = var_522_2

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_4 = 12 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_2) / 12)

				if (12 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_2) / 12)) > 0 and var_522_0 < var_522_4 then
					arg_519_1.talkMaxDuration = var_522_4

					if var_522_4 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_4 + 0
					end
				end

				arg_519_1.text_.text = var_522_2
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321371", "321371123", "story_v_out_321371.awb") ~= 0 then
					local var_522_5 = manager.audio:GetVoiceLength("story_v_out_321371", "321371123", "story_v_out_321371.awb") / 1000

					if var_522_5 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_5 + 0
					end

					if var_522_1.prefab_name ~= "" and arg_519_1.actors_[var_522_1.prefab_name] ~= nil then
						local var_522_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_1.prefab_name].transform, "story_v_out_321371", "321371123", "story_v_out_321371.awb")

						arg_519_1:RecordAudio("321371123", var_522_6)
						arg_519_1:RecordAudio("321371123", var_522_6)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_321371", "321371123", "story_v_out_321371.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_321371", "321371123", "story_v_out_321371.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_7 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_7

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L09g",
		"TextureConfig/Background/ST0506a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/MS2112"
	},
	voices = {
		"story_v_out_321371.awb"
	}
}
