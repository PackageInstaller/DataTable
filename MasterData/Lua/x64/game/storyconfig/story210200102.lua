return {
	Play1102002001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1102002001
		arg_1_1.duration_ = 4.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1102002002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_4_0.name = "ST12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST12

				arg_1_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST12" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1029ui_story"

			if arg_1_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1029ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1029ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.09, -6.2)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1029ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1029ui_story == nil then
				arg_1_1.var_.characterEffect1029ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1029ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1029ui_story then
				arg_1_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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
				arg_1_1:AudioAction("play", "music", "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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
				arg_1_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2.00000000298023
			local var_4_26 = 0.35

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(1102002001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 14 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 14)

				if (14 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 14)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002001", "story_v_side_new_1102002.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002001", "story_v_side_new_1102002.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_side_new_1102002", "1102002001", "story_v_side_new_1102002.awb")

						arg_1_1:RecordAudio("1102002001", var_4_33)
						arg_1_1:RecordAudio("1102002001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002001", "story_v_side_new_1102002.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002001", "story_v_side_new_1102002.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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
	Play1102002002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1102002002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1102002003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1029ui_story"]) and arg_9_1.var_.characterEffect1029ui_story == nil then
				arg_9_1.var_.characterEffect1029ui_story = arg_9_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1029ui_story"]) then
				if arg_9_1.var_.characterEffect1029ui_story and not isNil(arg_9_1.actors_["1029ui_story"]) then
					arg_9_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1029ui_story"]) and arg_9_1.var_.characterEffect1029ui_story then
				arg_9_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.275

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

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1102002002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 11 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 11)

				if (11 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 11)) > 0 and var_12_2 < var_12_5 then
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
	Play1102002003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1102002003
		arg_13_1.duration_ = 3.7

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1102002004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1029ui_story"]) and arg_13_1.var_.characterEffect1029ui_story == nil then
				arg_13_1.var_.characterEffect1029ui_story = arg_13_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1029ui_story"]) then
				if arg_13_1.var_.characterEffect1029ui_story and not isNil(arg_13_1.actors_["1029ui_story"]) then
					arg_13_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1029ui_story"]) and arg_13_1.var_.characterEffect1029ui_story then
				arg_13_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_16_2 = 0
			local var_16_3 = 0.425

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(1102002003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 17 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 17)

				if (17 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 17)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002003", "story_v_side_new_1102002.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002003", "story_v_side_new_1102002.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_side_new_1102002", "1102002003", "story_v_side_new_1102002.awb")

						arg_13_1:RecordAudio("1102002003", var_16_9)
						arg_13_1:RecordAudio("1102002003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002003", "story_v_side_new_1102002.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002003", "story_v_side_new_1102002.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_10 and arg_13_1.time_ < var_16_2 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1102002004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1102002004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1102002005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1029ui_story"]) and arg_17_1.var_.characterEffect1029ui_story == nil then
				arg_17_1.var_.characterEffect1029ui_story = arg_17_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1029ui_story"]) then
				if arg_17_1.var_.characterEffect1029ui_story and not isNil(arg_17_1.actors_["1029ui_story"]) then
					arg_17_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1029ui_story"]) and arg_17_1.var_.characterEffect1029ui_story then
				arg_17_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 1.175

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

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1102002004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 47 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 47)

				if (47 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 47)) > 0 and var_20_2 < var_20_5 then
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
	Play1102002005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1102002005
		arg_21_1.duration_ = 7.23

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1102002006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1029ui_story"]) and arg_21_1.var_.characterEffect1029ui_story == nil then
				arg_21_1.var_.characterEffect1029ui_story = arg_21_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1029ui_story"]) then
				if arg_21_1.var_.characterEffect1029ui_story and not isNil(arg_21_1.actors_["1029ui_story"]) then
					arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1029ui_story"]) and arg_21_1.var_.characterEffect1029ui_story then
				arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_24_2 = 0
			local var_24_3 = 0.8

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(1102002005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 32 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 32)

				if (32 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 32)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002005", "story_v_side_new_1102002.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002005", "story_v_side_new_1102002.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_side_new_1102002", "1102002005", "story_v_side_new_1102002.awb")

						arg_21_1:RecordAudio("1102002005", var_24_9)
						arg_21_1:RecordAudio("1102002005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002005", "story_v_side_new_1102002.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002005", "story_v_side_new_1102002.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1102002006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1102002006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1102002007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1029ui_story"]) and arg_25_1.var_.characterEffect1029ui_story == nil then
				arg_25_1.var_.characterEffect1029ui_story = arg_25_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1029ui_story"]) then
				if arg_25_1.var_.characterEffect1029ui_story and not isNil(arg_25_1.actors_["1029ui_story"]) then
					arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1029ui_story"]) and arg_25_1.var_.characterEffect1029ui_story then
				arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1102002006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 40 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 40)

				if (40 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 40)) > 0 and var_28_2 < var_28_5 then
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

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1102002007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1102002007
		arg_29_1.duration_ = 2.5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1102002008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1029ui_story"]) and arg_29_1.var_.characterEffect1029ui_story == nil then
				arg_29_1.var_.characterEffect1029ui_story = arg_29_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1029ui_story"]) then
				if arg_29_1.var_.characterEffect1029ui_story and not isNil(arg_29_1.actors_["1029ui_story"]) then
					arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1029ui_story"]) and arg_29_1.var_.characterEffect1029ui_story then
				arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_2 = 0
			local var_32_3 = 0.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(1102002007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 13 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 13)

				if (13 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 13)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002007", "story_v_side_new_1102002.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002007", "story_v_side_new_1102002.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_side_new_1102002", "1102002007", "story_v_side_new_1102002.awb")

						arg_29_1:RecordAudio("1102002007", var_32_9)
						arg_29_1:RecordAudio("1102002007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002007", "story_v_side_new_1102002.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002007", "story_v_side_new_1102002.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1102002008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1102002008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1102002009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1029ui_story"]) and arg_33_1.var_.characterEffect1029ui_story == nil then
				arg_33_1.var_.characterEffect1029ui_story = arg_33_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1029ui_story"]) then
				if arg_33_1.var_.characterEffect1029ui_story and not isNil(arg_33_1.actors_["1029ui_story"]) then
					arg_33_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1029ui_story"]) and arg_33_1.var_.characterEffect1029ui_story then
				arg_33_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 1.275

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

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1102002008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 51 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 51)

				if (51 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 51)) > 0 and var_36_2 < var_36_5 then
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
	Play1102002009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1102002009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1102002010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.975

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

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1102002009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 39)

				if (39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 39)) > 0 and var_40_0 < var_40_3 then
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
	Play1102002010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1102002010
		arg_41_1.duration_ = 8.5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1102002011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1029ui_story"]) and arg_41_1.var_.characterEffect1029ui_story == nil then
				arg_41_1.var_.characterEffect1029ui_story = arg_41_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1029ui_story"]) then
				if arg_41_1.var_.characterEffect1029ui_story and not isNil(arg_41_1.actors_["1029ui_story"]) then
					arg_41_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1029ui_story"]) and arg_41_1.var_.characterEffect1029ui_story then
				arg_41_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_44_2 = 0
			local var_44_3 = 0.6

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(1102002010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 24 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 24)

				if (24 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 24)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002010", "story_v_side_new_1102002.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002010", "story_v_side_new_1102002.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_side_new_1102002", "1102002010", "story_v_side_new_1102002.awb")

						arg_41_1:RecordAudio("1102002010", var_44_9)
						arg_41_1:RecordAudio("1102002010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002010", "story_v_side_new_1102002.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002010", "story_v_side_new_1102002.awb")
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
	Play1102002011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1102002011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1102002012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1029ui_story"]) and arg_45_1.var_.characterEffect1029ui_story == nil then
				arg_45_1.var_.characterEffect1029ui_story = arg_45_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1029ui_story"]) then
				if arg_45_1.var_.characterEffect1029ui_story and not isNil(arg_45_1.actors_["1029ui_story"]) then
					arg_45_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1029ui_story"]) and arg_45_1.var_.characterEffect1029ui_story then
				arg_45_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.225

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1102002011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 9 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 9)

				if (9 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 9)) > 0 and var_48_2 < var_48_5 then
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
	Play1102002012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1102002012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1102002013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.05

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

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1102002012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 2 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 2)

				if (2 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 2)) > 0 and var_52_0 < var_52_3 then
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
	Play1102002013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1102002013
		arg_53_1.duration_ = 5.13

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1102002014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.bgs_.STblack == nil then
				local var_56_0 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_56_0.name = "STblack"
				var_56_0.transform.parent = arg_53_1.stage_.transform
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_.STblack = var_56_0
			end

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= 2 + arg_56_0 then
				local var_56_1 = arg_53_1.bgs_.STblack

				arg_53_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_56_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_2 = var_56_1:GetComponent("SpriteRenderer")

				if var_56_2 and var_56_2.sprite then
					local var_56_3 = 2 * (var_56_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_56_1.transform.localScale = Vector3.New(var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "STblack" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_4 = 4

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_4 + 0.3 and arg_53_1.time_ < var_56_4 + 0.3 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_5 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_6 = 2

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_6 then
				local var_56_7 = Color.New(0, 0, 0)

				var_56_7.a = Mathf.Lerp(0, 1, (arg_53_1.time_ - var_56_5) / var_56_6)
				arg_53_1.mask_.color = var_56_7
			end

			if arg_53_1.time_ >= var_56_5 + var_56_6 and arg_53_1.time_ < var_56_5 + var_56_6 + arg_56_0 then
				local var_56_8 = Color.New(0, 0, 0)

				var_56_8.a = 1
				arg_53_1.mask_.color = var_56_8
			end

			local var_56_9 = 2

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_10 = 2

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 then
				local var_56_11 = Color.New(0, 0, 0)

				var_56_11.a = Mathf.Lerp(1, 0, (arg_53_1.time_ - var_56_9) / var_56_10)
				arg_53_1.mask_.color = var_56_11
			end

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 then
				local var_56_12 = Color.New(0, 0, 0)

				arg_53_1.mask_.enabled = false
				var_56_12.a = 0
				arg_53_1.mask_.color = var_56_12
			end

			local var_56_13 = arg_53_1.actors_["1029ui_story"].transform

			if 1.96599999815226 < arg_53_1.time_ and arg_53_1.time_ <= 1.96599999815226 + arg_56_0 then
				arg_53_1.var_.moveOldPos1029ui_story = var_56_13.localPosition
			end

			local var_56_14 = 0.001

			if 1.96599999815226 <= arg_53_1.time_ and arg_53_1.time_ < 1.96599999815226 + var_56_14 then
				var_56_13.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 1.96599999815226) / var_56_14)
				var_56_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_13.position).x, (manager.ui.mainCamera.transform.position - var_56_13.position).y, (manager.ui.mainCamera.transform.position - var_56_13.position).z)
				var_56_13.localEulerAngles.z = 0
				var_56_13.localEulerAngles.x = 0
				var_56_13.localEulerAngles = var_56_13.localEulerAngles
			end

			if arg_53_1.time_ >= 1.96599999815226 + var_56_14 and arg_53_1.time_ < 1.96599999815226 + var_56_14 + arg_56_0 then
				var_56_13.localPosition = Vector3.New(0, 100, 0)
				var_56_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_13.position).x, (manager.ui.mainCamera.transform.position - var_56_13.position).y, (manager.ui.mainCamera.transform.position - var_56_13.position).z)
				var_56_13.localEulerAngles.z = 0
				var_56_13.localEulerAngles.x = 0
				var_56_13.localEulerAngles = var_56_13.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_56_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_53_1.bgmTxt_.text ~= var_56_17 and arg_53_1.bgmTxt_.text ~= "" then
						if arg_53_1.bgmTxt2_.text ~= "" then
							arg_53_1.bgmTxt_.text = arg_53_1.bgmTxt2_.text
						end

						arg_53_1.bgmTxt2_.text = var_56_17

						arg_53_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_53_1.bgmTxt_.text = var_56_17
						arg_53_1.bgmTxt2_.text = var_56_17
					end

					if arg_53_1.bgmTimer then
						arg_53_1.bgmTimer:Stop()

						arg_53_1.bgmTimer = nil
					end

					if arg_53_1.settingData.show_music_name == 1 then
						arg_53_1.musicController:SetSelectedState("show")
						arg_53_1.musicAnimator_:Play("open", 0, 0)

						if arg_53_1.settingData.music_time ~= 0 then
							arg_53_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_53_1.settingData.music_time), function()
								if arg_53_1 == nil or isNil(arg_53_1.bgmTxt_) then
									return
								end

								arg_53_1.musicController:SetSelectedState("hide")
								arg_53_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_18 = 4
			local var_56_19 = 0.075

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_18 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_20 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_20:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_53_1.dialogCg_.alpha = arg_58_0
				end))
				var_56_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_21 = arg_53_1:GetWordFromCfg(1102002013)
				local var_56_22 = arg_53_1:FormatText(var_56_21.content)

				arg_53_1.text_.text = var_56_22

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_24 = 3 <= 0 and var_56_19 or var_56_19 * (utf8.len(var_56_22) / 3)

				if (3 <= 0 and var_56_19 or var_56_19 * (utf8.len(var_56_22) / 3)) > 0 and var_56_19 < var_56_24 then
					arg_53_1.talkMaxDuration = var_56_24
					var_56_18 = var_56_18 + 0.3

					if var_56_24 + var_56_18 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_24 + var_56_18
					end
				end

				arg_53_1.text_.text = var_56_22
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002013", "story_v_side_new_1102002.awb") ~= 0 then
					local var_56_25 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002013", "story_v_side_new_1102002.awb") / 1000

					if var_56_25 + var_56_18 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_25 + var_56_18
					end

					if var_56_21.prefab_name ~= "" and arg_53_1.actors_[var_56_21.prefab_name] ~= nil then
						local var_56_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_21.prefab_name].transform, "story_v_side_new_1102002", "1102002013", "story_v_side_new_1102002.awb")

						arg_53_1:RecordAudio("1102002013", var_56_26)
						arg_53_1:RecordAudio("1102002013", var_56_26)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002013", "story_v_side_new_1102002.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002013", "story_v_side_new_1102002.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_27 = var_56_18 + 0.3
			local var_56_28 = math.max(var_56_19, arg_53_1.talkMaxDuration)

			if var_56_18 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_27 + var_56_28 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_27) / var_56_28

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_27 + var_56_28 and arg_53_1.time_ < var_56_27 + var_56_28 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play1102002014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1102002014
		arg_60_1.duration_ = 7

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1102002015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if arg_60_1.bgs_.ST61 == nil then
				local var_63_0 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_63_0.name = "ST61"
				var_63_0.transform.parent = arg_60_1.stage_.transform
				var_63_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_.ST61 = var_63_0
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				local var_63_1 = arg_60_1.bgs_.ST61

				arg_60_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_63_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_2 = var_63_1:GetComponent("SpriteRenderer")

				if var_63_2 and var_63_2.sprite then
					local var_63_3 = 2 * (var_63_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_63_1.transform.localScale = Vector3.New(var_63_3 / var_63_2.sprite.bounds.size.y < var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x and var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x or var_63_3 / var_63_2.sprite.bounds.size.y, var_63_3 / var_63_2.sprite.bounds.size.y < var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x and var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x or var_63_3 / var_63_2.sprite.bounds.size.y, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "ST61" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_4 = 2

			if 2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			if arg_60_1.time_ >= var_63_4 + 0.3 and arg_60_1.time_ < var_63_4 + 0.3 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_5 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_6 = 2

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 then
				local var_63_7 = Color.New(0, 0, 0)

				var_63_7.a = Mathf.Lerp(1, 0, (arg_60_1.time_ - var_63_5) / var_63_6)
				arg_60_1.mask_.color = var_63_7
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 then
				local var_63_8 = Color.New(0, 0, 0)

				arg_60_1.mask_.enabled = false
				var_63_8.a = 0
				arg_60_1.mask_.color = var_63_8
			end

			if 0.125 < arg_60_1.time_ and arg_60_1.time_ <= 0.125 + arg_63_0 then
				arg_60_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 0.125 < arg_60_1.time_ and arg_60_1.time_ <= 0.125 + arg_63_0 then
				arg_60_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_63_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_60_1.bgmTxt_.text ~= var_63_13 and arg_60_1.bgmTxt_.text ~= "" then
						if arg_60_1.bgmTxt2_.text ~= "" then
							arg_60_1.bgmTxt_.text = arg_60_1.bgmTxt2_.text
						end

						arg_60_1.bgmTxt2_.text = var_63_13

						arg_60_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_60_1.bgmTxt_.text = var_63_13
						arg_60_1.bgmTxt2_.text = var_63_13
					end

					if arg_60_1.bgmTimer then
						arg_60_1.bgmTimer:Stop()

						arg_60_1.bgmTimer = nil
					end

					if arg_60_1.settingData.show_music_name == 1 then
						arg_60_1.musicController:SetSelectedState("show")
						arg_60_1.musicAnimator_:Play("open", 0, 0)

						if arg_60_1.settingData.music_time ~= 0 then
							arg_60_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_60_1.settingData.music_time), function()
								if arg_60_1 == nil or isNil(arg_60_1.bgmTxt_) then
									return
								end

								arg_60_1.musicController:SetSelectedState("hide")
								arg_60_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_60_1.time_ and arg_60_1.time_ <= 0.4 + arg_63_0 then
				arg_60_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_63_16 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_60_1.bgmTxt_.text ~= var_63_16 and arg_60_1.bgmTxt_.text ~= "" then
						if arg_60_1.bgmTxt2_.text ~= "" then
							arg_60_1.bgmTxt_.text = arg_60_1.bgmTxt2_.text
						end

						arg_60_1.bgmTxt2_.text = var_63_16

						arg_60_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_60_1.bgmTxt_.text = var_63_16
						arg_60_1.bgmTxt2_.text = var_63_16
					end

					if arg_60_1.bgmTimer then
						arg_60_1.bgmTimer:Stop()

						arg_60_1.bgmTimer = nil
					end

					if arg_60_1.settingData.show_music_name == 1 then
						arg_60_1.musicController:SetSelectedState("show")
						arg_60_1.musicAnimator_:Play("open", 0, 0)

						if arg_60_1.settingData.music_time ~= 0 then
							arg_60_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_60_1.settingData.music_time), function()
								if arg_60_1 == nil or isNil(arg_60_1.bgmTxt_) then
									return
								end

								arg_60_1.musicController:SetSelectedState("hide")
								arg_60_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_17 = 2
			local var_63_18 = 0.075

			if 2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_19 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_19:setOnUpdate(LuaHelper.FloatAction(function(arg_66_0)
					arg_60_1.dialogCg_.alpha = arg_66_0
				end))
				var_63_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_20 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(1102002014).content)

				arg_60_1.text_.text = var_63_20

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_22 = 3 <= 0 and var_63_18 or var_63_18 * (utf8.len(var_63_20) / 3)

				if (3 <= 0 and var_63_18 or var_63_18 * (utf8.len(var_63_20) / 3)) > 0 and var_63_18 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22
					var_63_17 = var_63_17 + 0.3

					if var_63_22 + var_63_17 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_17
					end
				end

				arg_60_1.text_.text = var_63_20
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_23 = var_63_17 + 0.3
			local var_63_24 = math.max(var_63_18, arg_60_1.talkMaxDuration)

			if var_63_17 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_24 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_23) / var_63_24

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_23 + var_63_24 and arg_60_1.time_ < var_63_23 + var_63_24 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1102002015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1102002015
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1102002016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 1.025

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(1102002015).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 41 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 41)

				if (41 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 41)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1102002016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1102002016
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1102002017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 1.025

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(1102002016).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 41 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 41)

				if (41 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 41)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1102002017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1102002017
		arg_76_1.duration_ = 3.4

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1102002018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if arg_76_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_79_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_76_1.stage_.transform)

				var_79_0.name = "1089ui_story"
				var_79_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_["1089ui_story"] = var_79_0

				local var_79_1 = var_79_0:GetComponentInChildren(typeof(CharacterEffect))

				var_79_1.enabled = true

				local var_79_2 = GameObjectTools.GetOrAddComponent(var_79_0, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(false)
				end

				arg_76_1:ShowWeapon(var_79_1.transform, false)

				arg_76_1.var_["1089ui_story" .. "Animator"] = var_79_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_76_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_76_1.var_["1089ui_story" .. "LipSync"] = var_79_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_79_3 = arg_76_1.actors_["1089ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1089ui_story = var_79_3.localPosition
			end

			local var_79_4 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				var_79_3.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_76_1.time_ - 0) / var_79_4)
				var_79_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_3.position).x, (manager.ui.mainCamera.transform.position - var_79_3.position).y, (manager.ui.mainCamera.transform.position - var_79_3.position).z)
				var_79_3.localEulerAngles.z = 0
				var_79_3.localEulerAngles.x = 0
				var_79_3.localEulerAngles = var_79_3.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				var_79_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_79_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_3.position).x, (manager.ui.mainCamera.transform.position - var_79_3.position).y, (manager.ui.mainCamera.transform.position - var_79_3.position).z)
				var_79_3.localEulerAngles.z = 0
				var_79_3.localEulerAngles.x = 0
				var_79_3.localEulerAngles = var_79_3.localEulerAngles
			end

			local var_79_5 = arg_76_1.actors_["1089ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_5) and arg_76_1.var_.characterEffect1089ui_story == nil then
				arg_76_1.var_.characterEffect1089ui_story = var_79_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_6 and not isNil(var_79_5) then
				if arg_76_1.var_.characterEffect1089ui_story and not isNil(var_79_5) then
					arg_76_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_6 and arg_76_1.time_ < 0 + var_79_6 + arg_79_0 and not isNil(var_79_5) and arg_76_1.var_.characterEffect1089ui_story then
				arg_76_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_8 = 0
			local var_79_9 = 0.275

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_10 = arg_76_1:GetWordFromCfg(1102002017)
				local var_79_11 = arg_76_1:FormatText(var_79_10.content)

				arg_76_1.text_.text = var_79_11

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 11 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 11)

				if (11 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 11)) > 0 and var_79_9 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_11
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002017", "story_v_side_new_1102002.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002017", "story_v_side_new_1102002.awb") / 1000

					if var_79_14 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_8
					end

					if var_79_10.prefab_name ~= "" and arg_76_1.actors_[var_79_10.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_10.prefab_name].transform, "story_v_side_new_1102002", "1102002017", "story_v_side_new_1102002.awb")

						arg_76_1:RecordAudio("1102002017", var_79_15)
						arg_76_1:RecordAudio("1102002017", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002017", "story_v_side_new_1102002.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002017", "story_v_side_new_1102002.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_16 and arg_76_1.time_ < var_79_8 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play1102002018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1102002018
		arg_80_1.duration_ = 6.23

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1102002019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_83_0 = 0
			local var_83_1 = 0.55

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_2 = arg_80_1:GetWordFromCfg(1102002018)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 22 <= 0 and var_83_1 or var_83_1 * (utf8.len(var_83_3) / 22)

				if (22 <= 0 and var_83_1 or var_83_1 * (utf8.len(var_83_3) / 22)) > 0 and var_83_1 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002018", "story_v_side_new_1102002.awb") ~= 0 then
					local var_83_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002018", "story_v_side_new_1102002.awb") / 1000

					if var_83_6 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_0
					end

					if var_83_2.prefab_name ~= "" and arg_80_1.actors_[var_83_2.prefab_name] ~= nil then
						local var_83_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_2.prefab_name].transform, "story_v_side_new_1102002", "1102002018", "story_v_side_new_1102002.awb")

						arg_80_1:RecordAudio("1102002018", var_83_7)
						arg_80_1:RecordAudio("1102002018", var_83_7)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002018", "story_v_side_new_1102002.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002018", "story_v_side_new_1102002.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_8 and arg_80_1.time_ < var_83_0 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1102002019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1102002019
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1102002020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1089ui_story"]) and arg_84_1.var_.characterEffect1089ui_story == nil then
				arg_84_1.var_.characterEffect1089ui_story = arg_84_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1089ui_story"]) then
				if arg_84_1.var_.characterEffect1089ui_story and not isNil(arg_84_1.actors_["1089ui_story"]) then
					arg_84_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1089ui_story"]) and arg_84_1.var_.characterEffect1089ui_story then
				arg_84_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.325

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(1102002019).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 13 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 13)

				if (13 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 13)) > 0 and var_87_2 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_6 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_6 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_6

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_6 and arg_84_1.time_ < var_87_1 + var_87_6 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1102002020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1102002020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1102002021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.05

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(1102002020).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 42 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 42)

				if (42 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 42)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play1102002021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1102002021
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1102002022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1089ui_story = arg_92_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1089ui_story"].transform.position).z)
				arg_92_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1089ui_story"].transform.localEulerAngles = arg_92_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1089ui_story"].transform.position).z)
				arg_92_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1089ui_story"].transform.localEulerAngles = arg_92_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_95_1 = 0
			local var_95_2 = 1.2

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(1102002021).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 48 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 48)

				if (48 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 48)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play1102002022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1102002022
		arg_96_1.duration_ = 4.4

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1102002023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1089ui_story = arg_96_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).z)
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles = arg_96_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_96_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1089ui_story"].transform.position).z)
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1089ui_story"].transform.localEulerAngles = arg_96_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["1089ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1089ui_story == nil then
				arg_96_1.var_.characterEffect1089ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1089ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1089ui_story then
				arg_96_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_99_4 = 0
			local var_99_5 = 0.425

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(1102002022)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 17 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 17)

				if (17 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 17)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002022", "story_v_side_new_1102002.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002022", "story_v_side_new_1102002.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_side_new_1102002", "1102002022", "story_v_side_new_1102002.awb")

						arg_96_1:RecordAudio("1102002022", var_99_11)
						arg_96_1:RecordAudio("1102002022", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002022", "story_v_side_new_1102002.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002022", "story_v_side_new_1102002.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play1102002023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1102002023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1102002024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1089ui_story"]) and arg_100_1.var_.characterEffect1089ui_story == nil then
				arg_100_1.var_.characterEffect1089ui_story = arg_100_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1089ui_story"]) then
				if arg_100_1.var_.characterEffect1089ui_story and not isNil(arg_100_1.actors_["1089ui_story"]) then
					arg_100_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1089ui_story"]) and arg_100_1.var_.characterEffect1089ui_story then
				arg_100_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.15

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(1102002023).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 6 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 6)

				if (6 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 6)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play1102002024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1102002024
		arg_104_1.duration_ = 3.53

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1102002025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1089ui_story"]) and arg_104_1.var_.characterEffect1089ui_story == nil then
				arg_104_1.var_.characterEffect1089ui_story = arg_104_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1089ui_story"]) then
				if arg_104_1.var_.characterEffect1089ui_story and not isNil(arg_104_1.actors_["1089ui_story"]) then
					arg_104_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1089ui_story"]) and arg_104_1.var_.characterEffect1089ui_story then
				arg_104_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_2 = 0
			local var_107_3 = 0.325

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(1102002024)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 13 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 13)

				if (13 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 13)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002024", "story_v_side_new_1102002.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002024", "story_v_side_new_1102002.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_side_new_1102002", "1102002024", "story_v_side_new_1102002.awb")

						arg_104_1:RecordAudio("1102002024", var_107_9)
						arg_104_1:RecordAudio("1102002024", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002024", "story_v_side_new_1102002.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002024", "story_v_side_new_1102002.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1102002025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1102002025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1102002026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1089ui_story"]) and arg_108_1.var_.characterEffect1089ui_story == nil then
				arg_108_1.var_.characterEffect1089ui_story = arg_108_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1089ui_story"]) then
				if arg_108_1.var_.characterEffect1089ui_story and not isNil(arg_108_1.actors_["1089ui_story"]) then
					arg_108_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1089ui_story"]) and arg_108_1.var_.characterEffect1089ui_story then
				arg_108_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.75

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(1102002025).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 30 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 30)

				if (30 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 30)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1102002026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1102002026
		arg_112_1.duration_ = 6.9

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1102002027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1089ui_story"]) and arg_112_1.var_.characterEffect1089ui_story == nil then
				arg_112_1.var_.characterEffect1089ui_story = arg_112_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1089ui_story"]) then
				if arg_112_1.var_.characterEffect1089ui_story and not isNil(arg_112_1.actors_["1089ui_story"]) then
					arg_112_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1089ui_story"]) and arg_112_1.var_.characterEffect1089ui_story then
				arg_112_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_115_2 = 0
			local var_115_3 = 0.725

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(1102002026)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 29 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 29)

				if (29 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 29)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002026", "story_v_side_new_1102002.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002026", "story_v_side_new_1102002.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_side_new_1102002", "1102002026", "story_v_side_new_1102002.awb")

						arg_112_1:RecordAudio("1102002026", var_115_9)
						arg_112_1:RecordAudio("1102002026", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002026", "story_v_side_new_1102002.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002026", "story_v_side_new_1102002.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1102002027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1102002027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1102002028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1089ui_story"]) and arg_116_1.var_.characterEffect1089ui_story == nil then
				arg_116_1.var_.characterEffect1089ui_story = arg_116_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1089ui_story"]) then
				if arg_116_1.var_.characterEffect1089ui_story and not isNil(arg_116_1.actors_["1089ui_story"]) then
					arg_116_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1089ui_story"]) and arg_116_1.var_.characterEffect1089ui_story then
				arg_116_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 0.175

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(1102002027).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 7 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 7)

				if (7 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 7)) > 0 and var_119_2 < var_119_5 then
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

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play1102002028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1102002028
		arg_120_1.duration_ = 1

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1102002029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1089ui_story"]) and arg_120_1.var_.characterEffect1089ui_story == nil then
				arg_120_1.var_.characterEffect1089ui_story = arg_120_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1089ui_story"]) then
				if arg_120_1.var_.characterEffect1089ui_story and not isNil(arg_120_1.actors_["1089ui_story"]) then
					arg_120_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1089ui_story"]) and arg_120_1.var_.characterEffect1089ui_story then
				arg_120_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_2 = 0
			local var_123_3 = 0.05

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_4 = arg_120_1:GetWordFromCfg(1102002028)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 2 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 2)

				if (2 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 2)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002028", "story_v_side_new_1102002.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002028", "story_v_side_new_1102002.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_side_new_1102002", "1102002028", "story_v_side_new_1102002.awb")

						arg_120_1:RecordAudio("1102002028", var_123_9)
						arg_120_1:RecordAudio("1102002028", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002028", "story_v_side_new_1102002.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002028", "story_v_side_new_1102002.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1102002029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1102002029
		arg_124_1.duration_ = 8.37

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1102002030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.975

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:GetWordFromCfg(1102002029)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 39 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 39)

				if (39 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 39)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002029", "story_v_side_new_1102002.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002029", "story_v_side_new_1102002.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_side_new_1102002", "1102002029", "story_v_side_new_1102002.awb")

						arg_124_1:RecordAudio("1102002029", var_127_6)
						arg_124_1:RecordAudio("1102002029", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002029", "story_v_side_new_1102002.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002029", "story_v_side_new_1102002.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play1102002030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1102002030
		arg_128_1.duration_ = 12.3

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1102002031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 1.225

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:GetWordFromCfg(1102002030)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 49 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 49)

				if (49 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 49)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002030", "story_v_side_new_1102002.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002030", "story_v_side_new_1102002.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_side_new_1102002", "1102002030", "story_v_side_new_1102002.awb")

						arg_128_1:RecordAudio("1102002030", var_131_6)
						arg_128_1:RecordAudio("1102002030", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002030", "story_v_side_new_1102002.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002030", "story_v_side_new_1102002.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play1102002031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1102002031
		arg_132_1.duration_ = 7.33

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1102002032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_135_0 = 0
			local var_135_1 = 0.875

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_2 = arg_132_1:GetWordFromCfg(1102002031)
				local var_135_3 = arg_132_1:FormatText(var_135_2.content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 35 <= 0 and var_135_1 or var_135_1 * (utf8.len(var_135_3) / 35)

				if (35 <= 0 and var_135_1 or var_135_1 * (utf8.len(var_135_3) / 35)) > 0 and var_135_1 < var_135_5 then
					arg_132_1.talkMaxDuration = var_135_5

					if var_135_5 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002031", "story_v_side_new_1102002.awb") ~= 0 then
					local var_135_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002031", "story_v_side_new_1102002.awb") / 1000

					if var_135_6 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_0
					end

					if var_135_2.prefab_name ~= "" and arg_132_1.actors_[var_135_2.prefab_name] ~= nil then
						local var_135_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_2.prefab_name].transform, "story_v_side_new_1102002", "1102002031", "story_v_side_new_1102002.awb")

						arg_132_1:RecordAudio("1102002031", var_135_7)
						arg_132_1:RecordAudio("1102002031", var_135_7)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002031", "story_v_side_new_1102002.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002031", "story_v_side_new_1102002.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_8 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_8 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_8

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_8 and arg_132_1.time_ < var_135_0 + var_135_8 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1102002032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1102002032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1102002033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1089ui_story"]) and arg_136_1.var_.characterEffect1089ui_story == nil then
				arg_136_1.var_.characterEffect1089ui_story = arg_136_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1089ui_story"]) then
				if arg_136_1.var_.characterEffect1089ui_story and not isNil(arg_136_1.actors_["1089ui_story"]) then
					arg_136_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1089ui_story"]) and arg_136_1.var_.characterEffect1089ui_story then
				arg_136_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_139_1 = 0
			local var_139_2 = 0.475

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(1102002032).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 19 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 19)

				if (19 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 19)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1102002033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1102002033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1102002034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 1.125

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(1102002033).content)

				arg_140_1.text_.text = var_143_1

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_3 = 45 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 45)

				if (45 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 45)) > 0 and var_143_0 < var_143_3 then
					arg_140_1.talkMaxDuration = var_143_3

					if var_143_3 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_3 + 0
					end
				end

				arg_140_1.text_.text = var_143_1
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_4 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_4

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1102002034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1102002034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1102002035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.65

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(1102002034).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 26 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 26)

				if (26 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 26)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1102002035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1102002035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1102002036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1089ui_story = arg_148_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).z)
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles = arg_148_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1089ui_story"].transform.position).z)
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1089ui_story"].transform.localEulerAngles = arg_148_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if 0.125 < arg_148_1.time_ and arg_148_1.time_ <= 0.125 + arg_151_0 then
				arg_148_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_door", "")
			end

			local var_151_2 = 0
			local var_151_3 = 0.4

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_4 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(1102002035).content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 16 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_4) / 16)

				if (16 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_4) / 16)) > 0 and var_151_3 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_2
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_3, arg_148_1.talkMaxDuration)

			if var_151_2 <= arg_148_1.time_ and arg_148_1.time_ < var_151_2 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_2) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_2 + var_151_7 and arg_148_1.time_ < var_151_2 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play1102002036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1102002036
		arg_152_1.duration_ = 4.2

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1102002037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1089ui_story = arg_152_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1089ui_story"].transform.position).z)
				arg_152_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1089ui_story"].transform.localEulerAngles = arg_152_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_152_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1089ui_story"].transform.position).z)
				arg_152_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1089ui_story"].transform.localEulerAngles = arg_152_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_155_1 = arg_152_1.actors_["1089ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1089ui_story == nil then
				arg_152_1.var_.characterEffect1089ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect1089ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1089ui_story then
				arg_152_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_155_4 = 0
			local var_155_5 = 0.35

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(1102002036)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 14 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 14)

				if (14 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 14)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002036", "story_v_side_new_1102002.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002036", "story_v_side_new_1102002.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_side_new_1102002", "1102002036", "story_v_side_new_1102002.awb")

						arg_152_1:RecordAudio("1102002036", var_155_11)
						arg_152_1:RecordAudio("1102002036", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002036", "story_v_side_new_1102002.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002036", "story_v_side_new_1102002.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play1102002037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1102002037
		arg_156_1.duration_ = 10.23

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1102002038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if arg_156_1.bgs_.ST0505 == nil then
				local var_159_0 = Object.Instantiate(arg_156_1.paintGo_)

				var_159_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0505")
				var_159_0.name = "ST0505"
				var_159_0.transform.parent = arg_156_1.stage_.transform
				var_159_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_.ST0505 = var_159_0
			end

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 then
				local var_159_1 = arg_156_1.bgs_.ST0505

				arg_156_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_2 = var_159_1:GetComponent("SpriteRenderer")

				if var_159_2 and var_159_2.sprite then
					local var_159_3 = 2 * (var_159_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_1.transform.localScale = Vector3.New(var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "ST0505" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_4 = 3.999999999999

			if 3.999999999999 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			if arg_156_1.time_ >= var_159_4 + 0.3 and arg_156_1.time_ < var_159_4 + 0.3 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_5 = 0

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_6 = 2

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 then
				local var_159_7 = Color.New(0, 0, 0)

				var_159_7.a = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_5) / var_159_6)
				arg_156_1.mask_.color = var_159_7
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 then
				local var_159_8 = Color.New(0, 0, 0)

				var_159_8.a = 1
				arg_156_1.mask_.color = var_159_8
			end

			local var_159_9 = 2

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_9 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_10 = 2

			if var_159_9 <= arg_156_1.time_ and arg_156_1.time_ < var_159_9 + var_159_10 then
				local var_159_11 = Color.New(0, 0, 0)

				var_159_11.a = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_9) / var_159_10)
				arg_156_1.mask_.color = var_159_11
			end

			if arg_156_1.time_ >= var_159_9 + var_159_10 and arg_156_1.time_ < var_159_9 + var_159_10 + arg_159_0 then
				local var_159_12 = Color.New(0, 0, 0)

				arg_156_1.mask_.enabled = false
				var_159_12.a = 0
				arg_156_1.mask_.color = var_159_12
			end

			local var_159_13 = arg_156_1.actors_["1089ui_story"].transform

			if 1.96599999815226 < arg_156_1.time_ and arg_156_1.time_ <= 1.96599999815226 + arg_159_0 then
				arg_156_1.var_.moveOldPos1089ui_story = var_159_13.localPosition
			end

			local var_159_14 = 0.001

			if 1.96599999815226 <= arg_156_1.time_ and arg_156_1.time_ < 1.96599999815226 + var_159_14 then
				var_159_13.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 1.96599999815226) / var_159_14)
				var_159_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_13.position).x, (manager.ui.mainCamera.transform.position - var_159_13.position).y, (manager.ui.mainCamera.transform.position - var_159_13.position).z)
				var_159_13.localEulerAngles.z = 0
				var_159_13.localEulerAngles.x = 0
				var_159_13.localEulerAngles = var_159_13.localEulerAngles
			end

			if arg_156_1.time_ >= 1.96599999815226 + var_159_14 and arg_156_1.time_ < 1.96599999815226 + var_159_14 + arg_159_0 then
				var_159_13.localPosition = Vector3.New(0, 100, 0)
				var_159_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_13.position).x, (manager.ui.mainCamera.transform.position - var_159_13.position).y, (manager.ui.mainCamera.transform.position - var_159_13.position).z)
				var_159_13.localEulerAngles.z = 0
				var_159_13.localEulerAngles.x = 0
				var_159_13.localEulerAngles = var_159_13.localEulerAngles
			end

			local var_159_15 = 2

			arg_156_1.isInRecall_ = false

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1.screenFilterGo_:SetActive(true)

				arg_156_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_159_2, iter_159_3 in pairs(arg_156_1.actors_) do
					for iter_159_4, iter_159_5 in ipairs((iter_159_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_159_5.color = iter_159_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_159_16 = 0.2

			if var_159_15 <= arg_156_1.time_ and arg_156_1.time_ < var_159_15 + var_159_16 then
				arg_156_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_15) / var_159_16)
			end

			if arg_156_1.time_ >= var_159_15 + var_159_16 and arg_156_1.time_ < var_159_15 + var_159_16 + arg_159_0 then
				arg_156_1.screenFilterEffect_.weight = 1
			end

			if 0.366666666666667 < arg_156_1.time_ and arg_156_1.time_ <= 0.366666666666667 + arg_159_0 then
				arg_156_1:AudioAction("stop", "effect", "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			if 1.63333333333333 < arg_156_1.time_ and arg_156_1.time_ <= 1.63333333333333 + arg_159_0 then
				arg_156_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room02", "")
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_19 = 3.999999999999
			local var_159_20 = 0.775

			if 3.999999999999 < arg_156_1.time_ and arg_156_1.time_ <= var_159_19 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_21 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_21:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_156_1.dialogCg_.alpha = arg_160_0
				end))
				var_159_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_156_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_159_22 = arg_156_1:GetWordFromCfg(1102002037)
				local var_159_23 = arg_156_1:FormatText(var_159_22.content)

				arg_156_1.text_.text = var_159_23

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_25 = 31 <= 0 and var_159_20 or var_159_20 * (utf8.len(var_159_23) / 31)

				if (31 <= 0 and var_159_20 or var_159_20 * (utf8.len(var_159_23) / 31)) > 0 and var_159_20 < var_159_25 then
					arg_156_1.talkMaxDuration = var_159_25
					var_159_19 = var_159_19 + 0.3

					if var_159_25 + var_159_19 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_25 + var_159_19
					end
				end

				arg_156_1.text_.text = var_159_23
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002037", "story_v_side_new_1102002.awb") ~= 0 then
					local var_159_26 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002037", "story_v_side_new_1102002.awb") / 1000

					if var_159_26 + var_159_19 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_26 + var_159_19
					end

					if var_159_22.prefab_name ~= "" and arg_156_1.actors_[var_159_22.prefab_name] ~= nil then
						local var_159_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_22.prefab_name].transform, "story_v_side_new_1102002", "1102002037", "story_v_side_new_1102002.awb")

						arg_156_1:RecordAudio("1102002037", var_159_27)
						arg_156_1:RecordAudio("1102002037", var_159_27)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002037", "story_v_side_new_1102002.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002037", "story_v_side_new_1102002.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_28 = var_159_19 + 0.3
			local var_159_29 = math.max(var_159_20, arg_156_1.talkMaxDuration)

			if var_159_19 + 0.3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_28 + var_159_29 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_28) / var_159_29

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_28 + var_159_29 and arg_156_1.time_ < var_159_28 + var_159_29 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play1102002038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1102002038
		arg_162_1.duration_ = 8.8

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1102002039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			arg_162_1.isInRecall_ = false

			if 2 < arg_162_1.time_ and arg_162_1.time_ <= 2 + arg_165_0 then
				arg_162_1.screenFilterGo_:SetActive(false)

				for iter_165_0, iter_165_1 in pairs(arg_162_1.actors_) do
					for iter_165_2, iter_165_3 in ipairs((iter_165_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_165_3.color = iter_165_3.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_165_0 = 0.1833333

			if 2 <= arg_162_1.time_ and arg_162_1.time_ < 2 + var_165_0 then
				arg_162_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_162_1.time_ - 2) / var_165_0)
			end

			if arg_162_1.time_ >= 2 + var_165_0 and arg_162_1.time_ < 2 + var_165_0 + arg_165_0 then
				arg_162_1.screenFilterEffect_.weight = 0
			end

			local var_165_1 = 0

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_2 = 2

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 then
				local var_165_3 = Color.New(0, 0, 0)

				var_165_3.a = Mathf.Lerp(0, 1, (arg_162_1.time_ - var_165_1) / var_165_2)
				arg_162_1.mask_.color = var_165_3
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 then
				local var_165_4 = Color.New(0, 0, 0)

				var_165_4.a = 1
				arg_162_1.mask_.color = var_165_4
			end

			local var_165_5 = 2

			if 2 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_6 = 2

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_6 then
				local var_165_7 = Color.New(0, 0, 0)

				var_165_7.a = Mathf.Lerp(1, 0, (arg_162_1.time_ - var_165_5) / var_165_6)
				arg_162_1.mask_.color = var_165_7
			end

			if arg_162_1.time_ >= var_165_5 + var_165_6 and arg_162_1.time_ < var_165_5 + var_165_6 + arg_165_0 then
				local var_165_8 = Color.New(0, 0, 0)

				arg_162_1.mask_.enabled = false
				var_165_8.a = 0
				arg_162_1.mask_.color = var_165_8
			end

			if arg_162_1.frameCnt_ <= 1 then
				arg_162_1.dialog_:SetActive(false)
			end

			local var_165_9 = 3.8
			local var_165_10 = 1.725

			if 3.8 < arg_162_1.time_ and arg_162_1.time_ <= var_165_9 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0

				arg_162_1.dialog_:SetActive(true)

				arg_162_1.dialogCg_.alpha = 0

				local var_165_11 = LeanTween.value(arg_162_1.dialog_, 0, 1, 0.3)

				var_165_11:setOnUpdate(LuaHelper.FloatAction(function(arg_166_0)
					arg_162_1.dialogCg_.alpha = arg_166_0
				end))
				var_165_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_162_1.dialog_)
					var_165_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_162_1.duration_ = arg_162_1.duration_ + 0.3

				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_12 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(1102002038).content)

				arg_162_1.text_.text = var_165_12

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_14 = 69 <= 0 and var_165_10 or var_165_10 * (utf8.len(var_165_12) / 69)

				if (69 <= 0 and var_165_10 or var_165_10 * (utf8.len(var_165_12) / 69)) > 0 and var_165_10 < var_165_14 then
					arg_162_1.talkMaxDuration = var_165_14
					var_165_9 = var_165_9 + 0.3

					if var_165_14 + var_165_9 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_9
					end
				end

				arg_162_1.text_.text = var_165_12
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_15 = var_165_9 + 0.3
			local var_165_16 = math.max(var_165_10, arg_162_1.talkMaxDuration)

			if var_165_9 + 0.3 <= arg_162_1.time_ and arg_162_1.time_ < var_165_15 + var_165_16 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_15) / var_165_16

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_15 + var_165_16 and arg_162_1.time_ < var_165_15 + var_165_16 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1102002039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1102002039
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1102002040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0.836552398744971 < arg_168_1.time_ and arg_168_1.time_ <= 0.836552398744971 + arg_171_0 then
				arg_168_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_button", "")
			end

			local var_171_1 = 0
			local var_171_2 = 1.15

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_3 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(1102002039).content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 46 <= 0 and var_171_2 or var_171_2 * (utf8.len(var_171_3) / 46)

				if (46 <= 0 and var_171_2 or var_171_2 * (utf8.len(var_171_3) / 46)) > 0 and var_171_2 < var_171_5 then
					arg_168_1.talkMaxDuration = var_171_5

					if var_171_5 + var_171_1 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + var_171_1
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_6 = math.max(var_171_2, arg_168_1.talkMaxDuration)

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_6 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_1) / var_171_6

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_1 + var_171_6 and arg_168_1.time_ < var_171_1 + var_171_6 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1102002040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1102002040
		arg_172_1.duration_ = 9

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1102002041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 2 < arg_172_1.time_ and arg_172_1.time_ <= 2 + arg_175_0 then
				local var_175_0 = arg_172_1.bgs_.STblack

				arg_172_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_175_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_175_1 = var_175_0:GetComponent("SpriteRenderer")

				if var_175_1 and var_175_1.sprite then
					local var_175_2 = 2 * (var_175_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_175_0.transform.localScale = Vector3.New(var_175_2 / var_175_1.sprite.bounds.size.y < var_175_2 * manager.ui.mainCameraCom_.aspect / var_175_1.sprite.bounds.size.x and var_175_2 * manager.ui.mainCameraCom_.aspect / var_175_1.sprite.bounds.size.x or var_175_2 / var_175_1.sprite.bounds.size.y, var_175_2 / var_175_1.sprite.bounds.size.y < var_175_2 * manager.ui.mainCameraCom_.aspect / var_175_1.sprite.bounds.size.x and var_175_2 * manager.ui.mainCameraCom_.aspect / var_175_1.sprite.bounds.size.x or var_175_2 / var_175_1.sprite.bounds.size.y, 0)
				end

				for iter_175_0, iter_175_1 in pairs(arg_172_1.bgs_) do
					if iter_175_0 ~= "STblack" then
						iter_175_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_175_3 = 4

			if 4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_3 + arg_175_0 then
				arg_172_1.allBtn_.enabled = false
			end

			if arg_172_1.time_ >= var_175_3 + 0.3 and arg_172_1.time_ < var_175_3 + 0.3 + arg_175_0 then
				arg_172_1.allBtn_.enabled = true
			end

			local var_175_4 = 0

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_5 = 2

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_5 then
				local var_175_6 = Color.New(0, 0, 0)

				var_175_6.a = Mathf.Lerp(0, 1, (arg_172_1.time_ - var_175_4) / var_175_5)
				arg_172_1.mask_.color = var_175_6
			end

			if arg_172_1.time_ >= var_175_4 + var_175_5 and arg_172_1.time_ < var_175_4 + var_175_5 + arg_175_0 then
				local var_175_7 = Color.New(0, 0, 0)

				var_175_7.a = 1
				arg_172_1.mask_.color = var_175_7
			end

			local var_175_8 = 2

			if 2 < arg_172_1.time_ and arg_172_1.time_ <= var_175_8 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_9 = 2

			if var_175_8 <= arg_172_1.time_ and arg_172_1.time_ < var_175_8 + var_175_9 then
				local var_175_10 = Color.New(0, 0, 0)

				var_175_10.a = Mathf.Lerp(1, 0, (arg_172_1.time_ - var_175_8) / var_175_9)
				arg_172_1.mask_.color = var_175_10
			end

			if arg_172_1.time_ >= var_175_8 + var_175_9 and arg_172_1.time_ < var_175_8 + var_175_9 + arg_175_0 then
				local var_175_11 = Color.New(0, 0, 0)

				arg_172_1.mask_.enabled = false
				var_175_11.a = 0
				arg_172_1.mask_.color = var_175_11
			end

			local var_175_12 = arg_172_1.actors_["1089ui_story"].transform

			if 1.966 < arg_172_1.time_ and arg_172_1.time_ <= 1.966 + arg_175_0 then
				arg_172_1.var_.moveOldPos1089ui_story = var_175_12.localPosition
			end

			local var_175_13 = 0.001

			if 1.966 <= arg_172_1.time_ and arg_172_1.time_ < 1.966 + var_175_13 then
				var_175_12.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 1.966) / var_175_13)
				var_175_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_12.position).x, (manager.ui.mainCamera.transform.position - var_175_12.position).y, (manager.ui.mainCamera.transform.position - var_175_12.position).z)
				var_175_12.localEulerAngles.z = 0
				var_175_12.localEulerAngles.x = 0
				var_175_12.localEulerAngles = var_175_12.localEulerAngles
			end

			if arg_172_1.time_ >= 1.966 + var_175_13 and arg_172_1.time_ < 1.966 + var_175_13 + arg_175_0 then
				var_175_12.localPosition = Vector3.New(0, 100, 0)
				var_175_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_12.position).x, (manager.ui.mainCamera.transform.position - var_175_12.position).y, (manager.ui.mainCamera.transform.position - var_175_12.position).z)
				var_175_12.localEulerAngles.z = 0
				var_175_12.localEulerAngles.x = 0
				var_175_12.localEulerAngles = var_175_12.localEulerAngles
			end

			if 0.5 < arg_172_1.time_ and arg_172_1.time_ <= 0.5 + arg_175_0 then
				arg_172_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room02", "")
			end

			if 1.5 < arg_172_1.time_ and arg_172_1.time_ <= 1.5 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_175_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_18 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_18

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_18
						arg_172_1.bgmTxt2_.text = var_175_18
					end

					if arg_172_1.bgmTimer then
						arg_172_1.bgmTimer:Stop()

						arg_172_1.bgmTimer = nil
					end

					if arg_172_1.settingData.show_music_name == 1 then
						arg_172_1.musicController:SetSelectedState("show")
						arg_172_1.musicAnimator_:Play("open", 0, 0)

						if arg_172_1.settingData.music_time ~= 0 then
							arg_172_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_172_1.settingData.music_time), function()
								if arg_172_1 == nil or isNil(arg_172_1.bgmTxt_) then
									return
								end

								arg_172_1.musicController:SetSelectedState("hide")
								arg_172_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_19 = 4
			local var_175_20 = 0.25

			if 4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_19 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_21 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_21:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_172_1.dialogCg_.alpha = arg_177_0
				end))
				var_175_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_22 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(1102002040).content)

				arg_172_1.text_.text = var_175_22

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_24 = 10 <= 0 and var_175_20 or var_175_20 * (utf8.len(var_175_22) / 10)

				if (10 <= 0 and var_175_20 or var_175_20 * (utf8.len(var_175_22) / 10)) > 0 and var_175_20 < var_175_24 then
					arg_172_1.talkMaxDuration = var_175_24
					var_175_19 = var_175_19 + 0.3

					if var_175_24 + var_175_19 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_24 + var_175_19
					end
				end

				arg_172_1.text_.text = var_175_22
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_25 = var_175_19 + 0.3
			local var_175_26 = math.max(var_175_20, arg_172_1.talkMaxDuration)

			if var_175_19 + 0.3 <= arg_172_1.time_ and arg_172_1.time_ < var_175_25 + var_175_26 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_25) / var_175_26

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_25 + var_175_26 and arg_172_1.time_ < var_175_25 + var_175_26 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play1102002041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1102002041
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1102002042(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1.25

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1102002041).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 50 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 50)

				if (50 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 50)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1102002042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1102002042
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1102002043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.275

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1102002042).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 11 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 11)

				if (11 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 11)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1102002043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1102002043
		arg_187_1.duration_ = 2.57

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1102002044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.275

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(1102002043)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 11 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 11)

				if (11 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 11)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002043", "story_v_side_new_1102002.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002043", "story_v_side_new_1102002.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_side_new_1102002", "1102002043", "story_v_side_new_1102002.awb")

						arg_187_1:RecordAudio("1102002043", var_190_6)
						arg_187_1:RecordAudio("1102002043", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002043", "story_v_side_new_1102002.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002043", "story_v_side_new_1102002.awb")
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
	Play1102002044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1102002044
		arg_191_1.duration_ = 5.73

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1102002045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if arg_191_1.bgs_.L02h == nil then
				local var_194_0 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02h")
				var_194_0.name = "L02h"
				var_194_0.transform.parent = arg_191_1.stage_.transform
				var_194_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_.L02h = var_194_0
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				local var_194_1 = arg_191_1.bgs_.L02h

				arg_191_1.bgs_.L02h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_194_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_2 = var_194_1:GetComponent("SpriteRenderer")

				if var_194_2 and var_194_2.sprite then
					local var_194_3 = 2 * (var_194_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_194_1.transform.localScale = Vector3.New(var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "L02h" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_4 = 2.00000000298023

			if 2.00000000298023 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			if arg_191_1.time_ >= var_194_4 + 0.3 and arg_191_1.time_ < var_194_4 + 0.3 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end

			local var_194_5 = 0

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_6 = 2

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_6 then
				local var_194_7 = Color.New(0, 0, 0)

				var_194_7.a = Mathf.Lerp(1, 0, (arg_191_1.time_ - var_194_5) / var_194_6)
				arg_191_1.mask_.color = var_194_7
			end

			if arg_191_1.time_ >= var_194_5 + var_194_6 and arg_191_1.time_ < var_194_5 + var_194_6 + arg_194_0 then
				local var_194_8 = Color.New(0, 0, 0)

				arg_191_1.mask_.enabled = false
				var_194_8.a = 0
				arg_191_1.mask_.color = var_194_8
			end

			local var_194_9 = "1020ui_story"

			if arg_191_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_194_10 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_191_1.stage_.transform)

				var_194_10.name = var_194_9
				var_194_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.actors_[var_194_9] = var_194_10

				local var_194_11 = var_194_10:GetComponentInChildren(typeof(CharacterEffect))

				var_194_11.enabled = true

				local var_194_12 = GameObjectTools.GetOrAddComponent(var_194_10, typeof(DynamicBoneHelper))

				if var_194_12 then
					var_194_12:EnableDynamicBone(false)
				end

				arg_191_1:ShowWeapon(var_194_11.transform, false)

				arg_191_1.var_[var_194_9 .. "Animator"] = var_194_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_191_1.var_[var_194_9 .. "Animator"].applyRootMotion = true
				arg_191_1.var_[var_194_9 .. "LipSync"] = var_194_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_194_13 = arg_191_1.actors_["1020ui_story"].transform

			if 1.8 < arg_191_1.time_ and arg_191_1.time_ <= 1.8 + arg_194_0 then
				arg_191_1.var_.moveOldPos1020ui_story = var_194_13.localPosition
			end

			local var_194_14 = 0.001

			if 1.8 <= arg_191_1.time_ and arg_191_1.time_ < 1.8 + var_194_14 then
				var_194_13.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_191_1.time_ - 1.8) / var_194_14)
				var_194_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_13.position).x, (manager.ui.mainCamera.transform.position - var_194_13.position).y, (manager.ui.mainCamera.transform.position - var_194_13.position).z)
				var_194_13.localEulerAngles.z = 0
				var_194_13.localEulerAngles.x = 0
				var_194_13.localEulerAngles = var_194_13.localEulerAngles
			end

			if arg_191_1.time_ >= 1.8 + var_194_14 and arg_191_1.time_ < 1.8 + var_194_14 + arg_194_0 then
				var_194_13.localPosition = Vector3.New(0, -0.85, -6.25)
				var_194_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_13.position).x, (manager.ui.mainCamera.transform.position - var_194_13.position).y, (manager.ui.mainCamera.transform.position - var_194_13.position).z)
				var_194_13.localEulerAngles.z = 0
				var_194_13.localEulerAngles.x = 0
				var_194_13.localEulerAngles = var_194_13.localEulerAngles
			end

			local var_194_15 = arg_191_1.actors_["1020ui_story"]

			if 1.8 < arg_191_1.time_ and arg_191_1.time_ <= 1.8 + arg_194_0 and not isNil(var_194_15) and arg_191_1.var_.characterEffect1020ui_story == nil then
				arg_191_1.var_.characterEffect1020ui_story = var_194_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_16 = 0.200000002980232

			if 1.8 <= arg_191_1.time_ and arg_191_1.time_ < 1.8 + var_194_16 and not isNil(var_194_15) then
				if arg_191_1.var_.characterEffect1020ui_story and not isNil(var_194_15) then
					arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 1.8 + var_194_16 and arg_191_1.time_ < 1.8 + var_194_16 + arg_194_0 and not isNil(var_194_15) and arg_191_1.var_.characterEffect1020ui_story then
				arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 1.8 < arg_191_1.time_ and arg_191_1.time_ <= 1.8 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 1.8 < arg_191_1.time_ and arg_191_1.time_ <= 1.8 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.125 < arg_191_1.time_ and arg_191_1.time_ <= 0.125 + arg_194_0 then
				arg_191_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_194_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_191_1.bgmTxt_.text ~= var_194_22 and arg_191_1.bgmTxt_.text ~= "" then
						if arg_191_1.bgmTxt2_.text ~= "" then
							arg_191_1.bgmTxt_.text = arg_191_1.bgmTxt2_.text
						end

						arg_191_1.bgmTxt2_.text = var_194_22

						arg_191_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_191_1.bgmTxt_.text = var_194_22
						arg_191_1.bgmTxt2_.text = var_194_22
					end

					if arg_191_1.bgmTimer then
						arg_191_1.bgmTimer:Stop()

						arg_191_1.bgmTimer = nil
					end

					if arg_191_1.settingData.show_music_name == 1 then
						arg_191_1.musicController:SetSelectedState("show")
						arg_191_1.musicAnimator_:Play("open", 0, 0)

						if arg_191_1.settingData.music_time ~= 0 then
							arg_191_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_191_1.settingData.music_time), function()
								if arg_191_1 == nil or isNil(arg_191_1.bgmTxt_) then
									return
								end

								arg_191_1.musicController:SetSelectedState("hide")
								arg_191_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_191_1.time_ and arg_191_1.time_ <= 0.4 + arg_194_0 then
				arg_191_1:AudioAction("play", "music", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic.awb")

				local var_194_25 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic")

				if "" ~= "" then
					if arg_191_1.bgmTxt_.text ~= var_194_25 and arg_191_1.bgmTxt_.text ~= "" then
						if arg_191_1.bgmTxt2_.text ~= "" then
							arg_191_1.bgmTxt_.text = arg_191_1.bgmTxt2_.text
						end

						arg_191_1.bgmTxt2_.text = var_194_25

						arg_191_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_191_1.bgmTxt_.text = var_194_25
						arg_191_1.bgmTxt2_.text = var_194_25
					end

					if arg_191_1.bgmTimer then
						arg_191_1.bgmTimer:Stop()

						arg_191_1.bgmTimer = nil
					end

					if arg_191_1.settingData.show_music_name == 1 then
						arg_191_1.musicController:SetSelectedState("show")
						arg_191_1.musicAnimator_:Play("open", 0, 0)

						if arg_191_1.settingData.music_time ~= 0 then
							arg_191_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_191_1.settingData.music_time), function()
								if arg_191_1 == nil or isNil(arg_191_1.bgmTxt_) then
									return
								end

								arg_191_1.musicController:SetSelectedState("hide")
								arg_191_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_26 = 2
			local var_194_27 = 0.5

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_26 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_28 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_28:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_191_1.dialogCg_.alpha = arg_197_0
				end))
				var_194_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_29 = arg_191_1:GetWordFromCfg(1102002044)
				local var_194_30 = arg_191_1:FormatText(var_194_29.content)

				arg_191_1.text_.text = var_194_30

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_32 = 20 <= 0 and var_194_27 or var_194_27 * (utf8.len(var_194_30) / 20)

				if (20 <= 0 and var_194_27 or var_194_27 * (utf8.len(var_194_30) / 20)) > 0 and var_194_27 < var_194_32 then
					arg_191_1.talkMaxDuration = var_194_32
					var_194_26 = var_194_26 + 0.3

					if var_194_32 + var_194_26 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_32 + var_194_26
					end
				end

				arg_191_1.text_.text = var_194_30
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002044", "story_v_side_new_1102002.awb") ~= 0 then
					local var_194_33 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002044", "story_v_side_new_1102002.awb") / 1000

					if var_194_33 + var_194_26 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_33 + var_194_26
					end

					if var_194_29.prefab_name ~= "" and arg_191_1.actors_[var_194_29.prefab_name] ~= nil then
						local var_194_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_29.prefab_name].transform, "story_v_side_new_1102002", "1102002044", "story_v_side_new_1102002.awb")

						arg_191_1:RecordAudio("1102002044", var_194_34)
						arg_191_1:RecordAudio("1102002044", var_194_34)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002044", "story_v_side_new_1102002.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002044", "story_v_side_new_1102002.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_35 = var_194_26 + 0.3
			local var_194_36 = math.max(var_194_27, arg_191_1.talkMaxDuration)

			if var_194_26 + 0.3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_35 + var_194_36 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_35) / var_194_36

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_35 + var_194_36 and arg_191_1.time_ < var_194_35 + var_194_36 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play1102002045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1102002045
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1102002046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1020ui_story"]) and arg_199_1.var_.characterEffect1020ui_story == nil then
				arg_199_1.var_.characterEffect1020ui_story = arg_199_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1020ui_story"]) then
				if arg_199_1.var_.characterEffect1020ui_story and not isNil(arg_199_1.actors_["1020ui_story"]) then
					arg_199_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1020ui_story"]) and arg_199_1.var_.characterEffect1020ui_story then
				arg_199_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.2

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
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

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(1102002045).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 8 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 8)

				if (8 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 8)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1102002046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1102002046
		arg_203_1.duration_ = 5.03

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1102002047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1020ui_story"]) and arg_203_1.var_.characterEffect1020ui_story == nil then
				arg_203_1.var_.characterEffect1020ui_story = arg_203_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1020ui_story"]) then
				if arg_203_1.var_.characterEffect1020ui_story and not isNil(arg_203_1.actors_["1020ui_story"]) then
					arg_203_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1020ui_story"]) and arg_203_1.var_.characterEffect1020ui_story then
				arg_203_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action464")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_206_2 = 0
			local var_206_3 = 0.625

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(1102002046)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 25 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 25)

				if (25 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 25)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002046", "story_v_side_new_1102002.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002046", "story_v_side_new_1102002.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_side_new_1102002", "1102002046", "story_v_side_new_1102002.awb")

						arg_203_1:RecordAudio("1102002046", var_206_9)
						arg_203_1:RecordAudio("1102002046", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002046", "story_v_side_new_1102002.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002046", "story_v_side_new_1102002.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1102002047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1102002047
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1102002048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1020ui_story = arg_207_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1020ui_story"].transform.position).z)
				arg_207_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1020ui_story"].transform.localEulerAngles = arg_207_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1020ui_story"].transform.position).z)
				arg_207_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1020ui_story"].transform.localEulerAngles = arg_207_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1020ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1020ui_story == nil then
				arg_207_1.var_.characterEffect1020ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1020ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_2)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1020ui_story then
				arg_207_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_210_3 = 0
			local var_210_4 = 1

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_3 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_5 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1102002047).content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 40 <= 0 and var_210_4 or var_210_4 * (utf8.len(var_210_5) / 40)

				if (40 <= 0 and var_210_4 or var_210_4 * (utf8.len(var_210_5) / 40)) > 0 and var_210_4 < var_210_7 then
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
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play1102002048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1102002048
		arg_211_1.duration_ = 4.2

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1102002049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1020ui_story = arg_211_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1020ui_story"].transform.position).z)
				arg_211_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1020ui_story"].transform.localEulerAngles = arg_211_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_211_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1020ui_story"].transform.position).z)
				arg_211_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1020ui_story"].transform.localEulerAngles = arg_211_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1020ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1020ui_story == nil then
				arg_211_1.var_.characterEffect1020ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1020ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1020ui_story then
				arg_211_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_214_4 = 0
			local var_214_5 = 0.45

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(1102002048)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 18 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 18)

				if (18 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 18)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002048", "story_v_side_new_1102002.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002048", "story_v_side_new_1102002.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_side_new_1102002", "1102002048", "story_v_side_new_1102002.awb")

						arg_211_1:RecordAudio("1102002048", var_214_11)
						arg_211_1:RecordAudio("1102002048", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002048", "story_v_side_new_1102002.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002048", "story_v_side_new_1102002.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102002049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1102002049
		arg_215_1.duration_ = 5.73

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1102002050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_9001
			local var_218_9000

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				local var_218_0 = arg_215_1.bgs_.L02h

				arg_215_1.bgs_.L02h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_218_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_1 = var_218_0:GetComponent("SpriteRenderer")

				if var_218_1 and var_218_1.sprite then
					local var_218_2 = 2 * (var_218_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_218_0.transform.localScale = Vector3.New(var_218_2 / var_218_1.sprite.bounds.size.y < var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x and var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x or var_218_2 / var_218_1.sprite.bounds.size.y, var_218_2 / var_218_1.sprite.bounds.size.y < var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x and var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x or var_218_2 / var_218_1.sprite.bounds.size.y, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "L02h" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_3 = "H03b"

			if arg_215_1.bgs_.H03b == nil then
				local var_218_4 = Object.Instantiate(arg_215_1.paintGo_)

				var_218_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_218_3)
				var_218_4.name = var_218_3
				var_218_4.transform.parent = arg_215_1.stage_.transform
				var_218_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.bgs_[var_218_3] = var_218_4
			end

			if 1.50066666851441 < arg_215_1.time_ and arg_215_1.time_ <= 1.50066666851441 + arg_218_0 then
				local var_218_5 = arg_215_1.bgs_.H03b

				arg_215_1.bgs_.H03b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_218_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_6 = var_218_5:GetComponent("SpriteRenderer")

				if var_218_6 and var_218_6.sprite then
					local var_218_7 = 2 * (var_218_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_218_5.transform.localScale = Vector3.New(var_218_7 / var_218_6.sprite.bounds.size.y < var_218_7 * manager.ui.mainCameraCom_.aspect / var_218_6.sprite.bounds.size.x and var_218_7 * manager.ui.mainCameraCom_.aspect / var_218_6.sprite.bounds.size.x or var_218_7 / var_218_6.sprite.bounds.size.y, var_218_7 / var_218_6.sprite.bounds.size.y < var_218_7 * manager.ui.mainCameraCom_.aspect / var_218_6.sprite.bounds.size.x and var_218_7 * manager.ui.mainCameraCom_.aspect / var_218_6.sprite.bounds.size.x or var_218_7 / var_218_6.sprite.bounds.size.y, 0)
				end

				for iter_218_2, iter_218_3 in pairs(arg_215_1.bgs_) do
					if iter_218_2 ~= "H03b" then
						iter_218_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_8 = 3.00066666851441

			if 3.00066666851441 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			if arg_215_1.time_ >= var_218_8 + 0.3 and arg_215_1.time_ < var_218_8 + 0.3 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			if 3.00066666851441 < arg_215_1.time_ and arg_215_1.time_ <= 3.00066666851441 + arg_218_0 then
				arg_215_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 3.00066666851441 < arg_215_1.time_ and arg_215_1.time_ <= 3.00066666851441 + arg_218_0 then
				arg_215_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_218_9 = arg_215_1.actors_["1020ui_story"].transform

			if 1.18333333333333 < arg_215_1.time_ and arg_215_1.time_ <= 1.18333333333333 + arg_218_0 then
				arg_215_1.var_.moveOldPos1020ui_story = var_218_9.localPosition
			end

			local var_218_10 = 0.001

			if 1.18333333333333 <= arg_215_1.time_ and arg_215_1.time_ < 1.18333333333333 + var_218_10 then
				var_218_9.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 1.18333333333333) / var_218_10)
				var_218_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_9.position).x, (manager.ui.mainCamera.transform.position - var_218_9.position).y, (manager.ui.mainCamera.transform.position - var_218_9.position).z)
				var_218_9.localEulerAngles.z = 0
				var_218_9.localEulerAngles.x = 0
				var_218_9.localEulerAngles = var_218_9.localEulerAngles
			end

			if arg_215_1.time_ >= 1.18333333333333 + var_218_10 and arg_215_1.time_ < 1.18333333333333 + var_218_10 + arg_218_0 then
				var_218_9.localPosition = Vector3.New(0, 100, 0)
				var_218_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_9.position).x, (manager.ui.mainCamera.transform.position - var_218_9.position).y, (manager.ui.mainCamera.transform.position - var_218_9.position).z)
				var_218_9.localEulerAngles.z = 0
				var_218_9.localEulerAngles.x = 0
				var_218_9.localEulerAngles = var_218_9.localEulerAngles
			end

			local var_218_11 = arg_215_1.actors_["1020ui_story"].transform

			if 3.06733333518108 < arg_215_1.time_ and arg_215_1.time_ <= 3.06733333518108 + arg_218_0 then
				arg_215_1.var_.moveOldPos1020ui_story = var_218_11.localPosition
			end

			local var_218_12 = 0.001

			if 3.06733333518108 <= arg_215_1.time_ and arg_215_1.time_ < 3.06733333518108 + var_218_12 then
				var_218_11.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_215_1.time_ - 3.06733333518108) / var_218_12)
				var_218_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_11.position).x, (manager.ui.mainCamera.transform.position - var_218_11.position).y, (manager.ui.mainCamera.transform.position - var_218_11.position).z)
				var_218_11.localEulerAngles.z = 0
				var_218_11.localEulerAngles.x = 0
				var_218_11.localEulerAngles = var_218_11.localEulerAngles
			end

			if arg_215_1.time_ >= 3.06733333518108 + var_218_12 and arg_215_1.time_ < 3.06733333518108 + var_218_12 + arg_218_0 then
				var_218_11.localPosition = Vector3.New(0, -0.85, -6.25)
				var_218_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_11.position).x, (manager.ui.mainCamera.transform.position - var_218_11.position).y, (manager.ui.mainCamera.transform.position - var_218_11.position).z)
				var_218_11.localEulerAngles.z = 0
				var_218_11.localEulerAngles.x = 0
				var_218_11.localEulerAngles = var_218_11.localEulerAngles
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				local var_218_13 = arg_215_1.var_.effect213213231213213

				if not arg_215_1.var_.effect213213231213213 then
					var_218_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_218_13.name = "213213231213213"
					arg_215_1.var_.effect213213231213213 = var_218_13
				else
					var_218_13.transform:SetParent(var_218_9001)
				end

				var_218_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_218_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_218_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_218_4, iter_218_5 in ipairs((var_218_13.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_218_5.transform.localScale = Vector3.New(iter_218_5.transform.localScale.x / var_218_15 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_218_5.transform.localScale.y / var_218_15, iter_218_5.transform.localScale.z)
				end
			end

			if 1.50066666851441 < arg_215_1.time_ and arg_215_1.time_ <= 1.50066666851441 + arg_218_0 then
				if arg_215_1.var_.effect213213231213213 then
					Object.Destroy(arg_215_1.var_.effect213213231213213)

					arg_215_1.var_.effect213213231213213 = nil
				end
			end

			if 1.50066666851441 < arg_215_1.time_ and arg_215_1.time_ <= 1.50066666851441 + arg_218_0 then
				local var_218_18 = arg_215_1.var_.effect213222222123213

				if not arg_215_1.var_.effect213222222123213 then
					var_218_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_218_18.name = "213222222123213"
					arg_215_1.var_.effect213222222123213 = var_218_18
				else
					var_218_18.transform:SetParent(var_218_9000)
				end

				var_218_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_218_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_218_20 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_218_6, iter_218_7 in ipairs((var_218_18.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_218_7.transform.localScale = Vector3.New(iter_218_7.transform.localScale.x / var_218_20 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_218_7.transform.localScale.y / var_218_20, iter_218_7.transform.localScale.z)
				end
			end

			if 0.183333333333333 < arg_215_1.time_ and arg_215_1.time_ <= 0.183333333333333 + arg_218_0 then
				arg_215_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 1.50066666851441 < arg_215_1.time_ and arg_215_1.time_ <= 1.50066666851441 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_river", "")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_whoosh", "")
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_25 = 3.00066666851441
			local var_218_26 = 0.125

			if 3.00066666851441 < arg_215_1.time_ and arg_215_1.time_ <= var_218_25 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_27 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_27:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_28 = arg_215_1:GetWordFromCfg(1102002049)
				local var_218_29 = arg_215_1:FormatText(var_218_28.content)

				arg_215_1.text_.text = var_218_29

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_31 = 5 <= 0 and var_218_26 or var_218_26 * (utf8.len(var_218_29) / 5)

				if (5 <= 0 and var_218_26 or var_218_26 * (utf8.len(var_218_29) / 5)) > 0 and var_218_26 < var_218_31 then
					arg_215_1.talkMaxDuration = var_218_31
					var_218_25 = var_218_25 + 0.3

					if var_218_31 + var_218_25 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_31 + var_218_25
					end
				end

				arg_215_1.text_.text = var_218_29
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002049", "story_v_side_new_1102002.awb") ~= 0 then
					local var_218_32 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002049", "story_v_side_new_1102002.awb") / 1000

					if var_218_32 + var_218_25 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_32 + var_218_25
					end

					if var_218_28.prefab_name ~= "" and arg_215_1.actors_[var_218_28.prefab_name] ~= nil then
						local var_218_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_28.prefab_name].transform, "story_v_side_new_1102002", "1102002049", "story_v_side_new_1102002.awb")

						arg_215_1:RecordAudio("1102002049", var_218_33)
						arg_215_1:RecordAudio("1102002049", var_218_33)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002049", "story_v_side_new_1102002.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002049", "story_v_side_new_1102002.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_34 = var_218_25 + 0.3
			local var_218_35 = math.max(var_218_26, arg_215_1.talkMaxDuration)

			if var_218_25 + 0.3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_34 + var_218_35 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_34) / var_218_35

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_34 + var_218_35 and arg_215_1.time_ < var_218_34 + var_218_35 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.18333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.06733333518108,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play1102002050 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1102002050
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1102002051(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1020ui_story = arg_221_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1020ui_story"].transform.position).z)
				arg_221_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1020ui_story"].transform.localEulerAngles = arg_221_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1020ui_story"].transform.position).z)
				arg_221_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1020ui_story"].transform.localEulerAngles = arg_221_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1020ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1020ui_story == nil then
				arg_221_1.var_.characterEffect1020ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1020ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_2)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1020ui_story then
				arg_221_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_224_3 = 0
			local var_224_4 = 0.6

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_5 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(1102002050).content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 24 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 24)

				if (24 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 24)) > 0 and var_224_4 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_3 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_3
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_4, arg_221_1.talkMaxDuration)

			if var_224_3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_3 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_3) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_3 + var_224_8 and arg_221_1.time_ < var_224_3 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play1102002051 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1102002051
		arg_225_1.duration_ = 9.5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1102002052(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1020ui_story = arg_225_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1020ui_story"].transform.position).z)
				arg_225_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1020ui_story"].transform.localEulerAngles = arg_225_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_225_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1020ui_story"].transform.position).z)
				arg_225_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1020ui_story"].transform.localEulerAngles = arg_225_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1020ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1020ui_story == nil then
				arg_225_1.var_.characterEffect1020ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1020ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1020ui_story then
				arg_225_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action438")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_228_4 = 0
			local var_228_5 = 1

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(1102002051)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 40 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 40)

				if (40 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 40)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002051", "story_v_side_new_1102002.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002051", "story_v_side_new_1102002.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_side_new_1102002", "1102002051", "story_v_side_new_1102002.awb")

						arg_225_1:RecordAudio("1102002051", var_228_11)
						arg_225_1:RecordAudio("1102002051", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002051", "story_v_side_new_1102002.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002051", "story_v_side_new_1102002.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play1102002052 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1102002052
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1102002053(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1020ui_story"]) and arg_229_1.var_.characterEffect1020ui_story == nil then
				arg_229_1.var_.characterEffect1020ui_story = arg_229_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1020ui_story"]) then
				if arg_229_1.var_.characterEffect1020ui_story and not isNil(arg_229_1.actors_["1020ui_story"]) then
					arg_229_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1020ui_story"]) and arg_229_1.var_.characterEffect1020ui_story then
				arg_229_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 1.225

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(1102002052).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 49 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 49)

				if (49 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 49)) > 0 and var_232_2 < var_232_5 then
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
	Play1102002053 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1102002053
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1102002054(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1020ui_story = arg_233_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).z)
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles = arg_233_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).z)
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles = arg_233_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_236_1 = 0
			local var_236_2 = 0.725

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1102002053).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 29 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 29)

				if (29 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 29)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play1102002054 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1102002054
		arg_237_1.duration_ = 2.33

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1102002055(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1020ui_story = arg_237_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).z)
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles = arg_237_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_237_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).z)
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles = arg_237_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1020ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1020ui_story == nil then
				arg_237_1.var_.characterEffect1020ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1020ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1020ui_story then
				arg_237_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_240_4 = 0
			local var_240_5 = 0.125

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(1102002054)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 5 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 5)

				if (5 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 5)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002054", "story_v_side_new_1102002.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002054", "story_v_side_new_1102002.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_side_new_1102002", "1102002054", "story_v_side_new_1102002.awb")

						arg_237_1:RecordAudio("1102002054", var_240_11)
						arg_237_1:RecordAudio("1102002054", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002054", "story_v_side_new_1102002.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002054", "story_v_side_new_1102002.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102002055 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1102002055
		arg_241_1.duration_ = 2

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1102002056(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_244_0 = 0
			local var_244_1 = 0.25

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_2 = arg_241_1:GetWordFromCfg(1102002055)
				local var_244_3 = arg_241_1:FormatText(var_244_2.content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 10 <= 0 and var_244_1 or var_244_1 * (utf8.len(var_244_3) / 10)

				if (10 <= 0 and var_244_1 or var_244_1 * (utf8.len(var_244_3) / 10)) > 0 and var_244_1 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002055", "story_v_side_new_1102002.awb") ~= 0 then
					local var_244_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002055", "story_v_side_new_1102002.awb") / 1000

					if var_244_6 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_0
					end

					if var_244_2.prefab_name ~= "" and arg_241_1.actors_[var_244_2.prefab_name] ~= nil then
						local var_244_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_2.prefab_name].transform, "story_v_side_new_1102002", "1102002055", "story_v_side_new_1102002.awb")

						arg_241_1:RecordAudio("1102002055", var_244_7)
						arg_241_1:RecordAudio("1102002055", var_244_7)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002055", "story_v_side_new_1102002.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002055", "story_v_side_new_1102002.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_8 and arg_241_1.time_ < var_244_0 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1102002056 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1102002056
		arg_245_1.duration_ = 7.23

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1102002057(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_9001
			local var_248_9000

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				local var_248_0 = arg_245_1.bgs_.H03b

				arg_245_1.bgs_.H03b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_248_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_1 = var_248_0:GetComponent("SpriteRenderer")

				if var_248_1 and var_248_1.sprite then
					local var_248_2 = 2 * (var_248_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_248_0.transform.localScale = Vector3.New(var_248_2 / var_248_1.sprite.bounds.size.y < var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x and var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x or var_248_2 / var_248_1.sprite.bounds.size.y, var_248_2 / var_248_1.sprite.bounds.size.y < var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x and var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x or var_248_2 / var_248_1.sprite.bounds.size.y, 0)
				end

				for iter_248_0, iter_248_1 in pairs(arg_245_1.bgs_) do
					if iter_248_0 ~= "H03b" then
						iter_248_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_3 = "H05"

			if arg_245_1.bgs_.H05 == nil then
				local var_248_4 = Object.Instantiate(arg_245_1.paintGo_)

				var_248_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_248_3)
				var_248_4.name = var_248_3
				var_248_4.transform.parent = arg_245_1.stage_.transform
				var_248_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.bgs_[var_248_3] = var_248_4
			end

			if 1.500667 < arg_245_1.time_ and arg_245_1.time_ <= 1.500667 + arg_248_0 then
				local var_248_5 = arg_245_1.bgs_.H05

				arg_245_1.bgs_.H05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_248_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_6 = var_248_5:GetComponent("SpriteRenderer")

				if var_248_6 and var_248_6.sprite then
					local var_248_7 = 2 * (var_248_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_248_5.transform.localScale = Vector3.New(var_248_7 / var_248_6.sprite.bounds.size.y < var_248_7 * manager.ui.mainCameraCom_.aspect / var_248_6.sprite.bounds.size.x and var_248_7 * manager.ui.mainCameraCom_.aspect / var_248_6.sprite.bounds.size.x or var_248_7 / var_248_6.sprite.bounds.size.y, var_248_7 / var_248_6.sprite.bounds.size.y < var_248_7 * manager.ui.mainCameraCom_.aspect / var_248_6.sprite.bounds.size.x and var_248_7 * manager.ui.mainCameraCom_.aspect / var_248_6.sprite.bounds.size.x or var_248_7 / var_248_6.sprite.bounds.size.y, 0)
				end

				for iter_248_2, iter_248_3 in pairs(arg_245_1.bgs_) do
					if iter_248_2 ~= "H05" then
						iter_248_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_8 = 3.000667

			if 3.000667 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				arg_245_1.allBtn_.enabled = false
			end

			if arg_245_1.time_ >= var_248_8 + 0.3 and arg_245_1.time_ < var_248_8 + 0.3 + arg_248_0 then
				arg_245_1.allBtn_.enabled = true
			end

			local var_248_9 = arg_245_1.actors_["1020ui_story"].transform

			if 2.5 < arg_245_1.time_ and arg_245_1.time_ <= 2.5 + arg_248_0 then
				arg_245_1.var_.moveOldPos1020ui_story = var_248_9.localPosition
			end

			local var_248_10 = 0.001

			if 2.5 <= arg_245_1.time_ and arg_245_1.time_ < 2.5 + var_248_10 then
				var_248_9.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_245_1.time_ - 2.5) / var_248_10)
				var_248_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_9.position).x, (manager.ui.mainCamera.transform.position - var_248_9.position).y, (manager.ui.mainCamera.transform.position - var_248_9.position).z)
				var_248_9.localEulerAngles.z = 0
				var_248_9.localEulerAngles.x = 0
				var_248_9.localEulerAngles = var_248_9.localEulerAngles
			end

			if arg_245_1.time_ >= 2.5 + var_248_10 and arg_245_1.time_ < 2.5 + var_248_10 + arg_248_0 then
				var_248_9.localPosition = Vector3.New(0, -0.85, -6.25)
				var_248_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_9.position).x, (manager.ui.mainCamera.transform.position - var_248_9.position).y, (manager.ui.mainCamera.transform.position - var_248_9.position).z)
				var_248_9.localEulerAngles.z = 0
				var_248_9.localEulerAngles.x = 0
				var_248_9.localEulerAngles = var_248_9.localEulerAngles
			end

			if 2.5 < arg_245_1.time_ and arg_245_1.time_ <= 2.5 + arg_248_0 then
				arg_245_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 2.5 < arg_245_1.time_ and arg_245_1.time_ <= 2.5 + arg_248_0 then
				arg_245_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				local var_248_11 = arg_245_1.var_.effect213213231213213

				if not arg_245_1.var_.effect213213231213213 then
					var_248_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_248_11.name = "213213231213213"
					arg_245_1.var_.effect213213231213213 = var_248_11
				else
					var_248_11.transform:SetParent(var_248_9001)
				end

				var_248_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_248_13 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_248_4, iter_248_5 in ipairs((var_248_11.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_248_5.transform.localScale = Vector3.New(iter_248_5.transform.localScale.x / var_248_13 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_248_5.transform.localScale.y / var_248_13, iter_248_5.transform.localScale.z)
				end
			end

			if 1.50066666851441 < arg_245_1.time_ and arg_245_1.time_ <= 1.50066666851441 + arg_248_0 then
				if arg_245_1.var_.effect213213231213213 then
					Object.Destroy(arg_245_1.var_.effect213213231213213)

					arg_245_1.var_.effect213213231213213 = nil
				end
			end

			if 1.50066666851441 < arg_245_1.time_ and arg_245_1.time_ <= 1.50066666851441 + arg_248_0 then
				local var_248_16 = arg_245_1.var_.effect213222222123213

				if not arg_245_1.var_.effect213222222123213 then
					var_248_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_248_16.name = "213222222123213"
					arg_245_1.var_.effect213222222123213 = var_248_16
				else
					var_248_16.transform:SetParent(var_248_9000)
				end

				var_248_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_248_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_248_6, iter_248_7 in ipairs((var_248_16.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_248_7.transform.localScale = Vector3.New(iter_248_7.transform.localScale.x / var_248_18 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_248_7.transform.localScale.y / var_248_18, iter_248_7.transform.localScale.z)
				end
			end

			local var_248_20 = arg_245_1.actors_["1020ui_story"].transform

			if 1.16599999815226 < arg_245_1.time_ and arg_245_1.time_ <= 1.16599999815226 + arg_248_0 then
				arg_245_1.var_.moveOldPos1020ui_story = var_248_20.localPosition
			end

			local var_248_21 = 0.001

			if 1.16599999815226 <= arg_245_1.time_ and arg_245_1.time_ < 1.16599999815226 + var_248_21 then
				var_248_20.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 1.16599999815226) / var_248_21)
				var_248_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_20.position).x, (manager.ui.mainCamera.transform.position - var_248_20.position).y, (manager.ui.mainCamera.transform.position - var_248_20.position).z)
				var_248_20.localEulerAngles.z = 0
				var_248_20.localEulerAngles.x = 0
				var_248_20.localEulerAngles = var_248_20.localEulerAngles
			end

			if arg_245_1.time_ >= 1.16599999815226 + var_248_21 and arg_245_1.time_ < 1.16599999815226 + var_248_21 + arg_248_0 then
				var_248_20.localPosition = Vector3.New(0, 100, 0)
				var_248_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_20.position).x, (manager.ui.mainCamera.transform.position - var_248_20.position).y, (manager.ui.mainCamera.transform.position - var_248_20.position).z)
				var_248_20.localEulerAngles.z = 0
				var_248_20.localEulerAngles.x = 0
				var_248_20.localEulerAngles = var_248_20.localEulerAngles
			end

			if 0.125 < arg_245_1.time_ and arg_245_1.time_ <= 0.125 + arg_248_0 then
				arg_245_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_river", "")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_whoosh", "")
			end

			if 1.2 < arg_245_1.time_ and arg_245_1.time_ <= 1.2 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_25 = 2.5
			local var_248_26 = 0.375

			if 2.5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_25 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_27 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_27:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_28 = arg_245_1:GetWordFromCfg(1102002056)
				local var_248_29 = arg_245_1:FormatText(var_248_28.content)

				arg_245_1.text_.text = var_248_29

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_31 = 15 <= 0 and var_248_26 or var_248_26 * (utf8.len(var_248_29) / 15)

				if (15 <= 0 and var_248_26 or var_248_26 * (utf8.len(var_248_29) / 15)) > 0 and var_248_26 < var_248_31 then
					arg_245_1.talkMaxDuration = var_248_31
					var_248_25 = var_248_25 + 0.3

					if var_248_31 + var_248_25 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_31 + var_248_25
					end
				end

				arg_245_1.text_.text = var_248_29
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002056", "story_v_side_new_1102002.awb") ~= 0 then
					local var_248_32 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002056", "story_v_side_new_1102002.awb") / 1000

					if var_248_32 + var_248_25 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_32 + var_248_25
					end

					if var_248_28.prefab_name ~= "" and arg_245_1.actors_[var_248_28.prefab_name] ~= nil then
						local var_248_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_28.prefab_name].transform, "story_v_side_new_1102002", "1102002056", "story_v_side_new_1102002.awb")

						arg_245_1:RecordAudio("1102002056", var_248_33)
						arg_245_1:RecordAudio("1102002056", var_248_33)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002056", "story_v_side_new_1102002.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002056", "story_v_side_new_1102002.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_34 = var_248_25 + 0.3
			local var_248_35 = math.max(var_248_26, arg_245_1.talkMaxDuration)

			if var_248_25 + 0.3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_34 + var_248_35 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_34) / var_248_35

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_34 + var_248_35 and arg_245_1.time_ < var_248_34 + var_248_35 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.16599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play1102002057 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1102002057
		arg_251_1.duration_ = 7

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1102002058(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_254_0 = 0
			local var_254_1 = 0.775

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(1102002057)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 31 <= 0 and var_254_1 or var_254_1 * (utf8.len(var_254_3) / 31)

				if (31 <= 0 and var_254_1 or var_254_1 * (utf8.len(var_254_3) / 31)) > 0 and var_254_1 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002057", "story_v_side_new_1102002.awb") ~= 0 then
					local var_254_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002057", "story_v_side_new_1102002.awb") / 1000

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end

					if var_254_2.prefab_name ~= "" and arg_251_1.actors_[var_254_2.prefab_name] ~= nil then
						local var_254_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_2.prefab_name].transform, "story_v_side_new_1102002", "1102002057", "story_v_side_new_1102002.awb")

						arg_251_1:RecordAudio("1102002057", var_254_7)
						arg_251_1:RecordAudio("1102002057", var_254_7)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002057", "story_v_side_new_1102002.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002057", "story_v_side_new_1102002.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_8 and arg_251_1.time_ < var_254_0 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1102002058 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1102002058
		arg_255_1.duration_ = 4.47

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1102002059(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action438")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_258_0 = 0
			local var_258_1 = 0.525

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_2 = arg_255_1:GetWordFromCfg(1102002058)
				local var_258_3 = arg_255_1:FormatText(var_258_2.content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 21 <= 0 and var_258_1 or var_258_1 * (utf8.len(var_258_3) / 21)

				if (21 <= 0 and var_258_1 or var_258_1 * (utf8.len(var_258_3) / 21)) > 0 and var_258_1 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002058", "story_v_side_new_1102002.awb") ~= 0 then
					local var_258_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002058", "story_v_side_new_1102002.awb") / 1000

					if var_258_6 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_6 + var_258_0
					end

					if var_258_2.prefab_name ~= "" and arg_255_1.actors_[var_258_2.prefab_name] ~= nil then
						local var_258_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_2.prefab_name].transform, "story_v_side_new_1102002", "1102002058", "story_v_side_new_1102002.awb")

						arg_255_1:RecordAudio("1102002058", var_258_7)
						arg_255_1:RecordAudio("1102002058", var_258_7)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002058", "story_v_side_new_1102002.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002058", "story_v_side_new_1102002.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_8 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_8 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_8

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_8 and arg_255_1.time_ < var_258_0 + var_258_8 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1102002059 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1102002059
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1102002060(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1020ui_story"]) and arg_259_1.var_.characterEffect1020ui_story == nil then
				arg_259_1.var_.characterEffect1020ui_story = arg_259_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1020ui_story"]) then
				if arg_259_1.var_.characterEffect1020ui_story and not isNil(arg_259_1.actors_["1020ui_story"]) then
					arg_259_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_0)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1020ui_story"]) and arg_259_1.var_.characterEffect1020ui_story then
				arg_259_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_262_1 = 0
			local var_262_2 = 0.55

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(1102002059).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 22 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 22)

				if (22 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 22)) > 0 and var_262_2 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_1
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_6 = math.max(var_262_2, arg_259_1.talkMaxDuration)

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_6 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_1) / var_262_6

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_1 + var_262_6 and arg_259_1.time_ < var_262_1 + var_262_6 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1102002060 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1102002060
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1102002061(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1020ui_story = arg_263_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1020ui_story"].transform.position).z)
				arg_263_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1020ui_story"].transform.localEulerAngles = arg_263_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1020ui_story"].transform.position).z)
				arg_263_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1020ui_story"].transform.localEulerAngles = arg_263_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_266_1 = 0
			local var_266_2 = 1.075

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

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1102002060).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 43 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 43)

				if (43 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 43)) > 0 and var_266_2 < var_266_5 then
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

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102002061 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1102002061
		arg_267_1.duration_ = 7.73

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1102002062(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_9001
			local var_270_9000

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				local var_270_0 = arg_267_1.bgs_.H05

				arg_267_1.bgs_.H05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_270_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_1 = var_270_0:GetComponent("SpriteRenderer")

				if var_270_1 and var_270_1.sprite then
					local var_270_2 = 2 * (var_270_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_270_0.transform.localScale = Vector3.New(var_270_2 / var_270_1.sprite.bounds.size.y < var_270_2 * manager.ui.mainCameraCom_.aspect / var_270_1.sprite.bounds.size.x and var_270_2 * manager.ui.mainCameraCom_.aspect / var_270_1.sprite.bounds.size.x or var_270_2 / var_270_1.sprite.bounds.size.y, var_270_2 / var_270_1.sprite.bounds.size.y < var_270_2 * manager.ui.mainCameraCom_.aspect / var_270_1.sprite.bounds.size.x and var_270_2 * manager.ui.mainCameraCom_.aspect / var_270_1.sprite.bounds.size.x or var_270_2 / var_270_1.sprite.bounds.size.y, 0)
				end

				for iter_270_0, iter_270_1 in pairs(arg_267_1.bgs_) do
					if iter_270_0 ~= "H05" then
						iter_270_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_3 = "H02"

			if arg_267_1.bgs_.H02 == nil then
				local var_270_4 = Object.Instantiate(arg_267_1.paintGo_)

				var_270_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_270_3)
				var_270_4.name = var_270_3
				var_270_4.transform.parent = arg_267_1.stage_.transform
				var_270_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.bgs_[var_270_3] = var_270_4
			end

			if 1.50066666851441 < arg_267_1.time_ and arg_267_1.time_ <= 1.50066666851441 + arg_270_0 then
				local var_270_5 = arg_267_1.bgs_.H02

				arg_267_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_270_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_6 = var_270_5:GetComponent("SpriteRenderer")

				if var_270_6 and var_270_6.sprite then
					local var_270_7 = 2 * (var_270_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_270_5.transform.localScale = Vector3.New(var_270_7 / var_270_6.sprite.bounds.size.y < var_270_7 * manager.ui.mainCameraCom_.aspect / var_270_6.sprite.bounds.size.x and var_270_7 * manager.ui.mainCameraCom_.aspect / var_270_6.sprite.bounds.size.x or var_270_7 / var_270_6.sprite.bounds.size.y, var_270_7 / var_270_6.sprite.bounds.size.y < var_270_7 * manager.ui.mainCameraCom_.aspect / var_270_6.sprite.bounds.size.x and var_270_7 * manager.ui.mainCameraCom_.aspect / var_270_6.sprite.bounds.size.x or var_270_7 / var_270_6.sprite.bounds.size.y, 0)
				end

				for iter_270_2, iter_270_3 in pairs(arg_267_1.bgs_) do
					if iter_270_2 ~= "H02" then
						iter_270_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_8 = 2.72566666851441

			if 2.72566666851441 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			if arg_267_1.time_ >= var_270_8 + 0.3 and arg_267_1.time_ < var_270_8 + 0.3 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				local var_270_9 = arg_267_1.var_.effect213213231213213

				if not arg_267_1.var_.effect213213231213213 then
					var_270_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_270_9.name = "213213231213213"
					arg_267_1.var_.effect213213231213213 = var_270_9
				else
					var_270_9.transform:SetParent(var_270_9001)
				end

				var_270_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_270_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_270_11 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_270_4, iter_270_5 in ipairs((var_270_9.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_270_5.transform.localScale = Vector3.New(iter_270_5.transform.localScale.x / var_270_11 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_270_5.transform.localScale.y / var_270_11, iter_270_5.transform.localScale.z)
				end
			end

			if 1.50066666851441 < arg_267_1.time_ and arg_267_1.time_ <= 1.50066666851441 + arg_270_0 then
				if arg_267_1.var_.effect213213231213213 then
					Object.Destroy(arg_267_1.var_.effect213213231213213)

					arg_267_1.var_.effect213213231213213 = nil
				end
			end

			if 1.50066666851441 < arg_267_1.time_ and arg_267_1.time_ <= 1.50066666851441 + arg_270_0 then
				local var_270_14 = arg_267_1.var_.effect213222222123213

				if not arg_267_1.var_.effect213222222123213 then
					var_270_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_270_14.name = "213222222123213"
					arg_267_1.var_.effect213222222123213 = var_270_14
				else
					var_270_14.transform:SetParent(var_270_9000)
				end

				var_270_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_270_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_270_16 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_270_6, iter_270_7 in ipairs((var_270_14.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_270_7.transform.localScale = Vector3.New(iter_270_7.transform.localScale.x / var_270_16 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_270_7.transform.localScale.y / var_270_16, iter_270_7.transform.localScale.z)
				end
			end

			if arg_267_1.frameCnt_ <= 1 then
				arg_267_1.dialog_:SetActive(false)
			end

			local var_270_18 = 2.72566666851441
			local var_270_19 = 0.775

			if 2.72566666851441 < arg_267_1.time_ and arg_267_1.time_ <= var_270_18 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_20 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_20:setOnUpdate(LuaHelper.FloatAction(function(arg_271_0)
					arg_267_1.dialogCg_.alpha = arg_271_0
				end))
				var_270_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_21 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1102002061).content)

				arg_267_1.text_.text = var_270_21

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_23 = 31 <= 0 and var_270_19 or var_270_19 * (utf8.len(var_270_21) / 31)

				if (31 <= 0 and var_270_19 or var_270_19 * (utf8.len(var_270_21) / 31)) > 0 and var_270_19 < var_270_23 then
					arg_267_1.talkMaxDuration = var_270_23
					var_270_18 = var_270_18 + 0.3

					if var_270_23 + var_270_18 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_23 + var_270_18
					end
				end

				arg_267_1.text_.text = var_270_21
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_24 = var_270_18 + 0.3
			local var_270_25 = math.max(var_270_19, arg_267_1.talkMaxDuration)

			if var_270_18 + 0.3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_24 + var_270_25 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_24) / var_270_25

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_24 + var_270_25 and arg_267_1.time_ < var_270_24 + var_270_25 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1102002062 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1102002062
		arg_273_1.duration_ = 3.83

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1102002063(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1020ui_story = arg_273_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).z)
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles = arg_273_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_273_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).z)
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles = arg_273_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1020ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1020ui_story == nil then
				arg_273_1.var_.characterEffect1020ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1020ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1020ui_story then
				arg_273_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_276_4 = 0
			local var_276_5 = 0.375

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(1102002062)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 15 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 15)

				if (15 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 15)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002062", "story_v_side_new_1102002.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002062", "story_v_side_new_1102002.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_side_new_1102002", "1102002062", "story_v_side_new_1102002.awb")

						arg_273_1:RecordAudio("1102002062", var_276_11)
						arg_273_1:RecordAudio("1102002062", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002062", "story_v_side_new_1102002.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002062", "story_v_side_new_1102002.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play1102002063 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1102002063
		arg_277_1.duration_ = 6.87

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1102002064(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action423")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_280_0 = 0
			local var_280_1 = 0.65

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(1102002063)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 26 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_3) / 26)

				if (26 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_3) / 26)) > 0 and var_280_1 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002063", "story_v_side_new_1102002.awb") ~= 0 then
					local var_280_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002063", "story_v_side_new_1102002.awb") / 1000

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end

					if var_280_2.prefab_name ~= "" and arg_277_1.actors_[var_280_2.prefab_name] ~= nil then
						local var_280_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_2.prefab_name].transform, "story_v_side_new_1102002", "1102002063", "story_v_side_new_1102002.awb")

						arg_277_1:RecordAudio("1102002063", var_280_7)
						arg_277_1:RecordAudio("1102002063", var_280_7)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002063", "story_v_side_new_1102002.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002063", "story_v_side_new_1102002.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1102002064 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1102002064
		arg_281_1.duration_ = 5.3

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1102002065(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_284_0 = 0
			local var_284_1 = 0.45

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(1102002064)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 18 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 18)

				if (18 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 18)) > 0 and var_284_1 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002064", "story_v_side_new_1102002.awb") ~= 0 then
					local var_284_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002064", "story_v_side_new_1102002.awb") / 1000

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end

					if var_284_2.prefab_name ~= "" and arg_281_1.actors_[var_284_2.prefab_name] ~= nil then
						local var_284_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_2.prefab_name].transform, "story_v_side_new_1102002", "1102002064", "story_v_side_new_1102002.awb")

						arg_281_1:RecordAudio("1102002064", var_284_7)
						arg_281_1:RecordAudio("1102002064", var_284_7)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002064", "story_v_side_new_1102002.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002064", "story_v_side_new_1102002.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1102002065 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1102002065
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1102002066(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1020ui_story"]) and arg_285_1.var_.characterEffect1020ui_story == nil then
				arg_285_1.var_.characterEffect1020ui_story = arg_285_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1020ui_story"]) then
				if arg_285_1.var_.characterEffect1020ui_story and not isNil(arg_285_1.actors_["1020ui_story"]) then
					arg_285_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1020ui_story"]) and arg_285_1.var_.characterEffect1020ui_story then
				arg_285_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 0.625

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

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(1102002065).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 25 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 25)

				if (25 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 25)) > 0 and var_288_2 < var_288_5 then
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
	Play1102002066 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1102002066
		arg_289_1.duration_ = 2.5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1102002067(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1020ui_story"]) and arg_289_1.var_.characterEffect1020ui_story == nil then
				arg_289_1.var_.characterEffect1020ui_story = arg_289_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1020ui_story"]) then
				if arg_289_1.var_.characterEffect1020ui_story and not isNil(arg_289_1.actors_["1020ui_story"]) then
					arg_289_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1020ui_story"]) and arg_289_1.var_.characterEffect1020ui_story then
				arg_289_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_292_2 = 0
			local var_292_3 = 0.3

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:GetWordFromCfg(1102002066)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 12 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 12)

				if (12 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 12)) > 0 and var_292_3 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002066", "story_v_side_new_1102002.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002066", "story_v_side_new_1102002.awb") / 1000

					if var_292_8 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_2
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_side_new_1102002", "1102002066", "story_v_side_new_1102002.awb")

						arg_289_1:RecordAudio("1102002066", var_292_9)
						arg_289_1:RecordAudio("1102002066", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002066", "story_v_side_new_1102002.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002066", "story_v_side_new_1102002.awb")
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
	Play1102002067 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1102002067
		arg_293_1.duration_ = 12.2

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1102002068(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.125

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:GetWordFromCfg(1102002067)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 45 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 45)

				if (45 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 45)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002067", "story_v_side_new_1102002.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002067", "story_v_side_new_1102002.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_side_new_1102002", "1102002067", "story_v_side_new_1102002.awb")

						arg_293_1:RecordAudio("1102002067", var_296_6)
						arg_293_1:RecordAudio("1102002067", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002067", "story_v_side_new_1102002.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002067", "story_v_side_new_1102002.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1102002068 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1102002068
		arg_297_1.duration_ = 7.1

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1102002069(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_2")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_300_0 = 0
			local var_300_1 = 0.6

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_2 = arg_297_1:GetWordFromCfg(1102002068)
				local var_300_3 = arg_297_1:FormatText(var_300_2.content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 24 <= 0 and var_300_1 or var_300_1 * (utf8.len(var_300_3) / 24)

				if (24 <= 0 and var_300_1 or var_300_1 * (utf8.len(var_300_3) / 24)) > 0 and var_300_1 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002068", "story_v_side_new_1102002.awb") ~= 0 then
					local var_300_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002068", "story_v_side_new_1102002.awb") / 1000

					if var_300_6 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_0
					end

					if var_300_2.prefab_name ~= "" and arg_297_1.actors_[var_300_2.prefab_name] ~= nil then
						local var_300_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_2.prefab_name].transform, "story_v_side_new_1102002", "1102002068", "story_v_side_new_1102002.awb")

						arg_297_1:RecordAudio("1102002068", var_300_7)
						arg_297_1:RecordAudio("1102002068", var_300_7)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002068", "story_v_side_new_1102002.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002068", "story_v_side_new_1102002.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_8 and arg_297_1.time_ < var_300_0 + var_300_8 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1102002069 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1102002069
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1102002070(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1020ui_story = arg_301_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).z)
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles = arg_301_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_301_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1020ui_story"].transform.position).z)
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1020ui_story"].transform.localEulerAngles = arg_301_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1020ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1020ui_story == nil then
				arg_301_1.var_.characterEffect1020ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1020ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_2)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1020ui_story then
				arg_301_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_304_3 = 0
			local var_304_4 = 0.725

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_3 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_5 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1102002069).content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 29 <= 0 and var_304_4 or var_304_4 * (utf8.len(var_304_5) / 29)

				if (29 <= 0 and var_304_4 or var_304_4 * (utf8.len(var_304_5) / 29)) > 0 and var_304_4 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_3 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_3
					end
				end

				arg_301_1.text_.text = var_304_5
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_4, arg_301_1.talkMaxDuration)

			if var_304_3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_3 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_3) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_3 + var_304_8 and arg_301_1.time_ < var_304_3 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play1102002070 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1102002070
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1102002071(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.525

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
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

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(1102002070).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 21 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 21)

				if (21 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 21)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1102002071 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1102002071
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1102002072(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.1

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(1102002071).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 4 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 4)

				if (4 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 4)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1102002072 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1102002072
		arg_313_1.duration_ = 7.3

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1102002073(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_9000

			if 0.299999999999 < arg_313_1.time_ and arg_313_1.time_ <= 0.299999999999 + arg_316_0 then
				local var_316_0 = arg_313_1.bgs_.STblack

				arg_313_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_316_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_316_1 = var_316_0:GetComponent("SpriteRenderer")

				if var_316_1 and var_316_1.sprite then
					local var_316_2 = 2 * (var_316_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_316_0.transform.localScale = Vector3.New(var_316_2 / var_316_1.sprite.bounds.size.y < var_316_2 * manager.ui.mainCameraCom_.aspect / var_316_1.sprite.bounds.size.x and var_316_2 * manager.ui.mainCameraCom_.aspect / var_316_1.sprite.bounds.size.x or var_316_2 / var_316_1.sprite.bounds.size.y, var_316_2 / var_316_1.sprite.bounds.size.y < var_316_2 * manager.ui.mainCameraCom_.aspect / var_316_1.sprite.bounds.size.x and var_316_2 * manager.ui.mainCameraCom_.aspect / var_316_1.sprite.bounds.size.x or var_316_2 / var_316_1.sprite.bounds.size.y, 0)
				end

				for iter_316_0, iter_316_1 in pairs(arg_313_1.bgs_) do
					if iter_316_0 ~= "STblack" then
						iter_316_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_316_3 = 0

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_3 + arg_316_0 then
				arg_313_1.allBtn_.enabled = false
			end

			if arg_313_1.time_ >= var_316_3 + 0.3 and arg_313_1.time_ < var_316_3 + 0.3 + arg_316_0 then
				arg_313_1.allBtn_.enabled = true
			end

			local var_316_4 = 0.3

			if 0.3 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.mask_.enabled = true
				arg_313_1.mask_.raycastTarget = true

				arg_313_1:SetGaussion(false)
			end

			local var_316_5 = 2

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_5 then
				local var_316_6 = Color.New(1, 1, 1)

				var_316_6.a = Mathf.Lerp(1, 0, (arg_313_1.time_ - var_316_4) / var_316_5)
				arg_313_1.mask_.color = var_316_6
			end

			if arg_313_1.time_ >= var_316_4 + var_316_5 and arg_313_1.time_ < var_316_4 + var_316_5 + arg_316_0 then
				local var_316_7 = Color.New(1, 1, 1)

				arg_313_1.mask_.enabled = false
				var_316_7.a = 0
				arg_313_1.mask_.color = var_316_7
			end

			if 0.1 < arg_313_1.time_ and arg_313_1.time_ <= 0.1 + arg_316_0 then
				arg_313_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_316_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_313_1.bgmTxt_.text ~= var_316_12 and arg_313_1.bgmTxt_.text ~= "" then
						if arg_313_1.bgmTxt2_.text ~= "" then
							arg_313_1.bgmTxt_.text = arg_313_1.bgmTxt2_.text
						end

						arg_313_1.bgmTxt2_.text = var_316_12

						arg_313_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_313_1.bgmTxt_.text = var_316_12
						arg_313_1.bgmTxt2_.text = var_316_12
					end

					if arg_313_1.bgmTimer then
						arg_313_1.bgmTimer:Stop()

						arg_313_1.bgmTimer = nil
					end

					if arg_313_1.settingData.show_music_name == 1 then
						arg_313_1.musicController:SetSelectedState("show")
						arg_313_1.musicAnimator_:Play("open", 0, 0)

						if arg_313_1.settingData.music_time ~= 0 then
							arg_313_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_313_1.settingData.music_time), function()
								if arg_313_1 == nil or isNil(arg_313_1.bgmTxt_) then
									return
								end

								arg_313_1.musicController:SetSelectedState("hide")
								arg_313_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.299999999999 < arg_313_1.time_ and arg_313_1.time_ <= 0.299999999999 + arg_316_0 then
				arg_313_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_glass", "")
			end

			if 0.299999999999 < arg_313_1.time_ and arg_313_1.time_ <= 0.299999999999 + arg_316_0 then
				local var_316_14 = arg_313_1.var_.effectriguangposui

				if not arg_313_1.var_.effectriguangposui then
					var_316_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_posui"), manager.ui.mainCamera.transform)
					var_316_14.name = "riguangposui"
					arg_313_1.var_.effectriguangposui = var_316_14
				else
					var_316_14.transform:SetParent(var_316_9000)
				end

				var_316_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_316_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.3 < arg_313_1.time_ and arg_313_1.time_ <= 2.3 + arg_316_0 then
				if arg_313_1.var_.effectriguangposui then
					Object.Destroy(arg_313_1.var_.effectriguangposui)

					arg_313_1.var_.effectriguangposui = nil
				end
			end

			if arg_313_1.frameCnt_ <= 1 then
				arg_313_1.dialog_:SetActive(false)
			end

			local var_316_17 = 2.299999999999
			local var_316_18 = 0.425

			if 2.299999999999 < arg_313_1.time_ and arg_313_1.time_ <= var_316_17 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				arg_313_1.dialog_:SetActive(true)

				arg_313_1.dialogCg_.alpha = 0

				local var_316_19 = LeanTween.value(arg_313_1.dialog_, 0, 1, 0.3)

				var_316_19:setOnUpdate(LuaHelper.FloatAction(function(arg_318_0)
					arg_313_1.dialogCg_.alpha = arg_318_0
				end))
				var_316_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_313_1.dialog_)
					var_316_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_313_1.duration_ = arg_313_1.duration_ + 0.3

				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_20 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(1102002072).content)

				arg_313_1.text_.text = var_316_20

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_22 = 17 <= 0 and var_316_18 or var_316_18 * (utf8.len(var_316_20) / 17)

				if (17 <= 0 and var_316_18 or var_316_18 * (utf8.len(var_316_20) / 17)) > 0 and var_316_18 < var_316_22 then
					arg_313_1.talkMaxDuration = var_316_22
					var_316_17 = var_316_17 + 0.3

					if var_316_22 + var_316_17 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_22 + var_316_17
					end
				end

				arg_313_1.text_.text = var_316_20
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_23 = var_316_17 + 0.3
			local var_316_24 = math.max(var_316_18, arg_313_1.talkMaxDuration)

			if var_316_17 + 0.3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_23 + var_316_24 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_23) / var_316_24

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_23 + var_316_24 and arg_313_1.time_ < var_316_23 + var_316_24 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1102002073 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1102002073
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1102002074(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.975

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(1102002073).content)

				arg_320_1.text_.text = var_323_1

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_3 = 39 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 39)

				if (39 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 39)) > 0 and var_323_0 < var_323_3 then
					arg_320_1.talkMaxDuration = var_323_3

					if var_323_3 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_3 + 0
					end
				end

				arg_320_1.text_.text = var_323_1
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_4 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_4

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1102002074 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1102002074
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1102002075(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.25

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(1102002074).content)

				arg_324_1.text_.text = var_327_1

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_3 = 10 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 10)

				if (10 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 10)) > 0 and var_327_0 < var_327_3 then
					arg_324_1.talkMaxDuration = var_327_3

					if var_327_3 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_3 + 0
					end
				end

				arg_324_1.text_.text = var_327_1
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_4 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_4

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1102002075 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1102002075
		arg_328_1.duration_ = 7

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1102002076(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				local var_331_0 = arg_328_1.bgs_.L02h

				arg_328_1.bgs_.L02h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_331_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_331_1 = var_331_0:GetComponent("SpriteRenderer")

				if var_331_1 and var_331_1.sprite then
					local var_331_2 = 2 * (var_331_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_331_0.transform.localScale = Vector3.New(var_331_2 / var_331_1.sprite.bounds.size.y < var_331_2 * manager.ui.mainCameraCom_.aspect / var_331_1.sprite.bounds.size.x and var_331_2 * manager.ui.mainCameraCom_.aspect / var_331_1.sprite.bounds.size.x or var_331_2 / var_331_1.sprite.bounds.size.y, var_331_2 / var_331_1.sprite.bounds.size.y < var_331_2 * manager.ui.mainCameraCom_.aspect / var_331_1.sprite.bounds.size.x and var_331_2 * manager.ui.mainCameraCom_.aspect / var_331_1.sprite.bounds.size.x or var_331_2 / var_331_1.sprite.bounds.size.y, 0)
				end

				for iter_331_0, iter_331_1 in pairs(arg_328_1.bgs_) do
					if iter_331_0 ~= "L02h" then
						iter_331_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_331_3 = 2

			if 2 < arg_328_1.time_ and arg_328_1.time_ <= var_331_3 + arg_331_0 then
				arg_328_1.allBtn_.enabled = false
			end

			if arg_328_1.time_ >= var_331_3 + 0.333333333333333 and arg_328_1.time_ < var_331_3 + 0.333333333333333 + arg_331_0 then
				arg_328_1.allBtn_.enabled = true
			end

			local var_331_4 = 0

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_5 = 2

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_5 then
				local var_331_6 = Color.New(0, 0, 0)

				var_331_6.a = Mathf.Lerp(1, 0, (arg_328_1.time_ - var_331_4) / var_331_5)
				arg_328_1.mask_.color = var_331_6
			end

			if arg_328_1.time_ >= var_331_4 + var_331_5 and arg_328_1.time_ < var_331_4 + var_331_5 + arg_331_0 then
				local var_331_7 = Color.New(0, 0, 0)

				arg_328_1.mask_.enabled = false
				var_331_7.a = 0
				arg_328_1.mask_.color = var_331_7
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if 0.125 < arg_328_1.time_ and arg_328_1.time_ <= 0.125 + arg_331_0 then
				arg_328_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_331_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_328_1.bgmTxt_.text ~= var_331_12 and arg_328_1.bgmTxt_.text ~= "" then
						if arg_328_1.bgmTxt2_.text ~= "" then
							arg_328_1.bgmTxt_.text = arg_328_1.bgmTxt2_.text
						end

						arg_328_1.bgmTxt2_.text = var_331_12

						arg_328_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_328_1.bgmTxt_.text = var_331_12
						arg_328_1.bgmTxt2_.text = var_331_12
					end

					if arg_328_1.bgmTimer then
						arg_328_1.bgmTimer:Stop()

						arg_328_1.bgmTimer = nil
					end

					if arg_328_1.settingData.show_music_name == 1 then
						arg_328_1.musicController:SetSelectedState("show")
						arg_328_1.musicAnimator_:Play("open", 0, 0)

						if arg_328_1.settingData.music_time ~= 0 then
							arg_328_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_328_1.settingData.music_time), function()
								if arg_328_1 == nil or isNil(arg_328_1.bgmTxt_) then
									return
								end

								arg_328_1.musicController:SetSelectedState("hide")
								arg_328_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_328_1.time_ and arg_328_1.time_ <= 0.333333333333333 + arg_331_0 then
				arg_328_1:AudioAction("play", "music", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_331_15 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if "" ~= "" then
					if arg_328_1.bgmTxt_.text ~= var_331_15 and arg_328_1.bgmTxt_.text ~= "" then
						if arg_328_1.bgmTxt2_.text ~= "" then
							arg_328_1.bgmTxt_.text = arg_328_1.bgmTxt2_.text
						end

						arg_328_1.bgmTxt2_.text = var_331_15

						arg_328_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_328_1.bgmTxt_.text = var_331_15
						arg_328_1.bgmTxt2_.text = var_331_15
					end

					if arg_328_1.bgmTimer then
						arg_328_1.bgmTimer:Stop()

						arg_328_1.bgmTimer = nil
					end

					if arg_328_1.settingData.show_music_name == 1 then
						arg_328_1.musicController:SetSelectedState("show")
						arg_328_1.musicAnimator_:Play("open", 0, 0)

						if arg_328_1.settingData.music_time ~= 0 then
							arg_328_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_328_1.settingData.music_time), function()
								if arg_328_1 == nil or isNil(arg_328_1.bgmTxt_) then
									return
								end

								arg_328_1.musicController:SetSelectedState("hide")
								arg_328_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_328_1.frameCnt_ <= 1 then
				arg_328_1.dialog_:SetActive(false)
			end

			local var_331_16 = 2
			local var_331_17 = 0.25

			if 2 < arg_328_1.time_ and arg_328_1.time_ <= var_331_16 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0

				arg_328_1.dialog_:SetActive(true)

				arg_328_1.dialogCg_.alpha = 0

				local var_331_18 = LeanTween.value(arg_328_1.dialog_, 0, 1, 0.3)

				var_331_18:setOnUpdate(LuaHelper.FloatAction(function(arg_334_0)
					arg_328_1.dialogCg_.alpha = arg_334_0
				end))
				var_331_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_328_1.dialog_)
					var_331_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_328_1.duration_ = arg_328_1.duration_ + 0.3

				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_19 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(1102002075).content)

				arg_328_1.text_.text = var_331_19

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_21 = 10 <= 0 and var_331_17 or var_331_17 * (utf8.len(var_331_19) / 10)

				if (10 <= 0 and var_331_17 or var_331_17 * (utf8.len(var_331_19) / 10)) > 0 and var_331_17 < var_331_21 then
					arg_328_1.talkMaxDuration = var_331_21
					var_331_16 = var_331_16 + 0.3

					if var_331_21 + var_331_16 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_21 + var_331_16
					end
				end

				arg_328_1.text_.text = var_331_19
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_22 = var_331_16 + 0.3
			local var_331_23 = math.max(var_331_17, arg_328_1.talkMaxDuration)

			if var_331_16 + 0.3 <= arg_328_1.time_ and arg_328_1.time_ < var_331_22 + var_331_23 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_22) / var_331_23

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_22 + var_331_23 and arg_328_1.time_ < var_331_22 + var_331_23 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1102002076 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1102002076
		arg_336_1.duration_ = 5.07

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1102002077(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1020ui_story = arg_336_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_339_0 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 then
				arg_336_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_336_1.time_ - 0) / var_339_0)
				arg_336_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1020ui_story"].transform.position).z)
				arg_336_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1020ui_story"].transform.localEulerAngles = arg_336_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 then
				arg_336_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_336_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1020ui_story"].transform.position).z)
				arg_336_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1020ui_story"].transform.localEulerAngles = arg_336_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_339_1 = arg_336_1.actors_["1020ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_1) and arg_336_1.var_.characterEffect1020ui_story == nil then
				arg_336_1.var_.characterEffect1020ui_story = var_339_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_2 and not isNil(var_339_1) then
				if arg_336_1.var_.characterEffect1020ui_story and not isNil(var_339_1) then
					arg_336_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_2 and arg_336_1.time_ < 0 + var_339_2 + arg_339_0 and not isNil(var_339_1) and arg_336_1.var_.characterEffect1020ui_story then
				arg_336_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_339_4 = 0
			local var_339_5 = 0.575

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_6 = arg_336_1:GetWordFromCfg(1102002076)
				local var_339_7 = arg_336_1:FormatText(var_339_6.content)

				arg_336_1.text_.text = var_339_7

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_9 = 23 <= 0 and var_339_5 or var_339_5 * (utf8.len(var_339_7) / 23)

				if (23 <= 0 and var_339_5 or var_339_5 * (utf8.len(var_339_7) / 23)) > 0 and var_339_5 < var_339_9 then
					arg_336_1.talkMaxDuration = var_339_9

					if var_339_9 + var_339_4 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_9 + var_339_4
					end
				end

				arg_336_1.text_.text = var_339_7
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002076", "story_v_side_new_1102002.awb") ~= 0 then
					local var_339_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002076", "story_v_side_new_1102002.awb") / 1000

					if var_339_10 + var_339_4 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_10 + var_339_4
					end

					if var_339_6.prefab_name ~= "" and arg_336_1.actors_[var_339_6.prefab_name] ~= nil then
						local var_339_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_6.prefab_name].transform, "story_v_side_new_1102002", "1102002076", "story_v_side_new_1102002.awb")

						arg_336_1:RecordAudio("1102002076", var_339_11)
						arg_336_1:RecordAudio("1102002076", var_339_11)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002076", "story_v_side_new_1102002.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002076", "story_v_side_new_1102002.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_12 = math.max(var_339_5, arg_336_1.talkMaxDuration)

			if var_339_4 <= arg_336_1.time_ and arg_336_1.time_ < var_339_4 + var_339_12 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_4) / var_339_12

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_4 + var_339_12 and arg_336_1.time_ < var_339_4 + var_339_12 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play1102002077 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1102002077
		arg_340_1.duration_ = 9.2

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1102002078(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.8

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_1 = arg_340_1:GetWordFromCfg(1102002077)
				local var_343_2 = arg_340_1:FormatText(var_343_1.content)

				arg_340_1.text_.text = var_343_2

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 32 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 32)

				if (32 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 32)) > 0 and var_343_0 < var_343_4 then
					arg_340_1.talkMaxDuration = var_343_4

					if var_343_4 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_4 + 0
					end
				end

				arg_340_1.text_.text = var_343_2
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002077", "story_v_side_new_1102002.awb") ~= 0 then
					local var_343_5 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002077", "story_v_side_new_1102002.awb") / 1000

					if var_343_5 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + 0
					end

					if var_343_1.prefab_name ~= "" and arg_340_1.actors_[var_343_1.prefab_name] ~= nil then
						local var_343_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_1.prefab_name].transform, "story_v_side_new_1102002", "1102002077", "story_v_side_new_1102002.awb")

						arg_340_1:RecordAudio("1102002077", var_343_6)
						arg_340_1:RecordAudio("1102002077", var_343_6)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002077", "story_v_side_new_1102002.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002077", "story_v_side_new_1102002.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_7 and arg_340_1.time_ < 0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1102002078 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1102002078
		arg_344_1.duration_ = 4.37

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1102002079(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_347_0 = 0
			local var_347_1 = 0.375

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_2 = arg_344_1:GetWordFromCfg(1102002078)
				local var_347_3 = arg_344_1:FormatText(var_347_2.content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 15 <= 0 and var_347_1 or var_347_1 * (utf8.len(var_347_3) / 15)

				if (15 <= 0 and var_347_1 or var_347_1 * (utf8.len(var_347_3) / 15)) > 0 and var_347_1 < var_347_5 then
					arg_344_1.talkMaxDuration = var_347_5

					if var_347_5 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002078", "story_v_side_new_1102002.awb") ~= 0 then
					local var_347_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002078", "story_v_side_new_1102002.awb") / 1000

					if var_347_6 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_0
					end

					if var_347_2.prefab_name ~= "" and arg_344_1.actors_[var_347_2.prefab_name] ~= nil then
						local var_347_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_2.prefab_name].transform, "story_v_side_new_1102002", "1102002078", "story_v_side_new_1102002.awb")

						arg_344_1:RecordAudio("1102002078", var_347_7)
						arg_344_1:RecordAudio("1102002078", var_347_7)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002078", "story_v_side_new_1102002.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002078", "story_v_side_new_1102002.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_8 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_8 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_8

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_8 and arg_344_1.time_ < var_347_0 + var_347_8 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1102002079 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1102002079
		arg_348_1.duration_ = 9

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1102002080(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if arg_348_1.bgs_.H02a == nil then
				local var_351_0 = Object.Instantiate(arg_348_1.paintGo_)

				var_351_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02a")
				var_351_0.name = "H02a"
				var_351_0.transform.parent = arg_348_1.stage_.transform
				var_351_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_348_1.bgs_.H02a = var_351_0
			end

			if 2 < arg_348_1.time_ and arg_348_1.time_ <= 2 + arg_351_0 then
				local var_351_1 = arg_348_1.bgs_.H02a

				arg_348_1.bgs_.H02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_351_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_351_2 = var_351_1:GetComponent("SpriteRenderer")

				if var_351_2 and var_351_2.sprite then
					local var_351_3 = 2 * (var_351_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_351_1.transform.localScale = Vector3.New(var_351_3 / var_351_2.sprite.bounds.size.y < var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x and var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x or var_351_3 / var_351_2.sprite.bounds.size.y, var_351_3 / var_351_2.sprite.bounds.size.y < var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x and var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x or var_351_3 / var_351_2.sprite.bounds.size.y, 0)
				end

				for iter_351_0, iter_351_1 in pairs(arg_348_1.bgs_) do
					if iter_351_0 ~= "H02a" then
						iter_351_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_351_4 = 3.999999999999

			if 3.999999999999 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1.allBtn_.enabled = false
			end

			if arg_348_1.time_ >= var_351_4 + 0.3 and arg_348_1.time_ < var_351_4 + 0.3 + arg_351_0 then
				arg_348_1.allBtn_.enabled = true
			end

			local var_351_5 = 0

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_5 + arg_351_0 then
				arg_348_1.mask_.enabled = true
				arg_348_1.mask_.raycastTarget = true

				arg_348_1:SetGaussion(false)
			end

			local var_351_6 = 2

			if var_351_5 <= arg_348_1.time_ and arg_348_1.time_ < var_351_5 + var_351_6 then
				local var_351_7 = Color.New(0, 0, 0)

				var_351_7.a = Mathf.Lerp(0, 1, (arg_348_1.time_ - var_351_5) / var_351_6)
				arg_348_1.mask_.color = var_351_7
			end

			if arg_348_1.time_ >= var_351_5 + var_351_6 and arg_348_1.time_ < var_351_5 + var_351_6 + arg_351_0 then
				local var_351_8 = Color.New(0, 0, 0)

				var_351_8.a = 1
				arg_348_1.mask_.color = var_351_8
			end

			local var_351_9 = 2

			if 2 < arg_348_1.time_ and arg_348_1.time_ <= var_351_9 + arg_351_0 then
				arg_348_1.mask_.enabled = true
				arg_348_1.mask_.raycastTarget = true

				arg_348_1:SetGaussion(false)
			end

			local var_351_10 = 2

			if var_351_9 <= arg_348_1.time_ and arg_348_1.time_ < var_351_9 + var_351_10 then
				local var_351_11 = Color.New(0, 0, 0)

				var_351_11.a = Mathf.Lerp(1, 0, (arg_348_1.time_ - var_351_9) / var_351_10)
				arg_348_1.mask_.color = var_351_11
			end

			if arg_348_1.time_ >= var_351_9 + var_351_10 and arg_348_1.time_ < var_351_9 + var_351_10 + arg_351_0 then
				local var_351_12 = Color.New(0, 0, 0)

				arg_348_1.mask_.enabled = false
				var_351_12.a = 0
				arg_348_1.mask_.color = var_351_12
			end

			local var_351_13 = arg_348_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_348_1.time_ and arg_348_1.time_ <= 1.96599999815226 + arg_351_0 then
				arg_348_1.var_.moveOldPos1020ui_story = var_351_13.localPosition
			end

			local var_351_14 = 0.001

			if 1.96599999815226 <= arg_348_1.time_ and arg_348_1.time_ < 1.96599999815226 + var_351_14 then
				var_351_13.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_348_1.time_ - 1.96599999815226) / var_351_14)
				var_351_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_351_13.position).x, (manager.ui.mainCamera.transform.position - var_351_13.position).y, (manager.ui.mainCamera.transform.position - var_351_13.position).z)
				var_351_13.localEulerAngles.z = 0
				var_351_13.localEulerAngles.x = 0
				var_351_13.localEulerAngles = var_351_13.localEulerAngles
			end

			if arg_348_1.time_ >= 1.96599999815226 + var_351_14 and arg_348_1.time_ < 1.96599999815226 + var_351_14 + arg_351_0 then
				var_351_13.localPosition = Vector3.New(0, 100, 0)
				var_351_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_351_13.position).x, (manager.ui.mainCamera.transform.position - var_351_13.position).y, (manager.ui.mainCamera.transform.position - var_351_13.position).z)
				var_351_13.localEulerAngles.z = 0
				var_351_13.localEulerAngles.x = 0
				var_351_13.localEulerAngles = var_351_13.localEulerAngles
			end

			local var_351_15 = arg_348_1.actors_["1020ui_story"]

			if 1.96599999815226 < arg_348_1.time_ and arg_348_1.time_ <= 1.96599999815226 + arg_351_0 and not isNil(var_351_15) and arg_348_1.var_.characterEffect1020ui_story == nil then
				arg_348_1.var_.characterEffect1020ui_story = var_351_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_16 = 0.034000001847744

			if 1.96599999815226 <= arg_348_1.time_ and arg_348_1.time_ < 1.96599999815226 + var_351_16 and not isNil(var_351_15) then
				if arg_348_1.var_.characterEffect1020ui_story and not isNil(var_351_15) then
					arg_348_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_348_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_348_1.time_ - 1.96599999815226) / var_351_16)
				end
			end

			if arg_348_1.time_ >= 1.96599999815226 + var_351_16 and arg_348_1.time_ < 1.96599999815226 + var_351_16 + arg_351_0 and not isNil(var_351_15) and arg_348_1.var_.characterEffect1020ui_story then
				arg_348_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_348_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0.466666666666667 < arg_348_1.time_ and arg_348_1.time_ <= 0.466666666666667 + arg_351_0 then
				arg_348_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 1.63333333333333 < arg_348_1.time_ and arg_348_1.time_ <= 1.63333333333333 + arg_351_0 then
				arg_348_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_sea_night", "")
			end

			if arg_348_1.frameCnt_ <= 1 then
				arg_348_1.dialog_:SetActive(false)
			end

			local var_351_19 = 3.999999999999
			local var_351_20 = 0.275

			if 3.999999999999 < arg_348_1.time_ and arg_348_1.time_ <= var_351_19 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0

				arg_348_1.dialog_:SetActive(true)

				arg_348_1.dialogCg_.alpha = 0

				local var_351_21 = LeanTween.value(arg_348_1.dialog_, 0, 1, 0.3)

				var_351_21:setOnUpdate(LuaHelper.FloatAction(function(arg_352_0)
					arg_348_1.dialogCg_.alpha = arg_352_0
				end))
				var_351_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_348_1.dialog_)
					var_351_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_348_1.duration_ = arg_348_1.duration_ + 0.3

				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_22 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(1102002079).content)

				arg_348_1.text_.text = var_351_22

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_24 = 11 <= 0 and var_351_20 or var_351_20 * (utf8.len(var_351_22) / 11)

				if (11 <= 0 and var_351_20 or var_351_20 * (utf8.len(var_351_22) / 11)) > 0 and var_351_20 < var_351_24 then
					arg_348_1.talkMaxDuration = var_351_24
					var_351_19 = var_351_19 + 0.3

					if var_351_24 + var_351_19 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_24 + var_351_19
					end
				end

				arg_348_1.text_.text = var_351_22
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_25 = var_351_19 + 0.3
			local var_351_26 = math.max(var_351_20, arg_348_1.talkMaxDuration)

			if var_351_19 + 0.3 <= arg_348_1.time_ and arg_348_1.time_ < var_351_25 + var_351_26 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_25) / var_351_26

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_25 + var_351_26 and arg_348_1.time_ < var_351_25 + var_351_26 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play1102002080 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1102002080
		arg_354_1.duration_ = 5.67

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1102002081(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1020ui_story = arg_354_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_357_0 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 then
				arg_354_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_354_1.time_ - 0) / var_357_0)
				arg_354_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1020ui_story"].transform.position).z)
				arg_354_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1020ui_story"].transform.localEulerAngles = arg_354_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 then
				arg_354_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_354_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1020ui_story"].transform.position).z)
				arg_354_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1020ui_story"].transform.localEulerAngles = arg_354_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_357_1 = arg_354_1.actors_["1020ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect1020ui_story == nil then
				arg_354_1.var_.characterEffect1020ui_story = var_357_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_2 and not isNil(var_357_1) then
				if arg_354_1.var_.characterEffect1020ui_story and not isNil(var_357_1) then
					arg_354_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_2 and arg_354_1.time_ < 0 + var_357_2 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect1020ui_story then
				arg_354_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_357_4 = 0
			local var_357_5 = 0.65

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_6 = arg_354_1:GetWordFromCfg(1102002080)
				local var_357_7 = arg_354_1:FormatText(var_357_6.content)

				arg_354_1.text_.text = var_357_7

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_9 = 26 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 26)

				if (26 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 26)) > 0 and var_357_5 < var_357_9 then
					arg_354_1.talkMaxDuration = var_357_9

					if var_357_9 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_9 + var_357_4
					end
				end

				arg_354_1.text_.text = var_357_7
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002080", "story_v_side_new_1102002.awb") ~= 0 then
					local var_357_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002080", "story_v_side_new_1102002.awb") / 1000

					if var_357_10 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_4
					end

					if var_357_6.prefab_name ~= "" and arg_354_1.actors_[var_357_6.prefab_name] ~= nil then
						local var_357_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_6.prefab_name].transform, "story_v_side_new_1102002", "1102002080", "story_v_side_new_1102002.awb")

						arg_354_1:RecordAudio("1102002080", var_357_11)
						arg_354_1:RecordAudio("1102002080", var_357_11)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002080", "story_v_side_new_1102002.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002080", "story_v_side_new_1102002.awb")
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
				actorName = "1020ui_story",
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
	Play1102002081 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1102002081
		arg_358_1.duration_ = 3.2

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1102002082(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.375

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:GetWordFromCfg(1102002081)
				local var_361_2 = arg_358_1:FormatText(var_361_1.content)

				arg_358_1.text_.text = var_361_2

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_4 = 15 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 15)

				if (15 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 15)) > 0 and var_361_0 < var_361_4 then
					arg_358_1.talkMaxDuration = var_361_4

					if var_361_4 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_4 + 0
					end
				end

				arg_358_1.text_.text = var_361_2
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002081", "story_v_side_new_1102002.awb") ~= 0 then
					local var_361_5 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002081", "story_v_side_new_1102002.awb") / 1000

					if var_361_5 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + 0
					end

					if var_361_1.prefab_name ~= "" and arg_358_1.actors_[var_361_1.prefab_name] ~= nil then
						local var_361_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_1.prefab_name].transform, "story_v_side_new_1102002", "1102002081", "story_v_side_new_1102002.awb")

						arg_358_1:RecordAudio("1102002081", var_361_6)
						arg_358_1:RecordAudio("1102002081", var_361_6)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002081", "story_v_side_new_1102002.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002081", "story_v_side_new_1102002.awb")
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
	Play1102002082 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1102002082
		arg_362_1.duration_ = 2.67

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1102002083(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action5_1")
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_365_0 = 0
			local var_365_1 = 0.25

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_2 = arg_362_1:GetWordFromCfg(1102002082)
				local var_365_3 = arg_362_1:FormatText(var_365_2.content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 10 <= 0 and var_365_1 or var_365_1 * (utf8.len(var_365_3) / 10)

				if (10 <= 0 and var_365_1 or var_365_1 * (utf8.len(var_365_3) / 10)) > 0 and var_365_1 < var_365_5 then
					arg_362_1.talkMaxDuration = var_365_5

					if var_365_5 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002082", "story_v_side_new_1102002.awb") ~= 0 then
					local var_365_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002082", "story_v_side_new_1102002.awb") / 1000

					if var_365_6 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_6 + var_365_0
					end

					if var_365_2.prefab_name ~= "" and arg_362_1.actors_[var_365_2.prefab_name] ~= nil then
						local var_365_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_2.prefab_name].transform, "story_v_side_new_1102002", "1102002082", "story_v_side_new_1102002.awb")

						arg_362_1:RecordAudio("1102002082", var_365_7)
						arg_362_1:RecordAudio("1102002082", var_365_7)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002082", "story_v_side_new_1102002.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002082", "story_v_side_new_1102002.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_8 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_8 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_8

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_8 and arg_362_1.time_ < var_365_0 + var_365_8 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1102002083 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1102002083
		arg_366_1.duration_ = 7

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1102002084(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_9000

			if arg_366_1.bgs_.H04 == nil then
				local var_369_0 = Object.Instantiate(arg_366_1.paintGo_)

				var_369_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H04")
				var_369_0.name = "H04"
				var_369_0.transform.parent = arg_366_1.stage_.transform
				var_369_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_366_1.bgs_.H04 = var_369_0
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				local var_369_1 = arg_366_1.bgs_.H04

				arg_366_1.bgs_.H04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_369_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_369_2 = var_369_1:GetComponent("SpriteRenderer")

				if var_369_2 and var_369_2.sprite then
					local var_369_3 = 2 * (var_369_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_369_1.transform.localScale = Vector3.New(var_369_3 / var_369_2.sprite.bounds.size.y < var_369_3 * manager.ui.mainCameraCom_.aspect / var_369_2.sprite.bounds.size.x and var_369_3 * manager.ui.mainCameraCom_.aspect / var_369_2.sprite.bounds.size.x or var_369_3 / var_369_2.sprite.bounds.size.y, var_369_3 / var_369_2.sprite.bounds.size.y < var_369_3 * manager.ui.mainCameraCom_.aspect / var_369_2.sprite.bounds.size.x and var_369_3 * manager.ui.mainCameraCom_.aspect / var_369_2.sprite.bounds.size.x or var_369_3 / var_369_2.sprite.bounds.size.y, 0)
				end

				for iter_369_0, iter_369_1 in pairs(arg_366_1.bgs_) do
					if iter_369_0 ~= "H04" then
						iter_369_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_369_4 = 2

			if 2 < arg_366_1.time_ and arg_366_1.time_ <= var_369_4 + arg_369_0 then
				arg_366_1.allBtn_.enabled = false
			end

			if arg_366_1.time_ >= var_369_4 + 0.3 and arg_366_1.time_ < var_369_4 + 0.3 + arg_369_0 then
				arg_366_1.allBtn_.enabled = true
			end

			local var_369_5 = 0

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_5 + arg_369_0 then
				arg_366_1.mask_.enabled = true
				arg_366_1.mask_.raycastTarget = true

				arg_366_1:SetGaussion(false)
			end

			local var_369_6 = 2

			if var_369_5 <= arg_366_1.time_ and arg_366_1.time_ < var_369_5 + var_369_6 then
				local var_369_7 = Color.New(0, 0, 0)

				var_369_7.a = Mathf.Lerp(1, 0, (arg_366_1.time_ - var_369_5) / var_369_6)
				arg_366_1.mask_.color = var_369_7
			end

			if arg_366_1.time_ >= var_369_5 + var_369_6 and arg_366_1.time_ < var_369_5 + var_369_6 + arg_369_0 then
				local var_369_8 = Color.New(0, 0, 0)

				arg_366_1.mask_.enabled = false
				var_369_8.a = 0
				arg_366_1.mask_.color = var_369_8
			end

			local var_369_9 = arg_366_1.actors_["1020ui_story"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos1020ui_story = var_369_9.localPosition
			end

			local var_369_10 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_10 then
				var_369_9.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_366_1.time_ - 0) / var_369_10)
				var_369_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_369_9.position).x, (manager.ui.mainCamera.transform.position - var_369_9.position).y, (manager.ui.mainCamera.transform.position - var_369_9.position).z)
				var_369_9.localEulerAngles.z = 0
				var_369_9.localEulerAngles.x = 0
				var_369_9.localEulerAngles = var_369_9.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_10 and arg_366_1.time_ < 0 + var_369_10 + arg_369_0 then
				var_369_9.localPosition = Vector3.New(0, 100, 0)
				var_369_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_369_9.position).x, (manager.ui.mainCamera.transform.position - var_369_9.position).y, (manager.ui.mainCamera.transform.position - var_369_9.position).z)
				var_369_9.localEulerAngles.z = 0
				var_369_9.localEulerAngles.x = 0
				var_369_9.localEulerAngles = var_369_9.localEulerAngles
			end

			local var_369_11 = arg_366_1.actors_["1020ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_11) and arg_366_1.var_.characterEffect1020ui_story == nil then
				arg_366_1.var_.characterEffect1020ui_story = var_369_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_12 = 0.075

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_12 and not isNil(var_369_11) then
				if arg_366_1.var_.characterEffect1020ui_story and not isNil(var_369_11) then
					arg_366_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_12)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_12 and arg_366_1.time_ < 0 + var_369_12 + arg_369_0 and not isNil(var_369_11) and arg_366_1.var_.characterEffect1020ui_story then
				arg_366_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				local var_369_13 = arg_366_1.var_.effecthuiyi3

				if not arg_366_1.var_.effecthuiyi3 then
					var_369_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_369_13.name = "huiyi3"
					arg_366_1.var_.effecthuiyi3 = var_369_13
				else
					var_369_13.transform:SetParent(var_369_9000)
				end

				var_369_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_369_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_sea_night", "")
			end

			if 0.125 < arg_366_1.time_ and arg_366_1.time_ <= 0.125 + arg_369_0 then
				arg_366_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_amb_cheer04_loop", "")
			end

			if arg_366_1.frameCnt_ <= 1 then
				arg_366_1.dialog_:SetActive(false)
			end

			local var_369_17 = 2
			local var_369_18 = 0.075

			if 2 < arg_366_1.time_ and arg_366_1.time_ <= var_369_17 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0

				arg_366_1.dialog_:SetActive(true)

				arg_366_1.dialogCg_.alpha = 0

				local var_369_19 = LeanTween.value(arg_366_1.dialog_, 0, 1, 0.3)

				var_369_19:setOnUpdate(LuaHelper.FloatAction(function(arg_370_0)
					arg_366_1.dialogCg_.alpha = arg_370_0
				end))
				var_369_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_366_1.dialog_)
					var_369_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_366_1.duration_ = arg_366_1.duration_ + 0.3

				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_20 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(1102002083).content)

				arg_366_1.text_.text = var_369_20

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_22 = 3 <= 0 and var_369_18 or var_369_18 * (utf8.len(var_369_20) / 3)

				if (3 <= 0 and var_369_18 or var_369_18 * (utf8.len(var_369_20) / 3)) > 0 and var_369_18 < var_369_22 then
					arg_366_1.talkMaxDuration = var_369_22
					var_369_17 = var_369_17 + 0.3

					if var_369_22 + var_369_17 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_22 + var_369_17
					end
				end

				arg_366_1.text_.text = var_369_20
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_23 = var_369_17 + 0.3
			local var_369_24 = math.max(var_369_18, arg_366_1.talkMaxDuration)

			if var_369_17 + 0.3 <= arg_366_1.time_ and arg_366_1.time_ < var_369_23 + var_369_24 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_23) / var_369_24

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_23 + var_369_24 and arg_366_1.time_ < var_369_23 + var_369_24 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play1102002084 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1102002084
		arg_372_1.duration_ = 6.5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1102002085(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos1020ui_story = arg_372_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_375_0 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 then
				arg_372_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_372_1.time_ - 0) / var_375_0)
				arg_372_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1020ui_story"].transform.position).z)
				arg_372_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["1020ui_story"].transform.localEulerAngles = arg_372_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 then
				arg_372_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_372_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1020ui_story"].transform.position).z)
				arg_372_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["1020ui_story"].transform.localEulerAngles = arg_372_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_375_1 = arg_372_1.actors_["1020ui_story"]

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(var_375_1) and arg_372_1.var_.characterEffect1020ui_story == nil then
				arg_372_1.var_.characterEffect1020ui_story = var_375_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_2 and not isNil(var_375_1) then
				if arg_372_1.var_.characterEffect1020ui_story and not isNil(var_375_1) then
					arg_372_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= 0 + var_375_2 and arg_372_1.time_ < 0 + var_375_2 + arg_375_0 and not isNil(var_375_1) and arg_372_1.var_.characterEffect1020ui_story then
				arg_372_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_375_4 = 0
			local var_375_5 = 0.6

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_6 = arg_372_1:GetWordFromCfg(1102002084)
				local var_375_7 = arg_372_1:FormatText(var_375_6.content)

				arg_372_1.text_.text = var_375_7

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_9 = 24 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_7) / 24)

				if (24 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_7) / 24)) > 0 and var_375_5 < var_375_9 then
					arg_372_1.talkMaxDuration = var_375_9

					if var_375_9 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_9 + var_375_4
					end
				end

				arg_372_1.text_.text = var_375_7
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002084", "story_v_side_new_1102002.awb") ~= 0 then
					local var_375_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002084", "story_v_side_new_1102002.awb") / 1000

					if var_375_10 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_4
					end

					if var_375_6.prefab_name ~= "" and arg_372_1.actors_[var_375_6.prefab_name] ~= nil then
						local var_375_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_6.prefab_name].transform, "story_v_side_new_1102002", "1102002084", "story_v_side_new_1102002.awb")

						arg_372_1:RecordAudio("1102002084", var_375_11)
						arg_372_1:RecordAudio("1102002084", var_375_11)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002084", "story_v_side_new_1102002.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002084", "story_v_side_new_1102002.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_12 = math.max(var_375_5, arg_372_1.talkMaxDuration)

			if var_375_4 <= arg_372_1.time_ and arg_372_1.time_ < var_375_4 + var_375_12 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_4) / var_375_12

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_4 + var_375_12 and arg_372_1.time_ < var_375_4 + var_375_12 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play1102002085 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1102002085
		arg_376_1.duration_ = 5.27

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1102002086(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.375

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_1 = arg_376_1:GetWordFromCfg(1102002085)
				local var_379_2 = arg_376_1:FormatText(var_379_1.content)

				arg_376_1.text_.text = var_379_2

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 15 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 15)

				if (15 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 15)) > 0 and var_379_0 < var_379_4 then
					arg_376_1.talkMaxDuration = var_379_4

					if var_379_4 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_4 + 0
					end
				end

				arg_376_1.text_.text = var_379_2
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002085", "story_v_side_new_1102002.awb") ~= 0 then
					local var_379_5 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002085", "story_v_side_new_1102002.awb") / 1000

					if var_379_5 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + 0
					end

					if var_379_1.prefab_name ~= "" and arg_376_1.actors_[var_379_1.prefab_name] ~= nil then
						local var_379_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_1.prefab_name].transform, "story_v_side_new_1102002", "1102002085", "story_v_side_new_1102002.awb")

						arg_376_1:RecordAudio("1102002085", var_379_6)
						arg_376_1:RecordAudio("1102002085", var_379_6)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002085", "story_v_side_new_1102002.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002085", "story_v_side_new_1102002.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1102002086 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1102002086
		arg_380_1.duration_ = 5.83

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1102002087(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_383_0 = 0
			local var_383_1 = 0.5

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_2 = arg_380_1:GetWordFromCfg(1102002086)
				local var_383_3 = arg_380_1:FormatText(var_383_2.content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 20 <= 0 and var_383_1 or var_383_1 * (utf8.len(var_383_3) / 20)

				if (20 <= 0 and var_383_1 or var_383_1 * (utf8.len(var_383_3) / 20)) > 0 and var_383_1 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002086", "story_v_side_new_1102002.awb") ~= 0 then
					local var_383_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002086", "story_v_side_new_1102002.awb") / 1000

					if var_383_6 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_0
					end

					if var_383_2.prefab_name ~= "" and arg_380_1.actors_[var_383_2.prefab_name] ~= nil then
						local var_383_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_2.prefab_name].transform, "story_v_side_new_1102002", "1102002086", "story_v_side_new_1102002.awb")

						arg_380_1:RecordAudio("1102002086", var_383_7)
						arg_380_1:RecordAudio("1102002086", var_383_7)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002086", "story_v_side_new_1102002.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002086", "story_v_side_new_1102002.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_8 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_8 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_8

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_8 and arg_380_1.time_ < var_383_0 + var_383_8 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1102002087 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1102002087
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1102002088(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["1020ui_story"]) and arg_384_1.var_.characterEffect1020ui_story == nil then
				arg_384_1.var_.characterEffect1020ui_story = arg_384_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_0 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["1020ui_story"]) then
				if arg_384_1.var_.characterEffect1020ui_story and not isNil(arg_384_1.actors_["1020ui_story"]) then
					arg_384_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_384_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_384_1.time_ - 0) / var_387_0)
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["1020ui_story"]) and arg_384_1.var_.characterEffect1020ui_story then
				arg_384_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_384_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_387_1 = 0
			local var_387_2 = 0.15

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(1102002087).content)

				arg_384_1.text_.text = var_387_3

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 6 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_3) / 6)

				if (6 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_3) / 6)) > 0 and var_387_2 < var_387_5 then
					arg_384_1.talkMaxDuration = var_387_5

					if var_387_5 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + var_387_1
					end
				end

				arg_384_1.text_.text = var_387_3
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_6 = math.max(var_387_2, arg_384_1.talkMaxDuration)

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_6 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_1) / var_387_6

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_1 + var_387_6 and arg_384_1.time_ < var_387_1 + var_387_6 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1102002088 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1102002088
		arg_388_1.duration_ = 10.8

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1102002089(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 3 < arg_388_1.time_ and arg_388_1.time_ <= 3 + arg_391_0 then
				local var_391_0 = arg_388_1.bgs_.STblack

				arg_388_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_391_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_391_1 = var_391_0:GetComponent("SpriteRenderer")

				if var_391_1 and var_391_1.sprite then
					local var_391_2 = 2 * (var_391_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_391_0.transform.localScale = Vector3.New(var_391_2 / var_391_1.sprite.bounds.size.y < var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x and var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x or var_391_2 / var_391_1.sprite.bounds.size.y, var_391_2 / var_391_1.sprite.bounds.size.y < var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x and var_391_2 * manager.ui.mainCameraCom_.aspect / var_391_1.sprite.bounds.size.x or var_391_2 / var_391_1.sprite.bounds.size.y, 0)
				end

				for iter_391_0, iter_391_1 in pairs(arg_388_1.bgs_) do
					if iter_391_0 ~= "STblack" then
						iter_391_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_391_3 = 6

			if 6 < arg_388_1.time_ and arg_388_1.time_ <= var_391_3 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			if arg_388_1.time_ >= var_391_3 + 0.3 and arg_388_1.time_ < var_391_3 + 0.3 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end

			local var_391_4 = 0

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_5 = 3

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_5 then
				local var_391_6 = Color.New(0, 0, 0)

				var_391_6.a = Mathf.Lerp(0, 1, (arg_388_1.time_ - var_391_4) / var_391_5)
				arg_388_1.mask_.color = var_391_6
			end

			if arg_388_1.time_ >= var_391_4 + var_391_5 and arg_388_1.time_ < var_391_4 + var_391_5 + arg_391_0 then
				local var_391_7 = Color.New(0, 0, 0)

				var_391_7.a = 1
				arg_388_1.mask_.color = var_391_7
			end

			local var_391_8 = 3

			if 3 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_9 = 3

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_9 then
				local var_391_10 = Color.New(0, 0, 0)

				var_391_10.a = Mathf.Lerp(1, 0, (arg_388_1.time_ - var_391_8) / var_391_9)
				arg_388_1.mask_.color = var_391_10
			end

			if arg_388_1.time_ >= var_391_8 + var_391_9 and arg_388_1.time_ < var_391_8 + var_391_9 + arg_391_0 then
				local var_391_11 = Color.New(0, 0, 0)

				arg_388_1.mask_.enabled = false
				var_391_11.a = 0
				arg_388_1.mask_.color = var_391_11
			end

			local var_391_12 = arg_388_1.actors_["1020ui_story"].transform

			if 2.96599999815226 < arg_388_1.time_ and arg_388_1.time_ <= 2.96599999815226 + arg_391_0 then
				arg_388_1.var_.moveOldPos1020ui_story = var_391_12.localPosition
			end

			local var_391_13 = 0.001

			if 2.96599999815226 <= arg_388_1.time_ and arg_388_1.time_ < 2.96599999815226 + var_391_13 then
				var_391_12.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_388_1.time_ - 2.96599999815226) / var_391_13)
				var_391_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_12.position).x, (manager.ui.mainCamera.transform.position - var_391_12.position).y, (manager.ui.mainCamera.transform.position - var_391_12.position).z)
				var_391_12.localEulerAngles.z = 0
				var_391_12.localEulerAngles.x = 0
				var_391_12.localEulerAngles = var_391_12.localEulerAngles
			end

			if arg_388_1.time_ >= 2.96599999815226 + var_391_13 and arg_388_1.time_ < 2.96599999815226 + var_391_13 + arg_391_0 then
				var_391_12.localPosition = Vector3.New(0, 100, 0)
				var_391_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_12.position).x, (manager.ui.mainCamera.transform.position - var_391_12.position).y, (manager.ui.mainCamera.transform.position - var_391_12.position).z)
				var_391_12.localEulerAngles.z = 0
				var_391_12.localEulerAngles.x = 0
				var_391_12.localEulerAngles = var_391_12.localEulerAngles
			end

			if 0.633333333333333 < arg_388_1.time_ and arg_388_1.time_ <= 0.633333333333333 + arg_391_0 then
				arg_388_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_boxing_amb_cheer04_loop", "")
			end

			if 2.6 < arg_388_1.time_ and arg_388_1.time_ <= 2.6 + arg_391_0 then
				arg_388_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_rewind_loop", "")
			end

			if arg_388_1.frameCnt_ <= 1 then
				arg_388_1.dialog_:SetActive(false)
			end

			local var_391_16 = 5.8
			local var_391_17 = 0.95

			if 5.8 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				arg_388_1.dialog_:SetActive(true)

				arg_388_1.dialogCg_.alpha = 0

				local var_391_18 = LeanTween.value(arg_388_1.dialog_, 0, 1, 0.3)

				var_391_18:setOnUpdate(LuaHelper.FloatAction(function(arg_392_0)
					arg_388_1.dialogCg_.alpha = arg_392_0
				end))
				var_391_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_388_1.dialog_)
					var_391_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_388_1.duration_ = arg_388_1.duration_ + 0.3

				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_19 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(1102002088).content)

				arg_388_1.text_.text = var_391_19

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_21 = 38 <= 0 and var_391_17 or var_391_17 * (utf8.len(var_391_19) / 38)

				if (38 <= 0 and var_391_17 or var_391_17 * (utf8.len(var_391_19) / 38)) > 0 and var_391_17 < var_391_21 then
					arg_388_1.talkMaxDuration = var_391_21
					var_391_16 = var_391_16 + 0.3

					if var_391_21 + var_391_16 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_21 + var_391_16
					end
				end

				arg_388_1.text_.text = var_391_19
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_22 = var_391_16 + 0.3
			local var_391_23 = math.max(var_391_17, arg_388_1.talkMaxDuration)

			if var_391_16 + 0.3 <= arg_388_1.time_ and arg_388_1.time_ < var_391_22 + var_391_23 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_22) / var_391_23

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_22 + var_391_23 and arg_388_1.time_ < var_391_22 + var_391_23 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play1102002089 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1102002089
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1102002090(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.325

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(1102002089).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 13 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 13)

				if (13 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 13)) > 0 and var_397_0 < var_397_3 then
					arg_394_1.talkMaxDuration = var_397_3

					if var_397_3 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_3 + 0
					end
				end

				arg_394_1.text_.text = var_397_1
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_4 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_4

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1102002090 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1102002090
		arg_398_1.duration_ = 5.53

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1102002091(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1020ui_story = arg_398_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_401_0 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 then
				arg_398_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_398_1.time_ - 0) / var_401_0)
				arg_398_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1020ui_story"].transform.position).z)
				arg_398_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1020ui_story"].transform.localEulerAngles = arg_398_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 then
				arg_398_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_398_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1020ui_story"].transform.position).z)
				arg_398_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1020ui_story"].transform.localEulerAngles = arg_398_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_401_1 = arg_398_1.actors_["1020ui_story"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1020ui_story == nil then
				arg_398_1.var_.characterEffect1020ui_story = var_401_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_2 and not isNil(var_401_1) then
				if arg_398_1.var_.characterEffect1020ui_story and not isNil(var_401_1) then
					arg_398_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_2 and arg_398_1.time_ < 0 + var_401_2 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1020ui_story then
				arg_398_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_401_4 = 0
			local var_401_5 = 0.425

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_4 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0

				arg_398_1.dialog_:SetActive(true)

				arg_398_1.dialogCg_.alpha = 0

				local var_401_6 = LeanTween.value(arg_398_1.dialog_, 0, 1, 0.3)

				var_401_6:setOnUpdate(LuaHelper.FloatAction(function(arg_402_0)
					arg_398_1.dialogCg_.alpha = arg_402_0
				end))
				var_401_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_398_1.dialog_)
					var_401_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_398_1.duration_ = arg_398_1.duration_ + 0.3

				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_7 = arg_398_1:GetWordFromCfg(1102002090)
				local var_401_8 = arg_398_1:FormatText(var_401_7.content)

				arg_398_1.text_.text = var_401_8

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_10 = 17 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_8) / 17)

				if (17 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_8) / 17)) > 0 and var_401_5 < var_401_10 then
					arg_398_1.talkMaxDuration = var_401_10
					var_401_4 = var_401_4 + 0.3

					if var_401_10 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_4
					end
				end

				arg_398_1.text_.text = var_401_8
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002090", "story_v_side_new_1102002.awb") ~= 0 then
					local var_401_11 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002090", "story_v_side_new_1102002.awb") / 1000

					if var_401_11 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_11 + var_401_4
					end

					if var_401_7.prefab_name ~= "" and arg_398_1.actors_[var_401_7.prefab_name] ~= nil then
						local var_401_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_7.prefab_name].transform, "story_v_side_new_1102002", "1102002090", "story_v_side_new_1102002.awb")

						arg_398_1:RecordAudio("1102002090", var_401_12)
						arg_398_1:RecordAudio("1102002090", var_401_12)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002090", "story_v_side_new_1102002.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002090", "story_v_side_new_1102002.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_13 = var_401_4 + 0.3
			local var_401_14 = math.max(var_401_5, arg_398_1.talkMaxDuration)

			if var_401_4 + 0.3 <= arg_398_1.time_ and arg_398_1.time_ < var_401_13 + var_401_14 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_13) / var_401_14

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_13 + var_401_14 and arg_398_1.time_ < var_401_13 + var_401_14 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play1102002091 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1102002091
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1102002092(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1020ui_story = arg_404_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1020ui_story"].transform.position).z)
				arg_404_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1020ui_story"].transform.localEulerAngles = arg_404_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_404_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1020ui_story"].transform.position).z)
				arg_404_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1020ui_story"].transform.localEulerAngles = arg_404_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_407_1 = arg_404_1.actors_["1020ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1020ui_story == nil then
				arg_404_1.var_.characterEffect1020ui_story = var_407_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_2 and not isNil(var_407_1) then
				if arg_404_1.var_.characterEffect1020ui_story and not isNil(var_407_1) then
					arg_404_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_2)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_2 and arg_404_1.time_ < 0 + var_407_2 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1020ui_story then
				arg_404_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_407_3 = 0
			local var_407_4 = 0.675

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_3 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_5 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(1102002091).content)

				arg_404_1.text_.text = var_407_5

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_7 = 27 <= 0 and var_407_4 or var_407_4 * (utf8.len(var_407_5) / 27)

				if (27 <= 0 and var_407_4 or var_407_4 * (utf8.len(var_407_5) / 27)) > 0 and var_407_4 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_3 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_3
					end
				end

				arg_404_1.text_.text = var_407_5
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_8 = math.max(var_407_4, arg_404_1.talkMaxDuration)

			if var_407_3 <= arg_404_1.time_ and arg_404_1.time_ < var_407_3 + var_407_8 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_3) / var_407_8

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_3 + var_407_8 and arg_404_1.time_ < var_407_3 + var_407_8 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play1102002092 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1102002092
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1102002093(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.425

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_1 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(1102002092).content)

				arg_408_1.text_.text = var_411_1

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_3 = 17 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 17)

				if (17 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 17)) > 0 and var_411_0 < var_411_3 then
					arg_408_1.talkMaxDuration = var_411_3

					if var_411_3 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_3 + 0
					end
				end

				arg_408_1.text_.text = var_411_1
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_4 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_4

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1102002093 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1102002093
		arg_412_1.duration_ = 10.63

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1102002094(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos1020ui_story = arg_412_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_415_0 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				arg_412_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_412_1.time_ - 0) / var_415_0)
				arg_412_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).z)
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles = arg_412_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				arg_412_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_412_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1020ui_story"].transform.position).z)
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1020ui_story"].transform.localEulerAngles = arg_412_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_415_1 = arg_412_1.actors_["1020ui_story"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_1) and arg_412_1.var_.characterEffect1020ui_story == nil then
				arg_412_1.var_.characterEffect1020ui_story = var_415_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_2 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_2 and not isNil(var_415_1) then
				if arg_412_1.var_.characterEffect1020ui_story and not isNil(var_415_1) then
					arg_412_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= 0 + var_415_2 and arg_412_1.time_ < 0 + var_415_2 + arg_415_0 and not isNil(var_415_1) and arg_412_1.var_.characterEffect1020ui_story then
				arg_412_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_415_4 = 0
			local var_415_5 = 0.75

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_4 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_6 = arg_412_1:GetWordFromCfg(1102002093)
				local var_415_7 = arg_412_1:FormatText(var_415_6.content)

				arg_412_1.text_.text = var_415_7

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_9 = 30 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_7) / 30)

				if (30 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_7) / 30)) > 0 and var_415_5 < var_415_9 then
					arg_412_1.talkMaxDuration = var_415_9

					if var_415_9 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_9 + var_415_4
					end
				end

				arg_412_1.text_.text = var_415_7
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002093", "story_v_side_new_1102002.awb") ~= 0 then
					local var_415_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002093", "story_v_side_new_1102002.awb") / 1000

					if var_415_10 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_10 + var_415_4
					end

					if var_415_6.prefab_name ~= "" and arg_412_1.actors_[var_415_6.prefab_name] ~= nil then
						local var_415_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_6.prefab_name].transform, "story_v_side_new_1102002", "1102002093", "story_v_side_new_1102002.awb")

						arg_412_1:RecordAudio("1102002093", var_415_11)
						arg_412_1:RecordAudio("1102002093", var_415_11)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002093", "story_v_side_new_1102002.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002093", "story_v_side_new_1102002.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_12 = math.max(var_415_5, arg_412_1.talkMaxDuration)

			if var_415_4 <= arg_412_1.time_ and arg_412_1.time_ < var_415_4 + var_415_12 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_4) / var_415_12

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_4 + var_415_12 and arg_412_1.time_ < var_415_4 + var_415_12 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play1102002094 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1102002094
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1102002095(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos1020ui_story = arg_416_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_419_0 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 then
				arg_416_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_416_1.time_ - 0) / var_419_0)
				arg_416_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1020ui_story"].transform.position).z)
				arg_416_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["1020ui_story"].transform.localEulerAngles = arg_416_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 then
				arg_416_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_416_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1020ui_story"].transform.position).z)
				arg_416_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["1020ui_story"].transform.localEulerAngles = arg_416_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_419_1 = arg_416_1.actors_["1020ui_story"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect1020ui_story == nil then
				arg_416_1.var_.characterEffect1020ui_story = var_419_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_2 and not isNil(var_419_1) then
				if arg_416_1.var_.characterEffect1020ui_story and not isNil(var_419_1) then
					arg_416_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_416_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_416_1.time_ - 0) / var_419_2)
				end
			end

			if arg_416_1.time_ >= 0 + var_419_2 and arg_416_1.time_ < 0 + var_419_2 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect1020ui_story then
				arg_416_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_416_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_419_3 = 0
			local var_419_4 = 0.15

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_3 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_5 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(1102002094).content)

				arg_416_1.text_.text = var_419_5

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_7 = 6 <= 0 and var_419_4 or var_419_4 * (utf8.len(var_419_5) / 6)

				if (6 <= 0 and var_419_4 or var_419_4 * (utf8.len(var_419_5) / 6)) > 0 and var_419_4 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_3 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_3
					end
				end

				arg_416_1.text_.text = var_419_5
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_8 = math.max(var_419_4, arg_416_1.talkMaxDuration)

			if var_419_3 <= arg_416_1.time_ and arg_416_1.time_ < var_419_3 + var_419_8 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_3) / var_419_8

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_3 + var_419_8 and arg_416_1.time_ < var_419_3 + var_419_8 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play1102002095 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1102002095
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1102002096(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 1

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_1 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(1102002095).content)

				arg_420_1.text_.text = var_423_1

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_3 = 40 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_1) / 40)

				if (40 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_1) / 40)) > 0 and var_423_0 < var_423_3 then
					arg_420_1.talkMaxDuration = var_423_3

					if var_423_3 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_3 + 0
					end
				end

				arg_420_1.text_.text = var_423_1
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_4 = math.max(var_423_0, arg_420_1.talkMaxDuration)

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_4 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - 0) / var_423_4

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= 0 + var_423_4 and arg_420_1.time_ < 0 + var_423_4 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1102002096 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1102002096
		arg_424_1.duration_ = 8.7

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1102002097(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1020ui_story = arg_424_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_427_0 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 then
				arg_424_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_424_1.time_ - 0) / var_427_0)
				arg_424_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1020ui_story"].transform.position).z)
				arg_424_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1020ui_story"].transform.localEulerAngles = arg_424_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 then
				arg_424_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_424_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1020ui_story"].transform.position).z)
				arg_424_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1020ui_story"].transform.localEulerAngles = arg_424_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_427_1 = arg_424_1.actors_["1020ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1020ui_story == nil then
				arg_424_1.var_.characterEffect1020ui_story = var_427_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_2 and not isNil(var_427_1) then
				if arg_424_1.var_.characterEffect1020ui_story and not isNil(var_427_1) then
					arg_424_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_2 and arg_424_1.time_ < 0 + var_427_2 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1020ui_story then
				arg_424_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_427_4 = 0
			local var_427_5 = 0.9

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_4 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_6 = arg_424_1:GetWordFromCfg(1102002096)
				local var_427_7 = arg_424_1:FormatText(var_427_6.content)

				arg_424_1.text_.text = var_427_7

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_9 = 36 <= 0 and var_427_5 or var_427_5 * (utf8.len(var_427_7) / 36)

				if (36 <= 0 and var_427_5 or var_427_5 * (utf8.len(var_427_7) / 36)) > 0 and var_427_5 < var_427_9 then
					arg_424_1.talkMaxDuration = var_427_9

					if var_427_9 + var_427_4 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_9 + var_427_4
					end
				end

				arg_424_1.text_.text = var_427_7
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002096", "story_v_side_new_1102002.awb") ~= 0 then
					local var_427_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002096", "story_v_side_new_1102002.awb") / 1000

					if var_427_10 + var_427_4 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_10 + var_427_4
					end

					if var_427_6.prefab_name ~= "" and arg_424_1.actors_[var_427_6.prefab_name] ~= nil then
						local var_427_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_6.prefab_name].transform, "story_v_side_new_1102002", "1102002096", "story_v_side_new_1102002.awb")

						arg_424_1:RecordAudio("1102002096", var_427_11)
						arg_424_1:RecordAudio("1102002096", var_427_11)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002096", "story_v_side_new_1102002.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002096", "story_v_side_new_1102002.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_12 = math.max(var_427_5, arg_424_1.talkMaxDuration)

			if var_427_4 <= arg_424_1.time_ and arg_424_1.time_ < var_427_4 + var_427_12 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_4) / var_427_12

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_4 + var_427_12 and arg_424_1.time_ < var_427_4 + var_427_12 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play1102002097 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1102002097
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1102002098(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos1020ui_story = arg_428_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_431_0 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 then
				arg_428_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_428_1.time_ - 0) / var_431_0)
				arg_428_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1020ui_story"].transform.position).z)
				arg_428_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1020ui_story"].transform.localEulerAngles = arg_428_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 then
				arg_428_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_428_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1020ui_story"].transform.position).z)
				arg_428_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1020ui_story"].transform.localEulerAngles = arg_428_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_431_1 = arg_428_1.actors_["1020ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect1020ui_story == nil then
				arg_428_1.var_.characterEffect1020ui_story = var_431_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_2 and not isNil(var_431_1) then
				if arg_428_1.var_.characterEffect1020ui_story and not isNil(var_431_1) then
					arg_428_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_428_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_428_1.time_ - 0) / var_431_2)
				end
			end

			if arg_428_1.time_ >= 0 + var_431_2 and arg_428_1.time_ < 0 + var_431_2 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect1020ui_story then
				arg_428_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_428_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_431_3 = 0
			local var_431_4 = 0.15

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_3 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_5 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(1102002097).content)

				arg_428_1.text_.text = var_431_5

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_7 = 6 <= 0 and var_431_4 or var_431_4 * (utf8.len(var_431_5) / 6)

				if (6 <= 0 and var_431_4 or var_431_4 * (utf8.len(var_431_5) / 6)) > 0 and var_431_4 < var_431_7 then
					arg_428_1.talkMaxDuration = var_431_7

					if var_431_7 + var_431_3 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_3
					end
				end

				arg_428_1.text_.text = var_431_5
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_8 = math.max(var_431_4, arg_428_1.talkMaxDuration)

			if var_431_3 <= arg_428_1.time_ and arg_428_1.time_ < var_431_3 + var_431_8 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_3) / var_431_8

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_3 + var_431_8 and arg_428_1.time_ < var_431_3 + var_431_8 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play1102002098 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1102002098
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1102002099(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0.725

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_1 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(1102002098).content)

				arg_432_1.text_.text = var_435_1

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_3 = 29 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 29)

				if (29 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 29)) > 0 and var_435_0 < var_435_3 then
					arg_432_1.talkMaxDuration = var_435_3

					if var_435_3 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_3 + 0
					end
				end

				arg_432_1.text_.text = var_435_1
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_4 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_4

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1102002099 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1102002099
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1102002100(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0.25

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_1 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(1102002099).content)

				arg_436_1.text_.text = var_439_1

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_3 = 10 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 10)

				if (10 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 10)) > 0 and var_439_0 < var_439_3 then
					arg_436_1.talkMaxDuration = var_439_3

					if var_439_3 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_3 + 0
					end
				end

				arg_436_1.text_.text = var_439_1
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_4 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_4 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_4

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_4 and arg_436_1.time_ < 0 + var_439_4 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1102002100 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1102002100
		arg_440_1.duration_ = 5.67

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1102002101(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos1020ui_story = arg_440_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_443_0 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 then
				arg_440_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_440_1.time_ - 0) / var_443_0)
				arg_440_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).z)
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles = arg_440_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 then
				arg_440_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_440_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1020ui_story"].transform.position).z)
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1020ui_story"].transform.localEulerAngles = arg_440_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_443_1 = arg_440_1.actors_["1020ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1020ui_story == nil then
				arg_440_1.var_.characterEffect1020ui_story = var_443_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_2 and not isNil(var_443_1) then
				if arg_440_1.var_.characterEffect1020ui_story and not isNil(var_443_1) then
					arg_440_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_2 and arg_440_1.time_ < 0 + var_443_2 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1020ui_story then
				arg_440_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_443_4 = 0
			local var_443_5 = 0.475

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_4 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_6 = arg_440_1:GetWordFromCfg(1102002100)
				local var_443_7 = arg_440_1:FormatText(var_443_6.content)

				arg_440_1.text_.text = var_443_7

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_9 = 19 <= 0 and var_443_5 or var_443_5 * (utf8.len(var_443_7) / 19)

				if (19 <= 0 and var_443_5 or var_443_5 * (utf8.len(var_443_7) / 19)) > 0 and var_443_5 < var_443_9 then
					arg_440_1.talkMaxDuration = var_443_9

					if var_443_9 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_9 + var_443_4
					end
				end

				arg_440_1.text_.text = var_443_7
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002100", "story_v_side_new_1102002.awb") ~= 0 then
					local var_443_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002100", "story_v_side_new_1102002.awb") / 1000

					if var_443_10 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_10 + var_443_4
					end

					if var_443_6.prefab_name ~= "" and arg_440_1.actors_[var_443_6.prefab_name] ~= nil then
						local var_443_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_6.prefab_name].transform, "story_v_side_new_1102002", "1102002100", "story_v_side_new_1102002.awb")

						arg_440_1:RecordAudio("1102002100", var_443_11)
						arg_440_1:RecordAudio("1102002100", var_443_11)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002100", "story_v_side_new_1102002.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002100", "story_v_side_new_1102002.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_12 = math.max(var_443_5, arg_440_1.talkMaxDuration)

			if var_443_4 <= arg_440_1.time_ and arg_440_1.time_ < var_443_4 + var_443_12 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_4) / var_443_12

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_4 + var_443_12 and arg_440_1.time_ < var_443_4 + var_443_12 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play1102002101 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1102002101
		arg_444_1.duration_ = 1

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1102002102(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0.1

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_1 = arg_444_1:GetWordFromCfg(1102002101)
				local var_447_2 = arg_444_1:FormatText(var_447_1.content)

				arg_444_1.text_.text = var_447_2

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_4 = 4 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_2) / 4)

				if (4 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_2) / 4)) > 0 and var_447_0 < var_447_4 then
					arg_444_1.talkMaxDuration = var_447_4

					if var_447_4 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_4 + 0
					end
				end

				arg_444_1.text_.text = var_447_2
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002101", "story_v_side_new_1102002.awb") ~= 0 then
					local var_447_5 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002101", "story_v_side_new_1102002.awb") / 1000

					if var_447_5 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_5 + 0
					end

					if var_447_1.prefab_name ~= "" and arg_444_1.actors_[var_447_1.prefab_name] ~= nil then
						local var_447_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_1.prefab_name].transform, "story_v_side_new_1102002", "1102002101", "story_v_side_new_1102002.awb")

						arg_444_1:RecordAudio("1102002101", var_447_6)
						arg_444_1:RecordAudio("1102002101", var_447_6)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002101", "story_v_side_new_1102002.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002101", "story_v_side_new_1102002.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_7 = math.max(var_447_0, arg_444_1.talkMaxDuration)

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_7 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - 0) / var_447_7

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= 0 + var_447_7 and arg_444_1.time_ < 0 + var_447_7 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play1102002102 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1102002102
		arg_448_1.duration_ = 2

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1102002103(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_451_0 = 0
			local var_451_1 = 0.15

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_2 = arg_448_1:GetWordFromCfg(1102002102)
				local var_451_3 = arg_448_1:FormatText(var_451_2.content)

				arg_448_1.text_.text = var_451_3

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 6 <= 0 and var_451_1 or var_451_1 * (utf8.len(var_451_3) / 6)

				if (6 <= 0 and var_451_1 or var_451_1 * (utf8.len(var_451_3) / 6)) > 0 and var_451_1 < var_451_5 then
					arg_448_1.talkMaxDuration = var_451_5

					if var_451_5 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_3
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002102", "story_v_side_new_1102002.awb") ~= 0 then
					local var_451_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002102", "story_v_side_new_1102002.awb") / 1000

					if var_451_6 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_6 + var_451_0
					end

					if var_451_2.prefab_name ~= "" and arg_448_1.actors_[var_451_2.prefab_name] ~= nil then
						local var_451_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_2.prefab_name].transform, "story_v_side_new_1102002", "1102002102", "story_v_side_new_1102002.awb")

						arg_448_1:RecordAudio("1102002102", var_451_7)
						arg_448_1:RecordAudio("1102002102", var_451_7)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002102", "story_v_side_new_1102002.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002102", "story_v_side_new_1102002.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_8 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_8 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_8

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_8 and arg_448_1.time_ < var_451_0 + var_451_8 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1102002103 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1102002103
		arg_452_1.duration_ = 1

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"

			SetActive(arg_452_1.choicesGo_, true)

			for iter_453_0, iter_453_1 in ipairs(arg_452_1.choices_) do
				SetActive(iter_453_1.go, iter_453_0 <= 1)
			end

			arg_452_1.choices_[1].txt.text = arg_452_1:FormatText(StoryChoiceCfg[1193].name)
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1102002104(arg_452_1)
			end

			arg_452_1:RecordChoiceLog(1102002103, 1193)
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos1020ui_story = arg_452_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_455_0 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 then
				arg_452_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_452_1.time_ - 0) / var_455_0)
				arg_452_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).z)
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles = arg_452_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 then
				arg_452_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_452_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1020ui_story"].transform.position).z)
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1020ui_story"].transform.localEulerAngles = arg_452_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_455_1 = arg_452_1.actors_["1020ui_story"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_1) and arg_452_1.var_.characterEffect1020ui_story == nil then
				arg_452_1.var_.characterEffect1020ui_story = var_455_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_2 and not isNil(var_455_1) then
				if arg_452_1.var_.characterEffect1020ui_story and not isNil(var_455_1) then
					arg_452_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 0) / var_455_2)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_2 and arg_452_1.time_ < 0 + var_455_2 + arg_455_0 and not isNil(var_455_1) and arg_452_1.var_.characterEffect1020ui_story then
				arg_452_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play1102002104 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1102002104
		arg_456_1.duration_ = 6

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1102002105(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos1020ui_story = arg_456_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_459_0 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 then
				arg_456_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_456_1.time_ - 0) / var_459_0)
				arg_456_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1020ui_story"].transform.position).z)
				arg_456_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["1020ui_story"].transform.localEulerAngles = arg_456_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 then
				arg_456_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_456_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1020ui_story"].transform.position).z)
				arg_456_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["1020ui_story"].transform.localEulerAngles = arg_456_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_459_1 = arg_456_1.actors_["1020ui_story"].transform

			if 3 < arg_456_1.time_ and arg_456_1.time_ <= 3 + arg_459_0 then
				arg_456_1.var_.moveOldPos1020ui_story = var_459_1.localPosition
			end

			local var_459_2 = 0.001

			if 3 <= arg_456_1.time_ and arg_456_1.time_ < 3 + var_459_2 then
				var_459_1.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_456_1.time_ - 3) / var_459_2)
				var_459_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_459_1.position).x, (manager.ui.mainCamera.transform.position - var_459_1.position).y, (manager.ui.mainCamera.transform.position - var_459_1.position).z)
				var_459_1.localEulerAngles.z = 0
				var_459_1.localEulerAngles.x = 0
				var_459_1.localEulerAngles = var_459_1.localEulerAngles
			end

			if arg_456_1.time_ >= 3 + var_459_2 and arg_456_1.time_ < 3 + var_459_2 + arg_459_0 then
				var_459_1.localPosition = Vector3.New(0, 100, 0)
				var_459_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_459_1.position).x, (manager.ui.mainCamera.transform.position - var_459_1.position).y, (manager.ui.mainCamera.transform.position - var_459_1.position).z)
				var_459_1.localEulerAngles.z = 0
				var_459_1.localEulerAngles.x = 0
				var_459_1.localEulerAngles = var_459_1.localEulerAngles
			end

			local var_459_3 = arg_456_1.actors_["1020ui_story"]

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(var_459_3) and arg_456_1.var_.characterEffect1020ui_story == nil then
				arg_456_1.var_.characterEffect1020ui_story = var_459_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_4 = 0.2

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 and not isNil(var_459_3) then
				if arg_456_1.var_.characterEffect1020ui_story and not isNil(var_459_3) then
					arg_456_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 and not isNil(var_459_3) and arg_456_1.var_.characterEffect1020ui_story then
				arg_456_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_459_6 = 0

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_6 + arg_459_0 then
				arg_456_1.mask_.enabled = true
				arg_456_1.mask_.raycastTarget = true

				arg_456_1:SetGaussion(false)
			end

			local var_459_7 = 3

			if var_459_6 <= arg_456_1.time_ and arg_456_1.time_ < var_459_6 + var_459_7 then
				local var_459_8 = Color.New(0, 0, 0)

				var_459_8.a = Mathf.Lerp(0, 1, (arg_456_1.time_ - var_459_6) / var_459_7)
				arg_456_1.mask_.color = var_459_8
			end

			if arg_456_1.time_ >= var_459_6 + var_459_7 and arg_456_1.time_ < var_459_6 + var_459_7 + arg_459_0 then
				local var_459_9 = Color.New(0, 0, 0)

				var_459_9.a = 1
				arg_456_1.mask_.color = var_459_9
			end

			local var_459_10 = 3

			if 3 < arg_456_1.time_ and arg_456_1.time_ <= var_459_10 + arg_459_0 then
				arg_456_1.mask_.enabled = true
				arg_456_1.mask_.raycastTarget = true

				arg_456_1:SetGaussion(false)
			end

			local var_459_11 = 3

			if var_459_10 <= arg_456_1.time_ and arg_456_1.time_ < var_459_10 + var_459_11 then
				local var_459_12 = Color.New(0, 0, 0)

				var_459_12.a = Mathf.Lerp(1, 0, (arg_456_1.time_ - var_459_10) / var_459_11)
				arg_456_1.mask_.color = var_459_12
			end

			if arg_456_1.time_ >= var_459_10 + var_459_11 and arg_456_1.time_ < var_459_10 + var_459_11 + arg_459_0 then
				local var_459_13 = Color.New(0, 0, 0)

				arg_456_1.mask_.enabled = false
				var_459_13.a = 0
				arg_456_1.mask_.color = var_459_13
			end

			if 3 < arg_456_1.time_ and arg_456_1.time_ <= 3 + arg_459_0 then
				local var_459_14 = arg_456_1.bgs_.STblack

				arg_456_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_459_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_459_15 = var_459_14:GetComponent("SpriteRenderer")

				if var_459_15 and var_459_15.sprite then
					local var_459_16 = 2 * (var_459_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_459_14.transform.localScale = Vector3.New(var_459_16 / var_459_15.sprite.bounds.size.y < var_459_16 * manager.ui.mainCameraCom_.aspect / var_459_15.sprite.bounds.size.x and var_459_16 * manager.ui.mainCameraCom_.aspect / var_459_15.sprite.bounds.size.x or var_459_16 / var_459_15.sprite.bounds.size.y, var_459_16 / var_459_15.sprite.bounds.size.y < var_459_16 * manager.ui.mainCameraCom_.aspect / var_459_15.sprite.bounds.size.x and var_459_16 * manager.ui.mainCameraCom_.aspect / var_459_15.sprite.bounds.size.x or var_459_16 / var_459_15.sprite.bounds.size.y, 0)
				end

				for iter_459_0, iter_459_1 in pairs(arg_456_1.bgs_) do
					if iter_459_0 ~= "STblack" then
						iter_459_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_459_17 = 0
			local var_459_18 = 0.225

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_17 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_19 = arg_456_1:GetWordFromCfg(1102002104)
				local var_459_20 = arg_456_1:FormatText(var_459_19.content)

				arg_456_1.text_.text = var_459_20

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_22 = 9 <= 0 and var_459_18 or var_459_18 * (utf8.len(var_459_20) / 9)

				if (9 <= 0 and var_459_18 or var_459_18 * (utf8.len(var_459_20) / 9)) > 0 and var_459_18 < var_459_22 then
					arg_456_1.talkMaxDuration = var_459_22

					if var_459_22 + var_459_17 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_22 + var_459_17
					end
				end

				arg_456_1.text_.text = var_459_20
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002104", "story_v_side_new_1102002.awb") ~= 0 then
					local var_459_23 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002104", "story_v_side_new_1102002.awb") / 1000

					if var_459_23 + var_459_17 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_23 + var_459_17
					end

					if var_459_19.prefab_name ~= "" and arg_456_1.actors_[var_459_19.prefab_name] ~= nil then
						local var_459_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_19.prefab_name].transform, "story_v_side_new_1102002", "1102002104", "story_v_side_new_1102002.awb")

						arg_456_1:RecordAudio("1102002104", var_459_24)
						arg_456_1:RecordAudio("1102002104", var_459_24)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002104", "story_v_side_new_1102002.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002104", "story_v_side_new_1102002.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_25 = math.max(var_459_18, arg_456_1.talkMaxDuration)

			if var_459_17 <= arg_456_1.time_ and arg_456_1.time_ < var_459_17 + var_459_25 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_17) / var_459_25

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_17 + var_459_25 and arg_456_1.time_ < var_459_17 + var_459_25 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play1102002105 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1102002105
		arg_460_1.duration_ = 7

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1102002106(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				local var_463_0 = arg_460_1.bgs_.ST0505

				arg_460_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_463_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_463_1 = var_463_0:GetComponent("SpriteRenderer")

				if var_463_1 and var_463_1.sprite then
					local var_463_2 = 2 * (var_463_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_463_0.transform.localScale = Vector3.New(var_463_2 / var_463_1.sprite.bounds.size.y < var_463_2 * manager.ui.mainCameraCom_.aspect / var_463_1.sprite.bounds.size.x and var_463_2 * manager.ui.mainCameraCom_.aspect / var_463_1.sprite.bounds.size.x or var_463_2 / var_463_1.sprite.bounds.size.y, var_463_2 / var_463_1.sprite.bounds.size.y < var_463_2 * manager.ui.mainCameraCom_.aspect / var_463_1.sprite.bounds.size.x and var_463_2 * manager.ui.mainCameraCom_.aspect / var_463_1.sprite.bounds.size.x or var_463_2 / var_463_1.sprite.bounds.size.y, 0)
				end

				for iter_463_0, iter_463_1 in pairs(arg_460_1.bgs_) do
					if iter_463_0 ~= "ST0505" then
						iter_463_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_463_3 = 1.999999999999

			if 1.999999999999 < arg_460_1.time_ and arg_460_1.time_ <= var_463_3 + arg_463_0 then
				arg_460_1.allBtn_.enabled = false
			end

			if arg_460_1.time_ >= var_463_3 + 0.3 and arg_460_1.time_ < var_463_3 + 0.3 + arg_463_0 then
				arg_460_1.allBtn_.enabled = true
			end

			local var_463_4 = 0

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_4 + arg_463_0 then
				arg_460_1.mask_.enabled = true
				arg_460_1.mask_.raycastTarget = true

				arg_460_1:SetGaussion(false)
			end

			local var_463_5 = 2

			if var_463_4 <= arg_460_1.time_ and arg_460_1.time_ < var_463_4 + var_463_5 then
				local var_463_6 = Color.New(1, 1, 1)

				var_463_6.a = Mathf.Lerp(1, 0, (arg_460_1.time_ - var_463_4) / var_463_5)
				arg_460_1.mask_.color = var_463_6
			end

			if arg_460_1.time_ >= var_463_4 + var_463_5 and arg_460_1.time_ < var_463_4 + var_463_5 + arg_463_0 then
				local var_463_7 = Color.New(1, 1, 1)

				arg_460_1.mask_.enabled = false
				var_463_7.a = 0
				arg_460_1.mask_.color = var_463_7
			end

			local var_463_8 = manager.ui.mainCamera.transform

			if 1.999999999999 < arg_460_1.time_ and arg_460_1.time_ <= 1.999999999999 + arg_463_0 then
				arg_460_1.var_.shakeOldPos = var_463_8.localPosition
			end

			local var_463_9 = 0.5

			if 1.999999999999 <= arg_460_1.time_ and arg_460_1.time_ < 1.999999999999 + var_463_9 then
				local var_463_10, var_463_11 = math.modf((arg_460_1.time_ - 1.999999999999) / 0.066)

				var_463_8.localPosition = Vector3.New(var_463_11 * 0.13, var_463_11 * 0.13, var_463_11 * 0.13) + arg_460_1.var_.shakeOldPos
			end

			if arg_460_1.time_ >= 1.999999999999 + var_463_9 and arg_460_1.time_ < 1.999999999999 + var_463_9 + arg_463_0 then
				var_463_8.localPosition = arg_460_1.var_.shakeOldPos
			end

			local var_463_12 = 1.999999999999

			if 1.999999999999 < arg_460_1.time_ and arg_460_1.time_ <= var_463_12 + arg_463_0 then
				arg_460_1.allBtn_.enabled = false
			end

			if arg_460_1.time_ >= var_463_12 + 0.5 and arg_460_1.time_ < var_463_12 + 0.5 + arg_463_0 then
				arg_460_1.allBtn_.enabled = true
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room02", "")
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_whoosh02", "")
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_rewind_loop", "")
			end

			if arg_460_1.frameCnt_ <= 1 then
				arg_460_1.dialog_:SetActive(false)
			end

			local var_463_16 = 2
			local var_463_17 = 0.075

			if 2 < arg_460_1.time_ and arg_460_1.time_ <= var_463_16 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0

				arg_460_1.dialog_:SetActive(true)

				arg_460_1.dialogCg_.alpha = 0

				local var_463_18 = LeanTween.value(arg_460_1.dialog_, 0, 1, 0.3)

				var_463_18:setOnUpdate(LuaHelper.FloatAction(function(arg_464_0)
					arg_460_1.dialogCg_.alpha = arg_464_0
				end))
				var_463_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_460_1.dialog_)
					var_463_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_460_1.duration_ = arg_460_1.duration_ + 0.3

				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_19 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(1102002105).content)

				arg_460_1.text_.text = var_463_19

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_21 = 3 <= 0 and var_463_17 or var_463_17 * (utf8.len(var_463_19) / 3)

				if (3 <= 0 and var_463_17 or var_463_17 * (utf8.len(var_463_19) / 3)) > 0 and var_463_17 < var_463_21 then
					arg_460_1.talkMaxDuration = var_463_21
					var_463_16 = var_463_16 + 0.3

					if var_463_21 + var_463_16 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_21 + var_463_16
					end
				end

				arg_460_1.text_.text = var_463_19
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_22 = var_463_16 + 0.3
			local var_463_23 = math.max(var_463_17, arg_460_1.talkMaxDuration)

			if var_463_16 + 0.3 <= arg_460_1.time_ and arg_460_1.time_ < var_463_22 + var_463_23 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_22) / var_463_23

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_22 + var_463_23 and arg_460_1.time_ < var_463_22 + var_463_23 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1102002106 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1102002106
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1102002107(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0.625

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_1 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(1102002106).content)

				arg_466_1.text_.text = var_469_1

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_3 = 25 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_1) / 25)

				if (25 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_1) / 25)) > 0 and var_469_0 < var_469_3 then
					arg_466_1.talkMaxDuration = var_469_3

					if var_469_3 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_3 + 0
					end
				end

				arg_466_1.text_.text = var_469_1
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_4 = math.max(var_469_0, arg_466_1.talkMaxDuration)

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_4 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - 0) / var_469_4

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= 0 + var_469_4 and arg_466_1.time_ < 0 + var_469_4 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1102002107 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1102002107
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1102002108(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0.25

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_1 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(1102002107).content)

				arg_470_1.text_.text = var_473_1

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_3 = 10 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_1) / 10)

				if (10 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_1) / 10)) > 0 and var_473_0 < var_473_3 then
					arg_470_1.talkMaxDuration = var_473_3

					if var_473_3 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_3 + 0
					end
				end

				arg_470_1.text_.text = var_473_1
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_4 = math.max(var_473_0, arg_470_1.talkMaxDuration)

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_4 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - 0) / var_473_4

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= 0 + var_473_4 and arg_470_1.time_ < 0 + var_473_4 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play1102002108 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1102002108
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1102002109(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0.925

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_1 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(1102002108).content)

				arg_474_1.text_.text = var_477_1

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_3 = 37 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_1) / 37)

				if (37 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_1) / 37)) > 0 and var_477_0 < var_477_3 then
					arg_474_1.talkMaxDuration = var_477_3

					if var_477_3 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_3 + 0
					end
				end

				arg_474_1.text_.text = var_477_1
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_4 = math.max(var_477_0, arg_474_1.talkMaxDuration)

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_4 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - 0) / var_477_4

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= 0 + var_477_4 and arg_474_1.time_ < 0 + var_477_4 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play1102002109 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1102002109
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1102002110(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 1.65

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_1 = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(1102002109).content)

				arg_478_1.text_.text = var_481_1

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_3 = 66 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_1) / 66)

				if (66 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_1) / 66)) > 0 and var_481_0 < var_481_3 then
					arg_478_1.talkMaxDuration = var_481_3

					if var_481_3 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_3 + 0
					end
				end

				arg_478_1.text_.text = var_481_1
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_4 = math.max(var_481_0, arg_478_1.talkMaxDuration)

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_4 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - 0) / var_481_4

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= 0 + var_481_4 and arg_478_1.time_ < 0 + var_481_4 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play1102002110 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1102002110
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1102002111(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0.65

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_1 = arg_482_1:FormatText(arg_482_1:GetWordFromCfg(1102002110).content)

				arg_482_1.text_.text = var_485_1

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_3 = 26 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_1) / 26)

				if (26 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_1) / 26)) > 0 and var_485_0 < var_485_3 then
					arg_482_1.talkMaxDuration = var_485_3

					if var_485_3 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_3 + 0
					end
				end

				arg_482_1.text_.text = var_485_1
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_4 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_4 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_4

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_4 and arg_482_1.time_ < 0 + var_485_4 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1102002111 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1102002111
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1102002112(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0.375

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_1 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(1102002111).content)

				arg_486_1.text_.text = var_489_1

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_3 = 15 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_1) / 15)

				if (15 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_1) / 15)) > 0 and var_489_0 < var_489_3 then
					arg_486_1.talkMaxDuration = var_489_3

					if var_489_3 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_3 + 0
					end
				end

				arg_486_1.text_.text = var_489_1
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_4 = math.max(var_489_0, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_4 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - 0) / var_489_4

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_4 and arg_486_1.time_ < 0 + var_489_4 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1102002112 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1102002112
		arg_490_1.duration_ = 12.5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1102002113(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 2.00000000298023 < arg_490_1.time_ and arg_490_1.time_ <= 2.00000000298023 + arg_493_0 then
				local var_493_0 = arg_490_1.bgs_.ST12

				arg_490_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_493_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_493_1 = var_493_0:GetComponent("SpriteRenderer")

				if var_493_1 and var_493_1.sprite then
					local var_493_2 = 2 * (var_493_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_493_0.transform.localScale = Vector3.New(var_493_2 / var_493_1.sprite.bounds.size.y < var_493_2 * manager.ui.mainCameraCom_.aspect / var_493_1.sprite.bounds.size.x and var_493_2 * manager.ui.mainCameraCom_.aspect / var_493_1.sprite.bounds.size.x or var_493_2 / var_493_1.sprite.bounds.size.y, var_493_2 / var_493_1.sprite.bounds.size.y < var_493_2 * manager.ui.mainCameraCom_.aspect / var_493_1.sprite.bounds.size.x and var_493_2 * manager.ui.mainCameraCom_.aspect / var_493_1.sprite.bounds.size.x or var_493_2 / var_493_1.sprite.bounds.size.y, 0)
				end

				for iter_493_0, iter_493_1 in pairs(arg_490_1.bgs_) do
					if iter_493_0 ~= "ST12" then
						iter_493_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_493_3 = 4

			if 4 < arg_490_1.time_ and arg_490_1.time_ <= var_493_3 + arg_493_0 then
				arg_490_1.allBtn_.enabled = false
			end

			if arg_490_1.time_ >= var_493_3 + 0.3 and arg_490_1.time_ < var_493_3 + 0.3 + arg_493_0 then
				arg_490_1.allBtn_.enabled = true
			end

			local var_493_4 = 0

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_4 + arg_493_0 then
				arg_490_1.mask_.enabled = true
				arg_490_1.mask_.raycastTarget = true

				arg_490_1:SetGaussion(false)
			end

			local var_493_5 = 2

			if var_493_4 <= arg_490_1.time_ and arg_490_1.time_ < var_493_4 + var_493_5 then
				local var_493_6 = Color.New(0, 0, 0)

				var_493_6.a = Mathf.Lerp(0, 1, (arg_490_1.time_ - var_493_4) / var_493_5)
				arg_490_1.mask_.color = var_493_6
			end

			if arg_490_1.time_ >= var_493_4 + var_493_5 and arg_490_1.time_ < var_493_4 + var_493_5 + arg_493_0 then
				local var_493_7 = Color.New(0, 0, 0)

				var_493_7.a = 1
				arg_490_1.mask_.color = var_493_7
			end

			local var_493_8 = 2

			if 2 < arg_490_1.time_ and arg_490_1.time_ <= var_493_8 + arg_493_0 then
				arg_490_1.mask_.enabled = true
				arg_490_1.mask_.raycastTarget = true

				arg_490_1:SetGaussion(false)
			end

			local var_493_9 = 2

			if var_493_8 <= arg_490_1.time_ and arg_490_1.time_ < var_493_8 + var_493_9 then
				local var_493_10 = Color.New(0, 0, 0)

				var_493_10.a = Mathf.Lerp(1, 0, (arg_490_1.time_ - var_493_8) / var_493_9)
				arg_490_1.mask_.color = var_493_10
			end

			if arg_490_1.time_ >= var_493_8 + var_493_9 and arg_490_1.time_ < var_493_8 + var_493_9 + arg_493_0 then
				local var_493_11 = Color.New(0, 0, 0)

				arg_490_1.mask_.enabled = false
				var_493_11.a = 0
				arg_490_1.mask_.color = var_493_11
			end

			local var_493_12 = arg_490_1.actors_["1029ui_story"].transform

			if 3.8 < arg_490_1.time_ and arg_490_1.time_ <= 3.8 + arg_493_0 then
				arg_490_1.var_.moveOldPos1029ui_story = var_493_12.localPosition
			end

			local var_493_13 = 0.001

			if 3.8 <= arg_490_1.time_ and arg_490_1.time_ < 3.8 + var_493_13 then
				var_493_12.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_490_1.time_ - 3.8) / var_493_13)
				var_493_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_493_12.position).x, (manager.ui.mainCamera.transform.position - var_493_12.position).y, (manager.ui.mainCamera.transform.position - var_493_12.position).z)
				var_493_12.localEulerAngles.z = 0
				var_493_12.localEulerAngles.x = 0
				var_493_12.localEulerAngles = var_493_12.localEulerAngles
			end

			if arg_490_1.time_ >= 3.8 + var_493_13 and arg_490_1.time_ < 3.8 + var_493_13 + arg_493_0 then
				var_493_12.localPosition = Vector3.New(0, -1.09, -6.2)
				var_493_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_493_12.position).x, (manager.ui.mainCamera.transform.position - var_493_12.position).y, (manager.ui.mainCamera.transform.position - var_493_12.position).z)
				var_493_12.localEulerAngles.z = 0
				var_493_12.localEulerAngles.x = 0
				var_493_12.localEulerAngles = var_493_12.localEulerAngles
			end

			local var_493_14 = arg_490_1.actors_["1029ui_story"]

			if 3.8 < arg_490_1.time_ and arg_490_1.time_ <= 3.8 + arg_493_0 and not isNil(var_493_14) and arg_490_1.var_.characterEffect1029ui_story == nil then
				arg_490_1.var_.characterEffect1029ui_story = var_493_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_15 = 0.200000002980232

			if 3.8 <= arg_490_1.time_ and arg_490_1.time_ < 3.8 + var_493_15 and not isNil(var_493_14) then
				if arg_490_1.var_.characterEffect1029ui_story and not isNil(var_493_14) then
					arg_490_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= 3.8 + var_493_15 and arg_490_1.time_ < 3.8 + var_493_15 + arg_493_0 and not isNil(var_493_14) and arg_490_1.var_.characterEffect1029ui_story then
				arg_490_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 3.8 < arg_490_1.time_ and arg_490_1.time_ <= 3.8 + arg_493_0 then
				arg_490_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 3.8 < arg_490_1.time_ and arg_490_1.time_ <= 3.8 + arg_493_0 then
				arg_490_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_493_17 = 2.00000000298023

			arg_490_1.isInRecall_ = false

			if var_493_17 < arg_490_1.time_ and arg_490_1.time_ <= var_493_17 + arg_493_0 then
				arg_490_1.screenFilterGo_:SetActive(true)

				arg_490_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_493_2, iter_493_3 in pairs(arg_490_1.actors_) do
					for iter_493_4, iter_493_5 in ipairs((iter_493_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_493_5.color = iter_493_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_493_18 = 0.1

			if var_493_17 <= arg_490_1.time_ and arg_490_1.time_ < var_493_17 + var_493_18 then
				arg_490_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_490_1.time_ - var_493_17) / var_493_18)
			end

			if arg_490_1.time_ >= var_493_17 + var_493_18 and arg_490_1.time_ < var_493_17 + var_493_18 + arg_493_0 then
				arg_490_1.screenFilterEffect_.weight = 1
			end

			if 0.266666666666667 < arg_490_1.time_ and arg_490_1.time_ <= 0.266666666666667 + arg_493_0 then
				arg_490_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room02", "")
			end

			if 1.66666666666667 < arg_490_1.time_ and arg_490_1.time_ <= 1.66666666666667 + arg_493_0 then
				arg_490_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_490_1.frameCnt_ <= 1 then
				arg_490_1.dialog_:SetActive(false)
			end

			local var_493_21 = 4.00000000298023
			local var_493_22 = 0.6

			if 4.00000000298023 < arg_490_1.time_ and arg_490_1.time_ <= var_493_21 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0

				arg_490_1.dialog_:SetActive(true)

				arg_490_1.dialogCg_.alpha = 0

				local var_493_23 = LeanTween.value(arg_490_1.dialog_, 0, 1, 0.3)

				var_493_23:setOnUpdate(LuaHelper.FloatAction(function(arg_494_0)
					arg_490_1.dialogCg_.alpha = arg_494_0
				end))
				var_493_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_490_1.dialog_)
					var_493_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_490_1.duration_ = arg_490_1.duration_ + 0.3

				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_24 = arg_490_1:GetWordFromCfg(1102002112)
				local var_493_25 = arg_490_1:FormatText(var_493_24.content)

				arg_490_1.text_.text = var_493_25

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_27 = 24 <= 0 and var_493_22 or var_493_22 * (utf8.len(var_493_25) / 24)

				if (24 <= 0 and var_493_22 or var_493_22 * (utf8.len(var_493_25) / 24)) > 0 and var_493_22 < var_493_27 then
					arg_490_1.talkMaxDuration = var_493_27
					var_493_21 = var_493_21 + 0.3

					if var_493_27 + var_493_21 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_27 + var_493_21
					end
				end

				arg_490_1.text_.text = var_493_25
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002112", "story_v_side_new_1102002.awb") ~= 0 then
					local var_493_28 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002112", "story_v_side_new_1102002.awb") / 1000

					if var_493_28 + var_493_21 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_28 + var_493_21
					end

					if var_493_24.prefab_name ~= "" and arg_490_1.actors_[var_493_24.prefab_name] ~= nil then
						local var_493_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_24.prefab_name].transform, "story_v_side_new_1102002", "1102002112", "story_v_side_new_1102002.awb")

						arg_490_1:RecordAudio("1102002112", var_493_29)
						arg_490_1:RecordAudio("1102002112", var_493_29)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002112", "story_v_side_new_1102002.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002112", "story_v_side_new_1102002.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_30 = var_493_21 + 0.3
			local var_493_31 = math.max(var_493_22, arg_490_1.talkMaxDuration)

			if var_493_21 + 0.3 <= arg_490_1.time_ and arg_490_1.time_ < var_493_30 + var_493_31 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_30) / var_493_31

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_30 + var_493_31 and arg_490_1.time_ < var_493_30 + var_493_31 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play1102002113 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1102002113
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1102002114(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos1029ui_story = arg_496_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_499_0 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_0 then
				arg_496_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_496_1.time_ - 0) / var_499_0)
				arg_496_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_496_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1029ui_story"].transform.position).z)
				arg_496_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_496_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_496_1.actors_["1029ui_story"].transform.localEulerAngles = arg_496_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_496_1.time_ >= 0 + var_499_0 and arg_496_1.time_ < 0 + var_499_0 + arg_499_0 then
				arg_496_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_496_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_496_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1029ui_story"].transform.position).z)
				arg_496_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_496_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_496_1.actors_["1029ui_story"].transform.localEulerAngles = arg_496_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_499_1 = arg_496_1.actors_["1029ui_story"]

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(var_499_1) and arg_496_1.var_.characterEffect1029ui_story == nil then
				arg_496_1.var_.characterEffect1029ui_story = var_499_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_2 = 0.200000002980232

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_2 and not isNil(var_499_1) then
				if arg_496_1.var_.characterEffect1029ui_story and not isNil(var_499_1) then
					arg_496_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_496_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_496_1.time_ - 0) / var_499_2)
				end
			end

			if arg_496_1.time_ >= 0 + var_499_2 and arg_496_1.time_ < 0 + var_499_2 + arg_499_0 and not isNil(var_499_1) and arg_496_1.var_.characterEffect1029ui_story then
				arg_496_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_496_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_499_3 = 0
			local var_499_4 = 0.225

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_3 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_5 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(1102002113).content)

				arg_496_1.text_.text = var_499_5

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_7 = 9 <= 0 and var_499_4 or var_499_4 * (utf8.len(var_499_5) / 9)

				if (9 <= 0 and var_499_4 or var_499_4 * (utf8.len(var_499_5) / 9)) > 0 and var_499_4 < var_499_7 then
					arg_496_1.talkMaxDuration = var_499_7

					if var_499_7 + var_499_3 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_3
					end
				end

				arg_496_1.text_.text = var_499_5
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_8 = math.max(var_499_4, arg_496_1.talkMaxDuration)

			if var_499_3 <= arg_496_1.time_ and arg_496_1.time_ < var_499_3 + var_499_8 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_3) / var_499_8

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_3 + var_499_8 and arg_496_1.time_ < var_499_3 + var_499_8 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play1102002114 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1102002114
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1102002115(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 1.275

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_1 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(1102002114).content)

				arg_500_1.text_.text = var_503_1

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_3 = 51 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 51)

				if (51 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 51)) > 0 and var_503_0 < var_503_3 then
					arg_500_1.talkMaxDuration = var_503_3

					if var_503_3 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_3 + 0
					end
				end

				arg_500_1.text_.text = var_503_1
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_4 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_4 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_4

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_4 and arg_500_1.time_ < 0 + var_503_4 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1102002115 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1102002115
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1102002116(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 1.175

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_1 = arg_504_1:FormatText(arg_504_1:GetWordFromCfg(1102002115).content)

				arg_504_1.text_.text = var_507_1

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_3 = 47 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_1) / 47)

				if (47 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_1) / 47)) > 0 and var_507_0 < var_507_3 then
					arg_504_1.talkMaxDuration = var_507_3

					if var_507_3 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_3 + 0
					end
				end

				arg_504_1.text_.text = var_507_1
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_4 = math.max(var_507_0, arg_504_1.talkMaxDuration)

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_4 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - 0) / var_507_4

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= 0 + var_507_4 and arg_504_1.time_ < 0 + var_507_4 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1102002116 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1102002116
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1102002117(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0.475

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, false)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_1 = arg_508_1:FormatText(arg_508_1:GetWordFromCfg(1102002116).content)

				arg_508_1.text_.text = var_511_1

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_3 = 19 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_1) / 19)

				if (19 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_1) / 19)) > 0 and var_511_0 < var_511_3 then
					arg_508_1.talkMaxDuration = var_511_3

					if var_511_3 + 0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_3 + 0
					end
				end

				arg_508_1.text_.text = var_511_1
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_4 = math.max(var_511_0, arg_508_1.talkMaxDuration)

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_4 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - 0) / var_511_4

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= 0 + var_511_4 and arg_508_1.time_ < 0 + var_511_4 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1102002117 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1102002117
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play1102002118(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0.2

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, true)
				arg_512_1.iconController_:SetSelectedState("hero")

				arg_512_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_512_1.callingController_:SetSelectedState("normal")

				arg_512_1.keyicon_.color = Color.New(1, 1, 1)
				arg_512_1.icon_.color = Color.New(1, 1, 1)

				local var_515_1 = arg_512_1:FormatText(arg_512_1:GetWordFromCfg(1102002117).content)

				arg_512_1.text_.text = var_515_1

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_3 = 8 <= 0 and var_515_0 or var_515_0 * (utf8.len(var_515_1) / 8)

				if (8 <= 0 and var_515_0 or var_515_0 * (utf8.len(var_515_1) / 8)) > 0 and var_515_0 < var_515_3 then
					arg_512_1.talkMaxDuration = var_515_3

					if var_515_3 + 0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_3 + 0
					end
				end

				arg_512_1.text_.text = var_515_1
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_4 = math.max(var_515_0, arg_512_1.talkMaxDuration)

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_4 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - 0) / var_515_4

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= 0 + var_515_4 and arg_512_1.time_ < 0 + var_515_4 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1102002118 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1102002118
		arg_516_1.duration_ = 7.17

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1102002119(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 2 < arg_516_1.time_ and arg_516_1.time_ <= 2 + arg_519_0 then
				local var_519_0 = arg_516_1.bgs_.STblack

				arg_516_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_519_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_519_1 = var_519_0:GetComponent("SpriteRenderer")

				if var_519_1 and var_519_1.sprite then
					local var_519_2 = 2 * (var_519_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_519_0.transform.localScale = Vector3.New(var_519_2 / var_519_1.sprite.bounds.size.y < var_519_2 * manager.ui.mainCameraCom_.aspect / var_519_1.sprite.bounds.size.x and var_519_2 * manager.ui.mainCameraCom_.aspect / var_519_1.sprite.bounds.size.x or var_519_2 / var_519_1.sprite.bounds.size.y, var_519_2 / var_519_1.sprite.bounds.size.y < var_519_2 * manager.ui.mainCameraCom_.aspect / var_519_1.sprite.bounds.size.x and var_519_2 * manager.ui.mainCameraCom_.aspect / var_519_1.sprite.bounds.size.x or var_519_2 / var_519_1.sprite.bounds.size.y, 0)
				end

				for iter_519_0, iter_519_1 in pairs(arg_516_1.bgs_) do
					if iter_519_0 ~= "STblack" then
						iter_519_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_519_3 = 3.999999999999

			if 3.999999999999 < arg_516_1.time_ and arg_516_1.time_ <= var_519_3 + arg_519_0 then
				arg_516_1.allBtn_.enabled = false
			end

			if arg_516_1.time_ >= var_519_3 + 0.3 and arg_516_1.time_ < var_519_3 + 0.3 + arg_519_0 then
				arg_516_1.allBtn_.enabled = true
			end

			local var_519_4 = 0

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_4 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_5 = 2

			if var_519_4 <= arg_516_1.time_ and arg_516_1.time_ < var_519_4 + var_519_5 then
				local var_519_6 = Color.New(0, 0, 0)

				var_519_6.a = Mathf.Lerp(0, 1, (arg_516_1.time_ - var_519_4) / var_519_5)
				arg_516_1.mask_.color = var_519_6
			end

			if arg_516_1.time_ >= var_519_4 + var_519_5 and arg_516_1.time_ < var_519_4 + var_519_5 + arg_519_0 then
				local var_519_7 = Color.New(0, 0, 0)

				var_519_7.a = 1
				arg_516_1.mask_.color = var_519_7
			end

			local var_519_8 = 2

			if 2 < arg_516_1.time_ and arg_516_1.time_ <= var_519_8 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_9 = 2

			if var_519_8 <= arg_516_1.time_ and arg_516_1.time_ < var_519_8 + var_519_9 then
				local var_519_10 = Color.New(0, 0, 0)

				var_519_10.a = Mathf.Lerp(1, 0, (arg_516_1.time_ - var_519_8) / var_519_9)
				arg_516_1.mask_.color = var_519_10
			end

			if arg_516_1.time_ >= var_519_8 + var_519_9 and arg_516_1.time_ < var_519_8 + var_519_9 + arg_519_0 then
				local var_519_11 = Color.New(0, 0, 0)

				arg_516_1.mask_.enabled = false
				var_519_11.a = 0
				arg_516_1.mask_.color = var_519_11
			end

			local var_519_12 = arg_516_1.actors_["1020ui_story"]

			if 4 < arg_516_1.time_ and arg_516_1.time_ <= 4 + arg_519_0 and not isNil(var_519_12) and arg_516_1.var_.characterEffect1020ui_story == nil then
				arg_516_1.var_.characterEffect1020ui_story = var_519_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_13 = 0.200000002980232

			if 4 <= arg_516_1.time_ and arg_516_1.time_ < 4 + var_519_13 and not isNil(var_519_12) then
				if arg_516_1.var_.characterEffect1020ui_story and not isNil(var_519_12) then
					arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= 4 + var_519_13 and arg_516_1.time_ < 4 + var_519_13 + arg_519_0 and not isNil(var_519_12) and arg_516_1.var_.characterEffect1020ui_story then
				arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_519_15 = arg_516_1.actors_["1020ui_story"].transform

			if 3.9 < arg_516_1.time_ and arg_516_1.time_ <= 3.9 + arg_519_0 then
				arg_516_1.var_.moveOldPos1020ui_story = var_519_15.localPosition
			end

			local var_519_16 = 0.001

			if 3.9 <= arg_516_1.time_ and arg_516_1.time_ < 3.9 + var_519_16 then
				var_519_15.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_516_1.time_ - 3.9) / var_519_16)
				var_519_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_519_15.position).x, (manager.ui.mainCamera.transform.position - var_519_15.position).y, (manager.ui.mainCamera.transform.position - var_519_15.position).z)
				var_519_15.localEulerAngles.z = 0
				var_519_15.localEulerAngles.x = 0
				var_519_15.localEulerAngles = var_519_15.localEulerAngles
			end

			if arg_516_1.time_ >= 3.9 + var_519_16 and arg_516_1.time_ < 3.9 + var_519_16 + arg_519_0 then
				var_519_15.localPosition = Vector3.New(0, -0.85, -6.25)
				var_519_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_519_15.position).x, (manager.ui.mainCamera.transform.position - var_519_15.position).y, (manager.ui.mainCamera.transform.position - var_519_15.position).z)
				var_519_15.localEulerAngles.z = 0
				var_519_15.localEulerAngles.x = 0
				var_519_15.localEulerAngles = var_519_15.localEulerAngles
			end

			if 3.9 < arg_516_1.time_ and arg_516_1.time_ <= 3.9 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 3.9 < arg_516_1.time_ and arg_516_1.time_ <= 3.9 + arg_519_0 then
				arg_516_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_519_17 = arg_516_1.actors_["1020ui_story"]

			if 3.9 < arg_516_1.time_ and arg_516_1.time_ <= 3.9 + arg_519_0 and not isNil(var_519_17) and arg_516_1.var_.characterEffect1020ui_story == nil then
				arg_516_1.var_.characterEffect1020ui_story = var_519_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_18 = 0.2

			if 3.9 <= arg_516_1.time_ and arg_516_1.time_ < 3.9 + var_519_18 and not isNil(var_519_17) then
				if arg_516_1.var_.characterEffect1020ui_story and not isNil(var_519_17) then
					arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= 3.9 + var_519_18 and arg_516_1.time_ < 3.9 + var_519_18 + arg_519_0 and not isNil(var_519_17) and arg_516_1.var_.characterEffect1020ui_story then
				arg_516_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if arg_516_1.frameCnt_ <= 1 then
				arg_516_1.dialog_:SetActive(false)
			end

			local var_519_20 = 4
			local var_519_21 = 0.375

			if 4 < arg_516_1.time_ and arg_516_1.time_ <= var_519_20 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0

				arg_516_1.dialog_:SetActive(true)

				arg_516_1.dialogCg_.alpha = 0

				local var_519_22 = LeanTween.value(arg_516_1.dialog_, 0, 1, 0.3)

				var_519_22:setOnUpdate(LuaHelper.FloatAction(function(arg_520_0)
					arg_516_1.dialogCg_.alpha = arg_520_0
				end))
				var_519_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_516_1.dialog_)
					var_519_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_516_1.duration_ = arg_516_1.duration_ + 0.3

				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_23 = arg_516_1:GetWordFromCfg(1102002118)
				local var_519_24 = arg_516_1:FormatText(var_519_23.content)

				arg_516_1.text_.text = var_519_24

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_26 = 15 <= 0 and var_519_21 or var_519_21 * (utf8.len(var_519_24) / 15)

				if (15 <= 0 and var_519_21 or var_519_21 * (utf8.len(var_519_24) / 15)) > 0 and var_519_21 < var_519_26 then
					arg_516_1.talkMaxDuration = var_519_26
					var_519_20 = var_519_20 + 0.3

					if var_519_26 + var_519_20 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_26 + var_519_20
					end
				end

				arg_516_1.text_.text = var_519_24
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002118", "story_v_side_new_1102002.awb") ~= 0 then
					local var_519_27 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002118", "story_v_side_new_1102002.awb") / 1000

					if var_519_27 + var_519_20 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_27 + var_519_20
					end

					if var_519_23.prefab_name ~= "" and arg_516_1.actors_[var_519_23.prefab_name] ~= nil then
						local var_519_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_23.prefab_name].transform, "story_v_side_new_1102002", "1102002118", "story_v_side_new_1102002.awb")

						arg_516_1:RecordAudio("1102002118", var_519_28)
						arg_516_1:RecordAudio("1102002118", var_519_28)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002118", "story_v_side_new_1102002.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002118", "story_v_side_new_1102002.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_29 = var_519_20 + 0.3
			local var_519_30 = math.max(var_519_21, arg_516_1.talkMaxDuration)

			if var_519_20 + 0.3 <= arg_516_1.time_ and arg_516_1.time_ < var_519_29 + var_519_30 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_29) / var_519_30

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_29 + var_519_30 and arg_516_1.time_ < var_519_29 + var_519_30 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play1102002119 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 1102002119
		arg_522_1.duration_ = 9

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play1102002120(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 2 < arg_522_1.time_ and arg_522_1.time_ <= 2 + arg_525_0 then
				local var_525_0 = arg_522_1.bgs_.ST12

				arg_522_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_525_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_525_1 = var_525_0:GetComponent("SpriteRenderer")

				if var_525_1 and var_525_1.sprite then
					local var_525_2 = 2 * (var_525_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_525_0.transform.localScale = Vector3.New(var_525_2 / var_525_1.sprite.bounds.size.y < var_525_2 * manager.ui.mainCameraCom_.aspect / var_525_1.sprite.bounds.size.x and var_525_2 * manager.ui.mainCameraCom_.aspect / var_525_1.sprite.bounds.size.x or var_525_2 / var_525_1.sprite.bounds.size.y, var_525_2 / var_525_1.sprite.bounds.size.y < var_525_2 * manager.ui.mainCameraCom_.aspect / var_525_1.sprite.bounds.size.x and var_525_2 * manager.ui.mainCameraCom_.aspect / var_525_1.sprite.bounds.size.x or var_525_2 / var_525_1.sprite.bounds.size.y, 0)
				end

				for iter_525_0, iter_525_1 in pairs(arg_522_1.bgs_) do
					if iter_525_0 ~= "ST12" then
						iter_525_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_525_3 = 4

			if 4 < arg_522_1.time_ and arg_522_1.time_ <= var_525_3 + arg_525_0 then
				arg_522_1.allBtn_.enabled = false
			end

			if arg_522_1.time_ >= var_525_3 + 0.3 and arg_522_1.time_ < var_525_3 + 0.3 + arg_525_0 then
				arg_522_1.allBtn_.enabled = true
			end

			local var_525_4 = 0

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_4 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_5 = 2

			if var_525_4 <= arg_522_1.time_ and arg_522_1.time_ < var_525_4 + var_525_5 then
				local var_525_6 = Color.New(0, 0, 0)

				var_525_6.a = Mathf.Lerp(0, 1, (arg_522_1.time_ - var_525_4) / var_525_5)
				arg_522_1.mask_.color = var_525_6
			end

			if arg_522_1.time_ >= var_525_4 + var_525_5 and arg_522_1.time_ < var_525_4 + var_525_5 + arg_525_0 then
				local var_525_7 = Color.New(0, 0, 0)

				var_525_7.a = 1
				arg_522_1.mask_.color = var_525_7
			end

			local var_525_8 = 2

			if 2 < arg_522_1.time_ and arg_522_1.time_ <= var_525_8 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_9 = 2

			if var_525_8 <= arg_522_1.time_ and arg_522_1.time_ < var_525_8 + var_525_9 then
				local var_525_10 = Color.New(0, 0, 0)

				var_525_10.a = Mathf.Lerp(1, 0, (arg_522_1.time_ - var_525_8) / var_525_9)
				arg_522_1.mask_.color = var_525_10
			end

			if arg_522_1.time_ >= var_525_8 + var_525_9 and arg_522_1.time_ < var_525_8 + var_525_9 + arg_525_0 then
				local var_525_11 = Color.New(0, 0, 0)

				arg_522_1.mask_.enabled = false
				var_525_11.a = 0
				arg_522_1.mask_.color = var_525_11
			end

			local var_525_12 = arg_522_1.actors_["1020ui_story"]

			if 4 < arg_522_1.time_ and arg_522_1.time_ <= 4 + arg_525_0 and not isNil(var_525_12) and arg_522_1.var_.characterEffect1020ui_story == nil then
				arg_522_1.var_.characterEffect1020ui_story = var_525_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_13 = 0.200000002980232

			if 4 <= arg_522_1.time_ and arg_522_1.time_ < 4 + var_525_13 and not isNil(var_525_12) then
				if arg_522_1.var_.characterEffect1020ui_story and not isNil(var_525_12) then
					arg_522_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_522_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_522_1.time_ - 4) / var_525_13)
				end
			end

			if arg_522_1.time_ >= 4 + var_525_13 and arg_522_1.time_ < 4 + var_525_13 + arg_525_0 and not isNil(var_525_12) and arg_522_1.var_.characterEffect1020ui_story then
				arg_522_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_522_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_525_14 = arg_522_1.actors_["1020ui_story"].transform

			if 1.966 < arg_522_1.time_ and arg_522_1.time_ <= 1.966 + arg_525_0 then
				arg_522_1.var_.moveOldPos1020ui_story = var_525_14.localPosition
			end

			local var_525_15 = 0.001

			if 1.966 <= arg_522_1.time_ and arg_522_1.time_ < 1.966 + var_525_15 then
				var_525_14.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_522_1.time_ - 1.966) / var_525_15)
				var_525_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_525_14.position).x, (manager.ui.mainCamera.transform.position - var_525_14.position).y, (manager.ui.mainCamera.transform.position - var_525_14.position).z)
				var_525_14.localEulerAngles.z = 0
				var_525_14.localEulerAngles.x = 0
				var_525_14.localEulerAngles = var_525_14.localEulerAngles
			end

			if arg_522_1.time_ >= 1.966 + var_525_15 and arg_522_1.time_ < 1.966 + var_525_15 + arg_525_0 then
				var_525_14.localPosition = Vector3.New(0, 100, 0)
				var_525_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_525_14.position).x, (manager.ui.mainCamera.transform.position - var_525_14.position).y, (manager.ui.mainCamera.transform.position - var_525_14.position).z)
				var_525_14.localEulerAngles.z = 0
				var_525_14.localEulerAngles.x = 0
				var_525_14.localEulerAngles = var_525_14.localEulerAngles
			end

			if arg_522_1.frameCnt_ <= 1 then
				arg_522_1.dialog_:SetActive(false)
			end

			local var_525_16 = 4
			local var_525_17 = 0.55

			if 4 < arg_522_1.time_ and arg_522_1.time_ <= var_525_16 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0

				arg_522_1.dialog_:SetActive(true)

				arg_522_1.dialogCg_.alpha = 0

				local var_525_18 = LeanTween.value(arg_522_1.dialog_, 0, 1, 0.3)

				var_525_18:setOnUpdate(LuaHelper.FloatAction(function(arg_526_0)
					arg_522_1.dialogCg_.alpha = arg_526_0
				end))
				var_525_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_522_1.dialog_)
					var_525_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_522_1.duration_ = arg_522_1.duration_ + 0.3

				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_522_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_525_19 = arg_522_1:FormatText(arg_522_1:GetWordFromCfg(1102002119).content)

				arg_522_1.text_.text = var_525_19

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_21 = 22 <= 0 and var_525_17 or var_525_17 * (utf8.len(var_525_19) / 22)

				if (22 <= 0 and var_525_17 or var_525_17 * (utf8.len(var_525_19) / 22)) > 0 and var_525_17 < var_525_21 then
					arg_522_1.talkMaxDuration = var_525_21
					var_525_16 = var_525_16 + 0.3

					if var_525_21 + var_525_16 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_21 + var_525_16
					end
				end

				arg_522_1.text_.text = var_525_19
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_22 = var_525_16 + 0.3
			local var_525_23 = math.max(var_525_17, arg_522_1.talkMaxDuration)

			if var_525_16 + 0.3 <= arg_522_1.time_ and arg_522_1.time_ < var_525_22 + var_525_23 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_22) / var_525_23

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_22 + var_525_23 and arg_522_1.time_ < var_525_22 + var_525_23 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play1102002120 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1102002120
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1102002121(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 1.4

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_528_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_531_1 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(1102002120).content)

				arg_528_1.text_.text = var_531_1

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_3 = 56 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 56)

				if (56 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 56)) > 0 and var_531_0 < var_531_3 then
					arg_528_1.talkMaxDuration = var_531_3

					if var_531_3 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_3 + 0
					end
				end

				arg_528_1.text_.text = var_531_1
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_4 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_4

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1102002121 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1102002121
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1102002122(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.6

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_532_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_535_1 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(1102002121).content)

				arg_532_1.text_.text = var_535_1

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_3 = 24 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 24)

				if (24 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 24)) > 0 and var_535_0 < var_535_3 then
					arg_532_1.talkMaxDuration = var_535_3

					if var_535_3 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_3 + 0
					end
				end

				arg_532_1.text_.text = var_535_1
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_4 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_4

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1102002122 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1102002122
		arg_536_1.duration_ = 9

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1102002123(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 2 < arg_536_1.time_ and arg_536_1.time_ <= 2 + arg_539_0 then
				local var_539_0 = arg_536_1.bgs_.ST0505

				arg_536_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_539_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_539_1 = var_539_0:GetComponent("SpriteRenderer")

				if var_539_1 and var_539_1.sprite then
					local var_539_2 = 2 * (var_539_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_539_0.transform.localScale = Vector3.New(var_539_2 / var_539_1.sprite.bounds.size.y < var_539_2 * manager.ui.mainCameraCom_.aspect / var_539_1.sprite.bounds.size.x and var_539_2 * manager.ui.mainCameraCom_.aspect / var_539_1.sprite.bounds.size.x or var_539_2 / var_539_1.sprite.bounds.size.y, var_539_2 / var_539_1.sprite.bounds.size.y < var_539_2 * manager.ui.mainCameraCom_.aspect / var_539_1.sprite.bounds.size.x and var_539_2 * manager.ui.mainCameraCom_.aspect / var_539_1.sprite.bounds.size.x or var_539_2 / var_539_1.sprite.bounds.size.y, 0)
				end

				for iter_539_0, iter_539_1 in pairs(arg_536_1.bgs_) do
					if iter_539_0 ~= "ST0505" then
						iter_539_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_539_3 = 4

			if 4 < arg_536_1.time_ and arg_536_1.time_ <= var_539_3 + arg_539_0 then
				arg_536_1.allBtn_.enabled = false
			end

			if arg_536_1.time_ >= var_539_3 + 0.3 and arg_536_1.time_ < var_539_3 + 0.3 + arg_539_0 then
				arg_536_1.allBtn_.enabled = true
			end

			local var_539_4 = 0

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_4 + arg_539_0 then
				arg_536_1.mask_.enabled = true
				arg_536_1.mask_.raycastTarget = true

				arg_536_1:SetGaussion(false)
			end

			local var_539_5 = 2

			if var_539_4 <= arg_536_1.time_ and arg_536_1.time_ < var_539_4 + var_539_5 then
				local var_539_6 = Color.New(0, 0, 0)

				var_539_6.a = Mathf.Lerp(0, 1, (arg_536_1.time_ - var_539_4) / var_539_5)
				arg_536_1.mask_.color = var_539_6
			end

			if arg_536_1.time_ >= var_539_4 + var_539_5 and arg_536_1.time_ < var_539_4 + var_539_5 + arg_539_0 then
				local var_539_7 = Color.New(0, 0, 0)

				var_539_7.a = 1
				arg_536_1.mask_.color = var_539_7
			end

			local var_539_8 = 2

			if 2 < arg_536_1.time_ and arg_536_1.time_ <= var_539_8 + arg_539_0 then
				arg_536_1.mask_.enabled = true
				arg_536_1.mask_.raycastTarget = true

				arg_536_1:SetGaussion(false)
			end

			local var_539_9 = 2

			if var_539_8 <= arg_536_1.time_ and arg_536_1.time_ < var_539_8 + var_539_9 then
				local var_539_10 = Color.New(0, 0, 0)

				var_539_10.a = Mathf.Lerp(1, 0, (arg_536_1.time_ - var_539_8) / var_539_9)
				arg_536_1.mask_.color = var_539_10
			end

			if arg_536_1.time_ >= var_539_8 + var_539_9 and arg_536_1.time_ < var_539_8 + var_539_9 + arg_539_0 then
				local var_539_11 = Color.New(0, 0, 0)

				arg_536_1.mask_.enabled = false
				var_539_11.a = 0
				arg_536_1.mask_.color = var_539_11
			end

			local var_539_12 = 2

			arg_536_1.isInRecall_ = false

			if var_539_12 < arg_536_1.time_ and arg_536_1.time_ <= var_539_12 + arg_539_0 then
				arg_536_1.screenFilterGo_:SetActive(false)

				for iter_539_2, iter_539_3 in pairs(arg_536_1.actors_) do
					for iter_539_4, iter_539_5 in ipairs((iter_539_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_539_5.color = iter_539_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_539_13 = 0.1

			if var_539_12 <= arg_536_1.time_ and arg_536_1.time_ < var_539_12 + var_539_13 then
				arg_536_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_536_1.time_ - var_539_12) / var_539_13)
			end

			if arg_536_1.time_ >= var_539_12 + var_539_13 and arg_536_1.time_ < var_539_12 + var_539_13 + arg_539_0 then
				arg_536_1.screenFilterEffect_.weight = 0
			end

			if 0.125 < arg_536_1.time_ and arg_536_1.time_ <= 0.125 + arg_539_0 then
				arg_536_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 1.63333333333333 < arg_536_1.time_ and arg_536_1.time_ <= 1.63333333333333 + arg_539_0 then
				arg_536_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room02", "")
			end

			if arg_536_1.frameCnt_ <= 1 then
				arg_536_1.dialog_:SetActive(false)
			end

			local var_539_16 = 4
			local var_539_17 = 0.2

			if 4 < arg_536_1.time_ and arg_536_1.time_ <= var_539_16 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0

				arg_536_1.dialog_:SetActive(true)

				arg_536_1.dialogCg_.alpha = 0

				local var_539_18 = LeanTween.value(arg_536_1.dialog_, 0, 1, 0.3)

				var_539_18:setOnUpdate(LuaHelper.FloatAction(function(arg_540_0)
					arg_536_1.dialogCg_.alpha = arg_540_0
				end))
				var_539_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_536_1.dialog_)
					var_539_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_536_1.duration_ = arg_536_1.duration_ + 0.3

				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_19 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(1102002122).content)

				arg_536_1.text_.text = var_539_19

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_21 = 8 <= 0 and var_539_17 or var_539_17 * (utf8.len(var_539_19) / 8)

				if (8 <= 0 and var_539_17 or var_539_17 * (utf8.len(var_539_19) / 8)) > 0 and var_539_17 < var_539_21 then
					arg_536_1.talkMaxDuration = var_539_21
					var_539_16 = var_539_16 + 0.3

					if var_539_21 + var_539_16 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_21 + var_539_16
					end
				end

				arg_536_1.text_.text = var_539_19
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_22 = var_539_16 + 0.3
			local var_539_23 = math.max(var_539_17, arg_536_1.talkMaxDuration)

			if var_539_16 + 0.3 <= arg_536_1.time_ and arg_536_1.time_ < var_539_22 + var_539_23 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_22) / var_539_23

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_22 + var_539_23 and arg_536_1.time_ < var_539_22 + var_539_23 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play1102002123 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1102002123
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1102002124(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0.7

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, false)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_1 = arg_542_1:FormatText(arg_542_1:GetWordFromCfg(1102002123).content)

				arg_542_1.text_.text = var_545_1

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_3 = 28 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_1) / 28)

				if (28 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_1) / 28)) > 0 and var_545_0 < var_545_3 then
					arg_542_1.talkMaxDuration = var_545_3

					if var_545_3 + 0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_3 + 0
					end
				end

				arg_542_1.text_.text = var_545_1
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_4 = math.max(var_545_0, arg_542_1.talkMaxDuration)

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_4 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - 0) / var_545_4

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= 0 + var_545_4 and arg_542_1.time_ < 0 + var_545_4 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play1102002124 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 1102002124
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play1102002125(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_549_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_546_1.bgmTxt_.text ~= var_549_2 and arg_546_1.bgmTxt_.text ~= "" then
						if arg_546_1.bgmTxt2_.text ~= "" then
							arg_546_1.bgmTxt_.text = arg_546_1.bgmTxt2_.text
						end

						arg_546_1.bgmTxt2_.text = var_549_2

						arg_546_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_546_1.bgmTxt_.text = var_549_2
						arg_546_1.bgmTxt2_.text = var_549_2
					end

					if arg_546_1.bgmTimer then
						arg_546_1.bgmTimer:Stop()

						arg_546_1.bgmTimer = nil
					end

					if arg_546_1.settingData.show_music_name == 1 then
						arg_546_1.musicController:SetSelectedState("show")
						arg_546_1.musicAnimator_:Play("open", 0, 0)

						if arg_546_1.settingData.music_time ~= 0 then
							arg_546_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_546_1.settingData.music_time), function()
								if arg_546_1 == nil or isNil(arg_546_1.bgmTxt_) then
									return
								end

								arg_546_1.musicController:SetSelectedState("hide")
								arg_546_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1:AudioAction("play", "effect", "se_story_141", "se_story_141_door", "")
			end

			local var_549_4 = 0
			local var_549_5 = 0.25

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_4 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_6 = arg_546_1:FormatText(arg_546_1:GetWordFromCfg(1102002124).content)

				arg_546_1.text_.text = var_549_6

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_8 = 10 <= 0 and var_549_5 or var_549_5 * (utf8.len(var_549_6) / 10)

				if (10 <= 0 and var_549_5 or var_549_5 * (utf8.len(var_549_6) / 10)) > 0 and var_549_5 < var_549_8 then
					arg_546_1.talkMaxDuration = var_549_8

					if var_549_8 + var_549_4 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_8 + var_549_4
					end
				end

				arg_546_1.text_.text = var_549_6
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_9 = math.max(var_549_5, arg_546_1.talkMaxDuration)

			if var_549_4 <= arg_546_1.time_ and arg_546_1.time_ < var_549_4 + var_549_9 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_4) / var_549_9

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_4 + var_549_9 and arg_546_1.time_ < var_549_4 + var_549_9 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play1102002125 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1102002125
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1102002126(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_footstep", "")
			end

			local var_554_1 = 0
			local var_554_2 = 0.425

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_3 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(1102002125).content)

				arg_551_1.text_.text = var_554_3

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 17 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_3) / 17)

				if (17 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_3) / 17)) > 0 and var_554_2 < var_554_5 then
					arg_551_1.talkMaxDuration = var_554_5

					if var_554_5 + var_554_1 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_5 + var_554_1
					end
				end

				arg_551_1.text_.text = var_554_3
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_6 = math.max(var_554_2, arg_551_1.talkMaxDuration)

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_6 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_1) / var_554_6

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_1 + var_554_6 and arg_551_1.time_ < var_554_1 + var_554_6 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1102002126 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1102002126
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1102002127(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0.45

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_1 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(1102002126).content)

				arg_555_1.text_.text = var_558_1

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_3 = 18 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 18)

				if (18 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_1) / 18)) > 0 and var_558_0 < var_558_3 then
					arg_555_1.talkMaxDuration = var_558_3

					if var_558_3 + 0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_3 + 0
					end
				end

				arg_555_1.text_.text = var_558_1
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_4 = math.max(var_558_0, arg_555_1.talkMaxDuration)

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_4 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - 0) / var_558_4

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= 0 + var_558_4 and arg_555_1.time_ < 0 + var_558_4 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1102002127 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1102002127
		arg_559_1.duration_ = 5.47

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1102002128(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.var_.moveOldPos1020ui_story = arg_559_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_562_0 = 0.001

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 then
				arg_559_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_559_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_559_1.time_ - 0) / var_562_0)
				arg_559_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_559_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1020ui_story"].transform.position).z)
				arg_559_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_559_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_559_1.actors_["1020ui_story"].transform.localEulerAngles = arg_559_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 then
				arg_559_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_559_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_559_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1020ui_story"].transform.position).z)
				arg_559_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_559_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_559_1.actors_["1020ui_story"].transform.localEulerAngles = arg_559_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_562_1 = arg_559_1.actors_["1020ui_story"]

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(var_562_1) and arg_559_1.var_.characterEffect1020ui_story == nil then
				arg_559_1.var_.characterEffect1020ui_story = var_562_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_2 = 0.200000002980232

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_2 and not isNil(var_562_1) then
				if arg_559_1.var_.characterEffect1020ui_story and not isNil(var_562_1) then
					arg_559_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_559_1.time_ >= 0 + var_562_2 and arg_559_1.time_ < 0 + var_562_2 + arg_562_0 and not isNil(var_562_1) and arg_559_1.var_.characterEffect1020ui_story then
				arg_559_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_562_4 = 0
			local var_562_5 = 0.6

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_4 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_6 = arg_559_1:GetWordFromCfg(1102002127)
				local var_562_7 = arg_559_1:FormatText(var_562_6.content)

				arg_559_1.text_.text = var_562_7

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_9 = 24 <= 0 and var_562_5 or var_562_5 * (utf8.len(var_562_7) / 24)

				if (24 <= 0 and var_562_5 or var_562_5 * (utf8.len(var_562_7) / 24)) > 0 and var_562_5 < var_562_9 then
					arg_559_1.talkMaxDuration = var_562_9

					if var_562_9 + var_562_4 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_9 + var_562_4
					end
				end

				arg_559_1.text_.text = var_562_7
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002127", "story_v_side_new_1102002.awb") ~= 0 then
					local var_562_10 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002127", "story_v_side_new_1102002.awb") / 1000

					if var_562_10 + var_562_4 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_10 + var_562_4
					end

					if var_562_6.prefab_name ~= "" and arg_559_1.actors_[var_562_6.prefab_name] ~= nil then
						local var_562_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_6.prefab_name].transform, "story_v_side_new_1102002", "1102002127", "story_v_side_new_1102002.awb")

						arg_559_1:RecordAudio("1102002127", var_562_11)
						arg_559_1:RecordAudio("1102002127", var_562_11)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002127", "story_v_side_new_1102002.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002127", "story_v_side_new_1102002.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_12 = math.max(var_562_5, arg_559_1.talkMaxDuration)

			if var_562_4 <= arg_559_1.time_ and arg_559_1.time_ < var_562_4 + var_562_12 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_4) / var_562_12

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_4 + var_562_12 and arg_559_1.time_ < var_562_4 + var_562_12 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_559_1:InitPlayNodeList()
	end,
	Play1102002128 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1102002128
		arg_563_1.duration_ = 4.17

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
			arg_563_1.auto_ = false
		end

		function arg_563_1.playNext_(arg_565_0)
			arg_563_1.onStoryFinished_()
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_566_0 = 0
			local var_566_1 = 0.275

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_2 = arg_563_1:GetWordFromCfg(1102002128)
				local var_566_3 = arg_563_1:FormatText(var_566_2.content)

				arg_563_1.text_.text = var_566_3

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_5 = 11 <= 0 and var_566_1 or var_566_1 * (utf8.len(var_566_3) / 11)

				if (11 <= 0 and var_566_1 or var_566_1 * (utf8.len(var_566_3) / 11)) > 0 and var_566_1 < var_566_5 then
					arg_563_1.talkMaxDuration = var_566_5

					if var_566_5 + var_566_0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_5 + var_566_0
					end
				end

				arg_563_1.text_.text = var_566_3
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002128", "story_v_side_new_1102002.awb") ~= 0 then
					local var_566_6 = manager.audio:GetVoiceLength("story_v_side_new_1102002", "1102002128", "story_v_side_new_1102002.awb") / 1000

					if var_566_6 + var_566_0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_6 + var_566_0
					end

					if var_566_2.prefab_name ~= "" and arg_563_1.actors_[var_566_2.prefab_name] ~= nil then
						local var_566_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_2.prefab_name].transform, "story_v_side_new_1102002", "1102002128", "story_v_side_new_1102002.awb")

						arg_563_1:RecordAudio("1102002128", var_566_7)
						arg_563_1:RecordAudio("1102002128", var_566_7)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_side_new_1102002", "1102002128", "story_v_side_new_1102002.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_side_new_1102002", "1102002128", "story_v_side_new_1102002.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_8 = math.max(var_566_1, arg_563_1.talkMaxDuration)

			if var_566_0 <= arg_563_1.time_ and arg_563_1.time_ < var_566_0 + var_566_8 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_0) / var_566_8

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_0 + var_566_8 and arg_563_1.time_ < var_566_0 + var_566_8 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/L02h",
		"TextureConfig/Background/H03b",
		"TextureConfig/Background/H05",
		"TextureConfig/Background/H02",
		"TextureConfig/Background/H02a",
		"TextureConfig/Background/H04"
	},
	voices = {
		"story_v_side_new_1102002.awb"
	}
}
