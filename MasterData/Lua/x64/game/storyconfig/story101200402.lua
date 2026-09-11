return {
	Play120042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120042001
		arg_1_1.duration_ = 4.63

		local var_1_0 = {
			zh = 4.633,
			ja = 4.533
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
				arg_1_0:Play120042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J02i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J02i")
				var_4_0.name = "J02i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J02i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J02i

				arg_1_1.bgs_.J02i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J02i" then
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

			local var_4_8 = "1069ui_story"

			if arg_1_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1069ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1069ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1069ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1069ui_story == nil then
				arg_1_1.var_.characterEffect1069ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1069ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1069ui_story then
				arg_1_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			local var_4_23 = 2
			local var_4_24 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(120042001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 11 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 11)

				if (11 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 11)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042001", "story_v_out_120042.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_120042", "120042001", "story_v_out_120042.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_120042", "120042001", "story_v_out_120042.awb")

						arg_1_1:RecordAudio("120042001", var_4_31)
						arg_1_1:RecordAudio("120042001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_120042", "120042001", "story_v_out_120042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_120042", "120042001", "story_v_out_120042.awb")
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

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play120042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120042002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play120042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1069ui_story"]) and arg_9_1.var_.characterEffect1069ui_story == nil then
				arg_9_1.var_.characterEffect1069ui_story = arg_9_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1069ui_story"]) then
				if arg_9_1.var_.characterEffect1069ui_story and not isNil(arg_9_1.actors_["1069ui_story"]) then
					arg_9_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1069ui_story"]) and arg_9_1.var_.characterEffect1069ui_story then
				arg_9_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.25

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(120042002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 10 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 10)

				if (10 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 10)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play120042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120042003
		arg_13_1.duration_ = 7

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play120042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1069ui_story = arg_13_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1069ui_story"].transform.position).z)
				arg_13_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1069ui_story"].transform.localEulerAngles = arg_13_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1069ui_story"].transform.position).z)
				arg_13_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1069ui_story"].transform.localEulerAngles = arg_13_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if 0.034 < arg_13_1.time_ and arg_13_1.time_ <= 0.034 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_16", "se_story_16_metal", "")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_15", "se_story_15_blast03", "")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_side_1066", "se_story_1066_Metal", "")
			end

			local var_16_4 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_5 = 2

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_5 then
				local var_16_6 = Color.New(1, 1, 1)

				var_16_6.a = Mathf.Lerp(1, 0, (arg_13_1.time_ - var_16_4) / var_16_5)
				arg_13_1.mask_.color = var_16_6
			end

			if arg_13_1.time_ >= var_16_4 + var_16_5 and arg_13_1.time_ < var_16_4 + var_16_5 + arg_16_0 then
				local var_16_7 = Color.New(1, 1, 1)

				arg_13_1.mask_.enabled = false
				var_16_7.a = 0
				arg_13_1.mask_.color = var_16_7
			end

			local var_16_8 = manager.ui.mainCamera.transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = var_16_8.localPosition
			end

			local var_16_9 = 1

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				local var_16_10, var_16_11 = math.modf((arg_13_1.time_ - 0) / 0.066)

				var_16_8.localPosition = Vector3.New(var_16_11 * 0.13, var_16_11 * 0.13, var_16_11 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_12 = 2
			local var_16_13 = 1.25

			if 2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(120042003).content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 50 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_14) / 50)

				if (50 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_14) / 50)) > 0 and var_16_13 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_17 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_17 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_17

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_17 and arg_13_1.time_ < var_16_12 + var_16_17 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play120042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120042004
		arg_17_1.duration_ = 2.97

		local var_17_0 = {
			zh = 2.466,
			ja = 2.966
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
				arg_17_0:Play120042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1069ui_story = arg_17_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1069ui_story"].transform.position).z)
				arg_17_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1069ui_story"].transform.localEulerAngles = arg_17_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_17_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1069ui_story"].transform.position).z)
				arg_17_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1069ui_story"].transform.localEulerAngles = arg_17_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1069ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1069ui_story == nil then
				arg_17_1.var_.characterEffect1069ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1069ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1069ui_story then
				arg_17_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action5_1")
			end

			local var_20_4 = 0
			local var_20_5 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(120042004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)

				if (10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042004", "story_v_out_120042.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042004", "story_v_out_120042.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_120042", "120042004", "story_v_out_120042.awb")

						arg_17_1:RecordAudio("120042004", var_20_11)
						arg_17_1:RecordAudio("120042004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_120042", "120042004", "story_v_out_120042.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_120042", "120042004", "story_v_out_120042.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play120042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120042005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play120042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1069ui_story"]) and arg_21_1.var_.characterEffect1069ui_story == nil then
				arg_21_1.var_.characterEffect1069ui_story = arg_21_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1069ui_story"]) then
				if arg_21_1.var_.characterEffect1069ui_story and not isNil(arg_21_1.actors_["1069ui_story"]) then
					arg_21_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1069ui_story"]) and arg_21_1.var_.characterEffect1069ui_story then
				arg_21_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
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

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(120042005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 18 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 18)

				if (18 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 18)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play120042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120042006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play120042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1069ui_story = arg_25_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1069ui_story"].transform.position).z)
				arg_25_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1069ui_story"].transform.localEulerAngles = arg_25_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1069ui_story"].transform.position).z)
				arg_25_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1069ui_story"].transform.localEulerAngles = arg_25_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_28_1 = 0
			local var_28_2 = 0.625

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(120042006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 25 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 25)

				if (25 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 25)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play120042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120042007
		arg_29_1.duration_ = 11.5

		local var_29_0 = {
			zh = 8.733,
			ja = 11.5
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
				arg_29_0:Play120042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1184ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1184ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1184ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1184ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1184ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1184ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["1184ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1184ui_story == nil then
				arg_29_1.var_.characterEffect1184ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect1184ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1184ui_story then
				arg_29_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_32_8 = 0
			local var_32_9 = 0.825

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(120042007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 33 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 33)

				if (33 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 33)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042007", "story_v_out_120042.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_120042", "120042007", "story_v_out_120042.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_120042", "120042007", "story_v_out_120042.awb")

						arg_29_1:RecordAudio("120042007", var_32_15)
						arg_29_1:RecordAudio("120042007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_120042", "120042007", "story_v_out_120042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_120042", "120042007", "story_v_out_120042.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play120042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120042008
		arg_33_1.duration_ = 5.67

		local var_33_0 = {
			zh = 2.7,
			ja = 5.666
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
				arg_33_0:Play120042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1069ui_story = arg_33_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1069ui_story"].transform.position).z)
				arg_33_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1069ui_story"].transform.localEulerAngles = arg_33_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6)
				arg_33_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1069ui_story"].transform.position).z)
				arg_33_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1069ui_story"].transform.localEulerAngles = arg_33_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1069ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1069ui_story == nil then
				arg_33_1.var_.characterEffect1069ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1069ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1069ui_story then
				arg_33_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["1184ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1184ui_story == nil then
				arg_33_1.var_.characterEffect1184ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect1184ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1184ui_story then
				arg_33_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_36_6 = 0
			local var_36_7 = 0.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(120042008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 13 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 13)

				if (13 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 13)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042008", "story_v_out_120042.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_120042", "120042008", "story_v_out_120042.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_120042", "120042008", "story_v_out_120042.awb")

						arg_33_1:RecordAudio("120042008", var_36_13)
						arg_33_1:RecordAudio("120042008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_120042", "120042008", "story_v_out_120042.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_120042", "120042008", "story_v_out_120042.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play120042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120042009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play120042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1069ui_story"]) and arg_37_1.var_.characterEffect1069ui_story == nil then
				arg_37_1.var_.characterEffect1069ui_story = arg_37_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1069ui_story"]) then
				if arg_37_1.var_.characterEffect1069ui_story and not isNil(arg_37_1.actors_["1069ui_story"]) then
					arg_37_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1069ui_story"]) and arg_37_1.var_.characterEffect1069ui_story then
				arg_37_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.575

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

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(120042009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 23 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 23)

				if (23 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 23)) > 0 and var_40_2 < var_40_5 then
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
	Play120042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120042010
		arg_41_1.duration_ = 2.3

		local var_41_0 = {
			zh = 0.999999999999,
			ja = 2.3
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
				arg_41_0:Play120042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1069ui_story = arg_41_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1069ui_story"].transform.position).z)
				arg_41_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1069ui_story"].transform.localEulerAngles = arg_41_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6)
				arg_41_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1069ui_story"].transform.position).z)
				arg_41_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1069ui_story"].transform.localEulerAngles = arg_41_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1069ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1069ui_story == nil then
				arg_41_1.var_.characterEffect1069ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1069ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1069ui_story then
				arg_41_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_44_4 = 0
			local var_44_5 = 0.075

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(120042010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 3 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 3)

				if (3 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 3)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042010", "story_v_out_120042.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042010", "story_v_out_120042.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_120042", "120042010", "story_v_out_120042.awb")

						arg_41_1:RecordAudio("120042010", var_44_11)
						arg_41_1:RecordAudio("120042010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_120042", "120042010", "story_v_out_120042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_120042", "120042010", "story_v_out_120042.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play120042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120042011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play120042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1069ui_story"]) and arg_45_1.var_.characterEffect1069ui_story == nil then
				arg_45_1.var_.characterEffect1069ui_story = arg_45_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1069ui_story"]) then
				if arg_45_1.var_.characterEffect1069ui_story and not isNil(arg_45_1.actors_["1069ui_story"]) then
					arg_45_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1069ui_story"]) and arg_45_1.var_.characterEffect1069ui_story then
				arg_45_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.425

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(120042011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 17 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 17)

				if (17 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 17)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play120042012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120042012
		arg_49_1.duration_ = 2.9

		local var_49_0 = {
			zh = 1.3,
			ja = 2.9
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
				arg_49_0:Play120042013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1069ui_story"]) and arg_49_1.var_.characterEffect1069ui_story == nil then
				arg_49_1.var_.characterEffect1069ui_story = arg_49_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1069ui_story"]) then
				if arg_49_1.var_.characterEffect1069ui_story and not isNil(arg_49_1.actors_["1069ui_story"]) then
					arg_49_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1069ui_story"]) and arg_49_1.var_.characterEffect1069ui_story then
				arg_49_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_52_2 = 0
			local var_52_3 = 0.15

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(120042012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 6 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 6)

				if (6 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 6)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042012", "story_v_out_120042.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_120042", "120042012", "story_v_out_120042.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_120042", "120042012", "story_v_out_120042.awb")

						arg_49_1:RecordAudio("120042012", var_52_9)
						arg_49_1:RecordAudio("120042012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_120042", "120042012", "story_v_out_120042.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_120042", "120042012", "story_v_out_120042.awb")
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
	Play120042013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 120042013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play120042014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1184ui_story = arg_53_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).z)
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles = arg_53_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1184ui_story"].transform.position).z)
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1184ui_story"].transform.localEulerAngles = arg_53_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1069ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1069ui_story = var_56_1.localPosition
			end

			local var_56_2 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 then
				var_56_1.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_2)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 then
				var_56_1.localPosition = Vector3.New(0, 100, 0)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			local var_56_3 = 0
			local var_56_4 = 1.15

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_5 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(120042013).content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 46 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 46)

				if (46 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 46)) > 0 and var_56_4 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_3
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_4, arg_53_1.talkMaxDuration)

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_3) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_3 + var_56_8 and arg_53_1.time_ < var_56_3 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play120042014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120042014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play120042015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.4

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

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(120042014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 56 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 56)

				if (56 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 56)) > 0 and var_60_0 < var_60_3 then
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
	Play120042015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120042015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play120042016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1184ui_story = arg_61_1.actors_["1184ui_story"].transform.localPosition

				arg_61_1:ShowWeapon(arg_61_1.var_["1184ui_story" .. "Animator"].transform, true)
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1184ui_story"].transform.position).z)
				arg_61_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1184ui_story"].transform.localEulerAngles = arg_61_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_61_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1184ui_story"].transform.position).z)
				arg_61_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1184ui_story"].transform.localEulerAngles = arg_61_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1184ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1184ui_story == nil then
				arg_61_1.var_.characterEffect1184ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1184ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1184ui_story then
				arg_61_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_64_4 = 0
			local var_64_5 = 0.125

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(120042015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 5 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 5)

				if (5 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 5)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042015", "story_v_out_120042.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042015", "story_v_out_120042.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_120042", "120042015", "story_v_out_120042.awb")

						arg_61_1:RecordAudio("120042015", var_64_11)
						arg_61_1:RecordAudio("120042015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_120042", "120042015", "story_v_out_120042.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_120042", "120042015", "story_v_out_120042.awb")
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

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play120042016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120042016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play120042017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1184ui_story = arg_65_1.actors_["1184ui_story"].transform.localPosition

				arg_65_1:ShowWeapon(arg_65_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1184ui_story"].transform.position).z)
				arg_65_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1184ui_story"].transform.localEulerAngles = arg_65_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1184ui_story"].transform.position).z)
				arg_65_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1184ui_story"].transform.localEulerAngles = arg_65_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_68_1 = 0
			local var_68_2 = 0.4

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(120042016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 16 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 16)

				if (16 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 16)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play120042017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120042017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play120042018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.8

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

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(120042017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 32 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 32)

				if (32 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 32)) > 0 and var_72_0 < var_72_3 then
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
	Play120042018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120042018
		arg_73_1.duration_ = 6.87

		local var_73_0 = {
			zh = 6.433,
			ja = 6.866
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
				arg_73_0:Play120042019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.bgs_.XH0104a == nil then
				local var_76_0 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0104a")
				var_76_0.name = "XH0104a"
				var_76_0.transform.parent = arg_73_1.stage_.transform
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_.XH0104a = var_76_0
			end

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				local var_76_1 = arg_73_1.bgs_.XH0104a

				arg_73_1.bgs_.XH0104a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_76_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_2 = var_76_1:GetComponent("SpriteRenderer")

				if var_76_2 and var_76_2.sprite then
					local var_76_3 = 2 * (var_76_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_76_1.transform.localScale = Vector3.New(var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "XH0104a" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_4 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_5 = 2

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_5 then
				local var_76_6 = Color.New(0, 0, 0)

				var_76_6.a = Mathf.Lerp(0, 1, (arg_73_1.time_ - var_76_4) / var_76_5)
				arg_73_1.mask_.color = var_76_6
			end

			if arg_73_1.time_ >= var_76_4 + var_76_5 and arg_73_1.time_ < var_76_4 + var_76_5 + arg_76_0 then
				local var_76_7 = Color.New(0, 0, 0)

				var_76_7.a = 1
				arg_73_1.mask_.color = var_76_7
			end

			local var_76_8 = 2

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_9 = 2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 then
				local var_76_10 = Color.New(0, 0, 0)

				var_76_10.a = Mathf.Lerp(1, 0, (arg_73_1.time_ - var_76_8) / var_76_9)
				arg_73_1.mask_.color = var_76_10
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 then
				local var_76_11 = Color.New(0, 0, 0)

				arg_73_1.mask_.enabled = false
				var_76_11.a = 0
				arg_73_1.mask_.color = var_76_11
			end

			local var_76_12 = arg_73_1.bgs_.XH0104a.transform

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				arg_73_1.var_.moveOldPosXH0104a = var_76_12.localPosition
			end

			local var_76_13 = 0.001

			if 2 <= arg_73_1.time_ and arg_73_1.time_ < 2 + var_76_13 then
				var_76_12.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPosXH0104a, Vector3.New(0, 1, 9.5), (arg_73_1.time_ - 2) / var_76_13)
			end

			if arg_73_1.time_ >= 2 + var_76_13 and arg_73_1.time_ < 2 + var_76_13 + arg_76_0 then
				var_76_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_76_14 = arg_73_1.bgs_.XH0104a.transform

			if 2.01666666666667 < arg_73_1.time_ and arg_73_1.time_ <= 2.01666666666667 + arg_76_0 then
				arg_73_1.var_.moveOldPosXH0104a = var_76_14.localPosition
			end

			local var_76_15 = 3.5

			if 2.01666666666667 <= arg_73_1.time_ and arg_73_1.time_ < 2.01666666666667 + var_76_15 then
				var_76_14.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPosXH0104a, Vector3.New(0, 1, 10), (arg_73_1.time_ - 2.01666666666667) / var_76_15)
			end

			if arg_73_1.time_ >= 2.01666666666667 + var_76_15 and arg_73_1.time_ < 2.01666666666667 + var_76_15 + arg_76_0 then
				var_76_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_76_16 = 4

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			if arg_73_1.time_ >= var_76_16 + 1.5 and arg_73_1.time_ < var_76_16 + 1.5 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_17 = 4
			local var_76_18 = 0.2

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_17 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_19 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_19:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_20 = arg_73_1:GetWordFromCfg(120042018)
				local var_76_21 = arg_73_1:FormatText(var_76_20.content)

				arg_73_1.text_.text = var_76_21

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_23 = 8 <= 0 and var_76_18 or var_76_18 * (utf8.len(var_76_21) / 8)

				if (8 <= 0 and var_76_18 or var_76_18 * (utf8.len(var_76_21) / 8)) > 0 and var_76_18 < var_76_23 then
					arg_73_1.talkMaxDuration = var_76_23
					var_76_17 = var_76_17 + 0.3

					if var_76_23 + var_76_17 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_17
					end
				end

				arg_73_1.text_.text = var_76_21
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042018", "story_v_out_120042.awb") ~= 0 then
					local var_76_24 = manager.audio:GetVoiceLength("story_v_out_120042", "120042018", "story_v_out_120042.awb") / 1000

					if var_76_24 + var_76_17 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_24 + var_76_17
					end

					if var_76_20.prefab_name ~= "" and arg_73_1.actors_[var_76_20.prefab_name] ~= nil then
						local var_76_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_20.prefab_name].transform, "story_v_out_120042", "120042018", "story_v_out_120042.awb")

						arg_73_1:RecordAudio("120042018", var_76_25)
						arg_73_1:RecordAudio("120042018", var_76_25)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_120042", "120042018", "story_v_out_120042.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_120042", "120042018", "story_v_out_120042.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_26 = var_76_17 + 0.3
			local var_76_27 = math.max(var_76_18, arg_73_1.talkMaxDuration)

			if var_76_17 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_26 + var_76_27 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_26) / var_76_27

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_26 + var_76_27 and arg_73_1.time_ < var_76_26 + var_76_27 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0104a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0104a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play120042019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 120042019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play120042020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.575

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

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(120042019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 23 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 23)

				if (23 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 23)) > 0 and var_82_0 < var_82_3 then
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
	Play120042020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 120042020
		arg_83_1.duration_ = 7.73

		local var_83_0 = {
			zh = 7.733,
			ja = 6.9
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
				arg_83_0:Play120042021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.9

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(120042020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 36 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 36)

				if (36 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 36)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042020", "story_v_out_120042.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042020", "story_v_out_120042.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_120042", "120042020", "story_v_out_120042.awb")

						arg_83_1:RecordAudio("120042020", var_86_6)
						arg_83_1:RecordAudio("120042020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_120042", "120042020", "story_v_out_120042.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_120042", "120042020", "story_v_out_120042.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play120042021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 120042021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play120042022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.975

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(120042021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 39 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 39)

				if (39 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 39)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play120042022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 120042022
		arg_91_1.duration_ = 5.53

		local var_91_0 = {
			zh = 3.666,
			ja = 5.533
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play120042023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.375

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:GetWordFromCfg(120042022)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 15 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 15)

				if (15 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 15)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042022", "story_v_out_120042.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042022", "story_v_out_120042.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_120042", "120042022", "story_v_out_120042.awb")

						arg_91_1:RecordAudio("120042022", var_94_6)
						arg_91_1:RecordAudio("120042022", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_120042", "120042022", "story_v_out_120042.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_120042", "120042022", "story_v_out_120042.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play120042023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 120042023
		arg_95_1.duration_ = 9

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play120042024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if arg_95_1.bgs_.XH0104 == nil then
				local var_98_0 = Object.Instantiate(arg_95_1.paintGo_)

				var_98_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0104")
				var_98_0.name = "XH0104"
				var_98_0.transform.parent = arg_95_1.stage_.transform
				var_98_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.bgs_.XH0104 = var_98_0
			end

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= 2 + arg_98_0 then
				local var_98_1 = arg_95_1.bgs_.XH0104

				arg_95_1.bgs_.XH0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_98_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_2 = var_98_1:GetComponent("SpriteRenderer")

				if var_98_2 and var_98_2.sprite then
					local var_98_3 = 2 * (var_98_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_98_1.transform.localScale = Vector3.New(var_98_3 / var_98_2.sprite.bounds.size.y < var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x and var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x or var_98_3 / var_98_2.sprite.bounds.size.y, var_98_3 / var_98_2.sprite.bounds.size.y < var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x and var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x or var_98_3 / var_98_2.sprite.bounds.size.y, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "XH0104" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_4 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_5 = 2

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_5 then
				local var_98_6 = Color.New(0, 0, 0)

				var_98_6.a = Mathf.Lerp(0, 1, (arg_95_1.time_ - var_98_4) / var_98_5)
				arg_95_1.mask_.color = var_98_6
			end

			if arg_95_1.time_ >= var_98_4 + var_98_5 and arg_95_1.time_ < var_98_4 + var_98_5 + arg_98_0 then
				local var_98_7 = Color.New(0, 0, 0)

				var_98_7.a = 1
				arg_95_1.mask_.color = var_98_7
			end

			local var_98_8 = 2

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_9 = 2

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_9 then
				local var_98_10 = Color.New(0, 0, 0)

				var_98_10.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_8) / var_98_9)
				arg_95_1.mask_.color = var_98_10
			end

			if arg_95_1.time_ >= var_98_8 + var_98_9 and arg_95_1.time_ < var_98_8 + var_98_9 + arg_98_0 then
				local var_98_11 = Color.New(0, 0, 0)

				arg_95_1.mask_.enabled = false
				var_98_11.a = 0
				arg_95_1.mask_.color = var_98_11
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_12 = 4
			local var_98_13 = 0.925

			if 4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_14 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_14:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_15 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(120042023).content)

				arg_95_1.text_.text = var_98_15

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_17 = 37 <= 0 and var_98_13 or var_98_13 * (utf8.len(var_98_15) / 37)

				if (37 <= 0 and var_98_13 or var_98_13 * (utf8.len(var_98_15) / 37)) > 0 and var_98_13 < var_98_17 then
					arg_95_1.talkMaxDuration = var_98_17
					var_98_12 = var_98_12 + 0.3

					if var_98_17 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_17 + var_98_12
					end
				end

				arg_95_1.text_.text = var_98_15
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_18 = var_98_12 + 0.3
			local var_98_19 = math.max(var_98_13, arg_95_1.talkMaxDuration)

			if var_98_12 + 0.3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_18 + var_98_19 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_18) / var_98_19

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_18 + var_98_19 and arg_95_1.time_ < var_98_18 + var_98_19 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play120042024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 120042024
		arg_101_1.duration_ = 3.7

		local var_101_0 = {
			zh = 3.7,
			ja = 2.4
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
				arg_101_0:Play120042025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.275

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(120042024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 11 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 11)

				if (11 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 11)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042024", "story_v_out_120042.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042024", "story_v_out_120042.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_120042", "120042024", "story_v_out_120042.awb")

						arg_101_1:RecordAudio("120042024", var_104_6)
						arg_101_1:RecordAudio("120042024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_120042", "120042024", "story_v_out_120042.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_120042", "120042024", "story_v_out_120042.awb")
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
	Play120042025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 120042025
		arg_105_1.duration_ = 9.6

		local var_105_0 = {
			zh = 3.533,
			ja = 9.6
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
				arg_105_0:Play120042026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.425

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(120042025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 17 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 17)

				if (17 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 17)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042025", "story_v_out_120042.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042025", "story_v_out_120042.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_120042", "120042025", "story_v_out_120042.awb")

						arg_105_1:RecordAudio("120042025", var_108_6)
						arg_105_1:RecordAudio("120042025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_120042", "120042025", "story_v_out_120042.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_120042", "120042025", "story_v_out_120042.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play120042026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 120042026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play120042027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.85

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(120042026).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 34 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 34)

				if (34 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 34)) > 0 and var_112_0 < var_112_3 then
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
	Play120042027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 120042027
		arg_113_1.duration_ = 6.1

		local var_113_0 = {
			zh = 6.1,
			ja = 5.1
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
				arg_113_0:Play120042028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.675

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(120042027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 27 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 27)

				if (27 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 27)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042027", "story_v_out_120042.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042027", "story_v_out_120042.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_120042", "120042027", "story_v_out_120042.awb")

						arg_113_1:RecordAudio("120042027", var_116_6)
						arg_113_1:RecordAudio("120042027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_120042", "120042027", "story_v_out_120042.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_120042", "120042027", "story_v_out_120042.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play120042028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 120042028
		arg_117_1.duration_ = 7.07

		local var_117_0 = {
			zh = 7.066,
			ja = 4.966
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
				arg_117_0:Play120042029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.875

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(120042028)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 35 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 35)

				if (35 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 35)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042028", "story_v_out_120042.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042028", "story_v_out_120042.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_120042", "120042028", "story_v_out_120042.awb")

						arg_117_1:RecordAudio("120042028", var_120_6)
						arg_117_1:RecordAudio("120042028", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_120042", "120042028", "story_v_out_120042.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_120042", "120042028", "story_v_out_120042.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play120042029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 120042029
		arg_121_1.duration_ = 13.27

		local var_121_0 = {
			zh = 12.766,
			ja = 13.266
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
				arg_121_0:Play120042030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.5

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(120042029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 60 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 60)

				if (60 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 60)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042029", "story_v_out_120042.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042029", "story_v_out_120042.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_120042", "120042029", "story_v_out_120042.awb")

						arg_121_1:RecordAudio("120042029", var_124_6)
						arg_121_1:RecordAudio("120042029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_120042", "120042029", "story_v_out_120042.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_120042", "120042029", "story_v_out_120042.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play120042030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 120042030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play120042031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.125

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(120042030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 45 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 45)

				if (45 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 45)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play120042031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 120042031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play120042032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.275

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(120042031).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 11 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 11)

				if (11 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 11)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play120042032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 120042032
		arg_133_1.duration_ = 14.57

		local var_133_0 = {
			zh = 11.866,
			ja = 14.566
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
				arg_133_0:Play120042033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 2 < arg_133_1.time_ and arg_133_1.time_ <= 2 + arg_136_0 then
				local var_136_0 = arg_133_1.bgs_.J02i

				arg_133_1.bgs_.J02i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_136_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_1 = var_136_0:GetComponent("SpriteRenderer")

				if var_136_1 and var_136_1.sprite then
					local var_136_2 = 2 * (var_136_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_136_0.transform.localScale = Vector3.New(var_136_2 / var_136_1.sprite.bounds.size.y < var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x and var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x or var_136_2 / var_136_1.sprite.bounds.size.y, var_136_2 / var_136_1.sprite.bounds.size.y < var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x and var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x or var_136_2 / var_136_1.sprite.bounds.size.y, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "J02i" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_3 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_4 = 2

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_4 then
				local var_136_5 = Color.New(0, 0, 0)

				var_136_5.a = Mathf.Lerp(0, 1, (arg_133_1.time_ - var_136_3) / var_136_4)
				arg_133_1.mask_.color = var_136_5
			end

			if arg_133_1.time_ >= var_136_3 + var_136_4 and arg_133_1.time_ < var_136_3 + var_136_4 + arg_136_0 then
				local var_136_6 = Color.New(0, 0, 0)

				var_136_6.a = 1
				arg_133_1.mask_.color = var_136_6
			end

			local var_136_7 = 2

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_8 = 2

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_8 then
				local var_136_9 = Color.New(0, 0, 0)

				var_136_9.a = Mathf.Lerp(1, 0, (arg_133_1.time_ - var_136_7) / var_136_8)
				arg_133_1.mask_.color = var_136_9
			end

			if arg_133_1.time_ >= var_136_7 + var_136_8 and arg_133_1.time_ < var_136_7 + var_136_8 + arg_136_0 then
				local var_136_10 = Color.New(0, 0, 0)

				arg_133_1.mask_.enabled = false
				var_136_10.a = 0
				arg_133_1.mask_.color = var_136_10
			end

			local var_136_11 = "1071ui_story"

			if arg_133_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_136_12 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_133_1.stage_.transform)

				var_136_12.name = var_136_11
				var_136_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_[var_136_11] = var_136_12

				local var_136_13 = var_136_12:GetComponentInChildren(typeof(CharacterEffect))

				var_136_13.enabled = true

				local var_136_14 = GameObjectTools.GetOrAddComponent(var_136_12, typeof(DynamicBoneHelper))

				if var_136_14 then
					var_136_14:EnableDynamicBone(false)
				end

				arg_133_1:ShowWeapon(var_136_13.transform, false)

				arg_133_1.var_[var_136_11 .. "Animator"] = var_136_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_133_1.var_[var_136_11 .. "Animator"].applyRootMotion = true
				arg_133_1.var_[var_136_11 .. "LipSync"] = var_136_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_136_15 = arg_133_1.actors_["1071ui_story"].transform

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= 4 + arg_136_0 then
				arg_133_1.var_.moveOldPos1071ui_story = var_136_15.localPosition
			end

			local var_136_16 = 0.001

			if 4 <= arg_133_1.time_ and arg_133_1.time_ < 4 + var_136_16 then
				var_136_15.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_133_1.time_ - 4) / var_136_16)
				var_136_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_15.position).x, (manager.ui.mainCamera.transform.position - var_136_15.position).y, (manager.ui.mainCamera.transform.position - var_136_15.position).z)
				var_136_15.localEulerAngles.z = 0
				var_136_15.localEulerAngles.x = 0
				var_136_15.localEulerAngles = var_136_15.localEulerAngles
			end

			if arg_133_1.time_ >= 4 + var_136_16 and arg_133_1.time_ < 4 + var_136_16 + arg_136_0 then
				var_136_15.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_136_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_15.position).x, (manager.ui.mainCamera.transform.position - var_136_15.position).y, (manager.ui.mainCamera.transform.position - var_136_15.position).z)
				var_136_15.localEulerAngles.z = 0
				var_136_15.localEulerAngles.x = 0
				var_136_15.localEulerAngles = var_136_15.localEulerAngles
			end

			local var_136_17 = arg_133_1.actors_["1069ui_story"].transform

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= 4 + arg_136_0 then
				arg_133_1.var_.moveOldPos1069ui_story = var_136_17.localPosition
			end

			local var_136_18 = 0.001

			if 4 <= arg_133_1.time_ and arg_133_1.time_ < 4 + var_136_18 then
				var_136_17.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_133_1.time_ - 4) / var_136_18)
				var_136_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_17.position).x, (manager.ui.mainCamera.transform.position - var_136_17.position).y, (manager.ui.mainCamera.transform.position - var_136_17.position).z)
				var_136_17.localEulerAngles.z = 0
				var_136_17.localEulerAngles.x = 0
				var_136_17.localEulerAngles = var_136_17.localEulerAngles
			end

			if arg_133_1.time_ >= 4 + var_136_18 and arg_133_1.time_ < 4 + var_136_18 + arg_136_0 then
				var_136_17.localPosition = Vector3.New(0.7, -1, -6)
				var_136_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_17.position).x, (manager.ui.mainCamera.transform.position - var_136_17.position).y, (manager.ui.mainCamera.transform.position - var_136_17.position).z)
				var_136_17.localEulerAngles.z = 0
				var_136_17.localEulerAngles.x = 0
				var_136_17.localEulerAngles = var_136_17.localEulerAngles
			end

			local var_136_19 = arg_133_1.actors_["1071ui_story"]

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= 4 + arg_136_0 and not isNil(var_136_19) and arg_133_1.var_.characterEffect1071ui_story == nil then
				arg_133_1.var_.characterEffect1071ui_story = var_136_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_20 = 0.2

			if 4 <= arg_133_1.time_ and arg_133_1.time_ < 4 + var_136_20 and not isNil(var_136_19) then
				if arg_133_1.var_.characterEffect1071ui_story and not isNil(var_136_19) then
					arg_133_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 4 + var_136_20 and arg_133_1.time_ < 4 + var_136_20 + arg_136_0 and not isNil(var_136_19) and arg_133_1.var_.characterEffect1071ui_story then
				arg_133_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_136_22 = arg_133_1.actors_["1069ui_story"]

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= 4 + arg_136_0 and not isNil(var_136_22) and arg_133_1.var_.characterEffect1069ui_story == nil then
				arg_133_1.var_.characterEffect1069ui_story = var_136_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_23 = 0.0339999999999998

			if 4 <= arg_133_1.time_ and arg_133_1.time_ < 4 + var_136_23 and not isNil(var_136_22) then
				if arg_133_1.var_.characterEffect1069ui_story and not isNil(var_136_22) then
					arg_133_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 4) / var_136_23)
				end
			end

			if arg_133_1.time_ >= 4 + var_136_23 and arg_133_1.time_ < 4 + var_136_23 + arg_136_0 and not isNil(var_136_22) and arg_133_1.var_.characterEffect1069ui_story then
				arg_133_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= 4 + arg_136_0 then
				arg_133_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= 4 + arg_136_0 then
				arg_133_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= 4 + arg_136_0 then
				arg_133_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_24 = 4
			local var_136_25 = 0.925

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_24 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_26 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_26:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_27 = arg_133_1:GetWordFromCfg(120042032)
				local var_136_28 = arg_133_1:FormatText(var_136_27.content)

				arg_133_1.text_.text = var_136_28

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_30 = 37 <= 0 and var_136_25 or var_136_25 * (utf8.len(var_136_28) / 37)

				if (37 <= 0 and var_136_25 or var_136_25 * (utf8.len(var_136_28) / 37)) > 0 and var_136_25 < var_136_30 then
					arg_133_1.talkMaxDuration = var_136_30
					var_136_24 = var_136_24 + 0.3

					if var_136_30 + var_136_24 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_30 + var_136_24
					end
				end

				arg_133_1.text_.text = var_136_28
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042032", "story_v_out_120042.awb") ~= 0 then
					local var_136_31 = manager.audio:GetVoiceLength("story_v_out_120042", "120042032", "story_v_out_120042.awb") / 1000

					if var_136_31 + var_136_24 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_31 + var_136_24
					end

					if var_136_27.prefab_name ~= "" and arg_133_1.actors_[var_136_27.prefab_name] ~= nil then
						local var_136_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_27.prefab_name].transform, "story_v_out_120042", "120042032", "story_v_out_120042.awb")

						arg_133_1:RecordAudio("120042032", var_136_32)
						arg_133_1:RecordAudio("120042032", var_136_32)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_120042", "120042032", "story_v_out_120042.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_120042", "120042032", "story_v_out_120042.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_33 = var_136_24 + 0.3
			local var_136_34 = math.max(var_136_25, arg_133_1.talkMaxDuration)

			if var_136_24 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_33 + var_136_34 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_33) / var_136_34

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_33 + var_136_34 and arg_133_1.time_ < var_136_33 + var_136_34 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play120042033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 120042033
		arg_139_1.duration_ = 8.97

		local var_139_0 = {
			zh = 8.966,
			ja = 6.033
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play120042034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1071ui_story = arg_139_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1071ui_story"].transform.position).z)
				arg_139_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1071ui_story"].transform.localEulerAngles = arg_139_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_139_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1071ui_story"].transform.position).z)
				arg_139_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1071ui_story"].transform.localEulerAngles = arg_139_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1069ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1069ui_story = var_142_1.localPosition
			end

			local var_142_2 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 then
				var_142_1.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_139_1.time_ - 0) / var_142_2)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 then
				var_142_1.localPosition = Vector3.New(0.7, -1, -6)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			local var_142_3 = arg_139_1.actors_["1071ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_3) and arg_139_1.var_.characterEffect1071ui_story == nil then
				arg_139_1.var_.characterEffect1071ui_story = var_142_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_4 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 and not isNil(var_142_3) then
				if arg_139_1.var_.characterEffect1071ui_story and not isNil(var_142_3) then
					arg_139_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_4)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 and not isNil(var_142_3) and arg_139_1.var_.characterEffect1071ui_story then
				arg_139_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_142_5 = arg_139_1.actors_["1069ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1069ui_story == nil then
				arg_139_1.var_.characterEffect1069ui_story = var_142_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_6 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.characterEffect1069ui_story and not isNil(var_142_5) then
					arg_139_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1069ui_story then
				arg_139_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action6_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_142_8 = 0
			local var_142_9 = 1

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(120042033)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 40 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 40)

				if (40 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 40)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042033", "story_v_out_120042.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_120042", "120042033", "story_v_out_120042.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_120042", "120042033", "story_v_out_120042.awb")

						arg_139_1:RecordAudio("120042033", var_142_15)
						arg_139_1:RecordAudio("120042033", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_120042", "120042033", "story_v_out_120042.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_120042", "120042033", "story_v_out_120042.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play120042034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 120042034
		arg_143_1.duration_ = 4

		local var_143_0 = {
			zh = 3.933,
			ja = 4
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
				arg_143_0:Play120042035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1071ui_story"]) and arg_143_1.var_.characterEffect1071ui_story == nil then
				arg_143_1.var_.characterEffect1071ui_story = arg_143_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1071ui_story"]) then
				if arg_143_1.var_.characterEffect1071ui_story and not isNil(arg_143_1.actors_["1071ui_story"]) then
					arg_143_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1071ui_story"]) and arg_143_1.var_.characterEffect1071ui_story then
				arg_143_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_146_2 = arg_143_1.actors_["1069ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.characterEffect1069ui_story == nil then
				arg_143_1.var_.characterEffect1069ui_story = var_146_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_3 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.characterEffect1069ui_story and not isNil(var_146_2) then
					arg_143_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_3)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.characterEffect1069ui_story then
				arg_143_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_146_4 = 0
			local var_146_5 = 0.425

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(120042034)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 17 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 17)

				if (17 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 17)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042034", "story_v_out_120042.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042034", "story_v_out_120042.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_120042", "120042034", "story_v_out_120042.awb")

						arg_143_1:RecordAudio("120042034", var_146_11)
						arg_143_1:RecordAudio("120042034", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_120042", "120042034", "story_v_out_120042.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_120042", "120042034", "story_v_out_120042.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play120042035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 120042035
		arg_147_1.duration_ = 11.57

		local var_147_0 = {
			zh = 7.366,
			ja = 11.566
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
				arg_147_0:Play120042036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.975

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(120042035)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 39 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 39)

				if (39 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 39)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042035", "story_v_out_120042.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042035", "story_v_out_120042.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_120042", "120042035", "story_v_out_120042.awb")

						arg_147_1:RecordAudio("120042035", var_150_6)
						arg_147_1:RecordAudio("120042035", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_120042", "120042035", "story_v_out_120042.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_120042", "120042035", "story_v_out_120042.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play120042036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 120042036
		arg_151_1.duration_ = 7.97

		local var_151_0 = {
			zh = 3.466,
			ja = 7.966
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
				arg_151_0:Play120042037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.425

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(120042036)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 17 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 17)

				if (17 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 17)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042036", "story_v_out_120042.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042036", "story_v_out_120042.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_120042", "120042036", "story_v_out_120042.awb")

						arg_151_1:RecordAudio("120042036", var_154_6)
						arg_151_1:RecordAudio("120042036", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_120042", "120042036", "story_v_out_120042.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_120042", "120042036", "story_v_out_120042.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play120042037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 120042037
		arg_155_1.duration_ = 5.13

		local var_155_0 = {
			zh = 3.1,
			ja = 5.133
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
				arg_155_0:Play120042038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1069ui_story"]) and arg_155_1.var_.characterEffect1069ui_story == nil then
				arg_155_1.var_.characterEffect1069ui_story = arg_155_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1069ui_story"]) then
				if arg_155_1.var_.characterEffect1069ui_story and not isNil(arg_155_1.actors_["1069ui_story"]) then
					arg_155_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1069ui_story"]) and arg_155_1.var_.characterEffect1069ui_story then
				arg_155_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_158_2 = arg_155_1.actors_["1071ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect1071ui_story == nil then
				arg_155_1.var_.characterEffect1071ui_story = var_158_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_3 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.characterEffect1071ui_story and not isNil(var_158_2) then
					arg_155_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_3)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect1071ui_story then
				arg_155_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action464")
			end

			local var_158_4 = 0
			local var_158_5 = 0.425

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(120042037)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 17 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 17)

				if (17 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 17)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042037", "story_v_out_120042.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042037", "story_v_out_120042.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_out_120042", "120042037", "story_v_out_120042.awb")

						arg_155_1:RecordAudio("120042037", var_158_11)
						arg_155_1:RecordAudio("120042037", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_120042", "120042037", "story_v_out_120042.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_120042", "120042037", "story_v_out_120042.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_12 and arg_155_1.time_ < var_158_4 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play120042038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 120042038
		arg_159_1.duration_ = 7.67

		local var_159_0 = {
			zh = 2.4,
			ja = 7.666
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
				arg_159_0:Play120042039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1071ui_story = arg_159_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1071ui_story"].transform.position).z)
				arg_159_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1071ui_story"].transform.localEulerAngles = arg_159_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_159_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1071ui_story"].transform.position).z)
				arg_159_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1071ui_story"].transform.localEulerAngles = arg_159_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1069ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1069ui_story = var_162_1.localPosition
			end

			local var_162_2 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 then
				var_162_1.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_159_1.time_ - 0) / var_162_2)
				var_162_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_1.position).x, (manager.ui.mainCamera.transform.position - var_162_1.position).y, (manager.ui.mainCamera.transform.position - var_162_1.position).z)
				var_162_1.localEulerAngles.z = 0
				var_162_1.localEulerAngles.x = 0
				var_162_1.localEulerAngles = var_162_1.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 then
				var_162_1.localPosition = Vector3.New(0.7, -1, -6)
				var_162_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_1.position).x, (manager.ui.mainCamera.transform.position - var_162_1.position).y, (manager.ui.mainCamera.transform.position - var_162_1.position).z)
				var_162_1.localEulerAngles.z = 0
				var_162_1.localEulerAngles.x = 0
				var_162_1.localEulerAngles = var_162_1.localEulerAngles
			end

			local var_162_3 = arg_159_1.actors_["1069ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect1069ui_story == nil then
				arg_159_1.var_.characterEffect1069ui_story = var_162_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_4 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 and not isNil(var_162_3) then
				if arg_159_1.var_.characterEffect1069ui_story and not isNil(var_162_3) then
					arg_159_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect1069ui_story then
				arg_159_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_162_6 = 0
			local var_162_7 = 0.35

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(120042038)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 14 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 14)

				if (14 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 14)) > 0 and var_162_7 < var_162_11 then
					arg_159_1.talkMaxDuration = var_162_11

					if var_162_11 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042038", "story_v_out_120042.awb") ~= 0 then
					local var_162_12 = manager.audio:GetVoiceLength("story_v_out_120042", "120042038", "story_v_out_120042.awb") / 1000

					if var_162_12 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_6
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_120042", "120042038", "story_v_out_120042.awb")

						arg_159_1:RecordAudio("120042038", var_162_13)
						arg_159_1:RecordAudio("120042038", var_162_13)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_120042", "120042038", "story_v_out_120042.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_120042", "120042038", "story_v_out_120042.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play120042039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 120042039
		arg_163_1.duration_ = 8.23

		local var_163_0 = {
			zh = 5.766,
			ja = 8.233
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
				arg_163_0:Play120042040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1071ui_story = arg_163_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1071ui_story"].transform.position).z)
				arg_163_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1071ui_story"].transform.localEulerAngles = arg_163_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_163_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1071ui_story"].transform.position).z)
				arg_163_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1071ui_story"].transform.localEulerAngles = arg_163_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1069ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1069ui_story = var_166_1.localPosition
			end

			local var_166_2 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 then
				var_166_1.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_163_1.time_ - 0) / var_166_2)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 then
				var_166_1.localPosition = Vector3.New(0.7, -1, -6)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			local var_166_3 = arg_163_1.actors_["1071ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.characterEffect1071ui_story == nil then
				arg_163_1.var_.characterEffect1071ui_story = var_166_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_4 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 and not isNil(var_166_3) then
				if arg_163_1.var_.characterEffect1071ui_story and not isNil(var_166_3) then
					arg_163_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.characterEffect1071ui_story then
				arg_163_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_166_6 = arg_163_1.actors_["1069ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1069ui_story == nil then
				arg_163_1.var_.characterEffect1069ui_story = var_166_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_7 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 and not isNil(var_166_6) then
				if arg_163_1.var_.characterEffect1069ui_story and not isNil(var_166_6) then
					arg_163_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_7)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1069ui_story then
				arg_163_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_166_8 = 0
			local var_166_9 = 0.7

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(120042039)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 28 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 28)

				if (28 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 28)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042039", "story_v_out_120042.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_120042", "120042039", "story_v_out_120042.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_120042", "120042039", "story_v_out_120042.awb")

						arg_163_1:RecordAudio("120042039", var_166_15)
						arg_163_1:RecordAudio("120042039", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_120042", "120042039", "story_v_out_120042.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_120042", "120042039", "story_v_out_120042.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_16 and arg_163_1.time_ < var_166_8 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play120042040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 120042040
		arg_167_1.duration_ = 7

		local var_167_0 = {
			zh = 7,
			ja = 6.333
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
				arg_167_0:Play120042041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1071ui_story = arg_167_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1071ui_story"].transform.position).z)
				arg_167_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1071ui_story"].transform.localEulerAngles = arg_167_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_167_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1071ui_story"].transform.position).z)
				arg_167_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1071ui_story"].transform.localEulerAngles = arg_167_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1069ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1069ui_story = var_170_1.localPosition
			end

			local var_170_2 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 then
				var_170_1.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_167_1.time_ - 0) / var_170_2)
				var_170_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_1.position).x, (manager.ui.mainCamera.transform.position - var_170_1.position).y, (manager.ui.mainCamera.transform.position - var_170_1.position).z)
				var_170_1.localEulerAngles.z = 0
				var_170_1.localEulerAngles.x = 0
				var_170_1.localEulerAngles = var_170_1.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 then
				var_170_1.localPosition = Vector3.New(0.7, -1, -6)
				var_170_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_1.position).x, (manager.ui.mainCamera.transform.position - var_170_1.position).y, (manager.ui.mainCamera.transform.position - var_170_1.position).z)
				var_170_1.localEulerAngles.z = 0
				var_170_1.localEulerAngles.x = 0
				var_170_1.localEulerAngles = var_170_1.localEulerAngles
			end

			local var_170_3 = arg_167_1.actors_["1071ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect1071ui_story == nil then
				arg_167_1.var_.characterEffect1071ui_story = var_170_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_4 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 and not isNil(var_170_3) then
				if arg_167_1.var_.characterEffect1071ui_story and not isNil(var_170_3) then
					arg_167_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_4)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect1071ui_story then
				arg_167_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_170_5 = arg_167_1.actors_["1069ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1069ui_story == nil then
				arg_167_1.var_.characterEffect1069ui_story = var_170_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_6 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.characterEffect1069ui_story and not isNil(var_170_5) then
					arg_167_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1069ui_story then
				arg_167_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_170_8 = 0
			local var_170_9 = 0.975

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(120042040)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 39 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 39)

				if (39 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 39)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042040", "story_v_out_120042.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_120042", "120042040", "story_v_out_120042.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_120042", "120042040", "story_v_out_120042.awb")

						arg_167_1:RecordAudio("120042040", var_170_15)
						arg_167_1:RecordAudio("120042040", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_120042", "120042040", "story_v_out_120042.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_120042", "120042040", "story_v_out_120042.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_16 and arg_167_1.time_ < var_170_8 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play120042041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 120042041
		arg_171_1.duration_ = 1.7

		local var_171_0 = {
			zh = 1.7,
			ja = 1.466
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
				arg_171_0:Play120042042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1071ui_story"]) and arg_171_1.var_.characterEffect1071ui_story == nil then
				arg_171_1.var_.characterEffect1071ui_story = arg_171_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1071ui_story"]) then
				if arg_171_1.var_.characterEffect1071ui_story and not isNil(arg_171_1.actors_["1071ui_story"]) then
					arg_171_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1071ui_story"]) and arg_171_1.var_.characterEffect1071ui_story then
				arg_171_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_174_2 = arg_171_1.actors_["1069ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect1069ui_story == nil then
				arg_171_1.var_.characterEffect1069ui_story = var_174_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_3 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.characterEffect1069ui_story and not isNil(var_174_2) then
					arg_171_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_3)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect1069ui_story then
				arg_171_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_174_4 = 0
			local var_174_5 = 0.15

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(120042041)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 6 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 6)

				if (6 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 6)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042041", "story_v_out_120042.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042041", "story_v_out_120042.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_120042", "120042041", "story_v_out_120042.awb")

						arg_171_1:RecordAudio("120042041", var_174_11)
						arg_171_1:RecordAudio("120042041", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_120042", "120042041", "story_v_out_120042.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_120042", "120042041", "story_v_out_120042.awb")
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

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play120042042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 120042042
		arg_175_1.duration_ = 5.5

		local var_175_0 = {
			zh = 4.066,
			ja = 5.5
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
				arg_175_0:Play120042043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_178_0 = 0
			local var_178_1 = 0.25

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(120042042)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 10 <= 0 and var_178_1 or var_178_1 * (utf8.len(var_178_3) / 10)

				if (10 <= 0 and var_178_1 or var_178_1 * (utf8.len(var_178_3) / 10)) > 0 and var_178_1 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042042", "story_v_out_120042.awb") ~= 0 then
					local var_178_6 = manager.audio:GetVoiceLength("story_v_out_120042", "120042042", "story_v_out_120042.awb") / 1000

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end

					if var_178_2.prefab_name ~= "" and arg_175_1.actors_[var_178_2.prefab_name] ~= nil then
						local var_178_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_2.prefab_name].transform, "story_v_out_120042", "120042042", "story_v_out_120042.awb")

						arg_175_1:RecordAudio("120042042", var_178_7)
						arg_175_1:RecordAudio("120042042", var_178_7)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_120042", "120042042", "story_v_out_120042.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_120042", "120042042", "story_v_out_120042.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play120042043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 120042043
		arg_179_1.duration_ = 2.27

		local var_179_0 = {
			zh = 2.266,
			ja = 1.933
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
				arg_179_0:Play120042044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1071ui_story"]) and arg_179_1.var_.characterEffect1071ui_story == nil then
				arg_179_1.var_.characterEffect1071ui_story = arg_179_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1071ui_story"]) then
				if arg_179_1.var_.characterEffect1071ui_story and not isNil(arg_179_1.actors_["1071ui_story"]) then
					arg_179_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1071ui_story"]) and arg_179_1.var_.characterEffect1071ui_story then
				arg_179_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_182_1 = arg_179_1.actors_["1069ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1069ui_story == nil then
				arg_179_1.var_.characterEffect1069ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1069ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1069ui_story then
				arg_179_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_182_4 = 0
			local var_182_5 = 0.3

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(120042043)
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

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042043", "story_v_out_120042.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042043", "story_v_out_120042.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_120042", "120042043", "story_v_out_120042.awb")

						arg_179_1:RecordAudio("120042043", var_182_11)
						arg_179_1:RecordAudio("120042043", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_120042", "120042043", "story_v_out_120042.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_120042", "120042043", "story_v_out_120042.awb")
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

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play120042044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 120042044
		arg_183_1.duration_ = 9.27

		local var_183_0 = {
			zh = 7.8,
			ja = 9.266
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
				arg_183_0:Play120042045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1071ui_story"]) and arg_183_1.var_.characterEffect1071ui_story == nil then
				arg_183_1.var_.characterEffect1071ui_story = arg_183_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1071ui_story"]) then
				if arg_183_1.var_.characterEffect1071ui_story and not isNil(arg_183_1.actors_["1071ui_story"]) then
					arg_183_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1071ui_story"]) and arg_183_1.var_.characterEffect1071ui_story then
				arg_183_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_186_2 = arg_183_1.actors_["1069ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect1069ui_story == nil then
				arg_183_1.var_.characterEffect1069ui_story = var_186_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_3 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.characterEffect1069ui_story and not isNil(var_186_2) then
					arg_183_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_3)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect1069ui_story then
				arg_183_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_186_4 = 0
			local var_186_5 = 0.775

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(120042044)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 31 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 31)

				if (31 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 31)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042044", "story_v_out_120042.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042044", "story_v_out_120042.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_120042", "120042044", "story_v_out_120042.awb")

						arg_183_1:RecordAudio("120042044", var_186_11)
						arg_183_1:RecordAudio("120042044", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_120042", "120042044", "story_v_out_120042.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_120042", "120042044", "story_v_out_120042.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play120042045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 120042045
		arg_187_1.duration_ = 6.5

		local var_187_0 = {
			zh = 6.166,
			ja = 6.5
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
				arg_187_0:Play120042046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.775

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(120042045)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 31 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 31)

				if (31 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 31)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042045", "story_v_out_120042.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042045", "story_v_out_120042.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_120042", "120042045", "story_v_out_120042.awb")

						arg_187_1:RecordAudio("120042045", var_190_6)
						arg_187_1:RecordAudio("120042045", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_120042", "120042045", "story_v_out_120042.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_120042", "120042045", "story_v_out_120042.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play120042046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 120042046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play120042047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1071ui_story = arg_191_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1071ui_story"].transform.position).z)
				arg_191_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1071ui_story"].transform.localEulerAngles = arg_191_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1071ui_story"].transform.position).z)
				arg_191_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1071ui_story"].transform.localEulerAngles = arg_191_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1069ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1069ui_story = var_194_1.localPosition
			end

			local var_194_2 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 then
				var_194_1.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_2)
				var_194_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_1.position).x, (manager.ui.mainCamera.transform.position - var_194_1.position).y, (manager.ui.mainCamera.transform.position - var_194_1.position).z)
				var_194_1.localEulerAngles.z = 0
				var_194_1.localEulerAngles.x = 0
				var_194_1.localEulerAngles = var_194_1.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 then
				var_194_1.localPosition = Vector3.New(0, 100, 0)
				var_194_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_1.position).x, (manager.ui.mainCamera.transform.position - var_194_1.position).y, (manager.ui.mainCamera.transform.position - var_194_1.position).z)
				var_194_1.localEulerAngles.z = 0
				var_194_1.localEulerAngles.x = 0
				var_194_1.localEulerAngles = var_194_1.localEulerAngles
			end

			local var_194_3 = 0
			local var_194_4 = 0.6

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_3 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_5 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(120042046).content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 24 <= 0 and var_194_4 or var_194_4 * (utf8.len(var_194_5) / 24)

				if (24 <= 0 and var_194_4 or var_194_4 * (utf8.len(var_194_5) / 24)) > 0 and var_194_4 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_3 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_3
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_4, arg_191_1.talkMaxDuration)

			if var_194_3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_3 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_3) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_3 + var_194_8 and arg_191_1.time_ < var_194_3 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play120042047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 120042047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play120042048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.725

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(120042047).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 29 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 29)

				if (29 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 29)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play120042048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 120042048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play120042049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.2

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(120042048).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 8 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 8)

				if (8 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 8)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play120042049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 120042049
		arg_203_1.duration_ = 14.07

		local var_203_0 = {
			zh = 14.066,
			ja = 11.3
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
				arg_203_0:Play120042050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1184ui_story = arg_203_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1184ui_story"].transform.position).z)
				arg_203_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1184ui_story"].transform.localEulerAngles = arg_203_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_203_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1184ui_story"].transform.position).z)
				arg_203_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1184ui_story"].transform.localEulerAngles = arg_203_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1184ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1184ui_story == nil then
				arg_203_1.var_.characterEffect1184ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1184ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1184ui_story then
				arg_203_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_206_4 = 0
			local var_206_5 = 1.125

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(120042049)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 45 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 45)

				if (45 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 45)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042049", "story_v_out_120042.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042049", "story_v_out_120042.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_120042", "120042049", "story_v_out_120042.awb")

						arg_203_1:RecordAudio("120042049", var_206_11)
						arg_203_1:RecordAudio("120042049", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_120042", "120042049", "story_v_out_120042.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_120042", "120042049", "story_v_out_120042.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play120042050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 120042050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play120042051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1184ui_story = arg_207_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1184ui_story"].transform.position).z)
				arg_207_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1184ui_story"].transform.localEulerAngles = arg_207_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_207_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1184ui_story"].transform.position).z)
				arg_207_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1184ui_story"].transform.localEulerAngles = arg_207_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1184ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1184ui_story == nil then
				arg_207_1.var_.characterEffect1184ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1184ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_2)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1184ui_story then
				arg_207_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_210_3 = 0
			local var_210_4 = 0.15

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_3 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_5 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(120042050).content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 6 <= 0 and var_210_4 or var_210_4 * (utf8.len(var_210_5) / 6)

				if (6 <= 0 and var_210_4 or var_210_4 * (utf8.len(var_210_5) / 6)) > 0 and var_210_4 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_3 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_3
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_4, arg_207_1.talkMaxDuration)

			if var_210_3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_3 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_3) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_3 + var_210_8 and arg_207_1.time_ < var_210_3 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play120042051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 120042051
		arg_211_1.duration_ = 14.27

		local var_211_0 = {
			zh = 8.4,
			ja = 14.266
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
				arg_211_0:Play120042052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1184ui_story"]) and arg_211_1.var_.characterEffect1184ui_story == nil then
				arg_211_1.var_.characterEffect1184ui_story = arg_211_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1184ui_story"]) then
				if arg_211_1.var_.characterEffect1184ui_story and not isNil(arg_211_1.actors_["1184ui_story"]) then
					arg_211_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1184ui_story"]) and arg_211_1.var_.characterEffect1184ui_story then
				arg_211_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_214_2 = 0
			local var_214_3 = 0.65

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:GetWordFromCfg(120042051)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 26 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 26)

				if (26 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 26)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042051", "story_v_out_120042.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_120042", "120042051", "story_v_out_120042.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_out_120042", "120042051", "story_v_out_120042.awb")

						arg_211_1:RecordAudio("120042051", var_214_9)
						arg_211_1:RecordAudio("120042051", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_120042", "120042051", "story_v_out_120042.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_120042", "120042051", "story_v_out_120042.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play120042052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 120042052
		arg_215_1.duration_ = 6.43

		local var_215_0 = {
			zh = 6.433,
			ja = 5.9
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
				arg_215_0:Play120042053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_218_0 = 0
			local var_218_1 = 0.65

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(120042052)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 26 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 26)

				if (26 <= 0 and var_218_1 or var_218_1 * (utf8.len(var_218_3) / 26)) > 0 and var_218_1 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042052", "story_v_out_120042.awb") ~= 0 then
					local var_218_6 = manager.audio:GetVoiceLength("story_v_out_120042", "120042052", "story_v_out_120042.awb") / 1000

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end

					if var_218_2.prefab_name ~= "" and arg_215_1.actors_[var_218_2.prefab_name] ~= nil then
						local var_218_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_2.prefab_name].transform, "story_v_out_120042", "120042052", "story_v_out_120042.awb")

						arg_215_1:RecordAudio("120042052", var_218_7)
						arg_215_1:RecordAudio("120042052", var_218_7)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_120042", "120042052", "story_v_out_120042.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_120042", "120042052", "story_v_out_120042.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play120042053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 120042053
		arg_219_1.duration_ = 0.2

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"

			SetActive(arg_219_1.choicesGo_, true)

			for iter_220_0, iter_220_1 in ipairs(arg_219_1.choices_) do
				SetActive(iter_220_1.go, iter_220_0 <= 2)
			end

			arg_219_1.choices_[1].txt.text = arg_219_1:FormatText(StoryChoiceCfg[368].name)
			arg_219_1.choices_[2].txt.text = arg_219_1:FormatText(StoryChoiceCfg[369].name)
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play120042054(arg_219_1)
			end

			if arg_221_0 == 2 then
				arg_219_0:Play120042054(arg_219_1)
			end

			arg_219_1:RecordChoiceLog(120042053, 368, 369)
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			if arg_219_1.time_ >= 0 + 0.2 and arg_219_1.time_ < 0 + 0.2 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			local var_222_0 = arg_219_1.actors_["1184ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1184ui_story == nil then
				arg_219_1.var_.characterEffect1184ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_1 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 and not isNil(var_222_0) then
				if arg_219_1.var_.characterEffect1184ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_1)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1184ui_story then
				arg_219_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play120042054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 120042054
		arg_223_1.duration_ = 6.23

		local var_223_0 = {
			zh = 6.233,
			ja = 5.8
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
				arg_223_0:Play120042055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1184ui_story"]) and arg_223_1.var_.characterEffect1184ui_story == nil then
				arg_223_1.var_.characterEffect1184ui_story = arg_223_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1184ui_story"]) then
				if arg_223_1.var_.characterEffect1184ui_story and not isNil(arg_223_1.actors_["1184ui_story"]) then
					arg_223_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1184ui_story"]) and arg_223_1.var_.characterEffect1184ui_story then
				arg_223_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_226_2 = 0
			local var_226_3 = 0.775

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_4 = arg_223_1:GetWordFromCfg(120042054)
				local var_226_5 = arg_223_1:FormatText(var_226_4.content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 31 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 31)

				if (31 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 31)) > 0 and var_226_3 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042054", "story_v_out_120042.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_120042", "120042054", "story_v_out_120042.awb") / 1000

					if var_226_8 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_2
					end

					if var_226_4.prefab_name ~= "" and arg_223_1.actors_[var_226_4.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_4.prefab_name].transform, "story_v_out_120042", "120042054", "story_v_out_120042.awb")

						arg_223_1:RecordAudio("120042054", var_226_9)
						arg_223_1:RecordAudio("120042054", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_120042", "120042054", "story_v_out_120042.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_120042", "120042054", "story_v_out_120042.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_10 and arg_223_1.time_ < var_226_2 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play120042055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 120042055
		arg_227_1.duration_ = 5

		local var_227_0 = {
			zh = 3.166,
			ja = 5
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
				arg_227_0:Play120042056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.325

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(120042055)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 13 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 13)

				if (13 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 13)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042055", "story_v_out_120042.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042055", "story_v_out_120042.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_120042", "120042055", "story_v_out_120042.awb")

						arg_227_1:RecordAudio("120042055", var_230_6)
						arg_227_1:RecordAudio("120042055", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_120042", "120042055", "story_v_out_120042.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_120042", "120042055", "story_v_out_120042.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play120042056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 120042056
		arg_231_1.duration_ = 9

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play120042057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if arg_231_1.bgs_.ST37a == nil then
				local var_234_0 = Object.Instantiate(arg_231_1.paintGo_)

				var_234_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37a")
				var_234_0.name = "ST37a"
				var_234_0.transform.parent = arg_231_1.stage_.transform
				var_234_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.bgs_.ST37a = var_234_0
			end

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				local var_234_1 = arg_231_1.bgs_.ST37a

				arg_231_1.bgs_.ST37a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_234_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_2 = var_234_1:GetComponent("SpriteRenderer")

				if var_234_2 and var_234_2.sprite then
					local var_234_3 = 2 * (var_234_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_234_1.transform.localScale = Vector3.New(var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "ST37a" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_4 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_5 = 2

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_5 then
				local var_234_6 = Color.New(0, 0, 0)

				var_234_6.a = Mathf.Lerp(0, 1, (arg_231_1.time_ - var_234_4) / var_234_5)
				arg_231_1.mask_.color = var_234_6
			end

			if arg_231_1.time_ >= var_234_4 + var_234_5 and arg_231_1.time_ < var_234_4 + var_234_5 + arg_234_0 then
				local var_234_7 = Color.New(0, 0, 0)

				var_234_7.a = 1
				arg_231_1.mask_.color = var_234_7
			end

			local var_234_8 = 2

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_9 = 2

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_9 then
				local var_234_10 = Color.New(0, 0, 0)

				var_234_10.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_8) / var_234_9)
				arg_231_1.mask_.color = var_234_10
			end

			if arg_231_1.time_ >= var_234_8 + var_234_9 and arg_231_1.time_ < var_234_8 + var_234_9 + arg_234_0 then
				local var_234_11 = Color.New(0, 0, 0)

				arg_231_1.mask_.enabled = false
				var_234_11.a = 0
				arg_231_1.mask_.color = var_234_11
			end

			local var_234_12 = arg_231_1.actors_["1184ui_story"].transform

			if 1.966 < arg_231_1.time_ and arg_231_1.time_ <= 1.966 + arg_234_0 then
				arg_231_1.var_.moveOldPos1184ui_story = var_234_12.localPosition
			end

			local var_234_13 = 0.001

			if 1.966 <= arg_231_1.time_ and arg_231_1.time_ < 1.966 + var_234_13 then
				var_234_12.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 1.966) / var_234_13)
				var_234_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_12.position).x, (manager.ui.mainCamera.transform.position - var_234_12.position).y, (manager.ui.mainCamera.transform.position - var_234_12.position).z)
				var_234_12.localEulerAngles.z = 0
				var_234_12.localEulerAngles.x = 0
				var_234_12.localEulerAngles = var_234_12.localEulerAngles
			end

			if arg_231_1.time_ >= 1.966 + var_234_13 and arg_231_1.time_ < 1.966 + var_234_13 + arg_234_0 then
				var_234_12.localPosition = Vector3.New(0, 100, 0)
				var_234_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_12.position).x, (manager.ui.mainCamera.transform.position - var_234_12.position).y, (manager.ui.mainCamera.transform.position - var_234_12.position).z)
				var_234_12.localEulerAngles.z = 0
				var_234_12.localEulerAngles.x = 0
				var_234_12.localEulerAngles = var_234_12.localEulerAngles
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_14 = 4
			local var_234_15 = 1.35

			if 4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_16 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_16:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_17 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(120042056).content)

				arg_231_1.text_.text = var_234_17

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_19 = 54 <= 0 and var_234_15 or var_234_15 * (utf8.len(var_234_17) / 54)

				if (54 <= 0 and var_234_15 or var_234_15 * (utf8.len(var_234_17) / 54)) > 0 and var_234_15 < var_234_19 then
					arg_231_1.talkMaxDuration = var_234_19
					var_234_14 = var_234_14 + 0.3

					if var_234_19 + var_234_14 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_14
					end
				end

				arg_231_1.text_.text = var_234_17
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_20 = var_234_14 + 0.3
			local var_234_21 = math.max(var_234_15, arg_231_1.talkMaxDuration)

			if var_234_14 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_20 + var_234_21 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_20) / var_234_21

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_20 + var_234_21 and arg_231_1.time_ < var_234_20 + var_234_21 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play120042057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 120042057
		arg_237_1.duration_ = 4.03

		local var_237_0 = {
			zh = 4.033,
			ja = 3.766
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
				arg_237_0:Play120042058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if arg_237_1.actors_["10044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10044ui_story"))) then
				local var_240_0 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_237_1.stage_.transform)

				var_240_0.name = "10044ui_story"
				var_240_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["10044ui_story"] = var_240_0

				local var_240_1 = var_240_0:GetComponentInChildren(typeof(CharacterEffect))

				var_240_1.enabled = true

				local var_240_2 = GameObjectTools.GetOrAddComponent(var_240_0, typeof(DynamicBoneHelper))

				if var_240_2 then
					var_240_2:EnableDynamicBone(false)
				end

				arg_237_1:ShowWeapon(var_240_1.transform, false)

				arg_237_1.var_["10044ui_story" .. "Animator"] = var_240_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_237_1.var_["10044ui_story" .. "Animator"].applyRootMotion = true
				arg_237_1.var_["10044ui_story" .. "LipSync"] = var_240_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_240_3 = arg_237_1.actors_["10044ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10044ui_story = var_240_3.localPosition
			end

			local var_240_4 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				var_240_3.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10044ui_story, Vector3.New(-0.7, -0.72, -6.3), (arg_237_1.time_ - 0) / var_240_4)
				var_240_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_3.position).x, (manager.ui.mainCamera.transform.position - var_240_3.position).y, (manager.ui.mainCamera.transform.position - var_240_3.position).z)
				var_240_3.localEulerAngles.z = 0
				var_240_3.localEulerAngles.x = 0
				var_240_3.localEulerAngles = var_240_3.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				var_240_3.localPosition = Vector3.New(-0.7, -0.72, -6.3)
				var_240_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_3.position).x, (manager.ui.mainCamera.transform.position - var_240_3.position).y, (manager.ui.mainCamera.transform.position - var_240_3.position).z)
				var_240_3.localEulerAngles.z = 0
				var_240_3.localEulerAngles.x = 0
				var_240_3.localEulerAngles = var_240_3.localEulerAngles
			end

			local var_240_5 = arg_237_1.actors_["1071ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1071ui_story = var_240_5.localPosition
			end

			local var_240_6 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 then
				var_240_5.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_237_1.time_ - 0) / var_240_6)
				var_240_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_5.position).x, (manager.ui.mainCamera.transform.position - var_240_5.position).y, (manager.ui.mainCamera.transform.position - var_240_5.position).z)
				var_240_5.localEulerAngles.z = 0
				var_240_5.localEulerAngles.x = 0
				var_240_5.localEulerAngles = var_240_5.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 then
				var_240_5.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_240_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_5.position).x, (manager.ui.mainCamera.transform.position - var_240_5.position).y, (manager.ui.mainCamera.transform.position - var_240_5.position).z)
				var_240_5.localEulerAngles.z = 0
				var_240_5.localEulerAngles.x = 0
				var_240_5.localEulerAngles = var_240_5.localEulerAngles
			end

			local var_240_7 = arg_237_1.actors_["10044ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.characterEffect10044ui_story == nil then
				arg_237_1.var_.characterEffect10044ui_story = var_240_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_8 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_8 and not isNil(var_240_7) then
				if arg_237_1.var_.characterEffect10044ui_story and not isNil(var_240_7) then
					arg_237_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_8 and arg_237_1.time_ < 0 + var_240_8 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.characterEffect10044ui_story then
				arg_237_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_240_10 = arg_237_1.actors_["1071ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_10) and arg_237_1.var_.characterEffect1071ui_story == nil then
				arg_237_1.var_.characterEffect1071ui_story = var_240_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_11 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_11 and not isNil(var_240_10) then
				if arg_237_1.var_.characterEffect1071ui_story and not isNil(var_240_10) then
					arg_237_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_11)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_11 and arg_237_1.time_ < 0 + var_240_11 + arg_240_0 and not isNil(var_240_10) and arg_237_1.var_.characterEffect1071ui_story then
				arg_237_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_240_12 = 0
			local var_240_13 = 0.275

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_12 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_14 = arg_237_1:GetWordFromCfg(120042057)
				local var_240_15 = arg_237_1:FormatText(var_240_14.content)

				arg_237_1.text_.text = var_240_15

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_17 = 11 <= 0 and var_240_13 or var_240_13 * (utf8.len(var_240_15) / 11)

				if (11 <= 0 and var_240_13 or var_240_13 * (utf8.len(var_240_15) / 11)) > 0 and var_240_13 < var_240_17 then
					arg_237_1.talkMaxDuration = var_240_17

					if var_240_17 + var_240_12 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_17 + var_240_12
					end
				end

				arg_237_1.text_.text = var_240_15
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042057", "story_v_out_120042.awb") ~= 0 then
					local var_240_18 = manager.audio:GetVoiceLength("story_v_out_120042", "120042057", "story_v_out_120042.awb") / 1000

					if var_240_18 + var_240_12 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_18 + var_240_12
					end

					if var_240_14.prefab_name ~= "" and arg_237_1.actors_[var_240_14.prefab_name] ~= nil then
						local var_240_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_14.prefab_name].transform, "story_v_out_120042", "120042057", "story_v_out_120042.awb")

						arg_237_1:RecordAudio("120042057", var_240_19)
						arg_237_1:RecordAudio("120042057", var_240_19)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_120042", "120042057", "story_v_out_120042.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_120042", "120042057", "story_v_out_120042.awb")
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play120042058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 120042058
		arg_241_1.duration_ = 3

		local var_241_0 = {
			zh = 2.733,
			ja = 3
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
				arg_241_0:Play120042059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1071ui_story"]) and arg_241_1.var_.characterEffect1071ui_story == nil then
				arg_241_1.var_.characterEffect1071ui_story = arg_241_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1071ui_story"]) then
				if arg_241_1.var_.characterEffect1071ui_story and not isNil(arg_241_1.actors_["1071ui_story"]) then
					arg_241_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1071ui_story"]) and arg_241_1.var_.characterEffect1071ui_story then
				arg_241_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_244_2 = arg_241_1.actors_["10044ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect10044ui_story == nil then
				arg_241_1.var_.characterEffect10044ui_story = var_244_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_3 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.characterEffect10044ui_story and not isNil(var_244_2) then
					arg_241_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_3)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect10044ui_story then
				arg_241_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_244_4 = 0
			local var_244_5 = 0.2

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(120042058)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 8 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 8)

				if (8 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 8)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042058", "story_v_out_120042.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042058", "story_v_out_120042.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_out_120042", "120042058", "story_v_out_120042.awb")

						arg_241_1:RecordAudio("120042058", var_244_11)
						arg_241_1:RecordAudio("120042058", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_120042", "120042058", "story_v_out_120042.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_120042", "120042058", "story_v_out_120042.awb")
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
	Play120042059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 120042059
		arg_245_1.duration_ = 4.13

		local var_245_0 = {
			zh = 4.133,
			ja = 3.7
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
				arg_245_0:Play120042060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1071ui_story"]) and arg_245_1.var_.characterEffect1071ui_story == nil then
				arg_245_1.var_.characterEffect1071ui_story = arg_245_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1071ui_story"]) then
				if arg_245_1.var_.characterEffect1071ui_story and not isNil(arg_245_1.actors_["1071ui_story"]) then
					arg_245_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1071ui_story"]) and arg_245_1.var_.characterEffect1071ui_story then
				arg_245_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_248_1 = arg_245_1.actors_["10044ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect10044ui_story == nil then
				arg_245_1.var_.characterEffect10044ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect10044ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect10044ui_story then
				arg_245_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_248_4 = 0
			local var_248_5 = 0.375

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(120042059)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 15 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 15)

				if (15 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 15)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042059", "story_v_out_120042.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042059", "story_v_out_120042.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_out_120042", "120042059", "story_v_out_120042.awb")

						arg_245_1:RecordAudio("120042059", var_248_11)
						arg_245_1:RecordAudio("120042059", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_120042", "120042059", "story_v_out_120042.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_120042", "120042059", "story_v_out_120042.awb")
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
	Play120042060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 120042060
		arg_249_1.duration_ = 3

		local var_249_0 = {
			zh = 2.666,
			ja = 3
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
				arg_249_0:Play120042061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["10044ui_story"]) and arg_249_1.var_.characterEffect10044ui_story == nil then
				arg_249_1.var_.characterEffect10044ui_story = arg_249_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["10044ui_story"]) then
				if arg_249_1.var_.characterEffect10044ui_story and not isNil(arg_249_1.actors_["10044ui_story"]) then
					arg_249_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["10044ui_story"]) and arg_249_1.var_.characterEffect10044ui_story then
				arg_249_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.25

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(120042060)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 10 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 10)

				if (10 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 10)) > 0 and var_252_2 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042060", "story_v_out_120042.awb") ~= 0 then
					local var_252_7 = manager.audio:GetVoiceLength("story_v_out_120042", "120042060", "story_v_out_120042.awb") / 1000

					if var_252_7 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_1
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_120042", "120042060", "story_v_out_120042.awb")

						arg_249_1:RecordAudio("120042060", var_252_8)
						arg_249_1:RecordAudio("120042060", var_252_8)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_120042", "120042060", "story_v_out_120042.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_120042", "120042060", "story_v_out_120042.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_9 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_9 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_9

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_9 and arg_249_1.time_ < var_252_1 + var_252_9 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play120042061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 120042061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play120042062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10044ui_story = arg_253_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10044ui_story"].transform.position).z)
				arg_253_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["10044ui_story"].transform.localEulerAngles = arg_253_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10044ui_story"].transform.position).z)
				arg_253_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["10044ui_story"].transform.localEulerAngles = arg_253_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1071ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1071ui_story = var_256_1.localPosition
			end

			local var_256_2 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 then
				var_256_1.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_2)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 then
				var_256_1.localPosition = Vector3.New(0, 100, 0)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			local var_256_3 = 0
			local var_256_4 = 0.825

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_5 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(120042061).content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 33 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 33)

				if (33 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 33)) > 0 and var_256_4 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_3 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_3
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_4, arg_253_1.talkMaxDuration)

			if var_256_3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_3 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_3) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_3 + var_256_8 and arg_253_1.time_ < var_256_3 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play120042062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 120042062
		arg_257_1.duration_ = 4.73

		local var_257_0 = {
			zh = 2.7,
			ja = 4.733
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
				arg_257_0:Play120042063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1071ui_story = arg_257_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).z)
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles = arg_257_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_257_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1071ui_story"].transform.position).z)
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1071ui_story"].transform.localEulerAngles = arg_257_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1069ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1069ui_story = var_260_1.localPosition
			end

			local var_260_2 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 then
				var_260_1.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_257_1.time_ - 0) / var_260_2)
				var_260_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_1.position).x, (manager.ui.mainCamera.transform.position - var_260_1.position).y, (manager.ui.mainCamera.transform.position - var_260_1.position).z)
				var_260_1.localEulerAngles.z = 0
				var_260_1.localEulerAngles.x = 0
				var_260_1.localEulerAngles = var_260_1.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 then
				var_260_1.localPosition = Vector3.New(0.7, -1, -6)
				var_260_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_1.position).x, (manager.ui.mainCamera.transform.position - var_260_1.position).y, (manager.ui.mainCamera.transform.position - var_260_1.position).z)
				var_260_1.localEulerAngles.z = 0
				var_260_1.localEulerAngles.x = 0
				var_260_1.localEulerAngles = var_260_1.localEulerAngles
			end

			local var_260_3 = arg_257_1.actors_["1071ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_3) and arg_257_1.var_.characterEffect1071ui_story == nil then
				arg_257_1.var_.characterEffect1071ui_story = var_260_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_4 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 and not isNil(var_260_3) then
				if arg_257_1.var_.characterEffect1071ui_story and not isNil(var_260_3) then
					arg_257_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_4)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 and not isNil(var_260_3) and arg_257_1.var_.characterEffect1071ui_story then
				arg_257_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_260_5 = arg_257_1.actors_["1069ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.characterEffect1069ui_story == nil then
				arg_257_1.var_.characterEffect1069ui_story = var_260_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_6 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_6 and not isNil(var_260_5) then
				if arg_257_1.var_.characterEffect1069ui_story and not isNil(var_260_5) then
					arg_257_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_6 and arg_257_1.time_ < 0 + var_260_6 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.characterEffect1069ui_story then
				arg_257_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_260_8 = 0
			local var_260_9 = 0.35

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(120042062)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 14 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 14)

				if (14 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 14)) > 0 and var_260_9 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042062", "story_v_out_120042.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_120042", "120042062", "story_v_out_120042.awb") / 1000

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_120042", "120042062", "story_v_out_120042.awb")

						arg_257_1:RecordAudio("120042062", var_260_15)
						arg_257_1:RecordAudio("120042062", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_120042", "120042062", "story_v_out_120042.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_120042", "120042062", "story_v_out_120042.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_16 and arg_257_1.time_ < var_260_8 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play120042063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 120042063
		arg_261_1.duration_ = 11.63

		local var_261_0 = {
			zh = 11.633,
			ja = 10.2
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
				arg_261_0:Play120042064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1069ui_story"]) and arg_261_1.var_.characterEffect1069ui_story == nil then
				arg_261_1.var_.characterEffect1069ui_story = arg_261_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1069ui_story"]) then
				if arg_261_1.var_.characterEffect1069ui_story and not isNil(arg_261_1.actors_["1069ui_story"]) then
					arg_261_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1069ui_story"]) and arg_261_1.var_.characterEffect1069ui_story then
				arg_261_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_264_1 = arg_261_1.actors_["1071ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1071ui_story == nil then
				arg_261_1.var_.characterEffect1071ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1071ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1071ui_story then
				arg_261_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_264_4 = 0
			local var_264_5 = 1.15

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(120042063)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 46 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 46)

				if (46 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 46)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042063", "story_v_out_120042.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042063", "story_v_out_120042.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_120042", "120042063", "story_v_out_120042.awb")

						arg_261_1:RecordAudio("120042063", var_264_11)
						arg_261_1:RecordAudio("120042063", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_120042", "120042063", "story_v_out_120042.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_120042", "120042063", "story_v_out_120042.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play120042064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 120042064
		arg_265_1.duration_ = 14.17

		local var_265_0 = {
			zh = 9.433,
			ja = 14.166
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
				arg_265_0:Play120042065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1069ui_story = arg_265_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1069ui_story"].transform.position).z)
				arg_265_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1069ui_story"].transform.localEulerAngles = arg_265_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1069ui_story"].transform.position).z)
				arg_265_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1069ui_story"].transform.localEulerAngles = arg_265_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_268_1 = "1075ui_story"

			if arg_265_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_268_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_265_1.stage_.transform)

				var_268_2.name = var_268_1
				var_268_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_[var_268_1] = var_268_2

				local var_268_3 = var_268_2:GetComponentInChildren(typeof(CharacterEffect))

				var_268_3.enabled = true

				local var_268_4 = GameObjectTools.GetOrAddComponent(var_268_2, typeof(DynamicBoneHelper))

				if var_268_4 then
					var_268_4:EnableDynamicBone(false)
				end

				arg_265_1:ShowWeapon(var_268_3.transform, false)

				arg_265_1.var_[var_268_1 .. "Animator"] = var_268_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_265_1.var_[var_268_1 .. "Animator"].applyRootMotion = true
				arg_265_1.var_[var_268_1 .. "LipSync"] = var_268_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_268_5 = arg_265_1.actors_["1075ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1075ui_story = var_268_5.localPosition
			end

			local var_268_6 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_6 then
				var_268_5.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_265_1.time_ - 0) / var_268_6)
				var_268_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_5.position).x, (manager.ui.mainCamera.transform.position - var_268_5.position).y, (manager.ui.mainCamera.transform.position - var_268_5.position).z)
				var_268_5.localEulerAngles.z = 0
				var_268_5.localEulerAngles.x = 0
				var_268_5.localEulerAngles = var_268_5.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_6 and arg_265_1.time_ < 0 + var_268_6 + arg_268_0 then
				var_268_5.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_268_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_5.position).x, (manager.ui.mainCamera.transform.position - var_268_5.position).y, (manager.ui.mainCamera.transform.position - var_268_5.position).z)
				var_268_5.localEulerAngles.z = 0
				var_268_5.localEulerAngles.x = 0
				var_268_5.localEulerAngles = var_268_5.localEulerAngles
			end

			local var_268_7 = arg_265_1.actors_["1071ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.characterEffect1071ui_story == nil then
				arg_265_1.var_.characterEffect1071ui_story = var_268_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_8 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_8 and not isNil(var_268_7) then
				if arg_265_1.var_.characterEffect1071ui_story and not isNil(var_268_7) then
					arg_265_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_8)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_8 and arg_265_1.time_ < 0 + var_268_8 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.characterEffect1071ui_story then
				arg_265_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_268_9 = arg_265_1.actors_["1075ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect1075ui_story == nil then
				arg_265_1.var_.characterEffect1075ui_story = var_268_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_10 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_10 and not isNil(var_268_9) then
				if arg_265_1.var_.characterEffect1075ui_story and not isNil(var_268_9) then
					arg_265_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_10 and arg_265_1.time_ < 0 + var_268_10 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect1075ui_story then
				arg_265_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_268_12 = 0
			local var_268_13 = 1.025

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_14 = arg_265_1:GetWordFromCfg(120042064)
				local var_268_15 = arg_265_1:FormatText(var_268_14.content)

				arg_265_1.text_.text = var_268_15

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_17 = 41 <= 0 and var_268_13 or var_268_13 * (utf8.len(var_268_15) / 41)

				if (41 <= 0 and var_268_13 or var_268_13 * (utf8.len(var_268_15) / 41)) > 0 and var_268_13 < var_268_17 then
					arg_265_1.talkMaxDuration = var_268_17

					if var_268_17 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_17 + var_268_12
					end
				end

				arg_265_1.text_.text = var_268_15
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042064", "story_v_out_120042.awb") ~= 0 then
					local var_268_18 = manager.audio:GetVoiceLength("story_v_out_120042", "120042064", "story_v_out_120042.awb") / 1000

					if var_268_18 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_18 + var_268_12
					end

					if var_268_14.prefab_name ~= "" and arg_265_1.actors_[var_268_14.prefab_name] ~= nil then
						local var_268_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_14.prefab_name].transform, "story_v_out_120042", "120042064", "story_v_out_120042.awb")

						arg_265_1:RecordAudio("120042064", var_268_19)
						arg_265_1:RecordAudio("120042064", var_268_19)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_120042", "120042064", "story_v_out_120042.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_120042", "120042064", "story_v_out_120042.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_20 = math.max(var_268_13, arg_265_1.talkMaxDuration)

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_20 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_12) / var_268_20

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_12 + var_268_20 and arg_265_1.time_ < var_268_12 + var_268_20 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play120042065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 120042065
		arg_269_1.duration_ = 11.13

		local var_269_0 = {
			zh = 11.133,
			ja = 10.266
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play120042066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1075ui_story"]) and arg_269_1.var_.characterEffect1075ui_story == nil then
				arg_269_1.var_.characterEffect1075ui_story = arg_269_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1075ui_story"]) then
				if arg_269_1.var_.characterEffect1075ui_story and not isNil(arg_269_1.actors_["1075ui_story"]) then
					arg_269_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1075ui_story"]) and arg_269_1.var_.characterEffect1075ui_story then
				arg_269_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_272_1 = arg_269_1.actors_["1071ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1071ui_story == nil then
				arg_269_1.var_.characterEffect1071ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1071ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1071ui_story then
				arg_269_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action432")
			end

			local var_272_4 = 0
			local var_272_5 = 0.975

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(120042065)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 39 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 39)

				if (39 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 39)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042065", "story_v_out_120042.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042065", "story_v_out_120042.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_120042", "120042065", "story_v_out_120042.awb")

						arg_269_1:RecordAudio("120042065", var_272_11)
						arg_269_1:RecordAudio("120042065", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_120042", "120042065", "story_v_out_120042.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_120042", "120042065", "story_v_out_120042.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play120042066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 120042066
		arg_273_1.duration_ = 10.2

		local var_273_0 = {
			zh = 10.2,
			ja = 6.7
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
				arg_273_0:Play120042067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 1.05

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(120042066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 42 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 42)

				if (42 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 42)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042066", "story_v_out_120042.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042066", "story_v_out_120042.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_120042", "120042066", "story_v_out_120042.awb")

						arg_273_1:RecordAudio("120042066", var_276_6)
						arg_273_1:RecordAudio("120042066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_120042", "120042066", "story_v_out_120042.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_120042", "120042066", "story_v_out_120042.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play120042067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 120042067
		arg_277_1.duration_ = 3.47

		local var_277_0 = {
			zh = 2.1,
			ja = 3.466
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
				arg_277_0:Play120042068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1071ui_story"]) and arg_277_1.var_.characterEffect1071ui_story == nil then
				arg_277_1.var_.characterEffect1071ui_story = arg_277_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1071ui_story"]) then
				if arg_277_1.var_.characterEffect1071ui_story and not isNil(arg_277_1.actors_["1071ui_story"]) then
					arg_277_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1071ui_story"]) and arg_277_1.var_.characterEffect1071ui_story then
				arg_277_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_280_1 = arg_277_1.actors_["1075ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1075ui_story == nil then
				arg_277_1.var_.characterEffect1075ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1075ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1075ui_story then
				arg_277_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_280_4 = 0
			local var_280_5 = 0.3

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(120042067)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 12 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 12)

				if (12 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 12)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042067", "story_v_out_120042.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042067", "story_v_out_120042.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_120042", "120042067", "story_v_out_120042.awb")

						arg_277_1:RecordAudio("120042067", var_280_11)
						arg_277_1:RecordAudio("120042067", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_120042", "120042067", "story_v_out_120042.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_120042", "120042067", "story_v_out_120042.awb")
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
	Play120042068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 120042068
		arg_281_1.duration_ = 5.33

		local var_281_0 = {
			zh = 5.333,
			ja = 3.066
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
				arg_281_0:Play120042069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1071ui_story"]) and arg_281_1.var_.characterEffect1071ui_story == nil then
				arg_281_1.var_.characterEffect1071ui_story = arg_281_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1071ui_story"]) then
				if arg_281_1.var_.characterEffect1071ui_story and not isNil(arg_281_1.actors_["1071ui_story"]) then
					arg_281_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1071ui_story"]) and arg_281_1.var_.characterEffect1071ui_story then
				arg_281_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_284_2 = arg_281_1.actors_["1075ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1075ui_story == nil then
				arg_281_1.var_.characterEffect1075ui_story = var_284_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.characterEffect1075ui_story and not isNil(var_284_2) then
					arg_281_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_3)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1075ui_story then
				arg_281_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action425")
			end

			local var_284_4 = 0
			local var_284_5 = 0.475

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(120042068)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 19 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 19)

				if (19 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 19)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042068", "story_v_out_120042.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042068", "story_v_out_120042.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_out_120042", "120042068", "story_v_out_120042.awb")

						arg_281_1:RecordAudio("120042068", var_284_11)
						arg_281_1:RecordAudio("120042068", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_120042", "120042068", "story_v_out_120042.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_120042", "120042068", "story_v_out_120042.awb")
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
	Play120042069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 120042069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play120042070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1071ui_story"]) and arg_285_1.var_.characterEffect1071ui_story == nil then
				arg_285_1.var_.characterEffect1071ui_story = arg_285_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1071ui_story"]) then
				if arg_285_1.var_.characterEffect1071ui_story and not isNil(arg_285_1.actors_["1071ui_story"]) then
					arg_285_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1071ui_story"]) and arg_285_1.var_.characterEffect1071ui_story then
				arg_285_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 0.7

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(120042069).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 28 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 28)

				if (28 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 28)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play120042070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 120042070
		arg_289_1.duration_ = 8.97

		local var_289_0 = {
			zh = 3.8,
			ja = 8.966
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play120042071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1071ui_story"]) and arg_289_1.var_.characterEffect1071ui_story == nil then
				arg_289_1.var_.characterEffect1071ui_story = arg_289_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1071ui_story"]) then
				if arg_289_1.var_.characterEffect1071ui_story and not isNil(arg_289_1.actors_["1071ui_story"]) then
					arg_289_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1071ui_story"]) and arg_289_1.var_.characterEffect1071ui_story then
				arg_289_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_292_2 = 0
			local var_292_3 = 0.275

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:GetWordFromCfg(120042070)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 11 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 11)

				if (11 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 11)) > 0 and var_292_3 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042070", "story_v_out_120042.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_120042", "120042070", "story_v_out_120042.awb") / 1000

					if var_292_8 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_2
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_out_120042", "120042070", "story_v_out_120042.awb")

						arg_289_1:RecordAudio("120042070", var_292_9)
						arg_289_1:RecordAudio("120042070", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_120042", "120042070", "story_v_out_120042.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_120042", "120042070", "story_v_out_120042.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_10 and arg_289_1.time_ < var_292_2 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play120042071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 120042071
		arg_293_1.duration_ = 8.07

		local var_293_0 = {
			zh = 2.566,
			ja = 8.066
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play120042072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1075ui_story = arg_293_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1075ui_story"].transform.position).z)
				arg_293_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1075ui_story"].transform.localEulerAngles = arg_293_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1075ui_story"].transform.position).z)
				arg_293_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1075ui_story"].transform.localEulerAngles = arg_293_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1069ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1069ui_story = var_296_1.localPosition
			end

			local var_296_2 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 then
				var_296_1.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_293_1.time_ - 0) / var_296_2)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 then
				var_296_1.localPosition = Vector3.New(0.7, -1, -6)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_296_3 = arg_293_1.actors_["1069ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_3) and arg_293_1.var_.characterEffect1069ui_story == nil then
				arg_293_1.var_.characterEffect1069ui_story = var_296_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_4 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 and not isNil(var_296_3) then
				if arg_293_1.var_.characterEffect1069ui_story and not isNil(var_296_3) then
					arg_293_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 and not isNil(var_296_3) and arg_293_1.var_.characterEffect1069ui_story then
				arg_293_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_296_6 = arg_293_1.actors_["1071ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect1071ui_story == nil then
				arg_293_1.var_.characterEffect1071ui_story = var_296_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_7 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 and not isNil(var_296_6) then
				if arg_293_1.var_.characterEffect1071ui_story and not isNil(var_296_6) then
					arg_293_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_7)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect1071ui_story then
				arg_293_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_296_8 = 0
			local var_296_9 = 0.3

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_10 = arg_293_1:GetWordFromCfg(120042071)
				local var_296_11 = arg_293_1:FormatText(var_296_10.content)

				arg_293_1.text_.text = var_296_11

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_13 = 12 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 12)

				if (12 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 12)) > 0 and var_296_9 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_8
					end
				end

				arg_293_1.text_.text = var_296_11
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042071", "story_v_out_120042.awb") ~= 0 then
					local var_296_14 = manager.audio:GetVoiceLength("story_v_out_120042", "120042071", "story_v_out_120042.awb") / 1000

					if var_296_14 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_8
					end

					if var_296_10.prefab_name ~= "" and arg_293_1.actors_[var_296_10.prefab_name] ~= nil then
						local var_296_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_10.prefab_name].transform, "story_v_out_120042", "120042071", "story_v_out_120042.awb")

						arg_293_1:RecordAudio("120042071", var_296_15)
						arg_293_1:RecordAudio("120042071", var_296_15)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_120042", "120042071", "story_v_out_120042.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_120042", "120042071", "story_v_out_120042.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_16 = math.max(var_296_9, arg_293_1.talkMaxDuration)

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_16 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_8) / var_296_16

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_8 + var_296_16 and arg_293_1.time_ < var_296_8 + var_296_16 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play120042072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 120042072
		arg_297_1.duration_ = 5.8

		local var_297_0 = {
			zh = 5.8,
			ja = 3.366
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play120042073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1069ui_story"]) and arg_297_1.var_.characterEffect1069ui_story == nil then
				arg_297_1.var_.characterEffect1069ui_story = arg_297_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1069ui_story"]) then
				if arg_297_1.var_.characterEffect1069ui_story and not isNil(arg_297_1.actors_["1069ui_story"]) then
					arg_297_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1069ui_story"]) and arg_297_1.var_.characterEffect1069ui_story then
				arg_297_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_300_1 = arg_297_1.actors_["1071ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1071ui_story == nil then
				arg_297_1.var_.characterEffect1071ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect1071ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1071ui_story then
				arg_297_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_300_4 = 0
			local var_300_5 = 0.4

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(120042072)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 16 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 16)

				if (16 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 16)) > 0 and var_300_5 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042072", "story_v_out_120042.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042072", "story_v_out_120042.awb") / 1000

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end

					if var_300_6.prefab_name ~= "" and arg_297_1.actors_[var_300_6.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_6.prefab_name].transform, "story_v_out_120042", "120042072", "story_v_out_120042.awb")

						arg_297_1:RecordAudio("120042072", var_300_11)
						arg_297_1:RecordAudio("120042072", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_120042", "120042072", "story_v_out_120042.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_120042", "120042072", "story_v_out_120042.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_12 and arg_297_1.time_ < var_300_4 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play120042073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 120042073
		arg_301_1.duration_ = 11.77

		local var_301_0 = {
			zh = 11.766,
			ja = 8.5
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
				arg_301_0:Play120042074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 1.3

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:GetWordFromCfg(120042073)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 52 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 52)

				if (52 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 52)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042073", "story_v_out_120042.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042073", "story_v_out_120042.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_120042", "120042073", "story_v_out_120042.awb")

						arg_301_1:RecordAudio("120042073", var_304_6)
						arg_301_1:RecordAudio("120042073", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_120042", "120042073", "story_v_out_120042.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_120042", "120042073", "story_v_out_120042.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play120042074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 120042074
		arg_305_1.duration_ = 5

		local var_305_0 = {
			zh = 4.2,
			ja = 5
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play120042075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1071ui_story"]) and arg_305_1.var_.characterEffect1071ui_story == nil then
				arg_305_1.var_.characterEffect1071ui_story = arg_305_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1071ui_story"]) then
				if arg_305_1.var_.characterEffect1071ui_story and not isNil(arg_305_1.actors_["1071ui_story"]) then
					arg_305_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1071ui_story"]) and arg_305_1.var_.characterEffect1071ui_story then
				arg_305_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_308_1 = arg_305_1.actors_["1069ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1069ui_story == nil then
				arg_305_1.var_.characterEffect1069ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1069ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1069ui_story then
				arg_305_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action423")
			end

			local var_308_4 = 0
			local var_308_5 = 0.65

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_6 = arg_305_1:GetWordFromCfg(120042074)
				local var_308_7 = arg_305_1:FormatText(var_308_6.content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 26 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 26)

				if (26 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 26)) > 0 and var_308_5 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042074", "story_v_out_120042.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042074", "story_v_out_120042.awb") / 1000

					if var_308_10 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_4
					end

					if var_308_6.prefab_name ~= "" and arg_305_1.actors_[var_308_6.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_6.prefab_name].transform, "story_v_out_120042", "120042074", "story_v_out_120042.awb")

						arg_305_1:RecordAudio("120042074", var_308_11)
						arg_305_1:RecordAudio("120042074", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_120042", "120042074", "story_v_out_120042.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_120042", "120042074", "story_v_out_120042.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_12 = math.max(var_308_5, arg_305_1.talkMaxDuration)

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_12 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_4) / var_308_12

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_4 + var_308_12 and arg_305_1.time_ < var_308_4 + var_308_12 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play120042075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 120042075
		arg_309_1.duration_ = 6.93

		local var_309_0 = {
			zh = 6.233,
			ja = 6.933
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
				arg_309_0:Play120042076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1071ui_story"]) and arg_309_1.var_.characterEffect1071ui_story == nil then
				arg_309_1.var_.characterEffect1071ui_story = arg_309_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1071ui_story"]) then
				if arg_309_1.var_.characterEffect1071ui_story and not isNil(arg_309_1.actors_["1071ui_story"]) then
					arg_309_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1071ui_story"]) and arg_309_1.var_.characterEffect1071ui_story then
				arg_309_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_312_2 = arg_309_1.actors_["1069ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect1069ui_story == nil then
				arg_309_1.var_.characterEffect1069ui_story = var_312_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_3 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.characterEffect1069ui_story and not isNil(var_312_2) then
					arg_309_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_3)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect1069ui_story then
				arg_309_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_312_4 = 0
			local var_312_5 = 0.725

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(120042075)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 29 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 29)

				if (29 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 29)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042075", "story_v_out_120042.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042075", "story_v_out_120042.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_120042", "120042075", "story_v_out_120042.awb")

						arg_309_1:RecordAudio("120042075", var_312_11)
						arg_309_1:RecordAudio("120042075", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_120042", "120042075", "story_v_out_120042.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_120042", "120042075", "story_v_out_120042.awb")
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

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play120042076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 120042076
		arg_313_1.duration_ = 6.9

		local var_313_0 = {
			zh = 5.5,
			ja = 6.9
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play120042077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.65

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:GetWordFromCfg(120042076)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 26 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 26)

				if (26 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 26)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042076", "story_v_out_120042.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042076", "story_v_out_120042.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_out_120042", "120042076", "story_v_out_120042.awb")

						arg_313_1:RecordAudio("120042076", var_316_6)
						arg_313_1:RecordAudio("120042076", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_120042", "120042076", "story_v_out_120042.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_120042", "120042076", "story_v_out_120042.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play120042077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 120042077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play120042078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1069ui_story = arg_317_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1069ui_story"].transform.position).z)
				arg_317_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1069ui_story"].transform.localEulerAngles = arg_317_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1069ui_story"].transform.position).z)
				arg_317_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1069ui_story"].transform.localEulerAngles = arg_317_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1071ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1071ui_story = var_320_1.localPosition
			end

			local var_320_2 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 then
				var_320_1.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_2)
				var_320_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_1.position).x, (manager.ui.mainCamera.transform.position - var_320_1.position).y, (manager.ui.mainCamera.transform.position - var_320_1.position).z)
				var_320_1.localEulerAngles.z = 0
				var_320_1.localEulerAngles.x = 0
				var_320_1.localEulerAngles = var_320_1.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 then
				var_320_1.localPosition = Vector3.New(0, 100, 0)
				var_320_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_1.position).x, (manager.ui.mainCamera.transform.position - var_320_1.position).y, (manager.ui.mainCamera.transform.position - var_320_1.position).z)
				var_320_1.localEulerAngles.z = 0
				var_320_1.localEulerAngles.x = 0
				var_320_1.localEulerAngles = var_320_1.localEulerAngles
			end

			local var_320_3 = 0
			local var_320_4 = 0.9

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_3 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_5 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(120042077).content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 36 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 36)

				if (36 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 36)) > 0 and var_320_4 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_3 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_3
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_4, arg_317_1.talkMaxDuration)

			if var_320_3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_3 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_3) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_3 + var_320_8 and arg_317_1.time_ < var_320_3 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play120042078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 120042078
		arg_321_1.duration_ = 5.87

		local var_321_0 = {
			zh = 5.866,
			ja = 5.533
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play120042079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1071ui_story"]) and arg_321_1.var_.characterEffect1071ui_story == nil then
				arg_321_1.var_.characterEffect1071ui_story = arg_321_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1071ui_story"]) then
				if arg_321_1.var_.characterEffect1071ui_story and not isNil(arg_321_1.actors_["1071ui_story"]) then
					arg_321_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1071ui_story"]) and arg_321_1.var_.characterEffect1071ui_story then
				arg_321_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_324_2 = arg_321_1.actors_["1071ui_story"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1071ui_story = var_324_2.localPosition
			end

			local var_324_3 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_3 then
				var_324_2.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_321_1.time_ - 0) / var_324_3)
				var_324_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_2.position).x, (manager.ui.mainCamera.transform.position - var_324_2.position).y, (manager.ui.mainCamera.transform.position - var_324_2.position).z)
				var_324_2.localEulerAngles.z = 0
				var_324_2.localEulerAngles.x = 0
				var_324_2.localEulerAngles = var_324_2.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_3 and arg_321_1.time_ < 0 + var_324_3 + arg_324_0 then
				var_324_2.localPosition = Vector3.New(0, -1.05, -6.2)
				var_324_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_2.position).x, (manager.ui.mainCamera.transform.position - var_324_2.position).y, (manager.ui.mainCamera.transform.position - var_324_2.position).z)
				var_324_2.localEulerAngles.z = 0
				var_324_2.localEulerAngles.x = 0
				var_324_2.localEulerAngles = var_324_2.localEulerAngles
			end

			local var_324_4 = 0
			local var_324_5 = 0.4

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(120042078)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 16 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 16)

				if (16 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 16)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042078", "story_v_out_120042.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042078", "story_v_out_120042.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_out_120042", "120042078", "story_v_out_120042.awb")

						arg_321_1:RecordAudio("120042078", var_324_11)
						arg_321_1:RecordAudio("120042078", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_120042", "120042078", "story_v_out_120042.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_120042", "120042078", "story_v_out_120042.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_12 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_12 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_12

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_12 and arg_321_1.time_ < var_324_4 + var_324_12 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play120042079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 120042079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play120042080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1071ui_story"]) and arg_325_1.var_.characterEffect1071ui_story == nil then
				arg_325_1.var_.characterEffect1071ui_story = arg_325_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1071ui_story"]) then
				if arg_325_1.var_.characterEffect1071ui_story and not isNil(arg_325_1.actors_["1071ui_story"]) then
					arg_325_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1071ui_story"]) and arg_325_1.var_.characterEffect1071ui_story then
				arg_325_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_328_1 = 0
			local var_328_2 = 1.575

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_3 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(120042079).content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 63 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 63)

				if (63 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 63)) > 0 and var_328_2 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_6 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_6 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_6

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_6 and arg_325_1.time_ < var_328_1 + var_328_6 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play120042080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 120042080
		arg_329_1.duration_ = 7.5

		local var_329_0 = {
			zh = 6.833,
			ja = 7.5
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
				arg_329_0:Play120042081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1071ui_story"]) and arg_329_1.var_.characterEffect1071ui_story == nil then
				arg_329_1.var_.characterEffect1071ui_story = arg_329_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1071ui_story"]) then
				if arg_329_1.var_.characterEffect1071ui_story and not isNil(arg_329_1.actors_["1071ui_story"]) then
					arg_329_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1071ui_story"]) and arg_329_1.var_.characterEffect1071ui_story then
				arg_329_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_332_2 = 0
			local var_332_3 = 0.575

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_2 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_4 = arg_329_1:GetWordFromCfg(120042080)
				local var_332_5 = arg_329_1:FormatText(var_332_4.content)

				arg_329_1.text_.text = var_332_5

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_7 = 23 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_5) / 23)

				if (23 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_5) / 23)) > 0 and var_332_3 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_2
					end
				end

				arg_329_1.text_.text = var_332_5
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042080", "story_v_out_120042.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_out_120042", "120042080", "story_v_out_120042.awb") / 1000

					if var_332_8 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_2
					end

					if var_332_4.prefab_name ~= "" and arg_329_1.actors_[var_332_4.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_4.prefab_name].transform, "story_v_out_120042", "120042080", "story_v_out_120042.awb")

						arg_329_1:RecordAudio("120042080", var_332_9)
						arg_329_1:RecordAudio("120042080", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_120042", "120042080", "story_v_out_120042.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_120042", "120042080", "story_v_out_120042.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_3, arg_329_1.talkMaxDuration)

			if var_332_2 <= arg_329_1.time_ and arg_329_1.time_ < var_332_2 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_2) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_2 + var_332_10 and arg_329_1.time_ < var_332_2 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play120042081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 120042081
		arg_333_1.duration_ = 3.57

		local var_333_0 = {
			zh = 3.566,
			ja = 3.266
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play120042082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1071ui_story"]) and arg_333_1.var_.characterEffect1071ui_story == nil then
				arg_333_1.var_.characterEffect1071ui_story = arg_333_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1071ui_story"]) then
				if arg_333_1.var_.characterEffect1071ui_story and not isNil(arg_333_1.actors_["1071ui_story"]) then
					arg_333_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1071ui_story"]) and arg_333_1.var_.characterEffect1071ui_story then
				arg_333_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_336_1 = 0
			local var_336_2 = 0.275

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10044")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:GetWordFromCfg(120042081)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_6 = 11 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_4) / 11)

				if (11 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_4) / 11)) > 0 and var_336_2 < var_336_6 then
					arg_333_1.talkMaxDuration = var_336_6

					if var_336_6 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_6 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042081", "story_v_out_120042.awb") ~= 0 then
					local var_336_7 = manager.audio:GetVoiceLength("story_v_out_120042", "120042081", "story_v_out_120042.awb") / 1000

					if var_336_7 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_1
					end

					if var_336_3.prefab_name ~= "" and arg_333_1.actors_[var_336_3.prefab_name] ~= nil then
						local var_336_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_3.prefab_name].transform, "story_v_out_120042", "120042081", "story_v_out_120042.awb")

						arg_333_1:RecordAudio("120042081", var_336_8)
						arg_333_1:RecordAudio("120042081", var_336_8)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_120042", "120042081", "story_v_out_120042.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_120042", "120042081", "story_v_out_120042.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_9 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_9 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_9

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_9 and arg_333_1.time_ < var_336_1 + var_336_9 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play120042082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 120042082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play120042083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.6

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

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(120042082).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 24 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 24)

				if (24 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 24)) > 0 and var_340_0 < var_340_3 then
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
	Play120042083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 120042083
		arg_341_1.duration_ = 8.37

		local var_341_0 = {
			zh = 4.3,
			ja = 8.366
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
				arg_341_0:Play120042084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1071ui_story"]) and arg_341_1.var_.characterEffect1071ui_story == nil then
				arg_341_1.var_.characterEffect1071ui_story = arg_341_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1071ui_story"]) then
				if arg_341_1.var_.characterEffect1071ui_story and not isNil(arg_341_1.actors_["1071ui_story"]) then
					arg_341_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1071ui_story"]) and arg_341_1.var_.characterEffect1071ui_story then
				arg_341_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_344_2 = 0
			local var_344_3 = 0.5

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_4 = arg_341_1:GetWordFromCfg(120042083)
				local var_344_5 = arg_341_1:FormatText(var_344_4.content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 20 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 20)

				if (20 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 20)) > 0 and var_344_3 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_2
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042083", "story_v_out_120042.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_120042", "120042083", "story_v_out_120042.awb") / 1000

					if var_344_8 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_2
					end

					if var_344_4.prefab_name ~= "" and arg_341_1.actors_[var_344_4.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_4.prefab_name].transform, "story_v_out_120042", "120042083", "story_v_out_120042.awb")

						arg_341_1:RecordAudio("120042083", var_344_9)
						arg_341_1:RecordAudio("120042083", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_120042", "120042083", "story_v_out_120042.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_120042", "120042083", "story_v_out_120042.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_3, arg_341_1.talkMaxDuration)

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_2) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_2 + var_344_10 and arg_341_1.time_ < var_344_2 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play120042084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 120042084
		arg_345_1.duration_ = 9.63

		local var_345_0 = {
			zh = 9.633,
			ja = 8.4
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
				arg_345_0:Play120042085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.775

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:GetWordFromCfg(120042084)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 31 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 31)

				if (31 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 31)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042084", "story_v_out_120042.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042084", "story_v_out_120042.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_out_120042", "120042084", "story_v_out_120042.awb")

						arg_345_1:RecordAudio("120042084", var_348_6)
						arg_345_1:RecordAudio("120042084", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_120042", "120042084", "story_v_out_120042.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_120042", "120042084", "story_v_out_120042.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play120042085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 120042085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play120042086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1071ui_story = arg_349_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1071ui_story"].transform.position).z)
				arg_349_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1071ui_story"].transform.localEulerAngles = arg_349_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1071ui_story"].transform.position).z)
				arg_349_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1071ui_story"].transform.localEulerAngles = arg_349_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_352_1 = 0
			local var_352_2 = 0.725

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_3 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(120042085).content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 29 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 29)

				if (29 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 29)) > 0 and var_352_2 < var_352_5 then
					arg_349_1.talkMaxDuration = var_352_5

					if var_352_5 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_6 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_6 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_6

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_6 and arg_349_1.time_ < var_352_1 + var_352_6 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play120042086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 120042086
		arg_353_1.duration_ = 6.93

		local var_353_0 = {
			zh = 2.266,
			ja = 6.933
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
				arg_353_0:Play120042087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1069ui_story = arg_353_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1069ui_story"].transform.position).z)
				arg_353_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1069ui_story"].transform.localEulerAngles = arg_353_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6)
				arg_353_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1069ui_story"].transform.position).z)
				arg_353_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1069ui_story"].transform.localEulerAngles = arg_353_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1071ui_story"].transform

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1071ui_story = var_356_1.localPosition
			end

			local var_356_2 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 then
				var_356_1.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_353_1.time_ - 0) / var_356_2)
				var_356_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_356_1.position).x, (manager.ui.mainCamera.transform.position - var_356_1.position).y, (manager.ui.mainCamera.transform.position - var_356_1.position).z)
				var_356_1.localEulerAngles.z = 0
				var_356_1.localEulerAngles.x = 0
				var_356_1.localEulerAngles = var_356_1.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 then
				var_356_1.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_356_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_356_1.position).x, (manager.ui.mainCamera.transform.position - var_356_1.position).y, (manager.ui.mainCamera.transform.position - var_356_1.position).z)
				var_356_1.localEulerAngles.z = 0
				var_356_1.localEulerAngles.x = 0
				var_356_1.localEulerAngles = var_356_1.localEulerAngles
			end

			local var_356_3 = arg_353_1.actors_["1069ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_3) and arg_353_1.var_.characterEffect1069ui_story == nil then
				arg_353_1.var_.characterEffect1069ui_story = var_356_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_4 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 and not isNil(var_356_3) then
				if arg_353_1.var_.characterEffect1069ui_story and not isNil(var_356_3) then
					arg_353_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 and not isNil(var_356_3) and arg_353_1.var_.characterEffect1069ui_story then
				arg_353_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_356_6 = arg_353_1.actors_["1071ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_6) and arg_353_1.var_.characterEffect1071ui_story == nil then
				arg_353_1.var_.characterEffect1071ui_story = var_356_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_7 = 0.0166666666666667

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 and not isNil(var_356_6) then
				if arg_353_1.var_.characterEffect1071ui_story and not isNil(var_356_6) then
					arg_353_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_7)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 and not isNil(var_356_6) and arg_353_1.var_.characterEffect1071ui_story then
				arg_353_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_356_8 = 0
			local var_356_9 = 0.275

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_10 = arg_353_1:GetWordFromCfg(120042086)
				local var_356_11 = arg_353_1:FormatText(var_356_10.content)

				arg_353_1.text_.text = var_356_11

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_13 = 11 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 11)

				if (11 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 11)) > 0 and var_356_9 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13

					if var_356_13 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_8
					end
				end

				arg_353_1.text_.text = var_356_11
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042086", "story_v_out_120042.awb") ~= 0 then
					local var_356_14 = manager.audio:GetVoiceLength("story_v_out_120042", "120042086", "story_v_out_120042.awb") / 1000

					if var_356_14 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_14 + var_356_8
					end

					if var_356_10.prefab_name ~= "" and arg_353_1.actors_[var_356_10.prefab_name] ~= nil then
						local var_356_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_10.prefab_name].transform, "story_v_out_120042", "120042086", "story_v_out_120042.awb")

						arg_353_1:RecordAudio("120042086", var_356_15)
						arg_353_1:RecordAudio("120042086", var_356_15)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_120042", "120042086", "story_v_out_120042.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_120042", "120042086", "story_v_out_120042.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_16 = math.max(var_356_9, arg_353_1.talkMaxDuration)

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_16 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_8) / var_356_16

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_8 + var_356_16 and arg_353_1.time_ < var_356_8 + var_356_16 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play120042087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 120042087
		arg_357_1.duration_ = 9.1

		local var_357_0 = {
			zh = 5.9,
			ja = 9.1
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
				arg_357_0:Play120042088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1071ui_story"]) and arg_357_1.var_.characterEffect1071ui_story == nil then
				arg_357_1.var_.characterEffect1071ui_story = arg_357_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1071ui_story"]) then
				if arg_357_1.var_.characterEffect1071ui_story and not isNil(arg_357_1.actors_["1071ui_story"]) then
					arg_357_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1071ui_story"]) and arg_357_1.var_.characterEffect1071ui_story then
				arg_357_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_360_2 = arg_357_1.actors_["1069ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.characterEffect1069ui_story == nil then
				arg_357_1.var_.characterEffect1069ui_story = var_360_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_3 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.characterEffect1069ui_story and not isNil(var_360_2) then
					arg_357_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_3)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.characterEffect1069ui_story then
				arg_357_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_360_4 = 0
			local var_360_5 = 0.65

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(120042087)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 26 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 26)

				if (26 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 26)) > 0 and var_360_5 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042087", "story_v_out_120042.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042087", "story_v_out_120042.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_out_120042", "120042087", "story_v_out_120042.awb")

						arg_357_1:RecordAudio("120042087", var_360_11)
						arg_357_1:RecordAudio("120042087", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_120042", "120042087", "story_v_out_120042.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_120042", "120042087", "story_v_out_120042.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_12 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_12 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_12

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_12 and arg_357_1.time_ < var_360_4 + var_360_12 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play120042088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 120042088
		arg_361_1.duration_ = 6.43

		local var_361_0 = {
			zh = 3.466,
			ja = 6.433
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
				arg_361_0:Play120042089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.425

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:GetWordFromCfg(120042088)
				local var_364_2 = arg_361_1:FormatText(var_364_1.content)

				arg_361_1.text_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 17 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 17)

				if (17 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 17)) > 0 and var_364_0 < var_364_4 then
					arg_361_1.talkMaxDuration = var_364_4

					if var_364_4 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_4 + 0
					end
				end

				arg_361_1.text_.text = var_364_2
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042088", "story_v_out_120042.awb") ~= 0 then
					local var_364_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042088", "story_v_out_120042.awb") / 1000

					if var_364_5 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + 0
					end

					if var_364_1.prefab_name ~= "" and arg_361_1.actors_[var_364_1.prefab_name] ~= nil then
						local var_364_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_1.prefab_name].transform, "story_v_out_120042", "120042088", "story_v_out_120042.awb")

						arg_361_1:RecordAudio("120042088", var_364_6)
						arg_361_1:RecordAudio("120042088", var_364_6)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_120042", "120042088", "story_v_out_120042.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_120042", "120042088", "story_v_out_120042.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play120042089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 120042089
		arg_365_1.duration_ = 6.4

		local var_365_0 = {
			zh = 6.4,
			ja = 3.333
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play120042090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1071ui_story = arg_365_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_368_0 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 then
				arg_365_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_365_1.time_ - 0) / var_368_0)
				arg_365_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1071ui_story"].transform.position).z)
				arg_365_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1071ui_story"].transform.localEulerAngles = arg_365_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 then
				arg_365_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_365_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1071ui_story"].transform.position).z)
				arg_365_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1071ui_story"].transform.localEulerAngles = arg_365_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_368_1 = arg_365_1.actors_["1075ui_story"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1075ui_story = var_368_1.localPosition
			end

			local var_368_2 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_2 then
				var_368_1.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_365_1.time_ - 0) / var_368_2)
				var_368_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_368_1.position).x, (manager.ui.mainCamera.transform.position - var_368_1.position).y, (manager.ui.mainCamera.transform.position - var_368_1.position).z)
				var_368_1.localEulerAngles.z = 0
				var_368_1.localEulerAngles.x = 0
				var_368_1.localEulerAngles = var_368_1.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_2 and arg_365_1.time_ < 0 + var_368_2 + arg_368_0 then
				var_368_1.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_368_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_368_1.position).x, (manager.ui.mainCamera.transform.position - var_368_1.position).y, (manager.ui.mainCamera.transform.position - var_368_1.position).z)
				var_368_1.localEulerAngles.z = 0
				var_368_1.localEulerAngles.x = 0
				var_368_1.localEulerAngles = var_368_1.localEulerAngles
			end

			local var_368_3 = arg_365_1.actors_["1075ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_3) and arg_365_1.var_.characterEffect1075ui_story == nil then
				arg_365_1.var_.characterEffect1075ui_story = var_368_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_4 = 0.2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 and not isNil(var_368_3) then
				if arg_365_1.var_.characterEffect1075ui_story and not isNil(var_368_3) then
					arg_365_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 and not isNil(var_368_3) and arg_365_1.var_.characterEffect1075ui_story then
				arg_365_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_368_6 = arg_365_1.actors_["1071ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_6) and arg_365_1.var_.characterEffect1071ui_story == nil then
				arg_365_1.var_.characterEffect1071ui_story = var_368_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_7 = 0.2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 and not isNil(var_368_6) then
				if arg_365_1.var_.characterEffect1071ui_story and not isNil(var_368_6) then
					arg_365_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_365_1.time_ - 0) / var_368_7)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 and not isNil(var_368_6) and arg_365_1.var_.characterEffect1071ui_story then
				arg_365_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_368_8 = arg_365_1.actors_["1069ui_story"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1069ui_story = var_368_8.localPosition
			end

			local var_368_9 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_9 then
				var_368_8.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_365_1.time_ - 0) / var_368_9)
				var_368_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_368_8.position).x, (manager.ui.mainCamera.transform.position - var_368_8.position).y, (manager.ui.mainCamera.transform.position - var_368_8.position).z)
				var_368_8.localEulerAngles.z = 0
				var_368_8.localEulerAngles.x = 0
				var_368_8.localEulerAngles = var_368_8.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_9 and arg_365_1.time_ < 0 + var_368_9 + arg_368_0 then
				var_368_8.localPosition = Vector3.New(0, 100, 0)
				var_368_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_368_8.position).x, (manager.ui.mainCamera.transform.position - var_368_8.position).y, (manager.ui.mainCamera.transform.position - var_368_8.position).z)
				var_368_8.localEulerAngles.z = 0
				var_368_8.localEulerAngles.x = 0
				var_368_8.localEulerAngles = var_368_8.localEulerAngles
			end

			local var_368_10 = 0
			local var_368_11 = 0.925

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_10 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_12 = arg_365_1:GetWordFromCfg(120042089)
				local var_368_13 = arg_365_1:FormatText(var_368_12.content)

				arg_365_1.text_.text = var_368_13

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_15 = 39 <= 0 and var_368_11 or var_368_11 * (utf8.len(var_368_13) / 39)

				if (39 <= 0 and var_368_11 or var_368_11 * (utf8.len(var_368_13) / 39)) > 0 and var_368_11 < var_368_15 then
					arg_365_1.talkMaxDuration = var_368_15

					if var_368_15 + var_368_10 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_15 + var_368_10
					end
				end

				arg_365_1.text_.text = var_368_13
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042089", "story_v_out_120042.awb") ~= 0 then
					local var_368_16 = manager.audio:GetVoiceLength("story_v_out_120042", "120042089", "story_v_out_120042.awb") / 1000

					if var_368_16 + var_368_10 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_16 + var_368_10
					end

					if var_368_12.prefab_name ~= "" and arg_365_1.actors_[var_368_12.prefab_name] ~= nil then
						local var_368_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_12.prefab_name].transform, "story_v_out_120042", "120042089", "story_v_out_120042.awb")

						arg_365_1:RecordAudio("120042089", var_368_17)
						arg_365_1:RecordAudio("120042089", var_368_17)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_120042", "120042089", "story_v_out_120042.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_120042", "120042089", "story_v_out_120042.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_18 = math.max(var_368_11, arg_365_1.talkMaxDuration)

			if var_368_10 <= arg_365_1.time_ and arg_365_1.time_ < var_368_10 + var_368_18 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_10) / var_368_18

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_10 + var_368_18 and arg_365_1.time_ < var_368_10 + var_368_18 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play120042090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 120042090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play120042091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1075ui_story"]) and arg_369_1.var_.characterEffect1075ui_story == nil then
				arg_369_1.var_.characterEffect1075ui_story = arg_369_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1075ui_story"]) then
				if arg_369_1.var_.characterEffect1075ui_story and not isNil(arg_369_1.actors_["1075ui_story"]) then
					arg_369_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1075ui_story"]) and arg_369_1.var_.characterEffect1075ui_story then
				arg_369_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 0.5

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(120042090).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 20 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 20)

				if (20 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 20)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play120042091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 120042091
		arg_373_1.duration_ = 7.33

		local var_373_0 = {
			zh = 7.333,
			ja = 6.733
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play120042092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1075ui_story"]) and arg_373_1.var_.characterEffect1075ui_story == nil then
				arg_373_1.var_.characterEffect1075ui_story = arg_373_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1075ui_story"]) then
				if arg_373_1.var_.characterEffect1075ui_story and not isNil(arg_373_1.actors_["1075ui_story"]) then
					arg_373_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1075ui_story"]) and arg_373_1.var_.characterEffect1075ui_story then
				arg_373_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_376_2 = 0
			local var_376_3 = 0.85

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(120042091)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 34 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 34)

				if (34 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 34)) > 0 and var_376_3 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042091", "story_v_out_120042.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_out_120042", "120042091", "story_v_out_120042.awb") / 1000

					if var_376_8 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_2
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_out_120042", "120042091", "story_v_out_120042.awb")

						arg_373_1:RecordAudio("120042091", var_376_9)
						arg_373_1:RecordAudio("120042091", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_120042", "120042091", "story_v_out_120042.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_120042", "120042091", "story_v_out_120042.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_10 and arg_373_1.time_ < var_376_2 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play120042092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 120042092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play120042093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1075ui_story = arg_377_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1075ui_story"].transform.position).z)
				arg_377_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1075ui_story"].transform.localEulerAngles = arg_377_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_377_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1075ui_story"].transform.position).z)
				arg_377_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1075ui_story"].transform.localEulerAngles = arg_377_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1071ui_story"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1071ui_story = var_380_1.localPosition
			end

			local var_380_2 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 then
				var_380_1.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_377_1.time_ - 0) / var_380_2)
				var_380_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_1.position).x, (manager.ui.mainCamera.transform.position - var_380_1.position).y, (manager.ui.mainCamera.transform.position - var_380_1.position).z)
				var_380_1.localEulerAngles.z = 0
				var_380_1.localEulerAngles.x = 0
				var_380_1.localEulerAngles = var_380_1.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 then
				var_380_1.localPosition = Vector3.New(0, 100, 0)
				var_380_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_1.position).x, (manager.ui.mainCamera.transform.position - var_380_1.position).y, (manager.ui.mainCamera.transform.position - var_380_1.position).z)
				var_380_1.localEulerAngles.z = 0
				var_380_1.localEulerAngles.x = 0
				var_380_1.localEulerAngles = var_380_1.localEulerAngles
			end

			local var_380_3 = 0
			local var_380_4 = 0.7

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_3 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_5 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(120042092).content)

				arg_377_1.text_.text = var_380_5

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_7 = 28 <= 0 and var_380_4 or var_380_4 * (utf8.len(var_380_5) / 28)

				if (28 <= 0 and var_380_4 or var_380_4 * (utf8.len(var_380_5) / 28)) > 0 and var_380_4 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_3 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_3
					end
				end

				arg_377_1.text_.text = var_380_5
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_8 = math.max(var_380_4, arg_377_1.talkMaxDuration)

			if var_380_3 <= arg_377_1.time_ and arg_377_1.time_ < var_380_3 + var_380_8 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_3) / var_380_8

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_3 + var_380_8 and arg_377_1.time_ < var_380_3 + var_380_8 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play120042093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 120042093
		arg_381_1.duration_ = 8.37

		local var_381_0 = {
			zh = 8.366,
			ja = 6.966
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play120042094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1071ui_story = arg_381_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1071ui_story"].transform.position).z)
				arg_381_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1071ui_story"].transform.localEulerAngles = arg_381_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_381_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1071ui_story"].transform.position).z)
				arg_381_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1071ui_story"].transform.localEulerAngles = arg_381_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["1071ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1071ui_story == nil then
				arg_381_1.var_.characterEffect1071ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect1071ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1071ui_story then
				arg_381_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_384_4 = 0
			local var_384_5 = 0.75

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_6 = arg_381_1:GetWordFromCfg(120042093)
				local var_384_7 = arg_381_1:FormatText(var_384_6.content)

				arg_381_1.text_.text = var_384_7

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_9 = 30 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 30)

				if (30 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 30)) > 0 and var_384_5 < var_384_9 then
					arg_381_1.talkMaxDuration = var_384_9

					if var_384_9 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_9 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_7
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042093", "story_v_out_120042.awb") ~= 0 then
					local var_384_10 = manager.audio:GetVoiceLength("story_v_out_120042", "120042093", "story_v_out_120042.awb") / 1000

					if var_384_10 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_4
					end

					if var_384_6.prefab_name ~= "" and arg_381_1.actors_[var_384_6.prefab_name] ~= nil then
						local var_384_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_6.prefab_name].transform, "story_v_out_120042", "120042093", "story_v_out_120042.awb")

						arg_381_1:RecordAudio("120042093", var_384_11)
						arg_381_1:RecordAudio("120042093", var_384_11)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_120042", "120042093", "story_v_out_120042.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_120042", "120042093", "story_v_out_120042.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_12 = math.max(var_384_5, arg_381_1.talkMaxDuration)

			if var_384_4 <= arg_381_1.time_ and arg_381_1.time_ < var_384_4 + var_384_12 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_4) / var_384_12

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_4 + var_384_12 and arg_381_1.time_ < var_384_4 + var_384_12 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play120042094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 120042094
		arg_385_1.duration_ = 1.8

		local var_385_0 = {
			zh = 1.8,
			ja = 1.566
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
				arg_385_0:Play120042095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.15

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(120042094)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 6 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 6)

				if (6 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 6)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042094", "story_v_out_120042.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042094", "story_v_out_120042.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_120042", "120042094", "story_v_out_120042.awb")

						arg_385_1:RecordAudio("120042094", var_388_6)
						arg_385_1:RecordAudio("120042094", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_120042", "120042094", "story_v_out_120042.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_120042", "120042094", "story_v_out_120042.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play120042095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 120042095
		arg_389_1.duration_ = 5.03

		local var_389_0 = {
			zh = 4.666,
			ja = 5.033
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

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
			local var_392_0 = 0.55

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_1 = arg_389_1:GetWordFromCfg(120042095)
				local var_392_2 = arg_389_1:FormatText(var_392_1.content)

				arg_389_1.text_.text = var_392_2

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 22 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 22)

				if (22 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 22)) > 0 and var_392_0 < var_392_4 then
					arg_389_1.talkMaxDuration = var_392_4

					if var_392_4 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_4 + 0
					end
				end

				arg_389_1.text_.text = var_392_2
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120042", "120042095", "story_v_out_120042.awb") ~= 0 then
					local var_392_5 = manager.audio:GetVoiceLength("story_v_out_120042", "120042095", "story_v_out_120042.awb") / 1000

					if var_392_5 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + 0
					end

					if var_392_1.prefab_name ~= "" and arg_389_1.actors_[var_392_1.prefab_name] ~= nil then
						local var_392_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_1.prefab_name].transform, "story_v_out_120042", "120042095", "story_v_out_120042.awb")

						arg_389_1:RecordAudio("120042095", var_392_6)
						arg_389_1:RecordAudio("120042095", var_392_6)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_120042", "120042095", "story_v_out_120042.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_120042", "120042095", "story_v_out_120042.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J02i",
		"TextureConfig/Background/XH0104a",
		"TextureConfig/Background/XH0104",
		"TextureConfig/Background/ST37a"
	},
	voices = {
		"story_v_out_120042.awb"
	}
}
