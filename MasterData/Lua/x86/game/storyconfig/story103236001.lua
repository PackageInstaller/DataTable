return {
	Play323601001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323601001
		arg_1_1.duration_ = 3.04

		local var_1_0 = {
			zh = 3.03870079841837,
			ja = 3.00570079841837
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
				arg_1_0:Play323601002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST32 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST32")
				var_4_0.name = "ST32"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST32 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST32

				arg_1_1.bgs_.ST32.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST32" then
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

			local var_4_9 = "10164ui_story"

			if arg_1_1.actors_["10164ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10164ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10164ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["10164ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect10164ui_story == nil then
				arg_1_1.var_.characterEffect10164ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect10164ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect10164ui_story then
				arg_1_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 1.47270079841837
			local var_4_24 = 0.15

			if 1.47270079841837 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10164")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_26 = arg_1_1:GetWordFromCfg(323601001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 6 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 6)

				if (6 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 6)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601001", "story_v_out_323601.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_323601", "323601001", "story_v_out_323601.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_323601", "323601001", "story_v_out_323601.awb")

						arg_1_1:RecordAudio("323601001", var_4_31)
						arg_1_1:RecordAudio("323601001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_323601", "323601001", "story_v_out_323601.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_323601", "323601001", "story_v_out_323601.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323601002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323601002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play323601003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10164ui_story"]) and arg_9_1.var_.characterEffect10164ui_story == nil then
				arg_9_1.var_.characterEffect10164ui_story = arg_9_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10164ui_story"]) then
				if arg_9_1.var_.characterEffect10164ui_story and not isNil(arg_9_1.actors_["10164ui_story"]) then
					arg_9_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10164ui_story"]) and arg_9_1.var_.characterEffect10164ui_story then
				arg_9_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_9_1.time_ and arg_9_1.time_ <= 0.3 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_side_104903", "se_story_side_104903_clap", "")
			end

			local var_12_2 = 0
			local var_12_3 = 1.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(323601002).content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 47 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 47)

				if (47 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 47)) > 0 and var_12_3 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 <= arg_9_1.time_ and arg_9_1.time_ < var_12_2 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_2) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_2 + var_12_7 and arg_9_1.time_ < var_12_2 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play323601003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323601003
		arg_13_1.duration_ = 12.73

		local var_13_0 = {
			zh = 8.266,
			ja = 12.733
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
				arg_13_0:Play323601004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10164ui_story = arg_13_1.actors_["10164ui_story"].transform.localPosition

				local var_16_0 = GameObjectTools.GetOrAddComponent(arg_13_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_16_0 then
					var_16_0:EnableDynamicBone(false)
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10164ui_story, Vector3.New(0, -1.08, -5.83), (arg_13_1.time_ - 0) / var_16_1)
				arg_13_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10164ui_story"].transform.position).z)
				arg_13_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10164ui_story"].transform.localEulerAngles = arg_13_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.83)
				arg_13_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10164ui_story"].transform.position).z)
				arg_13_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10164ui_story"].transform.localEulerAngles = arg_13_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_16_2 = GameObjectTools.GetOrAddComponent(arg_13_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(true)
				end
			end

			local var_16_3 = arg_13_1.actors_["10164ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect10164ui_story == nil then
				arg_13_1.var_.characterEffect10164ui_story = var_16_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_4 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 and not isNil(var_16_3) then
				if arg_13_1.var_.characterEffect10164ui_story and not isNil(var_16_3) then
					arg_13_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect10164ui_story then
				arg_13_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_16_6 = 0
			local var_16_7 = 1

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(323601003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 40 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_9) / 40)

				if (40 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_9) / 40)) > 0 and var_16_7 < var_16_11 then
					arg_13_1.talkMaxDuration = var_16_11

					if var_16_11 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601003", "story_v_out_323601.awb") ~= 0 then
					local var_16_12 = manager.audio:GetVoiceLength("story_v_out_323601", "323601003", "story_v_out_323601.awb") / 1000

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end

					if var_16_8.prefab_name ~= "" and arg_13_1.actors_[var_16_8.prefab_name] ~= nil then
						local var_16_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_8.prefab_name].transform, "story_v_out_323601", "323601003", "story_v_out_323601.awb")

						arg_13_1:RecordAudio("323601003", var_16_13)
						arg_13_1:RecordAudio("323601003", var_16_13)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_323601", "323601003", "story_v_out_323601.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_323601", "323601003", "story_v_out_323601.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_14 and arg_13_1.time_ < var_16_6 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play323601004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 323601004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play323601005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10164ui_story"]) and arg_17_1.var_.characterEffect10164ui_story == nil then
				arg_17_1.var_.characterEffect10164ui_story = arg_17_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10164ui_story"]) then
				if arg_17_1.var_.characterEffect10164ui_story and not isNil(arg_17_1.actors_["10164ui_story"]) then
					arg_17_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10164ui_story"]) and arg_17_1.var_.characterEffect10164ui_story then
				arg_17_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.85

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(323601004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 34 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 34)

				if (34 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 34)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play323601005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 323601005
		arg_21_1.duration_ = 1.13

		local var_21_0 = {
			zh = 1,
			ja = 1.133
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
				arg_21_0:Play323601006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.1

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(323601005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 4 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 4)

				if (4 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 4)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601005", "story_v_out_323601.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_323601", "323601005", "story_v_out_323601.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_323601", "323601005", "story_v_out_323601.awb")

						arg_21_1:RecordAudio("323601005", var_24_6)
						arg_21_1:RecordAudio("323601005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_323601", "323601005", "story_v_out_323601.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_323601", "323601005", "story_v_out_323601.awb")
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
	Play323601006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 323601006
		arg_25_1.duration_ = 6.7

		local var_25_0 = {
			zh = 6.7,
			ja = 6.2
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
				arg_25_0:Play323601007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10164ui_story"]) and arg_25_1.var_.characterEffect10164ui_story == nil then
				arg_25_1.var_.characterEffect10164ui_story = arg_25_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10164ui_story"]) then
				if arg_25_1.var_.characterEffect10164ui_story and not isNil(arg_25_1.actors_["10164ui_story"]) then
					arg_25_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10164ui_story"]) and arg_25_1.var_.characterEffect10164ui_story then
				arg_25_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action4816")
			end

			local var_28_2 = 0
			local var_28_3 = 0.825

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(323601006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 33 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 33)

				if (33 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 33)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601006", "story_v_out_323601.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601006", "story_v_out_323601.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_323601", "323601006", "story_v_out_323601.awb")

						arg_25_1:RecordAudio("323601006", var_28_9)
						arg_25_1:RecordAudio("323601006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_323601", "323601006", "story_v_out_323601.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_323601", "323601006", "story_v_out_323601.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play323601007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 323601007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play323601008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10164ui_story"]) and arg_29_1.var_.characterEffect10164ui_story == nil then
				arg_29_1.var_.characterEffect10164ui_story = arg_29_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10164ui_story"]) then
				if arg_29_1.var_.characterEffect10164ui_story and not isNil(arg_29_1.actors_["10164ui_story"]) then
					arg_29_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10164ui_story"]) and arg_29_1.var_.characterEffect10164ui_story then
				arg_29_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.125

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(323601007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 5 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 5)

				if (5 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 5)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play323601008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 323601008
		arg_33_1.duration_ = 7.43

		local var_33_0 = {
			zh = 7,
			ja = 7.433
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
				arg_33_0:Play323601009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10164ui_story"]) and arg_33_1.var_.characterEffect10164ui_story == nil then
				arg_33_1.var_.characterEffect10164ui_story = arg_33_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10164ui_story"]) then
				if arg_33_1.var_.characterEffect10164ui_story and not isNil(arg_33_1.actors_["10164ui_story"]) then
					arg_33_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10164ui_story"]) and arg_33_1.var_.characterEffect10164ui_story then
				arg_33_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_36_2 = 0
			local var_36_3 = 0.8

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(323601008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 32 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 32)

				if (32 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 32)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601008", "story_v_out_323601.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601008", "story_v_out_323601.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_323601", "323601008", "story_v_out_323601.awb")

						arg_33_1:RecordAudio("323601008", var_36_9)
						arg_33_1:RecordAudio("323601008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_323601", "323601008", "story_v_out_323601.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_323601", "323601008", "story_v_out_323601.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play323601009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 323601009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play323601010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10164ui_story"]) and arg_37_1.var_.characterEffect10164ui_story == nil then
				arg_37_1.var_.characterEffect10164ui_story = arg_37_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10164ui_story"]) then
				if arg_37_1.var_.characterEffect10164ui_story and not isNil(arg_37_1.actors_["10164ui_story"]) then
					arg_37_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10164ui_story"]) and arg_37_1.var_.characterEffect10164ui_story then
				arg_37_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 1.1

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(323601009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 44 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 44)

				if (44 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 44)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play323601010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 323601010
		arg_41_1.duration_ = 7.2

		local var_41_0 = {
			zh = 5.6,
			ja = 7.2
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
				arg_41_0:Play323601011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10164ui_story"]) and arg_41_1.var_.characterEffect10164ui_story == nil then
				arg_41_1.var_.characterEffect10164ui_story = arg_41_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10164ui_story"]) then
				if arg_41_1.var_.characterEffect10164ui_story and not isNil(arg_41_1.actors_["10164ui_story"]) then
					arg_41_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10164ui_story"]) and arg_41_1.var_.characterEffect10164ui_story then
				arg_41_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_44_2 = 0
			local var_44_3 = 0.575

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(323601010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 23 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 23)

				if (23 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 23)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601010", "story_v_out_323601.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601010", "story_v_out_323601.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_323601", "323601010", "story_v_out_323601.awb")

						arg_41_1:RecordAudio("323601010", var_44_9)
						arg_41_1:RecordAudio("323601010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_323601", "323601010", "story_v_out_323601.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_323601", "323601010", "story_v_out_323601.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play323601011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 323601011
		arg_45_1.duration_ = 10

		local var_45_0 = {
			zh = 10,
			ja = 9.533
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
				arg_45_0:Play323601012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_2")
			end

			local var_48_0 = 0
			local var_48_1 = 1.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(323601011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 48 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 48)

				if (48 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 48)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601011", "story_v_out_323601.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_out_323601", "323601011", "story_v_out_323601.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_out_323601", "323601011", "story_v_out_323601.awb")

						arg_45_1:RecordAudio("323601011", var_48_7)
						arg_45_1:RecordAudio("323601011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_323601", "323601011", "story_v_out_323601.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_323601", "323601011", "story_v_out_323601.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play323601012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323601012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play323601013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10164ui_story"]) and arg_49_1.var_.characterEffect10164ui_story == nil then
				arg_49_1.var_.characterEffect10164ui_story = arg_49_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10164ui_story"]) then
				if arg_49_1.var_.characterEffect10164ui_story and not isNil(arg_49_1.actors_["10164ui_story"]) then
					arg_49_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10164ui_story"]) and arg_49_1.var_.characterEffect10164ui_story then
				arg_49_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.375

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(323601012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 15 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 15)

				if (15 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 15)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play323601013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 323601013
		arg_53_1.duration_ = 2

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play323601014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10164ui_story"]) and arg_53_1.var_.characterEffect10164ui_story == nil then
				arg_53_1.var_.characterEffect10164ui_story = arg_53_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10164ui_story"]) then
				if arg_53_1.var_.characterEffect10164ui_story and not isNil(arg_53_1.actors_["10164ui_story"]) then
					arg_53_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10164ui_story"]) and arg_53_1.var_.characterEffect10164ui_story then
				arg_53_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_56_2 = 0
			local var_56_3 = 0.075

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(323601013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 3 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 3)

				if (3 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 3)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601013", "story_v_out_323601.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601013", "story_v_out_323601.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_323601", "323601013", "story_v_out_323601.awb")

						arg_53_1:RecordAudio("323601013", var_56_9)
						arg_53_1:RecordAudio("323601013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_323601", "323601013", "story_v_out_323601.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_323601", "323601013", "story_v_out_323601.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play323601014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 323601014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play323601015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10164ui_story"]) and arg_57_1.var_.characterEffect10164ui_story == nil then
				arg_57_1.var_.characterEffect10164ui_story = arg_57_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10164ui_story"]) then
				if arg_57_1.var_.characterEffect10164ui_story and not isNil(arg_57_1.actors_["10164ui_story"]) then
					arg_57_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10164ui_story"]) and arg_57_1.var_.characterEffect10164ui_story then
				arg_57_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.325

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(323601014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 13 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 13)

				if (13 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 13)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play323601015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323601015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play323601016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.475

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(323601015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 59 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 59)

				if (59 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 59)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play323601016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323601016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play323601017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.4

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(323601016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 16 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 16)

				if (16 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 16)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play323601017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323601017
		arg_69_1.duration_ = 2.13

		local var_69_0 = {
			zh = 2.133,
			ja = 1.666
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
				arg_69_0:Play323601018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10164ui_story"]) and arg_69_1.var_.characterEffect10164ui_story == nil then
				arg_69_1.var_.characterEffect10164ui_story = arg_69_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10164ui_story"]) then
				if arg_69_1.var_.characterEffect10164ui_story and not isNil(arg_69_1.actors_["10164ui_story"]) then
					arg_69_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10164ui_story"]) and arg_69_1.var_.characterEffect10164ui_story then
				arg_69_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_72_2 = 0
			local var_72_3 = 0.15

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(323601017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 6 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 6)

				if (6 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 6)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601017", "story_v_out_323601.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601017", "story_v_out_323601.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_323601", "323601017", "story_v_out_323601.awb")

						arg_69_1:RecordAudio("323601017", var_72_9)
						arg_69_1:RecordAudio("323601017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_323601", "323601017", "story_v_out_323601.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_323601", "323601017", "story_v_out_323601.awb")
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
	Play323601018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323601018
		arg_73_1.duration_ = 3.8

		local var_73_0 = {
			zh = 3.8,
			ja = 1.833
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play323601019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.actors_["1067ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1067ui_story"))) then
				local var_76_0 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_73_1.stage_.transform)

				var_76_0.name = "1067ui_story"
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1067ui_story"] = var_76_0

				local var_76_1 = var_76_0:GetComponentInChildren(typeof(CharacterEffect))

				var_76_1.enabled = true

				local var_76_2 = GameObjectTools.GetOrAddComponent(var_76_0, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(false)
				end

				arg_73_1:ShowWeapon(var_76_1.transform, false)

				arg_73_1.var_["1067ui_story" .. "Animator"] = var_76_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_73_1.var_["1067ui_story" .. "Animator"].applyRootMotion = true
				arg_73_1.var_["1067ui_story" .. "LipSync"] = var_76_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_76_3 = arg_73_1.actors_["1067ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect1067ui_story == nil then
				arg_73_1.var_.characterEffect1067ui_story = var_76_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 and not isNil(var_76_3) then
				if arg_73_1.var_.characterEffect1067ui_story and not isNil(var_76_3) then
					arg_73_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect1067ui_story then
				arg_73_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_76_6 = arg_73_1.actors_["10164ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect10164ui_story == nil then
				arg_73_1.var_.characterEffect10164ui_story = var_76_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_7 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 and not isNil(var_76_6) then
				if arg_73_1.var_.characterEffect10164ui_story and not isNil(var_76_6) then
					arg_73_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_7)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect10164ui_story then
				arg_73_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_76_8 = arg_73_1.actors_["10164ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10164ui_story = var_76_8.localPosition

				local var_76_9 = GameObjectTools.GetOrAddComponent(var_76_8.gameObject, typeof(DynamicBoneHelper))

				if var_76_9 then
					var_76_9:EnableDynamicBone(false)
				end
			end

			local var_76_10 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_10 then
				var_76_8.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10164ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_10)
				var_76_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_8.position).x, (manager.ui.mainCamera.transform.position - var_76_8.position).y, (manager.ui.mainCamera.transform.position - var_76_8.position).z)
				var_76_8.localEulerAngles.z = 0
				var_76_8.localEulerAngles.x = 0
				var_76_8.localEulerAngles = var_76_8.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_10 and arg_73_1.time_ < 0 + var_76_10 + arg_76_0 then
				var_76_8.localPosition = Vector3.New(0, 100, 0)
				var_76_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_8.position).x, (manager.ui.mainCamera.transform.position - var_76_8.position).y, (manager.ui.mainCamera.transform.position - var_76_8.position).z)
				var_76_8.localEulerAngles.z = 0
				var_76_8.localEulerAngles.x = 0
				var_76_8.localEulerAngles = var_76_8.localEulerAngles

				local var_76_11 = GameObjectTools.GetOrAddComponent(var_76_8.gameObject, typeof(DynamicBoneHelper))

				if var_76_11 then
					var_76_11:EnableDynamicBone(true)
				end
			end

			local var_76_12 = 0
			local var_76_13 = 0.25

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_14 = arg_73_1:GetWordFromCfg(323601018)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 10 <= 0 and var_76_13 or var_76_13 * (utf8.len(var_76_15) / 10)

				if (10 <= 0 and var_76_13 or var_76_13 * (utf8.len(var_76_15) / 10)) > 0 and var_76_13 < var_76_17 then
					arg_73_1.talkMaxDuration = var_76_17

					if var_76_17 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601018", "story_v_out_323601.awb") ~= 0 then
					local var_76_18 = manager.audio:GetVoiceLength("story_v_out_323601", "323601018", "story_v_out_323601.awb") / 1000

					if var_76_18 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_12
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_323601", "323601018", "story_v_out_323601.awb")

						arg_73_1:RecordAudio("323601018", var_76_19)
						arg_73_1:RecordAudio("323601018", var_76_19)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_323601", "323601018", "story_v_out_323601.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_323601", "323601018", "story_v_out_323601.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_20 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_20 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_20

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_20 and arg_73_1.time_ < var_76_12 + var_76_20 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play323601019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323601019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play323601020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10164ui_story = arg_77_1.actors_["10164ui_story"].transform.localPosition

				local var_80_0 = GameObjectTools.GetOrAddComponent(arg_77_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_80_0 then
					var_80_0:EnableDynamicBone(false)
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10164ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_1)
				arg_77_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).z)
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles = arg_77_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10164ui_story"].transform.position).z)
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10164ui_story"].transform.localEulerAngles = arg_77_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_80_2 = GameObjectTools.GetOrAddComponent(arg_77_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(true)
				end
			end

			local var_80_3 = arg_77_1.actors_["1067ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect1067ui_story == nil then
				arg_77_1.var_.characterEffect1067ui_story = var_80_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_4 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 and not isNil(var_80_3) then
				if arg_77_1.var_.characterEffect1067ui_story and not isNil(var_80_3) then
					arg_77_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_4)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect1067ui_story then
				arg_77_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_77_1.time_ and arg_77_1.time_ <= 0.200000002980232 + arg_80_0 then
				arg_77_1:AudioAction("play", "effect", "se_story_148", "se_story_148_footstep_snow04", "")
			end

			local var_80_6 = 0
			local var_80_7 = 1.225

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(323601019).content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 49 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_8) / 49)

				if (49 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_8) / 49)) > 0 and var_80_7 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_11 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_11 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_11

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_11 and arg_77_1.time_ < var_80_6 + var_80_11 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play323601020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323601020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play323601021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.075

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(323601020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 43 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 43)

				if (43 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 43)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play323601021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323601021
		arg_85_1.duration_ = 2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play323601022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if arg_85_1.actors_["10162ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10162ui_story"))) then
				local var_88_0 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_85_1.stage_.transform)

				var_88_0.name = "10162ui_story"
				var_88_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["10162ui_story"] = var_88_0

				local var_88_1 = var_88_0:GetComponentInChildren(typeof(CharacterEffect))

				var_88_1.enabled = true

				local var_88_2 = GameObjectTools.GetOrAddComponent(var_88_0, typeof(DynamicBoneHelper))

				if var_88_2 then
					var_88_2:EnableDynamicBone(false)
				end

				arg_85_1:ShowWeapon(var_88_1.transform, false)

				arg_85_1.var_["10162ui_story" .. "Animator"] = var_88_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_85_1.var_["10162ui_story" .. "Animator"].applyRootMotion = true
				arg_85_1.var_["10162ui_story" .. "LipSync"] = var_88_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_88_3 = arg_85_1.actors_["10162ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10162ui_story = var_88_3.localPosition

				local var_88_4 = GameObjectTools.GetOrAddComponent(var_88_3.gameObject, typeof(DynamicBoneHelper))

				if var_88_4 then
					var_88_4:EnableDynamicBone(false)
				end
			end

			local var_88_5 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_5 then
				var_88_3.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10162ui_story, Vector3.New(-0.74, -1.08, -5.83), (arg_85_1.time_ - 0) / var_88_5)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_5 and arg_85_1.time_ < 0 + var_88_5 + arg_88_0 then
				var_88_3.localPosition = Vector3.New(-0.74, -1.08, -5.83)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles

				local var_88_6 = GameObjectTools.GetOrAddComponent(var_88_3.gameObject, typeof(DynamicBoneHelper))

				if var_88_6 then
					var_88_6:EnableDynamicBone(true)
				end
			end

			local var_88_7 = arg_85_1.actors_["10162ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.characterEffect10162ui_story == nil then
				arg_85_1.var_.characterEffect10162ui_story = var_88_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_8 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_8 and not isNil(var_88_7) then
				if arg_85_1.var_.characterEffect10162ui_story and not isNil(var_88_7) then
					arg_85_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_8 and arg_85_1.time_ < 0 + var_88_8 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.characterEffect10162ui_story then
				arg_85_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.0589999988675118 < arg_85_1.time_ and arg_85_1.time_ <= 0.0589999988675118 + arg_88_0 then
				arg_85_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_88_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_85_1.bgmTxt_.text ~= var_88_12 and arg_85_1.bgmTxt_.text ~= "" then
						if arg_85_1.bgmTxt2_.text ~= "" then
							arg_85_1.bgmTxt_.text = arg_85_1.bgmTxt2_.text
						end

						arg_85_1.bgmTxt2_.text = var_88_12

						arg_85_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_85_1.bgmTxt_.text = var_88_12
						arg_85_1.bgmTxt2_.text = var_88_12
					end

					if arg_85_1.bgmTimer then
						arg_85_1.bgmTimer:Stop()

						arg_85_1.bgmTimer = nil
					end

					if arg_85_1.settingData.show_music_name == 1 then
						arg_85_1.musicController:SetSelectedState("show")
						arg_85_1.musicAnimator_:Play("open", 0, 0)

						if arg_85_1.settingData.music_time ~= 0 then
							arg_85_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_85_1.settingData.music_time), function()
								if arg_85_1 == nil or isNil(arg_85_1.bgmTxt_) then
									return
								end

								arg_85_1.musicController:SetSelectedState("hide")
								arg_85_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.034000001847744 < arg_85_1.time_ and arg_85_1.time_ <= 0.034000001847744 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_148", "se_story_148_horror", "")
			end

			local var_88_14 = 0
			local var_88_15 = 0.225

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_16 = arg_85_1:GetWordFromCfg(323601021)
				local var_88_17 = arg_85_1:FormatText(var_88_16.content)

				arg_85_1.text_.text = var_88_17

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_19 = 9 <= 0 and var_88_15 or var_88_15 * (utf8.len(var_88_17) / 9)

				if (9 <= 0 and var_88_15 or var_88_15 * (utf8.len(var_88_17) / 9)) > 0 and var_88_15 < var_88_19 then
					arg_85_1.talkMaxDuration = var_88_19

					if var_88_19 + var_88_14 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_19 + var_88_14
					end
				end

				arg_85_1.text_.text = var_88_17
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601021", "story_v_out_323601.awb") ~= 0 then
					local var_88_20 = manager.audio:GetVoiceLength("story_v_out_323601", "323601021", "story_v_out_323601.awb") / 1000

					if var_88_20 + var_88_14 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_20 + var_88_14
					end

					if var_88_16.prefab_name ~= "" and arg_85_1.actors_[var_88_16.prefab_name] ~= nil then
						local var_88_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_16.prefab_name].transform, "story_v_out_323601", "323601021", "story_v_out_323601.awb")

						arg_85_1:RecordAudio("323601021", var_88_21)
						arg_85_1:RecordAudio("323601021", var_88_21)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_323601", "323601021", "story_v_out_323601.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_323601", "323601021", "story_v_out_323601.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_22 = math.max(var_88_15, arg_85_1.talkMaxDuration)

			if var_88_14 <= arg_85_1.time_ and arg_85_1.time_ < var_88_14 + var_88_22 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_14) / var_88_22

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_14 + var_88_22 and arg_85_1.time_ < var_88_14 + var_88_22 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play323601022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 323601022
		arg_90_1.duration_ = 2

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play323601023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10164ui_story = arg_90_1.actors_["10164ui_story"].transform.localPosition

				local var_93_0 = GameObjectTools.GetOrAddComponent(arg_90_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_93_0 then
					var_93_0:EnableDynamicBone(false)
				end
			end

			local var_93_1 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_1 then
				arg_90_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10164ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_90_1.time_ - 0) / var_93_1)
				arg_90_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10164ui_story"].transform.position).z)
				arg_90_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["10164ui_story"].transform.localEulerAngles = arg_90_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_1 and arg_90_1.time_ < 0 + var_93_1 + arg_93_0 then
				arg_90_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.83)
				arg_90_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10164ui_story"].transform.position).z)
				arg_90_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["10164ui_story"].transform.localEulerAngles = arg_90_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_93_2 = GameObjectTools.GetOrAddComponent(arg_90_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(true)
				end
			end

			local var_93_3 = arg_90_1.actors_["10164ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_3) and arg_90_1.var_.characterEffect10164ui_story == nil then
				arg_90_1.var_.characterEffect10164ui_story = var_93_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_4 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 and not isNil(var_93_3) then
				if arg_90_1.var_.characterEffect10164ui_story and not isNil(var_93_3) then
					arg_90_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 and not isNil(var_93_3) and arg_90_1.var_.characterEffect10164ui_story then
				arg_90_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_93_6 = arg_90_1.actors_["10162ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_6) and arg_90_1.var_.characterEffect10162ui_story == nil then
				arg_90_1.var_.characterEffect10162ui_story = var_93_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_7 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 and not isNil(var_93_6) then
				if arg_90_1.var_.characterEffect10162ui_story and not isNil(var_93_6) then
					arg_90_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_90_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_7)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 and not isNil(var_93_6) and arg_90_1.var_.characterEffect10162ui_story then
				arg_90_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_90_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_93_8 = 0
			local var_93_9 = 0.2

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_10 = arg_90_1:GetWordFromCfg(323601022)
				local var_93_11 = arg_90_1:FormatText(var_93_10.content)

				arg_90_1.text_.text = var_93_11

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 8 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 8)

				if (8 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 8)) > 0 and var_93_9 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_11
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601022", "story_v_out_323601.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_323601", "323601022", "story_v_out_323601.awb") / 1000

					if var_93_14 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_8
					end

					if var_93_10.prefab_name ~= "" and arg_90_1.actors_[var_93_10.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_10.prefab_name].transform, "story_v_out_323601", "323601022", "story_v_out_323601.awb")

						arg_90_1:RecordAudio("323601022", var_93_15)
						arg_90_1:RecordAudio("323601022", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_323601", "323601022", "story_v_out_323601.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_323601", "323601022", "story_v_out_323601.awb")
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
				actorName = "10164ui_story",
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
	Play323601023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 323601023
		arg_94_1.duration_ = 4.93

		local var_94_0 = {
			zh = 3.933,
			ja = 4.933
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
				arg_94_0:Play323601024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10162ui_story"]) and arg_94_1.var_.characterEffect10162ui_story == nil then
				arg_94_1.var_.characterEffect10162ui_story = arg_94_1.actors_["10162ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10162ui_story"]) then
				if arg_94_1.var_.characterEffect10162ui_story and not isNil(arg_94_1.actors_["10162ui_story"]) then
					arg_94_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10162ui_story"]) and arg_94_1.var_.characterEffect10162ui_story then
				arg_94_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["10164ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect10164ui_story == nil then
				arg_94_1.var_.characterEffect10164ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect10164ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_94_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect10164ui_story then
				arg_94_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_94_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_97_4 = 0
			local var_97_5 = 0.45

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_6 = arg_94_1:GetWordFromCfg(323601023)
				local var_97_7 = arg_94_1:FormatText(var_97_6.content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 18 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 18)

				if (18 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 18)) > 0 and var_97_5 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601023", "story_v_out_323601.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_out_323601", "323601023", "story_v_out_323601.awb") / 1000

					if var_97_10 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_4
					end

					if var_97_6.prefab_name ~= "" and arg_94_1.actors_[var_97_6.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_6.prefab_name].transform, "story_v_out_323601", "323601023", "story_v_out_323601.awb")

						arg_94_1:RecordAudio("323601023", var_97_11)
						arg_94_1:RecordAudio("323601023", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_323601", "323601023", "story_v_out_323601.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_323601", "323601023", "story_v_out_323601.awb")
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
	Play323601024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 323601024
		arg_98_1.duration_ = 3.2

		local var_98_0 = {
			zh = 2.966,
			ja = 3.2
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
				arg_98_0:Play323601025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["10164ui_story"]) and arg_98_1.var_.characterEffect10164ui_story == nil then
				arg_98_1.var_.characterEffect10164ui_story = arg_98_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["10164ui_story"]) then
				if arg_98_1.var_.characterEffect10164ui_story and not isNil(arg_98_1.actors_["10164ui_story"]) then
					arg_98_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["10164ui_story"]) and arg_98_1.var_.characterEffect10164ui_story then
				arg_98_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["10162ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect10162ui_story == nil then
				arg_98_1.var_.characterEffect10162ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect10162ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect10162ui_story then
				arg_98_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_101_4 = 0
			local var_101_5 = 0.4

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(323601024)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 16 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 16)

				if (16 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 16)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601024", "story_v_out_323601.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_323601", "323601024", "story_v_out_323601.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_323601", "323601024", "story_v_out_323601.awb")

						arg_98_1:RecordAudio("323601024", var_101_11)
						arg_98_1:RecordAudio("323601024", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_323601", "323601024", "story_v_out_323601.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_323601", "323601024", "story_v_out_323601.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play323601025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 323601025
		arg_102_1.duration_ = 7.93

		local var_102_0 = {
			zh = 6.866,
			ja = 7.933
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
				arg_102_0:Play323601026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10162ui_story"]) and arg_102_1.var_.characterEffect10162ui_story == nil then
				arg_102_1.var_.characterEffect10162ui_story = arg_102_1.actors_["10162ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10162ui_story"]) then
				if arg_102_1.var_.characterEffect10162ui_story and not isNil(arg_102_1.actors_["10162ui_story"]) then
					arg_102_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10162ui_story"]) and arg_102_1.var_.characterEffect10162ui_story then
				arg_102_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["10164ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect10164ui_story == nil then
				arg_102_1.var_.characterEffect10164ui_story = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect10164ui_story and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect10164ui_story then
				arg_102_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_2")
			end

			local var_105_4 = 0
			local var_105_5 = 0.85

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(323601025)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 34 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 34)

				if (34 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 34)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601025", "story_v_out_323601.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_323601", "323601025", "story_v_out_323601.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_323601", "323601025", "story_v_out_323601.awb")

						arg_102_1:RecordAudio("323601025", var_105_11)
						arg_102_1:RecordAudio("323601025", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_323601", "323601025", "story_v_out_323601.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_323601", "323601025", "story_v_out_323601.awb")
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
	Play323601026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 323601026
		arg_106_1.duration_ = 5.53

		local var_106_0 = {
			zh = 2.566,
			ja = 5.533
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
				arg_106_0:Play323601027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.2

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:GetWordFromCfg(323601026)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 8 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 8)

				if (8 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 8)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601026", "story_v_out_323601.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_323601", "323601026", "story_v_out_323601.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_323601", "323601026", "story_v_out_323601.awb")

						arg_106_1:RecordAudio("323601026", var_109_6)
						arg_106_1:RecordAudio("323601026", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_323601", "323601026", "story_v_out_323601.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_323601", "323601026", "story_v_out_323601.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play323601027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 323601027
		arg_110_1.duration_ = 2.03

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play323601028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if arg_110_1.bgs_.STblack == nil then
				local var_113_0 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_113_0.name = "STblack"
				var_113_0.transform.parent = arg_110_1.stage_.transform
				var_113_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_.STblack = var_113_0
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				local var_113_1 = arg_110_1.bgs_.STblack

				arg_110_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_113_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_2 = var_113_1:GetComponent("SpriteRenderer")

				if var_113_2 and var_113_2.sprite then
					local var_113_3 = 2 * (var_113_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_113_1.transform.localScale = Vector3.New(var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "STblack" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_4 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			if arg_110_1.time_ >= var_113_4 + 0.3 and arg_110_1.time_ < var_113_4 + 0.3 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_5 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_6 = 2

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 then
				local var_113_7 = Color.New(0, 0, 0)

				var_113_7.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_5) / var_113_6)
				arg_110_1.mask_.color = var_113_7
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 then
				local var_113_8 = Color.New(0, 0, 0)

				arg_110_1.mask_.enabled = false
				var_113_8.a = 0
				arg_110_1.mask_.color = var_113_8
			end

			local var_113_9 = arg_110_1.actors_["10162ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10162ui_story = var_113_9.localPosition

				local var_113_10 = GameObjectTools.GetOrAddComponent(var_113_9.gameObject, typeof(DynamicBoneHelper))

				if var_113_10 then
					var_113_10:EnableDynamicBone(false)
				end
			end

			local var_113_11 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_11 then
				var_113_9.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_11)
				var_113_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_9.position).x, (manager.ui.mainCamera.transform.position - var_113_9.position).y, (manager.ui.mainCamera.transform.position - var_113_9.position).z)
				var_113_9.localEulerAngles.z = 0
				var_113_9.localEulerAngles.x = 0
				var_113_9.localEulerAngles = var_113_9.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_11 and arg_110_1.time_ < 0 + var_113_11 + arg_113_0 then
				var_113_9.localPosition = Vector3.New(0, 100, 0)
				var_113_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_9.position).x, (manager.ui.mainCamera.transform.position - var_113_9.position).y, (manager.ui.mainCamera.transform.position - var_113_9.position).z)
				var_113_9.localEulerAngles.z = 0
				var_113_9.localEulerAngles.x = 0
				var_113_9.localEulerAngles = var_113_9.localEulerAngles

				local var_113_12 = GameObjectTools.GetOrAddComponent(var_113_9.gameObject, typeof(DynamicBoneHelper))

				if var_113_12 then
					var_113_12:EnableDynamicBone(true)
				end
			end

			local var_113_13 = arg_110_1.actors_["10164ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10164ui_story = var_113_13.localPosition

				local var_113_14 = GameObjectTools.GetOrAddComponent(var_113_13.gameObject, typeof(DynamicBoneHelper))

				if var_113_14 then
					var_113_14:EnableDynamicBone(false)
				end
			end

			local var_113_15 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_15 then
				var_113_13.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10164ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_15)
				var_113_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_13.position).x, (manager.ui.mainCamera.transform.position - var_113_13.position).y, (manager.ui.mainCamera.transform.position - var_113_13.position).z)
				var_113_13.localEulerAngles.z = 0
				var_113_13.localEulerAngles.x = 0
				var_113_13.localEulerAngles = var_113_13.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_15 and arg_110_1.time_ < 0 + var_113_15 + arg_113_0 then
				var_113_13.localPosition = Vector3.New(0, 100, 0)
				var_113_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_13.position).x, (manager.ui.mainCamera.transform.position - var_113_13.position).y, (manager.ui.mainCamera.transform.position - var_113_13.position).z)
				var_113_13.localEulerAngles.z = 0
				var_113_13.localEulerAngles.x = 0
				var_113_13.localEulerAngles = var_113_13.localEulerAngles

				local var_113_16 = GameObjectTools.GetOrAddComponent(var_113_13.gameObject, typeof(DynamicBoneHelper))

				if var_113_16 then
					var_113_16:EnableDynamicBone(true)
				end
			end

			local var_113_17 = arg_110_1.actors_["1067ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_17) and arg_110_1.var_.characterEffect1067ui_story == nil then
				arg_110_1.var_.characterEffect1067ui_story = var_113_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_18 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_18 and not isNil(var_113_17) then
				if arg_110_1.var_.characterEffect1067ui_story and not isNil(var_113_17) then
					arg_110_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_18)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_18 and arg_110_1.time_ < 0 + var_113_18 + arg_113_0 and not isNil(var_113_17) and arg_110_1.var_.characterEffect1067ui_story then
				arg_110_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.fswbg_:SetActive(true)
				arg_110_1.dialog_:SetActive(false)

				arg_110_1.fswtw_.percent = 0
				arg_110_1.fswt_.text = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.fswt_)

				arg_110_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_110_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_110_1.fswtw_:SetDirty()

				arg_110_1.typewritterCharCountI18N = 0

				SetActive(arg_110_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_110_1:ShowNextGo(false)
			end

			local var_113_19 = 1.35

			if 1.35 < arg_110_1.time_ and arg_110_1.time_ <= var_113_19 + arg_113_0 then
				arg_110_1.var_.oldValueTypewriter = arg_110_1.fswtw_.percent

				SetActive(arg_110_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_110_1:ShowNextGo(false)
			end

			local var_113_20 = 0
			local var_113_21 = 0.65
			local var_113_22, var_113_23 = arg_110_1:GetPercentByPara(arg_110_1:FormatText(arg_110_1:GetWordFromCfg(102).content), 1)

			if var_113_19 < arg_110_1.time_ and arg_110_1.time_ <= var_113_19 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				local var_113_24 = var_113_20 <= 0 and var_113_21 or var_113_21 * ((var_113_23 - arg_110_1.typewritterCharCountI18N) / var_113_20)

				if (var_113_20 <= 0 and var_113_21 or var_113_21 * ((var_113_23 - arg_110_1.typewritterCharCountI18N) / var_113_20)) > 0 and var_113_21 < var_113_24 then
					arg_110_1.talkMaxDuration = var_113_24

					if var_113_24 + var_113_19 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_24 + var_113_19
					end
				end
			end

			local var_113_25 = math.max(0.65, arg_110_1.talkMaxDuration)

			if var_113_19 <= arg_110_1.time_ and arg_110_1.time_ < var_113_19 + var_113_25 then
				arg_110_1.fswtw_.percent = Mathf.Lerp(arg_110_1.var_.oldValueTypewriter, var_113_22, (arg_110_1.time_ - var_113_19) / var_113_25)
				arg_110_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_110_1.fswtw_:SetDirty()
			end

			if arg_110_1.time_ >= var_113_19 + var_113_25 and arg_110_1.time_ < var_113_19 + var_113_25 + arg_113_0 then
				arg_110_1.fswtw_.percent = var_113_22

				arg_110_1.fswtw_:SetDirty()
				arg_110_1:ShowNextGo(true)

				arg_110_1.typewritterCharCountI18N = var_113_23
			end

			if 0.034000001847744 < arg_110_1.time_ and arg_110_1.time_ <= 0.034000001847744 + arg_113_0 then
				arg_110_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1.03400000184774 < arg_110_1.time_ and arg_110_1.time_ <= 1.03400000184774 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_148", "se_story_148_bell_temple_china03_loop", "")
			end

			if 0.0166666666666667 < arg_110_1.time_ and arg_110_1.time_ <= 0.0166666666666667 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum03", "")
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play323601028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 323601028
		arg_114_1.duration_ = 7

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play323601029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if arg_114_1.bgs_.J21h == nil then
				local var_117_0 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21h")
				var_117_0.name = "J21h"
				var_117_0.transform.parent = arg_114_1.stage_.transform
				var_117_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_.J21h = var_117_0
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				local var_117_1 = arg_114_1.bgs_.J21h

				arg_114_1.bgs_.J21h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_117_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_2 = var_117_1:GetComponent("SpriteRenderer")

				if var_117_2 and var_117_2.sprite then
					local var_117_3 = 2 * (var_117_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_117_1.transform.localScale = Vector3.New(var_117_3 / var_117_2.sprite.bounds.size.y < var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x and var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x or var_117_3 / var_117_2.sprite.bounds.size.y, var_117_3 / var_117_2.sprite.bounds.size.y < var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x and var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x or var_117_3 / var_117_2.sprite.bounds.size.y, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "J21h" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_4 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			if arg_114_1.time_ >= var_117_4 + 0.3 and arg_114_1.time_ < var_117_4 + 0.3 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			local var_117_5 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_6 = 2

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 then
				local var_117_7 = Color.New(0, 0, 0)

				var_117_7.a = Mathf.Lerp(1, 0, (arg_114_1.time_ - var_117_5) / var_117_6)
				arg_114_1.mask_.color = var_117_7
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 then
				local var_117_8 = Color.New(0, 0, 0)

				arg_114_1.mask_.enabled = false
				var_117_8.a = 0
				arg_114_1.mask_.color = var_117_8
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.fswbg_:SetActive(false)
				arg_114_1.dialog_:SetActive(false)
				SetActive(arg_114_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_114_1:ShowNextGo(false)
			end

			if 0.0166666666666667 < arg_114_1.time_ and arg_114_1.time_ <= 0.0166666666666667 + arg_117_0 then
				arg_114_1.fswbg_:SetActive(false)
				arg_114_1.dialog_:SetActive(false)
				SetActive(arg_114_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_114_1:ShowNextGo(false)
			end

			if 0.1 < arg_114_1.time_ and arg_114_1.time_ <= 0.1 + arg_117_0 then
				arg_114_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_117_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_12 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_12

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_12
						arg_114_1.bgmTxt2_.text = var_117_12
					end

					if arg_114_1.bgmTimer then
						arg_114_1.bgmTimer:Stop()

						arg_114_1.bgmTimer = nil
					end

					if arg_114_1.settingData.show_music_name == 1 then
						arg_114_1.musicController:SetSelectedState("show")
						arg_114_1.musicAnimator_:Play("open", 0, 0)

						if arg_114_1.settingData.music_time ~= 0 then
							arg_114_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_114_1.settingData.music_time), function()
								if arg_114_1 == nil or isNil(arg_114_1.bgmTxt_) then
									return
								end

								arg_114_1.musicController:SetSelectedState("hide")
								arg_114_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_114_1.time_ and arg_114_1.time_ <= 0.433333333333333 + arg_117_0 then
				arg_114_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_117_15 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if "" ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_15 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_15

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_15
						arg_114_1.bgmTxt2_.text = var_117_15
					end

					if arg_114_1.bgmTimer then
						arg_114_1.bgmTimer:Stop()

						arg_114_1.bgmTimer = nil
					end

					if arg_114_1.settingData.show_music_name == 1 then
						arg_114_1.musicController:SetSelectedState("show")
						arg_114_1.musicAnimator_:Play("open", 0, 0)

						if arg_114_1.settingData.music_time ~= 0 then
							arg_114_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_114_1.settingData.music_time), function()
								if arg_114_1 == nil or isNil(arg_114_1.bgmTxt_) then
									return
								end

								arg_114_1.musicController:SetSelectedState("hide")
								arg_114_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_16 = 2
			local var_117_17 = 0.925

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_18 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_18:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_114_1.dialogCg_.alpha = arg_120_0
				end))
				var_117_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_19 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(323601028).content)

				arg_114_1.text_.text = var_117_19

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_21 = 37 <= 0 and var_117_17 or var_117_17 * (utf8.len(var_117_19) / 37)

				if (37 <= 0 and var_117_17 or var_117_17 * (utf8.len(var_117_19) / 37)) > 0 and var_117_17 < var_117_21 then
					arg_114_1.talkMaxDuration = var_117_21
					var_117_16 = var_117_16 + 0.3

					if var_117_21 + var_117_16 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_21 + var_117_16
					end
				end

				arg_114_1.text_.text = var_117_19
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = var_117_16 + 0.3
			local var_117_23 = math.max(var_117_17, arg_114_1.talkMaxDuration)

			if var_117_16 + 0.3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_22 + var_117_23 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_22) / var_117_23

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_22 + var_117_23 and arg_114_1.time_ < var_117_22 + var_117_23 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play323601029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 323601029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play323601030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 1.75

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(323601029).content)

				arg_122_1.text_.text = var_125_1

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_3 = 70 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 70)

				if (70 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 70)) > 0 and var_125_0 < var_125_3 then
					arg_122_1.talkMaxDuration = var_125_3

					if var_125_3 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_3 + 0
					end
				end

				arg_122_1.text_.text = var_125_1
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_4 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_4

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play323601030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 323601030
		arg_126_1.duration_ = 3.4

		local var_126_0 = {
			zh = 3.3,
			ja = 3.4
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
				arg_126_0:Play323601031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.3

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_1 = arg_126_1:GetWordFromCfg(323601030)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 12 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 12)

				if (12 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 12)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601030", "story_v_out_323601.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_323601", "323601030", "story_v_out_323601.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_323601", "323601030", "story_v_out_323601.awb")

						arg_126_1:RecordAudio("323601030", var_129_6)
						arg_126_1:RecordAudio("323601030", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_323601", "323601030", "story_v_out_323601.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_323601", "323601030", "story_v_out_323601.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play323601031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 323601031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play323601032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0.1 < arg_130_1.time_ and arg_130_1.time_ <= 0.1 + arg_133_0 then
				arg_130_1:AudioAction("play", "effect", "se_story_148", "se_story_148_horn", "")
			end

			local var_133_1 = 0
			local var_133_2 = 1.4

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_3 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(323601031).content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 56 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 56)

				if (56 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 56)) > 0 and var_133_2 < var_133_5 then
					arg_130_1.talkMaxDuration = var_133_5

					if var_133_5 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + var_133_1
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_6 = math.max(var_133_2, arg_130_1.talkMaxDuration)

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_6 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_1) / var_133_6

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_1 + var_133_6 and arg_130_1.time_ < var_133_1 + var_133_6 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play323601032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 323601032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play323601033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0.1 < arg_134_1.time_ and arg_134_1.time_ <= 0.1 + arg_137_0 then
				arg_134_1:AudioAction("play", "effect", "se_story_145", "se_story_145_footstep", "")
			end

			local var_137_1 = 0
			local var_137_2 = 0.2

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(323601032).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 8 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 8)

				if (8 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 8)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_6 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_6 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_6

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_6 and arg_134_1.time_ < var_137_1 + var_137_6 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play323601033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 323601033
		arg_138_1.duration_ = 1.27

		local var_138_0 = {
			zh = 1,
			ja = 1.266
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play323601034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["10164ui_story"]) and arg_138_1.var_.characterEffect10164ui_story == nil then
				arg_138_1.var_.characterEffect10164ui_story = arg_138_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["10164ui_story"]) then
				if arg_138_1.var_.characterEffect10164ui_story and not isNil(arg_138_1.actors_["10164ui_story"]) then
					arg_138_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["10164ui_story"]) and arg_138_1.var_.characterEffect10164ui_story then
				arg_138_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_141_2 = 0
			local var_141_3 = 0.1

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_2 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10164")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_4 = arg_138_1:GetWordFromCfg(323601033)
				local var_141_5 = arg_138_1:FormatText(var_141_4.content)

				arg_138_1.text_.text = var_141_5

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_7 = 4 <= 0 and var_141_3 or var_141_3 * (utf8.len(var_141_5) / 4)

				if (4 <= 0 and var_141_3 or var_141_3 * (utf8.len(var_141_5) / 4)) > 0 and var_141_3 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_2 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_2
					end
				end

				arg_138_1.text_.text = var_141_5
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601033", "story_v_out_323601.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601033", "story_v_out_323601.awb") / 1000

					if var_141_8 + var_141_2 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_2
					end

					if var_141_4.prefab_name ~= "" and arg_138_1.actors_[var_141_4.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_4.prefab_name].transform, "story_v_out_323601", "323601033", "story_v_out_323601.awb")

						arg_138_1:RecordAudio("323601033", var_141_9)
						arg_138_1:RecordAudio("323601033", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_323601", "323601033", "story_v_out_323601.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_323601", "323601033", "story_v_out_323601.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_3, arg_138_1.talkMaxDuration)

			if var_141_2 <= arg_138_1.time_ and arg_138_1.time_ < var_141_2 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_2) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_2 + var_141_10 and arg_138_1.time_ < var_141_2 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play323601034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 323601034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play323601035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["10164ui_story"]) and arg_142_1.var_.characterEffect10164ui_story == nil then
				arg_142_1.var_.characterEffect10164ui_story = arg_142_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["10164ui_story"]) then
				if arg_142_1.var_.characterEffect10164ui_story and not isNil(arg_142_1.actors_["10164ui_story"]) then
					arg_142_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_142_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["10164ui_story"]) and arg_142_1.var_.characterEffect10164ui_story then
				arg_142_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_142_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_145_1 = 0
			local var_145_2 = 1.175

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(323601034).content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 47 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 47)

				if (47 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 47)) > 0 and var_145_2 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_6 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_6 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_6

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_6 and arg_142_1.time_ < var_145_1 + var_145_6 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play323601035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 323601035
		arg_146_1.duration_ = 12.6

		local var_146_0 = {
			zh = 7.466,
			ja = 12.6
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play323601036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos10164ui_story = arg_146_1.actors_["10164ui_story"].transform.localPosition

				local var_149_0 = GameObjectTools.GetOrAddComponent(arg_146_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_149_0 then
					var_149_0:EnableDynamicBone(false)
				end
			end

			local var_149_1 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_1 then
				arg_146_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10164ui_story, Vector3.New(0, -1.08, -5.83), (arg_146_1.time_ - 0) / var_149_1)
				arg_146_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10164ui_story"].transform.position).z)
				arg_146_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["10164ui_story"].transform.localEulerAngles = arg_146_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_1 and arg_146_1.time_ < 0 + var_149_1 + arg_149_0 then
				arg_146_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.83)
				arg_146_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10164ui_story"].transform.position).z)
				arg_146_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["10164ui_story"].transform.localEulerAngles = arg_146_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_149_2 = GameObjectTools.GetOrAddComponent(arg_146_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_149_2 then
					var_149_2:EnableDynamicBone(true)
				end
			end

			local var_149_3 = arg_146_1.actors_["10164ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_3) and arg_146_1.var_.characterEffect10164ui_story == nil then
				arg_146_1.var_.characterEffect10164ui_story = var_149_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_4 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 and not isNil(var_149_3) then
				if arg_146_1.var_.characterEffect10164ui_story and not isNil(var_149_3) then
					arg_146_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 and not isNil(var_149_3) and arg_146_1.var_.characterEffect10164ui_story then
				arg_146_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_149_6 = 0
			local var_149_7 = 1

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_8 = arg_146_1:GetWordFromCfg(323601035)
				local var_149_9 = arg_146_1:FormatText(var_149_8.content)

				arg_146_1.text_.text = var_149_9

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 40 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_9) / 40)

				if (40 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_9) / 40)) > 0 and var_149_7 < var_149_11 then
					arg_146_1.talkMaxDuration = var_149_11

					if var_149_11 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_11 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_9
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601035", "story_v_out_323601.awb") ~= 0 then
					local var_149_12 = manager.audio:GetVoiceLength("story_v_out_323601", "323601035", "story_v_out_323601.awb") / 1000

					if var_149_12 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_12 + var_149_6
					end

					if var_149_8.prefab_name ~= "" and arg_146_1.actors_[var_149_8.prefab_name] ~= nil then
						local var_149_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_8.prefab_name].transform, "story_v_out_323601", "323601035", "story_v_out_323601.awb")

						arg_146_1:RecordAudio("323601035", var_149_13)
						arg_146_1:RecordAudio("323601035", var_149_13)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_323601", "323601035", "story_v_out_323601.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_323601", "323601035", "story_v_out_323601.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_14 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_14 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_14

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_14 and arg_146_1.time_ < var_149_6 + var_149_14 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play323601036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 323601036
		arg_150_1.duration_ = 2.83

		local var_150_0 = {
			zh = 2.733,
			ja = 2.833
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play323601037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.375

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:GetWordFromCfg(323601036)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 15 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 15)

				if (15 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 15)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601036", "story_v_out_323601.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_323601", "323601036", "story_v_out_323601.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_323601", "323601036", "story_v_out_323601.awb")

						arg_150_1:RecordAudio("323601036", var_153_6)
						arg_150_1:RecordAudio("323601036", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_323601", "323601036", "story_v_out_323601.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_323601", "323601036", "story_v_out_323601.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play323601037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 323601037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play323601038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["10164ui_story"]) and arg_154_1.var_.characterEffect10164ui_story == nil then
				arg_154_1.var_.characterEffect10164ui_story = arg_154_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["10164ui_story"]) then
				if arg_154_1.var_.characterEffect10164ui_story and not isNil(arg_154_1.actors_["10164ui_story"]) then
					arg_154_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_154_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_0)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["10164ui_story"]) and arg_154_1.var_.characterEffect10164ui_story then
				arg_154_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_154_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_157_1 = 0
			local var_157_2 = 0.8

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(323601037).content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 32 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 32)

				if (32 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 32)) > 0 and var_157_2 < var_157_5 then
					arg_154_1.talkMaxDuration = var_157_5

					if var_157_5 + var_157_1 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + var_157_1
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_6 = math.max(var_157_2, arg_154_1.talkMaxDuration)

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_6 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_1) / var_157_6

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_1 + var_157_6 and arg_154_1.time_ < var_157_1 + var_157_6 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play323601038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 323601038
		arg_158_1.duration_ = 7.97

		local var_158_0 = {
			zh = 7.966,
			ja = 7
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
				arg_158_0:Play323601039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["10164ui_story"]) and arg_158_1.var_.characterEffect10164ui_story == nil then
				arg_158_1.var_.characterEffect10164ui_story = arg_158_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["10164ui_story"]) then
				if arg_158_1.var_.characterEffect10164ui_story and not isNil(arg_158_1.actors_["10164ui_story"]) then
					arg_158_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["10164ui_story"]) and arg_158_1.var_.characterEffect10164ui_story then
				arg_158_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action29_1")
			end

			local var_161_2 = 0
			local var_161_3 = 0.925

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_4 = arg_158_1:GetWordFromCfg(323601038)
				local var_161_5 = arg_158_1:FormatText(var_161_4.content)

				arg_158_1.text_.text = var_161_5

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_7 = 37 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 37)

				if (37 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 37)) > 0 and var_161_3 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_5
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601038", "story_v_out_323601.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601038", "story_v_out_323601.awb") / 1000

					if var_161_8 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_2
					end

					if var_161_4.prefab_name ~= "" and arg_158_1.actors_[var_161_4.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_4.prefab_name].transform, "story_v_out_323601", "323601038", "story_v_out_323601.awb")

						arg_158_1:RecordAudio("323601038", var_161_9)
						arg_158_1:RecordAudio("323601038", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_323601", "323601038", "story_v_out_323601.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_323601", "323601038", "story_v_out_323601.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_10 and arg_158_1.time_ < var_161_2 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play323601039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 323601039
		arg_162_1.duration_ = 3.43

		local var_162_0 = {
			zh = 3.433,
			ja = 2.233
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play323601040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["10164ui_story"]) and arg_162_1.var_.characterEffect10164ui_story == nil then
				arg_162_1.var_.characterEffect10164ui_story = arg_162_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["10164ui_story"]) then
				if arg_162_1.var_.characterEffect10164ui_story and not isNil(arg_162_1.actors_["10164ui_story"]) then
					arg_162_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_162_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["10164ui_story"]) and arg_162_1.var_.characterEffect10164ui_story then
				arg_162_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_162_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.325

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(323601039)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 13 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 13)

				if (13 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 13)) > 0 and var_165_2 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601039", "story_v_out_323601.awb") ~= 0 then
					local var_165_7 = manager.audio:GetVoiceLength("story_v_out_323601", "323601039", "story_v_out_323601.awb") / 1000

					if var_165_7 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_1
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_323601", "323601039", "story_v_out_323601.awb")

						arg_162_1:RecordAudio("323601039", var_165_8)
						arg_162_1:RecordAudio("323601039", var_165_8)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_323601", "323601039", "story_v_out_323601.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_323601", "323601039", "story_v_out_323601.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_9 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_9 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_9

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_9 and arg_162_1.time_ < var_165_1 + var_165_9 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play323601040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 323601040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play323601041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.575

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_1 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(323601040).content)

				arg_166_1.text_.text = var_169_1

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_3 = 23 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 23)

				if (23 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 23)) > 0 and var_169_0 < var_169_3 then
					arg_166_1.talkMaxDuration = var_169_3

					if var_169_3 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_3 + 0
					end
				end

				arg_166_1.text_.text = var_169_1
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_4 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_4

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play323601041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 323601041
		arg_170_1.duration_ = 4.17

		local var_170_0 = {
			zh = 3.166,
			ja = 4.166
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play323601042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10164ui_story"]) and arg_170_1.var_.characterEffect10164ui_story == nil then
				arg_170_1.var_.characterEffect10164ui_story = arg_170_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10164ui_story"]) then
				if arg_170_1.var_.characterEffect10164ui_story and not isNil(arg_170_1.actors_["10164ui_story"]) then
					arg_170_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10164ui_story"]) and arg_170_1.var_.characterEffect10164ui_story then
				arg_170_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action29_2")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_173_2 = 0
			local var_173_3 = 0.3

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_4 = arg_170_1:GetWordFromCfg(323601041)
				local var_173_5 = arg_170_1:FormatText(var_173_4.content)

				arg_170_1.text_.text = var_173_5

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_7 = 12 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_5) / 12)

				if (12 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_5) / 12)) > 0 and var_173_3 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_2
					end
				end

				arg_170_1.text_.text = var_173_5
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601041", "story_v_out_323601.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601041", "story_v_out_323601.awb") / 1000

					if var_173_8 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_2
					end

					if var_173_4.prefab_name ~= "" and arg_170_1.actors_[var_173_4.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_4.prefab_name].transform, "story_v_out_323601", "323601041", "story_v_out_323601.awb")

						arg_170_1:RecordAudio("323601041", var_173_9)
						arg_170_1:RecordAudio("323601041", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_323601", "323601041", "story_v_out_323601.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_323601", "323601041", "story_v_out_323601.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_3, arg_170_1.talkMaxDuration)

			if var_173_2 <= arg_170_1.time_ and arg_170_1.time_ < var_173_2 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_2) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_2 + var_173_10 and arg_170_1.time_ < var_173_2 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play323601042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 323601042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play323601043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["10164ui_story"]) and arg_174_1.var_.characterEffect10164ui_story == nil then
				arg_174_1.var_.characterEffect10164ui_story = arg_174_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["10164ui_story"]) then
				if arg_174_1.var_.characterEffect10164ui_story and not isNil(arg_174_1.actors_["10164ui_story"]) then
					arg_174_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_0)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10164ui_story"]) and arg_174_1.var_.characterEffect10164ui_story then
				arg_174_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_177_1 = 0
			local var_177_2 = 0.475

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(323601042).content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 19 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 19)

				if (19 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 19)) > 0 and var_177_2 < var_177_5 then
					arg_174_1.talkMaxDuration = var_177_5

					if var_177_5 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + var_177_1
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_6 = math.max(var_177_2, arg_174_1.talkMaxDuration)

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_6 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_1) / var_177_6

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_1 + var_177_6 and arg_174_1.time_ < var_177_1 + var_177_6 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play323601043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 323601043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play323601044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 1.1

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(323601043).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 44 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 44)

				if (44 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 44)) > 0 and var_181_0 < var_181_3 then
					arg_178_1.talkMaxDuration = var_181_3

					if var_181_3 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_3 + 0
					end
				end

				arg_178_1.text_.text = var_181_1
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_4 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_4

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play323601044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 323601044
		arg_182_1.duration_ = 2.7

		local var_182_0 = {
			zh = 2.7,
			ja = 1.999999999999
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play323601045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["10164ui_story"]) and arg_182_1.var_.characterEffect10164ui_story == nil then
				arg_182_1.var_.characterEffect10164ui_story = arg_182_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["10164ui_story"]) then
				if arg_182_1.var_.characterEffect10164ui_story and not isNil(arg_182_1.actors_["10164ui_story"]) then
					arg_182_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["10164ui_story"]) and arg_182_1.var_.characterEffect10164ui_story then
				arg_182_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_185_2 = 0
			local var_185_3 = 0.275

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:GetWordFromCfg(323601044)
				local var_185_5 = arg_182_1:FormatText(var_185_4.content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 11 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 11)

				if (11 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 11)) > 0 and var_185_3 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601044", "story_v_out_323601.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601044", "story_v_out_323601.awb") / 1000

					if var_185_8 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_2
					end

					if var_185_4.prefab_name ~= "" and arg_182_1.actors_[var_185_4.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_4.prefab_name].transform, "story_v_out_323601", "323601044", "story_v_out_323601.awb")

						arg_182_1:RecordAudio("323601044", var_185_9)
						arg_182_1:RecordAudio("323601044", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_323601", "323601044", "story_v_out_323601.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_323601", "323601044", "story_v_out_323601.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_3, arg_182_1.talkMaxDuration)

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_2) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_2 + var_185_10 and arg_182_1.time_ < var_185_2 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play323601045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 323601045
		arg_186_1.duration_ = 10.7

		local var_186_0 = {
			zh = 7.233,
			ja = 10.7
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play323601046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_1")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_189_0 = 0
			local var_189_1 = 0.85

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_2 = arg_186_1:GetWordFromCfg(323601045)
				local var_189_3 = arg_186_1:FormatText(var_189_2.content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 34 <= 0 and var_189_1 or var_189_1 * (utf8.len(var_189_3) / 34)

				if (34 <= 0 and var_189_1 or var_189_1 * (utf8.len(var_189_3) / 34)) > 0 and var_189_1 < var_189_5 then
					arg_186_1.talkMaxDuration = var_189_5

					if var_189_5 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601045", "story_v_out_323601.awb") ~= 0 then
					local var_189_6 = manager.audio:GetVoiceLength("story_v_out_323601", "323601045", "story_v_out_323601.awb") / 1000

					if var_189_6 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_0
					end

					if var_189_2.prefab_name ~= "" and arg_186_1.actors_[var_189_2.prefab_name] ~= nil then
						local var_189_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_2.prefab_name].transform, "story_v_out_323601", "323601045", "story_v_out_323601.awb")

						arg_186_1:RecordAudio("323601045", var_189_7)
						arg_186_1:RecordAudio("323601045", var_189_7)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_323601", "323601045", "story_v_out_323601.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_323601", "323601045", "story_v_out_323601.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_8 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_8 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_8

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_8 and arg_186_1.time_ < var_189_0 + var_189_8 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play323601046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 323601046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play323601047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10164ui_story"]) and arg_190_1.var_.characterEffect10164ui_story == nil then
				arg_190_1.var_.characterEffect10164ui_story = arg_190_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10164ui_story"]) then
				if arg_190_1.var_.characterEffect10164ui_story and not isNil(arg_190_1.actors_["10164ui_story"]) then
					arg_190_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10164ui_story"]) and arg_190_1.var_.characterEffect10164ui_story then
				arg_190_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.725

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(323601046).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 29 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 29)

				if (29 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 29)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play323601047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 323601047
		arg_194_1.duration_ = 5.7

		local var_194_0 = {
			zh = 5.7,
			ja = 4.7
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play323601048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.5

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_1 = arg_194_1:GetWordFromCfg(323601047)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 20 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 20)

				if (20 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 20)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601047", "story_v_out_323601.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_323601", "323601047", "story_v_out_323601.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_323601", "323601047", "story_v_out_323601.awb")

						arg_194_1:RecordAudio("323601047", var_197_6)
						arg_194_1:RecordAudio("323601047", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_323601", "323601047", "story_v_out_323601.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_323601", "323601047", "story_v_out_323601.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play323601048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 323601048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play323601049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0.425

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_1 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(323601048).content)

				arg_198_1.text_.text = var_201_1

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_3 = 17 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 17)

				if (17 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 17)) > 0 and var_201_0 < var_201_3 then
					arg_198_1.talkMaxDuration = var_201_3

					if var_201_3 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_3 + 0
					end
				end

				arg_198_1.text_.text = var_201_1
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_4 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_4

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play323601049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 323601049
		arg_202_1.duration_ = 5.67

		local var_202_0 = {
			zh = 3,
			ja = 5.666
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play323601050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["10164ui_story"]) and arg_202_1.var_.characterEffect10164ui_story == nil then
				arg_202_1.var_.characterEffect10164ui_story = arg_202_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["10164ui_story"]) then
				if arg_202_1.var_.characterEffect10164ui_story and not isNil(arg_202_1.actors_["10164ui_story"]) then
					arg_202_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["10164ui_story"]) and arg_202_1.var_.characterEffect10164ui_story then
				arg_202_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_2")
			end

			local var_205_2 = 0

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 then
				arg_202_1.allBtn_.enabled = false
			end

			if arg_202_1.time_ >= var_205_2 + 1.275 and arg_202_1.time_ < var_205_2 + 1.275 + arg_205_0 then
				arg_202_1.allBtn_.enabled = true
			end

			if arg_202_1.frameCnt_ <= 1 then
				arg_202_1.dialog_:SetActive(false)
			end

			local var_205_3 = 1
			local var_205_4 = 0.275

			if 1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0

				arg_202_1.dialog_:SetActive(true)

				arg_202_1.dialogCg_.alpha = 0

				local var_205_5 = LeanTween.value(arg_202_1.dialog_, 0, 1, 0.3)

				var_205_5:setOnUpdate(LuaHelper.FloatAction(function(arg_206_0)
					arg_202_1.dialogCg_.alpha = arg_206_0
				end))
				var_205_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_202_1.dialog_)
					var_205_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_202_1.duration_ = arg_202_1.duration_ + 0.3

				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_6 = arg_202_1:GetWordFromCfg(323601049)
				local var_205_7 = arg_202_1:FormatText(var_205_6.content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_9 = 11 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_7) / 11)

				if (11 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_7) / 11)) > 0 and var_205_4 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9
					var_205_3 = var_205_3 + 0.3

					if var_205_9 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_3
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601049", "story_v_out_323601.awb") ~= 0 then
					local var_205_10 = manager.audio:GetVoiceLength("story_v_out_323601", "323601049", "story_v_out_323601.awb") / 1000

					if var_205_10 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_3
					end

					if var_205_6.prefab_name ~= "" and arg_202_1.actors_[var_205_6.prefab_name] ~= nil then
						local var_205_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_6.prefab_name].transform, "story_v_out_323601", "323601049", "story_v_out_323601.awb")

						arg_202_1:RecordAudio("323601049", var_205_11)
						arg_202_1:RecordAudio("323601049", var_205_11)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_323601", "323601049", "story_v_out_323601.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_323601", "323601049", "story_v_out_323601.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_12 = var_205_3 + 0.3
			local var_205_13 = math.max(var_205_4, arg_202_1.talkMaxDuration)

			if var_205_3 + 0.3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_12 + var_205_13 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_12) / var_205_13

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_12 + var_205_13 and arg_202_1.time_ < var_205_12 + var_205_13 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play323601050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 323601050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play323601051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["10164ui_story"]) and arg_208_1.var_.characterEffect10164ui_story == nil then
				arg_208_1.var_.characterEffect10164ui_story = arg_208_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["10164ui_story"]) then
				if arg_208_1.var_.characterEffect10164ui_story and not isNil(arg_208_1.actors_["10164ui_story"]) then
					arg_208_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["10164ui_story"]) and arg_208_1.var_.characterEffect10164ui_story then
				arg_208_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_211_1 = 0
			local var_211_2 = 1.25

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(323601050).content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 50 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 50)

				if (50 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 50)) > 0 and var_211_2 < var_211_5 then
					arg_208_1.talkMaxDuration = var_211_5

					if var_211_5 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_6 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_6 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_6

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_6 and arg_208_1.time_ < var_211_1 + var_211_6 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play323601051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 323601051
		arg_212_1.duration_ = 6.3

		local var_212_0 = {
			zh = 4.933,
			ja = 6.3
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
				arg_212_0:Play323601052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["10164ui_story"]) and arg_212_1.var_.characterEffect10164ui_story == nil then
				arg_212_1.var_.characterEffect10164ui_story = arg_212_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["10164ui_story"]) then
				if arg_212_1.var_.characterEffect10164ui_story and not isNil(arg_212_1.actors_["10164ui_story"]) then
					arg_212_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["10164ui_story"]) and arg_212_1.var_.characterEffect10164ui_story then
				arg_212_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_215_2 = 0
			local var_215_3 = 0.55

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_2 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_4 = arg_212_1:GetWordFromCfg(323601051)
				local var_215_5 = arg_212_1:FormatText(var_215_4.content)

				arg_212_1.text_.text = var_215_5

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_7 = 22 <= 0 and var_215_3 or var_215_3 * (utf8.len(var_215_5) / 22)

				if (22 <= 0 and var_215_3 or var_215_3 * (utf8.len(var_215_5) / 22)) > 0 and var_215_3 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_2
					end
				end

				arg_212_1.text_.text = var_215_5
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601051", "story_v_out_323601.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601051", "story_v_out_323601.awb") / 1000

					if var_215_8 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_2
					end

					if var_215_4.prefab_name ~= "" and arg_212_1.actors_[var_215_4.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_4.prefab_name].transform, "story_v_out_323601", "323601051", "story_v_out_323601.awb")

						arg_212_1:RecordAudio("323601051", var_215_9)
						arg_212_1:RecordAudio("323601051", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_323601", "323601051", "story_v_out_323601.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_323601", "323601051", "story_v_out_323601.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_3, arg_212_1.talkMaxDuration)

			if var_215_2 <= arg_212_1.time_ and arg_212_1.time_ < var_215_2 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_2) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_2 + var_215_10 and arg_212_1.time_ < var_215_2 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play323601052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 323601052
		arg_216_1.duration_ = 11.03

		local var_216_0 = {
			zh = 9.466,
			ja = 11.033
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play323601053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 1.175

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_1 = arg_216_1:GetWordFromCfg(323601052)
				local var_219_2 = arg_216_1:FormatText(var_219_1.content)

				arg_216_1.text_.text = var_219_2

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 47 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 47)

				if (47 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 47)) > 0 and var_219_0 < var_219_4 then
					arg_216_1.talkMaxDuration = var_219_4

					if var_219_4 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_4 + 0
					end
				end

				arg_216_1.text_.text = var_219_2
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601052", "story_v_out_323601.awb") ~= 0 then
					local var_219_5 = manager.audio:GetVoiceLength("story_v_out_323601", "323601052", "story_v_out_323601.awb") / 1000

					if var_219_5 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + 0
					end

					if var_219_1.prefab_name ~= "" and arg_216_1.actors_[var_219_1.prefab_name] ~= nil then
						local var_219_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_1.prefab_name].transform, "story_v_out_323601", "323601052", "story_v_out_323601.awb")

						arg_216_1:RecordAudio("323601052", var_219_6)
						arg_216_1:RecordAudio("323601052", var_219_6)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_323601", "323601052", "story_v_out_323601.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_323601", "323601052", "story_v_out_323601.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play323601053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 323601053
		arg_220_1.duration_ = 5.43

		local var_220_0 = {
			zh = 3.966,
			ja = 5.433
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
				arg_220_0:Play323601054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_223_0 = 0
			local var_223_1 = 0.35

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_2 = arg_220_1:GetWordFromCfg(323601053)
				local var_223_3 = arg_220_1:FormatText(var_223_2.content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 14 <= 0 and var_223_1 or var_223_1 * (utf8.len(var_223_3) / 14)

				if (14 <= 0 and var_223_1 or var_223_1 * (utf8.len(var_223_3) / 14)) > 0 and var_223_1 < var_223_5 then
					arg_220_1.talkMaxDuration = var_223_5

					if var_223_5 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601053", "story_v_out_323601.awb") ~= 0 then
					local var_223_6 = manager.audio:GetVoiceLength("story_v_out_323601", "323601053", "story_v_out_323601.awb") / 1000

					if var_223_6 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_6 + var_223_0
					end

					if var_223_2.prefab_name ~= "" and arg_220_1.actors_[var_223_2.prefab_name] ~= nil then
						local var_223_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_2.prefab_name].transform, "story_v_out_323601", "323601053", "story_v_out_323601.awb")

						arg_220_1:RecordAudio("323601053", var_223_7)
						arg_220_1:RecordAudio("323601053", var_223_7)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_323601", "323601053", "story_v_out_323601.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_323601", "323601053", "story_v_out_323601.awb")
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
	Play323601054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 323601054
		arg_224_1.duration_ = 12.93

		local var_224_0 = {
			zh = 12.933,
			ja = 11.2
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
				arg_224_0:Play323601055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["10164ui_story"]) and arg_224_1.var_.characterEffect10164ui_story == nil then
				arg_224_1.var_.characterEffect10164ui_story = arg_224_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["10164ui_story"]) then
				if arg_224_1.var_.characterEffect10164ui_story and not isNil(arg_224_1.actors_["10164ui_story"]) then
					arg_224_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_224_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_0)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["10164ui_story"]) and arg_224_1.var_.characterEffect10164ui_story then
				arg_224_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_224_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_227_1 = 0
			local var_227_2 = 1.55

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:GetWordFromCfg(323601054)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_6 = 62 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_4) / 62)

				if (62 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_4) / 62)) > 0 and var_227_2 < var_227_6 then
					arg_224_1.talkMaxDuration = var_227_6

					if var_227_6 + var_227_1 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_6 + var_227_1
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601054", "story_v_out_323601.awb") ~= 0 then
					local var_227_7 = manager.audio:GetVoiceLength("story_v_out_323601", "323601054", "story_v_out_323601.awb") / 1000

					if var_227_7 + var_227_1 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_1
					end

					if var_227_3.prefab_name ~= "" and arg_224_1.actors_[var_227_3.prefab_name] ~= nil then
						local var_227_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_3.prefab_name].transform, "story_v_out_323601", "323601054", "story_v_out_323601.awb")

						arg_224_1:RecordAudio("323601054", var_227_8)
						arg_224_1:RecordAudio("323601054", var_227_8)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_323601", "323601054", "story_v_out_323601.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_323601", "323601054", "story_v_out_323601.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_9 = math.max(var_227_2, arg_224_1.talkMaxDuration)

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_9 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_1) / var_227_9

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_1 + var_227_9 and arg_224_1.time_ < var_227_1 + var_227_9 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play323601055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 323601055
		arg_228_1.duration_ = 2.07

		local var_228_0 = {
			zh = 1.999999999999,
			ja = 2.066
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
				arg_228_0:Play323601056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["10164ui_story"]) and arg_228_1.var_.characterEffect10164ui_story == nil then
				arg_228_1.var_.characterEffect10164ui_story = arg_228_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["10164ui_story"]) then
				if arg_228_1.var_.characterEffect10164ui_story and not isNil(arg_228_1.actors_["10164ui_story"]) then
					arg_228_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["10164ui_story"]) and arg_228_1.var_.characterEffect10164ui_story then
				arg_228_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_2")
			end

			local var_231_2 = 0
			local var_231_3 = 0.2

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_2 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_4 = arg_228_1:GetWordFromCfg(323601055)
				local var_231_5 = arg_228_1:FormatText(var_231_4.content)

				arg_228_1.text_.text = var_231_5

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_7 = 8 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_5) / 8)

				if (8 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_5) / 8)) > 0 and var_231_3 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_2
					end
				end

				arg_228_1.text_.text = var_231_5
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601055", "story_v_out_323601.awb") ~= 0 then
					local var_231_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601055", "story_v_out_323601.awb") / 1000

					if var_231_8 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_8 + var_231_2
					end

					if var_231_4.prefab_name ~= "" and arg_228_1.actors_[var_231_4.prefab_name] ~= nil then
						local var_231_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_4.prefab_name].transform, "story_v_out_323601", "323601055", "story_v_out_323601.awb")

						arg_228_1:RecordAudio("323601055", var_231_9)
						arg_228_1:RecordAudio("323601055", var_231_9)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_323601", "323601055", "story_v_out_323601.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_323601", "323601055", "story_v_out_323601.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_3, arg_228_1.talkMaxDuration)

			if var_231_2 <= arg_228_1.time_ and arg_228_1.time_ < var_231_2 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_2) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_2 + var_231_10 and arg_228_1.time_ < var_231_2 + var_231_10 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play323601056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 323601056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play323601057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["10164ui_story"]) and arg_232_1.var_.characterEffect10164ui_story == nil then
				arg_232_1.var_.characterEffect10164ui_story = arg_232_1.actors_["10164ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_0 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["10164ui_story"]) then
				if arg_232_1.var_.characterEffect10164ui_story and not isNil(arg_232_1.actors_["10164ui_story"]) then
					arg_232_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_232_1.var_.characterEffect10164ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_0)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["10164ui_story"]) and arg_232_1.var_.characterEffect10164ui_story then
				arg_232_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_232_1.var_.characterEffect10164ui_story.fillRatio = 0.5
			end

			local var_235_1 = 0
			local var_235_2 = 0.275

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_3 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(323601056).content)

				arg_232_1.text_.text = var_235_3

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 11 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_3) / 11)

				if (11 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_3) / 11)) > 0 and var_235_2 < var_235_5 then
					arg_232_1.talkMaxDuration = var_235_5

					if var_235_5 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + var_235_1
					end
				end

				arg_232_1.text_.text = var_235_3
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_6 = math.max(var_235_2, arg_232_1.talkMaxDuration)

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_6 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_1) / var_235_6

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_1 + var_235_6 and arg_232_1.time_ < var_235_1 + var_235_6 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play323601057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 323601057
		arg_236_1.duration_ = 2

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play323601058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10164ui_story = arg_236_1.actors_["10164ui_story"].transform.localPosition

				local var_239_0 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_0 then
					var_239_0:EnableDynamicBone(false)
				end
			end

			local var_239_1 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				arg_236_1.actors_["10164ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10164ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_1)
				arg_236_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10164ui_story"].transform.position).z)
				arg_236_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["10164ui_story"].transform.localEulerAngles = arg_236_1.actors_["10164ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 then
				arg_236_1.actors_["10164ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.actors_["10164ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["10164ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10164ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["10164ui_story"].transform.position).z)
				arg_236_1.actors_["10164ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["10164ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["10164ui_story"].transform.localEulerAngles = arg_236_1.actors_["10164ui_story"].transform.localEulerAngles

				local var_239_2 = GameObjectTools.GetOrAddComponent(arg_236_1.actors_["10164ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_239_2 then
					var_239_2:EnableDynamicBone(true)
				end
			end

			local var_239_3 = "10170ui_story"

			if arg_236_1.actors_["10170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10170ui_story"))) then
				local var_239_4 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_236_1.stage_.transform)

				var_239_4.name = var_239_3
				var_239_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.actors_[var_239_3] = var_239_4

				local var_239_5 = var_239_4:GetComponentInChildren(typeof(CharacterEffect))

				var_239_5.enabled = true

				local var_239_6 = GameObjectTools.GetOrAddComponent(var_239_4, typeof(DynamicBoneHelper))

				if var_239_6 then
					var_239_6:EnableDynamicBone(false)
				end

				arg_236_1:ShowWeapon(var_239_5.transform, false)

				arg_236_1.var_[var_239_3 .. "Animator"] = var_239_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_236_1.var_[var_239_3 .. "Animator"].applyRootMotion = true
				arg_236_1.var_[var_239_3 .. "LipSync"] = var_239_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_239_7 = arg_236_1.actors_["10170ui_story"].transform

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10170ui_story = var_239_7.localPosition

				local var_239_8 = GameObjectTools.GetOrAddComponent(var_239_7.gameObject, typeof(DynamicBoneHelper))

				if var_239_8 then
					var_239_8:EnableDynamicBone(false)
				end
			end

			local var_239_9 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_9 then
				var_239_7.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_236_1.time_ - 0) / var_239_9)
				var_239_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_7.position).x, (manager.ui.mainCamera.transform.position - var_239_7.position).y, (manager.ui.mainCamera.transform.position - var_239_7.position).z)
				var_239_7.localEulerAngles.z = 0
				var_239_7.localEulerAngles.x = 0
				var_239_7.localEulerAngles = var_239_7.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_9 and arg_236_1.time_ < 0 + var_239_9 + arg_239_0 then
				var_239_7.localPosition = Vector3.New(0, -1.03, -6.05)
				var_239_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_239_7.position).x, (manager.ui.mainCamera.transform.position - var_239_7.position).y, (manager.ui.mainCamera.transform.position - var_239_7.position).z)
				var_239_7.localEulerAngles.z = 0
				var_239_7.localEulerAngles.x = 0
				var_239_7.localEulerAngles = var_239_7.localEulerAngles

				local var_239_10 = GameObjectTools.GetOrAddComponent(var_239_7.gameObject, typeof(DynamicBoneHelper))

				if var_239_10 then
					var_239_10:EnableDynamicBone(true)
				end
			end

			local var_239_11 = arg_236_1.actors_["10170ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_11) and arg_236_1.var_.characterEffect10170ui_story == nil then
				arg_236_1.var_.characterEffect10170ui_story = var_239_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_12 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_12 and not isNil(var_239_11) then
				if arg_236_1.var_.characterEffect10170ui_story and not isNil(var_239_11) then
					arg_236_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_12 and arg_236_1.time_ < 0 + var_239_12 + arg_239_0 and not isNil(var_239_11) and arg_236_1.var_.characterEffect10170ui_story then
				arg_236_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_239_14 = 0
			local var_239_15 = 0.125

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_14 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_16 = arg_236_1:GetWordFromCfg(323601057)
				local var_239_17 = arg_236_1:FormatText(var_239_16.content)

				arg_236_1.text_.text = var_239_17

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_19 = 5 <= 0 and var_239_15 or var_239_15 * (utf8.len(var_239_17) / 5)

				if (5 <= 0 and var_239_15 or var_239_15 * (utf8.len(var_239_17) / 5)) > 0 and var_239_15 < var_239_19 then
					arg_236_1.talkMaxDuration = var_239_19

					if var_239_19 + var_239_14 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_19 + var_239_14
					end
				end

				arg_236_1.text_.text = var_239_17
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601057", "story_v_out_323601.awb") ~= 0 then
					local var_239_20 = manager.audio:GetVoiceLength("story_v_out_323601", "323601057", "story_v_out_323601.awb") / 1000

					if var_239_20 + var_239_14 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_20 + var_239_14
					end

					if var_239_16.prefab_name ~= "" and arg_236_1.actors_[var_239_16.prefab_name] ~= nil then
						local var_239_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_16.prefab_name].transform, "story_v_out_323601", "323601057", "story_v_out_323601.awb")

						arg_236_1:RecordAudio("323601057", var_239_21)
						arg_236_1:RecordAudio("323601057", var_239_21)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_323601", "323601057", "story_v_out_323601.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_323601", "323601057", "story_v_out_323601.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_22 = math.max(var_239_15, arg_236_1.talkMaxDuration)

			if var_239_14 <= arg_236_1.time_ and arg_236_1.time_ < var_239_14 + var_239_22 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_14) / var_239_22

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_14 + var_239_22 and arg_236_1.time_ < var_239_14 + var_239_22 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play323601058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 323601058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play323601059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["10170ui_story"]) and arg_240_1.var_.characterEffect10170ui_story == nil then
				arg_240_1.var_.characterEffect10170ui_story = arg_240_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["10170ui_story"]) then
				if arg_240_1.var_.characterEffect10170ui_story and not isNil(arg_240_1.actors_["10170ui_story"]) then
					arg_240_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_0)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["10170ui_story"]) and arg_240_1.var_.characterEffect10170ui_story then
				arg_240_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_243_1 = 0
			local var_243_2 = 0.7

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(323601058).content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 28 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 28)

				if (28 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 28)) > 0 and var_243_2 < var_243_5 then
					arg_240_1.talkMaxDuration = var_243_5

					if var_243_5 + var_243_1 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + var_243_1
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_6 = math.max(var_243_2, arg_240_1.talkMaxDuration)

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_6 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_1) / var_243_6

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_1 + var_243_6 and arg_240_1.time_ < var_243_1 + var_243_6 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play323601059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 323601059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play323601060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.85

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_1 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(323601059).content)

				arg_244_1.text_.text = var_247_1

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_3 = 34 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 34)

				if (34 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 34)) > 0 and var_247_0 < var_247_3 then
					arg_244_1.talkMaxDuration = var_247_3

					if var_247_3 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_3 + 0
					end
				end

				arg_244_1.text_.text = var_247_1
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_4 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_4

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play323601060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 323601060
		arg_248_1.duration_ = 2.5

		local var_248_0 = {
			zh = 2.5,
			ja = 2.466
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
				arg_248_0:Play323601061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["10170ui_story"]) and arg_248_1.var_.characterEffect10170ui_story == nil then
				arg_248_1.var_.characterEffect10170ui_story = arg_248_1.actors_["10170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["10170ui_story"]) then
				if arg_248_1.var_.characterEffect10170ui_story and not isNil(arg_248_1.actors_["10170ui_story"]) then
					arg_248_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["10170ui_story"]) and arg_248_1.var_.characterEffect10170ui_story then
				arg_248_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action15_1")
			end

			local var_251_2 = 0
			local var_251_3 = 0.275

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_2 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_4 = arg_248_1:GetWordFromCfg(323601060)
				local var_251_5 = arg_248_1:FormatText(var_251_4.content)

				arg_248_1.text_.text = var_251_5

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_7 = 11 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_5) / 11)

				if (11 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_5) / 11)) > 0 and var_251_3 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_2
					end
				end

				arg_248_1.text_.text = var_251_5
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601060", "story_v_out_323601.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_323601", "323601060", "story_v_out_323601.awb") / 1000

					if var_251_8 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_2
					end

					if var_251_4.prefab_name ~= "" and arg_248_1.actors_[var_251_4.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_4.prefab_name].transform, "story_v_out_323601", "323601060", "story_v_out_323601.awb")

						arg_248_1:RecordAudio("323601060", var_251_9)
						arg_248_1:RecordAudio("323601060", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_323601", "323601060", "story_v_out_323601.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_323601", "323601060", "story_v_out_323601.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_3, arg_248_1.talkMaxDuration)

			if var_251_2 <= arg_248_1.time_ and arg_248_1.time_ < var_251_2 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_2) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_2 + var_251_10 and arg_248_1.time_ < var_251_2 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play323601061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 323601061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play323601062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10170ui_story = arg_252_1.actors_["10170ui_story"].transform.localPosition

				local var_255_0 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_0 then
					var_255_0:EnableDynamicBone(false)
				end
			end

			local var_255_1 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_1 then
				arg_252_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 0) / var_255_1)
				arg_252_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10170ui_story"].transform.position).z)
				arg_252_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10170ui_story"].transform.localEulerAngles = arg_252_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_1 and arg_252_1.time_ < 0 + var_255_1 + arg_255_0 then
				arg_252_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10170ui_story"].transform.position).z)
				arg_252_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10170ui_story"].transform.localEulerAngles = arg_252_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_255_2 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_2 then
					var_255_2:EnableDynamicBone(true)
				end
			end

			local var_255_3 = 0
			local var_255_4 = 0.675

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_3 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_5 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(323601061).content)

				arg_252_1.text_.text = var_255_5

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_7 = 27 <= 0 and var_255_4 or var_255_4 * (utf8.len(var_255_5) / 27)

				if (27 <= 0 and var_255_4 or var_255_4 * (utf8.len(var_255_5) / 27)) > 0 and var_255_4 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_3 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_3
					end
				end

				arg_252_1.text_.text = var_255_5
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_8 = math.max(var_255_4, arg_252_1.talkMaxDuration)

			if var_255_3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_3 + var_255_8 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_3) / var_255_8

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_3 + var_255_8 and arg_252_1.time_ < var_255_3 + var_255_8 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play323601062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 323601062
		arg_256_1.duration_ = 2.4

		local var_256_0 = {
			zh = 2.4,
			ja = 2.033
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
			arg_256_1.auto_ = false
		end

		function arg_256_1.playNext_(arg_258_0)
			arg_256_1.onStoryFinished_()
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if arg_256_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_259_0 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_256_1.stage_.transform)

				var_259_0.name = "1033ui_story"
				var_259_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.actors_["1033ui_story"] = var_259_0

				local var_259_1 = var_259_0:GetComponentInChildren(typeof(CharacterEffect))

				var_259_1.enabled = true

				local var_259_2 = GameObjectTools.GetOrAddComponent(var_259_0, typeof(DynamicBoneHelper))

				if var_259_2 then
					var_259_2:EnableDynamicBone(false)
				end

				arg_256_1:ShowWeapon(var_259_1.transform, false)

				arg_256_1.var_["1033ui_story" .. "Animator"] = var_259_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_256_1.var_["1033ui_story" .. "Animator"].applyRootMotion = true
				arg_256_1.var_["1033ui_story" .. "LipSync"] = var_259_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_259_3 = arg_256_1.actors_["1033ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_3) and arg_256_1.var_.characterEffect1033ui_story == nil then
				arg_256_1.var_.characterEffect1033ui_story = var_259_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_4 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 and not isNil(var_259_3) then
				if arg_256_1.var_.characterEffect1033ui_story and not isNil(var_259_3) then
					arg_256_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 and not isNil(var_259_3) and arg_256_1.var_.characterEffect1033ui_story then
				arg_256_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_259_6 = 0
			local var_259_7 = 0.325

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_8 = arg_256_1:GetWordFromCfg(323601062)
				local var_259_9 = arg_256_1:FormatText(var_259_8.content)

				arg_256_1.text_.text = var_259_9

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 13 <= 0 and var_259_7 or var_259_7 * (utf8.len(var_259_9) / 13)

				if (13 <= 0 and var_259_7 or var_259_7 * (utf8.len(var_259_9) / 13)) > 0 and var_259_7 < var_259_11 then
					arg_256_1.talkMaxDuration = var_259_11

					if var_259_11 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_11 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_9
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323601", "323601062", "story_v_out_323601.awb") ~= 0 then
					local var_259_12 = manager.audio:GetVoiceLength("story_v_out_323601", "323601062", "story_v_out_323601.awb") / 1000

					if var_259_12 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_12 + var_259_6
					end

					if var_259_8.prefab_name ~= "" and arg_256_1.actors_[var_259_8.prefab_name] ~= nil then
						local var_259_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_8.prefab_name].transform, "story_v_out_323601", "323601062", "story_v_out_323601.awb")

						arg_256_1:RecordAudio("323601062", var_259_13)
						arg_256_1:RecordAudio("323601062", var_259_13)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_323601", "323601062", "story_v_out_323601.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_323601", "323601062", "story_v_out_323601.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_14 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_14 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_14

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_14 and arg_256_1.time_ < var_259_6 + var_259_14 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST32",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J21h"
	},
	voices = {
		"story_v_out_323601.awb"
	}
}
