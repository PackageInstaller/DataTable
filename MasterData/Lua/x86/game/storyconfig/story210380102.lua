return {
	Play103802001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103802001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play103802002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_4_0.name = "B13"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13

				arg_1_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_6 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_6

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_6
						arg_1_1.bgmTxt2_.text = var_4_6
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_9 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_9 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_9

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_9
						arg_1_1.bgmTxt2_.text = var_4_9
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

			local var_4_10 = 0
			local var_4_11 = 0.8

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_13 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(103802001).content)

				arg_1_1.text_.text = var_4_13

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_15 = 32 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 32)

				if (32 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 32)) > 0 and var_4_11 < var_4_15 then
					arg_1_1.talkMaxDuration = var_4_15
					var_4_10 = var_4_10 + 0.3

					if var_4_15 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_15 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_13
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_16 = var_4_10 + 0.3
			local var_4_17 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_16) / var_4_17

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play103802002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 103802002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play103802003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.775

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(103802002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 31 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 31)

				if (31 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 31)) > 0 and var_12_0 < var_12_3 then
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
	Play103802003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 103802003
		arg_13_1.duration_ = 6.03

		local var_13_0 = {
			ja = 4.533,
			ko = 4.9,
			en = 6.033
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
				arg_13_0:Play103802004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1038ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1038ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1038ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1038ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1038ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect1038ui_story == nil then
				arg_13_1.var_.characterEffect1038ui_story = var_16_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_4 = 0.1

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 and not isNil(var_16_3) then
				if arg_13_1.var_.characterEffect1038ui_story and not isNil(var_16_3) then
					arg_13_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect1038ui_story then
				arg_13_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_16_6 = arg_13_1.actors_["1038ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1038ui_story = var_16_6.localPosition
			end

			local var_16_7 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				var_16_6.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.16, -5.3), (arg_13_1.time_ - 0) / var_16_7)
				var_16_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_6.position).x, (manager.ui.mainCamera.transform.position - var_16_6.position).y, (manager.ui.mainCamera.transform.position - var_16_6.position).z)
				var_16_6.localEulerAngles.z = 0
				var_16_6.localEulerAngles.x = 0
				var_16_6.localEulerAngles = var_16_6.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				var_16_6.localPosition = Vector3.New(0, -1.16, -5.3)
				var_16_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_6.position).x, (manager.ui.mainCamera.transform.position - var_16_6.position).y, (manager.ui.mainCamera.transform.position - var_16_6.position).z)
				var_16_6.localEulerAngles.z = 0
				var_16_6.localEulerAngles.x = 0
				var_16_6.localEulerAngles = var_16_6.localEulerAngles
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.425

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(103802003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 17 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 17)

				if (17 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 17)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802003", "story_v_side_old_103802.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802003", "story_v_side_old_103802.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_side_old_103802", "103802003", "story_v_side_old_103802.awb")

						arg_13_1:RecordAudio("103802003", var_16_15)
						arg_13_1:RecordAudio("103802003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802003", "story_v_side_old_103802.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802003", "story_v_side_old_103802.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play103802004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 103802004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play103802005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1038ui_story"]) and arg_17_1.var_.characterEffect1038ui_story == nil then
				arg_17_1.var_.characterEffect1038ui_story = arg_17_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.1

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1038ui_story"]) then
				if arg_17_1.var_.characterEffect1038ui_story and not isNil(arg_17_1.actors_["1038ui_story"]) then
					arg_17_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1038ui_story"]) and arg_17_1.var_.characterEffect1038ui_story then
				arg_17_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(103802004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 5 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 5)

				if (5 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 5)) > 0 and var_20_2 < var_20_5 then
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
	Play103802005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 103802005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play103802006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.025

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(103802005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 41 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 41)

				if (41 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 41)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play103802006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 103802006
		arg_25_1.duration_ = 13.9

		local var_25_0 = {
			ja = 11.833,
			ko = 13.9,
			en = 10.833
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
				arg_25_0:Play103802007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1038ui_story"]) and arg_25_1.var_.characterEffect1038ui_story == nil then
				arg_25_1.var_.characterEffect1038ui_story = arg_25_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.1

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1038ui_story"]) then
				if arg_25_1.var_.characterEffect1038ui_story and not isNil(arg_25_1.actors_["1038ui_story"]) then
					arg_25_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1038ui_story"]) and arg_25_1.var_.characterEffect1038ui_story then
				arg_25_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action457")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_28_2 = 0
			local var_28_3 = 1.2

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(103802006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 48 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 48)

				if (48 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 48)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802006", "story_v_side_old_103802.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802006", "story_v_side_old_103802.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_side_old_103802", "103802006", "story_v_side_old_103802.awb")

						arg_25_1:RecordAudio("103802006", var_28_9)
						arg_25_1:RecordAudio("103802006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802006", "story_v_side_old_103802.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802006", "story_v_side_old_103802.awb")
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
	Play103802007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 103802007
		arg_29_1.duration_ = 12.33

		local var_29_0 = {
			ja = 12.333,
			ko = 9,
			en = 8.3
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
				arg_29_0:Play103802008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action476")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_32_0 = 0
			local var_32_1 = 0.85

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(103802007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 34 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 34)

				if (34 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 34)) > 0 and var_32_1 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802007", "story_v_side_old_103802.awb") ~= 0 then
					local var_32_6 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802007", "story_v_side_old_103802.awb") / 1000

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end

					if var_32_2.prefab_name ~= "" and arg_29_1.actors_[var_32_2.prefab_name] ~= nil then
						local var_32_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_2.prefab_name].transform, "story_v_side_old_103802", "103802007", "story_v_side_old_103802.awb")

						arg_29_1:RecordAudio("103802007", var_32_7)
						arg_29_1:RecordAudio("103802007", var_32_7)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802007", "story_v_side_old_103802.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802007", "story_v_side_old_103802.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play103802008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 103802008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play103802009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1038ui_story"]) and arg_33_1.var_.characterEffect1038ui_story == nil then
				arg_33_1.var_.characterEffect1038ui_story = arg_33_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.1

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1038ui_story"]) then
				if arg_33_1.var_.characterEffect1038ui_story and not isNil(arg_33_1.actors_["1038ui_story"]) then
					arg_33_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1038ui_story"]) and arg_33_1.var_.characterEffect1038ui_story then
				arg_33_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.05

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(103802008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 2 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 2)

				if (2 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 2)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play103802009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 103802009
		arg_37_1.duration_ = 9.53

		local var_37_0 = {
			ja = 9.533,
			ko = 8.933,
			en = 7.666
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
				arg_37_0:Play103802010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1038ui_story"]) and arg_37_1.var_.characterEffect1038ui_story == nil then
				arg_37_1.var_.characterEffect1038ui_story = arg_37_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.1

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1038ui_story"]) then
				if arg_37_1.var_.characterEffect1038ui_story and not isNil(arg_37_1.actors_["1038ui_story"]) then
					arg_37_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1038ui_story"]) and arg_37_1.var_.characterEffect1038ui_story then
				arg_37_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action467")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_40_2 = 0
			local var_40_3 = 0.875

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(103802009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 35 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 35)

				if (35 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 35)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802009", "story_v_side_old_103802.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802009", "story_v_side_old_103802.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_side_old_103802", "103802009", "story_v_side_old_103802.awb")

						arg_37_1:RecordAudio("103802009", var_40_9)
						arg_37_1:RecordAudio("103802009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802009", "story_v_side_old_103802.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802009", "story_v_side_old_103802.awb")
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
	Play103802010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 103802010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play103802011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1038ui_story"]) and arg_41_1.var_.characterEffect1038ui_story == nil then
				arg_41_1.var_.characterEffect1038ui_story = arg_41_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.1

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1038ui_story"]) then
				if arg_41_1.var_.characterEffect1038ui_story and not isNil(arg_41_1.actors_["1038ui_story"]) then
					arg_41_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1038ui_story"]) and arg_41_1.var_.characterEffect1038ui_story then
				arg_41_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_44_1 = arg_41_1.actors_["1038ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1038ui_story = var_44_1.localPosition
			end

			local var_44_2 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 then
				var_44_1.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1038ui_story, Vector3.New(30, -1.16, -5.3), (arg_41_1.time_ - 0) / var_44_2)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 then
				var_44_1.localPosition = Vector3.New(30, -1.16, -5.3)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			local var_44_3 = 0
			local var_44_4 = 0.8

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(103802010).content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 32 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_5) / 32)

				if (32 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_5) / 32)) > 0 and var_44_4 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_8 and arg_41_1.time_ < var_44_3 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play103802011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 103802011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play103802012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPosB13 = arg_45_1.bgs_.B13.transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.bgs_.B13.transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPosB13, Vector3.New(0, -100, 10), (arg_45_1.time_ - 0) / var_48_0)
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.bgs_.B13.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_48_1 = "ST03"

			if arg_45_1.bgs_.ST03 == nil then
				local var_48_2 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_48_1)
				var_48_2.name = var_48_1
				var_48_2.transform.parent = arg_45_1.stage_.transform
				var_48_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_[var_48_1] = var_48_2
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_3 = arg_45_1.bgs_.ST03

				arg_45_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_48_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_4 = var_48_3:GetComponent("SpriteRenderer")

				if var_48_4 and var_48_4.sprite then
					local var_48_5 = 2 * (var_48_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_48_3.transform.localScale = Vector3.New(var_48_5 / var_48_4.sprite.bounds.size.y < var_48_5 * manager.ui.mainCameraCom_.aspect / var_48_4.sprite.bounds.size.x and var_48_5 * manager.ui.mainCameraCom_.aspect / var_48_4.sprite.bounds.size.x or var_48_5 / var_48_4.sprite.bounds.size.y, var_48_5 / var_48_4.sprite.bounds.size.y < var_48_5 * manager.ui.mainCameraCom_.aspect / var_48_4.sprite.bounds.size.x and var_48_5 * manager.ui.mainCameraCom_.aspect / var_48_4.sprite.bounds.size.x or var_48_5 / var_48_4.sprite.bounds.size.y, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "ST03" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_6 = 0
			local var_48_7 = 0.575

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(103802011).content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 23 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_8) / 23)

				if (23 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_8) / 23)) > 0 and var_48_7 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_11 and arg_45_1.time_ < var_48_6 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B13",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play103802012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 103802012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play103802013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.75

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
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

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(103802012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 30 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 30)

				if (30 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 30)) > 0 and var_52_0 < var_52_3 then
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
	Play103802013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 103802013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play103802014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.375

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(103802013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 15 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 15)

				if (15 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 15)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play103802014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 103802014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play103802015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.4

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(103802014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 16 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 16)

				if (16 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 16)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play103802015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 103802015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play103802016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.5

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(103802015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 20 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 20)

				if (20 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 20)) > 0 and var_64_0 < var_64_3 then
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
	Play103802016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 103802016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play103802017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.375

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

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(103802016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 15 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 15)

				if (15 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 15)) > 0 and var_68_0 < var_68_3 then
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
	Play103802017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 103802017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play103802018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(103802017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 17 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 17)

				if (17 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 17)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play103802018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 103802018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play103802019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.875

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(103802018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 35 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 35)

				if (35 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 35)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play103802019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 103802019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play103802020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.275

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(103802019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 11 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 11)

				if (11 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 11)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play103802020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 103802020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play103802021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPosST03 = arg_81_1.bgs_.ST03.transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.bgs_.ST03.transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPosST03, Vector3.New(0, -100, 10), (arg_81_1.time_ - 0) / var_84_0)
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.bgs_.ST03.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_84_1 = "D02b"

			if arg_81_1.bgs_.D02b == nil then
				local var_84_2 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_84_1)
				var_84_2.name = var_84_1
				var_84_2.transform.parent = arg_81_1.stage_.transform
				var_84_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_[var_84_1] = var_84_2
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				local var_84_3 = arg_81_1.bgs_.D02b

				arg_81_1.bgs_.D02b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_84_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_4 = var_84_3:GetComponent("SpriteRenderer")

				if var_84_4 and var_84_4.sprite then
					local var_84_5 = 2 * (var_84_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_84_3.transform.localScale = Vector3.New(var_84_5 / var_84_4.sprite.bounds.size.y < var_84_5 * manager.ui.mainCameraCom_.aspect / var_84_4.sprite.bounds.size.x and var_84_5 * manager.ui.mainCameraCom_.aspect / var_84_4.sprite.bounds.size.x or var_84_5 / var_84_4.sprite.bounds.size.y, var_84_5 / var_84_4.sprite.bounds.size.y < var_84_5 * manager.ui.mainCameraCom_.aspect / var_84_4.sprite.bounds.size.x and var_84_5 * manager.ui.mainCameraCom_.aspect / var_84_4.sprite.bounds.size.x or var_84_5 / var_84_4.sprite.bounds.size.y, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "D02b" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_6 = 0
			local var_84_7 = 0.25

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(103802020).content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 10 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_8) / 10)

				if (10 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_8) / 10)) > 0 and var_84_7 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_11 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_11 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_11

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_11 and arg_81_1.time_ < var_84_6 + var_84_11 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play103802021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 103802021
		arg_85_1.duration_ = 6.9

		local var_85_0 = {
			ja = 5.1,
			ko = 6.9,
			en = 6.6
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play103802022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if arg_85_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_88_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_85_1.stage_.transform)

				var_88_0.name = "1019ui_story"
				var_88_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["1019ui_story"] = var_88_0

				local var_88_1 = var_88_0:GetComponentInChildren(typeof(CharacterEffect))

				var_88_1.enabled = true

				local var_88_2 = GameObjectTools.GetOrAddComponent(var_88_0, typeof(DynamicBoneHelper))

				if var_88_2 then
					var_88_2:EnableDynamicBone(false)
				end

				arg_85_1:ShowWeapon(var_88_1.transform, false)

				arg_85_1.var_["1019ui_story" .. "Animator"] = var_88_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_85_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_85_1.var_["1019ui_story" .. "LipSync"] = var_88_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_88_3 = arg_85_1.actors_["1019ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect1019ui_story == nil then
				arg_85_1.var_.characterEffect1019ui_story = var_88_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_4 = 0.1

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 and not isNil(var_88_3) then
				if arg_85_1.var_.characterEffect1019ui_story and not isNil(var_88_3) then
					arg_85_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect1019ui_story then
				arg_85_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_88_6 = arg_85_1.actors_["1019ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1019ui_story = var_88_6.localPosition
			end

			local var_88_7 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				var_88_6.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1019ui_story, Vector3.New(0, -1.13, -5.3), (arg_85_1.time_ - 0) / var_88_7)
				var_88_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_6.position).x, (manager.ui.mainCamera.transform.position - var_88_6.position).y, (manager.ui.mainCamera.transform.position - var_88_6.position).z)
				var_88_6.localEulerAngles.z = 0
				var_88_6.localEulerAngles.x = 0
				var_88_6.localEulerAngles = var_88_6.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				var_88_6.localPosition = Vector3.New(0, -1.13, -5.3)
				var_88_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_6.position).x, (manager.ui.mainCamera.transform.position - var_88_6.position).y, (manager.ui.mainCamera.transform.position - var_88_6.position).z)
				var_88_6.localEulerAngles.z = 0
				var_88_6.localEulerAngles.x = 0
				var_88_6.localEulerAngles = var_88_6.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_88_8 = 0
			local var_88_9 = 0.65

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(103802021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 26 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 26)

				if (26 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 26)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802021", "story_v_side_old_103802.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802021", "story_v_side_old_103802.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_side_old_103802", "103802021", "story_v_side_old_103802.awb")

						arg_85_1:RecordAudio("103802021", var_88_15)
						arg_85_1:RecordAudio("103802021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802021", "story_v_side_old_103802.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802021", "story_v_side_old_103802.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play103802022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 103802022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play103802023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1019ui_story"]) and arg_89_1.var_.characterEffect1019ui_story == nil then
				arg_89_1.var_.characterEffect1019ui_story = arg_89_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.1

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1019ui_story"]) then
				if arg_89_1.var_.characterEffect1019ui_story and not isNil(arg_89_1.actors_["1019ui_story"]) then
					arg_89_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1019ui_story"]) and arg_89_1.var_.characterEffect1019ui_story then
				arg_89_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(103802022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 18 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 18)

				if (18 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 18)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play103802023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 103802023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play103802024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.55

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(103802023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 62 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 62)

				if (62 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 62)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play103802024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 103802024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play103802025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.65

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(103802024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 26 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 26)

				if (26 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 26)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play103802025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 103802025
		arg_101_1.duration_ = 7.23

		local var_101_0 = {
			ja = 7.233,
			ko = 5.533,
			en = 6.8
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
				arg_101_0:Play103802026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1019ui_story = arg_101_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1019ui_story, Vector3.New(10, -1.13, -5.3), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).z)
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles = arg_101_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(10, -1.13, -5.3)
				arg_101_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).z)
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles = arg_101_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_104_1 = 0
			local var_104_2 = 0.675

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[52].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(103802025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_6 = 27 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_4) / 27)

				if (27 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_4) / 27)) > 0 and var_104_2 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802025", "story_v_side_old_103802.awb") ~= 0 then
					local var_104_7 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802025", "story_v_side_old_103802.awb") / 1000

					if var_104_7 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_1
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_side_old_103802", "103802025", "story_v_side_old_103802.awb")

						arg_101_1:RecordAudio("103802025", var_104_8)
						arg_101_1:RecordAudio("103802025", var_104_8)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802025", "story_v_side_old_103802.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802025", "story_v_side_old_103802.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_9 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_9 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_9

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_9 and arg_101_1.time_ < var_104_1 + var_104_9 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play103802026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 103802026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play103802027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.175

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(103802026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 7 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 7)

				if (7 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 7)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play103802027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 103802027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play103802028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.15

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

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(103802027).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 46 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 46)

				if (46 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 46)) > 0 and var_112_0 < var_112_3 then
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
	Play103802028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 103802028
		arg_113_1.duration_ = 5.6

		local var_113_0 = {
			ja = 5.6,
			ko = 4.7,
			en = 4.366
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
				arg_113_0:Play103802029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1038ui_story"]) and arg_113_1.var_.characterEffect1038ui_story == nil then
				arg_113_1.var_.characterEffect1038ui_story = arg_113_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.1

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1038ui_story"]) then
				if arg_113_1.var_.characterEffect1038ui_story and not isNil(arg_113_1.actors_["1038ui_story"]) then
					arg_113_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1038ui_story"]) and arg_113_1.var_.characterEffect1038ui_story then
				arg_113_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_116_2 = arg_113_1.actors_["1038ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1038ui_story = var_116_2.localPosition
			end

			local var_116_3 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 then
				var_116_2.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.16, -5.3), (arg_113_1.time_ - 0) / var_116_3)
				var_116_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_2.position).x, (manager.ui.mainCamera.transform.position - var_116_2.position).y, (manager.ui.mainCamera.transform.position - var_116_2.position).z)
				var_116_2.localEulerAngles.z = 0
				var_116_2.localEulerAngles.x = 0
				var_116_2.localEulerAngles = var_116_2.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 then
				var_116_2.localPosition = Vector3.New(0, -1.16, -5.3)
				var_116_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_2.position).x, (manager.ui.mainCamera.transform.position - var_116_2.position).y, (manager.ui.mainCamera.transform.position - var_116_2.position).z)
				var_116_2.localEulerAngles.z = 0
				var_116_2.localEulerAngles.x = 0
				var_116_2.localEulerAngles = var_116_2.localEulerAngles
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action2_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_116_4 = 0
			local var_116_5 = 0.6

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(103802028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 24 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 24)

				if (24 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 24)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802028", "story_v_side_old_103802.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802028", "story_v_side_old_103802.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_side_old_103802", "103802028", "story_v_side_old_103802.awb")

						arg_113_1:RecordAudio("103802028", var_116_11)
						arg_113_1:RecordAudio("103802028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802028", "story_v_side_old_103802.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802028", "story_v_side_old_103802.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play103802029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 103802029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play103802030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.475

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(103802029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 19 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 19)

				if (19 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 19)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play103802030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 103802030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play103802031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1038ui_story"]) and arg_121_1.var_.characterEffect1038ui_story == nil then
				arg_121_1.var_.characterEffect1038ui_story = arg_121_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.1

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1038ui_story"]) then
				if arg_121_1.var_.characterEffect1038ui_story and not isNil(arg_121_1.actors_["1038ui_story"]) then
					arg_121_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1038ui_story"]) and arg_121_1.var_.characterEffect1038ui_story then
				arg_121_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.4

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(103802030).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 16 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 16)

				if (16 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 16)) > 0 and var_124_2 < var_124_5 then
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
	Play103802031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 103802031
		arg_125_1.duration_ = 10.17

		local var_125_0 = {
			ja = 7.433,
			ko = 10.166,
			en = 9.266
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
				arg_125_0:Play103802032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1038ui_story"]) and arg_125_1.var_.characterEffect1038ui_story == nil then
				arg_125_1.var_.characterEffect1038ui_story = arg_125_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.1

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1038ui_story"]) then
				if arg_125_1.var_.characterEffect1038ui_story and not isNil(arg_125_1.actors_["1038ui_story"]) then
					arg_125_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1038ui_story"]) and arg_125_1.var_.characterEffect1038ui_story then
				arg_125_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action425")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_128_2 = 0
			local var_128_3 = 0.8

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:GetWordFromCfg(103802031)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 32 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 32)

				if (32 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 32)) > 0 and var_128_3 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802031", "story_v_side_old_103802.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802031", "story_v_side_old_103802.awb") / 1000

					if var_128_8 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_2
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_side_old_103802", "103802031", "story_v_side_old_103802.awb")

						arg_125_1:RecordAudio("103802031", var_128_9)
						arg_125_1:RecordAudio("103802031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802031", "story_v_side_old_103802.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802031", "story_v_side_old_103802.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_10 and arg_125_1.time_ < var_128_2 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play103802032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 103802032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play103802033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1038ui_story"]) and arg_129_1.var_.characterEffect1038ui_story == nil then
				arg_129_1.var_.characterEffect1038ui_story = arg_129_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.1

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1038ui_story"]) then
				if arg_129_1.var_.characterEffect1038ui_story and not isNil(arg_129_1.actors_["1038ui_story"]) then
					arg_129_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1038ui_story"]) and arg_129_1.var_.characterEffect1038ui_story then
				arg_129_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.05

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

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(103802032).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 2 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 2)

				if (2 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 2)) > 0 and var_132_2 < var_132_5 then
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
	Play103802033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 103802033
		arg_133_1.duration_ = 7.43

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play103802034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1038ui_story"]) and arg_133_1.var_.characterEffect1038ui_story == nil then
				arg_133_1.var_.characterEffect1038ui_story = arg_133_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.1

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1038ui_story"]) then
				if arg_133_1.var_.characterEffect1038ui_story and not isNil(arg_133_1.actors_["1038ui_story"]) then
					arg_133_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1038ui_story"]) and arg_133_1.var_.characterEffect1038ui_story then
				arg_133_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action457")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_136_2 = 0
			local var_136_3 = 0.075

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(103802033)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 3 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 3)

				if (3 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 3)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802033", "story_v_side_old_103802.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802033", "story_v_side_old_103802.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_side_old_103802", "103802033", "story_v_side_old_103802.awb")

						arg_133_1:RecordAudio("103802033", var_136_9)
						arg_133_1:RecordAudio("103802033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802033", "story_v_side_old_103802.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802033", "story_v_side_old_103802.awb")
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
	Play103802034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 103802034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play103802035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.4

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(103802034).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 56 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 56)

				if (56 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 56)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play103802035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 103802035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play103802036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1038ui_story"]) and arg_141_1.var_.characterEffect1038ui_story == nil then
				arg_141_1.var_.characterEffect1038ui_story = arg_141_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.1

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1038ui_story"]) then
				if arg_141_1.var_.characterEffect1038ui_story and not isNil(arg_141_1.actors_["1038ui_story"]) then
					arg_141_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1038ui_story"]) and arg_141_1.var_.characterEffect1038ui_story then
				arg_141_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.775

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(103802035).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 31 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 31)

				if (31 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 31)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play103802036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 103802036
		arg_145_1.duration_ = 5.07

		local var_145_0 = {
			ja = 4.6,
			ko = 5.066,
			en = 4.5
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
				arg_145_0:Play103802037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1038ui_story"]) and arg_145_1.var_.characterEffect1038ui_story == nil then
				arg_145_1.var_.characterEffect1038ui_story = arg_145_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.1

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1038ui_story"]) then
				if arg_145_1.var_.characterEffect1038ui_story and not isNil(arg_145_1.actors_["1038ui_story"]) then
					arg_145_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1038ui_story"]) and arg_145_1.var_.characterEffect1038ui_story then
				arg_145_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action476")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_148_2 = 0
			local var_148_3 = 0.575

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_4 = arg_145_1:GetWordFromCfg(103802036)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 23 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 23)

				if (23 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 23)) > 0 and var_148_3 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802036", "story_v_side_old_103802.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802036", "story_v_side_old_103802.awb") / 1000

					if var_148_8 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_2
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_side_old_103802", "103802036", "story_v_side_old_103802.awb")

						arg_145_1:RecordAudio("103802036", var_148_9)
						arg_145_1:RecordAudio("103802036", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802036", "story_v_side_old_103802.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802036", "story_v_side_old_103802.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_10 and arg_145_1.time_ < var_148_2 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play103802037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 103802037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play103802038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1038ui_story"]) and arg_149_1.var_.characterEffect1038ui_story == nil then
				arg_149_1.var_.characterEffect1038ui_story = arg_149_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.1

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1038ui_story"]) then
				if arg_149_1.var_.characterEffect1038ui_story and not isNil(arg_149_1.actors_["1038ui_story"]) then
					arg_149_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1038ui_story"]) and arg_149_1.var_.characterEffect1038ui_story then
				arg_149_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_152_1 = 0
			local var_152_2 = 0.475

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(103802037).content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 19 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 19)

				if (19 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 19)) > 0 and var_152_2 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_6 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_6 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_6

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_6 and arg_149_1.time_ < var_152_1 + var_152_6 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play103802038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 103802038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play103802039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.6

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(103802038).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 24 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 24)

				if (24 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 24)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play103802039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 103802039
		arg_157_1.duration_ = 11.23

		local var_157_0 = {
			ja = 9.866,
			ko = 11.233,
			en = 7.566
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
				arg_157_0:Play103802040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1038ui_story"]) and arg_157_1.var_.characterEffect1038ui_story == nil then
				arg_157_1.var_.characterEffect1038ui_story = arg_157_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.1

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1038ui_story"]) then
				if arg_157_1.var_.characterEffect1038ui_story and not isNil(arg_157_1.actors_["1038ui_story"]) then
					arg_157_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1038ui_story"]) and arg_157_1.var_.characterEffect1038ui_story then
				arg_157_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action465")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_160_2 = 0
			local var_160_3 = 1.1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:GetWordFromCfg(103802039)
				local var_160_5 = arg_157_1:FormatText(var_160_4.content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 44 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 44)

				if (44 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 44)) > 0 and var_160_3 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802039", "story_v_side_old_103802.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802039", "story_v_side_old_103802.awb") / 1000

					if var_160_8 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_2
					end

					if var_160_4.prefab_name ~= "" and arg_157_1.actors_[var_160_4.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_4.prefab_name].transform, "story_v_side_old_103802", "103802039", "story_v_side_old_103802.awb")

						arg_157_1:RecordAudio("103802039", var_160_9)
						arg_157_1:RecordAudio("103802039", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802039", "story_v_side_old_103802.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802039", "story_v_side_old_103802.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_10 and arg_157_1.time_ < var_160_2 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play103802040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 103802040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play103802041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1038ui_story"]) and arg_161_1.var_.characterEffect1038ui_story == nil then
				arg_161_1.var_.characterEffect1038ui_story = arg_161_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.1

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1038ui_story"]) then
				if arg_161_1.var_.characterEffect1038ui_story and not isNil(arg_161_1.actors_["1038ui_story"]) then
					arg_161_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_0)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1038ui_story"]) and arg_161_1.var_.characterEffect1038ui_story then
				arg_161_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_164_1 = 0
			local var_164_2 = 0.25

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(103802040).content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 10 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 10)

				if (10 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 10)) > 0 and var_164_2 < var_164_5 then
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

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play103802041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 103802041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play103802042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPosD02b = arg_165_1.bgs_.D02b.transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.bgs_.D02b.transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPosD02b, Vector3.New(0, -100, 10), (arg_165_1.time_ - 0) / var_168_0)
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.bgs_.D02b.transform.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_1 = arg_165_1.bgs_.B13

				arg_165_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_168_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_2 = var_168_1:GetComponent("SpriteRenderer")

				if var_168_2 and var_168_2.sprite then
					local var_168_3 = 2 * (var_168_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_168_1.transform.localScale = Vector3.New(var_168_3 / var_168_2.sprite.bounds.size.y < var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x and var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x or var_168_3 / var_168_2.sprite.bounds.size.y, var_168_3 / var_168_2.sprite.bounds.size.y < var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x and var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x or var_168_3 / var_168_2.sprite.bounds.size.y, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "B13" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_4 = arg_165_1.actors_["1038ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1038ui_story = var_168_4.localPosition
			end

			local var_168_5 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 then
				var_168_4.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1038ui_story, Vector3.New(30, -1.16, -5.3), (arg_165_1.time_ - 0) / var_168_5)
				var_168_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_4.position).x, (manager.ui.mainCamera.transform.position - var_168_4.position).y, (manager.ui.mainCamera.transform.position - var_168_4.position).z)
				var_168_4.localEulerAngles.z = 0
				var_168_4.localEulerAngles.x = 0
				var_168_4.localEulerAngles = var_168_4.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 then
				var_168_4.localPosition = Vector3.New(30, -1.16, -5.3)
				var_168_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_4.position).x, (manager.ui.mainCamera.transform.position - var_168_4.position).y, (manager.ui.mainCamera.transform.position - var_168_4.position).z)
				var_168_4.localEulerAngles.z = 0
				var_168_4.localEulerAngles.x = 0
				var_168_4.localEulerAngles = var_168_4.localEulerAngles
			end

			local var_168_6 = 0
			local var_168_7 = 0.9

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(103802041).content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 36 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_8) / 36)

				if (36 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_8) / 36)) > 0 and var_168_7 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_11 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_11 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_11

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_11 and arg_165_1.time_ < var_168_6 + var_168_11 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "D02b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play103802042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 103802042
		arg_169_1.duration_ = 7.2

		local var_169_0 = {
			ja = 7.2,
			ko = 5.4,
			en = 6.2
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play103802043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1019ui_story"]) and arg_169_1.var_.characterEffect1019ui_story == nil then
				arg_169_1.var_.characterEffect1019ui_story = arg_169_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.1

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1019ui_story"]) then
				if arg_169_1.var_.characterEffect1019ui_story and not isNil(arg_169_1.actors_["1019ui_story"]) then
					arg_169_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1019ui_story"]) and arg_169_1.var_.characterEffect1019ui_story then
				arg_169_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_172_2 = arg_169_1.actors_["1019ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1019ui_story = var_172_2.localPosition
			end

			local var_172_3 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 then
				var_172_2.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1019ui_story, Vector3.New(0, -1.13, -5.3), (arg_169_1.time_ - 0) / var_172_3)
				var_172_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_2.position).x, (manager.ui.mainCamera.transform.position - var_172_2.position).y, (manager.ui.mainCamera.transform.position - var_172_2.position).z)
				var_172_2.localEulerAngles.z = 0
				var_172_2.localEulerAngles.x = 0
				var_172_2.localEulerAngles = var_172_2.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 then
				var_172_2.localPosition = Vector3.New(0, -1.13, -5.3)
				var_172_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_2.position).x, (manager.ui.mainCamera.transform.position - var_172_2.position).y, (manager.ui.mainCamera.transform.position - var_172_2.position).z)
				var_172_2.localEulerAngles.z = 0
				var_172_2.localEulerAngles.x = 0
				var_172_2.localEulerAngles = var_172_2.localEulerAngles
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_172_4 = 0
			local var_172_5 = 0.7

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(103802042)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 28 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 28)

				if (28 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 28)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802042", "story_v_side_old_103802.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802042", "story_v_side_old_103802.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_side_old_103802", "103802042", "story_v_side_old_103802.awb")

						arg_169_1:RecordAudio("103802042", var_172_11)
						arg_169_1:RecordAudio("103802042", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802042", "story_v_side_old_103802.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802042", "story_v_side_old_103802.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play103802043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 103802043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play103802044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1019ui_story"]) and arg_173_1.var_.characterEffect1019ui_story == nil then
				arg_173_1.var_.characterEffect1019ui_story = arg_173_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.1

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1019ui_story"]) then
				if arg_173_1.var_.characterEffect1019ui_story and not isNil(arg_173_1.actors_["1019ui_story"]) then
					arg_173_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1019ui_story"]) and arg_173_1.var_.characterEffect1019ui_story then
				arg_173_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_176_1 = 0
			local var_176_2 = 0.3

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(103802043).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 12 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 12)

				if (12 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 12)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play103802044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 103802044
		arg_177_1.duration_ = 8.9

		local var_177_0 = {
			ja = 6.533,
			ko = 7.6,
			en = 8.9
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play103802045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if arg_177_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_180_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_177_1.stage_.transform)

				var_180_0.name = "1080ui_story"
				var_180_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.actors_["1080ui_story"] = var_180_0

				local var_180_1 = var_180_0:GetComponentInChildren(typeof(CharacterEffect))

				var_180_1.enabled = true

				local var_180_2 = GameObjectTools.GetOrAddComponent(var_180_0, typeof(DynamicBoneHelper))

				if var_180_2 then
					var_180_2:EnableDynamicBone(false)
				end

				arg_177_1:ShowWeapon(var_180_1.transform, false)

				arg_177_1.var_["1080ui_story" .. "Animator"] = var_180_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_177_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_177_1.var_["1080ui_story" .. "LipSync"] = var_180_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_180_3 = arg_177_1.actors_["1080ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.characterEffect1080ui_story == nil then
				arg_177_1.var_.characterEffect1080ui_story = var_180_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_4 = 0.1

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 and not isNil(var_180_3) then
				if arg_177_1.var_.characterEffect1080ui_story and not isNil(var_180_3) then
					arg_177_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.characterEffect1080ui_story then
				arg_177_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_180_6 = arg_177_1.actors_["1019ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1019ui_story = var_180_6.localPosition
			end

			local var_180_7 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				var_180_6.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1019ui_story, Vector3.New(10, -1.13, -5.3), (arg_177_1.time_ - 0) / var_180_7)
				var_180_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_6.position).x, (manager.ui.mainCamera.transform.position - var_180_6.position).y, (manager.ui.mainCamera.transform.position - var_180_6.position).z)
				var_180_6.localEulerAngles.z = 0
				var_180_6.localEulerAngles.x = 0
				var_180_6.localEulerAngles = var_180_6.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				var_180_6.localPosition = Vector3.New(10, -1.13, -5.3)
				var_180_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_6.position).x, (manager.ui.mainCamera.transform.position - var_180_6.position).y, (manager.ui.mainCamera.transform.position - var_180_6.position).z)
				var_180_6.localEulerAngles.z = 0
				var_180_6.localEulerAngles.x = 0
				var_180_6.localEulerAngles = var_180_6.localEulerAngles
			end

			local var_180_8 = arg_177_1.actors_["1080ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1080ui_story = var_180_8.localPosition
			end

			local var_180_9 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_9 then
				var_180_8.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1080ui_story, Vector3.New(0, -0.97, -5.5), (arg_177_1.time_ - 0) / var_180_9)
				var_180_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_8.position).x, (manager.ui.mainCamera.transform.position - var_180_8.position).y, (manager.ui.mainCamera.transform.position - var_180_8.position).z)
				var_180_8.localEulerAngles.z = 0
				var_180_8.localEulerAngles.x = 0
				var_180_8.localEulerAngles = var_180_8.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_9 and arg_177_1.time_ < 0 + var_180_9 + arg_180_0 then
				var_180_8.localPosition = Vector3.New(0, -0.97, -5.5)
				var_180_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_8.position).x, (manager.ui.mainCamera.transform.position - var_180_8.position).y, (manager.ui.mainCamera.transform.position - var_180_8.position).z)
				var_180_8.localEulerAngles.z = 0
				var_180_8.localEulerAngles.x = 0
				var_180_8.localEulerAngles = var_180_8.localEulerAngles
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_180_10 = 0
			local var_180_11 = 0.9

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_12 = arg_177_1:GetWordFromCfg(103802044)
				local var_180_13 = arg_177_1:FormatText(var_180_12.content)

				arg_177_1.text_.text = var_180_13

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_15 = 36 <= 0 and var_180_11 or var_180_11 * (utf8.len(var_180_13) / 36)

				if (36 <= 0 and var_180_11 or var_180_11 * (utf8.len(var_180_13) / 36)) > 0 and var_180_11 < var_180_15 then
					arg_177_1.talkMaxDuration = var_180_15

					if var_180_15 + var_180_10 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_10
					end
				end

				arg_177_1.text_.text = var_180_13
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802044", "story_v_side_old_103802.awb") ~= 0 then
					local var_180_16 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802044", "story_v_side_old_103802.awb") / 1000

					if var_180_16 + var_180_10 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_16 + var_180_10
					end

					if var_180_12.prefab_name ~= "" and arg_177_1.actors_[var_180_12.prefab_name] ~= nil then
						local var_180_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_12.prefab_name].transform, "story_v_side_old_103802", "103802044", "story_v_side_old_103802.awb")

						arg_177_1:RecordAudio("103802044", var_180_17)
						arg_177_1:RecordAudio("103802044", var_180_17)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802044", "story_v_side_old_103802.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802044", "story_v_side_old_103802.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_18 = math.max(var_180_11, arg_177_1.talkMaxDuration)

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_18 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_10) / var_180_18

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_10 + var_180_18 and arg_177_1.time_ < var_180_10 + var_180_18 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play103802045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 103802045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play103802046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1080ui_story"]) and arg_181_1.var_.characterEffect1080ui_story == nil then
				arg_181_1.var_.characterEffect1080ui_story = arg_181_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.1

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1080ui_story"]) then
				if arg_181_1.var_.characterEffect1080ui_story and not isNil(arg_181_1.actors_["1080ui_story"]) then
					arg_181_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1080ui_story"]) and arg_181_1.var_.characterEffect1080ui_story then
				arg_181_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.35

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(103802045).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 14 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 14)

				if (14 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 14)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play103802046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 103802046
		arg_185_1.duration_ = 12.8

		local var_185_0 = {
			ja = 12.8,
			ko = 7.166,
			en = 6.433
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
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play103802047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if arg_185_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_188_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_185_1.stage_.transform)

				var_188_0.name = "1059ui_story"
				var_188_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["1059ui_story"] = var_188_0

				local var_188_1 = var_188_0:GetComponentInChildren(typeof(CharacterEffect))

				var_188_1.enabled = true

				local var_188_2 = GameObjectTools.GetOrAddComponent(var_188_0, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(false)
				end

				arg_185_1:ShowWeapon(var_188_1.transform, false)

				arg_185_1.var_["1059ui_story" .. "Animator"] = var_188_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_185_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_185_1.var_["1059ui_story" .. "LipSync"] = var_188_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_188_3 = arg_185_1.actors_["1059ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect1059ui_story == nil then
				arg_185_1.var_.characterEffect1059ui_story = var_188_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_4 = 0.1

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 and not isNil(var_188_3) then
				if arg_185_1.var_.characterEffect1059ui_story and not isNil(var_188_3) then
					arg_185_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect1059ui_story then
				arg_185_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_188_6 = arg_185_1.actors_["1080ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1080ui_story = var_188_6.localPosition
			end

			local var_188_7 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				var_188_6.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1080ui_story, Vector3.New(20, -0.97, -5.5), (arg_185_1.time_ - 0) / var_188_7)
				var_188_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_6.position).x, (manager.ui.mainCamera.transform.position - var_188_6.position).y, (manager.ui.mainCamera.transform.position - var_188_6.position).z)
				var_188_6.localEulerAngles.z = 0
				var_188_6.localEulerAngles.x = 0
				var_188_6.localEulerAngles = var_188_6.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				var_188_6.localPosition = Vector3.New(20, -0.97, -5.5)
				var_188_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_6.position).x, (manager.ui.mainCamera.transform.position - var_188_6.position).y, (manager.ui.mainCamera.transform.position - var_188_6.position).z)
				var_188_6.localEulerAngles.z = 0
				var_188_6.localEulerAngles.x = 0
				var_188_6.localEulerAngles = var_188_6.localEulerAngles
			end

			local var_188_8 = arg_185_1.actors_["1059ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1059ui_story = var_188_8.localPosition
			end

			local var_188_9 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_9 then
				var_188_8.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.1, -5.4), (arg_185_1.time_ - 0) / var_188_9)
				var_188_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_8.position).x, (manager.ui.mainCamera.transform.position - var_188_8.position).y, (manager.ui.mainCamera.transform.position - var_188_8.position).z)
				var_188_8.localEulerAngles.z = 0
				var_188_8.localEulerAngles.x = 0
				var_188_8.localEulerAngles = var_188_8.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_9 and arg_185_1.time_ < 0 + var_188_9 + arg_188_0 then
				var_188_8.localPosition = Vector3.New(0, -1.1, -5.4)
				var_188_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_8.position).x, (manager.ui.mainCamera.transform.position - var_188_8.position).y, (manager.ui.mainCamera.transform.position - var_188_8.position).z)
				var_188_8.localEulerAngles.z = 0
				var_188_8.localEulerAngles.x = 0
				var_188_8.localEulerAngles = var_188_8.localEulerAngles
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_188_10 = 0
			local var_188_11 = 0.7

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_12 = arg_185_1:GetWordFromCfg(103802046)
				local var_188_13 = arg_185_1:FormatText(var_188_12.content)

				arg_185_1.text_.text = var_188_13

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_15 = 28 <= 0 and var_188_11 or var_188_11 * (utf8.len(var_188_13) / 28)

				if (28 <= 0 and var_188_11 or var_188_11 * (utf8.len(var_188_13) / 28)) > 0 and var_188_11 < var_188_15 then
					arg_185_1.talkMaxDuration = var_188_15

					if var_188_15 + var_188_10 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_10
					end
				end

				arg_185_1.text_.text = var_188_13
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802046", "story_v_side_old_103802.awb") ~= 0 then
					local var_188_16 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802046", "story_v_side_old_103802.awb") / 1000

					if var_188_16 + var_188_10 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_16 + var_188_10
					end

					if var_188_12.prefab_name ~= "" and arg_185_1.actors_[var_188_12.prefab_name] ~= nil then
						local var_188_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_12.prefab_name].transform, "story_v_side_old_103802", "103802046", "story_v_side_old_103802.awb")

						arg_185_1:RecordAudio("103802046", var_188_17)
						arg_185_1:RecordAudio("103802046", var_188_17)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802046", "story_v_side_old_103802.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802046", "story_v_side_old_103802.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_18 = math.max(var_188_11, arg_185_1.talkMaxDuration)

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_18 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_10) / var_188_18

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_10 + var_188_18 and arg_185_1.time_ < var_188_10 + var_188_18 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play103802047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 103802047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play103802048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1059ui_story"]) and arg_189_1.var_.characterEffect1059ui_story == nil then
				arg_189_1.var_.characterEffect1059ui_story = arg_189_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.1

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1059ui_story"]) then
				if arg_189_1.var_.characterEffect1059ui_story and not isNil(arg_189_1.actors_["1059ui_story"]) then
					arg_189_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1059ui_story"]) and arg_189_1.var_.characterEffect1059ui_story then
				arg_189_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 0.475

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(103802047).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 19 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 19)

				if (19 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 19)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play103802048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 103802048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play103802049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPosB13 = arg_193_1.bgs_.B13.transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.bgs_.B13.transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPosB13, Vector3.New(0, -100, 10), (arg_193_1.time_ - 0) / var_196_0)
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.bgs_.B13.transform.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				local var_196_1 = arg_193_1.bgs_.D02b

				arg_193_1.bgs_.D02b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_196_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_2 = var_196_1:GetComponent("SpriteRenderer")

				if var_196_2 and var_196_2.sprite then
					local var_196_3 = 2 * (var_196_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_196_1.transform.localScale = Vector3.New(var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "D02b" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_4 = arg_193_1.actors_["1059ui_story"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1059ui_story = var_196_4.localPosition
			end

			local var_196_5 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_5 then
				var_196_4.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1059ui_story, Vector3.New(20, -1.1, -5.4), (arg_193_1.time_ - 0) / var_196_5)
				var_196_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_4.position).x, (manager.ui.mainCamera.transform.position - var_196_4.position).y, (manager.ui.mainCamera.transform.position - var_196_4.position).z)
				var_196_4.localEulerAngles.z = 0
				var_196_4.localEulerAngles.x = 0
				var_196_4.localEulerAngles = var_196_4.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_5 and arg_193_1.time_ < 0 + var_196_5 + arg_196_0 then
				var_196_4.localPosition = Vector3.New(20, -1.1, -5.4)
				var_196_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_4.position).x, (manager.ui.mainCamera.transform.position - var_196_4.position).y, (manager.ui.mainCamera.transform.position - var_196_4.position).z)
				var_196_4.localEulerAngles.z = 0
				var_196_4.localEulerAngles.x = 0
				var_196_4.localEulerAngles = var_196_4.localEulerAngles
			end

			local var_196_6 = 0
			local var_196_7 = 0.95

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(103802048).content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 38 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_8) / 38)

				if (38 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_8) / 38)) > 0 and var_196_7 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_11 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_11 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_11

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_11 and arg_193_1.time_ < var_196_6 + var_196_11 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B13",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play103802049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 103802049
		arg_197_1.duration_ = 12.03

		local var_197_0 = {
			ja = 10.766,
			ko = 7.666,
			en = 12.033
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
				arg_197_0:Play103802050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1038ui_story"]) and arg_197_1.var_.characterEffect1038ui_story == nil then
				arg_197_1.var_.characterEffect1038ui_story = arg_197_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.1

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1038ui_story"]) then
				if arg_197_1.var_.characterEffect1038ui_story and not isNil(arg_197_1.actors_["1038ui_story"]) then
					arg_197_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1038ui_story"]) and arg_197_1.var_.characterEffect1038ui_story then
				arg_197_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_200_2 = arg_197_1.actors_["1038ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1038ui_story = var_200_2.localPosition
			end

			local var_200_3 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 then
				var_200_2.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.16, -5.3), (arg_197_1.time_ - 0) / var_200_3)
				var_200_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_2.position).x, (manager.ui.mainCamera.transform.position - var_200_2.position).y, (manager.ui.mainCamera.transform.position - var_200_2.position).z)
				var_200_2.localEulerAngles.z = 0
				var_200_2.localEulerAngles.x = 0
				var_200_2.localEulerAngles = var_200_2.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 then
				var_200_2.localPosition = Vector3.New(0, -1.16, -5.3)
				var_200_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_2.position).x, (manager.ui.mainCamera.transform.position - var_200_2.position).y, (manager.ui.mainCamera.transform.position - var_200_2.position).z)
				var_200_2.localEulerAngles.z = 0
				var_200_2.localEulerAngles.x = 0
				var_200_2.localEulerAngles = var_200_2.localEulerAngles
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_200_4 = 0
			local var_200_5 = 1.075

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(103802049)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 43 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 43)

				if (43 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 43)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802049", "story_v_side_old_103802.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802049", "story_v_side_old_103802.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_side_old_103802", "103802049", "story_v_side_old_103802.awb")

						arg_197_1:RecordAudio("103802049", var_200_11)
						arg_197_1:RecordAudio("103802049", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802049", "story_v_side_old_103802.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802049", "story_v_side_old_103802.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_12 and arg_197_1.time_ < var_200_4 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play103802050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 103802050
		arg_201_1.duration_ = 2.8

		local var_201_0 = {
			ja = 2.8,
			ko = 2.566,
			en = 2.5
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
				arg_201_0:Play103802051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action457")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_204_0 = 0
			local var_204_1 = 0.275

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(103802050)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 11 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 11)

				if (11 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 11)) > 0 and var_204_1 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802050", "story_v_side_old_103802.awb") ~= 0 then
					local var_204_6 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802050", "story_v_side_old_103802.awb") / 1000

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end

					if var_204_2.prefab_name ~= "" and arg_201_1.actors_[var_204_2.prefab_name] ~= nil then
						local var_204_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_2.prefab_name].transform, "story_v_side_old_103802", "103802050", "story_v_side_old_103802.awb")

						arg_201_1:RecordAudio("103802050", var_204_7)
						arg_201_1:RecordAudio("103802050", var_204_7)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802050", "story_v_side_old_103802.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802050", "story_v_side_old_103802.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play103802051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 103802051
		arg_205_1.duration_ = 21.03

		local var_205_0 = {
			ja = 16.266,
			ko = 15.9,
			en = 21.033
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
				arg_205_0:Play103802052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if arg_205_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_208_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_205_1.stage_.transform)

				var_208_0.name = "1084ui_story"
				var_208_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.actors_["1084ui_story"] = var_208_0

				local var_208_1 = var_208_0:GetComponentInChildren(typeof(CharacterEffect))

				var_208_1.enabled = true

				local var_208_2 = GameObjectTools.GetOrAddComponent(var_208_0, typeof(DynamicBoneHelper))

				if var_208_2 then
					var_208_2:EnableDynamicBone(false)
				end

				arg_205_1:ShowWeapon(var_208_1.transform, false)

				arg_205_1.var_["1084ui_story" .. "Animator"] = var_208_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_205_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_205_1.var_["1084ui_story" .. "LipSync"] = var_208_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_208_3 = arg_205_1.actors_["1084ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect1084ui_story == nil then
				arg_205_1.var_.characterEffect1084ui_story = var_208_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_4 = 0.1

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 and not isNil(var_208_3) then
				if arg_205_1.var_.characterEffect1084ui_story and not isNil(var_208_3) then
					arg_205_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect1084ui_story then
				arg_205_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_208_6 = arg_205_1.actors_["1038ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect1038ui_story == nil then
				arg_205_1.var_.characterEffect1038ui_story = var_208_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_7 = 0.1

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 and not isNil(var_208_6) then
				if arg_205_1.var_.characterEffect1038ui_story and not isNil(var_208_6) then
					arg_205_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_7)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect1038ui_story then
				arg_205_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_208_8 = arg_205_1.actors_["1038ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1038ui_story = var_208_8.localPosition
			end

			local var_208_9 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_9 then
				var_208_8.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1038ui_story, Vector3.New(30, -1.16, -5.3), (arg_205_1.time_ - 0) / var_208_9)
				var_208_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_8.position).x, (manager.ui.mainCamera.transform.position - var_208_8.position).y, (manager.ui.mainCamera.transform.position - var_208_8.position).z)
				var_208_8.localEulerAngles.z = 0
				var_208_8.localEulerAngles.x = 0
				var_208_8.localEulerAngles = var_208_8.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_9 and arg_205_1.time_ < 0 + var_208_9 + arg_208_0 then
				var_208_8.localPosition = Vector3.New(30, -1.16, -5.3)
				var_208_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_8.position).x, (manager.ui.mainCamera.transform.position - var_208_8.position).y, (manager.ui.mainCamera.transform.position - var_208_8.position).z)
				var_208_8.localEulerAngles.z = 0
				var_208_8.localEulerAngles.x = 0
				var_208_8.localEulerAngles = var_208_8.localEulerAngles
			end

			local var_208_10 = arg_205_1.actors_["1084ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1084ui_story = var_208_10.localPosition
			end

			local var_208_11 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_11 then
				var_208_10.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1084ui_story, Vector3.New(0, -1.16, -5), (arg_205_1.time_ - 0) / var_208_11)
				var_208_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_10.position).x, (manager.ui.mainCamera.transform.position - var_208_10.position).y, (manager.ui.mainCamera.transform.position - var_208_10.position).z)
				var_208_10.localEulerAngles.z = 0
				var_208_10.localEulerAngles.x = 0
				var_208_10.localEulerAngles = var_208_10.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_11 and arg_205_1.time_ < 0 + var_208_11 + arg_208_0 then
				var_208_10.localPosition = Vector3.New(0, -1.16, -5)
				var_208_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_10.position).x, (manager.ui.mainCamera.transform.position - var_208_10.position).y, (manager.ui.mainCamera.transform.position - var_208_10.position).z)
				var_208_10.localEulerAngles.z = 0
				var_208_10.localEulerAngles.x = 0
				var_208_10.localEulerAngles = var_208_10.localEulerAngles
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_208_12 = 0
			local var_208_13 = 1.55

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_12 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_14 = arg_205_1:GetWordFromCfg(103802051)
				local var_208_15 = arg_205_1:FormatText(var_208_14.content)

				arg_205_1.text_.text = var_208_15

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_17 = 62 <= 0 and var_208_13 or var_208_13 * (utf8.len(var_208_15) / 62)

				if (62 <= 0 and var_208_13 or var_208_13 * (utf8.len(var_208_15) / 62)) > 0 and var_208_13 < var_208_17 then
					arg_205_1.talkMaxDuration = var_208_17

					if var_208_17 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_17 + var_208_12
					end
				end

				arg_205_1.text_.text = var_208_15
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802051", "story_v_side_old_103802.awb") ~= 0 then
					local var_208_18 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802051", "story_v_side_old_103802.awb") / 1000

					if var_208_18 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_18 + var_208_12
					end

					if var_208_14.prefab_name ~= "" and arg_205_1.actors_[var_208_14.prefab_name] ~= nil then
						local var_208_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_14.prefab_name].transform, "story_v_side_old_103802", "103802051", "story_v_side_old_103802.awb")

						arg_205_1:RecordAudio("103802051", var_208_19)
						arg_205_1:RecordAudio("103802051", var_208_19)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802051", "story_v_side_old_103802.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802051", "story_v_side_old_103802.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_20 = math.max(var_208_13, arg_205_1.talkMaxDuration)

			if var_208_12 <= arg_205_1.time_ and arg_205_1.time_ < var_208_12 + var_208_20 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_12) / var_208_20

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_12 + var_208_20 and arg_205_1.time_ < var_208_12 + var_208_20 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play103802052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 103802052
		arg_209_1.duration_ = 13.23

		local var_209_0 = {
			ja = 9.466,
			ko = 13.233,
			en = 10.4
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
				arg_209_0:Play103802053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1038ui_story"]) and arg_209_1.var_.characterEffect1038ui_story == nil then
				arg_209_1.var_.characterEffect1038ui_story = arg_209_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.1

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1038ui_story"]) then
				if arg_209_1.var_.characterEffect1038ui_story and not isNil(arg_209_1.actors_["1038ui_story"]) then
					arg_209_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1038ui_story"]) and arg_209_1.var_.characterEffect1038ui_story then
				arg_209_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_212_2 = arg_209_1.actors_["1084ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect1084ui_story == nil then
				arg_209_1.var_.characterEffect1084ui_story = var_212_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_3 = 0.1

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.characterEffect1084ui_story and not isNil(var_212_2) then
					arg_209_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_3)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect1084ui_story then
				arg_209_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_212_4 = arg_209_1.actors_["1084ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1084ui_story = var_212_4.localPosition
			end

			local var_212_5 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 then
				var_212_4.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1084ui_story, Vector3.New(20, -1.16, -5), (arg_209_1.time_ - 0) / var_212_5)
				var_212_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_4.position).x, (manager.ui.mainCamera.transform.position - var_212_4.position).y, (manager.ui.mainCamera.transform.position - var_212_4.position).z)
				var_212_4.localEulerAngles.z = 0
				var_212_4.localEulerAngles.x = 0
				var_212_4.localEulerAngles = var_212_4.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 then
				var_212_4.localPosition = Vector3.New(20, -1.16, -5)
				var_212_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_4.position).x, (manager.ui.mainCamera.transform.position - var_212_4.position).y, (manager.ui.mainCamera.transform.position - var_212_4.position).z)
				var_212_4.localEulerAngles.z = 0
				var_212_4.localEulerAngles.x = 0
				var_212_4.localEulerAngles = var_212_4.localEulerAngles
			end

			local var_212_6 = arg_209_1.actors_["1038ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1038ui_story = var_212_6.localPosition
			end

			local var_212_7 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				var_212_6.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.16, -5.3), (arg_209_1.time_ - 0) / var_212_7)
				var_212_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_6.position).x, (manager.ui.mainCamera.transform.position - var_212_6.position).y, (manager.ui.mainCamera.transform.position - var_212_6.position).z)
				var_212_6.localEulerAngles.z = 0
				var_212_6.localEulerAngles.x = 0
				var_212_6.localEulerAngles = var_212_6.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				var_212_6.localPosition = Vector3.New(0, -1.16, -5.3)
				var_212_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_6.position).x, (manager.ui.mainCamera.transform.position - var_212_6.position).y, (manager.ui.mainCamera.transform.position - var_212_6.position).z)
				var_212_6.localEulerAngles.z = 0
				var_212_6.localEulerAngles.x = 0
				var_212_6.localEulerAngles = var_212_6.localEulerAngles
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action6_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_212_8 = 0
			local var_212_9 = 1

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(103802052)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 40 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 40)

				if (40 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 40)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802052", "story_v_side_old_103802.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802052", "story_v_side_old_103802.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_side_old_103802", "103802052", "story_v_side_old_103802.awb")

						arg_209_1:RecordAudio("103802052", var_212_15)
						arg_209_1:RecordAudio("103802052", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802052", "story_v_side_old_103802.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802052", "story_v_side_old_103802.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play103802053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 103802053
		arg_213_1.duration_ = 21

		local var_213_0 = {
			ja = 21,
			ko = 15.3,
			en = 12.833
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
				arg_213_0:Play103802054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_216_0 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_213_1.stage_.transform)

				var_216_0.name = "1039ui_story"
				var_216_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_["1039ui_story"] = var_216_0

				local var_216_1 = var_216_0:GetComponentInChildren(typeof(CharacterEffect))

				var_216_1.enabled = true

				local var_216_2 = GameObjectTools.GetOrAddComponent(var_216_0, typeof(DynamicBoneHelper))

				if var_216_2 then
					var_216_2:EnableDynamicBone(false)
				end

				arg_213_1:ShowWeapon(var_216_1.transform, false)

				arg_213_1.var_["1039ui_story" .. "Animator"] = var_216_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_213_1.var_["1039ui_story" .. "Animator"].applyRootMotion = true
				arg_213_1.var_["1039ui_story" .. "LipSync"] = var_216_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_216_3 = arg_213_1.actors_["1039ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect1039ui_story == nil then
				arg_213_1.var_.characterEffect1039ui_story = var_216_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_4 = 0.1

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 and not isNil(var_216_3) then
				if arg_213_1.var_.characterEffect1039ui_story and not isNil(var_216_3) then
					arg_213_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect1039ui_story then
				arg_213_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_216_6 = arg_213_1.actors_["1038ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1038ui_story == nil then
				arg_213_1.var_.characterEffect1038ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_7 = 0.1

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 and not isNil(var_216_6) then
				if arg_213_1.var_.characterEffect1038ui_story and not isNil(var_216_6) then
					arg_213_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_7)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1038ui_story then
				arg_213_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_216_8 = arg_213_1.actors_["1038ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1038ui_story = var_216_8.localPosition
			end

			local var_216_9 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_9 then
				var_216_8.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1038ui_story, Vector3.New(30, -1.16, -5.3), (arg_213_1.time_ - 0) / var_216_9)
				var_216_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_8.position).x, (manager.ui.mainCamera.transform.position - var_216_8.position).y, (manager.ui.mainCamera.transform.position - var_216_8.position).z)
				var_216_8.localEulerAngles.z = 0
				var_216_8.localEulerAngles.x = 0
				var_216_8.localEulerAngles = var_216_8.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_9 and arg_213_1.time_ < 0 + var_216_9 + arg_216_0 then
				var_216_8.localPosition = Vector3.New(30, -1.16, -5.3)
				var_216_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_8.position).x, (manager.ui.mainCamera.transform.position - var_216_8.position).y, (manager.ui.mainCamera.transform.position - var_216_8.position).z)
				var_216_8.localEulerAngles.z = 0
				var_216_8.localEulerAngles.x = 0
				var_216_8.localEulerAngles = var_216_8.localEulerAngles
			end

			local var_216_10 = arg_213_1.actors_["1039ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1039ui_story = var_216_10.localPosition
			end

			local var_216_11 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_11 then
				var_216_10.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_213_1.time_ - 0) / var_216_11)
				var_216_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_10.position).x, (manager.ui.mainCamera.transform.position - var_216_10.position).y, (manager.ui.mainCamera.transform.position - var_216_10.position).z)
				var_216_10.localEulerAngles.z = 0
				var_216_10.localEulerAngles.x = 0
				var_216_10.localEulerAngles = var_216_10.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_11 and arg_213_1.time_ < 0 + var_216_11 + arg_216_0 then
				var_216_10.localPosition = Vector3.New(0, -1.06, -5.3)
				var_216_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_10.position).x, (manager.ui.mainCamera.transform.position - var_216_10.position).y, (manager.ui.mainCamera.transform.position - var_216_10.position).z)
				var_216_10.localEulerAngles.z = 0
				var_216_10.localEulerAngles.x = 0
				var_216_10.localEulerAngles = var_216_10.localEulerAngles
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_216_12 = 0
			local var_216_13 = 1.375

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_14 = arg_213_1:GetWordFromCfg(103802053)
				local var_216_15 = arg_213_1:FormatText(var_216_14.content)

				arg_213_1.text_.text = var_216_15

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_17 = 55 <= 0 and var_216_13 or var_216_13 * (utf8.len(var_216_15) / 55)

				if (55 <= 0 and var_216_13 or var_216_13 * (utf8.len(var_216_15) / 55)) > 0 and var_216_13 < var_216_17 then
					arg_213_1.talkMaxDuration = var_216_17

					if var_216_17 + var_216_12 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_17 + var_216_12
					end
				end

				arg_213_1.text_.text = var_216_15
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802053", "story_v_side_old_103802.awb") ~= 0 then
					local var_216_18 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802053", "story_v_side_old_103802.awb") / 1000

					if var_216_18 + var_216_12 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_18 + var_216_12
					end

					if var_216_14.prefab_name ~= "" and arg_213_1.actors_[var_216_14.prefab_name] ~= nil then
						local var_216_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_14.prefab_name].transform, "story_v_side_old_103802", "103802053", "story_v_side_old_103802.awb")

						arg_213_1:RecordAudio("103802053", var_216_19)
						arg_213_1:RecordAudio("103802053", var_216_19)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802053", "story_v_side_old_103802.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802053", "story_v_side_old_103802.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_20 = math.max(var_216_13, arg_213_1.talkMaxDuration)

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_20 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_12) / var_216_20

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_12 + var_216_20 and arg_213_1.time_ < var_216_12 + var_216_20 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play103802054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 103802054
		arg_217_1.duration_ = 6.53

		local var_217_0 = {
			ja = 5.966,
			ko = 6.533,
			en = 5.6
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
				arg_217_0:Play103802055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1038ui_story"]) and arg_217_1.var_.characterEffect1038ui_story == nil then
				arg_217_1.var_.characterEffect1038ui_story = arg_217_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.1

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1038ui_story"]) then
				if arg_217_1.var_.characterEffect1038ui_story and not isNil(arg_217_1.actors_["1038ui_story"]) then
					arg_217_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1038ui_story"]) and arg_217_1.var_.characterEffect1038ui_story then
				arg_217_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_220_2 = arg_217_1.actors_["1039ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.characterEffect1039ui_story == nil then
				arg_217_1.var_.characterEffect1039ui_story = var_220_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_3 = 0.1

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.characterEffect1039ui_story and not isNil(var_220_2) then
					arg_217_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_3)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.characterEffect1039ui_story then
				arg_217_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_220_4 = arg_217_1.actors_["1039ui_story"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1039ui_story = var_220_4.localPosition
			end

			local var_220_5 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_5 then
				var_220_4.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_217_1.time_ - 0) / var_220_5)
				var_220_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_4.position).x, (manager.ui.mainCamera.transform.position - var_220_4.position).y, (manager.ui.mainCamera.transform.position - var_220_4.position).z)
				var_220_4.localEulerAngles.z = 0
				var_220_4.localEulerAngles.x = 0
				var_220_4.localEulerAngles = var_220_4.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_5 and arg_217_1.time_ < 0 + var_220_5 + arg_220_0 then
				var_220_4.localPosition = Vector3.New(10, -1.06, -5.3)
				var_220_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_4.position).x, (manager.ui.mainCamera.transform.position - var_220_4.position).y, (manager.ui.mainCamera.transform.position - var_220_4.position).z)
				var_220_4.localEulerAngles.z = 0
				var_220_4.localEulerAngles.x = 0
				var_220_4.localEulerAngles = var_220_4.localEulerAngles
			end

			local var_220_6 = arg_217_1.actors_["1038ui_story"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1038ui_story = var_220_6.localPosition
			end

			local var_220_7 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				var_220_6.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.16, -5.3), (arg_217_1.time_ - 0) / var_220_7)
				var_220_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_6.position).x, (manager.ui.mainCamera.transform.position - var_220_6.position).y, (manager.ui.mainCamera.transform.position - var_220_6.position).z)
				var_220_6.localEulerAngles.z = 0
				var_220_6.localEulerAngles.x = 0
				var_220_6.localEulerAngles = var_220_6.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				var_220_6.localPosition = Vector3.New(0, -1.16, -5.3)
				var_220_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_6.position).x, (manager.ui.mainCamera.transform.position - var_220_6.position).y, (manager.ui.mainCamera.transform.position - var_220_6.position).z)
				var_220_6.localEulerAngles.z = 0
				var_220_6.localEulerAngles.x = 0
				var_220_6.localEulerAngles = var_220_6.localEulerAngles
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action2_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_220_8 = 0
			local var_220_9 = 0.575

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_10 = arg_217_1:GetWordFromCfg(103802054)
				local var_220_11 = arg_217_1:FormatText(var_220_10.content)

				arg_217_1.text_.text = var_220_11

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 23 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 23)

				if (23 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 23)) > 0 and var_220_9 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_11
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802054", "story_v_side_old_103802.awb") ~= 0 then
					local var_220_14 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802054", "story_v_side_old_103802.awb") / 1000

					if var_220_14 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_14 + var_220_8
					end

					if var_220_10.prefab_name ~= "" and arg_217_1.actors_[var_220_10.prefab_name] ~= nil then
						local var_220_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_10.prefab_name].transform, "story_v_side_old_103802", "103802054", "story_v_side_old_103802.awb")

						arg_217_1:RecordAudio("103802054", var_220_15)
						arg_217_1:RecordAudio("103802054", var_220_15)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802054", "story_v_side_old_103802.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802054", "story_v_side_old_103802.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_16 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_16 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_16

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_16 and arg_217_1.time_ < var_220_8 + var_220_16 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play103802055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 103802055
		arg_221_1.duration_ = 11.43

		local var_221_0 = {
			ja = 11.433,
			ko = 6.1,
			en = 6.266
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
				arg_221_0:Play103802056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1059ui_story"]) and arg_221_1.var_.characterEffect1059ui_story == nil then
				arg_221_1.var_.characterEffect1059ui_story = arg_221_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.1

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1059ui_story"]) then
				if arg_221_1.var_.characterEffect1059ui_story and not isNil(arg_221_1.actors_["1059ui_story"]) then
					arg_221_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1059ui_story"]) and arg_221_1.var_.characterEffect1059ui_story then
				arg_221_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_224_2 = arg_221_1.actors_["1038ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect1038ui_story == nil then
				arg_221_1.var_.characterEffect1038ui_story = var_224_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_3 = 0.1

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.characterEffect1038ui_story and not isNil(var_224_2) then
					arg_221_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_3)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect1038ui_story then
				arg_221_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_224_4 = arg_221_1.actors_["1038ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1038ui_story = var_224_4.localPosition
			end

			local var_224_5 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_5 then
				var_224_4.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1038ui_story, Vector3.New(30, -1.16, -5.3), (arg_221_1.time_ - 0) / var_224_5)
				var_224_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_4.position).x, (manager.ui.mainCamera.transform.position - var_224_4.position).y, (manager.ui.mainCamera.transform.position - var_224_4.position).z)
				var_224_4.localEulerAngles.z = 0
				var_224_4.localEulerAngles.x = 0
				var_224_4.localEulerAngles = var_224_4.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_5 and arg_221_1.time_ < 0 + var_224_5 + arg_224_0 then
				var_224_4.localPosition = Vector3.New(30, -1.16, -5.3)
				var_224_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_4.position).x, (manager.ui.mainCamera.transform.position - var_224_4.position).y, (manager.ui.mainCamera.transform.position - var_224_4.position).z)
				var_224_4.localEulerAngles.z = 0
				var_224_4.localEulerAngles.x = 0
				var_224_4.localEulerAngles = var_224_4.localEulerAngles
			end

			local var_224_6 = arg_221_1.actors_["1059ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1059ui_story = var_224_6.localPosition
			end

			local var_224_7 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				var_224_6.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.1, -5.4), (arg_221_1.time_ - 0) / var_224_7)
				var_224_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_6.position).x, (manager.ui.mainCamera.transform.position - var_224_6.position).y, (manager.ui.mainCamera.transform.position - var_224_6.position).z)
				var_224_6.localEulerAngles.z = 0
				var_224_6.localEulerAngles.x = 0
				var_224_6.localEulerAngles = var_224_6.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				var_224_6.localPosition = Vector3.New(0, -1.1, -5.4)
				var_224_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_6.position).x, (manager.ui.mainCamera.transform.position - var_224_6.position).y, (manager.ui.mainCamera.transform.position - var_224_6.position).z)
				var_224_6.localEulerAngles.z = 0
				var_224_6.localEulerAngles.x = 0
				var_224_6.localEulerAngles = var_224_6.localEulerAngles
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_224_8 = 0
			local var_224_9 = 0.525

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(103802055)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 21 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 21)

				if (21 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 21)) > 0 and var_224_9 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802055", "story_v_side_old_103802.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802055", "story_v_side_old_103802.awb") / 1000

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end

					if var_224_10.prefab_name ~= "" and arg_221_1.actors_[var_224_10.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_10.prefab_name].transform, "story_v_side_old_103802", "103802055", "story_v_side_old_103802.awb")

						arg_221_1:RecordAudio("103802055", var_224_15)
						arg_221_1:RecordAudio("103802055", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802055", "story_v_side_old_103802.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802055", "story_v_side_old_103802.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play103802056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 103802056
		arg_225_1.duration_ = 21.13

		local var_225_0 = {
			ja = 21.133,
			ko = 10.866,
			en = 11.366
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
				arg_225_0:Play103802057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action425")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_228_0 = 0
			local var_228_1 = 1.15

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(103802056)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 46 <= 0 and var_228_1 or var_228_1 * (utf8.len(var_228_3) / 46)

				if (46 <= 0 and var_228_1 or var_228_1 * (utf8.len(var_228_3) / 46)) > 0 and var_228_1 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802056", "story_v_side_old_103802.awb") ~= 0 then
					local var_228_6 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802056", "story_v_side_old_103802.awb") / 1000

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end

					if var_228_2.prefab_name ~= "" and arg_225_1.actors_[var_228_2.prefab_name] ~= nil then
						local var_228_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_2.prefab_name].transform, "story_v_side_old_103802", "103802056", "story_v_side_old_103802.awb")

						arg_225_1:RecordAudio("103802056", var_228_7)
						arg_225_1:RecordAudio("103802056", var_228_7)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802056", "story_v_side_old_103802.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802056", "story_v_side_old_103802.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_8 and arg_225_1.time_ < var_228_0 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play103802057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 103802057
		arg_229_1.duration_ = 13.73

		local var_229_0 = {
			ja = 11.4,
			ko = 13.733,
			en = 9.766
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play103802058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1038ui_story"]) and arg_229_1.var_.characterEffect1038ui_story == nil then
				arg_229_1.var_.characterEffect1038ui_story = arg_229_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.1

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1038ui_story"]) then
				if arg_229_1.var_.characterEffect1038ui_story and not isNil(arg_229_1.actors_["1038ui_story"]) then
					arg_229_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1038ui_story"]) and arg_229_1.var_.characterEffect1038ui_story then
				arg_229_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_232_2 = arg_229_1.actors_["1059ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect1059ui_story == nil then
				arg_229_1.var_.characterEffect1059ui_story = var_232_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_3 = 0.1

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.characterEffect1059ui_story and not isNil(var_232_2) then
					arg_229_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_3)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect1059ui_story then
				arg_229_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_232_4 = arg_229_1.actors_["1059ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1059ui_story = var_232_4.localPosition
			end

			local var_232_5 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_5 then
				var_232_4.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1059ui_story, Vector3.New(20, -1.1, -5.4), (arg_229_1.time_ - 0) / var_232_5)
				var_232_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_4.position).x, (manager.ui.mainCamera.transform.position - var_232_4.position).y, (manager.ui.mainCamera.transform.position - var_232_4.position).z)
				var_232_4.localEulerAngles.z = 0
				var_232_4.localEulerAngles.x = 0
				var_232_4.localEulerAngles = var_232_4.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_5 and arg_229_1.time_ < 0 + var_232_5 + arg_232_0 then
				var_232_4.localPosition = Vector3.New(20, -1.1, -5.4)
				var_232_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_4.position).x, (manager.ui.mainCamera.transform.position - var_232_4.position).y, (manager.ui.mainCamera.transform.position - var_232_4.position).z)
				var_232_4.localEulerAngles.z = 0
				var_232_4.localEulerAngles.x = 0
				var_232_4.localEulerAngles = var_232_4.localEulerAngles
			end

			local var_232_6 = arg_229_1.actors_["1038ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1038ui_story = var_232_6.localPosition
			end

			local var_232_7 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				var_232_6.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.16, -5.3), (arg_229_1.time_ - 0) / var_232_7)
				var_232_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_6.position).x, (manager.ui.mainCamera.transform.position - var_232_6.position).y, (manager.ui.mainCamera.transform.position - var_232_6.position).z)
				var_232_6.localEulerAngles.z = 0
				var_232_6.localEulerAngles.x = 0
				var_232_6.localEulerAngles = var_232_6.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				var_232_6.localPosition = Vector3.New(0, -1.16, -5.3)
				var_232_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_6.position).x, (manager.ui.mainCamera.transform.position - var_232_6.position).y, (manager.ui.mainCamera.transform.position - var_232_6.position).z)
				var_232_6.localEulerAngles.z = 0
				var_232_6.localEulerAngles.x = 0
				var_232_6.localEulerAngles = var_232_6.localEulerAngles
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_232_8 = 0
			local var_232_9 = 0.925

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_10 = arg_229_1:GetWordFromCfg(103802057)
				local var_232_11 = arg_229_1:FormatText(var_232_10.content)

				arg_229_1.text_.text = var_232_11

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_13 = 37 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_11) / 37)

				if (37 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_11) / 37)) > 0 and var_232_9 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_8
					end
				end

				arg_229_1.text_.text = var_232_11
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802057", "story_v_side_old_103802.awb") ~= 0 then
					local var_232_14 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802057", "story_v_side_old_103802.awb") / 1000

					if var_232_14 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_8
					end

					if var_232_10.prefab_name ~= "" and arg_229_1.actors_[var_232_10.prefab_name] ~= nil then
						local var_232_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_10.prefab_name].transform, "story_v_side_old_103802", "103802057", "story_v_side_old_103802.awb")

						arg_229_1:RecordAudio("103802057", var_232_15)
						arg_229_1:RecordAudio("103802057", var_232_15)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802057", "story_v_side_old_103802.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802057", "story_v_side_old_103802.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_9, arg_229_1.talkMaxDuration)

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_8) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_8 + var_232_16 and arg_229_1.time_ < var_232_8 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play103802058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 103802058
		arg_233_1.duration_ = 7.1

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play103802059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1084ui_story"]) and arg_233_1.var_.characterEffect1084ui_story == nil then
				arg_233_1.var_.characterEffect1084ui_story = arg_233_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.1

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1084ui_story"]) then
				if arg_233_1.var_.characterEffect1084ui_story and not isNil(arg_233_1.actors_["1084ui_story"]) then
					arg_233_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1084ui_story"]) and arg_233_1.var_.characterEffect1084ui_story then
				arg_233_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_236_2 = arg_233_1.actors_["1039ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1039ui_story == nil then
				arg_233_1.var_.characterEffect1039ui_story = var_236_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_3 = 0.1

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.characterEffect1039ui_story and not isNil(var_236_2) then
					arg_233_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1039ui_story then
				arg_233_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_236_5 = arg_233_1.actors_["1059ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect1059ui_story == nil then
				arg_233_1.var_.characterEffect1059ui_story = var_236_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.1

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.characterEffect1059ui_story and not isNil(var_236_5) then
					arg_233_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect1059ui_story then
				arg_233_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_236_8 = arg_233_1.actors_["1038ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.characterEffect1038ui_story == nil then
				arg_233_1.var_.characterEffect1038ui_story = var_236_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_9 = 0.1

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_9 and not isNil(var_236_8) then
				if arg_233_1.var_.characterEffect1038ui_story and not isNil(var_236_8) then
					arg_233_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_9)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_9 and arg_233_1.time_ < 0 + var_236_9 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.characterEffect1038ui_story then
				arg_233_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_236_10 = arg_233_1.actors_["1038ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1038ui_story = var_236_10.localPosition
			end

			local var_236_11 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_11 then
				var_236_10.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1038ui_story, Vector3.New(30, -1.16, -5.3), (arg_233_1.time_ - 0) / var_236_11)
				var_236_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_10.position).x, (manager.ui.mainCamera.transform.position - var_236_10.position).y, (manager.ui.mainCamera.transform.position - var_236_10.position).z)
				var_236_10.localEulerAngles.z = 0
				var_236_10.localEulerAngles.x = 0
				var_236_10.localEulerAngles = var_236_10.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_11 and arg_233_1.time_ < 0 + var_236_11 + arg_236_0 then
				var_236_10.localPosition = Vector3.New(30, -1.16, -5.3)
				var_236_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_10.position).x, (manager.ui.mainCamera.transform.position - var_236_10.position).y, (manager.ui.mainCamera.transform.position - var_236_10.position).z)
				var_236_10.localEulerAngles.z = 0
				var_236_10.localEulerAngles.x = 0
				var_236_10.localEulerAngles = var_236_10.localEulerAngles
			end

			local var_236_12 = arg_233_1.actors_["1084ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1084ui_story = var_236_12.localPosition
			end

			local var_236_13 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_13 then
				var_236_12.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1084ui_story, Vector3.New(-0.85, -1.16, -5), (arg_233_1.time_ - 0) / var_236_13)
				var_236_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_12.position).x, (manager.ui.mainCamera.transform.position - var_236_12.position).y, (manager.ui.mainCamera.transform.position - var_236_12.position).z)
				var_236_12.localEulerAngles.z = 0
				var_236_12.localEulerAngles.x = 0
				var_236_12.localEulerAngles = var_236_12.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_13 and arg_233_1.time_ < 0 + var_236_13 + arg_236_0 then
				var_236_12.localPosition = Vector3.New(-0.85, -1.16, -5)
				var_236_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_12.position).x, (manager.ui.mainCamera.transform.position - var_236_12.position).y, (manager.ui.mainCamera.transform.position - var_236_12.position).z)
				var_236_12.localEulerAngles.z = 0
				var_236_12.localEulerAngles.x = 0
				var_236_12.localEulerAngles = var_236_12.localEulerAngles
			end

			local var_236_14 = arg_233_1.actors_["1039ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1039ui_story = var_236_14.localPosition
			end

			local var_236_15 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_15 then
				var_236_14.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (arg_233_1.time_ - 0) / var_236_15)
				var_236_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_14.position).x, (manager.ui.mainCamera.transform.position - var_236_14.position).y, (manager.ui.mainCamera.transform.position - var_236_14.position).z)
				var_236_14.localEulerAngles.z = 0
				var_236_14.localEulerAngles.x = 0
				var_236_14.localEulerAngles = var_236_14.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_15 and arg_233_1.time_ < 0 + var_236_15 + arg_236_0 then
				var_236_14.localPosition = Vector3.New(0, -1.06, -5.3)
				var_236_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_14.position).x, (manager.ui.mainCamera.transform.position - var_236_14.position).y, (manager.ui.mainCamera.transform.position - var_236_14.position).z)
				var_236_14.localEulerAngles.z = 0
				var_236_14.localEulerAngles.x = 0
				var_236_14.localEulerAngles = var_236_14.localEulerAngles
			end

			local var_236_16 = arg_233_1.actors_["1059ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1059ui_story = var_236_16.localPosition
			end

			local var_236_17 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_17 then
				var_236_16.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1059ui_story, Vector3.New(1, -1.1, -5.4), (arg_233_1.time_ - 0) / var_236_17)
				var_236_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_16.position).x, (manager.ui.mainCamera.transform.position - var_236_16.position).y, (manager.ui.mainCamera.transform.position - var_236_16.position).z)
				var_236_16.localEulerAngles.z = 0
				var_236_16.localEulerAngles.x = 0
				var_236_16.localEulerAngles = var_236_16.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_17 and arg_233_1.time_ < 0 + var_236_17 + arg_236_0 then
				var_236_16.localPosition = Vector3.New(1, -1.1, -5.4)
				var_236_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_16.position).x, (manager.ui.mainCamera.transform.position - var_236_16.position).y, (manager.ui.mainCamera.transform.position - var_236_16.position).z)
				var_236_16.localEulerAngles.z = 0
				var_236_16.localEulerAngles.x = 0
				var_236_16.localEulerAngles = var_236_16.localEulerAngles
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			local var_236_18 = 0
			local var_236_19 = 1

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_18 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_20 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(103802058).content)

				arg_233_1.text_.text = var_236_20

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_22 = 40 <= 0 and var_236_19 or var_236_19 * (utf8.len(var_236_20) / 40)

				if (40 <= 0 and var_236_19 or var_236_19 * (utf8.len(var_236_20) / 40)) > 0 and var_236_19 < var_236_22 then
					arg_233_1.talkMaxDuration = var_236_22

					if var_236_22 + var_236_18 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_22 + var_236_18
					end
				end

				arg_233_1.text_.text = var_236_20
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_23 = math.max(var_236_19, arg_233_1.talkMaxDuration)

			if var_236_18 <= arg_233_1.time_ and arg_233_1.time_ < var_236_18 + var_236_23 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_18) / var_236_23

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_18 + var_236_23 and arg_233_1.time_ < var_236_18 + var_236_23 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play103802059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 103802059
		arg_237_1.duration_ = 5.6

		local var_237_0 = {
			ja = 5.6,
			ko = 4.9,
			en = 4.133
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
				arg_237_0:Play103802060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1039ui_story"]) and arg_237_1.var_.characterEffect1039ui_story == nil then
				arg_237_1.var_.characterEffect1039ui_story = arg_237_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.1

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1039ui_story"]) then
				if arg_237_1.var_.characterEffect1039ui_story and not isNil(arg_237_1.actors_["1039ui_story"]) then
					arg_237_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1039ui_story"]) and arg_237_1.var_.characterEffect1039ui_story then
				arg_237_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_240_2 = arg_237_1.actors_["1084ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.characterEffect1084ui_story == nil then
				arg_237_1.var_.characterEffect1084ui_story = var_240_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_3 = 0.1

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.characterEffect1084ui_story and not isNil(var_240_2) then
					arg_237_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_3)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.characterEffect1084ui_story then
				arg_237_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_240_4 = arg_237_1.actors_["1059ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect1059ui_story == nil then
				arg_237_1.var_.characterEffect1059ui_story = var_240_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_5 = 0.1

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_5 and not isNil(var_240_4) then
				if arg_237_1.var_.characterEffect1059ui_story and not isNil(var_240_4) then
					arg_237_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_5)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_5 and arg_237_1.time_ < 0 + var_240_5 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect1059ui_story then
				arg_237_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action464")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_240_6 = 0
			local var_240_7 = 0.575

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_8 = arg_237_1:GetWordFromCfg(103802059)
				local var_240_9 = arg_237_1:FormatText(var_240_8.content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 23 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_9) / 23)

				if (23 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_9) / 23)) > 0 and var_240_7 < var_240_11 then
					arg_237_1.talkMaxDuration = var_240_11

					if var_240_11 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802059", "story_v_side_old_103802.awb") ~= 0 then
					local var_240_12 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802059", "story_v_side_old_103802.awb") / 1000

					if var_240_12 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_6
					end

					if var_240_8.prefab_name ~= "" and arg_237_1.actors_[var_240_8.prefab_name] ~= nil then
						local var_240_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_8.prefab_name].transform, "story_v_side_old_103802", "103802059", "story_v_side_old_103802.awb")

						arg_237_1:RecordAudio("103802059", var_240_13)
						arg_237_1:RecordAudio("103802059", var_240_13)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802059", "story_v_side_old_103802.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802059", "story_v_side_old_103802.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play103802060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 103802060
		arg_241_1.duration_ = 6.1

		local var_241_0 = {
			ja = 6.1,
			ko = 5.533,
			en = 5.233
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
				arg_241_0:Play103802061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1084ui_story"]) and arg_241_1.var_.characterEffect1084ui_story == nil then
				arg_241_1.var_.characterEffect1084ui_story = arg_241_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.1

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1084ui_story"]) then
				if arg_241_1.var_.characterEffect1084ui_story and not isNil(arg_241_1.actors_["1084ui_story"]) then
					arg_241_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1084ui_story"]) and arg_241_1.var_.characterEffect1084ui_story then
				arg_241_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_244_2 = arg_241_1.actors_["1039ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect1039ui_story == nil then
				arg_241_1.var_.characterEffect1039ui_story = var_244_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_3 = 0.1

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.characterEffect1039ui_story and not isNil(var_244_2) then
					arg_241_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_3)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect1039ui_story then
				arg_241_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4135")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_244_4 = 0
			local var_244_5 = 0.525

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(103802060)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 21 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 21)

				if (21 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 21)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802060", "story_v_side_old_103802.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802060", "story_v_side_old_103802.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_side_old_103802", "103802060", "story_v_side_old_103802.awb")

						arg_241_1:RecordAudio("103802060", var_244_11)
						arg_241_1:RecordAudio("103802060", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802060", "story_v_side_old_103802.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802060", "story_v_side_old_103802.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play103802061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 103802061
		arg_245_1.duration_ = 7.23

		local var_245_0 = {
			ja = 7.233,
			ko = 5.3,
			en = 4.466
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
				arg_245_0:Play103802062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1059ui_story"]) and arg_245_1.var_.characterEffect1059ui_story == nil then
				arg_245_1.var_.characterEffect1059ui_story = arg_245_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.1

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1059ui_story"]) then
				if arg_245_1.var_.characterEffect1059ui_story and not isNil(arg_245_1.actors_["1059ui_story"]) then
					arg_245_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1059ui_story"]) and arg_245_1.var_.characterEffect1059ui_story then
				arg_245_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_248_2 = arg_245_1.actors_["1084ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.characterEffect1084ui_story == nil then
				arg_245_1.var_.characterEffect1084ui_story = var_248_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_3 = 0.1

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.characterEffect1084ui_story and not isNil(var_248_2) then
					arg_245_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_3)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.characterEffect1084ui_story then
				arg_245_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action465")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_248_4 = 0
			local var_248_5 = 0.575

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(103802061)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 23 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 23)

				if (23 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 23)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802061", "story_v_side_old_103802.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802061", "story_v_side_old_103802.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_side_old_103802", "103802061", "story_v_side_old_103802.awb")

						arg_245_1:RecordAudio("103802061", var_248_11)
						arg_245_1:RecordAudio("103802061", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802061", "story_v_side_old_103802.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802061", "story_v_side_old_103802.awb")
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

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play103802062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 103802062
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play103802063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1059ui_story"]) and arg_249_1.var_.characterEffect1059ui_story == nil then
				arg_249_1.var_.characterEffect1059ui_story = arg_249_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.1

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1059ui_story"]) then
				if arg_249_1.var_.characterEffect1059ui_story and not isNil(arg_249_1.actors_["1059ui_story"]) then
					arg_249_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1059ui_story"]) and arg_249_1.var_.characterEffect1059ui_story then
				arg_249_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.225

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(103802062).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 9 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 9)

				if (9 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 9)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play103802063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 103802063
		arg_253_1.duration_ = 10.93

		local var_253_0 = {
			ja = 6.666,
			ko = 9.933,
			en = 10.933
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
				arg_253_0:Play103802064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1038ui_story"]) and arg_253_1.var_.characterEffect1038ui_story == nil then
				arg_253_1.var_.characterEffect1038ui_story = arg_253_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.1

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1038ui_story"]) then
				if arg_253_1.var_.characterEffect1038ui_story and not isNil(arg_253_1.actors_["1038ui_story"]) then
					arg_253_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1038ui_story"]) and arg_253_1.var_.characterEffect1038ui_story then
				arg_253_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_256_2 = arg_253_1.actors_["1084ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1084ui_story = var_256_2.localPosition
			end

			local var_256_3 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 then
				var_256_2.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1084ui_story, Vector3.New(20, -1.16, -5), (arg_253_1.time_ - 0) / var_256_3)
				var_256_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_2.position).x, (manager.ui.mainCamera.transform.position - var_256_2.position).y, (manager.ui.mainCamera.transform.position - var_256_2.position).z)
				var_256_2.localEulerAngles.z = 0
				var_256_2.localEulerAngles.x = 0
				var_256_2.localEulerAngles = var_256_2.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 then
				var_256_2.localPosition = Vector3.New(20, -1.16, -5)
				var_256_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_2.position).x, (manager.ui.mainCamera.transform.position - var_256_2.position).y, (manager.ui.mainCamera.transform.position - var_256_2.position).z)
				var_256_2.localEulerAngles.z = 0
				var_256_2.localEulerAngles.x = 0
				var_256_2.localEulerAngles = var_256_2.localEulerAngles
			end

			local var_256_4 = arg_253_1.actors_["1039ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1039ui_story = var_256_4.localPosition
			end

			local var_256_5 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_5 then
				var_256_4.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (arg_253_1.time_ - 0) / var_256_5)
				var_256_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_4.position).x, (manager.ui.mainCamera.transform.position - var_256_4.position).y, (manager.ui.mainCamera.transform.position - var_256_4.position).z)
				var_256_4.localEulerAngles.z = 0
				var_256_4.localEulerAngles.x = 0
				var_256_4.localEulerAngles = var_256_4.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_5 and arg_253_1.time_ < 0 + var_256_5 + arg_256_0 then
				var_256_4.localPosition = Vector3.New(10, -1.06, -5.3)
				var_256_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_4.position).x, (manager.ui.mainCamera.transform.position - var_256_4.position).y, (manager.ui.mainCamera.transform.position - var_256_4.position).z)
				var_256_4.localEulerAngles.z = 0
				var_256_4.localEulerAngles.x = 0
				var_256_4.localEulerAngles = var_256_4.localEulerAngles
			end

			local var_256_6 = arg_253_1.actors_["1059ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1059ui_story = var_256_6.localPosition
			end

			local var_256_7 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				var_256_6.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1059ui_story, Vector3.New(20, -1.1, -5.4), (arg_253_1.time_ - 0) / var_256_7)
				var_256_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_6.position).x, (manager.ui.mainCamera.transform.position - var_256_6.position).y, (manager.ui.mainCamera.transform.position - var_256_6.position).z)
				var_256_6.localEulerAngles.z = 0
				var_256_6.localEulerAngles.x = 0
				var_256_6.localEulerAngles = var_256_6.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				var_256_6.localPosition = Vector3.New(20, -1.1, -5.4)
				var_256_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_6.position).x, (manager.ui.mainCamera.transform.position - var_256_6.position).y, (manager.ui.mainCamera.transform.position - var_256_6.position).z)
				var_256_6.localEulerAngles.z = 0
				var_256_6.localEulerAngles.x = 0
				var_256_6.localEulerAngles = var_256_6.localEulerAngles
			end

			local var_256_8 = arg_253_1.actors_["1038ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1038ui_story = var_256_8.localPosition
			end

			local var_256_9 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_9 then
				var_256_8.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.16, -5.3), (arg_253_1.time_ - 0) / var_256_9)
				var_256_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_8.position).x, (manager.ui.mainCamera.transform.position - var_256_8.position).y, (manager.ui.mainCamera.transform.position - var_256_8.position).z)
				var_256_8.localEulerAngles.z = 0
				var_256_8.localEulerAngles.x = 0
				var_256_8.localEulerAngles = var_256_8.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_9 and arg_253_1.time_ < 0 + var_256_9 + arg_256_0 then
				var_256_8.localPosition = Vector3.New(0, -1.16, -5.3)
				var_256_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_8.position).x, (manager.ui.mainCamera.transform.position - var_256_8.position).y, (manager.ui.mainCamera.transform.position - var_256_8.position).z)
				var_256_8.localEulerAngles.z = 0
				var_256_8.localEulerAngles.x = 0
				var_256_8.localEulerAngles = var_256_8.localEulerAngles
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_256_10 = 0
			local var_256_11 = 0.75

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_12 = arg_253_1:GetWordFromCfg(103802063)
				local var_256_13 = arg_253_1:FormatText(var_256_12.content)

				arg_253_1.text_.text = var_256_13

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_15 = 30 <= 0 and var_256_11 or var_256_11 * (utf8.len(var_256_13) / 30)

				if (30 <= 0 and var_256_11 or var_256_11 * (utf8.len(var_256_13) / 30)) > 0 and var_256_11 < var_256_15 then
					arg_253_1.talkMaxDuration = var_256_15

					if var_256_15 + var_256_10 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_15 + var_256_10
					end
				end

				arg_253_1.text_.text = var_256_13
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802063", "story_v_side_old_103802.awb") ~= 0 then
					local var_256_16 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802063", "story_v_side_old_103802.awb") / 1000

					if var_256_16 + var_256_10 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_16 + var_256_10
					end

					if var_256_12.prefab_name ~= "" and arg_253_1.actors_[var_256_12.prefab_name] ~= nil then
						local var_256_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_12.prefab_name].transform, "story_v_side_old_103802", "103802063", "story_v_side_old_103802.awb")

						arg_253_1:RecordAudio("103802063", var_256_17)
						arg_253_1:RecordAudio("103802063", var_256_17)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802063", "story_v_side_old_103802.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802063", "story_v_side_old_103802.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_18 = math.max(var_256_11, arg_253_1.talkMaxDuration)

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_18 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_10) / var_256_18

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_10 + var_256_18 and arg_253_1.time_ < var_256_10 + var_256_18 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play103802064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 103802064
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play103802065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPosD02b = arg_257_1.bgs_.D02b.transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.bgs_.D02b.transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPosD02b, Vector3.New(0, -100, 10), (arg_257_1.time_ - 0) / var_260_0)
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.bgs_.D02b.transform.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				local var_260_1 = arg_257_1.bgs_.B13

				arg_257_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_260_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_2 = var_260_1:GetComponent("SpriteRenderer")

				if var_260_2 and var_260_2.sprite then
					local var_260_3 = 2 * (var_260_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_260_1.transform.localScale = Vector3.New(var_260_3 / var_260_2.sprite.bounds.size.y < var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x and var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x or var_260_3 / var_260_2.sprite.bounds.size.y, var_260_3 / var_260_2.sprite.bounds.size.y < var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x and var_260_3 * manager.ui.mainCameraCom_.aspect / var_260_2.sprite.bounds.size.x or var_260_3 / var_260_2.sprite.bounds.size.y, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "B13" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_4 = arg_257_1.actors_["1038ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1038ui_story = var_260_4.localPosition
			end

			local var_260_5 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_5 then
				var_260_4.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1038ui_story, Vector3.New(30, -1.16, -5.3), (arg_257_1.time_ - 0) / var_260_5)
				var_260_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_4.position).x, (manager.ui.mainCamera.transform.position - var_260_4.position).y, (manager.ui.mainCamera.transform.position - var_260_4.position).z)
				var_260_4.localEulerAngles.z = 0
				var_260_4.localEulerAngles.x = 0
				var_260_4.localEulerAngles = var_260_4.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_5 and arg_257_1.time_ < 0 + var_260_5 + arg_260_0 then
				var_260_4.localPosition = Vector3.New(30, -1.16, -5.3)
				var_260_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_4.position).x, (manager.ui.mainCamera.transform.position - var_260_4.position).y, (manager.ui.mainCamera.transform.position - var_260_4.position).z)
				var_260_4.localEulerAngles.z = 0
				var_260_4.localEulerAngles.x = 0
				var_260_4.localEulerAngles = var_260_4.localEulerAngles
			end

			local var_260_6 = 0
			local var_260_7 = 0.875

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_8 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(103802064).content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_10 = 35 <= 0 and var_260_7 or var_260_7 * (utf8.len(var_260_8) / 35)

				if (35 <= 0 and var_260_7 or var_260_7 * (utf8.len(var_260_8) / 35)) > 0 and var_260_7 < var_260_10 then
					arg_257_1.talkMaxDuration = var_260_10

					if var_260_10 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_8
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_11 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_11 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_11

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_11 and arg_257_1.time_ < var_260_6 + var_260_11 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "D02b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play103802065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 103802065
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play103802066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.575

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(103802065).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 23 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 23)

				if (23 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 23)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play103802066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 103802066
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play103802067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.625

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(103802066).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 25 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 25)

				if (25 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 25)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play103802067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 103802067
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play103802068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPosB13 = arg_269_1.bgs_.B13.transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.bgs_.B13.transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPosB13, Vector3.New(0, -100, 10), (arg_269_1.time_ - 0) / var_272_0)
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.bgs_.B13.transform.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				local var_272_1 = arg_269_1.bgs_.D02b

				arg_269_1.bgs_.D02b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_272_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_272_2 = var_272_1:GetComponent("SpriteRenderer")

				if var_272_2 and var_272_2.sprite then
					local var_272_3 = 2 * (var_272_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_272_1.transform.localScale = Vector3.New(var_272_3 / var_272_2.sprite.bounds.size.y < var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x and var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x or var_272_3 / var_272_2.sprite.bounds.size.y, var_272_3 / var_272_2.sprite.bounds.size.y < var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x and var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x or var_272_3 / var_272_2.sprite.bounds.size.y, 0)
				end

				for iter_272_0, iter_272_1 in pairs(arg_269_1.bgs_) do
					if iter_272_0 ~= "D02b" then
						iter_272_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_272_4 = 0
			local var_272_5 = 0.6

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(103802067).content)

				arg_269_1.text_.text = var_272_6

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_8 = 24 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_6) / 24)

				if (24 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_6) / 24)) > 0 and var_272_5 < var_272_8 then
					arg_269_1.talkMaxDuration = var_272_8

					if var_272_8 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_6
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_9 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_9 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_9

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_9 and arg_269_1.time_ < var_272_4 + var_272_9 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B13",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play103802068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 103802068
		arg_273_1.duration_ = 14.07

		local var_273_0 = {
			ja = 8.8,
			ko = 11.066,
			en = 14.066
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play103802069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1038ui_story"]) and arg_273_1.var_.characterEffect1038ui_story == nil then
				arg_273_1.var_.characterEffect1038ui_story = arg_273_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.1

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1038ui_story"]) then
				if arg_273_1.var_.characterEffect1038ui_story and not isNil(arg_273_1.actors_["1038ui_story"]) then
					arg_273_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1038ui_story"]) and arg_273_1.var_.characterEffect1038ui_story then
				arg_273_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_276_2 = arg_273_1.actors_["1038ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1038ui_story = var_276_2.localPosition
			end

			local var_276_3 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 then
				var_276_2.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1038ui_story, Vector3.New(-0.83, -1.16, -5.3), (arg_273_1.time_ - 0) / var_276_3)
				var_276_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_2.position).x, (manager.ui.mainCamera.transform.position - var_276_2.position).y, (manager.ui.mainCamera.transform.position - var_276_2.position).z)
				var_276_2.localEulerAngles.z = 0
				var_276_2.localEulerAngles.x = 0
				var_276_2.localEulerAngles = var_276_2.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 then
				var_276_2.localPosition = Vector3.New(-0.83, -1.16, -5.3)
				var_276_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_2.position).x, (manager.ui.mainCamera.transform.position - var_276_2.position).y, (manager.ui.mainCamera.transform.position - var_276_2.position).z)
				var_276_2.localEulerAngles.z = 0
				var_276_2.localEulerAngles.x = 0
				var_276_2.localEulerAngles = var_276_2.localEulerAngles
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action6_1")
			end

			local var_276_4 = arg_273_1.actors_["1084ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1084ui_story = var_276_4.localPosition
			end

			local var_276_5 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_5 then
				var_276_4.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1084ui_story, Vector3.New(0.85, -1.16, -5), (arg_273_1.time_ - 0) / var_276_5)
				var_276_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_4.position).x, (manager.ui.mainCamera.transform.position - var_276_4.position).y, (manager.ui.mainCamera.transform.position - var_276_4.position).z)
				var_276_4.localEulerAngles.z = 0
				var_276_4.localEulerAngles.x = 0
				var_276_4.localEulerAngles = var_276_4.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_5 and arg_273_1.time_ < 0 + var_276_5 + arg_276_0 then
				var_276_4.localPosition = Vector3.New(0.85, -1.16, -5)
				var_276_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_4.position).x, (manager.ui.mainCamera.transform.position - var_276_4.position).y, (manager.ui.mainCamera.transform.position - var_276_4.position).z)
				var_276_4.localEulerAngles.z = 0
				var_276_4.localEulerAngles.x = 0
				var_276_4.localEulerAngles = var_276_4.localEulerAngles
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_276_6 = 0
			local var_276_7 = 1

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_8 = arg_273_1:GetWordFromCfg(103802068)
				local var_276_9 = arg_273_1:FormatText(var_276_8.content)

				arg_273_1.text_.text = var_276_9

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 40 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 40)

				if (40 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 40)) > 0 and var_276_7 < var_276_11 then
					arg_273_1.talkMaxDuration = var_276_11

					if var_276_11 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_9
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802068", "story_v_side_old_103802.awb") ~= 0 then
					local var_276_12 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802068", "story_v_side_old_103802.awb") / 1000

					if var_276_12 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_12 + var_276_6
					end

					if var_276_8.prefab_name ~= "" and arg_273_1.actors_[var_276_8.prefab_name] ~= nil then
						local var_276_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_8.prefab_name].transform, "story_v_side_old_103802", "103802068", "story_v_side_old_103802.awb")

						arg_273_1:RecordAudio("103802068", var_276_13)
						arg_273_1:RecordAudio("103802068", var_276_13)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802068", "story_v_side_old_103802.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802068", "story_v_side_old_103802.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play103802069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 103802069
		arg_277_1.duration_ = 2.47

		local var_277_0 = {
			ja = 1.999999999999,
			ko = 2.166,
			en = 2.466
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play103802070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1084ui_story"]) and arg_277_1.var_.characterEffect1084ui_story == nil then
				arg_277_1.var_.characterEffect1084ui_story = arg_277_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.1

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1084ui_story"]) then
				if arg_277_1.var_.characterEffect1084ui_story and not isNil(arg_277_1.actors_["1084ui_story"]) then
					arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1084ui_story"]) and arg_277_1.var_.characterEffect1084ui_story then
				arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_280_2 = arg_277_1.actors_["1038ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.characterEffect1038ui_story == nil then
				arg_277_1.var_.characterEffect1038ui_story = var_280_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_3 = 0.1

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.characterEffect1038ui_story and not isNil(var_280_2) then
					arg_277_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_3)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.characterEffect1038ui_story then
				arg_277_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4135")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_280_4 = 0
			local var_280_5 = 0.15

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(103802069)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 6 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 6)

				if (6 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 6)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802069", "story_v_side_old_103802.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802069", "story_v_side_old_103802.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_side_old_103802", "103802069", "story_v_side_old_103802.awb")

						arg_277_1:RecordAudio("103802069", var_280_11)
						arg_277_1:RecordAudio("103802069", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802069", "story_v_side_old_103802.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802069", "story_v_side_old_103802.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play103802070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 103802070
		arg_281_1.duration_ = 8.87

		local var_281_0 = {
			ja = 8.866,
			ko = 7.666,
			en = 6.4
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play103802071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1038ui_story"]) and arg_281_1.var_.characterEffect1038ui_story == nil then
				arg_281_1.var_.characterEffect1038ui_story = arg_281_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.1

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1038ui_story"]) then
				if arg_281_1.var_.characterEffect1038ui_story and not isNil(arg_281_1.actors_["1038ui_story"]) then
					arg_281_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1038ui_story"]) and arg_281_1.var_.characterEffect1038ui_story then
				arg_281_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_284_2 = arg_281_1.actors_["1084ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1084ui_story == nil then
				arg_281_1.var_.characterEffect1084ui_story = var_284_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.1

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.characterEffect1084ui_story and not isNil(var_284_2) then
					arg_281_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_3)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1084ui_story then
				arg_281_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action462")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_284_4 = 0
			local var_284_5 = 0.75

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(103802070)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 30 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 30)

				if (30 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 30)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802070", "story_v_side_old_103802.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802070", "story_v_side_old_103802.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_side_old_103802", "103802070", "story_v_side_old_103802.awb")

						arg_281_1:RecordAudio("103802070", var_284_11)
						arg_281_1:RecordAudio("103802070", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802070", "story_v_side_old_103802.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802070", "story_v_side_old_103802.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play103802071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 103802071
		arg_285_1.duration_ = 5.3

		local var_285_0 = {
			ja = 5.2,
			ko = 3.4,
			en = 5.3
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play103802072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1084ui_story"]) and arg_285_1.var_.characterEffect1084ui_story == nil then
				arg_285_1.var_.characterEffect1084ui_story = arg_285_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.1

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1084ui_story"]) then
				if arg_285_1.var_.characterEffect1084ui_story and not isNil(arg_285_1.actors_["1084ui_story"]) then
					arg_285_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1084ui_story"]) and arg_285_1.var_.characterEffect1084ui_story then
				arg_285_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_288_2 = arg_285_1.actors_["1038ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1038ui_story == nil then
				arg_285_1.var_.characterEffect1038ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.1

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.characterEffect1038ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_3)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1038ui_story then
				arg_285_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action453")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_288_4 = 0
			local var_288_5 = 0.15

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(103802071)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 6 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 6)

				if (6 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 6)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802071", "story_v_side_old_103802.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802071", "story_v_side_old_103802.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_side_old_103802", "103802071", "story_v_side_old_103802.awb")

						arg_285_1:RecordAudio("103802071", var_288_11)
						arg_285_1:RecordAudio("103802071", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802071", "story_v_side_old_103802.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802071", "story_v_side_old_103802.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play103802072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 103802072
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play103802073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1084ui_story"]) and arg_289_1.var_.characterEffect1084ui_story == nil then
				arg_289_1.var_.characterEffect1084ui_story = arg_289_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.1

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1084ui_story"]) then
				if arg_289_1.var_.characterEffect1084ui_story and not isNil(arg_289_1.actors_["1084ui_story"]) then
					arg_289_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_0)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1084ui_story"]) and arg_289_1.var_.characterEffect1084ui_story then
				arg_289_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_292_1 = 0
			local var_292_2 = 0.325

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(103802072).content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 13 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 13)

				if (13 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 13)) > 0 and var_292_2 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_6 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_6 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_6

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_6 and arg_289_1.time_ < var_292_1 + var_292_6 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play103802073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 103802073
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play103802074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1038ui_story = arg_293_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1038ui_story, Vector3.New(30, -1.16, -5.3), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1038ui_story"].transform.position).z)
				arg_293_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1038ui_story"].transform.localEulerAngles = arg_293_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(30, -1.16, -5.3)
				arg_293_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1038ui_story"].transform.position).z)
				arg_293_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1038ui_story"].transform.localEulerAngles = arg_293_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1084ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1084ui_story = var_296_1.localPosition
			end

			local var_296_2 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 then
				var_296_1.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1084ui_story, Vector3.New(20, -1.16, -5), (arg_293_1.time_ - 0) / var_296_2)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 then
				var_296_1.localPosition = Vector3.New(20, -1.16, -5)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			local var_296_3 = 0
			local var_296_4 = 0.45

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_5 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(103802073).content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 18 <= 0 and var_296_4 or var_296_4 * (utf8.len(var_296_5) / 18)

				if (18 <= 0 and var_296_4 or var_296_4 * (utf8.len(var_296_5) / 18)) > 0 and var_296_4 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_3 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_3
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_4, arg_293_1.talkMaxDuration)

			if var_296_3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_3 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_3) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_3 + var_296_8 and arg_293_1.time_ < var_296_3 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play103802074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 103802074
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play103802075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.6

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(103802074).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 24 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 24)

				if (24 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 24)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play103802075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 103802075
		arg_301_1.duration_ = 5.07

		local var_301_0 = {
			ja = 4.833,
			ko = 5.066,
			en = 4.9
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play103802076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1084ui_story"]) and arg_301_1.var_.characterEffect1084ui_story == nil then
				arg_301_1.var_.characterEffect1084ui_story = arg_301_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.1

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1084ui_story"]) then
				if arg_301_1.var_.characterEffect1084ui_story and not isNil(arg_301_1.actors_["1084ui_story"]) then
					arg_301_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1084ui_story"]) and arg_301_1.var_.characterEffect1084ui_story then
				arg_301_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_304_2 = arg_301_1.actors_["1084ui_story"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1084ui_story = var_304_2.localPosition
			end

			local var_304_3 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 then
				var_304_2.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1084ui_story, Vector3.New(0, -1.16, -5), (arg_301_1.time_ - 0) / var_304_3)
				var_304_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_2.position).x, (manager.ui.mainCamera.transform.position - var_304_2.position).y, (manager.ui.mainCamera.transform.position - var_304_2.position).z)
				var_304_2.localEulerAngles.z = 0
				var_304_2.localEulerAngles.x = 0
				var_304_2.localEulerAngles = var_304_2.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 then
				var_304_2.localPosition = Vector3.New(0, -1.16, -5)
				var_304_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_2.position).x, (manager.ui.mainCamera.transform.position - var_304_2.position).y, (manager.ui.mainCamera.transform.position - var_304_2.position).z)
				var_304_2.localEulerAngles.z = 0
				var_304_2.localEulerAngles.x = 0
				var_304_2.localEulerAngles = var_304_2.localEulerAngles
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_304_4 = 0
			local var_304_5 = 0.5

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(103802075)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 20 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 20)

				if (20 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 20)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802075", "story_v_side_old_103802.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802075", "story_v_side_old_103802.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_side_old_103802", "103802075", "story_v_side_old_103802.awb")

						arg_301_1:RecordAudio("103802075", var_304_11)
						arg_301_1:RecordAudio("103802075", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802075", "story_v_side_old_103802.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802075", "story_v_side_old_103802.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play103802076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 103802076
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play103802077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1084ui_story"]) and arg_305_1.var_.characterEffect1084ui_story == nil then
				arg_305_1.var_.characterEffect1084ui_story = arg_305_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.1

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1084ui_story"]) then
				if arg_305_1.var_.characterEffect1084ui_story and not isNil(arg_305_1.actors_["1084ui_story"]) then
					arg_305_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1084ui_story"]) and arg_305_1.var_.characterEffect1084ui_story then
				arg_305_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.275

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(103802076).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 11 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 11)

				if (11 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 11)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play103802077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 103802077
		arg_309_1.duration_ = 7.2

		local var_309_0 = {
			ja = 7.2,
			ko = 7.1,
			en = 6.366
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
				arg_309_0:Play103802078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1084ui_story"]) and arg_309_1.var_.characterEffect1084ui_story == nil then
				arg_309_1.var_.characterEffect1084ui_story = arg_309_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.1

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1084ui_story"]) then
				if arg_309_1.var_.characterEffect1084ui_story and not isNil(arg_309_1.actors_["1084ui_story"]) then
					arg_309_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1084ui_story"]) and arg_309_1.var_.characterEffect1084ui_story then
				arg_309_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action427")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_312_2 = 0
			local var_312_3 = 0.65

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:GetWordFromCfg(103802077)
				local var_312_5 = arg_309_1:FormatText(var_312_4.content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 26 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 26)

				if (26 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 26)) > 0 and var_312_3 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_2
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802077", "story_v_side_old_103802.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802077", "story_v_side_old_103802.awb") / 1000

					if var_312_8 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_2
					end

					if var_312_4.prefab_name ~= "" and arg_309_1.actors_[var_312_4.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_4.prefab_name].transform, "story_v_side_old_103802", "103802077", "story_v_side_old_103802.awb")

						arg_309_1:RecordAudio("103802077", var_312_9)
						arg_309_1:RecordAudio("103802077", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802077", "story_v_side_old_103802.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802077", "story_v_side_old_103802.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_3, arg_309_1.talkMaxDuration)

			if var_312_2 <= arg_309_1.time_ and arg_309_1.time_ < var_312_2 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_2) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_2 + var_312_10 and arg_309_1.time_ < var_312_2 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play103802078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 103802078
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play103802079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) and arg_313_1.var_.characterEffect1084ui_story == nil then
				arg_313_1.var_.characterEffect1084ui_story = arg_313_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.1

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) then
				if arg_313_1.var_.characterEffect1084ui_story and not isNil(arg_313_1.actors_["1084ui_story"]) then
					arg_313_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) and arg_313_1.var_.characterEffect1084ui_story then
				arg_313_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.275

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(103802078).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 11 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 11)

				if (11 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 11)) > 0 and var_316_2 < var_316_5 then
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
	Play103802079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 103802079
		arg_317_1.duration_ = 8.13

		local var_317_0 = {
			ja = 8.1,
			ko = 8.133,
			en = 5.266
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play103802080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) and arg_317_1.var_.characterEffect1084ui_story == nil then
				arg_317_1.var_.characterEffect1084ui_story = arg_317_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.1

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) then
				if arg_317_1.var_.characterEffect1084ui_story and not isNil(arg_317_1.actors_["1084ui_story"]) then
					arg_317_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1084ui_story"]) and arg_317_1.var_.characterEffect1084ui_story then
				arg_317_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action472")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_320_2 = 0
			local var_320_3 = 0.6

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_4 = arg_317_1:GetWordFromCfg(103802079)
				local var_320_5 = arg_317_1:FormatText(var_320_4.content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 24 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 24)

				if (24 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 24)) > 0 and var_320_3 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802079", "story_v_side_old_103802.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802079", "story_v_side_old_103802.awb") / 1000

					if var_320_8 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_2
					end

					if var_320_4.prefab_name ~= "" and arg_317_1.actors_[var_320_4.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_4.prefab_name].transform, "story_v_side_old_103802", "103802079", "story_v_side_old_103802.awb")

						arg_317_1:RecordAudio("103802079", var_320_9)
						arg_317_1:RecordAudio("103802079", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802079", "story_v_side_old_103802.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802079", "story_v_side_old_103802.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_3, arg_317_1.talkMaxDuration)

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_2) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_2 + var_320_10 and arg_317_1.time_ < var_320_2 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play103802080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 103802080
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play103802081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1084ui_story"]) and arg_321_1.var_.characterEffect1084ui_story == nil then
				arg_321_1.var_.characterEffect1084ui_story = arg_321_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.1

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1084ui_story"]) then
				if arg_321_1.var_.characterEffect1084ui_story and not isNil(arg_321_1.actors_["1084ui_story"]) then
					arg_321_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1084ui_story"]) and arg_321_1.var_.characterEffect1084ui_story then
				arg_321_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_324_1 = arg_321_1.actors_["1084ui_story"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1084ui_story = var_324_1.localPosition
			end

			local var_324_2 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 then
				var_324_1.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1084ui_story, Vector3.New(20, -1.16, -5), (arg_321_1.time_ - 0) / var_324_2)
				var_324_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_1.position).x, (manager.ui.mainCamera.transform.position - var_324_1.position).y, (manager.ui.mainCamera.transform.position - var_324_1.position).z)
				var_324_1.localEulerAngles.z = 0
				var_324_1.localEulerAngles.x = 0
				var_324_1.localEulerAngles = var_324_1.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 then
				var_324_1.localPosition = Vector3.New(20, -1.16, -5)
				var_324_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_1.position).x, (manager.ui.mainCamera.transform.position - var_324_1.position).y, (manager.ui.mainCamera.transform.position - var_324_1.position).z)
				var_324_1.localEulerAngles.z = 0
				var_324_1.localEulerAngles.x = 0
				var_324_1.localEulerAngles = var_324_1.localEulerAngles
			end

			local var_324_3 = 0
			local var_324_4 = 0.225

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_3 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_5 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(103802080).content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 9 <= 0 and var_324_4 or var_324_4 * (utf8.len(var_324_5) / 9)

				if (9 <= 0 and var_324_4 or var_324_4 * (utf8.len(var_324_5) / 9)) > 0 and var_324_4 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_3 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_3
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_4, arg_321_1.talkMaxDuration)

			if var_324_3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_3 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_3) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_3 + var_324_8 and arg_321_1.time_ < var_324_3 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play103802081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 103802081
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play103802082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.3

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_1 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(103802081).content)

				arg_325_1.text_.text = var_328_1

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_3 = 12 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 12)

				if (12 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 12)) > 0 and var_328_0 < var_328_3 then
					arg_325_1.talkMaxDuration = var_328_3

					if var_328_3 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_3 + 0
					end
				end

				arg_325_1.text_.text = var_328_1
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_4 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_4

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play103802082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 103802082
		arg_329_1.duration_ = 10.13

		local var_329_0 = {
			ja = 10.133,
			ko = 8.3,
			en = 9.9
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play103802083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1038ui_story"]) and arg_329_1.var_.characterEffect1038ui_story == nil then
				arg_329_1.var_.characterEffect1038ui_story = arg_329_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.1

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1038ui_story"]) then
				if arg_329_1.var_.characterEffect1038ui_story and not isNil(arg_329_1.actors_["1038ui_story"]) then
					arg_329_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1038ui_story"]) and arg_329_1.var_.characterEffect1038ui_story then
				arg_329_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_332_2 = arg_329_1.actors_["1038ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1038ui_story = var_332_2.localPosition
			end

			local var_332_3 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_3 then
				var_332_2.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.16, -5.3), (arg_329_1.time_ - 0) / var_332_3)
				var_332_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_2.position).x, (manager.ui.mainCamera.transform.position - var_332_2.position).y, (manager.ui.mainCamera.transform.position - var_332_2.position).z)
				var_332_2.localEulerAngles.z = 0
				var_332_2.localEulerAngles.x = 0
				var_332_2.localEulerAngles = var_332_2.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_3 and arg_329_1.time_ < 0 + var_332_3 + arg_332_0 then
				var_332_2.localPosition = Vector3.New(0, -1.16, -5.3)
				var_332_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_2.position).x, (manager.ui.mainCamera.transform.position - var_332_2.position).y, (manager.ui.mainCamera.transform.position - var_332_2.position).z)
				var_332_2.localEulerAngles.z = 0
				var_332_2.localEulerAngles.x = 0
				var_332_2.localEulerAngles = var_332_2.localEulerAngles
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_332_4 = 0
			local var_332_5 = 0.925

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(103802082)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 37 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 37)

				if (37 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 37)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802082", "story_v_side_old_103802.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802082", "story_v_side_old_103802.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_side_old_103802", "103802082", "story_v_side_old_103802.awb")

						arg_329_1:RecordAudio("103802082", var_332_11)
						arg_329_1:RecordAudio("103802082", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802082", "story_v_side_old_103802.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802082", "story_v_side_old_103802.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_12 and arg_329_1.time_ < var_332_4 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play103802083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 103802083
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play103802084(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.85

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(103802083).content)

				arg_333_1.text_.text = var_336_1

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_3 = 34 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 34)

				if (34 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 34)) > 0 and var_336_0 < var_336_3 then
					arg_333_1.talkMaxDuration = var_336_3

					if var_336_3 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_3 + 0
					end
				end

				arg_333_1.text_.text = var_336_1
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_4 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_4

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play103802084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 103802084
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play103802085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 1.375

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(103802084).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 55 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 55)

				if (55 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 55)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play103802085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 103802085
		arg_341_1.duration_ = 6.27

		local var_341_0 = {
			ja = 6.066,
			ko = 6.266,
			en = 5.033
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
				arg_341_0:Play103802086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action453")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_344_0 = 0
			local var_344_1 = 0.6

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_2 = arg_341_1:GetWordFromCfg(103802085)
				local var_344_3 = arg_341_1:FormatText(var_344_2.content)

				arg_341_1.text_.text = var_344_3

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 24 <= 0 and var_344_1 or var_344_1 * (utf8.len(var_344_3) / 24)

				if (24 <= 0 and var_344_1 or var_344_1 * (utf8.len(var_344_3) / 24)) > 0 and var_344_1 < var_344_5 then
					arg_341_1.talkMaxDuration = var_344_5

					if var_344_5 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_3
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802085", "story_v_side_old_103802.awb") ~= 0 then
					local var_344_6 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802085", "story_v_side_old_103802.awb") / 1000

					if var_344_6 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_6 + var_344_0
					end

					if var_344_2.prefab_name ~= "" and arg_341_1.actors_[var_344_2.prefab_name] ~= nil then
						local var_344_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_2.prefab_name].transform, "story_v_side_old_103802", "103802085", "story_v_side_old_103802.awb")

						arg_341_1:RecordAudio("103802085", var_344_7)
						arg_341_1:RecordAudio("103802085", var_344_7)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802085", "story_v_side_old_103802.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802085", "story_v_side_old_103802.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_8 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_8 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_8

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_8 and arg_341_1.time_ < var_344_0 + var_344_8 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play103802086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 103802086
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play103802087(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1038ui_story"]) and arg_345_1.var_.characterEffect1038ui_story == nil then
				arg_345_1.var_.characterEffect1038ui_story = arg_345_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.1

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1038ui_story"]) then
				if arg_345_1.var_.characterEffect1038ui_story and not isNil(arg_345_1.actors_["1038ui_story"]) then
					arg_345_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_0)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1038ui_story"]) and arg_345_1.var_.characterEffect1038ui_story then
				arg_345_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_348_1 = 0
			local var_348_2 = 0.2

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_3 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(103802086).content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 8 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 8)

				if (8 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 8)) > 0 and var_348_2 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_1
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_6 = math.max(var_348_2, arg_345_1.talkMaxDuration)

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_6 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_1) / var_348_6

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_1 + var_348_6 and arg_345_1.time_ < var_348_1 + var_348_6 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play103802087 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 103802087
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play103802088(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.7

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(103802087).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 28 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 28)

				if (28 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 28)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play103802088 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 103802088
		arg_353_1.duration_ = 12.97

		local var_353_0 = {
			ja = 12.966,
			ko = 12.466,
			en = 9.633
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play103802089(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1038ui_story"]) and arg_353_1.var_.characterEffect1038ui_story == nil then
				arg_353_1.var_.characterEffect1038ui_story = arg_353_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.1

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1038ui_story"]) then
				if arg_353_1.var_.characterEffect1038ui_story and not isNil(arg_353_1.actors_["1038ui_story"]) then
					arg_353_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1038ui_story"]) and arg_353_1.var_.characterEffect1038ui_story then
				arg_353_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action435")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_356_2 = 0
			local var_356_3 = 1.1

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_4 = arg_353_1:GetWordFromCfg(103802088)
				local var_356_5 = arg_353_1:FormatText(var_356_4.content)

				arg_353_1.text_.text = var_356_5

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_7 = 44 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_5) / 44)

				if (44 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_5) / 44)) > 0 and var_356_3 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_2
					end
				end

				arg_353_1.text_.text = var_356_5
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802088", "story_v_side_old_103802.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802088", "story_v_side_old_103802.awb") / 1000

					if var_356_8 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_2
					end

					if var_356_4.prefab_name ~= "" and arg_353_1.actors_[var_356_4.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_4.prefab_name].transform, "story_v_side_old_103802", "103802088", "story_v_side_old_103802.awb")

						arg_353_1:RecordAudio("103802088", var_356_9)
						arg_353_1:RecordAudio("103802088", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802088", "story_v_side_old_103802.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802088", "story_v_side_old_103802.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_3, arg_353_1.talkMaxDuration)

			if var_356_2 <= arg_353_1.time_ and arg_353_1.time_ < var_356_2 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_2) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_2 + var_356_10 and arg_353_1.time_ < var_356_2 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play103802089 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 103802089
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play103802090(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1038ui_story"]) and arg_357_1.var_.characterEffect1038ui_story == nil then
				arg_357_1.var_.characterEffect1038ui_story = arg_357_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.1

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1038ui_story"]) then
				if arg_357_1.var_.characterEffect1038ui_story and not isNil(arg_357_1.actors_["1038ui_story"]) then
					arg_357_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_0)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1038ui_story"]) and arg_357_1.var_.characterEffect1038ui_story then
				arg_357_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_360_1 = 0
			local var_360_2 = 0.05

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_3 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(103802089).content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 2 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 2)

				if (2 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 2)) > 0 and var_360_2 < var_360_5 then
					arg_357_1.talkMaxDuration = var_360_5

					if var_360_5 + var_360_1 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + var_360_1
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_6 = math.max(var_360_2, arg_357_1.talkMaxDuration)

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_6 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_1) / var_360_6

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_1 + var_360_6 and arg_357_1.time_ < var_360_1 + var_360_6 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play103802090 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 103802090
		arg_361_1.duration_ = 17.33

		local var_361_0 = {
			ja = 17.333,
			ko = 11.466,
			en = 10.3
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play103802091(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1038ui_story"]) and arg_361_1.var_.characterEffect1038ui_story == nil then
				arg_361_1.var_.characterEffect1038ui_story = arg_361_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.1

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1038ui_story"]) then
				if arg_361_1.var_.characterEffect1038ui_story and not isNil(arg_361_1.actors_["1038ui_story"]) then
					arg_361_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1038ui_story"]) and arg_361_1.var_.characterEffect1038ui_story then
				arg_361_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action457")
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_364_2 = 0
			local var_364_3 = 1.125

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_2 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_4 = arg_361_1:GetWordFromCfg(103802090)
				local var_364_5 = arg_361_1:FormatText(var_364_4.content)

				arg_361_1.text_.text = var_364_5

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_7 = 45 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_5) / 45)

				if (45 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_5) / 45)) > 0 and var_364_3 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_2
					end
				end

				arg_361_1.text_.text = var_364_5
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802090", "story_v_side_old_103802.awb") ~= 0 then
					local var_364_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802090", "story_v_side_old_103802.awb") / 1000

					if var_364_8 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_2
					end

					if var_364_4.prefab_name ~= "" and arg_361_1.actors_[var_364_4.prefab_name] ~= nil then
						local var_364_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_4.prefab_name].transform, "story_v_side_old_103802", "103802090", "story_v_side_old_103802.awb")

						arg_361_1:RecordAudio("103802090", var_364_9)
						arg_361_1:RecordAudio("103802090", var_364_9)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802090", "story_v_side_old_103802.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802090", "story_v_side_old_103802.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_3, arg_361_1.talkMaxDuration)

			if var_364_2 <= arg_361_1.time_ and arg_361_1.time_ < var_364_2 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_2) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_2 + var_364_10 and arg_361_1.time_ < var_364_2 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play103802091 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 103802091
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play103802092(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1038ui_story"]) and arg_365_1.var_.characterEffect1038ui_story == nil then
				arg_365_1.var_.characterEffect1038ui_story = arg_365_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.1

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1038ui_story"]) then
				if arg_365_1.var_.characterEffect1038ui_story and not isNil(arg_365_1.actors_["1038ui_story"]) then
					arg_365_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_365_1.time_ - 0) / var_368_0)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1038ui_story"]) and arg_365_1.var_.characterEffect1038ui_story then
				arg_365_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_368_1 = 0
			local var_368_2 = 0.25

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(103802091).content)

				arg_365_1.text_.text = var_368_3

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 10 <= 0 and var_368_2 or var_368_2 * (utf8.len(var_368_3) / 10)

				if (10 <= 0 and var_368_2 or var_368_2 * (utf8.len(var_368_3) / 10)) > 0 and var_368_2 < var_368_5 then
					arg_365_1.talkMaxDuration = var_368_5

					if var_368_5 + var_368_1 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + var_368_1
					end
				end

				arg_365_1.text_.text = var_368_3
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_6 = math.max(var_368_2, arg_365_1.talkMaxDuration)

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_6 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_1) / var_368_6

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_1 + var_368_6 and arg_365_1.time_ < var_368_1 + var_368_6 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play103802092 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 103802092
		arg_369_1.duration_ = 2

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play103802093(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1038ui_story"]) and arg_369_1.var_.characterEffect1038ui_story == nil then
				arg_369_1.var_.characterEffect1038ui_story = arg_369_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.1

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1038ui_story"]) then
				if arg_369_1.var_.characterEffect1038ui_story and not isNil(arg_369_1.actors_["1038ui_story"]) then
					arg_369_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1038ui_story"]) and arg_369_1.var_.characterEffect1038ui_story then
				arg_369_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action474")
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_372_2 = 0
			local var_372_3 = 0.075

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_2 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_4 = arg_369_1:GetWordFromCfg(103802092)
				local var_372_5 = arg_369_1:FormatText(var_372_4.content)

				arg_369_1.text_.text = var_372_5

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_7 = 3 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 3)

				if (3 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 3)) > 0 and var_372_3 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_2
					end
				end

				arg_369_1.text_.text = var_372_5
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802092", "story_v_side_old_103802.awb") ~= 0 then
					local var_372_8 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802092", "story_v_side_old_103802.awb") / 1000

					if var_372_8 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_2
					end

					if var_372_4.prefab_name ~= "" and arg_369_1.actors_[var_372_4.prefab_name] ~= nil then
						local var_372_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_4.prefab_name].transform, "story_v_side_old_103802", "103802092", "story_v_side_old_103802.awb")

						arg_369_1:RecordAudio("103802092", var_372_9)
						arg_369_1:RecordAudio("103802092", var_372_9)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802092", "story_v_side_old_103802.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802092", "story_v_side_old_103802.awb")
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
	Play103802093 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 103802093
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play103802094(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.875

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_1 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(103802093).content)

				arg_373_1.text_.text = var_376_1

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_3 = 35 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 35)

				if (35 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 35)) > 0 and var_376_0 < var_376_3 then
					arg_373_1.talkMaxDuration = var_376_3

					if var_376_3 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_3 + 0
					end
				end

				arg_373_1.text_.text = var_376_1
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_4 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_4

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play103802094 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 103802094
		arg_377_1.duration_ = 9.5

		local var_377_0 = {
			ja = 9.5,
			ko = 9.066,
			en = 7.3
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play103802095(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action447")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_380_0 = 0
			local var_380_1 = 0.775

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_2 = arg_377_1:GetWordFromCfg(103802094)
				local var_380_3 = arg_377_1:FormatText(var_380_2.content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 31 <= 0 and var_380_1 or var_380_1 * (utf8.len(var_380_3) / 31)

				if (31 <= 0 and var_380_1 or var_380_1 * (utf8.len(var_380_3) / 31)) > 0 and var_380_1 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802094", "story_v_side_old_103802.awb") ~= 0 then
					local var_380_6 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802094", "story_v_side_old_103802.awb") / 1000

					if var_380_6 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_6 + var_380_0
					end

					if var_380_2.prefab_name ~= "" and arg_377_1.actors_[var_380_2.prefab_name] ~= nil then
						local var_380_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_2.prefab_name].transform, "story_v_side_old_103802", "103802094", "story_v_side_old_103802.awb")

						arg_377_1:RecordAudio("103802094", var_380_7)
						arg_377_1:RecordAudio("103802094", var_380_7)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802094", "story_v_side_old_103802.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802094", "story_v_side_old_103802.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_8 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_8 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_8

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_8 and arg_377_1.time_ < var_380_0 + var_380_8 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play103802095 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 103802095
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play103802096(arg_381_1)
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

				local var_384_1 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(103802095).content)

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
	Play103802096 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 103802096
		arg_385_1.duration_ = 7.07

		local var_385_0 = {
			ja = 7.066,
			ko = 5.766,
			en = 6.333
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
				arg_385_0:Play103802097(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action476")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_388_0 = 0
			local var_388_1 = 0.45

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_2 = arg_385_1:GetWordFromCfg(103802096)
				local var_388_3 = arg_385_1:FormatText(var_388_2.content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 18 <= 0 and var_388_1 or var_388_1 * (utf8.len(var_388_3) / 18)

				if (18 <= 0 and var_388_1 or var_388_1 * (utf8.len(var_388_3) / 18)) > 0 and var_388_1 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_0
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103802", "103802096", "story_v_side_old_103802.awb") ~= 0 then
					local var_388_6 = manager.audio:GetVoiceLength("story_v_side_old_103802", "103802096", "story_v_side_old_103802.awb") / 1000

					if var_388_6 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_6 + var_388_0
					end

					if var_388_2.prefab_name ~= "" and arg_385_1.actors_[var_388_2.prefab_name] ~= nil then
						local var_388_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_2.prefab_name].transform, "story_v_side_old_103802", "103802096", "story_v_side_old_103802.awb")

						arg_385_1:RecordAudio("103802096", var_388_7)
						arg_385_1:RecordAudio("103802096", var_388_7)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_side_old_103802", "103802096", "story_v_side_old_103802.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_side_old_103802", "103802096", "story_v_side_old_103802.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_8 = math.max(var_388_1, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_8 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_0) / var_388_8

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_8 and arg_385_1.time_ < var_388_0 + var_388_8 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play103802097 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 103802097
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
			arg_389_1.auto_ = false
		end

		function arg_389_1.playNext_(arg_391_0)
			arg_389_1.onStoryFinished_()
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1038ui_story"]) and arg_389_1.var_.characterEffect1038ui_story == nil then
				arg_389_1.var_.characterEffect1038ui_story = arg_389_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.1

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1038ui_story"]) then
				if arg_389_1.var_.characterEffect1038ui_story and not isNil(arg_389_1.actors_["1038ui_story"]) then
					arg_389_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_0)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1038ui_story"]) and arg_389_1.var_.characterEffect1038ui_story then
				arg_389_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_392_1 = arg_389_1.actors_["1038ui_story"].transform

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1038ui_story = var_392_1.localPosition
			end

			local var_392_2 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 then
				var_392_1.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1038ui_story, Vector3.New(30, -1.16, -5.3), (arg_389_1.time_ - 0) / var_392_2)
				var_392_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_392_1.position).x, (manager.ui.mainCamera.transform.position - var_392_1.position).y, (manager.ui.mainCamera.transform.position - var_392_1.position).z)
				var_392_1.localEulerAngles.z = 0
				var_392_1.localEulerAngles.x = 0
				var_392_1.localEulerAngles = var_392_1.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 then
				var_392_1.localPosition = Vector3.New(30, -1.16, -5.3)
				var_392_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_392_1.position).x, (manager.ui.mainCamera.transform.position - var_392_1.position).y, (manager.ui.mainCamera.transform.position - var_392_1.position).z)
				var_392_1.localEulerAngles.z = 0
				var_392_1.localEulerAngles.x = 0
				var_392_1.localEulerAngles = var_392_1.localEulerAngles
			end

			local var_392_3 = 0
			local var_392_4 = 0.85

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_3 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_5 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(103802097).content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 34 <= 0 and var_392_4 or var_392_4 * (utf8.len(var_392_5) / 34)

				if (34 <= 0 and var_392_4 or var_392_4 * (utf8.len(var_392_5) / 34)) > 0 and var_392_4 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_3 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_3
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_8 = math.max(var_392_4, arg_389_1.talkMaxDuration)

			if var_392_3 <= arg_389_1.time_ and arg_389_1.time_ < var_392_3 + var_392_8 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_3) / var_392_8

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_3 + var_392_8 and arg_389_1.time_ < var_392_3 + var_392_8 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/D02b"
	},
	voices = {
		"story_v_side_old_103802.awb"
	}
}
