return {
	Play318262001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318262001
		arg_1_1.duration_ = 4.1

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318262002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K16i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K16i")
				var_4_0.name = "K16i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K16i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K16i

				arg_1_1.bgs_.K16i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K16i" then
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

			local var_4_8 = "1049ui_story"

			if arg_1_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1049ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1049ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.2, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1049ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1049ui_story == nil then
				arg_1_1.var_.characterEffect1049ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1049ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1049ui_story then
				arg_1_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
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

			if 0.8 < arg_1_1.time_ and arg_1_1.time_ <= 0.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_10_battle_sasanami_photonrail", "bgm_activity_2_10_battle_sasanami_photonrail", "bgm_activity_2_10_battle_sasanami_photonrail.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_10_battle_sasanami_photonrail", "bgm_activity_2_10_battle_sasanami_photonrail")

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
			local var_4_24 = 0.1

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(318262001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 4 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 4)

				if (4 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 4)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262001", "story_v_out_318262.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_318262", "318262001", "story_v_out_318262.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_318262", "318262001", "story_v_out_318262.awb")

						arg_1_1:RecordAudio("318262001", var_4_31)
						arg_1_1:RecordAudio("318262001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_318262", "318262001", "story_v_out_318262.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_318262", "318262001", "story_v_out_318262.awb")
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
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play318262002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318262002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play318262003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1049ui_story"]) and arg_9_1.var_.characterEffect1049ui_story == nil then
				arg_9_1.var_.characterEffect1049ui_story = arg_9_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1049ui_story"]) then
				if arg_9_1.var_.characterEffect1049ui_story and not isNil(arg_9_1.actors_["1049ui_story"]) then
					arg_9_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1049ui_story"]) and arg_9_1.var_.characterEffect1049ui_story then
				arg_9_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.175

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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(318262002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 7 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 7)

				if (7 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 7)) > 0 and var_12_2 < var_12_5 then
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
	Play318262003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318262003
		arg_13_1.duration_ = 2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play318262004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1049ui_story = arg_13_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).z)
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles = arg_13_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_13_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1049ui_story"].transform.position).z)
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1049ui_story"].transform.localEulerAngles = arg_13_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1049ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1049ui_story == nil then
				arg_13_1.var_.characterEffect1049ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1049ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1049ui_story then
				arg_13_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_16_4 = 0
			local var_16_5 = 0.125

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(318262003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 5 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 5)

				if (5 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 5)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262003", "story_v_out_318262.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262003", "story_v_out_318262.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_318262", "318262003", "story_v_out_318262.awb")

						arg_13_1:RecordAudio("318262003", var_16_11)
						arg_13_1:RecordAudio("318262003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_318262", "318262003", "story_v_out_318262.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_318262", "318262003", "story_v_out_318262.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play318262004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318262004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play318262005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1049ui_story = arg_17_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1049ui_story"].transform.position).z)
				arg_17_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1049ui_story"].transform.localEulerAngles = arg_17_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1049ui_story"].transform.position).z)
				arg_17_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1049ui_story"].transform.localEulerAngles = arg_17_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1049ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1049ui_story == nil then
				arg_17_1.var_.characterEffect1049ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1049ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1049ui_story then
				arg_17_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 0.85

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

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(318262004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 34 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 34)

				if (34 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 34)) > 0 and var_20_4 < var_20_7 then
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
				actorName = "1049ui_story",
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
	Play318262005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318262005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play318262006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.35

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(318262005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 54 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 54)

				if (54 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 54)) > 0 and var_24_0 < var_24_3 then
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
	Play318262006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318262006
		arg_25_1.duration_ = 6.5

		local var_25_0 = {
			zh = 6.5,
			ja = 6
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
				arg_25_0:Play318262007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1049ui_story = arg_25_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1049ui_story"].transform.position).z)
				arg_25_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1049ui_story"].transform.localEulerAngles = arg_25_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_25_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1049ui_story"].transform.position).z)
				arg_25_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1049ui_story"].transform.localEulerAngles = arg_25_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1049ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1049ui_story == nil then
				arg_25_1.var_.characterEffect1049ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1049ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1049ui_story then
				arg_25_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_4 = 0
			local var_28_5 = 0.7

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(318262006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 28 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 28)

				if (28 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 28)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262006", "story_v_out_318262.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262006", "story_v_out_318262.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_318262", "318262006", "story_v_out_318262.awb")

						arg_25_1:RecordAudio("318262006", var_28_11)
						arg_25_1:RecordAudio("318262006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_318262", "318262006", "story_v_out_318262.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_318262", "318262006", "story_v_out_318262.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play318262007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318262007
		arg_29_1.duration_ = 6

		local var_29_0 = {
			zh = 6,
			ja = 2.7
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
				arg_29_0:Play318262008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1049ui_story = arg_29_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1049ui_story"].transform.position).z)
				arg_29_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1049ui_story"].transform.localEulerAngles = arg_29_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_29_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1049ui_story"].transform.position).z)
				arg_29_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1049ui_story"].transform.localEulerAngles = arg_29_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1049ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1049ui_story == nil then
				arg_29_1.var_.characterEffect1049ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1049ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1049ui_story then
				arg_29_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_4 = 0
			local var_32_5 = 0.525

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(318262007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 21 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 21)

				if (21 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 21)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262007", "story_v_out_318262.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262007", "story_v_out_318262.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_318262", "318262007", "story_v_out_318262.awb")

						arg_29_1:RecordAudio("318262007", var_32_11)
						arg_29_1:RecordAudio("318262007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_318262", "318262007", "story_v_out_318262.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_318262", "318262007", "story_v_out_318262.awb")
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
				actorName = "1049ui_story",
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
	Play318262008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318262008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play318262009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1049ui_story = arg_33_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).z)
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles = arg_33_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1049ui_story"].transform.position).z)
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1049ui_story"].transform.localEulerAngles = arg_33_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1049ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1049ui_story == nil then
				arg_33_1.var_.characterEffect1049ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1049ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_2)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1049ui_story then
				arg_33_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_36_3 = 0
			local var_36_4 = 0.925

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(318262008).content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 37 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 37)

				if (37 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_5) / 37)) > 0 and var_36_4 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_8 and arg_33_1.time_ < var_36_3 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play318262009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318262009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play318262010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.775

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(318262009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 31 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 31)

				if (31 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 31)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play318262010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318262010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play318262011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.9

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(318262010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 36 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 36)

				if (36 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 36)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play318262011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318262011
		arg_45_1.duration_ = 3.9

		local var_45_0 = {
			zh = 1.999999999999,
			ja = 3.9
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
				arg_45_0:Play318262012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1049ui_story = arg_45_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1049ui_story"].transform.position).z)
				arg_45_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1049ui_story"].transform.localEulerAngles = arg_45_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_45_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1049ui_story"].transform.position).z)
				arg_45_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1049ui_story"].transform.localEulerAngles = arg_45_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1049ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1049ui_story == nil then
				arg_45_1.var_.characterEffect1049ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1049ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1049ui_story then
				arg_45_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_48_4 = 0
			local var_48_5 = 0.1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(318262011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 4 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 4)

				if (4 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 4)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262011", "story_v_out_318262.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262011", "story_v_out_318262.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_318262", "318262011", "story_v_out_318262.awb")

						arg_45_1:RecordAudio("318262011", var_48_11)
						arg_45_1:RecordAudio("318262011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_318262", "318262011", "story_v_out_318262.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_318262", "318262011", "story_v_out_318262.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play318262012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318262012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play318262013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1049ui_story"]) and arg_49_1.var_.characterEffect1049ui_story == nil then
				arg_49_1.var_.characterEffect1049ui_story = arg_49_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1049ui_story"]) then
				if arg_49_1.var_.characterEffect1049ui_story and not isNil(arg_49_1.actors_["1049ui_story"]) then
					arg_49_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1049ui_story"]) and arg_49_1.var_.characterEffect1049ui_story then
				arg_49_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.2

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(318262012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 8 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 8)

				if (8 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 8)) > 0 and var_52_2 < var_52_5 then
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
	Play318262013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318262013
		arg_53_1.duration_ = 5.23

		local var_53_0 = {
			zh = 1.999999999999,
			ja = 5.233
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
				arg_53_0:Play318262014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1049ui_story = arg_53_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1049ui_story"].transform.position).z)
				arg_53_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1049ui_story"].transform.localEulerAngles = arg_53_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_53_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1049ui_story"].transform.position).z)
				arg_53_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1049ui_story"].transform.localEulerAngles = arg_53_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1049ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1049ui_story == nil then
				arg_53_1.var_.characterEffect1049ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1049ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1049ui_story then
				arg_53_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_4 = 0
			local var_56_5 = 0.075

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(318262013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 3 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 3)

				if (3 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 3)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262013", "story_v_out_318262.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262013", "story_v_out_318262.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_318262", "318262013", "story_v_out_318262.awb")

						arg_53_1:RecordAudio("318262013", var_56_11)
						arg_53_1:RecordAudio("318262013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_318262", "318262013", "story_v_out_318262.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_318262", "318262013", "story_v_out_318262.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play318262014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318262014
		arg_57_1.duration_ = 1

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"

			SetActive(arg_57_1.choicesGo_, true)

			for iter_58_0, iter_58_1 in ipairs(arg_57_1.choices_) do
				SetActive(iter_58_1.go, iter_58_0 <= 1)
			end

			arg_57_1.choices_[1].txt.text = arg_57_1:FormatText(StoryChoiceCfg[684].name)
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play318262015(arg_57_1)
			end

			arg_57_1:RecordChoiceLog(318262014, 684)
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1049ui_story"]) and arg_57_1.var_.characterEffect1049ui_story == nil then
				arg_57_1.var_.characterEffect1049ui_story = arg_57_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1049ui_story"]) then
				if arg_57_1.var_.characterEffect1049ui_story and not isNil(arg_57_1.actors_["1049ui_story"]) then
					arg_57_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1049ui_story"]) and arg_57_1.var_.characterEffect1049ui_story then
				arg_57_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_1 + 0.5 and arg_57_1.time_ < var_60_1 + 0.5 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play318262015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 318262015
		arg_61_1.duration_ = 1.77

		local var_61_0 = {
			zh = 1.633,
			ja = 1.766
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
				arg_61_0:Play318262016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1049ui_story = arg_61_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1049ui_story"].transform.position).z)
				arg_61_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1049ui_story"].transform.localEulerAngles = arg_61_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_61_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1049ui_story"].transform.position).z)
				arg_61_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1049ui_story"].transform.localEulerAngles = arg_61_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1049ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1049ui_story == nil then
				arg_61_1.var_.characterEffect1049ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1049ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1049ui_story then
				arg_61_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_4 = 0
			local var_64_5 = 0.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(318262015)
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

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262015", "story_v_out_318262.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262015", "story_v_out_318262.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_318262", "318262015", "story_v_out_318262.awb")

						arg_61_1:RecordAudio("318262015", var_64_11)
						arg_61_1:RecordAudio("318262015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_318262", "318262015", "story_v_out_318262.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_318262", "318262015", "story_v_out_318262.awb")
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
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play318262016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 318262016
		arg_65_1.duration_ = 7.47

		local var_65_0 = {
			zh = 5.9,
			ja = 7.466
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
				arg_65_0:Play318262017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_0 = 0
			local var_68_1 = 0.6

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(318262016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 24 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 24)

				if (24 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 24)) > 0 and var_68_1 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262016", "story_v_out_318262.awb") ~= 0 then
					local var_68_6 = manager.audio:GetVoiceLength("story_v_out_318262", "318262016", "story_v_out_318262.awb") / 1000

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end

					if var_68_2.prefab_name ~= "" and arg_65_1.actors_[var_68_2.prefab_name] ~= nil then
						local var_68_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_2.prefab_name].transform, "story_v_out_318262", "318262016", "story_v_out_318262.awb")

						arg_65_1:RecordAudio("318262016", var_68_7)
						arg_65_1:RecordAudio("318262016", var_68_7)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_318262", "318262016", "story_v_out_318262.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_318262", "318262016", "story_v_out_318262.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play318262017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 318262017
		arg_69_1.duration_ = 1

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"

			SetActive(arg_69_1.choicesGo_, true)

			for iter_70_0, iter_70_1 in ipairs(arg_69_1.choices_) do
				SetActive(iter_70_1.go, iter_70_0 <= 1)
			end

			arg_69_1.choices_[1].txt.text = arg_69_1:FormatText(StoryChoiceCfg[685].name)
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play318262018(arg_69_1)
			end

			arg_69_1:RecordChoiceLog(318262017, 685)
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1049ui_story"]) and arg_69_1.var_.characterEffect1049ui_story == nil then
				arg_69_1.var_.characterEffect1049ui_story = arg_69_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1049ui_story"]) then
				if arg_69_1.var_.characterEffect1049ui_story and not isNil(arg_69_1.actors_["1049ui_story"]) then
					arg_69_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1049ui_story"]) and arg_69_1.var_.characterEffect1049ui_story then
				arg_69_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_1 + 0.5 and arg_69_1.time_ < var_72_1 + 0.5 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play318262018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 318262018
		arg_73_1.duration_ = 3.9

		local var_73_0 = {
			zh = 3.9,
			ja = 1.999999999999
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
				arg_73_0:Play318262019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1049ui_story"]) and arg_73_1.var_.characterEffect1049ui_story == nil then
				arg_73_1.var_.characterEffect1049ui_story = arg_73_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1049ui_story"]) then
				if arg_73_1.var_.characterEffect1049ui_story and not isNil(arg_73_1.actors_["1049ui_story"]) then
					arg_73_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1049ui_story"]) and arg_73_1.var_.characterEffect1049ui_story then
				arg_73_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_76_2 = 0
			local var_76_3 = 0.25

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(318262018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 10 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 10)

				if (10 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 10)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262018", "story_v_out_318262.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_318262", "318262018", "story_v_out_318262.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_318262", "318262018", "story_v_out_318262.awb")

						arg_73_1:RecordAudio("318262018", var_76_9)
						arg_73_1:RecordAudio("318262018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_318262", "318262018", "story_v_out_318262.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_318262", "318262018", "story_v_out_318262.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play318262019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 318262019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play318262020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1049ui_story = arg_77_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1049ui_story"].transform.position).z)
				arg_77_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1049ui_story"].transform.localEulerAngles = arg_77_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1049ui_story"].transform.position).z)
				arg_77_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1049ui_story"].transform.localEulerAngles = arg_77_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1049ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1049ui_story == nil then
				arg_77_1.var_.characterEffect1049ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1049ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_2)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1049ui_story then
				arg_77_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_80_3 = 0
			local var_80_4 = 0.65

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(318262019).content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 26 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 26)

				if (26 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 26)) > 0 and var_80_4 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_3
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_4, arg_77_1.talkMaxDuration)

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_3) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_3 + var_80_8 and arg_77_1.time_ < var_80_3 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play318262020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 318262020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play318262021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.125

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

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(318262020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 45 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 45)

				if (45 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 45)) > 0 and var_84_0 < var_84_3 then
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
	Play318262021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 318262021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play318262022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 1.15

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

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(318262021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 46 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 46)

				if (46 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 46)) > 0 and var_88_0 < var_88_3 then
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
	Play318262022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 318262022
		arg_89_1.duration_ = 8.63

		local var_89_0 = {
			zh = 6.9,
			ja = 8.633
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
				arg_89_0:Play318262023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1049ui_story = arg_89_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).z)
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles = arg_89_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_89_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).z)
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles = arg_89_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1049ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1049ui_story == nil then
				arg_89_1.var_.characterEffect1049ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1049ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1049ui_story then
				arg_89_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_92_4 = 0
			local var_92_5 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(318262022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 18 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 18)

				if (18 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 18)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262022", "story_v_out_318262.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262022", "story_v_out_318262.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_318262", "318262022", "story_v_out_318262.awb")

						arg_89_1:RecordAudio("318262022", var_92_11)
						arg_89_1:RecordAudio("318262022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_318262", "318262022", "story_v_out_318262.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_318262", "318262022", "story_v_out_318262.awb")
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

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play318262023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 318262023
		arg_93_1.duration_ = 7

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play318262024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.bgs_.STblack == nil then
				local var_96_0 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_96_0.name = "STblack"
				var_96_0.transform.parent = arg_93_1.stage_.transform
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_.STblack = var_96_0
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				local var_96_1 = arg_93_1.bgs_.STblack

				arg_93_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_96_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_2 = var_96_1:GetComponent("SpriteRenderer")

				if var_96_2 and var_96_2.sprite then
					local var_96_3 = 2 * (var_96_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_96_1.transform.localScale = Vector3.New(var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "STblack" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_4 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			if arg_93_1.time_ >= var_96_4 + 0.3 and arg_93_1.time_ < var_96_4 + 0.3 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_5 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_6 = 2

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_6 then
				local var_96_7 = Color.New(1, 1, 1)

				var_96_7.a = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_5) / var_96_6)
				arg_93_1.mask_.color = var_96_7
			end

			if arg_93_1.time_ >= var_96_5 + var_96_6 and arg_93_1.time_ < var_96_5 + var_96_6 + arg_96_0 then
				local var_96_8 = Color.New(1, 1, 1)

				arg_93_1.mask_.enabled = false
				var_96_8.a = 0
				arg_93_1.mask_.color = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1049ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1049ui_story = var_96_9.localPosition
			end

			local var_96_10 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_10 then
				var_96_9.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_10)
				var_96_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_9.position).x, (manager.ui.mainCamera.transform.position - var_96_9.position).y, (manager.ui.mainCamera.transform.position - var_96_9.position).z)
				var_96_9.localEulerAngles.z = 0
				var_96_9.localEulerAngles.x = 0
				var_96_9.localEulerAngles = var_96_9.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_10 and arg_93_1.time_ < 0 + var_96_10 + arg_96_0 then
				var_96_9.localPosition = Vector3.New(0, 100, 0)
				var_96_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_9.position).x, (manager.ui.mainCamera.transform.position - var_96_9.position).y, (manager.ui.mainCamera.transform.position - var_96_9.position).z)
				var_96_9.localEulerAngles.z = 0
				var_96_9.localEulerAngles.x = 0
				var_96_9.localEulerAngles = var_96_9.localEulerAngles
			end

			local var_96_11 = arg_93_1.actors_["1049ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_11) and arg_93_1.var_.characterEffect1049ui_story == nil then
				arg_93_1.var_.characterEffect1049ui_story = var_96_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_12 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_12 and not isNil(var_96_11) then
				if arg_93_1.var_.characterEffect1049ui_story and not isNil(var_96_11) then
					arg_93_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_12)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_12 and arg_93_1.time_ < 0 + var_96_12 + arg_96_0 and not isNil(var_96_11) and arg_93_1.var_.characterEffect1049ui_story then
				arg_93_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_13 = 2
			local var_96_14 = 0.975

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_15 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_15:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_16 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(318262023).content)

				arg_93_1.text_.text = var_96_16

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_18 = 39 <= 0 and var_96_14 or var_96_14 * (utf8.len(var_96_16) / 39)

				if (39 <= 0 and var_96_14 or var_96_14 * (utf8.len(var_96_16) / 39)) > 0 and var_96_14 < var_96_18 then
					arg_93_1.talkMaxDuration = var_96_18
					var_96_13 = var_96_13 + 0.3

					if var_96_18 + var_96_13 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_13
					end
				end

				arg_93_1.text_.text = var_96_16
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_19 = var_96_13 + 0.3
			local var_96_20 = math.max(var_96_14, arg_93_1.talkMaxDuration)

			if var_96_13 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_19 + var_96_20 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_19) / var_96_20

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_19 + var_96_20 and arg_93_1.time_ < var_96_19 + var_96_20 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play318262024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 318262024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play318262025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.2

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(318262024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 8 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 8)

				if (8 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 8)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play318262025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 318262025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play318262026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.475

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(318262025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 60 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 60)

				if (60 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 60)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play318262026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 318262026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play318262027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.25

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(318262026).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 10 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 10)

				if (10 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 10)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play318262027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 318262027
		arg_111_1.duration_ = 2

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play318262028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.fswbg_:SetActive(true)
				arg_111_1.dialog_:SetActive(false)

				arg_111_1.fswtw_.percent = 0
				arg_111_1.fswt_.text = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(318262027).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.fswt_)

				arg_111_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_111_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_111_1.fswtw_:SetDirty()

				arg_111_1.typewritterCharCountI18N = 0

				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_0 = 0.033

			if 0.033 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.var_.oldValueTypewriter = arg_111_1.fswtw_.percent

				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_1 = 12
			local var_114_2 = 0.8
			local var_114_3, var_114_4 = arg_111_1:GetPercentByPara(arg_111_1:FormatText(arg_111_1:GetWordFromCfg(318262027).content), 1)

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				local var_114_5 = var_114_1 <= 0 and var_114_2 or var_114_2 * ((var_114_4 - arg_111_1.typewritterCharCountI18N) / var_114_1)

				if (var_114_1 <= 0 and var_114_2 or var_114_2 * ((var_114_4 - arg_111_1.typewritterCharCountI18N) / var_114_1)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_0
					end
				end
			end

			local var_114_6 = math.max(0.8, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_6 then
				arg_111_1.fswtw_.percent = Mathf.Lerp(arg_111_1.var_.oldValueTypewriter, var_114_3, (arg_111_1.time_ - var_114_0) / var_114_6)
				arg_111_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_111_1.fswtw_:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_6 and arg_111_1.time_ < var_114_0 + var_114_6 + arg_114_0 then
				arg_111_1.fswtw_.percent = var_114_3

				arg_111_1.fswtw_:SetDirty()
				arg_111_1:ShowNextGo(true)

				arg_111_1.typewritterCharCountI18N = var_114_4
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				local var_114_7 = arg_111_1.fswbg_.transform:Find("textbox/adapt/content") or arg_111_1.fswbg_.transform:Find("textbox/content")
				local var_114_8 = arg_111_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_114_9 = var_114_7:GetComponent("RectTransform")

				var_114_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_114_9.offsetMin = Vector2.New(0, 0)
				var_114_9.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play318262028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 318262028
		arg_115_1.duration_ = 2

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play318262029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.fswbg_:SetActive(true)
				arg_115_1.dialog_:SetActive(false)

				arg_115_1.fswtw_.percent = 0
				arg_115_1.fswt_.text = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(318262028).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.fswt_)

				arg_115_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_115_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_115_1.fswtw_:SetDirty()

				arg_115_1.typewritterCharCountI18N = 0

				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.var_.oldValueTypewriter = arg_115_1.fswtw_.percent

				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_1 = 12
			local var_118_2 = 0.8
			local var_118_3, var_118_4 = arg_115_1:GetPercentByPara(arg_115_1:FormatText(arg_115_1:GetWordFromCfg(318262028).content), 1)

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				local var_118_5 = var_118_1 <= 0 and var_118_2 or var_118_2 * ((var_118_4 - arg_115_1.typewritterCharCountI18N) / var_118_1)

				if (var_118_1 <= 0 and var_118_2 or var_118_2 * ((var_118_4 - arg_115_1.typewritterCharCountI18N) / var_118_1)) > 0 and var_118_2 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_0
					end
				end
			end

			local var_118_6 = math.max(0.8, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_6 then
				arg_115_1.fswtw_.percent = Mathf.Lerp(arg_115_1.var_.oldValueTypewriter, var_118_3, (arg_115_1.time_ - var_118_0) / var_118_6)
				arg_115_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_115_1.fswtw_:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_6 and arg_115_1.time_ < var_118_0 + var_118_6 + arg_118_0 then
				arg_115_1.fswtw_.percent = var_118_3

				arg_115_1.fswtw_:SetDirty()
				arg_115_1:ShowNextGo(true)

				arg_115_1.typewritterCharCountI18N = var_118_4
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				local var_118_7 = arg_115_1.fswbg_.transform:Find("textbox/adapt/content") or arg_115_1.fswbg_.transform:Find("textbox/content")
				local var_118_8 = arg_115_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_118_9 = var_118_7:GetComponent("RectTransform")

				var_118_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_118_9.offsetMin = Vector2.New(0, 0)
				var_118_9.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play318262029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 318262029
		arg_119_1.duration_ = 7.02

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play318262030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if arg_119_1.bgs_.LX0206 == nil then
				local var_122_0 = Object.Instantiate(arg_119_1.paintGo_)

				var_122_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "LX0206")
				var_122_0.name = "LX0206"
				var_122_0.transform.parent = arg_119_1.stage_.transform
				var_122_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.bgs_.LX0206 = var_122_0
			end

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				local var_122_1 = arg_119_1.bgs_.LX0206

				arg_119_1.bgs_.LX0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_122_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_2 = var_122_1:GetComponent("SpriteRenderer")

				if var_122_2 and var_122_2.sprite then
					local var_122_3 = 2 * (var_122_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_122_1.transform.localScale = Vector3.New(var_122_3 / var_122_2.sprite.bounds.size.y < var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x and var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x or var_122_3 / var_122_2.sprite.bounds.size.y, var_122_3 / var_122_2.sprite.bounds.size.y < var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x and var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x or var_122_3 / var_122_2.sprite.bounds.size.y, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "LX0206" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_4 = 0

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_5 = 2

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_5 then
				local var_122_6 = Color.New(0, 0, 0)

				var_122_6.a = Mathf.Lerp(0, 1, (arg_119_1.time_ - var_122_4) / var_122_5)
				arg_119_1.mask_.color = var_122_6
			end

			if arg_119_1.time_ >= var_122_4 + var_122_5 and arg_119_1.time_ < var_122_4 + var_122_5 + arg_122_0 then
				local var_122_7 = Color.New(0, 0, 0)

				var_122_7.a = 1
				arg_119_1.mask_.color = var_122_7
			end

			local var_122_8 = 2

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_9 = 2

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_9 then
				local var_122_10 = Color.New(0, 0, 0)

				var_122_10.a = Mathf.Lerp(1, 0, (arg_119_1.time_ - var_122_8) / var_122_9)
				arg_119_1.mask_.color = var_122_10
			end

			if arg_119_1.time_ >= var_122_8 + var_122_9 and arg_119_1.time_ < var_122_8 + var_122_9 + arg_122_0 then
				local var_122_11 = Color.New(0, 0, 0)

				arg_119_1.mask_.enabled = false
				var_122_11.a = 0
				arg_119_1.mask_.color = var_122_11
			end

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				arg_119_1.fswbg_:SetActive(false)
				arg_119_1.dialog_:SetActive(false)
				SetActive(arg_119_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_119_1:ShowNextGo(false)
			end

			local var_122_12 = arg_119_1.bgs_.LX0206.transform

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				arg_119_1.var_.moveOldPosLX0206 = var_122_12.localPosition
			end

			local var_122_13 = 0.001

			if 2 <= arg_119_1.time_ and arg_119_1.time_ < 2 + var_122_13 then
				var_122_12.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPosLX0206, Vector3.New(0, 1, 9.5), (arg_119_1.time_ - 2) / var_122_13)
			end

			if arg_119_1.time_ >= 2 + var_122_13 and arg_119_1.time_ < 2 + var_122_13 + arg_122_0 then
				var_122_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_122_14 = arg_119_1.bgs_.LX0206.transform

			if 2.01666666666667 < arg_119_1.time_ and arg_119_1.time_ <= 2.01666666666667 + arg_122_0 then
				arg_119_1.var_.moveOldPosLX0206 = var_122_14.localPosition
			end

			local var_122_15 = 5

			if 2.01666666666667 <= arg_119_1.time_ and arg_119_1.time_ < 2.01666666666667 + var_122_15 then
				var_122_14.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPosLX0206, Vector3.New(0, 1, 10), (arg_119_1.time_ - 2.01666666666667) / var_122_15)
			end

			if arg_119_1.time_ >= 2.01666666666667 + var_122_15 and arg_119_1.time_ < 2.01666666666667 + var_122_15 + arg_122_0 then
				var_122_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_122_16 = 4

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			if arg_119_1.time_ >= var_122_16 + 3.01666666666667 and arg_119_1.time_ < var_122_16 + 3.01666666666667 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_17 = 2
			local var_122_18 = 1.375

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_17 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_19 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_19:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_20 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(318262029).content)

				arg_119_1.text_.text = var_122_20

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_22 = 55 <= 0 and var_122_18 or var_122_18 * (utf8.len(var_122_20) / 55)

				if (55 <= 0 and var_122_18 or var_122_18 * (utf8.len(var_122_20) / 55)) > 0 and var_122_18 < var_122_22 then
					arg_119_1.talkMaxDuration = var_122_22
					var_122_17 = var_122_17 + 0.3

					if var_122_22 + var_122_17 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_17
					end
				end

				arg_119_1.text_.text = var_122_20
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_23 = var_122_17 + 0.3
			local var_122_24 = math.max(var_122_18, arg_119_1.talkMaxDuration)

			if var_122_17 + 0.3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_23 + var_122_24 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_23) / var_122_24

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_23 + var_122_24 and arg_119_1.time_ < var_122_23 + var_122_24 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "LX0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LX0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play318262030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318262030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play318262031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.9

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

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(318262030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 36 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 36)

				if (36 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 36)) > 0 and var_128_0 < var_128_3 then
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
	Play318262031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318262031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play318262032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1.475

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

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(318262031).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 58 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 58)

				if (58 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 58)) > 0 and var_132_0 < var_132_3 then
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
	Play318262032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318262032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play318262033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.875

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(318262032).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 35 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 35)

				if (35 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 35)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play318262033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318262033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play318262034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.35

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

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(318262033).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 14 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 14)

				if (14 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 14)) > 0 and var_140_0 < var_140_3 then
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
	Play318262034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318262034
		arg_141_1.duration_ = 7.8

		local var_141_0 = {
			zh = 7.8,
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
				arg_141_0:Play318262035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.5

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(318262034)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 20 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 20)

				if (20 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 20)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262034", "story_v_out_318262.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262034", "story_v_out_318262.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_318262", "318262034", "story_v_out_318262.awb")

						arg_141_1:RecordAudio("318262034", var_144_6)
						arg_141_1:RecordAudio("318262034", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_318262", "318262034", "story_v_out_318262.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_318262", "318262034", "story_v_out_318262.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play318262035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318262035
		arg_145_1.duration_ = 6.3

		local var_145_0 = {
			zh = 4.3,
			ja = 6.3
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
				arg_145_0:Play318262036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.3

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(318262035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 12 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 12)

				if (12 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 12)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262035", "story_v_out_318262.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262035", "story_v_out_318262.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_318262", "318262035", "story_v_out_318262.awb")

						arg_145_1:RecordAudio("318262035", var_148_6)
						arg_145_1:RecordAudio("318262035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_318262", "318262035", "story_v_out_318262.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_318262", "318262035", "story_v_out_318262.awb")
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
	Play318262036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318262036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play318262037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.3

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(318262036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 12 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 12)

				if (12 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 12)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play318262037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318262037
		arg_153_1.duration_ = 5.87

		local var_153_0 = {
			zh = 4,
			ja = 5.866
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
				arg_153_0:Play318262038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.45

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(318262037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 18 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 18)

				if (18 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 18)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262037", "story_v_out_318262.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262037", "story_v_out_318262.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_318262", "318262037", "story_v_out_318262.awb")

						arg_153_1:RecordAudio("318262037", var_156_6)
						arg_153_1:RecordAudio("318262037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_318262", "318262037", "story_v_out_318262.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_318262", "318262037", "story_v_out_318262.awb")
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
	Play318262038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318262038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318262039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.9

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(318262038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 36 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 36)

				if (36 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 36)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play318262039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318262039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play318262040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.775

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(318262039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 31 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 31)

				if (31 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 31)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play318262040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318262040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318262041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.8

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

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(318262040).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 32 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 32)

				if (32 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 32)) > 0 and var_168_0 < var_168_3 then
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
	Play318262041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318262041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play318262042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(318262041).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 40 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 40)

				if (40 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 40)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play318262042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 318262042
		arg_173_1.duration_ = 9.07

		local var_173_0 = {
			zh = 8.166,
			ja = 9.066
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play318262043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if arg_173_1.bgs_.K05f == nil then
				local var_176_0 = Object.Instantiate(arg_173_1.paintGo_)

				var_176_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05f")
				var_176_0.name = "K05f"
				var_176_0.transform.parent = arg_173_1.stage_.transform
				var_176_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.bgs_.K05f = var_176_0
			end

			if 2 < arg_173_1.time_ and arg_173_1.time_ <= 2 + arg_176_0 then
				local var_176_1 = arg_173_1.bgs_.K05f

				arg_173_1.bgs_.K05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_176_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_176_2 = var_176_1:GetComponent("SpriteRenderer")

				if var_176_2 and var_176_2.sprite then
					local var_176_3 = 2 * (var_176_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_176_1.transform.localScale = Vector3.New(var_176_3 / var_176_2.sprite.bounds.size.y < var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x and var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x or var_176_3 / var_176_2.sprite.bounds.size.y, var_176_3 / var_176_2.sprite.bounds.size.y < var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x and var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x or var_176_3 / var_176_2.sprite.bounds.size.y, 0)
				end

				for iter_176_0, iter_176_1 in pairs(arg_173_1.bgs_) do
					if iter_176_0 ~= "K05f" then
						iter_176_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_176_4 = 0

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_5 = 2

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_5 then
				local var_176_6 = Color.New(0, 0, 0)

				var_176_6.a = Mathf.Lerp(0, 1, (arg_173_1.time_ - var_176_4) / var_176_5)
				arg_173_1.mask_.color = var_176_6
			end

			if arg_173_1.time_ >= var_176_4 + var_176_5 and arg_173_1.time_ < var_176_4 + var_176_5 + arg_176_0 then
				local var_176_7 = Color.New(0, 0, 0)

				var_176_7.a = 1
				arg_173_1.mask_.color = var_176_7
			end

			local var_176_8 = 2

			if 2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_9 = 2

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_9 then
				local var_176_10 = Color.New(0, 0, 0)

				var_176_10.a = Mathf.Lerp(1, 0, (arg_173_1.time_ - var_176_8) / var_176_9)
				arg_173_1.mask_.color = var_176_10
			end

			if arg_173_1.time_ >= var_176_8 + var_176_9 and arg_173_1.time_ < var_176_8 + var_176_9 + arg_176_0 then
				local var_176_11 = Color.New(0, 0, 0)

				arg_173_1.mask_.enabled = false
				var_176_11.a = 0
				arg_173_1.mask_.color = var_176_11
			end

			if arg_173_1.frameCnt_ <= 1 then
				arg_173_1.dialog_:SetActive(false)
			end

			local var_176_12 = 4
			local var_176_13 = 0.375

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				arg_173_1.dialog_:SetActive(true)

				arg_173_1.dialogCg_.alpha = 0

				local var_176_14 = LeanTween.value(arg_173_1.dialog_, 0, 1, 0.3)

				var_176_14:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_173_1.dialogCg_.alpha = arg_177_0
				end))
				var_176_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_173_1.dialog_)
					var_176_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_173_1.duration_ = arg_173_1.duration_ + 0.3

				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_15 = arg_173_1:GetWordFromCfg(318262042)
				local var_176_16 = arg_173_1:FormatText(var_176_15.content)

				arg_173_1.text_.text = var_176_16

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_18 = 15 <= 0 and var_176_13 or var_176_13 * (utf8.len(var_176_16) / 15)

				if (15 <= 0 and var_176_13 or var_176_13 * (utf8.len(var_176_16) / 15)) > 0 and var_176_13 < var_176_18 then
					arg_173_1.talkMaxDuration = var_176_18
					var_176_12 = var_176_12 + 0.3

					if var_176_18 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_18 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_16
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262042", "story_v_out_318262.awb") ~= 0 then
					local var_176_19 = manager.audio:GetVoiceLength("story_v_out_318262", "318262042", "story_v_out_318262.awb") / 1000

					if var_176_19 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_19 + var_176_12
					end

					if var_176_15.prefab_name ~= "" and arg_173_1.actors_[var_176_15.prefab_name] ~= nil then
						local var_176_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_15.prefab_name].transform, "story_v_out_318262", "318262042", "story_v_out_318262.awb")

						arg_173_1:RecordAudio("318262042", var_176_20)
						arg_173_1:RecordAudio("318262042", var_176_20)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_318262", "318262042", "story_v_out_318262.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_318262", "318262042", "story_v_out_318262.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_21 = var_176_12 + 0.3
			local var_176_22 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 + 0.3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_21 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_21) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_21 + var_176_22 and arg_173_1.time_ < var_176_21 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play318262043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 318262043
		arg_179_1.duration_ = 2.63

		local var_179_0 = {
			zh = 2.1,
			ja = 2.633
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
				arg_179_0:Play318262044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.225

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:GetWordFromCfg(318262043)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 9 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 9)

				if (9 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 9)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262043", "story_v_out_318262.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262043", "story_v_out_318262.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_318262", "318262043", "story_v_out_318262.awb")

						arg_179_1:RecordAudio("318262043", var_182_6)
						arg_179_1:RecordAudio("318262043", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_318262", "318262043", "story_v_out_318262.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_318262", "318262043", "story_v_out_318262.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play318262044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 318262044
		arg_183_1.duration_ = 5.37

		local var_183_0 = {
			zh = 5.366,
			ja = 4.266
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
				arg_183_0:Play318262045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.3

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[484].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:GetWordFromCfg(318262044)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 12 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 12)

				if (12 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 12)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262044", "story_v_out_318262.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262044", "story_v_out_318262.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_318262", "318262044", "story_v_out_318262.awb")

						arg_183_1:RecordAudio("318262044", var_186_6)
						arg_183_1:RecordAudio("318262044", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_318262", "318262044", "story_v_out_318262.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_318262", "318262044", "story_v_out_318262.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play318262045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 318262045
		arg_187_1.duration_ = 6.2

		local var_187_0 = {
			zh = 5.733,
			ja = 6.2
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
				arg_187_0:Play318262046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.575

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:GetWordFromCfg(318262045)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 23 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 23)

				if (23 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 23)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262045", "story_v_out_318262.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262045", "story_v_out_318262.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_318262", "318262045", "story_v_out_318262.awb")

						arg_187_1:RecordAudio("318262045", var_190_6)
						arg_187_1:RecordAudio("318262045", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_318262", "318262045", "story_v_out_318262.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_318262", "318262045", "story_v_out_318262.awb")
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
	Play318262046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 318262046
		arg_191_1.duration_ = 9.1

		local var_191_0 = {
			zh = 4.7,
			ja = 9.1
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
				arg_191_0:Play318262047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.375

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[484].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:GetWordFromCfg(318262046)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 15 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 15)

				if (15 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 15)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262046", "story_v_out_318262.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262046", "story_v_out_318262.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_318262", "318262046", "story_v_out_318262.awb")

						arg_191_1:RecordAudio("318262046", var_194_6)
						arg_191_1:RecordAudio("318262046", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_318262", "318262046", "story_v_out_318262.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_318262", "318262046", "story_v_out_318262.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play318262047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 318262047
		arg_195_1.duration_ = 3.27

		local var_195_0 = {
			zh = 1.266,
			ja = 3.266
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
				arg_195_0:Play318262048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.1

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(318262047)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 4 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 4)

				if (4 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 4)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262047", "story_v_out_318262.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262047", "story_v_out_318262.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_318262", "318262047", "story_v_out_318262.awb")

						arg_195_1:RecordAudio("318262047", var_198_6)
						arg_195_1:RecordAudio("318262047", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_318262", "318262047", "story_v_out_318262.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_318262", "318262047", "story_v_out_318262.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play318262048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 318262048
		arg_199_1.duration_ = 6.3

		local var_199_0 = {
			zh = 6.3,
			ja = 4.7
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play318262049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.475

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[484].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:GetWordFromCfg(318262048)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 19 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 19)

				if (19 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 19)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262048", "story_v_out_318262.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262048", "story_v_out_318262.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_318262", "318262048", "story_v_out_318262.awb")

						arg_199_1:RecordAudio("318262048", var_202_6)
						arg_199_1:RecordAudio("318262048", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_318262", "318262048", "story_v_out_318262.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_318262", "318262048", "story_v_out_318262.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play318262049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 318262049
		arg_203_1.duration_ = 4

		local var_203_0 = {
			zh = 4,
			ja = 2.7
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
				arg_203_0:Play318262050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.3

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[484].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:GetWordFromCfg(318262049)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 12 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 12)

				if (12 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 12)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262049", "story_v_out_318262.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262049", "story_v_out_318262.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_318262", "318262049", "story_v_out_318262.awb")

						arg_203_1:RecordAudio("318262049", var_206_6)
						arg_203_1:RecordAudio("318262049", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_318262", "318262049", "story_v_out_318262.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_318262", "318262049", "story_v_out_318262.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play318262050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 318262050
		arg_207_1.duration_ = 4.53

		local var_207_0 = {
			zh = 4.533,
			ja = 2.666
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play318262051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.275

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[484].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:GetWordFromCfg(318262050)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 11 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 11)

				if (11 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 11)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262050", "story_v_out_318262.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_318262", "318262050", "story_v_out_318262.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_318262", "318262050", "story_v_out_318262.awb")

						arg_207_1:RecordAudio("318262050", var_210_6)
						arg_207_1:RecordAudio("318262050", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_318262", "318262050", "story_v_out_318262.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_318262", "318262050", "story_v_out_318262.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play318262051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 318262051
		arg_211_1.duration_ = 9.07

		local var_211_0 = {
			zh = 8.499999999999,
			ja = 9.065999999999
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
				arg_211_0:Play318262052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 2 < arg_211_1.time_ and arg_211_1.time_ <= 2 + arg_214_0 then
				local var_214_0 = arg_211_1.bgs_.K16i

				arg_211_1.bgs_.K16i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_214_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_214_1 = var_214_0:GetComponent("SpriteRenderer")

				if var_214_1 and var_214_1.sprite then
					local var_214_2 = 2 * (var_214_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_214_0.transform.localScale = Vector3.New(var_214_2 / var_214_1.sprite.bounds.size.y < var_214_2 * manager.ui.mainCameraCom_.aspect / var_214_1.sprite.bounds.size.x and var_214_2 * manager.ui.mainCameraCom_.aspect / var_214_1.sprite.bounds.size.x or var_214_2 / var_214_1.sprite.bounds.size.y, var_214_2 / var_214_1.sprite.bounds.size.y < var_214_2 * manager.ui.mainCameraCom_.aspect / var_214_1.sprite.bounds.size.x and var_214_2 * manager.ui.mainCameraCom_.aspect / var_214_1.sprite.bounds.size.x or var_214_2 / var_214_1.sprite.bounds.size.y, 0)
				end

				for iter_214_0, iter_214_1 in pairs(arg_211_1.bgs_) do
					if iter_214_0 ~= "K16i" then
						iter_214_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_214_3 = 0

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.mask_.enabled = true
				arg_211_1.mask_.raycastTarget = true

				arg_211_1:SetGaussion(false)
			end

			local var_214_4 = 2

			if var_214_3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_3 + var_214_4 then
				local var_214_5 = Color.New(0, 0, 0)

				var_214_5.a = Mathf.Lerp(0, 1, (arg_211_1.time_ - var_214_3) / var_214_4)
				arg_211_1.mask_.color = var_214_5
			end

			if arg_211_1.time_ >= var_214_3 + var_214_4 and arg_211_1.time_ < var_214_3 + var_214_4 + arg_214_0 then
				local var_214_6 = Color.New(0, 0, 0)

				var_214_6.a = 1
				arg_211_1.mask_.color = var_214_6
			end

			local var_214_7 = 2

			if 2 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 then
				arg_211_1.mask_.enabled = true
				arg_211_1.mask_.raycastTarget = true

				arg_211_1:SetGaussion(false)
			end

			local var_214_8 = 2

			if var_214_7 <= arg_211_1.time_ and arg_211_1.time_ < var_214_7 + var_214_8 then
				local var_214_9 = Color.New(0, 0, 0)

				var_214_9.a = Mathf.Lerp(1, 0, (arg_211_1.time_ - var_214_7) / var_214_8)
				arg_211_1.mask_.color = var_214_9
			end

			if arg_211_1.time_ >= var_214_7 + var_214_8 and arg_211_1.time_ < var_214_7 + var_214_8 + arg_214_0 then
				local var_214_10 = Color.New(0, 0, 0)

				arg_211_1.mask_.enabled = false
				var_214_10.a = 0
				arg_211_1.mask_.color = var_214_10
			end

			local var_214_11 = arg_211_1.actors_["1049ui_story"].transform

			if 1.999999999999 < arg_211_1.time_ and arg_211_1.time_ <= 1.999999999999 + arg_214_0 then
				arg_211_1.var_.moveOldPos1049ui_story = var_214_11.localPosition
			end

			local var_214_12 = 0.001

			if 1.999999999999 <= arg_211_1.time_ and arg_211_1.time_ < 1.999999999999 + var_214_12 then
				var_214_11.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_211_1.time_ - 1.999999999999) / var_214_12)
				var_214_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_11.position).x, (manager.ui.mainCamera.transform.position - var_214_11.position).y, (manager.ui.mainCamera.transform.position - var_214_11.position).z)
				var_214_11.localEulerAngles.z = 0
				var_214_11.localEulerAngles.x = 0
				var_214_11.localEulerAngles = var_214_11.localEulerAngles
			end

			if arg_211_1.time_ >= 1.999999999999 + var_214_12 and arg_211_1.time_ < 1.999999999999 + var_214_12 + arg_214_0 then
				var_214_11.localPosition = Vector3.New(0, -1.2, -6)
				var_214_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_11.position).x, (manager.ui.mainCamera.transform.position - var_214_11.position).y, (manager.ui.mainCamera.transform.position - var_214_11.position).z)
				var_214_11.localEulerAngles.z = 0
				var_214_11.localEulerAngles.x = 0
				var_214_11.localEulerAngles = var_214_11.localEulerAngles
			end

			local var_214_13 = arg_211_1.actors_["1049ui_story"]

			if 1.999999999999 < arg_211_1.time_ and arg_211_1.time_ <= 1.999999999999 + arg_214_0 and not isNil(var_214_13) and arg_211_1.var_.characterEffect1049ui_story == nil then
				arg_211_1.var_.characterEffect1049ui_story = var_214_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_14 = 0.200000002980232

			if 1.999999999999 <= arg_211_1.time_ and arg_211_1.time_ < 1.999999999999 + var_214_14 and not isNil(var_214_13) then
				if arg_211_1.var_.characterEffect1049ui_story and not isNil(var_214_13) then
					arg_211_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 1.999999999999 + var_214_14 and arg_211_1.time_ < 1.999999999999 + var_214_14 + arg_214_0 and not isNil(var_214_13) and arg_211_1.var_.characterEffect1049ui_story then
				arg_211_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 1.999999999999 < arg_211_1.time_ and arg_211_1.time_ <= 1.999999999999 + arg_214_0 then
				arg_211_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 1.999999999999 < arg_211_1.time_ and arg_211_1.time_ <= 1.999999999999 + arg_214_0 then
				arg_211_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_211_1.frameCnt_ <= 1 then
				arg_211_1.dialog_:SetActive(false)
			end

			local var_214_16 = 3.999999999999
			local var_214_17 = 0.45

			if 3.999999999999 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				arg_211_1.dialog_:SetActive(true)

				arg_211_1.dialogCg_.alpha = 0

				local var_214_18 = LeanTween.value(arg_211_1.dialog_, 0, 1, 0.3)

				var_214_18:setOnUpdate(LuaHelper.FloatAction(function(arg_215_0)
					arg_211_1.dialogCg_.alpha = arg_215_0
				end))
				var_214_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_211_1.dialog_)
					var_214_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_211_1.duration_ = arg_211_1.duration_ + 0.3

				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_19 = arg_211_1:GetWordFromCfg(318262051)
				local var_214_20 = arg_211_1:FormatText(var_214_19.content)

				arg_211_1.text_.text = var_214_20

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_22 = 18 <= 0 and var_214_17 or var_214_17 * (utf8.len(var_214_20) / 18)

				if (18 <= 0 and var_214_17 or var_214_17 * (utf8.len(var_214_20) / 18)) > 0 and var_214_17 < var_214_22 then
					arg_211_1.talkMaxDuration = var_214_22
					var_214_16 = var_214_16 + 0.3

					if var_214_22 + var_214_16 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_22 + var_214_16
					end
				end

				arg_211_1.text_.text = var_214_20
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262051", "story_v_out_318262.awb") ~= 0 then
					local var_214_23 = manager.audio:GetVoiceLength("story_v_out_318262", "318262051", "story_v_out_318262.awb") / 1000

					if var_214_23 + var_214_16 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_16
					end

					if var_214_19.prefab_name ~= "" and arg_211_1.actors_[var_214_19.prefab_name] ~= nil then
						local var_214_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_19.prefab_name].transform, "story_v_out_318262", "318262051", "story_v_out_318262.awb")

						arg_211_1:RecordAudio("318262051", var_214_24)
						arg_211_1:RecordAudio("318262051", var_214_24)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_318262", "318262051", "story_v_out_318262.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_318262", "318262051", "story_v_out_318262.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_25 = var_214_16 + 0.3
			local var_214_26 = math.max(var_214_17, arg_211_1.talkMaxDuration)

			if var_214_16 + 0.3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_25 + var_214_26 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_25) / var_214_26

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_25 + var_214_26 and arg_211_1.time_ < var_214_25 + var_214_26 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play318262052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 318262052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play318262053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1049ui_story = arg_217_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1049ui_story"].transform.position).z)
				arg_217_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1049ui_story"].transform.localEulerAngles = arg_217_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1049ui_story"].transform.position).z)
				arg_217_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1049ui_story"].transform.localEulerAngles = arg_217_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1049ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1049ui_story == nil then
				arg_217_1.var_.characterEffect1049ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1049ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_2)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1049ui_story then
				arg_217_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_220_3 = 0
			local var_220_4 = 1.3

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_5 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(318262052).content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 52 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_5) / 52)

				if (52 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_5) / 52)) > 0 and var_220_4 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_3
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_4, arg_217_1.talkMaxDuration)

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_3) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_3 + var_220_8 and arg_217_1.time_ < var_220_3 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play318262053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 318262053
		arg_221_1.duration_ = 5.6

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play318262054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_0 = 0.6

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				local var_224_1 = Color.New(1, 1, 1)

				var_224_1.a = Mathf.Lerp(1, 0, (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.mask_.color = var_224_1
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				local var_224_2 = Color.New(1, 1, 1)

				arg_221_1.mask_.enabled = false
				var_224_2.a = 0
				arg_221_1.mask_.color = var_224_2
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_3 = 0.6
			local var_224_4 = 1.65

			if 0.6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_5 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_5:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(318262053).content)

				arg_221_1.text_.text = var_224_6

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_8 = 66 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_6) / 66)

				if (66 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_6) / 66)) > 0 and var_224_4 < var_224_8 then
					arg_221_1.talkMaxDuration = var_224_8
					var_224_3 = var_224_3 + 0.3

					if var_224_8 + var_224_3 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_3
					end
				end

				arg_221_1.text_.text = var_224_6
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_9 = var_224_3 + 0.3
			local var_224_10 = math.max(var_224_4, arg_221_1.talkMaxDuration)

			if var_224_3 + 0.3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_9) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_9 + var_224_10 and arg_221_1.time_ < var_224_9 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play318262054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 318262054
		arg_227_1.duration_ = 5.73

		local var_227_0 = {
			zh = 5.733,
			ja = 5.033
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
				arg_227_0:Play318262055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1049ui_story = arg_227_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1049ui_story"].transform.position).z)
				arg_227_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1049ui_story"].transform.localEulerAngles = arg_227_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_227_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1049ui_story"].transform.position).z)
				arg_227_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1049ui_story"].transform.localEulerAngles = arg_227_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1049ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1049ui_story == nil then
				arg_227_1.var_.characterEffect1049ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1049ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1049ui_story then
				arg_227_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_4 = 0
			local var_230_5 = 0.35

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(318262054)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 14 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 14)

				if (14 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 14)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262054", "story_v_out_318262.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262054", "story_v_out_318262.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_out_318262", "318262054", "story_v_out_318262.awb")

						arg_227_1:RecordAudio("318262054", var_230_11)
						arg_227_1:RecordAudio("318262054", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_318262", "318262054", "story_v_out_318262.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_318262", "318262054", "story_v_out_318262.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play318262055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 318262055
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play318262056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1049ui_story = arg_231_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1049ui_story"].transform.position).z)
				arg_231_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1049ui_story"].transform.localEulerAngles = arg_231_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1049ui_story"].transform.position).z)
				arg_231_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1049ui_story"].transform.localEulerAngles = arg_231_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1049ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1049ui_story == nil then
				arg_231_1.var_.characterEffect1049ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1049ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_2)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1049ui_story then
				arg_231_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_234_3 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_3 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_4 = 0.6

			if var_234_3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_3 + var_234_4 then
				local var_234_5 = Color.New(1, 1, 1)

				var_234_5.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_3) / var_234_4)
				arg_231_1.mask_.color = var_234_5
			end

			if arg_231_1.time_ >= var_234_3 + var_234_4 and arg_231_1.time_ < var_234_3 + var_234_4 + arg_234_0 then
				local var_234_6 = Color.New(1, 1, 1)

				arg_231_1.mask_.enabled = false
				var_234_6.a = 0
				arg_231_1.mask_.color = var_234_6
			end

			local var_234_7 = manager.ui.mainCamera.transform

			if 0.200000002980232 < arg_231_1.time_ and arg_231_1.time_ <= 0.200000002980232 + arg_234_0 then
				arg_231_1.var_.shakeOldPos = var_234_7.localPosition
			end

			local var_234_8 = 1

			if 0.200000002980232 <= arg_231_1.time_ and arg_231_1.time_ < 0.200000002980232 + var_234_8 then
				local var_234_9, var_234_10 = math.modf((arg_231_1.time_ - 0.200000002980232) / 0.066)

				var_234_7.localPosition = Vector3.New(var_234_10 * 0.13, var_234_10 * 0.13, var_234_10 * 0.13) + arg_231_1.var_.shakeOldPos
			end

			if arg_231_1.time_ >= 0.200000002980232 + var_234_8 and arg_231_1.time_ < 0.200000002980232 + var_234_8 + arg_234_0 then
				var_234_7.localPosition = arg_231_1.var_.shakeOldPos
			end

			local var_234_11 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			if arg_231_1.time_ >= var_234_11 + 1.20000000298023 and arg_231_1.time_ < var_234_11 + 1.20000000298023 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_power", "")
			end

			local var_234_13 = 0
			local var_234_14 = 1.7

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_13 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_15 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(318262055).content)

				arg_231_1.text_.text = var_234_15

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_17 = 68 <= 0 and var_234_14 or var_234_14 * (utf8.len(var_234_15) / 68)

				if (68 <= 0 and var_234_14 or var_234_14 * (utf8.len(var_234_15) / 68)) > 0 and var_234_14 < var_234_17 then
					arg_231_1.talkMaxDuration = var_234_17

					if var_234_17 + var_234_13 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_17 + var_234_13
					end
				end

				arg_231_1.text_.text = var_234_15
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_18 = math.max(var_234_14, arg_231_1.talkMaxDuration)

			if var_234_13 <= arg_231_1.time_ and arg_231_1.time_ < var_234_13 + var_234_18 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_13) / var_234_18

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_13 + var_234_18 and arg_231_1.time_ < var_234_13 + var_234_18 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play318262056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 318262056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play318262057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.05

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(318262056).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 42 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 42)

				if (42 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 42)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play318262057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 318262057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play318262058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.8

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(318262057).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 32 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 32)

				if (32 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 32)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play318262058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 318262058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play318262059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.225

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(318262058).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 9 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 9)

				if (9 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 9)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play318262059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 318262059
		arg_247_1.duration_ = 8.33

		local var_247_0 = {
			zh = 4.166,
			ja = 8.333
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play318262060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1049ui_story = arg_247_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1049ui_story"].transform.position).z)
				arg_247_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1049ui_story"].transform.localEulerAngles = arg_247_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_247_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1049ui_story"].transform.position).z)
				arg_247_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1049ui_story"].transform.localEulerAngles = arg_247_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1049ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1049ui_story == nil then
				arg_247_1.var_.characterEffect1049ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1049ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1049ui_story then
				arg_247_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_250_4 = 0
			local var_250_5 = 0.425

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:GetWordFromCfg(318262059)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 17 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 17)

				if (17 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 17)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262059", "story_v_out_318262.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262059", "story_v_out_318262.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_out_318262", "318262059", "story_v_out_318262.awb")

						arg_247_1:RecordAudio("318262059", var_250_11)
						arg_247_1:RecordAudio("318262059", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_318262", "318262059", "story_v_out_318262.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_318262", "318262059", "story_v_out_318262.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play318262060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 318262060
		arg_251_1.duration_ = 3.47

		local var_251_0 = {
			zh = 3.466,
			ja = 1.466
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play318262061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1049ui_story = arg_251_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).z)
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles = arg_251_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_251_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1049ui_story"].transform.position).z)
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1049ui_story"].transform.localEulerAngles = arg_251_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1049ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1049ui_story == nil then
				arg_251_1.var_.characterEffect1049ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1049ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1049ui_story then
				arg_251_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_4 = 0
			local var_254_5 = 0.275

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:GetWordFromCfg(318262060)
				local var_254_7 = arg_251_1:FormatText(var_254_6.content)

				arg_251_1.text_.text = var_254_7

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_9 = 11 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 11)

				if (11 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 11)) > 0 and var_254_5 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_7
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262060", "story_v_out_318262.awb") ~= 0 then
					local var_254_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262060", "story_v_out_318262.awb") / 1000

					if var_254_10 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_4
					end

					if var_254_6.prefab_name ~= "" and arg_251_1.actors_[var_254_6.prefab_name] ~= nil then
						local var_254_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_6.prefab_name].transform, "story_v_out_318262", "318262060", "story_v_out_318262.awb")

						arg_251_1:RecordAudio("318262060", var_254_11)
						arg_251_1:RecordAudio("318262060", var_254_11)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_318262", "318262060", "story_v_out_318262.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_318262", "318262060", "story_v_out_318262.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_12 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_12 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_12

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_12 and arg_251_1.time_ < var_254_4 + var_254_12 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play318262061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 318262061
		arg_255_1.duration_ = 4.5

		local var_255_0 = {
			zh = 4.5,
			ja = 3.4
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play318262062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if arg_255_1.actors_["10065ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10065ui_story"))) then
				local var_258_0 = Object.Instantiate(Asset.Load("Char/" .. "10065ui_story"), arg_255_1.stage_.transform)

				var_258_0.name = "10065ui_story"
				var_258_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.actors_["10065ui_story"] = var_258_0

				local var_258_1 = var_258_0:GetComponentInChildren(typeof(CharacterEffect))

				var_258_1.enabled = true

				local var_258_2 = GameObjectTools.GetOrAddComponent(var_258_0, typeof(DynamicBoneHelper))

				if var_258_2 then
					var_258_2:EnableDynamicBone(false)
				end

				arg_255_1:ShowWeapon(var_258_1.transform, false)

				arg_255_1.var_["10065ui_story" .. "Animator"] = var_258_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_255_1.var_["10065ui_story" .. "Animator"].applyRootMotion = true
				arg_255_1.var_["10065ui_story" .. "LipSync"] = var_258_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_258_3 = arg_255_1.actors_["10065ui_story"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10065ui_story = var_258_3.localPosition
			end

			local var_258_4 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				var_258_3.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_255_1.time_ - 0) / var_258_4)
				var_258_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_3.position).x, (manager.ui.mainCamera.transform.position - var_258_3.position).y, (manager.ui.mainCamera.transform.position - var_258_3.position).z)
				var_258_3.localEulerAngles.z = 0
				var_258_3.localEulerAngles.x = 0
				var_258_3.localEulerAngles = var_258_3.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				var_258_3.localPosition = Vector3.New(0, -0.81, -6.19)
				var_258_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_3.position).x, (manager.ui.mainCamera.transform.position - var_258_3.position).y, (manager.ui.mainCamera.transform.position - var_258_3.position).z)
				var_258_3.localEulerAngles.z = 0
				var_258_3.localEulerAngles.x = 0
				var_258_3.localEulerAngles = var_258_3.localEulerAngles
			end

			local var_258_5 = arg_255_1.actors_["10065ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.characterEffect10065ui_story == nil then
				arg_255_1.var_.characterEffect10065ui_story = var_258_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_6 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_6 and not isNil(var_258_5) then
				if arg_255_1.var_.characterEffect10065ui_story and not isNil(var_258_5) then
					arg_255_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_6 and arg_255_1.time_ < 0 + var_258_6 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.characterEffect10065ui_story then
				arg_255_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action2_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_258_8 = arg_255_1.actors_["1049ui_story"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1049ui_story = var_258_8.localPosition
			end

			local var_258_9 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_9 then
				var_258_8.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 0) / var_258_9)
				var_258_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_8.position).x, (manager.ui.mainCamera.transform.position - var_258_8.position).y, (manager.ui.mainCamera.transform.position - var_258_8.position).z)
				var_258_8.localEulerAngles.z = 0
				var_258_8.localEulerAngles.x = 0
				var_258_8.localEulerAngles = var_258_8.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_9 and arg_255_1.time_ < 0 + var_258_9 + arg_258_0 then
				var_258_8.localPosition = Vector3.New(0, 100, 0)
				var_258_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_8.position).x, (manager.ui.mainCamera.transform.position - var_258_8.position).y, (manager.ui.mainCamera.transform.position - var_258_8.position).z)
				var_258_8.localEulerAngles.z = 0
				var_258_8.localEulerAngles.x = 0
				var_258_8.localEulerAngles = var_258_8.localEulerAngles
			end

			local var_258_10 = arg_255_1.actors_["1049ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_10) and arg_255_1.var_.characterEffect1049ui_story == nil then
				arg_255_1.var_.characterEffect1049ui_story = var_258_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_11 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_11 and not isNil(var_258_10) then
				if arg_255_1.var_.characterEffect1049ui_story and not isNil(var_258_10) then
					arg_255_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_11)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_11 and arg_255_1.time_ < 0 + var_258_11 + arg_258_0 and not isNil(var_258_10) and arg_255_1.var_.characterEffect1049ui_story then
				arg_255_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_258_12 = 0
			local var_258_13 = 0.25

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_12 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_14 = arg_255_1:GetWordFromCfg(318262061)
				local var_258_15 = arg_255_1:FormatText(var_258_14.content)

				arg_255_1.text_.text = var_258_15

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_17 = 10 <= 0 and var_258_13 or var_258_13 * (utf8.len(var_258_15) / 10)

				if (10 <= 0 and var_258_13 or var_258_13 * (utf8.len(var_258_15) / 10)) > 0 and var_258_13 < var_258_17 then
					arg_255_1.talkMaxDuration = var_258_17

					if var_258_17 + var_258_12 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_17 + var_258_12
					end
				end

				arg_255_1.text_.text = var_258_15
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262061", "story_v_out_318262.awb") ~= 0 then
					local var_258_18 = manager.audio:GetVoiceLength("story_v_out_318262", "318262061", "story_v_out_318262.awb") / 1000

					if var_258_18 + var_258_12 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_18 + var_258_12
					end

					if var_258_14.prefab_name ~= "" and arg_255_1.actors_[var_258_14.prefab_name] ~= nil then
						local var_258_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_14.prefab_name].transform, "story_v_out_318262", "318262061", "story_v_out_318262.awb")

						arg_255_1:RecordAudio("318262061", var_258_19)
						arg_255_1:RecordAudio("318262061", var_258_19)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_318262", "318262061", "story_v_out_318262.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_318262", "318262061", "story_v_out_318262.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_20 = math.max(var_258_13, arg_255_1.talkMaxDuration)

			if var_258_12 <= arg_255_1.time_ and arg_255_1.time_ < var_258_12 + var_258_20 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_12) / var_258_20

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_12 + var_258_20 and arg_255_1.time_ < var_258_12 + var_258_20 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play318262062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 318262062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play318262063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10065ui_story = arg_259_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10065ui_story"].transform.position).z)
				arg_259_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10065ui_story"].transform.localEulerAngles = arg_259_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10065ui_story"].transform.position).z)
				arg_259_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10065ui_story"].transform.localEulerAngles = arg_259_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["10065ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect10065ui_story == nil then
				arg_259_1.var_.characterEffect10065ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect10065ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_2)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect10065ui_story then
				arg_259_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_262_3 = 0
			local var_262_4 = 0.85

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_3 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_5 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(318262062).content)

				arg_259_1.text_.text = var_262_5

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_7 = 34 <= 0 and var_262_4 or var_262_4 * (utf8.len(var_262_5) / 34)

				if (34 <= 0 and var_262_4 or var_262_4 * (utf8.len(var_262_5) / 34)) > 0 and var_262_4 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_3 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_3
					end
				end

				arg_259_1.text_.text = var_262_5
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_8 = math.max(var_262_4, arg_259_1.talkMaxDuration)

			if var_262_3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_3 + var_262_8 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_3) / var_262_8

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_3 + var_262_8 and arg_259_1.time_ < var_262_3 + var_262_8 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play318262063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 318262063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play318262064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_power", "")
			end

			local var_266_1 = 0
			local var_266_2 = 1.3

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(318262063).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 52 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 52)

				if (52 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 52)) > 0 and var_266_2 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_6 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_6 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_6

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_6 and arg_263_1.time_ < var_266_1 + var_266_6 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play318262064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 318262064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play318262065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_270_0 = 0.6

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				local var_270_1, var_270_2 = math.modf((arg_267_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_270_2 * 0.13, var_270_2 * 0.13, var_270_2 * 0.13) + arg_267_1.var_.shakeOldPos
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				manager.ui.mainCamera.transform.localPosition = arg_267_1.var_.shakeOldPos
			end

			local var_270_3 = 0

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_3 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			if arg_267_1.time_ >= var_270_3 + 0.6 and arg_267_1.time_ < var_270_3 + 0.6 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_hit", "")
			end

			local var_270_5 = 0
			local var_270_6 = 1.5

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(318262064).content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 60 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_7) / 60)

				if (60 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_7) / 60)) > 0 and var_270_6 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_10 and arg_267_1.time_ < var_270_5 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play318262065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 318262065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play318262066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.4

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(318262065).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 16 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 16)

				if (16 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 16)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play318262066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 318262066
		arg_275_1.duration_ = 3.63

		local var_275_0 = {
			zh = 2.533,
			ja = 3.633
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
				arg_275_0:Play318262067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1049ui_story = arg_275_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).z)
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles = arg_275_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_275_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).z)
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles = arg_275_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1049ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1049ui_story == nil then
				arg_275_1.var_.characterEffect1049ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1049ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1049ui_story then
				arg_275_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action9_2")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_278_4 = 0
			local var_278_5 = 0.25

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:GetWordFromCfg(318262066)
				local var_278_7 = arg_275_1:FormatText(var_278_6.content)

				arg_275_1.text_.text = var_278_7

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 10 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 10)

				if (10 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 10)) > 0 and var_278_5 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_7
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262066", "story_v_out_318262.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262066", "story_v_out_318262.awb") / 1000

					if var_278_10 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_4
					end

					if var_278_6.prefab_name ~= "" and arg_275_1.actors_[var_278_6.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_6.prefab_name].transform, "story_v_out_318262", "318262066", "story_v_out_318262.awb")

						arg_275_1:RecordAudio("318262066", var_278_11)
						arg_275_1:RecordAudio("318262066", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_318262", "318262066", "story_v_out_318262.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_318262", "318262066", "story_v_out_318262.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_12 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_12 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_12

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_12 and arg_275_1.time_ < var_278_4 + var_278_12 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play318262067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 318262067
		arg_279_1.duration_ = 4.4

		local var_279_0 = {
			zh = 2.666,
			ja = 4.4
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
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play318262068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10065ui_story = arg_279_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10065ui_story"].transform.position).z)
				arg_279_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["10065ui_story"].transform.localEulerAngles = arg_279_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, -0.81, -6.19)
				arg_279_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10065ui_story"].transform.position).z)
				arg_279_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["10065ui_story"].transform.localEulerAngles = arg_279_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["10065ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect10065ui_story == nil then
				arg_279_1.var_.characterEffect10065ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect10065ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect10065ui_story then
				arg_279_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action1_1")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_282_4 = arg_279_1.actors_["1049ui_story"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1049ui_story = var_282_4.localPosition
			end

			local var_282_5 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_5 then
				var_282_4.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_5)
				var_282_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_4.position).x, (manager.ui.mainCamera.transform.position - var_282_4.position).y, (manager.ui.mainCamera.transform.position - var_282_4.position).z)
				var_282_4.localEulerAngles.z = 0
				var_282_4.localEulerAngles.x = 0
				var_282_4.localEulerAngles = var_282_4.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_5 and arg_279_1.time_ < 0 + var_282_5 + arg_282_0 then
				var_282_4.localPosition = Vector3.New(0, 100, 0)
				var_282_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_4.position).x, (manager.ui.mainCamera.transform.position - var_282_4.position).y, (manager.ui.mainCamera.transform.position - var_282_4.position).z)
				var_282_4.localEulerAngles.z = 0
				var_282_4.localEulerAngles.x = 0
				var_282_4.localEulerAngles = var_282_4.localEulerAngles
			end

			local var_282_6 = arg_279_1.actors_["1049ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_6) and arg_279_1.var_.characterEffect1049ui_story == nil then
				arg_279_1.var_.characterEffect1049ui_story = var_282_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_7 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 and not isNil(var_282_6) then
				if arg_279_1.var_.characterEffect1049ui_story and not isNil(var_282_6) then
					arg_279_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_7)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 and not isNil(var_282_6) and arg_279_1.var_.characterEffect1049ui_story then
				arg_279_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_282_8 = 0
			local var_282_9 = 0.15

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_10 = arg_279_1:GetWordFromCfg(318262067)
				local var_282_11 = arg_279_1:FormatText(var_282_10.content)

				arg_279_1.text_.text = var_282_11

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_13 = 6 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 6)

				if (6 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 6)) > 0 and var_282_9 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_11
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262067", "story_v_out_318262.awb") ~= 0 then
					local var_282_14 = manager.audio:GetVoiceLength("story_v_out_318262", "318262067", "story_v_out_318262.awb") / 1000

					if var_282_14 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_14 + var_282_8
					end

					if var_282_10.prefab_name ~= "" and arg_279_1.actors_[var_282_10.prefab_name] ~= nil then
						local var_282_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_10.prefab_name].transform, "story_v_out_318262", "318262067", "story_v_out_318262.awb")

						arg_279_1:RecordAudio("318262067", var_282_15)
						arg_279_1:RecordAudio("318262067", var_282_15)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_318262", "318262067", "story_v_out_318262.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_318262", "318262067", "story_v_out_318262.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_16 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_16

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_16 and arg_279_1.time_ < var_282_8 + var_282_16 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play318262068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 318262068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play318262069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10065ui_story = arg_283_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10065ui_story"].transform.position).z)
				arg_283_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10065ui_story"].transform.localEulerAngles = arg_283_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_283_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["10065ui_story"].transform.position).z)
				arg_283_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["10065ui_story"].transform.localEulerAngles = arg_283_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["10065ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect10065ui_story == nil then
				arg_283_1.var_.characterEffect10065ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect10065ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_283_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_2)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect10065ui_story then
				arg_283_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_283_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_286_3 = 0
			local var_286_4 = 0.4

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_3 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_5 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(318262068).content)

				arg_283_1.text_.text = var_286_5

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_7 = 16 <= 0 and var_286_4 or var_286_4 * (utf8.len(var_286_5) / 16)

				if (16 <= 0 and var_286_4 or var_286_4 * (utf8.len(var_286_5) / 16)) > 0 and var_286_4 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_3 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_3
					end
				end

				arg_283_1.text_.text = var_286_5
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_8 = math.max(var_286_4, arg_283_1.talkMaxDuration)

			if var_286_3 <= arg_283_1.time_ and arg_283_1.time_ < var_286_3 + var_286_8 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_3) / var_286_8

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_3 + var_286_8 and arg_283_1.time_ < var_286_3 + var_286_8 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play318262069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 318262069
		arg_287_1.duration_ = 11.7

		local var_287_0 = {
			zh = 6.666,
			ja = 11.7
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
				arg_287_0:Play318262070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10065ui_story = arg_287_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10065ui_story"].transform.position).z)
				arg_287_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["10065ui_story"].transform.localEulerAngles = arg_287_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, -0.81, -6.19)
				arg_287_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10065ui_story"].transform.position).z)
				arg_287_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["10065ui_story"].transform.localEulerAngles = arg_287_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["10065ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect10065ui_story == nil then
				arg_287_1.var_.characterEffect10065ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect10065ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect10065ui_story then
				arg_287_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action4_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_290_4 = 0
			local var_290_5 = 0.625

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:GetWordFromCfg(318262069)
				local var_290_7 = arg_287_1:FormatText(var_290_6.content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 25 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 25)

				if (25 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 25)) > 0 and var_290_5 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262069", "story_v_out_318262.awb") ~= 0 then
					local var_290_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262069", "story_v_out_318262.awb") / 1000

					if var_290_10 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_4
					end

					if var_290_6.prefab_name ~= "" and arg_287_1.actors_[var_290_6.prefab_name] ~= nil then
						local var_290_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_6.prefab_name].transform, "story_v_out_318262", "318262069", "story_v_out_318262.awb")

						arg_287_1:RecordAudio("318262069", var_290_11)
						arg_287_1:RecordAudio("318262069", var_290_11)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_318262", "318262069", "story_v_out_318262.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_318262", "318262069", "story_v_out_318262.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_12 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_12 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_12

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_12 and arg_287_1.time_ < var_290_4 + var_290_12 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play318262070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 318262070
		arg_291_1.duration_ = 4.5

		local var_291_0 = {
			zh = 4.333,
			ja = 4.5
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
				arg_291_0:Play318262071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1049ui_story = arg_291_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1049ui_story"].transform.position).z)
				arg_291_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1049ui_story"].transform.localEulerAngles = arg_291_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_291_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1049ui_story"].transform.position).z)
				arg_291_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1049ui_story"].transform.localEulerAngles = arg_291_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["1049ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1049ui_story == nil then
				arg_291_1.var_.characterEffect1049ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect1049ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1049ui_story then
				arg_291_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_294_4 = arg_291_1.actors_["10065ui_story"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10065ui_story = var_294_4.localPosition
			end

			local var_294_5 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_5 then
				var_294_4.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 0) / var_294_5)
				var_294_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_4.position).x, (manager.ui.mainCamera.transform.position - var_294_4.position).y, (manager.ui.mainCamera.transform.position - var_294_4.position).z)
				var_294_4.localEulerAngles.z = 0
				var_294_4.localEulerAngles.x = 0
				var_294_4.localEulerAngles = var_294_4.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_5 and arg_291_1.time_ < 0 + var_294_5 + arg_294_0 then
				var_294_4.localPosition = Vector3.New(0, 100, 0)
				var_294_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_4.position).x, (manager.ui.mainCamera.transform.position - var_294_4.position).y, (manager.ui.mainCamera.transform.position - var_294_4.position).z)
				var_294_4.localEulerAngles.z = 0
				var_294_4.localEulerAngles.x = 0
				var_294_4.localEulerAngles = var_294_4.localEulerAngles
			end

			local var_294_6 = arg_291_1.actors_["10065ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_6) and arg_291_1.var_.characterEffect10065ui_story == nil then
				arg_291_1.var_.characterEffect10065ui_story = var_294_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_7 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 and not isNil(var_294_6) then
				if arg_291_1.var_.characterEffect10065ui_story and not isNil(var_294_6) then
					arg_291_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_7)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 and not isNil(var_294_6) and arg_291_1.var_.characterEffect10065ui_story then
				arg_291_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_294_8 = 0
			local var_294_9 = 0.375

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_10 = arg_291_1:GetWordFromCfg(318262070)
				local var_294_11 = arg_291_1:FormatText(var_294_10.content)

				arg_291_1.text_.text = var_294_11

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_13 = 15 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_11) / 15)

				if (15 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_11) / 15)) > 0 and var_294_9 < var_294_13 then
					arg_291_1.talkMaxDuration = var_294_13

					if var_294_13 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_11
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262070", "story_v_out_318262.awb") ~= 0 then
					local var_294_14 = manager.audio:GetVoiceLength("story_v_out_318262", "318262070", "story_v_out_318262.awb") / 1000

					if var_294_14 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_14 + var_294_8
					end

					if var_294_10.prefab_name ~= "" and arg_291_1.actors_[var_294_10.prefab_name] ~= nil then
						local var_294_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_10.prefab_name].transform, "story_v_out_318262", "318262070", "story_v_out_318262.awb")

						arg_291_1:RecordAudio("318262070", var_294_15)
						arg_291_1:RecordAudio("318262070", var_294_15)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_318262", "318262070", "story_v_out_318262.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_318262", "318262070", "story_v_out_318262.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_16 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_16 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_16

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_16 and arg_291_1.time_ < var_294_8 + var_294_16 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play318262071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 318262071
		arg_295_1.duration_ = 15.5

		local var_295_0 = {
			zh = 10.233,
			ja = 15.5
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
				arg_295_0:Play318262072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10065ui_story = arg_295_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10065ui_story"].transform.position).z)
				arg_295_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["10065ui_story"].transform.localEulerAngles = arg_295_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, -0.81, -6.19)
				arg_295_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["10065ui_story"].transform.position).z)
				arg_295_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["10065ui_story"].transform.localEulerAngles = arg_295_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["10065ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect10065ui_story == nil then
				arg_295_1.var_.characterEffect10065ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect10065ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect10065ui_story then
				arg_295_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action4_2")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_4 = arg_295_1.actors_["1049ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_4) and arg_295_1.var_.characterEffect1049ui_story == nil then
				arg_295_1.var_.characterEffect1049ui_story = var_298_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_5 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_5 and not isNil(var_298_4) then
				if arg_295_1.var_.characterEffect1049ui_story and not isNil(var_298_4) then
					arg_295_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_5)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_5 and arg_295_1.time_ < 0 + var_298_5 + arg_298_0 and not isNil(var_298_4) and arg_295_1.var_.characterEffect1049ui_story then
				arg_295_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_298_6 = arg_295_1.actors_["1049ui_story"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1049ui_story = var_298_6.localPosition
			end

			local var_298_7 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				var_298_6.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_7)
				var_298_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_6.position).x, (manager.ui.mainCamera.transform.position - var_298_6.position).y, (manager.ui.mainCamera.transform.position - var_298_6.position).z)
				var_298_6.localEulerAngles.z = 0
				var_298_6.localEulerAngles.x = 0
				var_298_6.localEulerAngles = var_298_6.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				var_298_6.localPosition = Vector3.New(0, 100, 0)
				var_298_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_6.position).x, (manager.ui.mainCamera.transform.position - var_298_6.position).y, (manager.ui.mainCamera.transform.position - var_298_6.position).z)
				var_298_6.localEulerAngles.z = 0
				var_298_6.localEulerAngles.x = 0
				var_298_6.localEulerAngles = var_298_6.localEulerAngles
			end

			local var_298_8 = 0
			local var_298_9 = 1.05

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_10 = arg_295_1:GetWordFromCfg(318262071)
				local var_298_11 = arg_295_1:FormatText(var_298_10.content)

				arg_295_1.text_.text = var_298_11

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_13 = 42 <= 0 and var_298_9 or var_298_9 * (utf8.len(var_298_11) / 42)

				if (42 <= 0 and var_298_9 or var_298_9 * (utf8.len(var_298_11) / 42)) > 0 and var_298_9 < var_298_13 then
					arg_295_1.talkMaxDuration = var_298_13

					if var_298_13 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_13 + var_298_8
					end
				end

				arg_295_1.text_.text = var_298_11
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262071", "story_v_out_318262.awb") ~= 0 then
					local var_298_14 = manager.audio:GetVoiceLength("story_v_out_318262", "318262071", "story_v_out_318262.awb") / 1000

					if var_298_14 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_14 + var_298_8
					end

					if var_298_10.prefab_name ~= "" and arg_295_1.actors_[var_298_10.prefab_name] ~= nil then
						local var_298_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_10.prefab_name].transform, "story_v_out_318262", "318262071", "story_v_out_318262.awb")

						arg_295_1:RecordAudio("318262071", var_298_15)
						arg_295_1:RecordAudio("318262071", var_298_15)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_318262", "318262071", "story_v_out_318262.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_318262", "318262071", "story_v_out_318262.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_16 = math.max(var_298_9, arg_295_1.talkMaxDuration)

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_16 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_8) / var_298_16

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_8 + var_298_16 and arg_295_1.time_ < var_298_8 + var_298_16 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play318262072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 318262072
		arg_299_1.duration_ = 7.8

		local var_299_0 = {
			zh = 7.8,
			ja = 7.133
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
				arg_299_0:Play318262073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10065ui_story = arg_299_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10065ui_story"].transform.position).z)
				arg_299_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["10065ui_story"].transform.localEulerAngles = arg_299_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, -0.81, -6.19)
				arg_299_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10065ui_story"].transform.position).z)
				arg_299_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["10065ui_story"].transform.localEulerAngles = arg_299_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["10065ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect10065ui_story == nil then
				arg_299_1.var_.characterEffect10065ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect10065ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect10065ui_story then
				arg_299_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action1_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_302_4 = 0
			local var_302_5 = 0.65

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:GetWordFromCfg(318262072)
				local var_302_7 = arg_299_1:FormatText(var_302_6.content)

				arg_299_1.text_.text = var_302_7

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_9 = 26 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 26)

				if (26 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 26)) > 0 and var_302_5 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_7
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262072", "story_v_out_318262.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262072", "story_v_out_318262.awb") / 1000

					if var_302_10 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_4
					end

					if var_302_6.prefab_name ~= "" and arg_299_1.actors_[var_302_6.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_6.prefab_name].transform, "story_v_out_318262", "318262072", "story_v_out_318262.awb")

						arg_299_1:RecordAudio("318262072", var_302_11)
						arg_299_1:RecordAudio("318262072", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_318262", "318262072", "story_v_out_318262.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_318262", "318262072", "story_v_out_318262.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_12 = math.max(var_302_5, arg_299_1.talkMaxDuration)

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_12 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_4) / var_302_12

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_4 + var_302_12 and arg_299_1.time_ < var_302_4 + var_302_12 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play318262073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 318262073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play318262074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_9000

			if arg_303_1.bgs_.K16i_blur == nil then
				local var_306_0 = Object.Instantiate(arg_303_1.paintGo_)

				var_306_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K16i_blur")
				var_306_0.name = "K16i_blur"
				var_306_0.transform.parent = arg_303_1.stage_.transform
				var_306_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_303_1.bgs_.K16i_blur = var_306_0
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				local var_306_1 = arg_303_1.bgs_.K16i_blur

				arg_303_1.bgs_.K16i_blur.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_306_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_306_2 = var_306_1:GetComponent("SpriteRenderer")

				if var_306_2 and var_306_2.sprite then
					local var_306_3 = 2 * (var_306_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_306_1.transform.localScale = Vector3.New(var_306_3 / var_306_2.sprite.bounds.size.y < var_306_3 * manager.ui.mainCameraCom_.aspect / var_306_2.sprite.bounds.size.x and var_306_3 * manager.ui.mainCameraCom_.aspect / var_306_2.sprite.bounds.size.x or var_306_3 / var_306_2.sprite.bounds.size.y, var_306_3 / var_306_2.sprite.bounds.size.y < var_306_3 * manager.ui.mainCameraCom_.aspect / var_306_2.sprite.bounds.size.x and var_306_3 * manager.ui.mainCameraCom_.aspect / var_306_2.sprite.bounds.size.x or var_306_3 / var_306_2.sprite.bounds.size.y, 0)
				end

				for iter_306_0, iter_306_1 in pairs(arg_303_1.bgs_) do
					if iter_306_0 ~= "K16i_blur" then
						iter_306_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_306_4 = arg_303_1.actors_["10065ui_story"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos10065ui_story = var_306_4.localPosition
			end

			local var_306_5 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_5 then
				var_306_4.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_303_1.time_ - 0) / var_306_5)
				var_306_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_4.position).x, (manager.ui.mainCamera.transform.position - var_306_4.position).y, (manager.ui.mainCamera.transform.position - var_306_4.position).z)
				var_306_4.localEulerAngles.z = 0
				var_306_4.localEulerAngles.x = 0
				var_306_4.localEulerAngles = var_306_4.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_5 and arg_303_1.time_ < 0 + var_306_5 + arg_306_0 then
				var_306_4.localPosition = Vector3.New(0, 100, 0)
				var_306_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_4.position).x, (manager.ui.mainCamera.transform.position - var_306_4.position).y, (manager.ui.mainCamera.transform.position - var_306_4.position).z)
				var_306_4.localEulerAngles.z = 0
				var_306_4.localEulerAngles.x = 0
				var_306_4.localEulerAngles = var_306_4.localEulerAngles
			end

			local var_306_6 = arg_303_1.actors_["10065ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_6) and arg_303_1.var_.characterEffect10065ui_story == nil then
				arg_303_1.var_.characterEffect10065ui_story = var_306_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_7 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 and not isNil(var_306_6) then
				if arg_303_1.var_.characterEffect10065ui_story and not isNil(var_306_6) then
					arg_303_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_303_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_7)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 and not isNil(var_306_6) and arg_303_1.var_.characterEffect10065ui_story then
				arg_303_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_303_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_306_8 = arg_303_1.actors_["1049ui_story"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1049ui_story = var_306_8.localPosition
			end

			local var_306_9 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_9 then
				var_306_8.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_303_1.time_ - 0) / var_306_9)
				var_306_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_8.position).x, (manager.ui.mainCamera.transform.position - var_306_8.position).y, (manager.ui.mainCamera.transform.position - var_306_8.position).z)
				var_306_8.localEulerAngles.z = 0
				var_306_8.localEulerAngles.x = 0
				var_306_8.localEulerAngles = var_306_8.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_9 and arg_303_1.time_ < 0 + var_306_9 + arg_306_0 then
				var_306_8.localPosition = Vector3.New(0, 100, 0)
				var_306_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_8.position).x, (manager.ui.mainCamera.transform.position - var_306_8.position).y, (manager.ui.mainCamera.transform.position - var_306_8.position).z)
				var_306_8.localEulerAngles.z = 0
				var_306_8.localEulerAngles.x = 0
				var_306_8.localEulerAngles = var_306_8.localEulerAngles
			end

			local var_306_10 = "K16i_blur"

			if arg_303_1.bgs_.K16i_blur == nil then
				local var_306_11 = Object.Instantiate(arg_303_1.blurPaintGo_)

				var_306_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_306_10)
				var_306_11.name = var_306_10
				var_306_11.transform.parent = arg_303_1.stage_.transform
				var_306_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_303_1.bgs_[var_306_10] = var_306_11
			end

			local var_306_12 = 0
			local var_306_13 = arg_303_1.bgs_[var_306_10]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_12 + arg_306_0 then
				var_306_13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_306_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_306_14 = var_306_13:GetComponent("SpriteRenderer")

				if var_306_14 and var_306_14.sprite then
					local var_306_15 = 2 * (var_306_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_306_13.transform.localScale = Vector3.New(var_306_15 / var_306_14.sprite.bounds.size.y < var_306_15 * manager.ui.mainCameraCom_.aspect / var_306_14.sprite.bounds.size.x and var_306_15 * manager.ui.mainCameraCom_.aspect / var_306_14.sprite.bounds.size.x or var_306_15 / var_306_14.sprite.bounds.size.y, var_306_15 / var_306_14.sprite.bounds.size.y < var_306_15 * manager.ui.mainCameraCom_.aspect / var_306_14.sprite.bounds.size.x and var_306_15 * manager.ui.mainCameraCom_.aspect / var_306_14.sprite.bounds.size.x or var_306_15 / var_306_14.sprite.bounds.size.y, 0)
				end
			end

			local var_306_16 = 1

			if var_306_12 <= arg_303_1.time_ and arg_303_1.time_ < var_306_12 + var_306_16 then
				local var_306_17 = Color.New(1, 1, 1)

				var_306_17.a = Mathf.Lerp(1, 0, (arg_303_1.time_ - var_306_12) / var_306_16)

				var_306_13:GetComponent("SpriteRenderer").material:SetColor("_Color", var_306_17)
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				local var_306_18 = arg_303_1.var_.effect10318260201

				if not arg_303_1.var_.effect10318260201 then
					var_306_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), manager.ui.mainCamera.transform)
					var_306_18.name = "10318260201"
					arg_303_1.var_.effect10318260201 = var_306_18
				else
					var_306_18.transform:SetParent(var_306_9000)
				end

				var_306_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_306_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_306_20 = 0
			local var_306_21 = 1.45

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_20 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_22 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(318262073).content)

				arg_303_1.text_.text = var_306_22

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_24 = 58 <= 0 and var_306_21 or var_306_21 * (utf8.len(var_306_22) / 58)

				if (58 <= 0 and var_306_21 or var_306_21 * (utf8.len(var_306_22) / 58)) > 0 and var_306_21 < var_306_24 then
					arg_303_1.talkMaxDuration = var_306_24

					if var_306_24 + var_306_20 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_24 + var_306_20
					end
				end

				arg_303_1.text_.text = var_306_22
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_25 = math.max(var_306_21, arg_303_1.talkMaxDuration)

			if var_306_20 <= arg_303_1.time_ and arg_303_1.time_ < var_306_20 + var_306_25 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_20) / var_306_25

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_20 + var_306_25 and arg_303_1.time_ < var_306_20 + var_306_25 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play318262074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 318262074
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play318262075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 1.375

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(318262074).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 55 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 55)

				if (55 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 55)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play318262075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 318262075
		arg_311_1.duration_ = 8.73

		local var_311_0 = {
			zh = 5,
			ja = 8.733
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play318262076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if arg_311_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_314_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_311_1.stage_.transform)

				var_314_0.name = "10066ui_story"
				var_314_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_311_1.actors_["10066ui_story"] = var_314_0

				local var_314_1 = var_314_0:GetComponentInChildren(typeof(CharacterEffect))

				var_314_1.enabled = true

				local var_314_2 = GameObjectTools.GetOrAddComponent(var_314_0, typeof(DynamicBoneHelper))

				if var_314_2 then
					var_314_2:EnableDynamicBone(false)
				end

				arg_311_1:ShowWeapon(var_314_1.transform, false)

				arg_311_1.var_["10066ui_story" .. "Animator"] = var_314_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_311_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_311_1.var_["10066ui_story" .. "LipSync"] = var_314_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_314_3 = arg_311_1.actors_["10066ui_story"].transform

			if 1 < arg_311_1.time_ and arg_311_1.time_ <= 1 + arg_314_0 then
				arg_311_1.var_.moveOldPos10066ui_story = var_314_3.localPosition
			end

			local var_314_4 = 0.001

			if 1 <= arg_311_1.time_ and arg_311_1.time_ < 1 + var_314_4 then
				var_314_3.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_311_1.time_ - 1) / var_314_4)
				var_314_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_314_3.position).x, (manager.ui.mainCamera.transform.position - var_314_3.position).y, (manager.ui.mainCamera.transform.position - var_314_3.position).z)
				var_314_3.localEulerAngles.z = 0
				var_314_3.localEulerAngles.x = 0
				var_314_3.localEulerAngles = var_314_3.localEulerAngles
			end

			if arg_311_1.time_ >= 1 + var_314_4 and arg_311_1.time_ < 1 + var_314_4 + arg_314_0 then
				var_314_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_314_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_314_3.position).x, (manager.ui.mainCamera.transform.position - var_314_3.position).y, (manager.ui.mainCamera.transform.position - var_314_3.position).z)
				var_314_3.localEulerAngles.z = 0
				var_314_3.localEulerAngles.x = 0
				var_314_3.localEulerAngles = var_314_3.localEulerAngles
			end

			local var_314_5 = arg_311_1.actors_["10066ui_story"]

			if 1 < arg_311_1.time_ and arg_311_1.time_ <= 1 + arg_314_0 and not isNil(var_314_5) and arg_311_1.var_.characterEffect10066ui_story == nil then
				arg_311_1.var_.characterEffect10066ui_story = var_314_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_6 = 0.200000002980232

			if 1 <= arg_311_1.time_ and arg_311_1.time_ < 1 + var_314_6 and not isNil(var_314_5) then
				if arg_311_1.var_.characterEffect10066ui_story and not isNil(var_314_5) then
					arg_311_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 1 + var_314_6 and arg_311_1.time_ < 1 + var_314_6 + arg_314_0 and not isNil(var_314_5) and arg_311_1.var_.characterEffect10066ui_story then
				arg_311_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 1 < arg_311_1.time_ and arg_311_1.time_ <= 1 + arg_314_0 then
				arg_311_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 1 < arg_311_1.time_ and arg_311_1.time_ <= 1 + arg_314_0 then
				arg_311_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_314_8 = "K16i_blur"

			if arg_311_1.bgs_.K16i_blur == nil then
				local var_314_9 = Object.Instantiate(arg_311_1.blurPaintGo_)

				var_314_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_314_8)
				var_314_9.name = var_314_8
				var_314_9.transform.parent = arg_311_1.stage_.transform
				var_314_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_311_1.bgs_[var_314_8] = var_314_9
			end

			local var_314_10 = 0
			local var_314_11 = arg_311_1.bgs_[var_314_8]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_10 + arg_314_0 then
				var_314_11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_314_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_314_12 = var_314_11:GetComponent("SpriteRenderer")

				if var_314_12 and var_314_12.sprite then
					local var_314_13 = 2 * (var_314_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_314_11.transform.localScale = Vector3.New(var_314_13 / var_314_12.sprite.bounds.size.y < var_314_13 * manager.ui.mainCameraCom_.aspect / var_314_12.sprite.bounds.size.x and var_314_13 * manager.ui.mainCameraCom_.aspect / var_314_12.sprite.bounds.size.x or var_314_13 / var_314_12.sprite.bounds.size.y, var_314_13 / var_314_12.sprite.bounds.size.y < var_314_13 * manager.ui.mainCameraCom_.aspect / var_314_12.sprite.bounds.size.x and var_314_13 * manager.ui.mainCameraCom_.aspect / var_314_12.sprite.bounds.size.x or var_314_13 / var_314_12.sprite.bounds.size.y, 0)
				end
			end

			local var_314_14 = 0.0166666666666666

			if var_314_10 <= arg_311_1.time_ and arg_311_1.time_ < var_314_10 + var_314_14 then
				local var_314_15 = Color.New(1, 1, 1)

				var_314_15.a = Mathf.Lerp(0, 1, (arg_311_1.time_ - var_314_10) / var_314_14)

				var_314_11:GetComponent("SpriteRenderer").material:SetColor("_Color", var_314_15)
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				if arg_311_1.var_.effect10318260201 then
					Object.Destroy(arg_311_1.var_.effect10318260201)

					arg_311_1.var_.effect10318260201 = nil
				end
			end

			local var_314_17 = 0

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_17 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_18 = 2

			if var_314_17 <= arg_311_1.time_ and arg_311_1.time_ < var_314_17 + var_314_18 then
				local var_314_19 = Color.New(1, 1, 1)

				var_314_19.a = Mathf.Lerp(1, 0, (arg_311_1.time_ - var_314_17) / var_314_18)
				arg_311_1.mask_.color = var_314_19
			end

			if arg_311_1.time_ >= var_314_17 + var_314_18 and arg_311_1.time_ < var_314_17 + var_314_18 + arg_314_0 then
				local var_314_20 = Color.New(1, 1, 1)

				arg_311_1.mask_.enabled = false
				var_314_20.a = 0
				arg_311_1.mask_.color = var_314_20
			end

			if arg_311_1.frameCnt_ <= 1 then
				arg_311_1.dialog_:SetActive(false)
			end

			local var_314_21 = 1
			local var_314_22 = 0.375

			if 1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_21 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				arg_311_1.dialog_:SetActive(true)

				arg_311_1.dialogCg_.alpha = 0

				local var_314_23 = LeanTween.value(arg_311_1.dialog_, 0, 1, 0.3)

				var_314_23:setOnUpdate(LuaHelper.FloatAction(function(arg_315_0)
					arg_311_1.dialogCg_.alpha = arg_315_0
				end))
				var_314_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_311_1.dialog_)
					var_314_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_311_1.duration_ = arg_311_1.duration_ + 0.3

				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_24 = arg_311_1:GetWordFromCfg(318262075)
				local var_314_25 = arg_311_1:FormatText(var_314_24.content)

				arg_311_1.text_.text = var_314_25

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_27 = 15 <= 0 and var_314_22 or var_314_22 * (utf8.len(var_314_25) / 15)

				if (15 <= 0 and var_314_22 or var_314_22 * (utf8.len(var_314_25) / 15)) > 0 and var_314_22 < var_314_27 then
					arg_311_1.talkMaxDuration = var_314_27
					var_314_21 = var_314_21 + 0.3

					if var_314_27 + var_314_21 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_27 + var_314_21
					end
				end

				arg_311_1.text_.text = var_314_25
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262075", "story_v_out_318262.awb") ~= 0 then
					local var_314_28 = manager.audio:GetVoiceLength("story_v_out_318262", "318262075", "story_v_out_318262.awb") / 1000

					if var_314_28 + var_314_21 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_28 + var_314_21
					end

					if var_314_24.prefab_name ~= "" and arg_311_1.actors_[var_314_24.prefab_name] ~= nil then
						local var_314_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_24.prefab_name].transform, "story_v_out_318262", "318262075", "story_v_out_318262.awb")

						arg_311_1:RecordAudio("318262075", var_314_29)
						arg_311_1:RecordAudio("318262075", var_314_29)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_318262", "318262075", "story_v_out_318262.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_318262", "318262075", "story_v_out_318262.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_30 = var_314_21 + 0.3
			local var_314_31 = math.max(var_314_22, arg_311_1.talkMaxDuration)

			if var_314_21 + 0.3 <= arg_311_1.time_ and arg_311_1.time_ < var_314_30 + var_314_31 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_30) / var_314_31

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_30 + var_314_31 and arg_311_1.time_ < var_314_30 + var_314_31 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play318262076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 318262076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play318262077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10066ui_story = arg_317_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10066ui_story"].transform.position).z)
				arg_317_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["10066ui_story"].transform.localEulerAngles = arg_317_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10066ui_story"].transform.position).z)
				arg_317_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["10066ui_story"].transform.localEulerAngles = arg_317_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["10066ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect10066ui_story == nil then
				arg_317_1.var_.characterEffect10066ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect10066ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_317_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_2)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect10066ui_story then
				arg_317_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_317_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_320_3 = 0
			local var_320_4 = 1.25

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

				local var_320_5 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(318262076).content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 50 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 50)

				if (50 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 50)) > 0 and var_320_4 < var_320_7 then
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play318262077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 318262077
		arg_321_1.duration_ = 7

		local var_321_0 = {
			zh = 4.9,
			ja = 7
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
				arg_321_0:Play318262078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if arg_321_1.actors_["4016ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4016ui_story"))) then
				local var_324_0 = Object.Instantiate(Asset.Load("Char/" .. "4016ui_story"), arg_321_1.stage_.transform)

				var_324_0.name = "4016ui_story"
				var_324_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.actors_["4016ui_story"] = var_324_0

				local var_324_1 = var_324_0:GetComponentInChildren(typeof(CharacterEffect))

				var_324_1.enabled = true

				local var_324_2 = GameObjectTools.GetOrAddComponent(var_324_0, typeof(DynamicBoneHelper))

				if var_324_2 then
					var_324_2:EnableDynamicBone(false)
				end

				arg_321_1:ShowWeapon(var_324_1.transform, false)

				arg_321_1.var_["4016ui_story" .. "Animator"] = var_324_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_321_1.var_["4016ui_story" .. "Animator"].applyRootMotion = true
				arg_321_1.var_["4016ui_story" .. "LipSync"] = var_324_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_324_3 = arg_321_1.actors_["4016ui_story"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos4016ui_story = var_324_3.localPosition
				var_324_3.localScale = Vector3.New(0.5, 0.5, 0.5)
			end

			local var_324_4 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				var_324_3.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos4016ui_story, Vector3.New(0, -2, 2.45), (arg_321_1.time_ - 0) / var_324_4)
				var_324_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_3.position).x, (manager.ui.mainCamera.transform.position - var_324_3.position).y, (manager.ui.mainCamera.transform.position - var_324_3.position).z)
				var_324_3.localEulerAngles.z = 0
				var_324_3.localEulerAngles.x = 0
				var_324_3.localEulerAngles = var_324_3.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				var_324_3.localPosition = Vector3.New(0, -2, 2.45)
				var_324_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_3.position).x, (manager.ui.mainCamera.transform.position - var_324_3.position).y, (manager.ui.mainCamera.transform.position - var_324_3.position).z)
				var_324_3.localEulerAngles.z = 0
				var_324_3.localEulerAngles.x = 0
				var_324_3.localEulerAngles = var_324_3.localEulerAngles
			end

			local var_324_5 = arg_321_1.actors_["4016ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_5) and arg_321_1.var_.characterEffect4016ui_story == nil then
				arg_321_1.var_.characterEffect4016ui_story = var_324_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_6 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_6 and not isNil(var_324_5) then
				if arg_321_1.var_.characterEffect4016ui_story and not isNil(var_324_5) then
					arg_321_1.var_.characterEffect4016ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_6 and arg_321_1.time_ < 0 + var_324_6 + arg_324_0 and not isNil(var_324_5) and arg_321_1.var_.characterEffect4016ui_story then
				arg_321_1.var_.characterEffect4016ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("4016ui_story", "StoryTimeline/CharAction/story4016/story4016action/4016action1_1")
			end

			local var_324_8 = 0
			local var_324_9 = 0.275

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_10 = arg_321_1:GetWordFromCfg(318262077)
				local var_324_11 = arg_321_1:FormatText(var_324_10.content)

				arg_321_1.text_.text = var_324_11

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_13 = 11 <= 0 and var_324_9 or var_324_9 * (utf8.len(var_324_11) / 11)

				if (11 <= 0 and var_324_9 or var_324_9 * (utf8.len(var_324_11) / 11)) > 0 and var_324_9 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_8
					end
				end

				arg_321_1.text_.text = var_324_11
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262077", "story_v_out_318262.awb") ~= 0 then
					local var_324_14 = manager.audio:GetVoiceLength("story_v_out_318262", "318262077", "story_v_out_318262.awb") / 1000

					if var_324_14 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_14 + var_324_8
					end

					if var_324_10.prefab_name ~= "" and arg_321_1.actors_[var_324_10.prefab_name] ~= nil then
						local var_324_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_10.prefab_name].transform, "story_v_out_318262", "318262077", "story_v_out_318262.awb")

						arg_321_1:RecordAudio("318262077", var_324_15)
						arg_321_1:RecordAudio("318262077", var_324_15)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_318262", "318262077", "story_v_out_318262.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_318262", "318262077", "story_v_out_318262.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_16 = math.max(var_324_9, arg_321_1.talkMaxDuration)

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_16 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_8) / var_324_16

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_8 + var_324_16 and arg_321_1.time_ < var_324_8 + var_324_16 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play318262078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 318262078
		arg_325_1.duration_ = 3.73

		local var_325_0 = {
			zh = 3.733,
			ja = 3.166
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play318262079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if arg_325_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_328_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_325_1.stage_.transform)

				var_328_0.name = "1015ui_story"
				var_328_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.actors_["1015ui_story"] = var_328_0

				local var_328_1 = var_328_0:GetComponentInChildren(typeof(CharacterEffect))

				var_328_1.enabled = true

				local var_328_2 = GameObjectTools.GetOrAddComponent(var_328_0, typeof(DynamicBoneHelper))

				if var_328_2 then
					var_328_2:EnableDynamicBone(false)
				end

				arg_325_1:ShowWeapon(var_328_1.transform, false)

				arg_325_1.var_["1015ui_story" .. "Animator"] = var_328_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_325_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_325_1.var_["1015ui_story" .. "LipSync"] = var_328_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_328_3 = arg_325_1.actors_["1015ui_story"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1015ui_story = var_328_3.localPosition
			end

			local var_328_4 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				var_328_3.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_325_1.time_ - 0) / var_328_4)
				var_328_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_3.position).x, (manager.ui.mainCamera.transform.position - var_328_3.position).y, (manager.ui.mainCamera.transform.position - var_328_3.position).z)
				var_328_3.localEulerAngles.z = 0
				var_328_3.localEulerAngles.x = 0
				var_328_3.localEulerAngles = var_328_3.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				var_328_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_328_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_3.position).x, (manager.ui.mainCamera.transform.position - var_328_3.position).y, (manager.ui.mainCamera.transform.position - var_328_3.position).z)
				var_328_3.localEulerAngles.z = 0
				var_328_3.localEulerAngles.x = 0
				var_328_3.localEulerAngles = var_328_3.localEulerAngles
			end

			local var_328_5 = arg_325_1.actors_["1015ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_5) and arg_325_1.var_.characterEffect1015ui_story == nil then
				arg_325_1.var_.characterEffect1015ui_story = var_328_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_6 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_6 and not isNil(var_328_5) then
				if arg_325_1.var_.characterEffect1015ui_story and not isNil(var_328_5) then
					arg_325_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_6 and arg_325_1.time_ < 0 + var_328_6 + arg_328_0 and not isNil(var_328_5) and arg_325_1.var_.characterEffect1015ui_story then
				arg_325_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_328_8 = arg_325_1.actors_["4016ui_story"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos4016ui_story = var_328_8.localPosition
			end

			local var_328_9 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_9 then
				var_328_8.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos4016ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 0) / var_328_9)
				var_328_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_8.position).x, (manager.ui.mainCamera.transform.position - var_328_8.position).y, (manager.ui.mainCamera.transform.position - var_328_8.position).z)
				var_328_8.localEulerAngles.z = 0
				var_328_8.localEulerAngles.x = 0
				var_328_8.localEulerAngles = var_328_8.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_9 and arg_325_1.time_ < 0 + var_328_9 + arg_328_0 then
				var_328_8.localPosition = Vector3.New(0, 100, 0)
				var_328_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_8.position).x, (manager.ui.mainCamera.transform.position - var_328_8.position).y, (manager.ui.mainCamera.transform.position - var_328_8.position).z)
				var_328_8.localEulerAngles.z = 0
				var_328_8.localEulerAngles.x = 0
				var_328_8.localEulerAngles = var_328_8.localEulerAngles
			end

			local var_328_10 = arg_325_1.actors_["10065ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_10) and arg_325_1.var_.characterEffect10065ui_story == nil then
				arg_325_1.var_.characterEffect10065ui_story = var_328_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_11 and not isNil(var_328_10) then
				if arg_325_1.var_.characterEffect10065ui_story and not isNil(var_328_10) then
					arg_325_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_11)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_11 and arg_325_1.time_ < 0 + var_328_11 + arg_328_0 and not isNil(var_328_10) and arg_325_1.var_.characterEffect10065ui_story then
				arg_325_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_328_12 = 0
			local var_328_13 = 0.425

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_12 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_14 = arg_325_1:GetWordFromCfg(318262078)
				local var_328_15 = arg_325_1:FormatText(var_328_14.content)

				arg_325_1.text_.text = var_328_15

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_17 = 17 <= 0 and var_328_13 or var_328_13 * (utf8.len(var_328_15) / 17)

				if (17 <= 0 and var_328_13 or var_328_13 * (utf8.len(var_328_15) / 17)) > 0 and var_328_13 < var_328_17 then
					arg_325_1.talkMaxDuration = var_328_17

					if var_328_17 + var_328_12 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_17 + var_328_12
					end
				end

				arg_325_1.text_.text = var_328_15
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262078", "story_v_out_318262.awb") ~= 0 then
					local var_328_18 = manager.audio:GetVoiceLength("story_v_out_318262", "318262078", "story_v_out_318262.awb") / 1000

					if var_328_18 + var_328_12 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_18 + var_328_12
					end

					if var_328_14.prefab_name ~= "" and arg_325_1.actors_[var_328_14.prefab_name] ~= nil then
						local var_328_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_14.prefab_name].transform, "story_v_out_318262", "318262078", "story_v_out_318262.awb")

						arg_325_1:RecordAudio("318262078", var_328_19)
						arg_325_1:RecordAudio("318262078", var_328_19)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_318262", "318262078", "story_v_out_318262.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_318262", "318262078", "story_v_out_318262.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_20 = math.max(var_328_13, arg_325_1.talkMaxDuration)

			if var_328_12 <= arg_325_1.time_ and arg_325_1.time_ < var_328_12 + var_328_20 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_12) / var_328_20

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_12 + var_328_20 and arg_325_1.time_ < var_328_12 + var_328_20 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play318262079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 318262079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play318262080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1015ui_story = arg_329_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1015ui_story"].transform.position).z)
				arg_329_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1015ui_story"].transform.localEulerAngles = arg_329_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1015ui_story"].transform.position).z)
				arg_329_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1015ui_story"].transform.localEulerAngles = arg_329_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1015ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1015ui_story == nil then
				arg_329_1.var_.characterEffect1015ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1015ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_2)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1015ui_story then
				arg_329_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_332_3 = manager.ui.mainCamera.transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.shakeOldPos = var_332_3.localPosition
			end

			local var_332_4 = 0.6

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				local var_332_5, var_332_6 = math.modf((arg_329_1.time_ - 0) / 0.066)

				var_332_3.localPosition = Vector3.New(var_332_6 * 0.13, var_332_6 * 0.13, var_332_6 * 0.13) + arg_329_1.var_.shakeOldPos
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				var_332_3.localPosition = arg_329_1.var_.shakeOldPos
			end

			local var_332_7 = 0

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_7 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			if arg_329_1.time_ >= var_332_7 + 0.6 and arg_329_1.time_ < var_332_7 + 0.6 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_stonecrushing", "")
			end

			local var_332_9 = 0
			local var_332_10 = 1.5

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_11 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(318262079).content)

				arg_329_1.text_.text = var_332_11

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 60 <= 0 and var_332_10 or var_332_10 * (utf8.len(var_332_11) / 60)

				if (60 <= 0 and var_332_10 or var_332_10 * (utf8.len(var_332_11) / 60)) > 0 and var_332_10 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_9 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_9
					end
				end

				arg_329_1.text_.text = var_332_11
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_14 = math.max(var_332_10, arg_329_1.talkMaxDuration)

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_14 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_9) / var_332_14

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_9 + var_332_14 and arg_329_1.time_ < var_332_9 + var_332_14 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play318262080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 318262080
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play318262081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 1.125

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

				local var_336_1 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(318262080).content)

				arg_333_1.text_.text = var_336_1

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_3 = 45 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 45)

				if (45 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 45)) > 0 and var_336_0 < var_336_3 then
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
	Play318262081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 318262081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play318262082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0.533333333333333 < arg_337_1.time_ and arg_337_1.time_ <= 0.533333333333333 + arg_340_0 then
				arg_337_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_hit", "")
			end

			local var_340_1 = 0
			local var_340_2 = 0.925

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(318262081).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 37 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 37)

				if (37 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 37)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_6 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_6

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_6 and arg_337_1.time_ < var_340_1 + var_340_6 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play318262082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 318262082
		arg_341_1.duration_ = 4.57

		local var_341_0 = {
			zh = 2.066,
			ja = 4.566
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
				arg_341_0:Play318262083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos4016ui_story = arg_341_1.actors_["4016ui_story"].transform.localPosition
				arg_341_1.actors_["4016ui_story"].transform.localScale = Vector3.New(0.5, 0.5, 0.5)
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["4016ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos4016ui_story, Vector3.New(0, -2, 2.45), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["4016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["4016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["4016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["4016ui_story"].transform.position).z)
				arg_341_1.actors_["4016ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["4016ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["4016ui_story"].transform.localEulerAngles = arg_341_1.actors_["4016ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["4016ui_story"].transform.localPosition = Vector3.New(0, -2, 2.45)
				arg_341_1.actors_["4016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["4016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["4016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["4016ui_story"].transform.position).z)
				arg_341_1.actors_["4016ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["4016ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["4016ui_story"].transform.localEulerAngles = arg_341_1.actors_["4016ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["4016ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect4016ui_story == nil then
				arg_341_1.var_.characterEffect4016ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect4016ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect4016ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect4016ui_story then
				arg_341_1.var_.characterEffect4016ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("4016ui_story", "StoryTimeline/CharAction/story4016/story4016action/4016action1_1")
			end

			local var_344_4 = 0
			local var_344_5 = 0.1

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(318262082)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 4 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 4)

				if (4 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 4)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262082", "story_v_out_318262.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262082", "story_v_out_318262.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_318262", "318262082", "story_v_out_318262.awb")

						arg_341_1:RecordAudio("318262082", var_344_11)
						arg_341_1:RecordAudio("318262082", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_318262", "318262082", "story_v_out_318262.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_318262", "318262082", "story_v_out_318262.awb")
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
				actorName = "4016ui_story",
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
	Play318262083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 318262083
		arg_345_1.duration_ = 1.3

		local var_345_0 = {
			zh = 1.3,
			ja = 1.1
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
				arg_345_0:Play318262084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1015ui_story = arg_345_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1015ui_story"].transform.position).z)
				arg_345_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1015ui_story"].transform.localEulerAngles = arg_345_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_345_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1015ui_story"].transform.position).z)
				arg_345_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1015ui_story"].transform.localEulerAngles = arg_345_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["4016ui_story"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos4016ui_story = var_348_1.localPosition
			end

			local var_348_2 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 then
				var_348_1.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos4016ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 0) / var_348_2)
				var_348_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_1.position).x, (manager.ui.mainCamera.transform.position - var_348_1.position).y, (manager.ui.mainCamera.transform.position - var_348_1.position).z)
				var_348_1.localEulerAngles.z = 0
				var_348_1.localEulerAngles.x = 0
				var_348_1.localEulerAngles = var_348_1.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 then
				var_348_1.localPosition = Vector3.New(0, 100, 0)
				var_348_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_1.position).x, (manager.ui.mainCamera.transform.position - var_348_1.position).y, (manager.ui.mainCamera.transform.position - var_348_1.position).z)
				var_348_1.localEulerAngles.z = 0
				var_348_1.localEulerAngles.x = 0
				var_348_1.localEulerAngles = var_348_1.localEulerAngles
			end

			local var_348_3 = arg_345_1.actors_["4016ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_3) and arg_345_1.var_.characterEffect4016ui_story == nil then
				arg_345_1.var_.characterEffect4016ui_story = var_348_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_4 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 and not isNil(var_348_3) then
				if arg_345_1.var_.characterEffect4016ui_story and not isNil(var_348_3) then
					arg_345_1.var_.characterEffect4016ui_story.fillFlat = true
					arg_345_1.var_.characterEffect4016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_4)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 and not isNil(var_348_3) and arg_345_1.var_.characterEffect4016ui_story then
				arg_345_1.var_.characterEffect4016ui_story.fillFlat = true
				arg_345_1.var_.characterEffect4016ui_story.fillRatio = 0.5
			end

			local var_348_5 = manager.ui.mainCamera.transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.shakeOldPos = var_348_5.localPosition
			end

			local var_348_6 = 0.6

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_6 then
				local var_348_7, var_348_8 = math.modf((arg_345_1.time_ - 0) / 0.066)

				var_348_5.localPosition = Vector3.New(var_348_8 * 0.13, var_348_8 * 0.13, var_348_8 * 0.13) + arg_345_1.var_.shakeOldPos
			end

			if arg_345_1.time_ >= 0 + var_348_6 and arg_345_1.time_ < 0 + var_348_6 + arg_348_0 then
				var_348_5.localPosition = arg_345_1.var_.shakeOldPos
			end

			local var_348_9 = 0

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_9 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			if arg_345_1.time_ >= var_348_9 + 0.6 and arg_345_1.time_ < var_348_9 + 0.6 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_10 = 0
			local var_348_11 = 0.05

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_12 = arg_345_1:GetWordFromCfg(318262083)
				local var_348_13 = arg_345_1:FormatText(var_348_12.content)

				arg_345_1.text_.text = var_348_13

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_15 = 2 <= 0 and var_348_11 or var_348_11 * (utf8.len(var_348_13) / 2)

				if (2 <= 0 and var_348_11 or var_348_11 * (utf8.len(var_348_13) / 2)) > 0 and var_348_11 < var_348_15 then
					arg_345_1.talkMaxDuration = var_348_15

					if var_348_15 + var_348_10 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_15 + var_348_10
					end
				end

				arg_345_1.text_.text = var_348_13
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262083", "story_v_out_318262.awb") ~= 0 then
					local var_348_16 = manager.audio:GetVoiceLength("story_v_out_318262", "318262083", "story_v_out_318262.awb") / 1000

					if var_348_16 + var_348_10 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_16 + var_348_10
					end

					if var_348_12.prefab_name ~= "" and arg_345_1.actors_[var_348_12.prefab_name] ~= nil then
						local var_348_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_12.prefab_name].transform, "story_v_out_318262", "318262083", "story_v_out_318262.awb")

						arg_345_1:RecordAudio("318262083", var_348_17)
						arg_345_1:RecordAudio("318262083", var_348_17)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_318262", "318262083", "story_v_out_318262.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_318262", "318262083", "story_v_out_318262.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_18 = math.max(var_348_11, arg_345_1.talkMaxDuration)

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_18 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_10) / var_348_18

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_10 + var_348_18 and arg_345_1.time_ < var_348_10 + var_348_18 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play318262084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 318262084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play318262085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1015ui_story = arg_349_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1015ui_story"].transform.position).z)
				arg_349_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1015ui_story"].transform.localEulerAngles = arg_349_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1015ui_story"].transform.position).z)
				arg_349_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1015ui_story"].transform.localEulerAngles = arg_349_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1015ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1015ui_story == nil then
				arg_349_1.var_.characterEffect1015ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect1015ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_2)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1015ui_story then
				arg_349_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_energy01", "")
			end

			local var_352_4 = 0
			local var_352_5 = 0.975

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_6 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(318262084).content)

				arg_349_1.text_.text = var_352_6

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_8 = 39 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_6) / 39)

				if (39 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_6) / 39)) > 0 and var_352_5 < var_352_8 then
					arg_349_1.talkMaxDuration = var_352_8

					if var_352_8 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_6
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_9 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_9 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_9

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_9 and arg_349_1.time_ < var_352_4 + var_352_9 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play318262085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 318262085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play318262086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 1.275

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(318262085).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 51 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 51)

				if (51 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 51)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play318262086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 318262086
		arg_357_1.duration_ = 2

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play318262087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos10066ui_story = arg_357_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10066ui_story"].transform.position).z)
				arg_357_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["10066ui_story"].transform.localEulerAngles = arg_357_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_357_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10066ui_story"].transform.position).z)
				arg_357_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["10066ui_story"].transform.localEulerAngles = arg_357_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["10066ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect10066ui_story == nil then
				arg_357_1.var_.characterEffect10066ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect10066ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect10066ui_story then
				arg_357_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_360_4 = arg_357_1.actors_["4016ui_story"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos4016ui_story = var_360_4.localPosition
			end

			local var_360_5 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_5 then
				var_360_4.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos4016ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_5)
				var_360_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_4.position).x, (manager.ui.mainCamera.transform.position - var_360_4.position).y, (manager.ui.mainCamera.transform.position - var_360_4.position).z)
				var_360_4.localEulerAngles.z = 0
				var_360_4.localEulerAngles.x = 0
				var_360_4.localEulerAngles = var_360_4.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_5 and arg_357_1.time_ < 0 + var_360_5 + arg_360_0 then
				var_360_4.localPosition = Vector3.New(0, 100, 0)
				var_360_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_4.position).x, (manager.ui.mainCamera.transform.position - var_360_4.position).y, (manager.ui.mainCamera.transform.position - var_360_4.position).z)
				var_360_4.localEulerAngles.z = 0
				var_360_4.localEulerAngles.x = 0
				var_360_4.localEulerAngles = var_360_4.localEulerAngles
			end

			local var_360_6 = 0
			local var_360_7 = 0.125

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_8 = arg_357_1:GetWordFromCfg(318262086)
				local var_360_9 = arg_357_1:FormatText(var_360_8.content)

				arg_357_1.text_.text = var_360_9

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_11 = 5 <= 0 and var_360_7 or var_360_7 * (utf8.len(var_360_9) / 5)

				if (5 <= 0 and var_360_7 or var_360_7 * (utf8.len(var_360_9) / 5)) > 0 and var_360_7 < var_360_11 then
					arg_357_1.talkMaxDuration = var_360_11

					if var_360_11 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_11 + var_360_6
					end
				end

				arg_357_1.text_.text = var_360_9
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262086", "story_v_out_318262.awb") ~= 0 then
					local var_360_12 = manager.audio:GetVoiceLength("story_v_out_318262", "318262086", "story_v_out_318262.awb") / 1000

					if var_360_12 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_12 + var_360_6
					end

					if var_360_8.prefab_name ~= "" and arg_357_1.actors_[var_360_8.prefab_name] ~= nil then
						local var_360_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_8.prefab_name].transform, "story_v_out_318262", "318262086", "story_v_out_318262.awb")

						arg_357_1:RecordAudio("318262086", var_360_13)
						arg_357_1:RecordAudio("318262086", var_360_13)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_318262", "318262086", "story_v_out_318262.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_318262", "318262086", "story_v_out_318262.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_14 = math.max(var_360_7, arg_357_1.talkMaxDuration)

			if var_360_6 <= arg_357_1.time_ and arg_357_1.time_ < var_360_6 + var_360_14 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_6) / var_360_14

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_6 + var_360_14 and arg_357_1.time_ < var_360_6 + var_360_14 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play318262087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 318262087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play318262088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10066ui_story = arg_361_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_364_0 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 then
				arg_361_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_361_1.time_ - 0) / var_364_0)
				arg_361_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10066ui_story"].transform.position).z)
				arg_361_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["10066ui_story"].transform.localEulerAngles = arg_361_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 then
				arg_361_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_361_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10066ui_story"].transform.position).z)
				arg_361_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["10066ui_story"].transform.localEulerAngles = arg_361_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_364_1 = arg_361_1.actors_["10066ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect10066ui_story == nil then
				arg_361_1.var_.characterEffect10066ui_story = var_364_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_2 and not isNil(var_364_1) then
				if arg_361_1.var_.characterEffect10066ui_story and not isNil(var_364_1) then
					arg_361_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_361_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_2)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_2 and arg_361_1.time_ < 0 + var_364_2 + arg_364_0 and not isNil(var_364_1) and arg_361_1.var_.characterEffect10066ui_story then
				arg_361_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_361_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_364_3 = 0
			local var_364_4 = 0.65

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_3 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_5 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(318262087).content)

				arg_361_1.text_.text = var_364_5

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_7 = 26 <= 0 and var_364_4 or var_364_4 * (utf8.len(var_364_5) / 26)

				if (26 <= 0 and var_364_4 or var_364_4 * (utf8.len(var_364_5) / 26)) > 0 and var_364_4 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_3 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_3
					end
				end

				arg_361_1.text_.text = var_364_5
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_4, arg_361_1.talkMaxDuration)

			if var_364_3 <= arg_361_1.time_ and arg_361_1.time_ < var_364_3 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_3) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_3 + var_364_8 and arg_361_1.time_ < var_364_3 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play318262088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 318262088
		arg_365_1.duration_ = 4.2

		local var_365_0 = {
			zh = 3.9,
			ja = 4.2
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
				arg_365_0:Play318262089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1015ui_story = arg_365_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_368_0 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 then
				arg_365_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_365_1.time_ - 0) / var_368_0)
				arg_365_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1015ui_story"].transform.position).z)
				arg_365_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1015ui_story"].transform.localEulerAngles = arg_365_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 then
				arg_365_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_365_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1015ui_story"].transform.position).z)
				arg_365_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1015ui_story"].transform.localEulerAngles = arg_365_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_368_1 = arg_365_1.actors_["1015ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1015ui_story == nil then
				arg_365_1.var_.characterEffect1015ui_story = var_368_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_2 and not isNil(var_368_1) then
				if arg_365_1.var_.characterEffect1015ui_story and not isNil(var_368_1) then
					arg_365_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_2 and arg_365_1.time_ < 0 + var_368_2 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1015ui_story then
				arg_365_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action8_2")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_368_4 = 0
			local var_368_5 = 0.175

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_6 = arg_365_1:GetWordFromCfg(318262088)
				local var_368_7 = arg_365_1:FormatText(var_368_6.content)

				arg_365_1.text_.text = var_368_7

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_9 = 7 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 7)

				if (7 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 7)) > 0 and var_368_5 < var_368_9 then
					arg_365_1.talkMaxDuration = var_368_9

					if var_368_9 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_9 + var_368_4
					end
				end

				arg_365_1.text_.text = var_368_7
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262088", "story_v_out_318262.awb") ~= 0 then
					local var_368_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262088", "story_v_out_318262.awb") / 1000

					if var_368_10 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_4
					end

					if var_368_6.prefab_name ~= "" and arg_365_1.actors_[var_368_6.prefab_name] ~= nil then
						local var_368_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_6.prefab_name].transform, "story_v_out_318262", "318262088", "story_v_out_318262.awb")

						arg_365_1:RecordAudio("318262088", var_368_11)
						arg_365_1:RecordAudio("318262088", var_368_11)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_318262", "318262088", "story_v_out_318262.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_318262", "318262088", "story_v_out_318262.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_12 = math.max(var_368_5, arg_365_1.talkMaxDuration)

			if var_368_4 <= arg_365_1.time_ and arg_365_1.time_ < var_368_4 + var_368_12 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_4) / var_368_12

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_4 + var_368_12 and arg_365_1.time_ < var_368_4 + var_368_12 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play318262089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 318262089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play318262090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1015ui_story = arg_369_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).z)
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles = arg_369_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_369_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1015ui_story"].transform.position).z)
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1015ui_story"].transform.localEulerAngles = arg_369_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_372_1 = arg_369_1.actors_["1015ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1015ui_story == nil then
				arg_369_1.var_.characterEffect1015ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect1015ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_2)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1015ui_story then
				arg_369_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_372_3 = 0
			local var_372_4 = 0.275

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_3 + arg_372_0 then
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

				local var_372_5 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(318262089).content)

				arg_369_1.text_.text = var_372_5

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_7 = 11 <= 0 and var_372_4 or var_372_4 * (utf8.len(var_372_5) / 11)

				if (11 <= 0 and var_372_4 or var_372_4 * (utf8.len(var_372_5) / 11)) > 0 and var_372_4 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_3 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_3
					end
				end

				arg_369_1.text_.text = var_372_5
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_8 = math.max(var_372_4, arg_369_1.talkMaxDuration)

			if var_372_3 <= arg_369_1.time_ and arg_369_1.time_ < var_372_3 + var_372_8 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_3) / var_372_8

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_3 + var_372_8 and arg_369_1.time_ < var_372_3 + var_372_8 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play318262090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 318262090
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play318262091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 1.2

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

				local var_376_1 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(318262090).content)

				arg_373_1.text_.text = var_376_1

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_3 = 48 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 48)

				if (48 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 48)) > 0 and var_376_0 < var_376_3 then
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
	Play318262091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 318262091
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play318262092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.8

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(318262091).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 32 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 32)

				if (32 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 32)) > 0 and var_380_0 < var_380_3 then
					arg_377_1.talkMaxDuration = var_380_3

					if var_380_3 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_3 + 0
					end
				end

				arg_377_1.text_.text = var_380_1
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_4 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_4

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play318262092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 318262092
		arg_381_1.duration_ = 5.57

		local var_381_0 = {
			zh = 5.566,
			ja = 4.4
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
				arg_381_0:Play318262093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10066ui_story = arg_381_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["10066ui_story"].transform.position).z)
				arg_381_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["10066ui_story"].transform.localEulerAngles = arg_381_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_381_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["10066ui_story"].transform.position).z)
				arg_381_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["10066ui_story"].transform.localEulerAngles = arg_381_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["10066ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect10066ui_story == nil then
				arg_381_1.var_.characterEffect10066ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect10066ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect10066ui_story then
				arg_381_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_384_4 = 0
			local var_384_5 = 0.375

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_6 = arg_381_1:GetWordFromCfg(318262092)
				local var_384_7 = arg_381_1:FormatText(var_384_6.content)

				arg_381_1.text_.text = var_384_7

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_9 = 15 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 15)

				if (15 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 15)) > 0 and var_384_5 < var_384_9 then
					arg_381_1.talkMaxDuration = var_384_9

					if var_384_9 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_9 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_7
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262092", "story_v_out_318262.awb") ~= 0 then
					local var_384_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262092", "story_v_out_318262.awb") / 1000

					if var_384_10 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_4
					end

					if var_384_6.prefab_name ~= "" and arg_381_1.actors_[var_384_6.prefab_name] ~= nil then
						local var_384_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_6.prefab_name].transform, "story_v_out_318262", "318262092", "story_v_out_318262.awb")

						arg_381_1:RecordAudio("318262092", var_384_11)
						arg_381_1:RecordAudio("318262092", var_384_11)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_318262", "318262092", "story_v_out_318262.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_318262", "318262092", "story_v_out_318262.awb")
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play318262093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 318262093
		arg_385_1.duration_ = 7.1

		local var_385_0 = {
			zh = 6.2,
			ja = 7.1
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
				arg_385_0:Play318262094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["4016ui_story"]) and arg_385_1.var_.characterEffect4016ui_story == nil then
				arg_385_1.var_.characterEffect4016ui_story = arg_385_1.actors_["4016ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["4016ui_story"]) then
				if arg_385_1.var_.characterEffect4016ui_story and not isNil(arg_385_1.actors_["4016ui_story"]) then
					arg_385_1.var_.characterEffect4016ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["4016ui_story"]) and arg_385_1.var_.characterEffect4016ui_story then
				arg_385_1.var_.characterEffect4016ui_story.fillFlat = false
			end

			local var_388_2 = arg_385_1.actors_["10066ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos10066ui_story = var_388_2.localPosition
			end

			local var_388_3 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_3 then
				var_388_2.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_385_1.time_ - 0) / var_388_3)
				var_388_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_2.position).x, (manager.ui.mainCamera.transform.position - var_388_2.position).y, (manager.ui.mainCamera.transform.position - var_388_2.position).z)
				var_388_2.localEulerAngles.z = 0
				var_388_2.localEulerAngles.x = 0
				var_388_2.localEulerAngles = var_388_2.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_3 and arg_385_1.time_ < 0 + var_388_3 + arg_388_0 then
				var_388_2.localPosition = Vector3.New(0, 100, 0)
				var_388_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_2.position).x, (manager.ui.mainCamera.transform.position - var_388_2.position).y, (manager.ui.mainCamera.transform.position - var_388_2.position).z)
				var_388_2.localEulerAngles.z = 0
				var_388_2.localEulerAngles.x = 0
				var_388_2.localEulerAngles = var_388_2.localEulerAngles
			end

			local var_388_4 = arg_385_1.actors_["10066ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_4) and arg_385_1.var_.characterEffect10066ui_story == nil then
				arg_385_1.var_.characterEffect10066ui_story = var_388_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_5 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_5 and not isNil(var_388_4) then
				if arg_385_1.var_.characterEffect10066ui_story and not isNil(var_388_4) then
					arg_385_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_385_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_5)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_5 and arg_385_1.time_ < 0 + var_388_5 + arg_388_0 and not isNil(var_388_4) and arg_385_1.var_.characterEffect10066ui_story then
				arg_385_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_385_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_388_6 = arg_385_1.actors_["4016ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos4016ui_story = var_388_6.localPosition
				var_388_6.localScale = Vector3.New(0.5, 0.5, 0.5)
			end

			local var_388_7 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				var_388_6.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos4016ui_story, Vector3.New(0, -2, 2.45), (arg_385_1.time_ - 0) / var_388_7)
				var_388_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_6.position).x, (manager.ui.mainCamera.transform.position - var_388_6.position).y, (manager.ui.mainCamera.transform.position - var_388_6.position).z)
				var_388_6.localEulerAngles.z = 0
				var_388_6.localEulerAngles.x = 0
				var_388_6.localEulerAngles = var_388_6.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				var_388_6.localPosition = Vector3.New(0, -2, 2.45)
				var_388_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_6.position).x, (manager.ui.mainCamera.transform.position - var_388_6.position).y, (manager.ui.mainCamera.transform.position - var_388_6.position).z)
				var_388_6.localEulerAngles.z = 0
				var_388_6.localEulerAngles.x = 0
				var_388_6.localEulerAngles = var_388_6.localEulerAngles
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("4016ui_story", "StoryTimeline/CharAction/story4016/story4016action/4016action1_1")
			end

			local var_388_8 = 0
			local var_388_9 = 0.575

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_10 = arg_385_1:GetWordFromCfg(318262093)
				local var_388_11 = arg_385_1:FormatText(var_388_10.content)

				arg_385_1.text_.text = var_388_11

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_13 = 23 <= 0 and var_388_9 or var_388_9 * (utf8.len(var_388_11) / 23)

				if (23 <= 0 and var_388_9 or var_388_9 * (utf8.len(var_388_11) / 23)) > 0 and var_388_9 < var_388_13 then
					arg_385_1.talkMaxDuration = var_388_13

					if var_388_13 + var_388_8 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_8
					end
				end

				arg_385_1.text_.text = var_388_11
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262093", "story_v_out_318262.awb") ~= 0 then
					local var_388_14 = manager.audio:GetVoiceLength("story_v_out_318262", "318262093", "story_v_out_318262.awb") / 1000

					if var_388_14 + var_388_8 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_14 + var_388_8
					end

					if var_388_10.prefab_name ~= "" and arg_385_1.actors_[var_388_10.prefab_name] ~= nil then
						local var_388_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_10.prefab_name].transform, "story_v_out_318262", "318262093", "story_v_out_318262.awb")

						arg_385_1:RecordAudio("318262093", var_388_15)
						arg_385_1:RecordAudio("318262093", var_388_15)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_318262", "318262093", "story_v_out_318262.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_318262", "318262093", "story_v_out_318262.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_16 = math.max(var_388_9, arg_385_1.talkMaxDuration)

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_16 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_8) / var_388_16

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_8 + var_388_16 and arg_385_1.time_ < var_388_8 + var_388_16 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play318262094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 318262094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play318262095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos4016ui_story = arg_389_1.actors_["4016ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["4016ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos4016ui_story, Vector3.New(0, 100, 0), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["4016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["4016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["4016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["4016ui_story"].transform.position).z)
				arg_389_1.actors_["4016ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["4016ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["4016ui_story"].transform.localEulerAngles = arg_389_1.actors_["4016ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["4016ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_389_1.actors_["4016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["4016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["4016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["4016ui_story"].transform.position).z)
				arg_389_1.actors_["4016ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["4016ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["4016ui_story"].transform.localEulerAngles = arg_389_1.actors_["4016ui_story"].transform.localEulerAngles
			end

			local var_392_1 = arg_389_1.actors_["10065ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect10065ui_story == nil then
				arg_389_1.var_.characterEffect10065ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 and not isNil(var_392_1) then
				if arg_389_1.var_.characterEffect10065ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_389_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_2)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect10065ui_story then
				arg_389_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_389_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_392_3 = 0
			local var_392_4 = 0.3

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_3 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_5 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(318262094).content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 12 <= 0 and var_392_4 or var_392_4 * (utf8.len(var_392_5) / 12)

				if (12 <= 0 and var_392_4 or var_392_4 * (utf8.len(var_392_5) / 12)) > 0 and var_392_4 < var_392_7 then
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
				actorName = "4016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play318262095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 318262095
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play318262096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.475

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(318262095).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 59 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 59)

				if (59 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 59)) > 0 and var_396_0 < var_396_3 then
					arg_393_1.talkMaxDuration = var_396_3

					if var_396_3 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_3 + 0
					end
				end

				arg_393_1.text_.text = var_396_1
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_4 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_4

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play318262096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 318262096
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play318262097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 1.025

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(318262096).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 41 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 41)

				if (41 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 41)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play318262097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 318262097
		arg_401_1.duration_ = 9.83

		local var_401_0 = {
			zh = 9.833,
			ja = 9.4
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play318262098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["4016ui_story"]) and arg_401_1.var_.characterEffect4016ui_story == nil then
				arg_401_1.var_.characterEffect4016ui_story = arg_401_1.actors_["4016ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["4016ui_story"]) then
				if arg_401_1.var_.characterEffect4016ui_story and not isNil(arg_401_1.actors_["4016ui_story"]) then
					arg_401_1.var_.characterEffect4016ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["4016ui_story"]) and arg_401_1.var_.characterEffect4016ui_story then
				arg_401_1.var_.characterEffect4016ui_story.fillFlat = false
			end

			local var_404_2 = arg_401_1.actors_["4016ui_story"].transform

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos4016ui_story = var_404_2.localPosition
				var_404_2.localScale = Vector3.New(0.5, 0.5, 0.5)
			end

			local var_404_3 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_3 then
				var_404_2.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos4016ui_story, Vector3.New(0, -2, 2.45), (arg_401_1.time_ - 0) / var_404_3)
				var_404_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_404_2.position).x, (manager.ui.mainCamera.transform.position - var_404_2.position).y, (manager.ui.mainCamera.transform.position - var_404_2.position).z)
				var_404_2.localEulerAngles.z = 0
				var_404_2.localEulerAngles.x = 0
				var_404_2.localEulerAngles = var_404_2.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_3 and arg_401_1.time_ < 0 + var_404_3 + arg_404_0 then
				var_404_2.localPosition = Vector3.New(0, -2, 2.45)
				var_404_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_404_2.position).x, (manager.ui.mainCamera.transform.position - var_404_2.position).y, (manager.ui.mainCamera.transform.position - var_404_2.position).z)
				var_404_2.localEulerAngles.z = 0
				var_404_2.localEulerAngles.x = 0
				var_404_2.localEulerAngles = var_404_2.localEulerAngles
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("4016ui_story", "StoryTimeline/CharAction/story4016/story4016action/4016action1_1")
			end

			local var_404_4 = 0
			local var_404_5 = 0.5

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_6 = arg_401_1:GetWordFromCfg(318262097)
				local var_404_7 = arg_401_1:FormatText(var_404_6.content)

				arg_401_1.text_.text = var_404_7

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_9 = 20 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 20)

				if (20 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 20)) > 0 and var_404_5 < var_404_9 then
					arg_401_1.talkMaxDuration = var_404_9

					if var_404_9 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_9 + var_404_4
					end
				end

				arg_401_1.text_.text = var_404_7
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318262", "318262097", "story_v_out_318262.awb") ~= 0 then
					local var_404_10 = manager.audio:GetVoiceLength("story_v_out_318262", "318262097", "story_v_out_318262.awb") / 1000

					if var_404_10 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_4
					end

					if var_404_6.prefab_name ~= "" and arg_401_1.actors_[var_404_6.prefab_name] ~= nil then
						local var_404_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_6.prefab_name].transform, "story_v_out_318262", "318262097", "story_v_out_318262.awb")

						arg_401_1:RecordAudio("318262097", var_404_11)
						arg_401_1:RecordAudio("318262097", var_404_11)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_318262", "318262097", "story_v_out_318262.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_318262", "318262097", "story_v_out_318262.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_12 = math.max(var_404_5, arg_401_1.talkMaxDuration)

			if var_404_4 <= arg_401_1.time_ and arg_401_1.time_ < var_404_4 + var_404_12 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_4) / var_404_12

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_4 + var_404_12 and arg_401_1.time_ < var_404_4 + var_404_12 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play318262098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 318262098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play318262099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos4016ui_story = arg_405_1.actors_["4016ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["4016ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos4016ui_story, Vector3.New(0, 100, 0), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["4016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["4016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["4016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["4016ui_story"].transform.position).z)
				arg_405_1.actors_["4016ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["4016ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["4016ui_story"].transform.localEulerAngles = arg_405_1.actors_["4016ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["4016ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_405_1.actors_["4016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["4016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["4016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["4016ui_story"].transform.position).z)
				arg_405_1.actors_["4016ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["4016ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["4016ui_story"].transform.localEulerAngles = arg_405_1.actors_["4016ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["4016ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect4016ui_story == nil then
				arg_405_1.var_.characterEffect4016ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect4016ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect4016ui_story.fillFlat = true
					arg_405_1.var_.characterEffect4016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_2)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect4016ui_story then
				arg_405_1.var_.characterEffect4016ui_story.fillFlat = true
				arg_405_1.var_.characterEffect4016ui_story.fillRatio = 0.5
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_blast", "")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_408_5 = 0
			local var_408_6 = 1.225

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_5 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_7 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(318262098).content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_9 = 49 <= 0 and var_408_6 or var_408_6 * (utf8.len(var_408_7) / 49)

				if (49 <= 0 and var_408_6 or var_408_6 * (utf8.len(var_408_7) / 49)) > 0 and var_408_6 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_5 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_5
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_10 = math.max(var_408_6, arg_405_1.talkMaxDuration)

			if var_408_5 <= arg_405_1.time_ and arg_405_1.time_ < var_408_5 + var_408_10 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_5) / var_408_10

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_5 + var_408_10 and arg_405_1.time_ < var_408_5 + var_408_10 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play318262099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 318262099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
			arg_409_1.auto_ = false
		end

		function arg_409_1.playNext_(arg_411_0)
			arg_409_1.onStoryFinished_()
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.8

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_1 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(318262099).content)

				arg_409_1.text_.text = var_412_1

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_3 = 32 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 32)

				if (32 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 32)) > 0 and var_412_0 < var_412_3 then
					arg_409_1.talkMaxDuration = var_412_3

					if var_412_3 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_3 + 0
					end
				end

				arg_409_1.text_.text = var_412_1
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_4 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_4 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_4

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_4 and arg_409_1.time_ < 0 + var_412_4 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K16i",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/LX0206",
		"TextureConfig/Background/K05f",
		"TextureConfig/Background/K16i_blur"
	},
	voices = {
		"story_v_out_318262.awb"
	}
}
