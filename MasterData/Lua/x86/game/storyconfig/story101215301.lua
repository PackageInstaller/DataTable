return {
	Play121531001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121531001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121531002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST37a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37a")
				var_4_0.name = "ST37a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST37a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST37a

				arg_1_1.bgs_.ST37a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST37a" then
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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
			local var_4_15 = 1.475

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(121531001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 59 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 59)

				if (59 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 59)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play121531002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121531002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121531003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(121531002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 40 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 40)

				if (40 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 40)) > 0 and var_12_0 < var_12_3 then
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
	Play121531003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121531003
		arg_13_1.duration_ = 11.1

		local var_13_0 = {
			ja = 9.366,
			ko = 11.1,
			zh = 11.1
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
				arg_13_0:Play121531004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1074ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1074ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1074ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1074ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1074ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1074ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1074ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.055, -6.12)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1074ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1074ui_story == nil then
				arg_13_1.var_.characterEffect1074ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1074ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1074ui_story then
				arg_13_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.8

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(121531003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 32 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 32)

				if (32 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 32)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531003", "story_v_out_121531.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_121531", "121531003", "story_v_out_121531.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_121531", "121531003", "story_v_out_121531.awb")

						arg_13_1:RecordAudio("121531003", var_16_15)
						arg_13_1:RecordAudio("121531003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121531", "121531003", "story_v_out_121531.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121531", "121531003", "story_v_out_121531.awb")
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
				actorName = "1074ui_story",
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
	Play121531004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121531004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play121531005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1074ui_story = arg_17_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1074ui_story"].transform.position).z)
				arg_17_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1074ui_story"].transform.localEulerAngles = arg_17_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1074ui_story"].transform.position).z)
				arg_17_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1074ui_story"].transform.localEulerAngles = arg_17_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1074ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1074ui_story == nil then
				arg_17_1.var_.characterEffect1074ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1074ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1074ui_story then
				arg_17_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 0.9

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(121531004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 36 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 36)

				if (36 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 36)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play121531005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121531005
		arg_21_1.duration_ = 6

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play121531006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_24_0 = 1

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				local var_24_1, var_24_2 = math.modf((arg_21_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_24_2 * 0.13, var_24_2 * 0.13, var_24_2 * 0.13) + arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				manager.ui.mainCamera.transform.localPosition = arg_21_1.var_.shakeOldPos
			end

			local var_24_3 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			if arg_21_1.time_ >= var_24_3 + 1 and arg_21_1.time_ < var_24_3 + 1 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_5 = 1
			local var_24_6 = 1.325

			if 1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_7 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_7:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(121531005).content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 53 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 53)

				if (53 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 53)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10
					var_24_5 = var_24_5 + 0.3

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = var_24_5 + 0.3
			local var_24_12 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_12 and arg_21_1.time_ < var_24_11 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play121531006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 121531006
		arg_27_1.duration_ = 6.8

		local var_27_0 = {
			ja = 3.866,
			ko = 6.8,
			zh = 6.8
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play121531007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1074ui_story = arg_27_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).z)
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles = arg_27_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_27_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).z)
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles = arg_27_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1074ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1074ui_story == nil then
				arg_27_1.var_.characterEffect1074ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1074ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1074ui_story then
				arg_27_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_30_4 = 0
			local var_30_5 = 0.225

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_6 = arg_27_1:GetWordFromCfg(121531006)
				local var_30_7 = arg_27_1:FormatText(var_30_6.content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 9 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 9)

				if (9 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 9)) > 0 and var_30_5 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_4
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531006", "story_v_out_121531.awb") ~= 0 then
					local var_30_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531006", "story_v_out_121531.awb") / 1000

					if var_30_10 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_4
					end

					if var_30_6.prefab_name ~= "" and arg_27_1.actors_[var_30_6.prefab_name] ~= nil then
						local var_30_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_6.prefab_name].transform, "story_v_out_121531", "121531006", "story_v_out_121531.awb")

						arg_27_1:RecordAudio("121531006", var_30_11)
						arg_27_1:RecordAudio("121531006", var_30_11)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_121531", "121531006", "story_v_out_121531.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_121531", "121531006", "story_v_out_121531.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_12 = math.max(var_30_5, arg_27_1.talkMaxDuration)

			if var_30_4 <= arg_27_1.time_ and arg_27_1.time_ < var_30_4 + var_30_12 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_4) / var_30_12

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_4 + var_30_12 and arg_27_1.time_ < var_30_4 + var_30_12 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play121531007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 121531007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play121531008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1074ui_story = arg_31_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1074ui_story"].transform.position).z)
				arg_31_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1074ui_story"].transform.localEulerAngles = arg_31_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1074ui_story"].transform.position).z)
				arg_31_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1074ui_story"].transform.localEulerAngles = arg_31_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1074ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1074ui_story == nil then
				arg_31_1.var_.characterEffect1074ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1074ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_2)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1074ui_story then
				arg_31_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_34_3 = 0
			local var_34_4 = 1.1

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_5 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(121531007).content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 44 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 44)

				if (44 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 44)) > 0 and var_34_4 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_3
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_8 = math.max(var_34_4, arg_31_1.talkMaxDuration)

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_8 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_3) / var_34_8

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_3 + var_34_8 and arg_31_1.time_ < var_34_3 + var_34_8 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play121531008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 121531008
		arg_35_1.duration_ = 3.87

		local var_35_0 = {
			ja = 3.866,
			ko = 2.933,
			zh = 2.933
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play121531009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1074ui_story = arg_35_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).z)
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles = arg_35_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_35_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).z)
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles = arg_35_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1074ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1074ui_story == nil then
				arg_35_1.var_.characterEffect1074ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1074ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1074ui_story then
				arg_35_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_38_4 = 0
			local var_38_5 = 0.25

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(121531008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 10 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 10)

				if (10 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 10)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531008", "story_v_out_121531.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531008", "story_v_out_121531.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_121531", "121531008", "story_v_out_121531.awb")

						arg_35_1:RecordAudio("121531008", var_38_11)
						arg_35_1:RecordAudio("121531008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_121531", "121531008", "story_v_out_121531.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_121531", "121531008", "story_v_out_121531.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play121531009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 121531009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play121531010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1074ui_story = arg_39_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).z)
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles = arg_39_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).z)
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles = arg_39_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1074ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1074ui_story == nil then
				arg_39_1.var_.characterEffect1074ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1074ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_2)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1074ui_story then
				arg_39_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_42_3 = 0
			local var_42_4 = 1.2

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_5 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(121531009).content)

				arg_39_1.text_.text = var_42_5

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_7 = 48 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_5) / 48)

				if (48 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_5) / 48)) > 0 and var_42_4 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_3
					end
				end

				arg_39_1.text_.text = var_42_5
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_4, arg_39_1.talkMaxDuration)

			if var_42_3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_3 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_3) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_3 + var_42_8 and arg_39_1.time_ < var_42_3 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play121531010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 121531010
		arg_43_1.duration_ = 7.97

		local var_43_0 = {
			ja = 7.966,
			ko = 6.966,
			zh = 6.966
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
				arg_43_0:Play121531011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1074ui_story = arg_43_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).z)
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles = arg_43_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_43_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).z)
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles = arg_43_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1074ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1074ui_story == nil then
				arg_43_1.var_.characterEffect1074ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1074ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_2)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1074ui_story then
				arg_43_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_46_3 = "10044ui_story"

			if arg_43_1.actors_["10044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10044ui_story"))) then
				local var_46_4 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_43_1.stage_.transform)

				var_46_4.name = var_46_3
				var_46_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_[var_46_3] = var_46_4

				local var_46_5 = var_46_4:GetComponentInChildren(typeof(CharacterEffect))

				var_46_5.enabled = true

				local var_46_6 = GameObjectTools.GetOrAddComponent(var_46_4, typeof(DynamicBoneHelper))

				if var_46_6 then
					var_46_6:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_5.transform, false)

				arg_43_1.var_[var_46_3 .. "Animator"] = var_46_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_[var_46_3 .. "Animator"].applyRootMotion = true
				arg_43_1.var_[var_46_3 .. "LipSync"] = var_46_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_7 = arg_43_1.actors_["10044ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10044ui_story = var_46_7.localPosition
			end

			local var_46_8 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_8 then
				var_46_7.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_43_1.time_ - 0) / var_46_8)
				var_46_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_7.position).x, (manager.ui.mainCamera.transform.position - var_46_7.position).y, (manager.ui.mainCamera.transform.position - var_46_7.position).z)
				var_46_7.localEulerAngles.z = 0
				var_46_7.localEulerAngles.x = 0
				var_46_7.localEulerAngles = var_46_7.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_8 and arg_43_1.time_ < 0 + var_46_8 + arg_46_0 then
				var_46_7.localPosition = Vector3.New(0.7, -0.72, -6.3)
				var_46_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_7.position).x, (manager.ui.mainCamera.transform.position - var_46_7.position).y, (manager.ui.mainCamera.transform.position - var_46_7.position).z)
				var_46_7.localEulerAngles.z = 0
				var_46_7.localEulerAngles.x = 0
				var_46_7.localEulerAngles = var_46_7.localEulerAngles
			end

			local var_46_9 = arg_43_1.actors_["10044ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect10044ui_story == nil then
				arg_43_1.var_.characterEffect10044ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_10 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_10 and not isNil(var_46_9) then
				if arg_43_1.var_.characterEffect10044ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_10 and arg_43_1.time_ < 0 + var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect10044ui_story then
				arg_43_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_46_12 = 0
			local var_46_13 = 1

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_14 = arg_43_1:GetWordFromCfg(121531010)
				local var_46_15 = arg_43_1:FormatText(var_46_14.content)

				arg_43_1.text_.text = var_46_15

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_17 = 40 <= 0 and var_46_13 or var_46_13 * (utf8.len(var_46_15) / 40)

				if (40 <= 0 and var_46_13 or var_46_13 * (utf8.len(var_46_15) / 40)) > 0 and var_46_13 < var_46_17 then
					arg_43_1.talkMaxDuration = var_46_17

					if var_46_17 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_17 + var_46_12
					end
				end

				arg_43_1.text_.text = var_46_15
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531010", "story_v_out_121531.awb") ~= 0 then
					local var_46_18 = manager.audio:GetVoiceLength("story_v_out_121531", "121531010", "story_v_out_121531.awb") / 1000

					if var_46_18 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_18 + var_46_12
					end

					if var_46_14.prefab_name ~= "" and arg_43_1.actors_[var_46_14.prefab_name] ~= nil then
						local var_46_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_14.prefab_name].transform, "story_v_out_121531", "121531010", "story_v_out_121531.awb")

						arg_43_1:RecordAudio("121531010", var_46_19)
						arg_43_1:RecordAudio("121531010", var_46_19)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_121531", "121531010", "story_v_out_121531.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_121531", "121531010", "story_v_out_121531.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_20 = math.max(var_46_13, arg_43_1.talkMaxDuration)

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_20 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_12) / var_46_20

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_12 + var_46_20 and arg_43_1.time_ < var_46_12 + var_46_20 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play121531011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 121531011
		arg_47_1.duration_ = 7.7

		local var_47_0 = {
			ja = 7.7,
			ko = 5.066,
			zh = 5.066
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
				arg_47_0:Play121531012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1074ui_story"]) and arg_47_1.var_.characterEffect1074ui_story == nil then
				arg_47_1.var_.characterEffect1074ui_story = arg_47_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1074ui_story"]) then
				if arg_47_1.var_.characterEffect1074ui_story and not isNil(arg_47_1.actors_["1074ui_story"]) then
					arg_47_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1074ui_story"]) and arg_47_1.var_.characterEffect1074ui_story then
				arg_47_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_2 = arg_47_1.actors_["10044ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect10044ui_story == nil then
				arg_47_1.var_.characterEffect10044ui_story = var_50_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_3 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.characterEffect10044ui_story and not isNil(var_50_2) then
					arg_47_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_3)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect10044ui_story then
				arg_47_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_50_4 = 0
			local var_50_5 = 0.5

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(121531011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 20 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 20)

				if (20 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 20)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531011", "story_v_out_121531.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531011", "story_v_out_121531.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_121531", "121531011", "story_v_out_121531.awb")

						arg_47_1:RecordAudio("121531011", var_50_11)
						arg_47_1:RecordAudio("121531011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_121531", "121531011", "story_v_out_121531.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_121531", "121531011", "story_v_out_121531.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_12 and arg_47_1.time_ < var_50_4 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play121531012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 121531012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play121531013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1074ui_story = arg_51_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1074ui_story"].transform.position).z)
				arg_51_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1074ui_story"].transform.localEulerAngles = arg_51_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1074ui_story"].transform.position).z)
				arg_51_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1074ui_story"].transform.localEulerAngles = arg_51_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1074ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1074ui_story == nil then
				arg_51_1.var_.characterEffect1074ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1074ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_2)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1074ui_story then
				arg_51_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_54_3 = arg_51_1.actors_["10044ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10044ui_story = var_54_3.localPosition
			end

			local var_54_4 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				var_54_3.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_4)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				var_54_3.localPosition = Vector3.New(0, 100, 0)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			local var_54_5 = arg_51_1.actors_["10044ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect10044ui_story == nil then
				arg_51_1.var_.characterEffect10044ui_story = var_54_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_6 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 and not isNil(var_54_5) then
				if arg_51_1.var_.characterEffect10044ui_story and not isNil(var_54_5) then
					arg_51_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_6)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect10044ui_story then
				arg_51_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_54_8 = 0
			local var_54_9 = 1.15

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_10 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(121531012).content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_12 = 46 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_10) / 46)

				if (46 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_10) / 46)) > 0 and var_54_9 < var_54_12 then
					arg_51_1.talkMaxDuration = var_54_12

					if var_54_12 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_12 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_13 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_13 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_8) / var_54_13

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_8 + var_54_13 and arg_51_1.time_ < var_54_8 + var_54_13 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play121531013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 121531013
		arg_55_1.duration_ = 7.07

		local var_55_0 = {
			ja = 7.065999999999,
			ko = 6.632999999999,
			zh = 6.632999999999
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
				arg_55_0:Play121531014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.bgs_.ST29a == nil then
				local var_58_0 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST29a")
				var_58_0.name = "ST29a"
				var_58_0.transform.parent = arg_55_1.stage_.transform
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_.ST29a = var_58_0
			end

			if 1.999999999999 < arg_55_1.time_ and arg_55_1.time_ <= 1.999999999999 + arg_58_0 then
				local var_58_1 = arg_55_1.bgs_.ST29a

				arg_55_1.bgs_.ST29a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_58_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_2 = var_58_1:GetComponent("SpriteRenderer")

				if var_58_2 and var_58_2.sprite then
					local var_58_3 = 2 * (var_58_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_58_1.transform.localScale = Vector3.New(var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "ST29a" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_4 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_5 = 2

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_5 then
				local var_58_6 = Color.New(0, 0, 0)

				var_58_6.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_4) / var_58_5)
				arg_55_1.mask_.color = var_58_6
			end

			if arg_55_1.time_ >= var_58_4 + var_58_5 and arg_55_1.time_ < var_58_4 + var_58_5 + arg_58_0 then
				local var_58_7 = Color.New(0, 0, 0)

				var_58_7.a = 1
				arg_55_1.mask_.color = var_58_7
			end

			local var_58_8 = 2

			if 2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_9 = 2

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 then
				local var_58_10 = Color.New(0, 0, 0)

				var_58_10.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_8) / var_58_9)
				arg_55_1.mask_.color = var_58_10
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 then
				local var_58_11 = Color.New(0, 0, 0)

				arg_55_1.mask_.enabled = false
				var_58_11.a = 0
				arg_55_1.mask_.color = var_58_11
			end

			local var_58_12 = "1072ui_story"

			if arg_55_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_58_13 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_55_1.stage_.transform)

				var_58_13.name = var_58_12
				var_58_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_[var_58_12] = var_58_13

				local var_58_14 = var_58_13:GetComponentInChildren(typeof(CharacterEffect))

				var_58_14.enabled = true

				local var_58_15 = GameObjectTools.GetOrAddComponent(var_58_13, typeof(DynamicBoneHelper))

				if var_58_15 then
					var_58_15:EnableDynamicBone(false)
				end

				arg_55_1:ShowWeapon(var_58_14.transform, false)

				arg_55_1.var_[var_58_12 .. "Animator"] = var_58_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_55_1.var_[var_58_12 .. "Animator"].applyRootMotion = true
				arg_55_1.var_[var_58_12 .. "LipSync"] = var_58_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_58_16 = arg_55_1.actors_["1072ui_story"].transform

			if 3.8 < arg_55_1.time_ and arg_55_1.time_ <= 3.8 + arg_58_0 then
				arg_55_1.var_.moveOldPos1072ui_story = var_58_16.localPosition
			end

			local var_58_17 = 0.001

			if 3.8 <= arg_55_1.time_ and arg_55_1.time_ < 3.8 + var_58_17 then
				var_58_16.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_55_1.time_ - 3.8) / var_58_17)
				var_58_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_16.position).x, (manager.ui.mainCamera.transform.position - var_58_16.position).y, (manager.ui.mainCamera.transform.position - var_58_16.position).z)
				var_58_16.localEulerAngles.z = 0
				var_58_16.localEulerAngles.x = 0
				var_58_16.localEulerAngles = var_58_16.localEulerAngles
			end

			if arg_55_1.time_ >= 3.8 + var_58_17 and arg_55_1.time_ < 3.8 + var_58_17 + arg_58_0 then
				var_58_16.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_58_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_16.position).x, (manager.ui.mainCamera.transform.position - var_58_16.position).y, (manager.ui.mainCamera.transform.position - var_58_16.position).z)
				var_58_16.localEulerAngles.z = 0
				var_58_16.localEulerAngles.x = 0
				var_58_16.localEulerAngles = var_58_16.localEulerAngles
			end

			local var_58_18 = arg_55_1.actors_["1072ui_story"]

			if 3.8 < arg_55_1.time_ and arg_55_1.time_ <= 3.8 + arg_58_0 and not isNil(var_58_18) and arg_55_1.var_.characterEffect1072ui_story == nil then
				arg_55_1.var_.characterEffect1072ui_story = var_58_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_19 = 0.200000002980232

			if 3.8 <= arg_55_1.time_ and arg_55_1.time_ < 3.8 + var_58_19 and not isNil(var_58_18) then
				if arg_55_1.var_.characterEffect1072ui_story and not isNil(var_58_18) then
					arg_55_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 3.8 + var_58_19 and arg_55_1.time_ < 3.8 + var_58_19 + arg_58_0 and not isNil(var_58_18) and arg_55_1.var_.characterEffect1072ui_story then
				arg_55_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 3.8 < arg_55_1.time_ and arg_55_1.time_ <= 3.8 + arg_58_0 then
				arg_55_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 3.8 < arg_55_1.time_ and arg_55_1.time_ <= 3.8 + arg_58_0 then
				arg_55_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_21 = arg_55_1.actors_["1074ui_story"].transform

			if 3.8 < arg_55_1.time_ and arg_55_1.time_ <= 3.8 + arg_58_0 then
				arg_55_1.var_.moveOldPos1074ui_story = var_58_21.localPosition
			end

			local var_58_22 = 0.001

			if 3.8 <= arg_55_1.time_ and arg_55_1.time_ < 3.8 + var_58_22 then
				var_58_21.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_55_1.time_ - 3.8) / var_58_22)
				var_58_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_21.position).x, (manager.ui.mainCamera.transform.position - var_58_21.position).y, (manager.ui.mainCamera.transform.position - var_58_21.position).z)
				var_58_21.localEulerAngles.z = 0
				var_58_21.localEulerAngles.x = 0
				var_58_21.localEulerAngles = var_58_21.localEulerAngles
			end

			if arg_55_1.time_ >= 3.8 + var_58_22 and arg_55_1.time_ < 3.8 + var_58_22 + arg_58_0 then
				var_58_21.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_58_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_21.position).x, (manager.ui.mainCamera.transform.position - var_58_21.position).y, (manager.ui.mainCamera.transform.position - var_58_21.position).z)
				var_58_21.localEulerAngles.z = 0
				var_58_21.localEulerAngles.x = 0
				var_58_21.localEulerAngles = var_58_21.localEulerAngles
			end

			local var_58_23 = arg_55_1.actors_["1074ui_story"]

			if 3.8 < arg_55_1.time_ and arg_55_1.time_ <= 3.8 + arg_58_0 and not isNil(var_58_23) and arg_55_1.var_.characterEffect1074ui_story == nil then
				arg_55_1.var_.characterEffect1074ui_story = var_58_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_24 = 0.200000002980232

			if 3.8 <= arg_55_1.time_ and arg_55_1.time_ < 3.8 + var_58_24 and not isNil(var_58_23) then
				if arg_55_1.var_.characterEffect1074ui_story and not isNil(var_58_23) then
					arg_55_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 3.8) / var_58_24)
				end
			end

			if arg_55_1.time_ >= 3.8 + var_58_24 and arg_55_1.time_ < 3.8 + var_58_24 + arg_58_0 and not isNil(var_58_23) and arg_55_1.var_.characterEffect1074ui_story then
				arg_55_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_25 = 3.999999999999
			local var_58_26 = 0.35

			if 3.999999999999 < arg_55_1.time_ and arg_55_1.time_ <= var_58_25 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_27 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_27:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_28 = arg_55_1:GetWordFromCfg(121531013)
				local var_58_29 = arg_55_1:FormatText(var_58_28.content)

				arg_55_1.text_.text = var_58_29

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_31 = 14 <= 0 and var_58_26 or var_58_26 * (utf8.len(var_58_29) / 14)

				if (14 <= 0 and var_58_26 or var_58_26 * (utf8.len(var_58_29) / 14)) > 0 and var_58_26 < var_58_31 then
					arg_55_1.talkMaxDuration = var_58_31
					var_58_25 = var_58_25 + 0.3

					if var_58_31 + var_58_25 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_31 + var_58_25
					end
				end

				arg_55_1.text_.text = var_58_29
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531013", "story_v_out_121531.awb") ~= 0 then
					local var_58_32 = manager.audio:GetVoiceLength("story_v_out_121531", "121531013", "story_v_out_121531.awb") / 1000

					if var_58_32 + var_58_25 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_32 + var_58_25
					end

					if var_58_28.prefab_name ~= "" and arg_55_1.actors_[var_58_28.prefab_name] ~= nil then
						local var_58_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_28.prefab_name].transform, "story_v_out_121531", "121531013", "story_v_out_121531.awb")

						arg_55_1:RecordAudio("121531013", var_58_33)
						arg_55_1:RecordAudio("121531013", var_58_33)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_121531", "121531013", "story_v_out_121531.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_121531", "121531013", "story_v_out_121531.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_34 = var_58_25 + 0.3
			local var_58_35 = math.max(var_58_26, arg_55_1.talkMaxDuration)

			if var_58_25 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_34 + var_58_35 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_34) / var_58_35

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_34 + var_58_35 and arg_55_1.time_ < var_58_34 + var_58_35 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play121531014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121531014
		arg_61_1.duration_ = 5.1

		local var_61_0 = {
			ja = 5.1,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_61_0:Play121531015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1074ui_story"]) and arg_61_1.var_.characterEffect1074ui_story == nil then
				arg_61_1.var_.characterEffect1074ui_story = arg_61_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1074ui_story"]) then
				if arg_61_1.var_.characterEffect1074ui_story and not isNil(arg_61_1.actors_["1074ui_story"]) then
					arg_61_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1074ui_story"]) and arg_61_1.var_.characterEffect1074ui_story then
				arg_61_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_2 = arg_61_1.actors_["1072ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1072ui_story == nil then
				arg_61_1.var_.characterEffect1072ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1072ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1072ui_story then
				arg_61_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_64_4 = 0
			local var_64_5 = 0.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(121531014)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 6 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 6)

				if (6 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 6)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531014", "story_v_out_121531.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531014", "story_v_out_121531.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_121531", "121531014", "story_v_out_121531.awb")

						arg_61_1:RecordAudio("121531014", var_64_11)
						arg_61_1:RecordAudio("121531014", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_121531", "121531014", "story_v_out_121531.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_121531", "121531014", "story_v_out_121531.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play121531015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121531015
		arg_65_1.duration_ = 6.37

		local var_65_0 = {
			ja = 6.366,
			ko = 4.833,
			zh = 4.833
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
				arg_65_0:Play121531016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1072ui_story"]) and arg_65_1.var_.characterEffect1072ui_story == nil then
				arg_65_1.var_.characterEffect1072ui_story = arg_65_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1072ui_story"]) then
				if arg_65_1.var_.characterEffect1072ui_story and not isNil(arg_65_1.actors_["1072ui_story"]) then
					arg_65_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1072ui_story"]) and arg_65_1.var_.characterEffect1072ui_story then
				arg_65_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_2 = arg_65_1.actors_["1074ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1074ui_story == nil then
				arg_65_1.var_.characterEffect1074ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1074ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1074ui_story then
				arg_65_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_68_4 = 0
			local var_68_5 = 0.675

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(121531015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 27 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 27)

				if (27 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 27)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531015", "story_v_out_121531.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531015", "story_v_out_121531.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_121531", "121531015", "story_v_out_121531.awb")

						arg_65_1:RecordAudio("121531015", var_68_11)
						arg_65_1:RecordAudio("121531015", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121531", "121531015", "story_v_out_121531.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121531", "121531015", "story_v_out_121531.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play121531016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121531016
		arg_69_1.duration_ = 5.43

		local var_69_0 = {
			ja = 3.6,
			ko = 5.433,
			zh = 5.433
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
				arg_69_0:Play121531017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1074ui_story"]) and arg_69_1.var_.characterEffect1074ui_story == nil then
				arg_69_1.var_.characterEffect1074ui_story = arg_69_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1074ui_story"]) then
				if arg_69_1.var_.characterEffect1074ui_story and not isNil(arg_69_1.actors_["1074ui_story"]) then
					arg_69_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1074ui_story"]) and arg_69_1.var_.characterEffect1074ui_story then
				arg_69_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_2 = arg_69_1.actors_["1072ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1072ui_story == nil then
				arg_69_1.var_.characterEffect1072ui_story = var_72_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_3 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.characterEffect1072ui_story and not isNil(var_72_2) then
					arg_69_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_3)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1072ui_story then
				arg_69_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_72_4 = 0
			local var_72_5 = 0.725

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(121531016)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 29 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 29)

				if (29 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 29)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531016", "story_v_out_121531.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531016", "story_v_out_121531.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_121531", "121531016", "story_v_out_121531.awb")

						arg_69_1:RecordAudio("121531016", var_72_11)
						arg_69_1:RecordAudio("121531016", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121531", "121531016", "story_v_out_121531.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121531", "121531016", "story_v_out_121531.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play121531017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121531017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play121531018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1074ui_story"]) and arg_73_1.var_.characterEffect1074ui_story == nil then
				arg_73_1.var_.characterEffect1074ui_story = arg_73_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1074ui_story"]) then
				if arg_73_1.var_.characterEffect1074ui_story and not isNil(arg_73_1.actors_["1074ui_story"]) then
					arg_73_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1074ui_story"]) and arg_73_1.var_.characterEffect1074ui_story then
				arg_73_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 1.95

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(121531017).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 78 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 78)

				if (78 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 78)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play121531018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121531018
		arg_77_1.duration_ = 11.13

		local var_77_0 = {
			ja = 11.133,
			ko = 7.5,
			zh = 7.5
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play121531019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1072ui_story"]) and arg_77_1.var_.characterEffect1072ui_story == nil then
				arg_77_1.var_.characterEffect1072ui_story = arg_77_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1072ui_story"]) then
				if arg_77_1.var_.characterEffect1072ui_story and not isNil(arg_77_1.actors_["1072ui_story"]) then
					arg_77_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1072ui_story"]) and arg_77_1.var_.characterEffect1072ui_story then
				arg_77_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_80_2 = 0
			local var_80_3 = 0.95

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(121531018)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 38 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 38)

				if (38 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 38)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531018", "story_v_out_121531.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_121531", "121531018", "story_v_out_121531.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_121531", "121531018", "story_v_out_121531.awb")

						arg_77_1:RecordAudio("121531018", var_80_9)
						arg_77_1:RecordAudio("121531018", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_121531", "121531018", "story_v_out_121531.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_121531", "121531018", "story_v_out_121531.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play121531019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 121531019
		arg_81_1.duration_ = 8.6

		local var_81_0 = {
			ja = 8.6,
			ko = 6.133,
			zh = 6.133
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play121531020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.9

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(121531019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 36 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 36)

				if (36 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 36)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531019", "story_v_out_121531.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_121531", "121531019", "story_v_out_121531.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_121531", "121531019", "story_v_out_121531.awb")

						arg_81_1:RecordAudio("121531019", var_84_6)
						arg_81_1:RecordAudio("121531019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_121531", "121531019", "story_v_out_121531.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_121531", "121531019", "story_v_out_121531.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play121531020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121531020
		arg_85_1.duration_ = 5.13

		local var_85_0 = {
			ja = 5.133,
			ko = 3.866,
			zh = 3.866
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
				arg_85_0:Play121531021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1074ui_story = arg_85_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).z)
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles = arg_85_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1074ui_story"].transform.position).z)
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1074ui_story"].transform.localEulerAngles = arg_85_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1072ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1072ui_story == nil then
				arg_85_1.var_.characterEffect1072ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1072ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_2)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1072ui_story then
				arg_85_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_88_3 = arg_85_1.actors_["10044ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10044ui_story = var_88_3.localPosition
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_3.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_85_1.time_ - 0) / var_88_4)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_3.localPosition = Vector3.New(0.7, -0.72, -6.3)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			local var_88_5 = arg_85_1.actors_["10044ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect10044ui_story == nil then
				arg_85_1.var_.characterEffect10044ui_story = var_88_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_6 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.characterEffect10044ui_story and not isNil(var_88_5) then
					arg_85_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect10044ui_story then
				arg_85_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_88_8 = 0
			local var_88_9 = 0.5

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(121531020)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 20 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 20)

				if (20 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 20)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531020", "story_v_out_121531.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_121531", "121531020", "story_v_out_121531.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_121531", "121531020", "story_v_out_121531.awb")

						arg_85_1:RecordAudio("121531020", var_88_15)
						arg_85_1:RecordAudio("121531020", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_121531", "121531020", "story_v_out_121531.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_121531", "121531020", "story_v_out_121531.awb")
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
				actorName = "10044ui_story",
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
	Play121531021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121531021
		arg_89_1.duration_ = 10.7

		local var_89_0 = {
			ja = 10.7,
			ko = 5.466,
			zh = 5.466
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play121531022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1072ui_story"]) and arg_89_1.var_.characterEffect1072ui_story == nil then
				arg_89_1.var_.characterEffect1072ui_story = arg_89_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1072ui_story"]) then
				if arg_89_1.var_.characterEffect1072ui_story and not isNil(arg_89_1.actors_["1072ui_story"]) then
					arg_89_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1072ui_story"]) and arg_89_1.var_.characterEffect1072ui_story then
				arg_89_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_2 = arg_89_1.actors_["10044ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect10044ui_story == nil then
				arg_89_1.var_.characterEffect10044ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect10044ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect10044ui_story then
				arg_89_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_92_4 = 0
			local var_92_5 = 0.625

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(121531021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 25 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 25)

				if (25 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 25)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531021", "story_v_out_121531.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531021", "story_v_out_121531.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_121531", "121531021", "story_v_out_121531.awb")

						arg_89_1:RecordAudio("121531021", var_92_11)
						arg_89_1:RecordAudio("121531021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_121531", "121531021", "story_v_out_121531.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_121531", "121531021", "story_v_out_121531.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play121531022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121531022
		arg_93_1.duration_ = 4.63

		local var_93_0 = {
			ja = 4.633,
			ko = 2.3,
			zh = 2.3
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
				arg_93_0:Play121531023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10044ui_story"]) and arg_93_1.var_.characterEffect10044ui_story == nil then
				arg_93_1.var_.characterEffect10044ui_story = arg_93_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10044ui_story"]) then
				if arg_93_1.var_.characterEffect10044ui_story and not isNil(arg_93_1.actors_["10044ui_story"]) then
					arg_93_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10044ui_story"]) and arg_93_1.var_.characterEffect10044ui_story then
				arg_93_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_96_2 = arg_93_1.actors_["1072ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1072ui_story == nil then
				arg_93_1.var_.characterEffect1072ui_story = var_96_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.characterEffect1072ui_story and not isNil(var_96_2) then
					arg_93_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_3)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1072ui_story then
				arg_93_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_96_4 = 0
			local var_96_5 = 0.3

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(121531022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 12 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 12)

				if (12 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 12)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531022", "story_v_out_121531.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531022", "story_v_out_121531.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_121531", "121531022", "story_v_out_121531.awb")

						arg_93_1:RecordAudio("121531022", var_96_11)
						arg_93_1:RecordAudio("121531022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_121531", "121531022", "story_v_out_121531.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_121531", "121531022", "story_v_out_121531.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play121531023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 121531023
		arg_97_1.duration_ = 8.67

		local var_97_0 = {
			ja = 8.666,
			ko = 6.966,
			zh = 6.966
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
				arg_97_0:Play121531024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1072ui_story = arg_97_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).z)
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles = arg_97_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1072ui_story"].transform.position).z)
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1072ui_story"].transform.localEulerAngles = arg_97_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1072ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1072ui_story == nil then
				arg_97_1.var_.characterEffect1072ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1072ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_2)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1072ui_story then
				arg_97_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_100_3 = arg_97_1.actors_["1074ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1074ui_story = var_100_3.localPosition
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_97_1.time_ - 0) / var_100_4)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			local var_100_5 = arg_97_1.actors_["1074ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect1074ui_story == nil then
				arg_97_1.var_.characterEffect1074ui_story = var_100_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.characterEffect1074ui_story and not isNil(var_100_5) then
					arg_97_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect1074ui_story then
				arg_97_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_100_8 = arg_97_1.actors_["10044ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.characterEffect10044ui_story == nil then
				arg_97_1.var_.characterEffect10044ui_story = var_100_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_9 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_9 and not isNil(var_100_8) then
				if arg_97_1.var_.characterEffect10044ui_story and not isNil(var_100_8) then
					arg_97_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_9)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_9 and arg_97_1.time_ < 0 + var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.characterEffect10044ui_story then
				arg_97_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_100_10 = 0
			local var_100_11 = 0.85

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_12 = arg_97_1:GetWordFromCfg(121531023)
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

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531023", "story_v_out_121531.awb") ~= 0 then
					local var_100_16 = manager.audio:GetVoiceLength("story_v_out_121531", "121531023", "story_v_out_121531.awb") / 1000

					if var_100_16 + var_100_10 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_16 + var_100_10
					end

					if var_100_12.prefab_name ~= "" and arg_97_1.actors_[var_100_12.prefab_name] ~= nil then
						local var_100_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_12.prefab_name].transform, "story_v_out_121531", "121531023", "story_v_out_121531.awb")

						arg_97_1:RecordAudio("121531023", var_100_17)
						arg_97_1:RecordAudio("121531023", var_100_17)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_121531", "121531023", "story_v_out_121531.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_121531", "121531023", "story_v_out_121531.awb")
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
				actorName = "1074ui_story",
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
	Play121531024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121531024
		arg_101_1.duration_ = 6.3

		local var_101_0 = {
			ja = 6.3,
			ko = 6,
			zh = 6
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
				arg_101_0:Play121531025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10044ui_story = arg_101_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10044ui_story"].transform.position).z)
				arg_101_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10044ui_story"].transform.localEulerAngles = arg_101_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0.7, -0.72, -6.3)
				arg_101_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10044ui_story"].transform.position).z)
				arg_101_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10044ui_story"].transform.localEulerAngles = arg_101_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["10044ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10044ui_story == nil then
				arg_101_1.var_.characterEffect10044ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect10044ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10044ui_story then
				arg_101_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action432")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_104_4 = arg_101_1.actors_["1074ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect1074ui_story == nil then
				arg_101_1.var_.characterEffect1074ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_5 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 and not isNil(var_104_4) then
				if arg_101_1.var_.characterEffect1074ui_story and not isNil(var_104_4) then
					arg_101_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_5)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect1074ui_story then
				arg_101_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_104_6 = 0
			local var_104_7 = 0.825

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(121531024)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 33 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 33)

				if (33 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 33)) > 0 and var_104_7 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531024", "story_v_out_121531.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_121531", "121531024", "story_v_out_121531.awb") / 1000

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_121531", "121531024", "story_v_out_121531.awb")

						arg_101_1:RecordAudio("121531024", var_104_13)
						arg_101_1:RecordAudio("121531024", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_121531", "121531024", "story_v_out_121531.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_121531", "121531024", "story_v_out_121531.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play121531025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121531025
		arg_105_1.duration_ = 7.5

		local var_105_0 = {
			ja = 7.066,
			ko = 7.5,
			zh = 7.5
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play121531026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1072ui_story = arg_105_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).z)
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles = arg_105_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_105_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1072ui_story"].transform.position).z)
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1072ui_story"].transform.localEulerAngles = arg_105_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1072ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1072ui_story == nil then
				arg_105_1.var_.characterEffect1072ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1072ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1072ui_story then
				arg_105_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_4 = arg_105_1.actors_["1074ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1074ui_story = var_108_4.localPosition
			end

			local var_108_5 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 then
				var_108_4.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_5)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 then
				var_108_4.localPosition = Vector3.New(0, 100, 0)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			local var_108_6 = arg_105_1.actors_["1074ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1074ui_story == nil then
				arg_105_1.var_.characterEffect1074ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_7 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 and not isNil(var_108_6) then
				if arg_105_1.var_.characterEffect1074ui_story and not isNil(var_108_6) then
					arg_105_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_7)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect1074ui_story then
				arg_105_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_108_8 = arg_105_1.actors_["10044ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.characterEffect10044ui_story == nil then
				arg_105_1.var_.characterEffect10044ui_story = var_108_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_9 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_9 and not isNil(var_108_8) then
				if arg_105_1.var_.characterEffect10044ui_story and not isNil(var_108_8) then
					arg_105_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_9)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_9 and arg_105_1.time_ < 0 + var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.characterEffect10044ui_story then
				arg_105_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_108_10 = 0
			local var_108_11 = 0.8

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_12 = arg_105_1:GetWordFromCfg(121531025)
				local var_108_13 = arg_105_1:FormatText(var_108_12.content)

				arg_105_1.text_.text = var_108_13

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_15 = 32 <= 0 and var_108_11 or var_108_11 * (utf8.len(var_108_13) / 32)

				if (32 <= 0 and var_108_11 or var_108_11 * (utf8.len(var_108_13) / 32)) > 0 and var_108_11 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15

					if var_108_15 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_10
					end
				end

				arg_105_1.text_.text = var_108_13
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531025", "story_v_out_121531.awb") ~= 0 then
					local var_108_16 = manager.audio:GetVoiceLength("story_v_out_121531", "121531025", "story_v_out_121531.awb") / 1000

					if var_108_16 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_10
					end

					if var_108_12.prefab_name ~= "" and arg_105_1.actors_[var_108_12.prefab_name] ~= nil then
						local var_108_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_12.prefab_name].transform, "story_v_out_121531", "121531025", "story_v_out_121531.awb")

						arg_105_1:RecordAudio("121531025", var_108_17)
						arg_105_1:RecordAudio("121531025", var_108_17)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_121531", "121531025", "story_v_out_121531.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_121531", "121531025", "story_v_out_121531.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_18 = math.max(var_108_11, arg_105_1.talkMaxDuration)

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_18 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_10) / var_108_18

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_10 + var_108_18 and arg_105_1.time_ < var_108_10 + var_108_18 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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
				actorName = "1074ui_story",
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
	Play121531026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 121531026
		arg_109_1.duration_ = 4.03

		local var_109_0 = {
			ja = 4.033,
			ko = 2.966,
			zh = 2.966
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
				arg_109_0:Play121531027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1072ui_story"]) and arg_109_1.var_.characterEffect1072ui_story == nil then
				arg_109_1.var_.characterEffect1072ui_story = arg_109_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1072ui_story"]) then
				if arg_109_1.var_.characterEffect1072ui_story and not isNil(arg_109_1.actors_["1072ui_story"]) then
					arg_109_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1072ui_story"]) and arg_109_1.var_.characterEffect1072ui_story then
				arg_109_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_112_1 = arg_109_1.actors_["10044ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10044ui_story == nil then
				arg_109_1.var_.characterEffect10044ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect10044ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10044ui_story then
				arg_109_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action2_2")
			end

			local var_112_4 = 0
			local var_112_5 = 0.2

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(121531026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 8 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 8)

				if (8 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 8)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531026", "story_v_out_121531.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531026", "story_v_out_121531.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_121531", "121531026", "story_v_out_121531.awb")

						arg_109_1:RecordAudio("121531026", var_112_11)
						arg_109_1:RecordAudio("121531026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_121531", "121531026", "story_v_out_121531.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_121531", "121531026", "story_v_out_121531.awb")
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

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play121531027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 121531027
		arg_113_1.duration_ = 10.87

		local var_113_0 = {
			ja = 10.866,
			ko = 7.4,
			zh = 7.4
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
				arg_113_0:Play121531028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1072ui_story"]) and arg_113_1.var_.characterEffect1072ui_story == nil then
				arg_113_1.var_.characterEffect1072ui_story = arg_113_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1072ui_story"]) then
				if arg_113_1.var_.characterEffect1072ui_story and not isNil(arg_113_1.actors_["1072ui_story"]) then
					arg_113_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1072ui_story"]) and arg_113_1.var_.characterEffect1072ui_story then
				arg_113_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_116_2 = arg_113_1.actors_["10044ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect10044ui_story == nil then
				arg_113_1.var_.characterEffect10044ui_story = var_116_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_3 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.characterEffect10044ui_story and not isNil(var_116_2) then
					arg_113_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_3)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect10044ui_story then
				arg_113_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_116_4 = 0
			local var_116_5 = 0.875

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(121531027)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 35 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 35)

				if (35 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 35)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531027", "story_v_out_121531.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531027", "story_v_out_121531.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_121531", "121531027", "story_v_out_121531.awb")

						arg_113_1:RecordAudio("121531027", var_116_11)
						arg_113_1:RecordAudio("121531027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_121531", "121531027", "story_v_out_121531.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_121531", "121531027", "story_v_out_121531.awb")
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

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play121531028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 121531028
		arg_117_1.duration_ = 9.63

		local var_117_0 = {
			ja = 9.633,
			ko = 6.666,
			zh = 6.666
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
				arg_117_0:Play121531029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10044ui_story = arg_117_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10044ui_story"].transform.position).z)
				arg_117_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10044ui_story"].transform.localEulerAngles = arg_117_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10044ui_story"].transform.position).z)
				arg_117_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10044ui_story"].transform.localEulerAngles = arg_117_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["10044ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10044ui_story == nil then
				arg_117_1.var_.characterEffect10044ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect10044ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_2)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10044ui_story then
				arg_117_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_120_3 = arg_117_1.actors_["1074ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1074ui_story = var_120_3.localPosition
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_3.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_117_1.time_ - 0) / var_120_4)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_3.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			local var_120_5 = arg_117_1.actors_["1074ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1074ui_story == nil then
				arg_117_1.var_.characterEffect1074ui_story = var_120_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_6 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.characterEffect1074ui_story and not isNil(var_120_5) then
					arg_117_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1074ui_story then
				arg_117_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_8 = arg_117_1.actors_["1072ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.characterEffect1072ui_story == nil then
				arg_117_1.var_.characterEffect1072ui_story = var_120_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_9 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_9 and not isNil(var_120_8) then
				if arg_117_1.var_.characterEffect1072ui_story and not isNil(var_120_8) then
					arg_117_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_9)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_9 and arg_117_1.time_ < 0 + var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.characterEffect1072ui_story then
				arg_117_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_120_10 = 0
			local var_120_11 = 0.925

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_12 = arg_117_1:GetWordFromCfg(121531028)
				local var_120_13 = arg_117_1:FormatText(var_120_12.content)

				arg_117_1.text_.text = var_120_13

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_15 = 37 <= 0 and var_120_11 or var_120_11 * (utf8.len(var_120_13) / 37)

				if (37 <= 0 and var_120_11 or var_120_11 * (utf8.len(var_120_13) / 37)) > 0 and var_120_11 < var_120_15 then
					arg_117_1.talkMaxDuration = var_120_15

					if var_120_15 + var_120_10 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_15 + var_120_10
					end
				end

				arg_117_1.text_.text = var_120_13
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531028", "story_v_out_121531.awb") ~= 0 then
					local var_120_16 = manager.audio:GetVoiceLength("story_v_out_121531", "121531028", "story_v_out_121531.awb") / 1000

					if var_120_16 + var_120_10 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_16 + var_120_10
					end

					if var_120_12.prefab_name ~= "" and arg_117_1.actors_[var_120_12.prefab_name] ~= nil then
						local var_120_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_12.prefab_name].transform, "story_v_out_121531", "121531028", "story_v_out_121531.awb")

						arg_117_1:RecordAudio("121531028", var_120_17)
						arg_117_1:RecordAudio("121531028", var_120_17)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_121531", "121531028", "story_v_out_121531.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_121531", "121531028", "story_v_out_121531.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_18 = math.max(var_120_11, arg_117_1.talkMaxDuration)

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_18 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_10) / var_120_18

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_10 + var_120_18 and arg_117_1.time_ < var_120_10 + var_120_18 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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

		arg_117_1:InitPlayNodeList()
	end,
	Play121531029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 121531029
		arg_121_1.duration_ = 3

		local var_121_0 = {
			ja = 3,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_121_0:Play121531030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1074ui_story = arg_121_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1074ui_story"].transform.position).z)
				arg_121_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1074ui_story"].transform.localEulerAngles = arg_121_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1074ui_story"].transform.position).z)
				arg_121_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1074ui_story"].transform.localEulerAngles = arg_121_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1074ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1074ui_story == nil then
				arg_121_1.var_.characterEffect1074ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1074ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1074ui_story then
				arg_121_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_124_3 = arg_121_1.actors_["1072ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1072ui_story = var_124_3.localPosition
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_4)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(0, 100, 0)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			local var_124_5 = arg_121_1.actors_["1072ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect1072ui_story == nil then
				arg_121_1.var_.characterEffect1072ui_story = var_124_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.characterEffect1072ui_story and not isNil(var_124_5) then
					arg_121_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_6)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect1072ui_story then
				arg_121_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_124_7 = arg_121_1.actors_["10044ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10044ui_story = var_124_7.localPosition
			end

			local var_124_8 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_8 then
				var_124_7.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10044ui_story, Vector3.New(0, -0.72, -6.3), (arg_121_1.time_ - 0) / var_124_8)
				var_124_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_7.position).x, (manager.ui.mainCamera.transform.position - var_124_7.position).y, (manager.ui.mainCamera.transform.position - var_124_7.position).z)
				var_124_7.localEulerAngles.z = 0
				var_124_7.localEulerAngles.x = 0
				var_124_7.localEulerAngles = var_124_7.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_8 and arg_121_1.time_ < 0 + var_124_8 + arg_124_0 then
				var_124_7.localPosition = Vector3.New(0, -0.72, -6.3)
				var_124_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_7.position).x, (manager.ui.mainCamera.transform.position - var_124_7.position).y, (manager.ui.mainCamera.transform.position - var_124_7.position).z)
				var_124_7.localEulerAngles.z = 0
				var_124_7.localEulerAngles.x = 0
				var_124_7.localEulerAngles = var_124_7.localEulerAngles
			end

			local var_124_9 = arg_121_1.actors_["10044ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10044ui_story == nil then
				arg_121_1.var_.characterEffect10044ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_10 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_10 and not isNil(var_124_9) then
				if arg_121_1.var_.characterEffect10044ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_10 and arg_121_1.time_ < 0 + var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10044ui_story then
				arg_121_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_124_12 = 0
			local var_124_13 = 0.2

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_14 = arg_121_1:GetWordFromCfg(121531029)
				local var_124_15 = arg_121_1:FormatText(var_124_14.content)

				arg_121_1.text_.text = var_124_15

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_17 = 8 <= 0 and var_124_13 or var_124_13 * (utf8.len(var_124_15) / 8)

				if (8 <= 0 and var_124_13 or var_124_13 * (utf8.len(var_124_15) / 8)) > 0 and var_124_13 < var_124_17 then
					arg_121_1.talkMaxDuration = var_124_17

					if var_124_17 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_12
					end
				end

				arg_121_1.text_.text = var_124_15
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531029", "story_v_out_121531.awb") ~= 0 then
					local var_124_18 = manager.audio:GetVoiceLength("story_v_out_121531", "121531029", "story_v_out_121531.awb") / 1000

					if var_124_18 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_18 + var_124_12
					end

					if var_124_14.prefab_name ~= "" and arg_121_1.actors_[var_124_14.prefab_name] ~= nil then
						local var_124_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_14.prefab_name].transform, "story_v_out_121531", "121531029", "story_v_out_121531.awb")

						arg_121_1:RecordAudio("121531029", var_124_19)
						arg_121_1:RecordAudio("121531029", var_124_19)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_121531", "121531029", "story_v_out_121531.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_121531", "121531029", "story_v_out_121531.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_20 = math.max(var_124_13, arg_121_1.talkMaxDuration)

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_20 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_12) / var_124_20

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_12 + var_124_20 and arg_121_1.time_ < var_124_12 + var_124_20 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
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
	Play121531030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 121531030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play121531031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10044ui_story"]) and arg_125_1.var_.characterEffect10044ui_story == nil then
				arg_125_1.var_.characterEffect10044ui_story = arg_125_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10044ui_story"]) then
				if arg_125_1.var_.characterEffect10044ui_story and not isNil(arg_125_1.actors_["10044ui_story"]) then
					arg_125_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10044ui_story"]) and arg_125_1.var_.characterEffect10044ui_story then
				arg_125_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 0.875

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(121531030).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 35 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 35)

				if (35 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 35)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play121531031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 121531031
		arg_129_1.duration_ = 6.43

		local var_129_0 = {
			ja = 6.433,
			ko = 5.933,
			zh = 5.933
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
				arg_129_0:Play121531032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10044ui_story"]) and arg_129_1.var_.characterEffect10044ui_story == nil then
				arg_129_1.var_.characterEffect10044ui_story = arg_129_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10044ui_story"]) then
				if arg_129_1.var_.characterEffect10044ui_story and not isNil(arg_129_1.actors_["10044ui_story"]) then
					arg_129_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10044ui_story"]) and arg_129_1.var_.characterEffect10044ui_story then
				arg_129_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_132_2 = 0
			local var_132_3 = 0.525

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(121531031)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 21 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 21)

				if (21 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 21)) > 0 and var_132_3 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531031", "story_v_out_121531.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_121531", "121531031", "story_v_out_121531.awb") / 1000

					if var_132_8 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_2
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_out_121531", "121531031", "story_v_out_121531.awb")

						arg_129_1:RecordAudio("121531031", var_132_9)
						arg_129_1:RecordAudio("121531031", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_121531", "121531031", "story_v_out_121531.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_121531", "121531031", "story_v_out_121531.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_10 and arg_129_1.time_ < var_132_2 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play121531032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 121531032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play121531033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10044ui_story = arg_133_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10044ui_story"].transform.position).z)
				arg_133_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10044ui_story"].transform.localEulerAngles = arg_133_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10044ui_story"].transform.position).z)
				arg_133_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10044ui_story"].transform.localEulerAngles = arg_133_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["10044ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10044ui_story == nil then
				arg_133_1.var_.characterEffect10044ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect10044ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_2)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10044ui_story then
				arg_133_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_136_3 = 0
			local var_136_4 = 0.35

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_5 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(121531032).content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 14 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 14)

				if (14 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 14)) > 0 and var_136_4 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_3) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_3 + var_136_8 and arg_133_1.time_ < var_136_3 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play121531033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 121531033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play121531034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1

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

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(121531033).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 40 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 40)

				if (40 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 40)) > 0 and var_140_0 < var_140_3 then
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
	Play121531034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 121531034
		arg_141_1.duration_ = 15.27

		local var_141_0 = {
			ja = 12,
			ko = 15.266,
			zh = 15.266
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
				arg_141_0:Play121531035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1072ui_story = arg_141_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1072ui_story"].transform.position).z)
				arg_141_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1072ui_story"].transform.localEulerAngles = arg_141_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_141_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1072ui_story"].transform.position).z)
				arg_141_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1072ui_story"].transform.localEulerAngles = arg_141_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1072ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1072ui_story == nil then
				arg_141_1.var_.characterEffect1072ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1072ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1072ui_story then
				arg_141_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_4 = 0
			local var_144_5 = 1.375

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(121531034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 55 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 55)

				if (55 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 55)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531034", "story_v_out_121531.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_121531", "121531034", "story_v_out_121531.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_121531", "121531034", "story_v_out_121531.awb")

						arg_141_1:RecordAudio("121531034", var_144_11)
						arg_141_1:RecordAudio("121531034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_121531", "121531034", "story_v_out_121531.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_121531", "121531034", "story_v_out_121531.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play121531035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 121531035
		arg_145_1.duration_ = 14.47

		local var_145_0 = {
			ja = 14.466,
			ko = 10.733,
			zh = 10.733
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
				arg_145_0:Play121531036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.2

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(121531035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 48 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 48)

				if (48 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 48)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531035", "story_v_out_121531.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_121531", "121531035", "story_v_out_121531.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_121531", "121531035", "story_v_out_121531.awb")

						arg_145_1:RecordAudio("121531035", var_148_6)
						arg_145_1:RecordAudio("121531035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_121531", "121531035", "story_v_out_121531.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_121531", "121531035", "story_v_out_121531.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play121531036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 121531036
		arg_149_1.duration_ = 14.23

		local var_149_0 = {
			ja = 14.233,
			ko = 12.5,
			zh = 12.5
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
				arg_149_0:Play121531037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_0 = 0
			local var_152_1 = 1.575

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(121531036)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 65 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 65)

				if (65 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 65)) > 0 and var_152_1 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531036", "story_v_out_121531.awb") ~= 0 then
					local var_152_6 = manager.audio:GetVoiceLength("story_v_out_121531", "121531036", "story_v_out_121531.awb") / 1000

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end

					if var_152_2.prefab_name ~= "" and arg_149_1.actors_[var_152_2.prefab_name] ~= nil then
						local var_152_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_2.prefab_name].transform, "story_v_out_121531", "121531036", "story_v_out_121531.awb")

						arg_149_1:RecordAudio("121531036", var_152_7)
						arg_149_1:RecordAudio("121531036", var_152_7)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_121531", "121531036", "story_v_out_121531.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_121531", "121531036", "story_v_out_121531.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play121531037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 121531037
		arg_153_1.duration_ = 9.07

		local var_153_0 = {
			ja = 9.066,
			ko = 9,
			zh = 9
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
				arg_153_0:Play121531038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.125

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(121531037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 45 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 45)

				if (45 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 45)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531037", "story_v_out_121531.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_121531", "121531037", "story_v_out_121531.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_121531", "121531037", "story_v_out_121531.awb")

						arg_153_1:RecordAudio("121531037", var_156_6)
						arg_153_1:RecordAudio("121531037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_121531", "121531037", "story_v_out_121531.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_121531", "121531037", "story_v_out_121531.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play121531038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 121531038
		arg_157_1.duration_ = 8.13

		local var_157_0 = {
			ja = 8.133,
			ko = 6.5,
			zh = 6.5
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
				arg_157_0:Play121531039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action452")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_0 = 0
			local var_160_1 = 0.675

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(121531038)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 27 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 27)

				if (27 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 27)) > 0 and var_160_1 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121531", "121531038", "story_v_out_121531.awb") ~= 0 then
					local var_160_6 = manager.audio:GetVoiceLength("story_v_out_121531", "121531038", "story_v_out_121531.awb") / 1000

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end

					if var_160_2.prefab_name ~= "" and arg_157_1.actors_[var_160_2.prefab_name] ~= nil then
						local var_160_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_2.prefab_name].transform, "story_v_out_121531", "121531038", "story_v_out_121531.awb")

						arg_157_1:RecordAudio("121531038", var_160_7)
						arg_157_1:RecordAudio("121531038", var_160_7)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_121531", "121531038", "story_v_out_121531.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_121531", "121531038", "story_v_out_121531.awb")
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
	Play121531039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 121531039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play121531040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1072ui_story = arg_161_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1072ui_story"].transform.position).z)
				arg_161_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1072ui_story"].transform.localEulerAngles = arg_161_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1072ui_story"].transform.position).z)
				arg_161_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1072ui_story"].transform.localEulerAngles = arg_161_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1072ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1072ui_story == nil then
				arg_161_1.var_.characterEffect1072ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1072ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_2)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1072ui_story then
				arg_161_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_164_3 = 0
			local var_164_4 = 1.325

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(121531039).content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 53 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 53)

				if (53 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 53)) > 0 and var_164_4 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_3
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_4, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_3) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_8 and arg_161_1.time_ < var_164_3 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play121531040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 121531040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
			arg_165_1.auto_ = false
		end

		function arg_165_1.playNext_(arg_167_0)
			arg_165_1.onStoryFinished_()
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.05

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(121531040).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 42 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 42)

				if (42 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 42)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST37a",
		"TextureConfig/Background/ST29a"
	},
	voices = {
		"story_v_out_121531.awb"
	}
}
