return {
	Play411181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411181001
		arg_1_1.duration_ = 8.77

		local var_1_0 = {
			zh = 8.4,
			ja = 8.766
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
				arg_1_0:Play411181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST75 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST75")
				var_4_0.name = "ST75"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST75 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST75

				arg_1_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST75" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.625

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(411181001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 25 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 25)

				if (25 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 25)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181001", "story_v_out_411181.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_411181", "411181001", "story_v_out_411181.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_411181", "411181001", "story_v_out_411181.awb")

						arg_1_1:RecordAudio("411181001", var_4_22)
						arg_1_1:RecordAudio("411181001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_411181", "411181001", "story_v_out_411181.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_411181", "411181001", "story_v_out_411181.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play411181002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411181002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411181003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.1

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(411181002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 44 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 44)

				if (44 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 44)) > 0 and var_12_0 < var_12_3 then
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
	Play411181003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411181003
		arg_13_1.duration_ = 2.83

		local var_13_0 = {
			zh = 2.233,
			ja = 2.833
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
				arg_13_0:Play411181004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(411181003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 7)

				if (7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 7)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181003", "story_v_out_411181.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_411181", "411181003", "story_v_out_411181.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_411181", "411181003", "story_v_out_411181.awb")

						arg_13_1:RecordAudio("411181003", var_16_6)
						arg_13_1:RecordAudio("411181003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_411181", "411181003", "story_v_out_411181.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_411181", "411181003", "story_v_out_411181.awb")
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
	Play411181004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411181004
		arg_17_1.duration_ = 9.5

		local var_17_0 = {
			zh = 7.066,
			ja = 9.5
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
				arg_17_0:Play411181005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1095ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1095ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1095ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1095ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1095ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1095ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1095ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1095ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_8 = 0
			local var_20_9 = 0.6

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(411181004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 24 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 24)

				if (24 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 24)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181004", "story_v_out_411181.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181004", "story_v_out_411181.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_411181", "411181004", "story_v_out_411181.awb")

						arg_17_1:RecordAudio("411181004", var_20_15)
						arg_17_1:RecordAudio("411181004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_411181", "411181004", "story_v_out_411181.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_411181", "411181004", "story_v_out_411181.awb")
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
				actorName = "1095ui_story",
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
	Play411181005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411181005
		arg_21_1.duration_ = 9.7

		local var_21_0 = {
			zh = 9.7,
			ja = 6.7
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
				arg_21_0:Play411181006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = arg_21_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) then
				if arg_21_1.var_.characterEffect1095ui_story and not isNil(arg_21_1.actors_["1095ui_story"]) then
					arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1095ui_story"]) and arg_21_1.var_.characterEffect1095ui_story then
				arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 1.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(411181005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 52 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 52)

				if (52 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 52)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181005", "story_v_out_411181.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_411181", "411181005", "story_v_out_411181.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_411181", "411181005", "story_v_out_411181.awb")

						arg_21_1:RecordAudio("411181005", var_24_8)
						arg_21_1:RecordAudio("411181005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_411181", "411181005", "story_v_out_411181.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_411181", "411181005", "story_v_out_411181.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_9 and arg_21_1.time_ < var_24_1 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play411181006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411181006
		arg_25_1.duration_ = 1.93

		local var_25_0 = {
			zh = 1.8,
			ja = 1.933
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
				arg_25_0:Play411181007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.25

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(411181006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 10 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 10)

				if (10 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 10)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181006", "story_v_out_411181.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_411181", "411181006", "story_v_out_411181.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_411181", "411181006", "story_v_out_411181.awb")

						arg_25_1:RecordAudio("411181006", var_28_6)
						arg_25_1:RecordAudio("411181006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_411181", "411181006", "story_v_out_411181.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_411181", "411181006", "story_v_out_411181.awb")
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
	Play411181007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411181007
		arg_29_1.duration_ = 8.33

		local var_29_0 = {
			zh = 8.333,
			ja = 7.7
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
				arg_29_0:Play411181008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1095ui_story = arg_29_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).z)
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles = arg_29_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_29_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).z)
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles = arg_29_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1095ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1095ui_story == nil then
				arg_29_1.var_.characterEffect1095ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1095ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1095ui_story then
				arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_32_4 = 0
			local var_32_5 = 0.925

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(411181007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 37 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 37)

				if (37 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 37)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181007", "story_v_out_411181.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_411181", "411181007", "story_v_out_411181.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_411181", "411181007", "story_v_out_411181.awb")

						arg_29_1:RecordAudio("411181007", var_32_11)
						arg_29_1:RecordAudio("411181007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_411181", "411181007", "story_v_out_411181.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_411181", "411181007", "story_v_out_411181.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411181008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411181008
		arg_33_1.duration_ = 3.6

		local var_33_0 = {
			zh = 2.566,
			ja = 3.6
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
				arg_33_0:Play411181009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1095ui_story"]) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = arg_33_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1095ui_story"]) then
				if arg_33_1.var_.characterEffect1095ui_story and not isNil(arg_33_1.actors_["1095ui_story"]) then
					arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1095ui_story"]) and arg_33_1.var_.characterEffect1095ui_story then
				arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.275

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(411181008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 11 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 11)

				if (11 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 11)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181008", "story_v_out_411181.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_411181", "411181008", "story_v_out_411181.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_411181", "411181008", "story_v_out_411181.awb")

						arg_33_1:RecordAudio("411181008", var_36_8)
						arg_33_1:RecordAudio("411181008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_411181", "411181008", "story_v_out_411181.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_411181", "411181008", "story_v_out_411181.awb")
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

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play411181009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411181009
		arg_37_1.duration_ = 6.03

		local var_37_0 = {
			zh = 5.4,
			ja = 6.033
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
				arg_37_0:Play411181010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = arg_37_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) then
				if arg_37_1.var_.characterEffect1095ui_story and not isNil(arg_37_1.actors_["1095ui_story"]) then
					arg_37_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) and arg_37_1.var_.characterEffect1095ui_story then
				arg_37_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_2 = 0
			local var_40_3 = 0.675

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(411181009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 27 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 27)

				if (27 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 27)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181009", "story_v_out_411181.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_411181", "411181009", "story_v_out_411181.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_411181", "411181009", "story_v_out_411181.awb")

						arg_37_1:RecordAudio("411181009", var_40_9)
						arg_37_1:RecordAudio("411181009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_411181", "411181009", "story_v_out_411181.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_411181", "411181009", "story_v_out_411181.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play411181010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411181010
		arg_41_1.duration_ = 7.67

		local var_41_0 = {
			zh = 6.7,
			ja = 7.666
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
				arg_41_0:Play411181011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1095ui_story"]) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = arg_41_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1095ui_story"]) then
				if arg_41_1.var_.characterEffect1095ui_story and not isNil(arg_41_1.actors_["1095ui_story"]) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1095ui_story"]) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.85

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(411181010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 34 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 34)

				if (34 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 34)) > 0 and var_44_2 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181010", "story_v_out_411181.awb") ~= 0 then
					local var_44_7 = manager.audio:GetVoiceLength("story_v_out_411181", "411181010", "story_v_out_411181.awb") / 1000

					if var_44_7 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_1
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_411181", "411181010", "story_v_out_411181.awb")

						arg_41_1:RecordAudio("411181010", var_44_8)
						arg_41_1:RecordAudio("411181010", var_44_8)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_411181", "411181010", "story_v_out_411181.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_411181", "411181010", "story_v_out_411181.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_9 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_9

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_9 and arg_41_1.time_ < var_44_1 + var_44_9 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play411181011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 411181011
		arg_45_1.duration_ = 4.2

		local var_45_0 = {
			zh = 2.166,
			ja = 4.2
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play411181012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(411181011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 11 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 11)

				if (11 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 11)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181011", "story_v_out_411181.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_411181", "411181011", "story_v_out_411181.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_411181", "411181011", "story_v_out_411181.awb")

						arg_45_1:RecordAudio("411181011", var_48_6)
						arg_45_1:RecordAudio("411181011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_411181", "411181011", "story_v_out_411181.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_411181", "411181011", "story_v_out_411181.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play411181012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 411181012
		arg_49_1.duration_ = 8.53

		local var_49_0 = {
			zh = 8.533,
			ja = 4.933
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play411181013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = arg_49_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) then
				if arg_49_1.var_.characterEffect1095ui_story and not isNil(arg_49_1.actors_["1095ui_story"]) then
					arg_49_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) and arg_49_1.var_.characterEffect1095ui_story then
				arg_49_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_52_2 = 0
			local var_52_3 = 0.925

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(411181012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 37 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 37)

				if (37 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 37)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181012", "story_v_out_411181.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_411181", "411181012", "story_v_out_411181.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_411181", "411181012", "story_v_out_411181.awb")

						arg_49_1:RecordAudio("411181012", var_52_9)
						arg_49_1:RecordAudio("411181012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_411181", "411181012", "story_v_out_411181.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_411181", "411181012", "story_v_out_411181.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play411181013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 411181013
		arg_53_1.duration_ = 8.7

		local var_53_0 = {
			zh = 6.666,
			ja = 8.7
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play411181014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.9

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(411181013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 36 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 36)

				if (36 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 36)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181013", "story_v_out_411181.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_411181", "411181013", "story_v_out_411181.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_411181", "411181013", "story_v_out_411181.awb")

						arg_53_1:RecordAudio("411181013", var_56_6)
						arg_53_1:RecordAudio("411181013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_411181", "411181013", "story_v_out_411181.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_411181", "411181013", "story_v_out_411181.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play411181014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 411181014
		arg_57_1.duration_ = 6.1

		local var_57_0 = {
			zh = 3.466,
			ja = 6.1
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play411181015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) and arg_57_1.var_.characterEffect1095ui_story == nil then
				arg_57_1.var_.characterEffect1095ui_story = arg_57_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) then
				if arg_57_1.var_.characterEffect1095ui_story and not isNil(arg_57_1.actors_["1095ui_story"]) then
					arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) and arg_57_1.var_.characterEffect1095ui_story then
				arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.25

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(411181014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 10 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_4) / 10)

				if (10 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_4) / 10)) > 0 and var_60_2 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181014", "story_v_out_411181.awb") ~= 0 then
					local var_60_7 = manager.audio:GetVoiceLength("story_v_out_411181", "411181014", "story_v_out_411181.awb") / 1000

					if var_60_7 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_1
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_411181", "411181014", "story_v_out_411181.awb")

						arg_57_1:RecordAudio("411181014", var_60_8)
						arg_57_1:RecordAudio("411181014", var_60_8)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_411181", "411181014", "story_v_out_411181.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_411181", "411181014", "story_v_out_411181.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_9 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_9 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_9

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_9 and arg_57_1.time_ < var_60_1 + var_60_9 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play411181015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 411181015
		arg_61_1.duration_ = 5.53

		local var_61_0 = {
			zh = 3.5,
			ja = 5.533
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play411181016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = arg_61_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) then
				if arg_61_1.var_.characterEffect1095ui_story and not isNil(arg_61_1.actors_["1095ui_story"]) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_64_2 = 0
			local var_64_3 = 0.525

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(411181015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 21 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 21)

				if (21 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 21)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181015", "story_v_out_411181.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_411181", "411181015", "story_v_out_411181.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_411181", "411181015", "story_v_out_411181.awb")

						arg_61_1:RecordAudio("411181015", var_64_9)
						arg_61_1:RecordAudio("411181015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_411181", "411181015", "story_v_out_411181.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_411181", "411181015", "story_v_out_411181.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play411181016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 411181016
		arg_65_1.duration_ = 2.13

		local var_65_0 = {
			zh = 2.133,
			ja = 1.466
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play411181017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1095ui_story"]) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = arg_65_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1095ui_story"]) then
				if arg_65_1.var_.characterEffect1095ui_story and not isNil(arg_65_1.actors_["1095ui_story"]) then
					arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1095ui_story"]) and arg_65_1.var_.characterEffect1095ui_story then
				arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.1

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1155].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(411181016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 4 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_4) / 4)

				if (4 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_4) / 4)) > 0 and var_68_2 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181016", "story_v_out_411181.awb") ~= 0 then
					local var_68_7 = manager.audio:GetVoiceLength("story_v_out_411181", "411181016", "story_v_out_411181.awb") / 1000

					if var_68_7 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_1
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_411181", "411181016", "story_v_out_411181.awb")

						arg_65_1:RecordAudio("411181016", var_68_8)
						arg_65_1:RecordAudio("411181016", var_68_8)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_411181", "411181016", "story_v_out_411181.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_411181", "411181016", "story_v_out_411181.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_9 and arg_65_1.time_ < var_68_1 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play411181017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 411181017
		arg_69_1.duration_ = 2.3

		local var_69_0 = {
			zh = 2.3,
			ja = 1.999999999999
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play411181018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1095ui_story"]) and arg_69_1.var_.characterEffect1095ui_story == nil then
				arg_69_1.var_.characterEffect1095ui_story = arg_69_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1095ui_story"]) then
				if arg_69_1.var_.characterEffect1095ui_story and not isNil(arg_69_1.actors_["1095ui_story"]) then
					arg_69_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1095ui_story"]) and arg_69_1.var_.characterEffect1095ui_story then
				arg_69_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_72_2 = 0
			local var_72_3 = 0.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(411181017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 10 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 10)

				if (10 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 10)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181017", "story_v_out_411181.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_411181", "411181017", "story_v_out_411181.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_411181", "411181017", "story_v_out_411181.awb")

						arg_69_1:RecordAudio("411181017", var_72_9)
						arg_69_1:RecordAudio("411181017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_411181", "411181017", "story_v_out_411181.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_411181", "411181017", "story_v_out_411181.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_10 and arg_69_1.time_ < var_72_2 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play411181018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 411181018
		arg_73_1.duration_ = 9

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play411181019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				arg_73_1.var_.moveOldPos1095ui_story = arg_73_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 2 <= arg_73_1.time_ and arg_73_1.time_ < 2 + var_76_0 then
				arg_73_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 2) / var_76_0)
				arg_73_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1095ui_story"].transform.position).z)
				arg_73_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1095ui_story"].transform.localEulerAngles = arg_73_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 2 + var_76_0 and arg_73_1.time_ < 2 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1095ui_story"].transform.position).z)
				arg_73_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1095ui_story"].transform.localEulerAngles = arg_73_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1095ui_story"]

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1095ui_story == nil then
				arg_73_1.var_.characterEffect1095ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 2 <= arg_73_1.time_ and arg_73_1.time_ < 2 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1095ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 2) / var_76_2)
				end
			end

			if arg_73_1.time_ >= 2 + var_76_2 and arg_73_1.time_ < 2 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1095ui_story then
				arg_73_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				local var_76_3 = arg_73_1.bgs_.ST75

				arg_73_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_76_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_4 = var_76_3:GetComponent("SpriteRenderer")

				if var_76_4 and var_76_4.sprite then
					local var_76_5 = 2 * (var_76_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_76_3.transform.localScale = Vector3.New(var_76_5 / var_76_4.sprite.bounds.size.y < var_76_5 * manager.ui.mainCameraCom_.aspect / var_76_4.sprite.bounds.size.x and var_76_5 * manager.ui.mainCameraCom_.aspect / var_76_4.sprite.bounds.size.x or var_76_5 / var_76_4.sprite.bounds.size.y, var_76_5 / var_76_4.sprite.bounds.size.y < var_76_5 * manager.ui.mainCameraCom_.aspect / var_76_4.sprite.bounds.size.x and var_76_5 * manager.ui.mainCameraCom_.aspect / var_76_4.sprite.bounds.size.x or var_76_5 / var_76_4.sprite.bounds.size.y, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "ST75" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_6 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_7 = 2

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_7 then
				local var_76_8 = Color.New(0, 0, 0)

				var_76_8.a = Mathf.Lerp(0, 1, (arg_73_1.time_ - var_76_6) / var_76_7)
				arg_73_1.mask_.color = var_76_8
			end

			if arg_73_1.time_ >= var_76_6 + var_76_7 and arg_73_1.time_ < var_76_6 + var_76_7 + arg_76_0 then
				local var_76_9 = Color.New(0, 0, 0)

				var_76_9.a = 1
				arg_73_1.mask_.color = var_76_9
			end

			local var_76_10 = 2

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_11 = 2

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 then
				local var_76_12 = Color.New(0, 0, 0)

				var_76_12.a = Mathf.Lerp(1, 0, (arg_73_1.time_ - var_76_10) / var_76_11)
				arg_73_1.mask_.color = var_76_12
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 then
				local var_76_13 = Color.New(0, 0, 0)

				arg_73_1.mask_.enabled = false
				var_76_13.a = 0
				arg_73_1.mask_.color = var_76_13
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_14 = 4
			local var_76_15 = 1.175

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_16 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_16:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_17 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(411181018).content)

				arg_73_1.text_.text = var_76_17

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_19 = 47 <= 0 and var_76_15 or var_76_15 * (utf8.len(var_76_17) / 47)

				if (47 <= 0 and var_76_15 or var_76_15 * (utf8.len(var_76_17) / 47)) > 0 and var_76_15 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19
					var_76_14 = var_76_14 + 0.3

					if var_76_19 + var_76_14 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_14
					end
				end

				arg_73_1.text_.text = var_76_17
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_20 = var_76_14 + 0.3
			local var_76_21 = math.max(var_76_15, arg_73_1.talkMaxDuration)

			if var_76_14 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_20 + var_76_21 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_20) / var_76_21

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_20 + var_76_21 and arg_73_1.time_ < var_76_20 + var_76_21 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play411181019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 411181019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play411181020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.95

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(411181019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 38 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 38)

				if (38 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 38)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play411181020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 411181020
		arg_83_1.duration_ = 2

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play411181021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if arg_83_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_86_0 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_83_1.stage_.transform)

				var_86_0.name = "4010ui_story"
				var_86_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["4010ui_story"] = var_86_0

				local var_86_1 = var_86_0:GetComponentInChildren(typeof(CharacterEffect))

				var_86_1.enabled = true

				local var_86_2 = GameObjectTools.GetOrAddComponent(var_86_0, typeof(DynamicBoneHelper))

				if var_86_2 then
					var_86_2:EnableDynamicBone(false)
				end

				arg_83_1:ShowWeapon(var_86_1.transform, false)

				arg_83_1.var_["4010ui_story" .. "Animator"] = var_86_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_83_1.var_["4010ui_story" .. "Animator"].applyRootMotion = true
				arg_83_1.var_["4010ui_story" .. "LipSync"] = var_86_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_86_3 = arg_83_1.actors_["4010ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos4010ui_story = var_86_3.localPosition
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_3.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_83_1.time_ - 0) / var_86_4)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_3.localPosition = Vector3.New(0, -1.59, -5.2)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			local var_86_5 = arg_83_1.actors_["4010ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect4010ui_story == nil then
				arg_83_1.var_.characterEffect4010ui_story = var_86_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_6 and not isNil(var_86_5) then
				if arg_83_1.var_.characterEffect4010ui_story and not isNil(var_86_5) then
					arg_83_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_6 and arg_83_1.time_ < 0 + var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect4010ui_story then
				arg_83_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_86_8 = 0
			local var_86_9 = 0.1

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_10 = arg_83_1:GetWordFromCfg(411181020)
				local var_86_11 = arg_83_1:FormatText(var_86_10.content)

				arg_83_1.text_.text = var_86_11

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 4 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 4)

				if (4 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 4)) > 0 and var_86_9 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_8
					end
				end

				arg_83_1.text_.text = var_86_11
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181020", "story_v_out_411181.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181020", "story_v_out_411181.awb") / 1000

					if var_86_14 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_8
					end

					if var_86_10.prefab_name ~= "" and arg_83_1.actors_[var_86_10.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_10.prefab_name].transform, "story_v_out_411181", "411181020", "story_v_out_411181.awb")

						arg_83_1:RecordAudio("411181020", var_86_15)
						arg_83_1:RecordAudio("411181020", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_411181", "411181020", "story_v_out_411181.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_411181", "411181020", "story_v_out_411181.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_9, arg_83_1.talkMaxDuration)

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_8) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_8 + var_86_16 and arg_83_1.time_ < var_86_8 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play411181021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411181021
		arg_87_1.duration_ = 2

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play411181022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1095ui_story = arg_87_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).z)
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles = arg_87_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_87_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).z)
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles = arg_87_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1095ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1095ui_story == nil then
				arg_87_1.var_.characterEffect1095ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1095ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1095ui_story then
				arg_87_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_90_4 = arg_87_1.actors_["4010ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos4010ui_story = var_90_4.localPosition
			end

			local var_90_5 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_5 then
				var_90_4.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_5)
				var_90_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_4.position).x, (manager.ui.mainCamera.transform.position - var_90_4.position).y, (manager.ui.mainCamera.transform.position - var_90_4.position).z)
				var_90_4.localEulerAngles.z = 0
				var_90_4.localEulerAngles.x = 0
				var_90_4.localEulerAngles = var_90_4.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_5 and arg_87_1.time_ < 0 + var_90_5 + arg_90_0 then
				var_90_4.localPosition = Vector3.New(0, 100, 0)
				var_90_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_4.position).x, (manager.ui.mainCamera.transform.position - var_90_4.position).y, (manager.ui.mainCamera.transform.position - var_90_4.position).z)
				var_90_4.localEulerAngles.z = 0
				var_90_4.localEulerAngles.x = 0
				var_90_4.localEulerAngles = var_90_4.localEulerAngles
			end

			local var_90_6 = arg_87_1.actors_["4010ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect4010ui_story == nil then
				arg_87_1.var_.characterEffect4010ui_story = var_90_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_7 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 and not isNil(var_90_6) then
				if arg_87_1.var_.characterEffect4010ui_story and not isNil(var_90_6) then
					arg_87_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_87_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_7)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect4010ui_story then
				arg_87_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_87_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_90_8 = 0
			local var_90_9 = 0.1

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_10 = arg_87_1:GetWordFromCfg(411181021)
				local var_90_11 = arg_87_1:FormatText(var_90_10.content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 4 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 4)

				if (4 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 4)) > 0 and var_90_9 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13

					if var_90_13 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181021", "story_v_out_411181.awb") ~= 0 then
					local var_90_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181021", "story_v_out_411181.awb") / 1000

					if var_90_14 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_14 + var_90_8
					end

					if var_90_10.prefab_name ~= "" and arg_87_1.actors_[var_90_10.prefab_name] ~= nil then
						local var_90_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_10.prefab_name].transform, "story_v_out_411181", "411181021", "story_v_out_411181.awb")

						arg_87_1:RecordAudio("411181021", var_90_15)
						arg_87_1:RecordAudio("411181021", var_90_15)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_411181", "411181021", "story_v_out_411181.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_411181", "411181021", "story_v_out_411181.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_16 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_16

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_16 and arg_87_1.time_ < var_90_8 + var_90_16 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411181022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 411181022
		arg_91_1.duration_ = 6.2

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play411181023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_9000

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1095ui_story = arg_91_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1095ui_story"].transform.position).z)
				arg_91_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1095ui_story"].transform.localEulerAngles = arg_91_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1095ui_story"].transform.position).z)
				arg_91_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1095ui_story"].transform.localEulerAngles = arg_91_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["1095ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1095ui_story == nil then
				arg_91_1.var_.characterEffect1095ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1095ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_2)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1095ui_story then
				arg_91_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_94_3 = manager.ui.mainCamera.transform

			if 0.200000002980232 < arg_91_1.time_ and arg_91_1.time_ <= 0.200000002980232 + arg_94_0 then
				arg_91_1.var_.shakeOldPos = var_94_3.localPosition
			end

			local var_94_4 = 0.5

			if 0.200000002980232 <= arg_91_1.time_ and arg_91_1.time_ < 0.200000002980232 + var_94_4 then
				local var_94_5, var_94_6 = math.modf((arg_91_1.time_ - 0.200000002980232) / 0.066)

				var_94_3.localPosition = Vector3.New(var_94_6 * 0.13, var_94_6 * 0.13, var_94_6 * 0.13) + arg_91_1.var_.shakeOldPos
			end

			if arg_91_1.time_ >= 0.200000002980232 + var_94_4 and arg_91_1.time_ < 0.200000002980232 + var_94_4 + arg_94_0 then
				var_94_3.localPosition = arg_91_1.var_.shakeOldPos
			end

			if 0.466666666666667 < arg_91_1.time_ and arg_91_1.time_ <= 0.466666666666667 + arg_94_0 then
				local var_94_7 = arg_91_1.var_.effect101

				if not arg_91_1.var_.effect101 then
					var_94_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_94_7.name = "101"
					arg_91_1.var_.effect101 = var_94_7
				else
					var_94_7.transform:SetParent(var_94_9000)
				end

				var_94_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_94_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_94_9 = 0

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = false

				arg_91_1:SetGaussion(false)
			end

			local var_94_10 = 0.333333333333333

			if var_94_9 <= arg_91_1.time_ and arg_91_1.time_ < var_94_9 + var_94_10 then
				local var_94_11 = Color.New(1, 1, 1)

				var_94_11.a = Mathf.Lerp(1, 0, (arg_91_1.time_ - var_94_9) / var_94_10)
				arg_91_1.mask_.color = var_94_11
			end

			if arg_91_1.time_ >= var_94_9 + var_94_10 and arg_91_1.time_ < var_94_9 + var_94_10 + arg_94_0 then
				local var_94_12 = Color.New(1, 1, 1)

				arg_91_1.mask_.enabled = false
				var_94_12.a = 0
				arg_91_1.mask_.color = var_94_12
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_13 = 1.2
			local var_94_14 = 1.35

			if 1.2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_15 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_15:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_16 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(411181022).content)

				arg_91_1.text_.text = var_94_16

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_18 = 54 <= 0 and var_94_14 or var_94_14 * (utf8.len(var_94_16) / 54)

				if (54 <= 0 and var_94_14 or var_94_14 * (utf8.len(var_94_16) / 54)) > 0 and var_94_14 < var_94_18 then
					arg_91_1.talkMaxDuration = var_94_18
					var_94_13 = var_94_13 + 0.3

					if var_94_18 + var_94_13 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_18 + var_94_13
					end
				end

				arg_91_1.text_.text = var_94_16
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_19 = var_94_13 + 0.3
			local var_94_20 = math.max(var_94_14, arg_91_1.talkMaxDuration)

			if var_94_13 + 0.3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_19 + var_94_20 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_19) / var_94_20

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_19 + var_94_20 and arg_91_1.time_ < var_94_19 + var_94_20 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play411181023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 411181023
		arg_97_1.duration_ = 2.33

		local var_97_0 = {
			zh = 2.3,
			ja = 2.333
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
				arg_97_0:Play411181024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos4010ui_story = arg_97_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4010ui_story"].transform.position).z)
				arg_97_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["4010ui_story"].transform.localEulerAngles = arg_97_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_97_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4010ui_story"].transform.position).z)
				arg_97_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["4010ui_story"].transform.localEulerAngles = arg_97_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["4010ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect4010ui_story == nil then
				arg_97_1.var_.characterEffect4010ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect4010ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect4010ui_story then
				arg_97_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action5_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				if arg_97_1.var_.effect101 then
					Object.Destroy(arg_97_1.var_.effect101)

					arg_97_1.var_.effect101 = nil
				end
			end

			local var_100_5 = 0
			local var_100_6 = 0.275

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:GetWordFromCfg(411181023)
				local var_100_8 = arg_97_1:FormatText(var_100_7.content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 11 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 11)

				if (11 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 11)) > 0 and var_100_6 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181023", "story_v_out_411181.awb") ~= 0 then
					local var_100_11 = manager.audio:GetVoiceLength("story_v_out_411181", "411181023", "story_v_out_411181.awb") / 1000

					if var_100_11 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_5
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_411181", "411181023", "story_v_out_411181.awb")

						arg_97_1:RecordAudio("411181023", var_100_12)
						arg_97_1:RecordAudio("411181023", var_100_12)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_411181", "411181023", "story_v_out_411181.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_411181", "411181023", "story_v_out_411181.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_13 and arg_97_1.time_ < var_100_5 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411181024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 411181024
		arg_101_1.duration_ = 4.37

		local var_101_0 = {
			zh = 1.999999999999,
			ja = 4.366
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
				arg_101_0:Play411181025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1095ui_story = arg_101_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).z)
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles = arg_101_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_101_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1095ui_story"].transform.position).z)
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1095ui_story"].transform.localEulerAngles = arg_101_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1095ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1095ui_story == nil then
				arg_101_1.var_.characterEffect1095ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1095ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1095ui_story then
				arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_104_4 = arg_101_1.actors_["4010ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos4010ui_story = var_104_4.localPosition
			end

			local var_104_5 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 then
				var_104_4.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_5)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 then
				var_104_4.localPosition = Vector3.New(0, 100, 0)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			local var_104_6 = arg_101_1.actors_["4010ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect4010ui_story == nil then
				arg_101_1.var_.characterEffect4010ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 and not isNil(var_104_6) then
				if arg_101_1.var_.characterEffect4010ui_story and not isNil(var_104_6) then
					arg_101_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_101_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_7)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect4010ui_story then
				arg_101_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_101_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_104_8 = 0
			local var_104_9 = 0.225

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(411181024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 9 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 9)

				if (9 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 9)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181024", "story_v_out_411181.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181024", "story_v_out_411181.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_411181", "411181024", "story_v_out_411181.awb")

						arg_101_1:RecordAudio("411181024", var_104_15)
						arg_101_1:RecordAudio("411181024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_411181", "411181024", "story_v_out_411181.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_411181", "411181024", "story_v_out_411181.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play411181025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 411181025
		arg_105_1.duration_ = 5.43

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play411181026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1095ui_story = arg_105_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1095ui_story"].transform.position).z)
				arg_105_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1095ui_story"].transform.localEulerAngles = arg_105_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1095ui_story"].transform.position).z)
				arg_105_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1095ui_story"].transform.localEulerAngles = arg_105_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1095ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1095ui_story == nil then
				arg_105_1.var_.characterEffect1095ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1095ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_2)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1095ui_story then
				arg_105_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_explosion", "")
			end

			local var_108_4 = manager.ui.mainCamera.transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.shakeOldPos = var_108_4.localPosition
			end

			local var_108_5 = 0.666666666666667

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 then
				local var_108_6, var_108_7 = math.modf((arg_105_1.time_ - 0) / 0.066)

				var_108_4.localPosition = Vector3.New(var_108_7 * 0.13, var_108_7 * 0.13, var_108_7 * 0.13) + arg_105_1.var_.shakeOldPos
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 then
				var_108_4.localPosition = arg_105_1.var_.shakeOldPos
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_8 = 0.433333333333333
			local var_108_9 = 1.375

			if 0.433333333333333 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_10 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_10:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_11 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(411181025).content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 55 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 55)

				if (55 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 55)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13
					var_108_8 = var_108_8 + 0.3

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = var_108_8 + 0.3
			local var_108_15 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_14 + var_108_15 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_14) / var_108_15

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_14 + var_108_15 and arg_105_1.time_ < var_108_14 + var_108_15 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411181026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 411181026
		arg_111_1.duration_ = 6.14

		local var_111_0 = {
			zh = 6.10833333333333,
			ja = 6.14133333333333
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play411181027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_9000

			if arg_111_1.bgs_.B10c == nil then
				local var_114_0 = Object.Instantiate(arg_111_1.paintGo_)

				var_114_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10c")
				var_114_0.name = "B10c"
				var_114_0.transform.parent = arg_111_1.stage_.transform
				var_114_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.bgs_.B10c = var_114_0
			end

			if 2 < arg_111_1.time_ and arg_111_1.time_ <= 2 + arg_114_0 then
				local var_114_1 = arg_111_1.bgs_.B10c

				arg_111_1.bgs_.B10c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_114_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_114_2 = var_114_1:GetComponent("SpriteRenderer")

				if var_114_2 and var_114_2.sprite then
					local var_114_3 = 2 * (var_114_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_114_1.transform.localScale = Vector3.New(var_114_3 / var_114_2.sprite.bounds.size.y < var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x and var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x or var_114_3 / var_114_2.sprite.bounds.size.y, var_114_3 / var_114_2.sprite.bounds.size.y < var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x and var_114_3 * manager.ui.mainCameraCom_.aspect / var_114_2.sprite.bounds.size.x or var_114_3 / var_114_2.sprite.bounds.size.y, 0)
				end

				for iter_114_0, iter_114_1 in pairs(arg_111_1.bgs_) do
					if iter_114_0 ~= "B10c" then
						iter_114_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_114_4 = 0

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_5 = 2

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_5 then
				local var_114_6 = Color.New(0, 0, 0)

				var_114_6.a = Mathf.Lerp(0, 1, (arg_111_1.time_ - var_114_4) / var_114_5)
				arg_111_1.mask_.color = var_114_6
			end

			if arg_111_1.time_ >= var_114_4 + var_114_5 and arg_111_1.time_ < var_114_4 + var_114_5 + arg_114_0 then
				local var_114_7 = Color.New(0, 0, 0)

				var_114_7.a = 1
				arg_111_1.mask_.color = var_114_7
			end

			local var_114_8 = 2

			if 2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_9 = 2

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_9 then
				local var_114_10 = Color.New(0, 0, 0)

				var_114_10.a = Mathf.Lerp(1, 0, (arg_111_1.time_ - var_114_8) / var_114_9)
				arg_111_1.mask_.color = var_114_10
			end

			if arg_111_1.time_ >= var_114_8 + var_114_9 and arg_111_1.time_ < var_114_8 + var_114_9 + arg_114_0 then
				local var_114_11 = Color.New(0, 0, 0)

				arg_111_1.mask_.enabled = false
				var_114_11.a = 0
				arg_111_1.mask_.color = var_114_11
			end

			if 3.03333333333333 < arg_111_1.time_ and arg_111_1.time_ <= 3.03333333333333 + arg_114_0 then
				local var_114_12 = arg_111_1.var_.effect990

				if not arg_111_1.var_.effect990 then
					var_114_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_114_12.name = "990"
					arg_111_1.var_.effect990 = var_114_12
				else
					var_114_12.transform:SetParent(var_114_9000)
				end

				var_114_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_114_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_14 = 4.40833333333333
			local var_114_15 = 0.225

			if 4.40833333333333 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_16 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_16:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_111_1.dialogCg_.alpha = arg_115_0
				end))
				var_114_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[717].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_17 = arg_111_1:GetWordFromCfg(411181026)
				local var_114_18 = arg_111_1:FormatText(var_114_17.content)

				arg_111_1.text_.text = var_114_18

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_20 = 9 <= 0 and var_114_15 or var_114_15 * (utf8.len(var_114_18) / 9)

				if (9 <= 0 and var_114_15 or var_114_15 * (utf8.len(var_114_18) / 9)) > 0 and var_114_15 < var_114_20 then
					arg_111_1.talkMaxDuration = var_114_20
					var_114_14 = var_114_14 + 0.3

					if var_114_20 + var_114_14 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_20 + var_114_14
					end
				end

				arg_111_1.text_.text = var_114_18
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181026", "story_v_out_411181.awb") ~= 0 then
					local var_114_21 = manager.audio:GetVoiceLength("story_v_out_411181", "411181026", "story_v_out_411181.awb") / 1000

					if var_114_21 + var_114_14 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_21 + var_114_14
					end

					if var_114_17.prefab_name ~= "" and arg_111_1.actors_[var_114_17.prefab_name] ~= nil then
						local var_114_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_17.prefab_name].transform, "story_v_out_411181", "411181026", "story_v_out_411181.awb")

						arg_111_1:RecordAudio("411181026", var_114_22)
						arg_111_1:RecordAudio("411181026", var_114_22)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_411181", "411181026", "story_v_out_411181.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_411181", "411181026", "story_v_out_411181.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_23 = var_114_14 + 0.3
			local var_114_24 = math.max(var_114_15, arg_111_1.talkMaxDuration)

			if var_114_14 + 0.3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_23 + var_114_24 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_23) / var_114_24

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_23 + var_114_24 and arg_111_1.time_ < var_114_23 + var_114_24 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play411181027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 411181027
		arg_117_1.duration_ = 2.2

		local var_117_0 = {
			zh = 2.2,
			ja = 2.1
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
				arg_117_0:Play411181028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if arg_117_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_120_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_117_1.stage_.transform)

				var_120_0.name = "3008ui_story"
				var_120_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["3008ui_story"] = var_120_0

				local var_120_1 = var_120_0:GetComponentInChildren(typeof(CharacterEffect))

				var_120_1.enabled = true

				local var_120_2 = GameObjectTools.GetOrAddComponent(var_120_0, typeof(DynamicBoneHelper))

				if var_120_2 then
					var_120_2:EnableDynamicBone(false)
				end

				arg_117_1:ShowWeapon(var_120_1.transform, false)

				arg_117_1.var_["3008ui_story" .. "Animator"] = var_120_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_117_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_117_1.var_["3008ui_story" .. "LipSync"] = var_120_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_120_3 = arg_117_1.actors_["3008ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.characterEffect3008ui_story == nil then
				arg_117_1.var_.characterEffect3008ui_story = var_120_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_4 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 and not isNil(var_120_3) then
				if arg_117_1.var_.characterEffect3008ui_story and not isNil(var_120_3) then
					arg_117_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_117_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_4)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.characterEffect3008ui_story then
				arg_117_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_117_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_120_5 = 0
			local var_120_6 = 0.225

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[717].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_7 = arg_117_1:GetWordFromCfg(411181027)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 9 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 9)

				if (9 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 9)) > 0 and var_120_6 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181027", "story_v_out_411181.awb") ~= 0 then
					local var_120_11 = manager.audio:GetVoiceLength("story_v_out_411181", "411181027", "story_v_out_411181.awb") / 1000

					if var_120_11 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_5
					end

					if var_120_7.prefab_name ~= "" and arg_117_1.actors_[var_120_7.prefab_name] ~= nil then
						local var_120_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_7.prefab_name].transform, "story_v_out_411181", "411181027", "story_v_out_411181.awb")

						arg_117_1:RecordAudio("411181027", var_120_12)
						arg_117_1:RecordAudio("411181027", var_120_12)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_411181", "411181027", "story_v_out_411181.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_411181", "411181027", "story_v_out_411181.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_5) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_5 + var_120_13 and arg_117_1.time_ < var_120_5 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play411181028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 411181028
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play411181029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				if arg_121_1.var_.effect990 then
					Object.Destroy(arg_121_1.var_.effect990)

					arg_121_1.var_.effect990 = nil
				end
			end

			local var_124_1 = 0
			local var_124_2 = 0.7

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(411181028).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 28 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 28)

				if (28 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 28)) > 0 and var_124_2 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_6 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_6 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_6

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_6 and arg_121_1.time_ < var_124_1 + var_124_6 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play411181029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 411181029
		arg_125_1.duration_ = 3.47

		local var_125_0 = {
			zh = 1.999999999999,
			ja = 3.466
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
				arg_125_0:Play411181030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos4010ui_story = arg_125_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["4010ui_story"].transform.position).z)
				arg_125_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["4010ui_story"].transform.localEulerAngles = arg_125_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_125_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["4010ui_story"].transform.position).z)
				arg_125_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["4010ui_story"].transform.localEulerAngles = arg_125_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["4010ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect4010ui_story == nil then
				arg_125_1.var_.characterEffect4010ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect4010ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect4010ui_story then
				arg_125_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_128_4 = arg_125_1.actors_["3008ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos3008ui_story = var_128_4.localPosition
			end

			local var_128_5 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 then
				var_128_4.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_5)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 then
				var_128_4.localPosition = Vector3.New(0, 100, 0)
				var_128_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_4.position).x, (manager.ui.mainCamera.transform.position - var_128_4.position).y, (manager.ui.mainCamera.transform.position - var_128_4.position).z)
				var_128_4.localEulerAngles.z = 0
				var_128_4.localEulerAngles.x = 0
				var_128_4.localEulerAngles = var_128_4.localEulerAngles
			end

			local var_128_6 = arg_125_1.actors_["3008ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect3008ui_story == nil then
				arg_125_1.var_.characterEffect3008ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_7 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 and not isNil(var_128_6) then
				if arg_125_1.var_.characterEffect3008ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_125_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_7)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect3008ui_story then
				arg_125_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_125_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_128_8 = 0
			local var_128_9 = 0.25

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(411181029)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 10 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 10)

				if (10 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 10)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181029", "story_v_out_411181.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181029", "story_v_out_411181.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_411181", "411181029", "story_v_out_411181.awb")

						arg_125_1:RecordAudio("411181029", var_128_15)
						arg_125_1:RecordAudio("411181029", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_411181", "411181029", "story_v_out_411181.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_411181", "411181029", "story_v_out_411181.awb")
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
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
	Play411181030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 411181030
		arg_129_1.duration_ = 8.27

		local var_129_0 = {
			zh = 5.8,
			ja = 8.266
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
				arg_129_0:Play411181031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["4010ui_story"]) and arg_129_1.var_.characterEffect4010ui_story == nil then
				arg_129_1.var_.characterEffect4010ui_story = arg_129_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["4010ui_story"]) then
				if arg_129_1.var_.characterEffect4010ui_story and not isNil(arg_129_1.actors_["4010ui_story"]) then
					arg_129_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_129_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["4010ui_story"]) and arg_129_1.var_.characterEffect4010ui_story then
				arg_129_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_129_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.975

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[22].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_129_1.callingController_:SetSelectedState("calling")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(411181030)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 39 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 39)

				if (39 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 39)) > 0 and var_132_2 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181030", "story_v_out_411181.awb") ~= 0 then
					local var_132_7 = manager.audio:GetVoiceLength("story_v_out_411181", "411181030", "story_v_out_411181.awb") / 1000

					if var_132_7 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_1
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_411181", "411181030", "story_v_out_411181.awb")

						arg_129_1:RecordAudio("411181030", var_132_8)
						arg_129_1:RecordAudio("411181030", var_132_8)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_411181", "411181030", "story_v_out_411181.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_411181", "411181030", "story_v_out_411181.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_9 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_9 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_9

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_9 and arg_129_1.time_ < var_132_1 + var_132_9 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play411181031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 411181031
		arg_133_1.duration_ = 7.53

		local var_133_0 = {
			zh = 4.166,
			ja = 7.533
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
				arg_133_0:Play411181032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["4010ui_story"]) and arg_133_1.var_.characterEffect4010ui_story == nil then
				arg_133_1.var_.characterEffect4010ui_story = arg_133_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["4010ui_story"]) then
				if arg_133_1.var_.characterEffect4010ui_story and not isNil(arg_133_1.actors_["4010ui_story"]) then
					arg_133_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["4010ui_story"]) and arg_133_1.var_.characterEffect4010ui_story then
				arg_133_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_136_2 = 0
			local var_136_3 = 0.55

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(411181031)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 22 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 22)

				if (22 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 22)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181031", "story_v_out_411181.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_411181", "411181031", "story_v_out_411181.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_out_411181", "411181031", "story_v_out_411181.awb")

						arg_133_1:RecordAudio("411181031", var_136_9)
						arg_133_1:RecordAudio("411181031", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_411181", "411181031", "story_v_out_411181.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_411181", "411181031", "story_v_out_411181.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_10 and arg_133_1.time_ < var_136_2 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play411181032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 411181032
		arg_137_1.duration_ = 3

		local var_137_0 = {
			zh = 2.566,
			ja = 3
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
				arg_137_0:Play411181033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["4010ui_story"]) and arg_137_1.var_.characterEffect4010ui_story == nil then
				arg_137_1.var_.characterEffect4010ui_story = arg_137_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["4010ui_story"]) then
				if arg_137_1.var_.characterEffect4010ui_story and not isNil(arg_137_1.actors_["4010ui_story"]) then
					arg_137_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_137_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["4010ui_story"]) and arg_137_1.var_.characterEffect4010ui_story then
				arg_137_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_137_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_140_1 = arg_137_1.actors_["3008ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect3008ui_story == nil then
				arg_137_1.var_.characterEffect3008ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect3008ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect3008ui_story then
				arg_137_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_140_4 = 0
			local var_140_5 = 0.2

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[22].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_137_1.callingController_:SetSelectedState("calling")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_6 = arg_137_1:GetWordFromCfg(411181032)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 8 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 8)

				if (8 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 8)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181032", "story_v_out_411181.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_411181", "411181032", "story_v_out_411181.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_411181", "411181032", "story_v_out_411181.awb")

						arg_137_1:RecordAudio("411181032", var_140_11)
						arg_137_1:RecordAudio("411181032", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_411181", "411181032", "story_v_out_411181.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_411181", "411181032", "story_v_out_411181.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play411181033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 411181033
		arg_141_1.duration_ = 4.5

		local var_141_0 = {
			zh = 3.7,
			ja = 4.5
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play411181034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["4010ui_story"]) and arg_141_1.var_.characterEffect4010ui_story == nil then
				arg_141_1.var_.characterEffect4010ui_story = arg_141_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["4010ui_story"]) then
				if arg_141_1.var_.characterEffect4010ui_story and not isNil(arg_141_1.actors_["4010ui_story"]) then
					arg_141_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["4010ui_story"]) and arg_141_1.var_.characterEffect4010ui_story then
				arg_141_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_2 = 0
			local var_144_3 = 0.475

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(411181033)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 19 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 19)

				if (19 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 19)) > 0 and var_144_3 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181033", "story_v_out_411181.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_411181", "411181033", "story_v_out_411181.awb") / 1000

					if var_144_8 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_2
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_411181", "411181033", "story_v_out_411181.awb")

						arg_141_1:RecordAudio("411181033", var_144_9)
						arg_141_1:RecordAudio("411181033", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_411181", "411181033", "story_v_out_411181.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_411181", "411181033", "story_v_out_411181.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_10 and arg_141_1.time_ < var_144_2 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play411181034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 411181034
		arg_145_1.duration_ = 8.2

		local var_145_0 = {
			zh = 4.7,
			ja = 8.2
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
				arg_145_0:Play411181035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1095ui_story = arg_145_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).z)
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles = arg_145_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_145_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).z)
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles = arg_145_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["4010ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect4010ui_story == nil then
				arg_145_1.var_.characterEffect4010ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect4010ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_145_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_2)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect4010ui_story then
				arg_145_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_145_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_148_3 = arg_145_1.actors_["4010ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos4010ui_story = var_148_3.localPosition
			end

			local var_148_4 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_3.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_4)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_3.localPosition = Vector3.New(0, 100, 0)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			local var_148_5 = arg_145_1.actors_["1095ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1095ui_story == nil then
				arg_145_1.var_.characterEffect1095ui_story = var_148_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.characterEffect1095ui_story and not isNil(var_148_5) then
					arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1095ui_story then
				arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				if arg_145_1.var_.characterEffect1095ui_story == nil then
					arg_145_1.var_.characterEffect1095ui_story = arg_145_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_148_8 = arg_145_1.var_.characterEffect1095ui_story

				arg_145_1.var_.characterEffect1095ui_story.imageEffect:turnOn(false)

				var_148_8.interferenceEffect.enabled = true
				var_148_8.interferenceEffect.noise = 0.01
				var_148_8.interferenceEffect.simTimeScale = 1
				var_148_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				if arg_145_1.var_.characterEffect1095ui_story == nil then
					arg_145_1.var_.characterEffect1095ui_story = arg_145_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_145_1.var_.characterEffect1095ui_story.imageEffect:turnOn(false)
			end

			local var_148_10 = 0
			local var_148_11 = 0.6

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_12 = arg_145_1:GetWordFromCfg(411181034)
				local var_148_13 = arg_145_1:FormatText(var_148_12.content)

				arg_145_1.text_.text = var_148_13

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_15 = 24 <= 0 and var_148_11 or var_148_11 * (utf8.len(var_148_13) / 24)

				if (24 <= 0 and var_148_11 or var_148_11 * (utf8.len(var_148_13) / 24)) > 0 and var_148_11 < var_148_15 then
					arg_145_1.talkMaxDuration = var_148_15

					if var_148_15 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_15 + var_148_10
					end
				end

				arg_145_1.text_.text = var_148_13
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181034", "story_v_out_411181.awb") ~= 0 then
					local var_148_16 = manager.audio:GetVoiceLength("story_v_out_411181", "411181034", "story_v_out_411181.awb") / 1000

					if var_148_16 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_16 + var_148_10
					end

					if var_148_12.prefab_name ~= "" and arg_145_1.actors_[var_148_12.prefab_name] ~= nil then
						local var_148_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_12.prefab_name].transform, "story_v_out_411181", "411181034", "story_v_out_411181.awb")

						arg_145_1:RecordAudio("411181034", var_148_17)
						arg_145_1:RecordAudio("411181034", var_148_17)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_411181", "411181034", "story_v_out_411181.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_411181", "411181034", "story_v_out_411181.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_18 = math.max(var_148_11, arg_145_1.talkMaxDuration)

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_18 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_10) / var_148_18

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_10 + var_148_18 and arg_145_1.time_ < var_148_10 + var_148_18 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411181035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 411181035
		arg_149_1.duration_ = 2

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play411181036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1095ui_story"]) and arg_149_1.var_.characterEffect1095ui_story == nil then
				arg_149_1.var_.characterEffect1095ui_story = arg_149_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1095ui_story"]) then
				if arg_149_1.var_.characterEffect1095ui_story and not isNil(arg_149_1.actors_["1095ui_story"]) then
					arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1095ui_story"]) and arg_149_1.var_.characterEffect1095ui_story then
				arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_152_1 = arg_149_1.actors_["1095ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1095ui_story = var_152_1.localPosition
			end

			local var_152_2 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 then
				var_152_1.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_2)
				var_152_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_1.position).x, (manager.ui.mainCamera.transform.position - var_152_1.position).y, (manager.ui.mainCamera.transform.position - var_152_1.position).z)
				var_152_1.localEulerAngles.z = 0
				var_152_1.localEulerAngles.x = 0
				var_152_1.localEulerAngles = var_152_1.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 then
				var_152_1.localPosition = Vector3.New(0, 100, 0)
				var_152_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_1.position).x, (manager.ui.mainCamera.transform.position - var_152_1.position).y, (manager.ui.mainCamera.transform.position - var_152_1.position).z)
				var_152_1.localEulerAngles.z = 0
				var_152_1.localEulerAngles.x = 0
				var_152_1.localEulerAngles = var_152_1.localEulerAngles
			end

			local var_152_3 = arg_149_1.actors_["4010ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_3) and arg_149_1.var_.characterEffect4010ui_story == nil then
				arg_149_1.var_.characterEffect4010ui_story = var_152_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_4 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 and not isNil(var_152_3) then
				if arg_149_1.var_.characterEffect4010ui_story and not isNil(var_152_3) then
					arg_149_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 and not isNil(var_152_3) and arg_149_1.var_.characterEffect4010ui_story then
				arg_149_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_152_6 = arg_149_1.actors_["4010ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos4010ui_story = var_152_6.localPosition
			end

			local var_152_7 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				var_152_6.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_149_1.time_ - 0) / var_152_7)
				var_152_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_6.position).x, (manager.ui.mainCamera.transform.position - var_152_6.position).y, (manager.ui.mainCamera.transform.position - var_152_6.position).z)
				var_152_6.localEulerAngles.z = 0
				var_152_6.localEulerAngles.x = 0
				var_152_6.localEulerAngles = var_152_6.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				var_152_6.localPosition = Vector3.New(0, -1.59, -5.2)
				var_152_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_6.position).x, (manager.ui.mainCamera.transform.position - var_152_6.position).y, (manager.ui.mainCamera.transform.position - var_152_6.position).z)
				var_152_6.localEulerAngles.z = 0
				var_152_6.localEulerAngles.x = 0
				var_152_6.localEulerAngles = var_152_6.localEulerAngles
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			local var_152_8 = 0
			local var_152_9 = 0.05

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(411181035)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 2 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 2)

				if (2 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 2)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181035", "story_v_out_411181.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181035", "story_v_out_411181.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_411181", "411181035", "story_v_out_411181.awb")

						arg_149_1:RecordAudio("411181035", var_152_15)
						arg_149_1:RecordAudio("411181035", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_411181", "411181035", "story_v_out_411181.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_411181", "411181035", "story_v_out_411181.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411181036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 411181036
		arg_153_1.duration_ = 8.47

		local var_153_0 = {
			zh = 8.133,
			ja = 8.466
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
				arg_153_0:Play411181037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos4010ui_story = arg_153_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["4010ui_story"].transform.position).z)
				arg_153_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["4010ui_story"].transform.localEulerAngles = arg_153_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_153_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["4010ui_story"].transform.position).z)
				arg_153_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["4010ui_story"].transform.localEulerAngles = arg_153_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_156_1 = 0
			local var_156_2 = 1.1

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(411181036)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 44 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 44)

				if (44 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 44)) > 0 and var_156_2 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181036", "story_v_out_411181.awb") ~= 0 then
					local var_156_7 = manager.audio:GetVoiceLength("story_v_out_411181", "411181036", "story_v_out_411181.awb") / 1000

					if var_156_7 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_1
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_411181", "411181036", "story_v_out_411181.awb")

						arg_153_1:RecordAudio("411181036", var_156_8)
						arg_153_1:RecordAudio("411181036", var_156_8)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_411181", "411181036", "story_v_out_411181.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_411181", "411181036", "story_v_out_411181.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_9 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_9 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_9

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_9 and arg_153_1.time_ < var_156_1 + var_156_9 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411181037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 411181037
		arg_157_1.duration_ = 2.37

		local var_157_0 = {
			zh = 2.033,
			ja = 2.366
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
				arg_157_0:Play411181038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["4010ui_story"]) and arg_157_1.var_.characterEffect4010ui_story == nil then
				arg_157_1.var_.characterEffect4010ui_story = arg_157_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["4010ui_story"]) then
				if arg_157_1.var_.characterEffect4010ui_story and not isNil(arg_157_1.actors_["4010ui_story"]) then
					arg_157_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_157_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["4010ui_story"]) and arg_157_1.var_.characterEffect4010ui_story then
				arg_157_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_157_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 0.125

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[22].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_157_1.callingController_:SetSelectedState("calling")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(411181037)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 5 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 5)

				if (5 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 5)) > 0 and var_160_2 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181037", "story_v_out_411181.awb") ~= 0 then
					local var_160_7 = manager.audio:GetVoiceLength("story_v_out_411181", "411181037", "story_v_out_411181.awb") / 1000

					if var_160_7 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_1
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_411181", "411181037", "story_v_out_411181.awb")

						arg_157_1:RecordAudio("411181037", var_160_8)
						arg_157_1:RecordAudio("411181037", var_160_8)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_411181", "411181037", "story_v_out_411181.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_411181", "411181037", "story_v_out_411181.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_9 and arg_157_1.time_ < var_160_1 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play411181038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 411181038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play411181039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos4010ui_story = arg_161_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["4010ui_story"].transform.position).z)
				arg_161_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["4010ui_story"].transform.localEulerAngles = arg_161_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["4010ui_story"].transform.position).z)
				arg_161_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["4010ui_story"].transform.localEulerAngles = arg_161_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_164_1 = 0
			local var_164_2 = 1.425

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(411181038).content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 57 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 57)

				if (57 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 57)) > 0 and var_164_2 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_6 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_6 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_6

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_6 and arg_161_1.time_ < var_164_1 + var_164_6 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411181039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 411181039
		arg_165_1.duration_ = 4.23

		local var_165_0 = {
			zh = 4.033,
			ja = 4.233
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play411181040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 1.4 < arg_165_1.time_ and arg_165_1.time_ <= 1.4 + arg_168_0 then
				local var_168_0 = arg_165_1.bgs_.B10c

				arg_165_1.bgs_.B10c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_168_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_1 = var_168_0:GetComponent("SpriteRenderer")

				if var_168_1 and var_168_1.sprite then
					local var_168_2 = 2 * (var_168_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_168_0.transform.localScale = Vector3.New(var_168_2 / var_168_1.sprite.bounds.size.y < var_168_2 * manager.ui.mainCameraCom_.aspect / var_168_1.sprite.bounds.size.x and var_168_2 * manager.ui.mainCameraCom_.aspect / var_168_1.sprite.bounds.size.x or var_168_2 / var_168_1.sprite.bounds.size.y, var_168_2 / var_168_1.sprite.bounds.size.y < var_168_2 * manager.ui.mainCameraCom_.aspect / var_168_1.sprite.bounds.size.x and var_168_2 * manager.ui.mainCameraCom_.aspect / var_168_1.sprite.bounds.size.x or var_168_2 / var_168_1.sprite.bounds.size.y, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "B10c" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_3 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_4 = 1.4

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_4 then
				local var_168_5 = Color.New(0, 0, 0)

				var_168_5.a = Mathf.Lerp(0, 1, (arg_165_1.time_ - var_168_3) / var_168_4)
				arg_165_1.mask_.color = var_168_5
			end

			if arg_165_1.time_ >= var_168_3 + var_168_4 and arg_165_1.time_ < var_168_3 + var_168_4 + arg_168_0 then
				local var_168_6 = Color.New(0, 0, 0)

				var_168_6.a = 1
				arg_165_1.mask_.color = var_168_6
			end

			local var_168_7 = 1.4

			if 1.4 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_8 = 1.7

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_8 then
				local var_168_9 = Color.New(0, 0, 0)

				var_168_9.a = Mathf.Lerp(1, 0, (arg_165_1.time_ - var_168_7) / var_168_8)
				arg_165_1.mask_.color = var_168_9
			end

			if arg_165_1.time_ >= var_168_7 + var_168_8 and arg_165_1.time_ < var_168_7 + var_168_8 + arg_168_0 then
				local var_168_10 = Color.New(0, 0, 0)

				arg_165_1.mask_.enabled = false
				var_168_10.a = 0
				arg_165_1.mask_.color = var_168_10
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_11 = 3
			local var_168_12 = 0.1

			if 3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_13 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_13:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[718].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_14 = arg_165_1:GetWordFromCfg(411181039)
				local var_168_15 = arg_165_1:FormatText(var_168_14.content)

				arg_165_1.text_.text = var_168_15

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_17 = 4 <= 0 and var_168_12 or var_168_12 * (utf8.len(var_168_15) / 4)

				if (4 <= 0 and var_168_12 or var_168_12 * (utf8.len(var_168_15) / 4)) > 0 and var_168_12 < var_168_17 then
					arg_165_1.talkMaxDuration = var_168_17
					var_168_11 = var_168_11 + 0.3

					if var_168_17 + var_168_11 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_17 + var_168_11
					end
				end

				arg_165_1.text_.text = var_168_15
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181039", "story_v_out_411181.awb") ~= 0 then
					local var_168_18 = manager.audio:GetVoiceLength("story_v_out_411181", "411181039", "story_v_out_411181.awb") / 1000

					if var_168_18 + var_168_11 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_18 + var_168_11
					end

					if var_168_14.prefab_name ~= "" and arg_165_1.actors_[var_168_14.prefab_name] ~= nil then
						local var_168_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_14.prefab_name].transform, "story_v_out_411181", "411181039", "story_v_out_411181.awb")

						arg_165_1:RecordAudio("411181039", var_168_19)
						arg_165_1:RecordAudio("411181039", var_168_19)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_411181", "411181039", "story_v_out_411181.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_411181", "411181039", "story_v_out_411181.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_20 = var_168_11 + 0.3
			local var_168_21 = math.max(var_168_12, arg_165_1.talkMaxDuration)

			if var_168_11 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_20 + var_168_21 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_20) / var_168_21

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_20 + var_168_21 and arg_165_1.time_ < var_168_20 + var_168_21 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play411181040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411181040
		arg_171_1.duration_ = 3.1

		local var_171_0 = {
			zh = 2.466,
			ja = 3.1
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411181041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos4010ui_story = arg_171_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["4010ui_story"].transform.position).z)
				arg_171_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["4010ui_story"].transform.localEulerAngles = arg_171_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_171_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["4010ui_story"].transform.position).z)
				arg_171_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["4010ui_story"].transform.localEulerAngles = arg_171_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["4010ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect4010ui_story == nil then
				arg_171_1.var_.characterEffect4010ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect4010ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect4010ui_story then
				arg_171_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_174_4 = 0
			local var_174_5 = 0.35

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(411181040)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 14 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 14)

				if (14 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 14)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181040", "story_v_out_411181.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_411181", "411181040", "story_v_out_411181.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_411181", "411181040", "story_v_out_411181.awb")

						arg_171_1:RecordAudio("411181040", var_174_11)
						arg_171_1:RecordAudio("411181040", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_411181", "411181040", "story_v_out_411181.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_411181", "411181040", "story_v_out_411181.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_12 and arg_171_1.time_ < var_174_4 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411181041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411181041
		arg_175_1.duration_ = 3

		local var_175_0 = {
			zh = 1.9,
			ja = 3
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
				arg_175_0:Play411181042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["4010ui_story"]) and arg_175_1.var_.characterEffect4010ui_story == nil then
				arg_175_1.var_.characterEffect4010ui_story = arg_175_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["4010ui_story"]) then
				if arg_175_1.var_.characterEffect4010ui_story and not isNil(arg_175_1.actors_["4010ui_story"]) then
					arg_175_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_175_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["4010ui_story"]) and arg_175_1.var_.characterEffect4010ui_story then
				arg_175_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_175_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.25

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[718].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(411181041)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_6 = 10 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_4) / 10)

				if (10 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_4) / 10)) > 0 and var_178_2 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181041", "story_v_out_411181.awb") ~= 0 then
					local var_178_7 = manager.audio:GetVoiceLength("story_v_out_411181", "411181041", "story_v_out_411181.awb") / 1000

					if var_178_7 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_1
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_411181", "411181041", "story_v_out_411181.awb")

						arg_175_1:RecordAudio("411181041", var_178_8)
						arg_175_1:RecordAudio("411181041", var_178_8)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_411181", "411181041", "story_v_out_411181.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_411181", "411181041", "story_v_out_411181.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_9 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_9 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_9

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_9 and arg_175_1.time_ < var_178_1 + var_178_9 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play411181042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411181042
		arg_179_1.duration_ = 2.03

		local var_179_0 = {
			zh = 2.033,
			ja = 1.866
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
				arg_179_0:Play411181043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos4010ui_story = arg_179_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["4010ui_story"].transform.position).z)
				arg_179_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["4010ui_story"].transform.localEulerAngles = arg_179_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_179_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["4010ui_story"].transform.position).z)
				arg_179_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["4010ui_story"].transform.localEulerAngles = arg_179_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["4010ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect4010ui_story == nil then
				arg_179_1.var_.characterEffect4010ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect4010ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect4010ui_story then
				arg_179_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_182_4 = 0
			local var_182_5 = 0.3

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(411181042)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 12 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 12)

				if (12 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 12)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181042", "story_v_out_411181.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_411181", "411181042", "story_v_out_411181.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_411181", "411181042", "story_v_out_411181.awb")

						arg_179_1:RecordAudio("411181042", var_182_11)
						arg_179_1:RecordAudio("411181042", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_411181", "411181042", "story_v_out_411181.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_411181", "411181042", "story_v_out_411181.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411181043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 411181043
		arg_183_1.duration_ = 4.23

		local var_183_0 = {
			zh = 4.233,
			ja = 2.7
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
				arg_183_0:Play411181044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if arg_183_1.actors_["1024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1024ui_story"))) then
				local var_186_0 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_183_1.stage_.transform)

				var_186_0.name = "1024ui_story"
				var_186_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["1024ui_story"] = var_186_0

				local var_186_1 = var_186_0:GetComponentInChildren(typeof(CharacterEffect))

				var_186_1.enabled = true

				local var_186_2 = GameObjectTools.GetOrAddComponent(var_186_0, typeof(DynamicBoneHelper))

				if var_186_2 then
					var_186_2:EnableDynamicBone(false)
				end

				arg_183_1:ShowWeapon(var_186_1.transform, false)

				arg_183_1.var_["1024ui_story" .. "Animator"] = var_186_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_183_1.var_["1024ui_story" .. "Animator"].applyRootMotion = true
				arg_183_1.var_["1024ui_story" .. "LipSync"] = var_186_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_186_3 = arg_183_1.actors_["1024ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1024ui_story = var_186_3.localPosition
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_3.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_183_1.time_ - 0) / var_186_4)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_3.localPosition = Vector3.New(0, -1, -6.05)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			local var_186_5 = arg_183_1.actors_["1024ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect1024ui_story == nil then
				arg_183_1.var_.characterEffect1024ui_story = var_186_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_6 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_6 and not isNil(var_186_5) then
				if arg_183_1.var_.characterEffect1024ui_story and not isNil(var_186_5) then
					arg_183_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_6 and arg_183_1.time_ < 0 + var_186_6 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect1024ui_story then
				arg_183_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_186_8 = arg_183_1.actors_["4010ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos4010ui_story = var_186_8.localPosition
			end

			local var_186_9 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_9 then
				var_186_8.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_9)
				var_186_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_8.position).x, (manager.ui.mainCamera.transform.position - var_186_8.position).y, (manager.ui.mainCamera.transform.position - var_186_8.position).z)
				var_186_8.localEulerAngles.z = 0
				var_186_8.localEulerAngles.x = 0
				var_186_8.localEulerAngles = var_186_8.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_9 and arg_183_1.time_ < 0 + var_186_9 + arg_186_0 then
				var_186_8.localPosition = Vector3.New(0, 100, 0)
				var_186_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_8.position).x, (manager.ui.mainCamera.transform.position - var_186_8.position).y, (manager.ui.mainCamera.transform.position - var_186_8.position).z)
				var_186_8.localEulerAngles.z = 0
				var_186_8.localEulerAngles.x = 0
				var_186_8.localEulerAngles = var_186_8.localEulerAngles
			end

			local var_186_10 = arg_183_1.actors_["4010ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_10) and arg_183_1.var_.characterEffect4010ui_story == nil then
				arg_183_1.var_.characterEffect4010ui_story = var_186_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_11 and not isNil(var_186_10) then
				if arg_183_1.var_.characterEffect4010ui_story and not isNil(var_186_10) then
					arg_183_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_183_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_11)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_11 and arg_183_1.time_ < 0 + var_186_11 + arg_186_0 and not isNil(var_186_10) and arg_183_1.var_.characterEffect4010ui_story then
				arg_183_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_183_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_186_12 = 0
			local var_186_13 = 0.5

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_12 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_14 = arg_183_1:GetWordFromCfg(411181043)
				local var_186_15 = arg_183_1:FormatText(var_186_14.content)

				arg_183_1.text_.text = var_186_15

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_17 = 20 <= 0 and var_186_13 or var_186_13 * (utf8.len(var_186_15) / 20)

				if (20 <= 0 and var_186_13 or var_186_13 * (utf8.len(var_186_15) / 20)) > 0 and var_186_13 < var_186_17 then
					arg_183_1.talkMaxDuration = var_186_17

					if var_186_17 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_17 + var_186_12
					end
				end

				arg_183_1.text_.text = var_186_15
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181043", "story_v_out_411181.awb") ~= 0 then
					local var_186_18 = manager.audio:GetVoiceLength("story_v_out_411181", "411181043", "story_v_out_411181.awb") / 1000

					if var_186_18 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_18 + var_186_12
					end

					if var_186_14.prefab_name ~= "" and arg_183_1.actors_[var_186_14.prefab_name] ~= nil then
						local var_186_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_14.prefab_name].transform, "story_v_out_411181", "411181043", "story_v_out_411181.awb")

						arg_183_1:RecordAudio("411181043", var_186_19)
						arg_183_1:RecordAudio("411181043", var_186_19)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_411181", "411181043", "story_v_out_411181.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_411181", "411181043", "story_v_out_411181.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_20 = math.max(var_186_13, arg_183_1.talkMaxDuration)

			if var_186_12 <= arg_183_1.time_ and arg_183_1.time_ < var_186_12 + var_186_20 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_12) / var_186_20

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_12 + var_186_20 and arg_183_1.time_ < var_186_12 + var_186_20 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play411181044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 411181044
		arg_187_1.duration_ = 4.8

		local var_187_0 = {
			zh = 4.166,
			ja = 4.8
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
				arg_187_0:Play411181045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos4010ui_story = arg_187_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["4010ui_story"].transform.position).z)
				arg_187_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["4010ui_story"].transform.localEulerAngles = arg_187_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				arg_187_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["4010ui_story"].transform.position).z)
				arg_187_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["4010ui_story"].transform.localEulerAngles = arg_187_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["4010ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect4010ui_story == nil then
				arg_187_1.var_.characterEffect4010ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect4010ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect4010ui_story then
				arg_187_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_190_4 = arg_187_1.actors_["1024ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1024ui_story = var_190_4.localPosition
			end

			local var_190_5 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_5 then
				var_190_4.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1024ui_story, Vector3.New(0.7, -1, -6.05), (arg_187_1.time_ - 0) / var_190_5)
				var_190_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_4.position).x, (manager.ui.mainCamera.transform.position - var_190_4.position).y, (manager.ui.mainCamera.transform.position - var_190_4.position).z)
				var_190_4.localEulerAngles.z = 0
				var_190_4.localEulerAngles.x = 0
				var_190_4.localEulerAngles = var_190_4.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_5 and arg_187_1.time_ < 0 + var_190_5 + arg_190_0 then
				var_190_4.localPosition = Vector3.New(0.7, -1, -6.05)
				var_190_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_4.position).x, (manager.ui.mainCamera.transform.position - var_190_4.position).y, (manager.ui.mainCamera.transform.position - var_190_4.position).z)
				var_190_4.localEulerAngles.z = 0
				var_190_4.localEulerAngles.x = 0
				var_190_4.localEulerAngles = var_190_4.localEulerAngles
			end

			local var_190_6 = arg_187_1.actors_["1024ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect1024ui_story == nil then
				arg_187_1.var_.characterEffect1024ui_story = var_190_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_7 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 and not isNil(var_190_6) then
				if arg_187_1.var_.characterEffect1024ui_story and not isNil(var_190_6) then
					arg_187_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_7)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect1024ui_story then
				arg_187_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_190_8 = 0
			local var_190_9 = 0.35

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(411181044)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 14 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 14)

				if (14 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 14)) > 0 and var_190_9 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181044", "story_v_out_411181.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181044", "story_v_out_411181.awb") / 1000

					if var_190_14 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_8
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_out_411181", "411181044", "story_v_out_411181.awb")

						arg_187_1:RecordAudio("411181044", var_190_15)
						arg_187_1:RecordAudio("411181044", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_411181", "411181044", "story_v_out_411181.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_411181", "411181044", "story_v_out_411181.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_16 and arg_187_1.time_ < var_190_8 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play411181045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 411181045
		arg_191_1.duration_ = 7.03

		local var_191_0 = {
			zh = 5.6,
			ja = 7.033
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
				arg_191_0:Play411181046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos4010ui_story = arg_191_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["4010ui_story"].transform.position).z)
				arg_191_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["4010ui_story"].transform.localEulerAngles = arg_191_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				arg_191_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["4010ui_story"].transform.position).z)
				arg_191_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["4010ui_story"].transform.localEulerAngles = arg_191_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["4010ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect4010ui_story == nil then
				arg_191_1.var_.characterEffect4010ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect4010ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_191_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_2)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect4010ui_story then
				arg_191_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_191_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_194_3 = arg_191_1.actors_["1024ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1024ui_story = var_194_3.localPosition
			end

			local var_194_4 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				var_194_3.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1024ui_story, Vector3.New(0.7, -1, -6.05), (arg_191_1.time_ - 0) / var_194_4)
				var_194_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_3.position).x, (manager.ui.mainCamera.transform.position - var_194_3.position).y, (manager.ui.mainCamera.transform.position - var_194_3.position).z)
				var_194_3.localEulerAngles.z = 0
				var_194_3.localEulerAngles.x = 0
				var_194_3.localEulerAngles = var_194_3.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				var_194_3.localPosition = Vector3.New(0.7, -1, -6.05)
				var_194_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_3.position).x, (manager.ui.mainCamera.transform.position - var_194_3.position).y, (manager.ui.mainCamera.transform.position - var_194_3.position).z)
				var_194_3.localEulerAngles.z = 0
				var_194_3.localEulerAngles.x = 0
				var_194_3.localEulerAngles = var_194_3.localEulerAngles
			end

			local var_194_5 = arg_191_1.actors_["1024ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.characterEffect1024ui_story == nil then
				arg_191_1.var_.characterEffect1024ui_story = var_194_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_6 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_6 and not isNil(var_194_5) then
				if arg_191_1.var_.characterEffect1024ui_story and not isNil(var_194_5) then
					arg_191_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_6 and arg_191_1.time_ < 0 + var_194_6 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.characterEffect1024ui_story then
				arg_191_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_194_8 = 0
			local var_194_9 = 0.775

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_10 = arg_191_1:GetWordFromCfg(411181045)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_13 = 31 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 31)

				if (31 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 31)) > 0 and var_194_9 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_8
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181045", "story_v_out_411181.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181045", "story_v_out_411181.awb") / 1000

					if var_194_14 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_8
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_411181", "411181045", "story_v_out_411181.awb")

						arg_191_1:RecordAudio("411181045", var_194_15)
						arg_191_1:RecordAudio("411181045", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_411181", "411181045", "story_v_out_411181.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_411181", "411181045", "story_v_out_411181.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_9, arg_191_1.talkMaxDuration)

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_8) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_8 + var_194_16 and arg_191_1.time_ < var_194_8 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play411181046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 411181046
		arg_195_1.duration_ = 5.3

		local var_195_0 = {
			zh = 2.2,
			ja = 5.3
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
				arg_195_0:Play411181047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1024ui_story"]) and arg_195_1.var_.characterEffect1024ui_story == nil then
				arg_195_1.var_.characterEffect1024ui_story = arg_195_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1024ui_story"]) then
				if arg_195_1.var_.characterEffect1024ui_story and not isNil(arg_195_1.actors_["1024ui_story"]) then
					arg_195_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1024ui_story"]) and arg_195_1.var_.characterEffect1024ui_story then
				arg_195_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_198_1 = arg_195_1.actors_["4010ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect4010ui_story == nil then
				arg_195_1.var_.characterEffect4010ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect4010ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect4010ui_story then
				arg_195_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_198_4 = 0
			local var_198_5 = 0.275

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(411181046)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 11 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 11)

				if (11 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 11)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181046", "story_v_out_411181.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_out_411181", "411181046", "story_v_out_411181.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_out_411181", "411181046", "story_v_out_411181.awb")

						arg_195_1:RecordAudio("411181046", var_198_11)
						arg_195_1:RecordAudio("411181046", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_411181", "411181046", "story_v_out_411181.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_411181", "411181046", "story_v_out_411181.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play411181047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 411181047
		arg_199_1.duration_ = 6

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play411181048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_9000

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1024ui_story = arg_199_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1024ui_story"].transform.position).z)
				arg_199_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1024ui_story"].transform.localEulerAngles = arg_199_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1024ui_story"].transform.position).z)
				arg_199_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1024ui_story"].transform.localEulerAngles = arg_199_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["4010ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos4010ui_story = var_202_1.localPosition
			end

			local var_202_2 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 then
				var_202_1.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_2)
				var_202_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_1.position).x, (manager.ui.mainCamera.transform.position - var_202_1.position).y, (manager.ui.mainCamera.transform.position - var_202_1.position).z)
				var_202_1.localEulerAngles.z = 0
				var_202_1.localEulerAngles.x = 0
				var_202_1.localEulerAngles = var_202_1.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 then
				var_202_1.localPosition = Vector3.New(0, 100, 0)
				var_202_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_1.position).x, (manager.ui.mainCamera.transform.position - var_202_1.position).y, (manager.ui.mainCamera.transform.position - var_202_1.position).z)
				var_202_1.localEulerAngles.z = 0
				var_202_1.localEulerAngles.x = 0
				var_202_1.localEulerAngles = var_202_1.localEulerAngles
			end

			local var_202_3 = manager.ui.mainCamera.transform

			if 0.333333343267441 < arg_199_1.time_ and arg_199_1.time_ <= 0.333333343267441 + arg_202_0 then
				arg_199_1.var_.shakeOldPos = var_202_3.localPosition
			end

			local var_202_4 = 0.5

			if 0.333333343267441 <= arg_199_1.time_ and arg_199_1.time_ < 0.333333343267441 + var_202_4 then
				local var_202_5, var_202_6 = math.modf((arg_199_1.time_ - 0.333333343267441) / 0.066)

				var_202_3.localPosition = Vector3.New(var_202_6 * 0.13, var_202_6 * 0.13, var_202_6 * 0.13) + arg_199_1.var_.shakeOldPos
			end

			if arg_199_1.time_ >= 0.333333343267441 + var_202_4 and arg_199_1.time_ < 0.333333343267441 + var_202_4 + arg_202_0 then
				var_202_3.localPosition = arg_199_1.var_.shakeOldPos
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				local var_202_7 = arg_199_1.var_.effect123

				if not arg_199_1.var_.effect123 then
					var_202_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_202_7.name = "123"
					arg_199_1.var_.effect123 = var_202_7
				else
					var_202_7.transform:SetParent(var_202_9000)
				end

				var_202_7.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_202_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.733333333333333 < arg_199_1.time_ and arg_199_1.time_ <= 0.733333333333333 + arg_202_0 then
				if arg_199_1.var_.effect123 then
					Object.Destroy(arg_199_1.var_.effect123)

					arg_199_1.var_.effect123 = nil
				end
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_10 = 1
			local var_202_11 = 1.275

			if 1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_12 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_12:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_13 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(411181047).content)

				arg_199_1.text_.text = var_202_13

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_15 = 51 <= 0 and var_202_11 or var_202_11 * (utf8.len(var_202_13) / 51)

				if (51 <= 0 and var_202_11 or var_202_11 * (utf8.len(var_202_13) / 51)) > 0 and var_202_11 < var_202_15 then
					arg_199_1.talkMaxDuration = var_202_15
					var_202_10 = var_202_10 + 0.3

					if var_202_15 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_15 + var_202_10
					end
				end

				arg_199_1.text_.text = var_202_13
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = var_202_10 + 0.3
			local var_202_17 = math.max(var_202_11, arg_199_1.talkMaxDuration)

			if var_202_10 + 0.3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_16 + var_202_17 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_16) / var_202_17

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_16 + var_202_17 and arg_199_1.time_ < var_202_16 + var_202_17 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play411181048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 411181048
		arg_205_1.duration_ = 7.17

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play411181049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = false

				arg_205_1:SetGaussion(false)
			end

			local var_208_0 = 1.93333333333333

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				local var_208_1 = Color.New(1, 1, 1)

				var_208_1.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.mask_.color = var_208_1
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				local var_208_2 = Color.New(1, 1, 1)

				arg_205_1.mask_.enabled = false
				var_208_2.a = 0
				arg_205_1.mask_.color = var_208_2
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_3 = 2.16666666666667
			local var_208_4 = 1.725

			if 2.16666666666667 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_5 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_5:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(411181048).content)

				arg_205_1.text_.text = var_208_6

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_8 = 67 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_6) / 67)

				if (67 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_6) / 67)) > 0 and var_208_4 < var_208_8 then
					arg_205_1.talkMaxDuration = var_208_8
					var_208_3 = var_208_3 + 0.3

					if var_208_8 + var_208_3 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_3
					end
				end

				arg_205_1.text_.text = var_208_6
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_9 = var_208_3 + 0.3
			local var_208_10 = math.max(var_208_4, arg_205_1.talkMaxDuration)

			if var_208_3 + 0.3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_9) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_9 + var_208_10 and arg_205_1.time_ < var_208_9 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play411181049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 411181049
		arg_211_1.duration_ = 2.57

		local var_211_0 = {
			zh = 2.566,
			ja = 2.366
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play411181050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if arg_211_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_214_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_211_1.stage_.transform)

				var_214_0.name = "2078ui_story"
				var_214_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["2078ui_story"] = var_214_0

				local var_214_1 = var_214_0:GetComponentInChildren(typeof(CharacterEffect))

				var_214_1.enabled = true

				local var_214_2 = GameObjectTools.GetOrAddComponent(var_214_0, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(false)
				end

				arg_211_1:ShowWeapon(var_214_1.transform, false)

				arg_211_1.var_["2078ui_story" .. "Animator"] = var_214_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_211_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_211_1.var_["2078ui_story" .. "LipSync"] = var_214_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_214_3 = arg_211_1.actors_["2078ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos2078ui_story = var_214_3.localPosition
			end

			local var_214_4 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				var_214_3.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_211_1.time_ - 0) / var_214_4)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			local var_214_5 = arg_211_1.actors_["2078ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.characterEffect2078ui_story == nil then
				arg_211_1.var_.characterEffect2078ui_story = var_214_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_6 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_6 and not isNil(var_214_5) then
				if arg_211_1.var_.characterEffect2078ui_story and not isNil(var_214_5) then
					arg_211_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_6 and arg_211_1.time_ < 0 + var_214_6 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.characterEffect2078ui_story then
				arg_211_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_8 = 0
			local var_214_9 = 0.275

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_10 = arg_211_1:GetWordFromCfg(411181049)
				local var_214_11 = arg_211_1:FormatText(var_214_10.content)

				arg_211_1.text_.text = var_214_11

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 11 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 11)

				if (11 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 11)) > 0 and var_214_9 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_8
					end
				end

				arg_211_1.text_.text = var_214_11
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181049", "story_v_out_411181.awb") ~= 0 then
					local var_214_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181049", "story_v_out_411181.awb") / 1000

					if var_214_14 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_14 + var_214_8
					end

					if var_214_10.prefab_name ~= "" and arg_211_1.actors_[var_214_10.prefab_name] ~= nil then
						local var_214_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_10.prefab_name].transform, "story_v_out_411181", "411181049", "story_v_out_411181.awb")

						arg_211_1:RecordAudio("411181049", var_214_15)
						arg_211_1:RecordAudio("411181049", var_214_15)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_411181", "411181049", "story_v_out_411181.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_411181", "411181049", "story_v_out_411181.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_9, arg_211_1.talkMaxDuration)

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_8) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_8 + var_214_16 and arg_211_1.time_ < var_214_8 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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
	Play411181050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 411181050
		arg_215_1.duration_ = 5.3

		local var_215_0 = {
			zh = 3.3,
			ja = 5.3
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play411181051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos4010ui_story = arg_215_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["4010ui_story"].transform.position).z)
				arg_215_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["4010ui_story"].transform.localEulerAngles = arg_215_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_215_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["4010ui_story"].transform.position).z)
				arg_215_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["4010ui_story"].transform.localEulerAngles = arg_215_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["4010ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect4010ui_story == nil then
				arg_215_1.var_.characterEffect4010ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect4010ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect4010ui_story then
				arg_215_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_218_4 = arg_215_1.actors_["2078ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos2078ui_story = var_218_4.localPosition
			end

			local var_218_5 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_5 then
				var_218_4.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_5)
				var_218_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_4.position).x, (manager.ui.mainCamera.transform.position - var_218_4.position).y, (manager.ui.mainCamera.transform.position - var_218_4.position).z)
				var_218_4.localEulerAngles.z = 0
				var_218_4.localEulerAngles.x = 0
				var_218_4.localEulerAngles = var_218_4.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_5 and arg_215_1.time_ < 0 + var_218_5 + arg_218_0 then
				var_218_4.localPosition = Vector3.New(0, 100, 0)
				var_218_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_4.position).x, (manager.ui.mainCamera.transform.position - var_218_4.position).y, (manager.ui.mainCamera.transform.position - var_218_4.position).z)
				var_218_4.localEulerAngles.z = 0
				var_218_4.localEulerAngles.x = 0
				var_218_4.localEulerAngles = var_218_4.localEulerAngles
			end

			local var_218_6 = arg_215_1.actors_["2078ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect2078ui_story == nil then
				arg_215_1.var_.characterEffect2078ui_story = var_218_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_7 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 and not isNil(var_218_6) then
				if arg_215_1.var_.characterEffect2078ui_story and not isNil(var_218_6) then
					arg_215_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_215_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_7)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect2078ui_story then
				arg_215_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_215_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_218_8 = 0
			local var_218_9 = 0.375

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_10 = arg_215_1:GetWordFromCfg(411181050)
				local var_218_11 = arg_215_1:FormatText(var_218_10.content)

				arg_215_1.text_.text = var_218_11

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_13 = 15 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 15)

				if (15 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 15)) > 0 and var_218_9 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_8
					end
				end

				arg_215_1.text_.text = var_218_11
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181050", "story_v_out_411181.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181050", "story_v_out_411181.awb") / 1000

					if var_218_14 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_8
					end

					if var_218_10.prefab_name ~= "" and arg_215_1.actors_[var_218_10.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_10.prefab_name].transform, "story_v_out_411181", "411181050", "story_v_out_411181.awb")

						arg_215_1:RecordAudio("411181050", var_218_15)
						arg_215_1:RecordAudio("411181050", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_411181", "411181050", "story_v_out_411181.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_411181", "411181050", "story_v_out_411181.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_16 = math.max(var_218_9, arg_215_1.talkMaxDuration)

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_16 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_8) / var_218_16

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_8 + var_218_16 and arg_215_1.time_ < var_218_8 + var_218_16 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play411181051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 411181051
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play411181052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos4010ui_story = arg_219_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["4010ui_story"].transform.position).z)
				arg_219_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["4010ui_story"].transform.localEulerAngles = arg_219_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["4010ui_story"].transform.position).z)
				arg_219_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["4010ui_story"].transform.localEulerAngles = arg_219_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["4010ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect4010ui_story == nil then
				arg_219_1.var_.characterEffect4010ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect4010ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_219_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_2)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect4010ui_story then
				arg_219_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_219_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_222_3 = 0
			local var_222_4 = 1.225

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_5 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(411181051).content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 49 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_5) / 49)

				if (49 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_5) / 49)) > 0 and var_222_4 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_3
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_4, arg_219_1.talkMaxDuration)

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_3) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_3 + var_222_8 and arg_219_1.time_ < var_222_3 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411181052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 411181052
		arg_223_1.duration_ = 3.33

		local var_223_0 = {
			zh = 1.833,
			ja = 3.333
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
				arg_223_0:Play411181053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos4010ui_story = arg_223_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["4010ui_story"].transform.position).z)
				arg_223_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["4010ui_story"].transform.localEulerAngles = arg_223_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_223_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["4010ui_story"].transform.position).z)
				arg_223_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["4010ui_story"].transform.localEulerAngles = arg_223_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["4010ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect4010ui_story == nil then
				arg_223_1.var_.characterEffect4010ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect4010ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect4010ui_story then
				arg_223_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_4 = 0
			local var_226_5 = 0.2

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(411181052)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 8 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 8)

				if (8 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 8)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181052", "story_v_out_411181.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_411181", "411181052", "story_v_out_411181.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_411181", "411181052", "story_v_out_411181.awb")

						arg_223_1:RecordAudio("411181052", var_226_11)
						arg_223_1:RecordAudio("411181052", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_411181", "411181052", "story_v_out_411181.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_411181", "411181052", "story_v_out_411181.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play411181053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 411181053
		arg_227_1.duration_ = 4.53

		local var_227_0 = {
			zh = 4.533,
			ja = 1.999999999999
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
				arg_227_0:Play411181054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1024ui_story = arg_227_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1024ui_story"].transform.position).z)
				arg_227_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1024ui_story"].transform.localEulerAngles = arg_227_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_227_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1024ui_story"].transform.position).z)
				arg_227_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1024ui_story"].transform.localEulerAngles = arg_227_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1024ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1024ui_story == nil then
				arg_227_1.var_.characterEffect1024ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1024ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1024ui_story then
				arg_227_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_230_4 = arg_227_1.actors_["4010ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos4010ui_story = var_230_4.localPosition
			end

			local var_230_5 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_5 then
				var_230_4.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_5)
				var_230_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_4.position).x, (manager.ui.mainCamera.transform.position - var_230_4.position).y, (manager.ui.mainCamera.transform.position - var_230_4.position).z)
				var_230_4.localEulerAngles.z = 0
				var_230_4.localEulerAngles.x = 0
				var_230_4.localEulerAngles = var_230_4.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_5 and arg_227_1.time_ < 0 + var_230_5 + arg_230_0 then
				var_230_4.localPosition = Vector3.New(0, 100, 0)
				var_230_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_4.position).x, (manager.ui.mainCamera.transform.position - var_230_4.position).y, (manager.ui.mainCamera.transform.position - var_230_4.position).z)
				var_230_4.localEulerAngles.z = 0
				var_230_4.localEulerAngles.x = 0
				var_230_4.localEulerAngles = var_230_4.localEulerAngles
			end

			local var_230_6 = arg_227_1.actors_["4010ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_6) and arg_227_1.var_.characterEffect4010ui_story == nil then
				arg_227_1.var_.characterEffect4010ui_story = var_230_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_7 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 and not isNil(var_230_6) then
				if arg_227_1.var_.characterEffect4010ui_story and not isNil(var_230_6) then
					arg_227_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_227_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_7)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 and not isNil(var_230_6) and arg_227_1.var_.characterEffect4010ui_story then
				arg_227_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_227_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_230_8 = 0
			local var_230_9 = 0.05

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_10 = arg_227_1:GetWordFromCfg(411181053)
				local var_230_11 = arg_227_1:FormatText(var_230_10.content)

				arg_227_1.text_.text = var_230_11

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 2 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 2)

				if (2 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 2)) > 0 and var_230_9 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_11
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181053", "story_v_out_411181.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_out_411181", "411181053", "story_v_out_411181.awb") / 1000

					if var_230_14 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_8
					end

					if var_230_10.prefab_name ~= "" and arg_227_1.actors_[var_230_10.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_10.prefab_name].transform, "story_v_out_411181", "411181053", "story_v_out_411181.awb")

						arg_227_1:RecordAudio("411181053", var_230_15)
						arg_227_1:RecordAudio("411181053", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_411181", "411181053", "story_v_out_411181.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_411181", "411181053", "story_v_out_411181.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_16 and arg_227_1.time_ < var_230_8 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play411181054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 411181054
		arg_231_1.duration_ = 6.4

		local var_231_0 = {
			zh = 3.63300000298023,
			ja = 6.40000000298023
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
				arg_231_0:Play411181055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1024ui_story = arg_231_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1024ui_story"].transform.position).z)
				arg_231_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1024ui_story"].transform.localEulerAngles = arg_231_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1024ui_story"].transform.position).z)
				arg_231_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1024ui_story"].transform.localEulerAngles = arg_231_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1024ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1024ui_story == nil then
				arg_231_1.var_.characterEffect1024ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1024ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_2)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1024ui_story then
				arg_231_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_234_3 = arg_231_1.actors_["2078ui_story"].transform

			if 0.5 < arg_231_1.time_ and arg_231_1.time_ <= 0.5 + arg_234_0 then
				arg_231_1.var_.moveOldPos2078ui_story = var_234_3.localPosition
			end

			local var_234_4 = 0.001

			if 0.5 <= arg_231_1.time_ and arg_231_1.time_ < 0.5 + var_234_4 then
				var_234_3.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_231_1.time_ - 0.5) / var_234_4)
				var_234_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_3.position).x, (manager.ui.mainCamera.transform.position - var_234_3.position).y, (manager.ui.mainCamera.transform.position - var_234_3.position).z)
				var_234_3.localEulerAngles.z = 0
				var_234_3.localEulerAngles.x = 0
				var_234_3.localEulerAngles = var_234_3.localEulerAngles
			end

			if arg_231_1.time_ >= 0.5 + var_234_4 and arg_231_1.time_ < 0.5 + var_234_4 + arg_234_0 then
				var_234_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_234_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_3.position).x, (manager.ui.mainCamera.transform.position - var_234_3.position).y, (manager.ui.mainCamera.transform.position - var_234_3.position).z)
				var_234_3.localEulerAngles.z = 0
				var_234_3.localEulerAngles.x = 0
				var_234_3.localEulerAngles = var_234_3.localEulerAngles
			end

			local var_234_5 = arg_231_1.actors_["2078ui_story"]

			if 0.5 < arg_231_1.time_ and arg_231_1.time_ <= 0.5 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect2078ui_story == nil then
				arg_231_1.var_.characterEffect2078ui_story = var_234_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if 0.5 <= arg_231_1.time_ and arg_231_1.time_ < 0.5 + var_234_6 and not isNil(var_234_5) then
				if arg_231_1.var_.characterEffect2078ui_story and not isNil(var_234_5) then
					arg_231_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0.5 + var_234_6 and arg_231_1.time_ < 0.5 + var_234_6 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect2078ui_story then
				arg_231_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0.5 < arg_231_1.time_ and arg_231_1.time_ <= 0.5 + arg_234_0 then
				arg_231_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0.5 < arg_231_1.time_ and arg_231_1.time_ <= 0.5 + arg_234_0 then
				arg_231_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_8 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = false

				arg_231_1:SetGaussion(false)
			end

			local var_234_9 = 0.1

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_9 then
				local var_234_10 = Color.New(1, 1, 1)

				var_234_10.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_8) / var_234_9)
				arg_231_1.mask_.color = var_234_10
			end

			if arg_231_1.time_ >= var_234_8 + var_234_9 and arg_231_1.time_ < var_234_8 + var_234_9 + arg_234_0 then
				local var_234_11 = Color.New(1, 1, 1)

				arg_231_1.mask_.enabled = false
				var_234_11.a = 0
				arg_231_1.mask_.color = var_234_11
			end

			local var_234_12 = 0.1

			if 0.1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = false

				arg_231_1:SetGaussion(false)
			end

			local var_234_13 = 0.465999998152256

			if var_234_12 <= arg_231_1.time_ and arg_231_1.time_ < var_234_12 + var_234_13 then
				local var_234_14 = Color.New(1, 1, 1)

				var_234_14.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_12) / var_234_13)
				arg_231_1.mask_.color = var_234_14
			end

			if arg_231_1.time_ >= var_234_12 + var_234_13 and arg_231_1.time_ < var_234_12 + var_234_13 + arg_234_0 then
				local var_234_15 = Color.New(1, 1, 1)

				arg_231_1.mask_.enabled = false
				var_234_15.a = 0
				arg_231_1.mask_.color = var_234_15
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_16 = 1.00000000298023
			local var_234_17 = 0.275

			if 1.00000000298023 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_18 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_18:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_19 = arg_231_1:GetWordFromCfg(411181054)
				local var_234_20 = arg_231_1:FormatText(var_234_19.content)

				arg_231_1.text_.text = var_234_20

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_22 = 11 <= 0 and var_234_17 or var_234_17 * (utf8.len(var_234_20) / 11)

				if (11 <= 0 and var_234_17 or var_234_17 * (utf8.len(var_234_20) / 11)) > 0 and var_234_17 < var_234_22 then
					arg_231_1.talkMaxDuration = var_234_22
					var_234_16 = var_234_16 + 0.3

					if var_234_22 + var_234_16 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_22 + var_234_16
					end
				end

				arg_231_1.text_.text = var_234_20
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181054", "story_v_out_411181.awb") ~= 0 then
					local var_234_23 = manager.audio:GetVoiceLength("story_v_out_411181", "411181054", "story_v_out_411181.awb") / 1000

					if var_234_23 + var_234_16 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_23 + var_234_16
					end

					if var_234_19.prefab_name ~= "" and arg_231_1.actors_[var_234_19.prefab_name] ~= nil then
						local var_234_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_19.prefab_name].transform, "story_v_out_411181", "411181054", "story_v_out_411181.awb")

						arg_231_1:RecordAudio("411181054", var_234_24)
						arg_231_1:RecordAudio("411181054", var_234_24)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_411181", "411181054", "story_v_out_411181.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_411181", "411181054", "story_v_out_411181.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_25 = var_234_16 + 0.3
			local var_234_26 = math.max(var_234_17, arg_231_1.talkMaxDuration)

			if var_234_16 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_25 + var_234_26 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_25) / var_234_26

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_25 + var_234_26 and arg_231_1.time_ < var_234_25 + var_234_26 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play411181055 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 411181055
		arg_237_1.duration_ = 3.23

		local var_237_0 = {
			zh = 3.233,
			ja = 3
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play411181056(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos2078ui_story = arg_237_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["2078ui_story"].transform.position).z)
				arg_237_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["2078ui_story"].transform.localEulerAngles = arg_237_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["2078ui_story"].transform.position).z)
				arg_237_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["2078ui_story"].transform.localEulerAngles = arg_237_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["2078ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect2078ui_story == nil then
				arg_237_1.var_.characterEffect2078ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect2078ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_237_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_2)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect2078ui_story then
				arg_237_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_237_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_240_3 = 0
			local var_240_4 = 0.4

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_3 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[718].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_5 = arg_237_1:GetWordFromCfg(411181055)
				local var_240_6 = arg_237_1:FormatText(var_240_5.content)

				arg_237_1.text_.text = var_240_6

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_8 = 16 <= 0 and var_240_4 or var_240_4 * (utf8.len(var_240_6) / 16)

				if (16 <= 0 and var_240_4 or var_240_4 * (utf8.len(var_240_6) / 16)) > 0 and var_240_4 < var_240_8 then
					arg_237_1.talkMaxDuration = var_240_8

					if var_240_8 + var_240_3 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_3
					end
				end

				arg_237_1.text_.text = var_240_6
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181055", "story_v_out_411181.awb") ~= 0 then
					local var_240_9 = manager.audio:GetVoiceLength("story_v_out_411181", "411181055", "story_v_out_411181.awb") / 1000

					if var_240_9 + var_240_3 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_3
					end

					if var_240_5.prefab_name ~= "" and arg_237_1.actors_[var_240_5.prefab_name] ~= nil then
						local var_240_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_5.prefab_name].transform, "story_v_out_411181", "411181055", "story_v_out_411181.awb")

						arg_237_1:RecordAudio("411181055", var_240_10)
						arg_237_1:RecordAudio("411181055", var_240_10)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_411181", "411181055", "story_v_out_411181.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_411181", "411181055", "story_v_out_411181.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_11 = math.max(var_240_4, arg_237_1.talkMaxDuration)

			if var_240_3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_3 + var_240_11 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_3) / var_240_11

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_3 + var_240_11 and arg_237_1.time_ < var_240_3 + var_240_11 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play411181056 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 411181056
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play411181057(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 1

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(411181056).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 40 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 40)

				if (40 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 40)) > 0 and var_244_0 < var_244_3 then
					arg_241_1.talkMaxDuration = var_244_3

					if var_244_3 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_3 + 0
					end
				end

				arg_241_1.text_.text = var_244_1
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_4 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_4

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play411181057 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 411181057
		arg_245_1.duration_ = 1.6

		local var_245_0 = {
			zh = 1.6,
			ja = 1.033
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
				arg_245_0:Play411181058(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos4010ui_story = arg_245_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).z)
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles = arg_245_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_245_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4010ui_story"].transform.position).z)
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["4010ui_story"].transform.localEulerAngles = arg_245_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["4010ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect4010ui_story == nil then
				arg_245_1.var_.characterEffect4010ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect4010ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect4010ui_story then
				arg_245_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_248_4 = 0
			local var_248_5 = 0.075

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(411181057)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 3 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 3)

				if (3 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 3)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181057", "story_v_out_411181.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_411181", "411181057", "story_v_out_411181.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_out_411181", "411181057", "story_v_out_411181.awb")

						arg_245_1:RecordAudio("411181057", var_248_11)
						arg_245_1:RecordAudio("411181057", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_411181", "411181057", "story_v_out_411181.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_411181", "411181057", "story_v_out_411181.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play411181058 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 411181058
		arg_249_1.duration_ = 3.67

		local var_249_0 = {
			zh = 3.466,
			ja = 3.666
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
				arg_249_0:Play411181059(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos4010ui_story = arg_249_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["4010ui_story"].transform.position).z)
				arg_249_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["4010ui_story"].transform.localEulerAngles = arg_249_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, -1.59, -5.2)
				arg_249_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["4010ui_story"].transform.position).z)
				arg_249_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["4010ui_story"].transform.localEulerAngles = arg_249_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["4010ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect4010ui_story == nil then
				arg_249_1.var_.characterEffect4010ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect4010ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect4010ui_story then
				arg_249_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action5_1")
			end

			local var_252_4 = 0
			local var_252_5 = 0.325

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(411181058)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 13 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 13)

				if (13 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 13)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181058", "story_v_out_411181.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_411181", "411181058", "story_v_out_411181.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_411181", "411181058", "story_v_out_411181.awb")

						arg_249_1:RecordAudio("411181058", var_252_11)
						arg_249_1:RecordAudio("411181058", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_411181", "411181058", "story_v_out_411181.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_411181", "411181058", "story_v_out_411181.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play411181059 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 411181059
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play411181060(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["4010ui_story"]) and arg_253_1.var_.characterEffect4010ui_story == nil then
				arg_253_1.var_.characterEffect4010ui_story = arg_253_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["4010ui_story"]) then
				if arg_253_1.var_.characterEffect4010ui_story and not isNil(arg_253_1.actors_["4010ui_story"]) then
					arg_253_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_253_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["4010ui_story"]) and arg_253_1.var_.characterEffect4010ui_story then
				arg_253_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_253_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:AudioAction("play", "effect", "se_story_15", "se_story_15_kick", "")
			end

			local var_256_2 = arg_253_1.actors_["4010ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos4010ui_story = var_256_2.localPosition
			end

			local var_256_3 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 then
				var_256_2.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_3)
				var_256_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_2.position).x, (manager.ui.mainCamera.transform.position - var_256_2.position).y, (manager.ui.mainCamera.transform.position - var_256_2.position).z)
				var_256_2.localEulerAngles.z = 0
				var_256_2.localEulerAngles.x = 0
				var_256_2.localEulerAngles = var_256_2.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 then
				var_256_2.localPosition = Vector3.New(0, 100, 0)
				var_256_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_2.position).x, (manager.ui.mainCamera.transform.position - var_256_2.position).y, (manager.ui.mainCamera.transform.position - var_256_2.position).z)
				var_256_2.localEulerAngles.z = 0
				var_256_2.localEulerAngles.x = 0
				var_256_2.localEulerAngles = var_256_2.localEulerAngles
			end

			local var_256_4 = manager.ui.mainCamera.transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.shakeOldPos = var_256_4.localPosition
			end

			local var_256_5 = 0.6

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_5 then
				local var_256_6, var_256_7 = math.modf((arg_253_1.time_ - 0) / 0.066)

				var_256_4.localPosition = Vector3.New(var_256_7 * 0.13, var_256_7 * 0.13, var_256_7 * 0.13) + arg_253_1.var_.shakeOldPos
			end

			if arg_253_1.time_ >= 0 + var_256_5 and arg_253_1.time_ < 0 + var_256_5 + arg_256_0 then
				var_256_4.localPosition = arg_253_1.var_.shakeOldPos
			end

			local var_256_8 = 0

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.allBtn_.enabled = false
			end

			if arg_253_1.time_ >= var_256_8 + 0.6 and arg_253_1.time_ < var_256_8 + 0.6 + arg_256_0 then
				arg_253_1.allBtn_.enabled = true
			end

			local var_256_9 = 0
			local var_256_10 = 1.075

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_11 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(411181059).content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 43 <= 0 and var_256_10 or var_256_10 * (utf8.len(var_256_11) / 43)

				if (43 <= 0 and var_256_10 or var_256_10 * (utf8.len(var_256_11) / 43)) > 0 and var_256_10 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_9 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_9
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_10, arg_253_1.talkMaxDuration)

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_9) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_9 + var_256_14 and arg_253_1.time_ < var_256_9 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play411181060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 411181060
		arg_257_1.duration_ = 9.47

		local var_257_0 = {
			zh = 6.6,
			ja = 9.466
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
				arg_257_0:Play411181061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 2 < arg_257_1.time_ and arg_257_1.time_ <= 2 + arg_260_0 then
				local var_260_0 = arg_257_1.bgs_.B10c

				arg_257_1.bgs_.B10c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_260_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_1 = var_260_0:GetComponent("SpriteRenderer")

				if var_260_1 and var_260_1.sprite then
					local var_260_2 = 2 * (var_260_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_260_0.transform.localScale = Vector3.New(var_260_2 / var_260_1.sprite.bounds.size.y < var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x and var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x or var_260_2 / var_260_1.sprite.bounds.size.y, var_260_2 / var_260_1.sprite.bounds.size.y < var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x and var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x or var_260_2 / var_260_1.sprite.bounds.size.y, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "B10c" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_3 = 0

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_3 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_4 = 2

			if var_260_3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_3 + var_260_4 then
				local var_260_5 = Color.New(0, 0, 0)

				var_260_5.a = Mathf.Lerp(0, 1, (arg_257_1.time_ - var_260_3) / var_260_4)
				arg_257_1.mask_.color = var_260_5
			end

			if arg_257_1.time_ >= var_260_3 + var_260_4 and arg_257_1.time_ < var_260_3 + var_260_4 + arg_260_0 then
				local var_260_6 = Color.New(0, 0, 0)

				var_260_6.a = 1
				arg_257_1.mask_.color = var_260_6
			end

			local var_260_7 = 2

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_7 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_8 = 1.1

			if var_260_7 <= arg_257_1.time_ and arg_257_1.time_ < var_260_7 + var_260_8 then
				local var_260_9 = Color.New(0, 0, 0)

				var_260_9.a = Mathf.Lerp(1, 0, (arg_257_1.time_ - var_260_7) / var_260_8)
				arg_257_1.mask_.color = var_260_9
			end

			if arg_257_1.time_ >= var_260_7 + var_260_8 and arg_257_1.time_ < var_260_7 + var_260_8 + arg_260_0 then
				local var_260_10 = Color.New(0, 0, 0)

				arg_257_1.mask_.enabled = false
				var_260_10.a = 0
				arg_257_1.mask_.color = var_260_10
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_11 = 3.1
			local var_260_12 = 0.3

			if 3.1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_11 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_13 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_13:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_14 = arg_257_1:GetWordFromCfg(411181060)
				local var_260_15 = arg_257_1:FormatText(var_260_14.content)

				arg_257_1.text_.text = var_260_15

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_17 = 12 <= 0 and var_260_12 or var_260_12 * (utf8.len(var_260_15) / 12)

				if (12 <= 0 and var_260_12 or var_260_12 * (utf8.len(var_260_15) / 12)) > 0 and var_260_12 < var_260_17 then
					arg_257_1.talkMaxDuration = var_260_17
					var_260_11 = var_260_11 + 0.3

					if var_260_17 + var_260_11 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_17 + var_260_11
					end
				end

				arg_257_1.text_.text = var_260_15
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181060", "story_v_out_411181.awb") ~= 0 then
					local var_260_18 = manager.audio:GetVoiceLength("story_v_out_411181", "411181060", "story_v_out_411181.awb") / 1000

					if var_260_18 + var_260_11 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_18 + var_260_11
					end

					if var_260_14.prefab_name ~= "" and arg_257_1.actors_[var_260_14.prefab_name] ~= nil then
						local var_260_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_14.prefab_name].transform, "story_v_out_411181", "411181060", "story_v_out_411181.awb")

						arg_257_1:RecordAudio("411181060", var_260_19)
						arg_257_1:RecordAudio("411181060", var_260_19)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_411181", "411181060", "story_v_out_411181.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_411181", "411181060", "story_v_out_411181.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_20 = var_260_11 + 0.3
			local var_260_21 = math.max(var_260_12, arg_257_1.talkMaxDuration)

			if var_260_11 + 0.3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_20 + var_260_21 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_20) / var_260_21

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_20 + var_260_21 and arg_257_1.time_ < var_260_20 + var_260_21 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play411181061 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 411181061
		arg_263_1.duration_ = 5.33

		local var_263_0 = {
			zh = 3.3,
			ja = 5.333
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play411181062(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["2078ui_story"]) and arg_263_1.var_.characterEffect2078ui_story == nil then
				arg_263_1.var_.characterEffect2078ui_story = arg_263_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["2078ui_story"]) then
				if arg_263_1.var_.characterEffect2078ui_story and not isNil(arg_263_1.actors_["2078ui_story"]) then
					arg_263_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_263_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["2078ui_story"]) and arg_263_1.var_.characterEffect2078ui_story then
				arg_263_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_263_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_266_1 = arg_263_1.actors_["1024ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1024ui_story == nil then
				arg_263_1.var_.characterEffect1024ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1024ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1024ui_story then
				arg_263_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_266_4 = arg_263_1.actors_["1024ui_story"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1024ui_story = var_266_4.localPosition

				arg_263_1:ShowWeapon(arg_263_1.var_["1024ui_story" .. "Animator"].transform, false)
			end

			local var_266_5 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_5 then
				var_266_4.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1024ui_story, Vector3.New(0, -1, -6.05), (arg_263_1.time_ - 0) / var_266_5)
				var_266_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_4.position).x, (manager.ui.mainCamera.transform.position - var_266_4.position).y, (manager.ui.mainCamera.transform.position - var_266_4.position).z)
				var_266_4.localEulerAngles.z = 0
				var_266_4.localEulerAngles.x = 0
				var_266_4.localEulerAngles = var_266_4.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_5 and arg_263_1.time_ < 0 + var_266_5 + arg_266_0 then
				var_266_4.localPosition = Vector3.New(0, -1, -6.05)
				var_266_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_4.position).x, (manager.ui.mainCamera.transform.position - var_266_4.position).y, (manager.ui.mainCamera.transform.position - var_266_4.position).z)
				var_266_4.localEulerAngles.z = 0
				var_266_4.localEulerAngles.x = 0
				var_266_4.localEulerAngles = var_266_4.localEulerAngles
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_266_6 = 0
			local var_266_7 = 0.4

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_8 = arg_263_1:GetWordFromCfg(411181061)
				local var_266_9 = arg_263_1:FormatText(var_266_8.content)

				arg_263_1.text_.text = var_266_9

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 16 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 16)

				if (16 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 16)) > 0 and var_266_7 < var_266_11 then
					arg_263_1.talkMaxDuration = var_266_11

					if var_266_11 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_9
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181061", "story_v_out_411181.awb") ~= 0 then
					local var_266_12 = manager.audio:GetVoiceLength("story_v_out_411181", "411181061", "story_v_out_411181.awb") / 1000

					if var_266_12 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_6
					end

					if var_266_8.prefab_name ~= "" and arg_263_1.actors_[var_266_8.prefab_name] ~= nil then
						local var_266_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_8.prefab_name].transform, "story_v_out_411181", "411181061", "story_v_out_411181.awb")

						arg_263_1:RecordAudio("411181061", var_266_13)
						arg_263_1:RecordAudio("411181061", var_266_13)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_411181", "411181061", "story_v_out_411181.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_411181", "411181061", "story_v_out_411181.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_14 and arg_263_1.time_ < var_266_6 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play411181062 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 411181062
		arg_267_1.duration_ = 3

		local var_267_0 = {
			zh = 3,
			ja = 2.433
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play411181063(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["2078ui_story"]) and arg_267_1.var_.characterEffect2078ui_story == nil then
				arg_267_1.var_.characterEffect2078ui_story = arg_267_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["2078ui_story"]) then
				if arg_267_1.var_.characterEffect2078ui_story and not isNil(arg_267_1.actors_["2078ui_story"]) then
					arg_267_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["2078ui_story"]) and arg_267_1.var_.characterEffect2078ui_story then
				arg_267_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_270_2 = arg_267_1.actors_["1024ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect1024ui_story == nil then
				arg_267_1.var_.characterEffect1024ui_story = var_270_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_3 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.characterEffect1024ui_story and not isNil(var_270_2) then
					arg_267_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_3)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect1024ui_story then
				arg_267_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_270_4 = 0
			local var_270_5 = 0.35

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[710].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_6 = arg_267_1:GetWordFromCfg(411181062)
				local var_270_7 = arg_267_1:FormatText(var_270_6.content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 14 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 14)

				if (14 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 14)) > 0 and var_270_5 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_4
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181062", "story_v_out_411181.awb") ~= 0 then
					local var_270_10 = manager.audio:GetVoiceLength("story_v_out_411181", "411181062", "story_v_out_411181.awb") / 1000

					if var_270_10 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_4
					end

					if var_270_6.prefab_name ~= "" and arg_267_1.actors_[var_270_6.prefab_name] ~= nil then
						local var_270_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_6.prefab_name].transform, "story_v_out_411181", "411181062", "story_v_out_411181.awb")

						arg_267_1:RecordAudio("411181062", var_270_11)
						arg_267_1:RecordAudio("411181062", var_270_11)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_411181", "411181062", "story_v_out_411181.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_411181", "411181062", "story_v_out_411181.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_12 = math.max(var_270_5, arg_267_1.talkMaxDuration)

			if var_270_4 <= arg_267_1.time_ and arg_267_1.time_ < var_270_4 + var_270_12 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_4) / var_270_12

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_4 + var_270_12 and arg_267_1.time_ < var_270_4 + var_270_12 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play411181063 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 411181063
		arg_271_1.duration_ = 5.4

		local var_271_0 = {
			zh = 3.466,
			ja = 5.4
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
				arg_271_0:Play411181064(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1024ui_story"]) and arg_271_1.var_.characterEffect1024ui_story == nil then
				arg_271_1.var_.characterEffect1024ui_story = arg_271_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1024ui_story"]) then
				if arg_271_1.var_.characterEffect1024ui_story and not isNil(arg_271_1.actors_["1024ui_story"]) then
					arg_271_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1024ui_story"]) and arg_271_1.var_.characterEffect1024ui_story then
				arg_271_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_274_2 = 0
			local var_274_3 = 0.475

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_4 = arg_271_1:GetWordFromCfg(411181063)
				local var_274_5 = arg_271_1:FormatText(var_274_4.content)

				arg_271_1.text_.text = var_274_5

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_7 = 19 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 19)

				if (19 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 19)) > 0 and var_274_3 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_2
					end
				end

				arg_271_1.text_.text = var_274_5
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181063", "story_v_out_411181.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_out_411181", "411181063", "story_v_out_411181.awb") / 1000

					if var_274_8 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_2
					end

					if var_274_4.prefab_name ~= "" and arg_271_1.actors_[var_274_4.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_4.prefab_name].transform, "story_v_out_411181", "411181063", "story_v_out_411181.awb")

						arg_271_1:RecordAudio("411181063", var_274_9)
						arg_271_1:RecordAudio("411181063", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_411181", "411181063", "story_v_out_411181.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_411181", "411181063", "story_v_out_411181.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_3, arg_271_1.talkMaxDuration)

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_2) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_2 + var_274_10 and arg_271_1.time_ < var_274_2 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play411181064 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 411181064
		arg_275_1.duration_ = 6.67

		local var_275_0 = {
			zh = 6.666,
			ja = 6
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
				arg_275_0:Play411181065(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.925

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:GetWordFromCfg(411181064)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 37 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 37)

				if (37 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 37)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181064", "story_v_out_411181.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_411181", "411181064", "story_v_out_411181.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_411181", "411181064", "story_v_out_411181.awb")

						arg_275_1:RecordAudio("411181064", var_278_6)
						arg_275_1:RecordAudio("411181064", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_411181", "411181064", "story_v_out_411181.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_411181", "411181064", "story_v_out_411181.awb")
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
	Play411181065 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 411181065
		arg_279_1.duration_ = 7.93

		local var_279_0 = {
			zh = 4.9,
			ja = 7.933
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
			arg_279_1.auto_ = false
		end

		function arg_279_1.playNext_(arg_281_0)
			arg_279_1.onStoryFinished_()
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_282_0 = 0
			local var_282_1 = 0.675

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_2 = arg_279_1:GetWordFromCfg(411181065)
				local var_282_3 = arg_279_1:FormatText(var_282_2.content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 27 <= 0 and var_282_1 or var_282_1 * (utf8.len(var_282_3) / 27)

				if (27 <= 0 and var_282_1 or var_282_1 * (utf8.len(var_282_3) / 27)) > 0 and var_282_1 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411181", "411181065", "story_v_out_411181.awb") ~= 0 then
					local var_282_6 = manager.audio:GetVoiceLength("story_v_out_411181", "411181065", "story_v_out_411181.awb") / 1000

					if var_282_6 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_0
					end

					if var_282_2.prefab_name ~= "" and arg_279_1.actors_[var_282_2.prefab_name] ~= nil then
						local var_282_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_2.prefab_name].transform, "story_v_out_411181", "411181065", "story_v_out_411181.awb")

						arg_279_1:RecordAudio("411181065", var_282_7)
						arg_279_1:RecordAudio("411181065", var_282_7)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_411181", "411181065", "story_v_out_411181.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_411181", "411181065", "story_v_out_411181.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_8 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_8 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_8

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_8 and arg_279_1.time_ < var_282_0 + var_282_8 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST75",
		"TextureConfig/Background/B10c"
	},
	voices = {
		"story_v_out_411181.awb"
	}
}
