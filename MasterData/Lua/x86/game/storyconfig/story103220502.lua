return {
	Play322052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322052001
		arg_1_1.duration_ = 3.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L15h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15h")
				var_4_0.name = "L15h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L15h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L15h

				arg_1_1.bgs_.L15h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L15h" then
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

			local var_4_9 = "2079ui_story"

			if arg_1_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["2079ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos2079ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.28, -5.6)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["2079ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect2079ui_story == nil then
				arg_1_1.var_.characterEffect2079ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect2079ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect2079ui_story then
				arg_1_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

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
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_battle_monster_p1", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_26 = 2
			local var_4_27 = 0.15

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[643].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(322052001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 6 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 6)

				if (6 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 6)) > 0 and var_4_27 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_26 = var_4_26 + 0.3

					if var_4_32 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052001", "story_v_out_322052.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_322052", "322052001", "story_v_out_322052.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_322052", "322052001", "story_v_out_322052.awb")

						arg_1_1:RecordAudio("322052001", var_4_34)
						arg_1_1:RecordAudio("322052001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322052", "322052001", "story_v_out_322052.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322052", "322052001", "story_v_out_322052.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = var_4_26 + 0.3
			local var_4_36 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_35) / var_4_36

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play322052002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322052002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322052003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos2079ui_story = arg_9_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).z)
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles = arg_9_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).z)
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles = arg_9_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["2079ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect2079ui_story == nil then
				arg_9_1.var_.characterEffect2079ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect2079ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_9_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect2079ui_story then
				arg_9_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_9_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_12_3 = 0
			local var_12_4 = 1.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(322052002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 43 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 43)

				if (43 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 43)) > 0 and var_12_4 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_8 and arg_9_1.time_ < var_12_3 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play322052003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322052003
		arg_13_1.duration_ = 5.37

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play322052004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_9000

			if 0.633333333333333 < arg_13_1.time_ and arg_13_1.time_ <= 0.633333333333333 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_145", "se_story_145_explosion05", "")
			end

			local var_16_1 = manager.ui.mainCamera.transform

			if 0.633333333333333 < arg_13_1.time_ and arg_13_1.time_ <= 0.633333333333333 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = var_16_1.localPosition
			end

			local var_16_2 = 0.366666666666667

			if 0.633333333333333 <= arg_13_1.time_ and arg_13_1.time_ < 0.633333333333333 + var_16_2 then
				local var_16_3, var_16_4 = math.modf((arg_13_1.time_ - 0.633333333333333) / 0.066)

				var_16_1.localPosition = Vector3.New(var_16_4 * 0.13, var_16_4 * 0.13, var_16_4 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= 0.633333333333333 + var_16_2 and arg_13_1.time_ < 0.633333333333333 + var_16_2 + arg_16_0 then
				var_16_1.localPosition = arg_13_1.var_.shakeOldPos
			end

			if 0.5 < arg_13_1.time_ and arg_13_1.time_ <= 0.5 + arg_16_0 then
				local var_16_5 = arg_13_1.var_.effect2003

				if not arg_13_1.var_.effect2003 then
					var_16_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_16_5.name = "2003"
					arg_13_1.var_.effect2003 = var_16_5
				else
					var_16_5.transform:SetParent(var_16_9000)
				end

				var_16_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_16_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.53333333333333 < arg_13_1.time_ and arg_13_1.time_ <= 3.53333333333333 + arg_16_0 then
				if arg_13_1.var_.effect2003 then
					Object.Destroy(arg_13_1.var_.effect2003)

					arg_13_1.var_.effect2003 = nil
				end
			end

			local var_16_8 = 0
			local var_16_9 = 1.05

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(322052003).content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 42 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_10) / 42)

				if (42 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_10) / 42)) > 0 and var_16_9 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_13 and arg_13_1.time_ < var_16_8 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play322052004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322052004
		arg_17_1.duration_ = 3.97

		local var_17_0 = {
			zh = 1.999999999999,
			ja = 3.966
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
				arg_17_0:Play322052005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos2079ui_story = arg_17_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).z)
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles = arg_17_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_17_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["2079ui_story"].transform.position).z)
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["2079ui_story"].transform.localEulerAngles = arg_17_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["2079ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect2079ui_story == nil then
				arg_17_1.var_.characterEffect2079ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect2079ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect2079ui_story then
				arg_17_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.733333333333333 < arg_17_1.time_ and arg_17_1.time_ <= 0.733333333333333 + arg_20_0 then
				arg_17_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_battle_monster_p1", "")
			end

			local var_20_5 = 0
			local var_20_6 = 0.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[643].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(322052004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 9 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 9)

				if (9 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 9)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052004", "story_v_out_322052.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_322052", "322052004", "story_v_out_322052.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_322052", "322052004", "story_v_out_322052.awb")

						arg_17_1:RecordAudio("322052004", var_20_12)
						arg_17_1:RecordAudio("322052004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322052", "322052004", "story_v_out_322052.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322052", "322052004", "story_v_out_322052.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_13 and arg_17_1.time_ < var_20_5 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play322052005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322052005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322052006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos2079ui_story = arg_21_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).z)
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles = arg_21_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["2079ui_story"].transform.position).z)
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["2079ui_story"].transform.localEulerAngles = arg_21_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if 0.7 < arg_21_1.time_ and arg_21_1.time_ <= 0.7 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_140", "se_story_140_synth", "")
			end

			local var_24_2 = 0
			local var_24_3 = 1.225

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(322052005).content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 49 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 49)

				if (49 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 49)) > 0 and var_24_3 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_7 and arg_21_1.time_ < var_24_2 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play322052006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322052006
		arg_25_1.duration_ = 3.7

		local var_25_0 = {
			zh = 3.4,
			ja = 3.7
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
				arg_25_0:Play322052007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["10150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10150ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "10150ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["10150ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["10150ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["10150ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["10150ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["10150ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10150ui_story = var_28_3.localPosition

				local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_3.gameObject, typeof(DynamicBoneHelper))

				if var_28_4 then
					var_28_4:EnableDynamicBone(false)
				end
			end

			local var_28_5 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_25_1.time_ - 0) / var_28_5)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles

				local var_28_6 = GameObjectTools.GetOrAddComponent(var_28_3.gameObject, typeof(DynamicBoneHelper))

				if var_28_6 then
					var_28_6:EnableDynamicBone(true)
				end
			end

			local var_28_7 = arg_25_1.actors_["10150ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect10150ui_story == nil then
				arg_25_1.var_.characterEffect10150ui_story = var_28_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_8 and not isNil(var_28_7) then
				if arg_25_1.var_.characterEffect10150ui_story and not isNil(var_28_7) then
					arg_25_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_8 and arg_25_1.time_ < 0 + var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect10150ui_story then
				arg_25_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_28_10 = 0
			local var_28_11 = 0.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
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

				local var_28_12 = arg_25_1:GetWordFromCfg(322052006)
				local var_28_13 = arg_25_1:FormatText(var_28_12.content)

				arg_25_1.text_.text = var_28_13

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 9 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 9)

				if (9 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 9)) > 0 and var_28_11 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_13
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052006", "story_v_out_322052.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_322052", "322052006", "story_v_out_322052.awb") / 1000

					if var_28_16 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_10
					end

					if var_28_12.prefab_name ~= "" and arg_25_1.actors_[var_28_12.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_12.prefab_name].transform, "story_v_out_322052", "322052006", "story_v_out_322052.awb")

						arg_25_1:RecordAudio("322052006", var_28_17)
						arg_25_1:RecordAudio("322052006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322052", "322052006", "story_v_out_322052.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322052", "322052006", "story_v_out_322052.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_10) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_10 + var_28_18 and arg_25_1.time_ < var_28_10 + var_28_18 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322052007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322052007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play322052008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "404001ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["404001ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["404001ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["404001ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["404001ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos404001ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0.8, -1.55, -5.5)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["404001ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect404001ui_story == nil then
				arg_29_1.var_.characterEffect404001ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect404001ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect404001ui_story then
				arg_29_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_32_8 = arg_29_1.actors_["10150ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.characterEffect10150ui_story == nil then
				arg_29_1.var_.characterEffect10150ui_story = var_32_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_9 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 and not isNil(var_32_8) then
				if arg_29_1.var_.characterEffect10150ui_story and not isNil(var_32_8) then
					arg_29_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_9)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.characterEffect10150ui_story then
				arg_29_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			local var_32_10 = 0
			local var_32_11 = 0.125

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_12 = arg_29_1:GetWordFromCfg(322052007)
				local var_32_13 = arg_29_1:FormatText(var_32_12.content)

				arg_29_1.text_.text = var_32_13

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 5 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 5)

				if (5 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 5)) > 0 and var_32_11 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_10
					end
				end

				arg_29_1.text_.text = var_32_13
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052007", "story_v_out_322052.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_322052", "322052007", "story_v_out_322052.awb") / 1000

					if var_32_16 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_10
					end

					if var_32_12.prefab_name ~= "" and arg_29_1.actors_[var_32_12.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_12.prefab_name].transform, "story_v_out_322052", "322052007", "story_v_out_322052.awb")

						arg_29_1:RecordAudio("322052007", var_32_17)
						arg_29_1:RecordAudio("322052007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322052", "322052007", "story_v_out_322052.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322052", "322052007", "story_v_out_322052.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_11, arg_29_1.talkMaxDuration)

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_10) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_10 + var_32_18 and arg_29_1.time_ < var_32_10 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play322052008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322052008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322052009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos404001ui_story = arg_33_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).z)
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles = arg_33_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["404001ui_story"].transform.position).z)
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["404001ui_story"].transform.localEulerAngles = arg_33_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["10150ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10150ui_story = var_36_1.localPosition

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_1.gameObject, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end
			end

			local var_36_3 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 then
				var_36_1.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_3)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 then
				var_36_1.localPosition = Vector3.New(0, 100, 0)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles

				local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_1.gameObject, typeof(DynamicBoneHelper))

				if var_36_4 then
					var_36_4:EnableDynamicBone(true)
				end
			end

			if 0.366666666666667 < arg_33_1.time_ and arg_33_1.time_ <= 0.366666666666667 + arg_36_0 then
				arg_33_1:AudioAction("play", "effect", "se_story_145", "se_story_145_tentacle", "")
			end

			local var_36_6 = manager.ui.mainCamera.transform

			if 0.366666666666667 < arg_33_1.time_ and arg_33_1.time_ <= 0.366666666666667 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_6.localPosition
			end

			local var_36_7 = 0.633333333333333

			if 0.366666666666667 <= arg_33_1.time_ and arg_33_1.time_ < 0.366666666666667 + var_36_7 then
				local var_36_8, var_36_9 = math.modf((arg_33_1.time_ - 0.366666666666667) / 0.099)

				var_36_6.localPosition = Vector3.New(var_36_9 * 0.04, var_36_9 * 0.02, var_36_9 * 0.02) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= 0.366666666666667 + var_36_7 and arg_33_1.time_ < 0.366666666666667 + var_36_7 + arg_36_0 then
				var_36_6.localPosition = arg_33_1.var_.shakeOldPos
			end

			local var_36_10 = 0
			local var_36_11 = 1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_12 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(322052008).content)

				arg_33_1.text_.text = var_36_12

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_14 = 40 <= 0 and var_36_11 or var_36_11 * (utf8.len(var_36_12) / 40)

				if (40 <= 0 and var_36_11 or var_36_11 * (utf8.len(var_36_12) / 40)) > 0 and var_36_11 < var_36_14 then
					arg_33_1.talkMaxDuration = var_36_14

					if var_36_14 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_12
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_15 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_15 and arg_33_1.time_ < var_36_10 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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
				actorName = "10150ui_story",
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
	Play322052009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322052009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play322052010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.7

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

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(322052009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 68 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 68)

				if (68 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 68)) > 0 and var_40_0 < var_40_3 then
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
	Play322052010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322052010
		arg_41_1.duration_ = 1.07

		local var_41_0 = {
			zh = 0.999999999999,
			ja = 1.066
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
				arg_41_0:Play322052011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.1

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(322052010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 4 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 4)

				if (4 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 4)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052010", "story_v_out_322052.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_322052", "322052010", "story_v_out_322052.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_322052", "322052010", "story_v_out_322052.awb")

						arg_41_1:RecordAudio("322052010", var_44_6)
						arg_41_1:RecordAudio("322052010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322052", "322052010", "story_v_out_322052.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322052", "322052010", "story_v_out_322052.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322052011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322052011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322052012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.475

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(322052011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 59 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 59)

				if (59 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 59)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322052012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322052012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322052013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.025

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(322052012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 41 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 41)

				if (41 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 41)) > 0 and var_52_0 < var_52_3 then
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
	Play322052013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322052013
		arg_53_1.duration_ = 2

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play322052014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos2079ui_story = arg_53_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).z)
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles = arg_53_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_53_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).z)
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles = arg_53_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["2079ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect2079ui_story == nil then
				arg_53_1.var_.characterEffect2079ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect2079ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect2079ui_story then
				arg_53_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_4 = 0
			local var_56_5 = 0.125

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[643].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(322052013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 5 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 5)

				if (5 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 5)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052013", "story_v_out_322052.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_322052", "322052013", "story_v_out_322052.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_322052", "322052013", "story_v_out_322052.awb")

						arg_53_1:RecordAudio("322052013", var_56_11)
						arg_53_1:RecordAudio("322052013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322052", "322052013", "story_v_out_322052.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322052", "322052013", "story_v_out_322052.awb")
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
				actorName = "2079ui_story",
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
	Play322052014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322052014
		arg_57_1.duration_ = 2.3

		local var_57_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_57_0:Play322052015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos2079ui_story = arg_57_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).z)
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles = arg_57_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["2079ui_story"].transform.position).z)
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["2079ui_story"].transform.localEulerAngles = arg_57_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_60_1 = "1284ui_story"

			if arg_57_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_60_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_57_1.stage_.transform)

				var_60_2.name = var_60_1
				var_60_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_[var_60_1] = var_60_2

				local var_60_3 = var_60_2:GetComponentInChildren(typeof(CharacterEffect))

				var_60_3.enabled = true

				local var_60_4 = GameObjectTools.GetOrAddComponent(var_60_2, typeof(DynamicBoneHelper))

				if var_60_4 then
					var_60_4:EnableDynamicBone(false)
				end

				arg_57_1:ShowWeapon(var_60_3.transform, false)

				arg_57_1.var_[var_60_1 .. "Animator"] = var_60_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_57_1.var_[var_60_1 .. "Animator"].applyRootMotion = true
				arg_57_1.var_[var_60_1 .. "LipSync"] = var_60_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_60_5 = arg_57_1.actors_["1284ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1284ui_story = var_60_5.localPosition

				arg_57_1:ShowWeapon(arg_57_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_60_6 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 then
				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_57_1.time_ - 0) / var_60_6)
				var_60_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_5.position).x, (manager.ui.mainCamera.transform.position - var_60_5.position).y, (manager.ui.mainCamera.transform.position - var_60_5.position).z)
				var_60_5.localEulerAngles.z = 0
				var_60_5.localEulerAngles.x = 0
				var_60_5.localEulerAngles = var_60_5.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(0, -0.985, -6.22)
				var_60_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_5.position).x, (manager.ui.mainCamera.transform.position - var_60_5.position).y, (manager.ui.mainCamera.transform.position - var_60_5.position).z)
				var_60_5.localEulerAngles.z = 0
				var_60_5.localEulerAngles.x = 0
				var_60_5.localEulerAngles = var_60_5.localEulerAngles
			end

			local var_60_7 = arg_57_1.actors_["1284ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.characterEffect1284ui_story == nil then
				arg_57_1.var_.characterEffect1284ui_story = var_60_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_8 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_8 and not isNil(var_60_7) then
				if arg_57_1.var_.characterEffect1284ui_story and not isNil(var_60_7) then
					arg_57_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_8 and arg_57_1.time_ < 0 + var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.characterEffect1284ui_story then
				arg_57_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_60_10 = arg_57_1.actors_["2079ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_10) and arg_57_1.var_.characterEffect2079ui_story == nil then
				arg_57_1.var_.characterEffect2079ui_story = var_60_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_11 and not isNil(var_60_10) then
				if arg_57_1.var_.characterEffect2079ui_story and not isNil(var_60_10) then
					arg_57_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_57_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_11)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_11 and arg_57_1.time_ < 0 + var_60_11 + arg_60_0 and not isNil(var_60_10) and arg_57_1.var_.characterEffect2079ui_story then
				arg_57_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_57_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_60_12 = 0
			local var_60_13 = 0.125

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_14 = arg_57_1:GetWordFromCfg(322052014)
				local var_60_15 = arg_57_1:FormatText(var_60_14.content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 5 <= 0 and var_60_13 or var_60_13 * (utf8.len(var_60_15) / 5)

				if (5 <= 0 and var_60_13 or var_60_13 * (utf8.len(var_60_15) / 5)) > 0 and var_60_13 < var_60_17 then
					arg_57_1.talkMaxDuration = var_60_17

					if var_60_17 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052014", "story_v_out_322052.awb") ~= 0 then
					local var_60_18 = manager.audio:GetVoiceLength("story_v_out_322052", "322052014", "story_v_out_322052.awb") / 1000

					if var_60_18 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_12
					end

					if var_60_14.prefab_name ~= "" and arg_57_1.actors_[var_60_14.prefab_name] ~= nil then
						local var_60_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_14.prefab_name].transform, "story_v_out_322052", "322052014", "story_v_out_322052.awb")

						arg_57_1:RecordAudio("322052014", var_60_19)
						arg_57_1:RecordAudio("322052014", var_60_19)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322052", "322052014", "story_v_out_322052.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322052", "322052014", "story_v_out_322052.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_20 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_20 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_12) / var_60_20

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_12 + var_60_20 and arg_57_1.time_ < var_60_12 + var_60_20 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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

		arg_57_1:InitPlayNodeList()
	end,
	Play322052015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322052015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play322052016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1284ui_story = arg_61_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1284ui_story"].transform.position).z)
				arg_61_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1284ui_story"].transform.localEulerAngles = arg_61_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1284ui_story"].transform.position).z)
				arg_61_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1284ui_story"].transform.localEulerAngles = arg_61_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1284ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1284ui_story == nil then
				arg_61_1.var_.characterEffect1284ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1284ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_2)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1284ui_story then
				arg_61_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0.399999999999 < arg_61_1.time_ and arg_61_1.time_ <= 0.399999999999 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_145", "se_story_145_explosion03", "")
			end

			local var_64_4 = 0
			local var_64_5 = 1.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(322052015).content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_8 = 56 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_6) / 56)

				if (56 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_6) / 56)) > 0 and var_64_5 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_9 and arg_61_1.time_ < var_64_4 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play322052016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322052016
		arg_65_1.duration_ = 5.25

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play322052017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_9000

			if 0.433333333333333 < arg_65_1.time_ and arg_65_1.time_ <= 0.433333333333333 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_17", "se_story_17_fire_loop", "")
			end

			if 0.249999999999 < arg_65_1.time_ and arg_65_1.time_ <= 0.249999999999 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_140", "se_story_140_baqin_skill02", "")
			end

			local var_68_2 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = false

				arg_65_1:SetGaussion(false)
			end

			local var_68_3 = 0.433333333333333

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_3 then
				local var_68_4 = Color.New(1, 1, 1)

				var_68_4.a = Mathf.Lerp(1, 0, (arg_65_1.time_ - var_68_2) / var_68_3)
				arg_65_1.mask_.color = var_68_4
			end

			if arg_65_1.time_ >= var_68_2 + var_68_3 and arg_65_1.time_ < var_68_2 + var_68_3 + arg_68_0 then
				local var_68_5 = Color.New(1, 1, 1)

				arg_65_1.mask_.enabled = false
				var_68_5.a = 0
				arg_65_1.mask_.color = var_68_5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				local var_68_6 = arg_65_1.var_.effect2016

				if not arg_65_1.var_.effect2016 then
					var_68_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_wasteland_in_keep"), manager.ui.mainCamera.transform)
					var_68_6.name = "2016"
					arg_65_1.var_.effect2016 = var_68_6
				else
					var_68_6.transform:SetParent(var_68_9000)
				end

				var_68_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_68_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_68_8 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_68_9 = var_68_6.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_68_0, iter_68_1 in ipairs((var_68_9:ToTable())) do
					iter_68_1.transform.localScale = Vector3.New(iter_68_1.transform.localScale.x / var_68_8 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_68_9 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_68_1.transform.localScale.y / var_68_8, iter_68_1.transform.localScale.z)
				end
			end

			if 0.1 < arg_65_1.time_ and arg_65_1.time_ <= 0.1 + arg_68_0 then
				arg_65_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_12 = 0.249999999999
			local var_68_13 = 1.35

			if 0.249999999999 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_14 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_14:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(322052016).content)

				arg_65_1.text_.text = var_68_15

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 54 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_15) / 54)

				if (54 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_15) / 54)) > 0 and var_68_13 < var_68_17 then
					arg_65_1.talkMaxDuration = var_68_17
					var_68_12 = var_68_12 + 0.3

					if var_68_17 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_15
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = var_68_12 + 0.3
			local var_68_19 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_18 + var_68_19 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_18) / var_68_19

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_18 + var_68_19 and arg_65_1.time_ < var_68_18 + var_68_19 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play322052017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322052017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play322052018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.65

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(322052017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 66 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 66)

				if (66 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 66)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play322052018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322052018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play322052019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.2

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(322052018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 48 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 48)

				if (48 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 48)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play322052019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322052019
		arg_79_1.duration_ = 1.63

		local var_79_0 = {
			zh = 1.633,
			ja = 1.6
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
				arg_79_0:Play322052020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.15

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:GetWordFromCfg(322052019)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 6 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 6)

				if (6 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 6)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052019", "story_v_out_322052.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_322052", "322052019", "story_v_out_322052.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_322052", "322052019", "story_v_out_322052.awb")

						arg_79_1:RecordAudio("322052019", var_82_6)
						arg_79_1:RecordAudio("322052019", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_322052", "322052019", "story_v_out_322052.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_322052", "322052019", "story_v_out_322052.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play322052020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322052020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play322052021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.75

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(322052020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 30 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 30)

				if (30 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 30)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play322052021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322052021
		arg_87_1.duration_ = 7

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play322052022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 2.4 < arg_87_1.time_ and arg_87_1.time_ <= 2.4 + arg_90_0 then
				arg_87_1:AudioAction("play", "effect", "se_story_143", "se_story_143_fire", "")
			end

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= 1 + arg_90_0 then
				if arg_87_1.var_.effect2016 then
					Object.Destroy(arg_87_1.var_.effect2016)

					arg_87_1.var_.effect2016 = nil
				end
			end

			local var_90_2 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_3 = 1

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_3 then
				local var_90_4 = Color.New(0, 0, 0)

				var_90_4.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - var_90_2) / var_90_3)
				arg_87_1.mask_.color = var_90_4
			end

			if arg_87_1.time_ >= var_90_2 + var_90_3 and arg_87_1.time_ < var_90_2 + var_90_3 + arg_90_0 then
				local var_90_5 = Color.New(0, 0, 0)

				var_90_5.a = 1
				arg_87_1.mask_.color = var_90_5
			end

			local var_90_6 = 1

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_7 = 1

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_7 then
				local var_90_8 = Color.New(0, 0, 0)

				var_90_8.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_6) / var_90_7)
				arg_87_1.mask_.color = var_90_8
			end

			if arg_87_1.time_ >= var_90_6 + var_90_7 and arg_87_1.time_ < var_90_6 + var_90_7 + arg_90_0 then
				local var_90_9 = Color.New(0, 0, 0)

				arg_87_1.mask_.enabled = false
				var_90_9.a = 0
				arg_87_1.mask_.color = var_90_9
			end

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= 1 + arg_90_0 then
				local var_90_10 = arg_87_1.bgs_.L15h

				arg_87_1.bgs_.L15h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_11 = var_90_10:GetComponent("SpriteRenderer")

				if var_90_11 and var_90_11.sprite then
					local var_90_12 = 2 * (var_90_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_10.transform.localScale = Vector3.New(var_90_12 / var_90_11.sprite.bounds.size.y < var_90_12 * manager.ui.mainCameraCom_.aspect / var_90_11.sprite.bounds.size.x and var_90_12 * manager.ui.mainCameraCom_.aspect / var_90_11.sprite.bounds.size.x or var_90_12 / var_90_11.sprite.bounds.size.y, var_90_12 / var_90_11.sprite.bounds.size.y < var_90_12 * manager.ui.mainCameraCom_.aspect / var_90_11.sprite.bounds.size.x and var_90_12 * manager.ui.mainCameraCom_.aspect / var_90_11.sprite.bounds.size.x or var_90_12 / var_90_11.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "L15h" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_13 = 2
			local var_90_14 = 1.725

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_15 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_15:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_16 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(322052021).content)

				arg_87_1.text_.text = var_90_16

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_18 = 69 <= 0 and var_90_14 or var_90_14 * (utf8.len(var_90_16) / 69)

				if (69 <= 0 and var_90_14 or var_90_14 * (utf8.len(var_90_16) / 69)) > 0 and var_90_14 < var_90_18 then
					arg_87_1.talkMaxDuration = var_90_18
					var_90_13 = var_90_13 + 0.3

					if var_90_18 + var_90_13 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_18 + var_90_13
					end
				end

				arg_87_1.text_.text = var_90_16
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_19 = var_90_13 + 0.3
			local var_90_20 = math.max(var_90_14, arg_87_1.talkMaxDuration)

			if var_90_13 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_19 + var_90_20 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_19) / var_90_20

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_19 + var_90_20 and arg_87_1.time_ < var_90_19 + var_90_20 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play322052022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322052022
		arg_93_1.duration_ = 4.73

		local var_93_0 = {
			zh = 2.933,
			ja = 4.733
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
				arg_93_0:Play322052023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.actors_["10152ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10152ui_story"))) then
				local var_96_0 = Object.Instantiate(Asset.Load("Char/" .. "10152ui_story"), arg_93_1.stage_.transform)

				var_96_0.name = "10152ui_story"
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["10152ui_story"] = var_96_0

				local var_96_1 = var_96_0:GetComponentInChildren(typeof(CharacterEffect))

				var_96_1.enabled = true

				local var_96_2 = GameObjectTools.GetOrAddComponent(var_96_0, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_1.transform, false)

				arg_93_1.var_["10152ui_story" .. "Animator"] = var_96_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_["10152ui_story" .. "Animator"].applyRootMotion = true
				arg_93_1.var_["10152ui_story" .. "LipSync"] = var_96_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_3 = arg_93_1.actors_["10152ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10152ui_story = var_96_3.localPosition

				local var_96_4 = GameObjectTools.GetOrAddComponent(var_96_3.gameObject, typeof(DynamicBoneHelper))

				if var_96_4 then
					var_96_4:EnableDynamicBone(false)
				end
			end

			local var_96_5 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 then
				var_96_3.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10152ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_93_1.time_ - 0) / var_96_5)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 then
				var_96_3.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles

				local var_96_6 = GameObjectTools.GetOrAddComponent(var_96_3.gameObject, typeof(DynamicBoneHelper))

				if var_96_6 then
					var_96_6:EnableDynamicBone(true)
				end
			end

			local var_96_7 = arg_93_1.actors_["10152ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.characterEffect10152ui_story == nil then
				arg_93_1.var_.characterEffect10152ui_story = var_96_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_8 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_8 and not isNil(var_96_7) then
				if arg_93_1.var_.characterEffect10152ui_story and not isNil(var_96_7) then
					arg_93_1.var_.characterEffect10152ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_8 and arg_93_1.time_ < 0 + var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.characterEffect10152ui_story then
				arg_93_1.var_.characterEffect10152ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_96_10 = 0
			local var_96_11 = 0.075

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_12 = arg_93_1:GetWordFromCfg(322052022)
				local var_96_13 = arg_93_1:FormatText(var_96_12.content)

				arg_93_1.text_.text = var_96_13

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_15 = 3 <= 0 and var_96_11 or var_96_11 * (utf8.len(var_96_13) / 3)

				if (3 <= 0 and var_96_11 or var_96_11 * (utf8.len(var_96_13) / 3)) > 0 and var_96_11 < var_96_15 then
					arg_93_1.talkMaxDuration = var_96_15

					if var_96_15 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_10
					end
				end

				arg_93_1.text_.text = var_96_13
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052022", "story_v_out_322052.awb") ~= 0 then
					local var_96_16 = manager.audio:GetVoiceLength("story_v_out_322052", "322052022", "story_v_out_322052.awb") / 1000

					if var_96_16 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_10
					end

					if var_96_12.prefab_name ~= "" and arg_93_1.actors_[var_96_12.prefab_name] ~= nil then
						local var_96_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_12.prefab_name].transform, "story_v_out_322052", "322052022", "story_v_out_322052.awb")

						arg_93_1:RecordAudio("322052022", var_96_17)
						arg_93_1:RecordAudio("322052022", var_96_17)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322052", "322052022", "story_v_out_322052.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322052", "322052022", "story_v_out_322052.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_18 = math.max(var_96_11, arg_93_1.talkMaxDuration)

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_18 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_10) / var_96_18

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_10 + var_96_18 and arg_93_1.time_ < var_96_10 + var_96_18 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10152ui_story",
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
	Play322052023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322052023
		arg_97_1.duration_ = 3.53

		local var_97_0 = {
			zh = 2.166,
			ja = 3.533
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
				arg_97_0:Play322052024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos404001ui_story = arg_97_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).z)
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles = arg_97_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_97_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["404001ui_story"].transform.position).z)
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["404001ui_story"].transform.localEulerAngles = arg_97_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["404001ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect404001ui_story == nil then
				arg_97_1.var_.characterEffect404001ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect404001ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect404001ui_story then
				arg_97_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_100_4 = arg_97_1.actors_["10152ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect10152ui_story == nil then
				arg_97_1.var_.characterEffect10152ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_5 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 and not isNil(var_100_4) then
				if arg_97_1.var_.characterEffect10152ui_story and not isNil(var_100_4) then
					arg_97_1.var_.characterEffect10152ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10152ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_5)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect10152ui_story then
				arg_97_1.var_.characterEffect10152ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10152ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_100_6 = 0
			local var_100_7 = 0.225

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
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

				local var_100_8 = arg_97_1:GetWordFromCfg(322052023)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 9 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 9)

				if (9 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 9)) > 0 and var_100_7 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052023", "story_v_out_322052.awb") ~= 0 then
					local var_100_12 = manager.audio:GetVoiceLength("story_v_out_322052", "322052023", "story_v_out_322052.awb") / 1000

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_322052", "322052023", "story_v_out_322052.awb")

						arg_97_1:RecordAudio("322052023", var_100_13)
						arg_97_1:RecordAudio("322052023", var_100_13)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_322052", "322052023", "story_v_out_322052.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_322052", "322052023", "story_v_out_322052.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
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
	Play322052024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322052024
		arg_101_1.duration_ = 6.87

		local var_101_0 = {
			zh = 4.033,
			ja = 6.866
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
				arg_101_0:Play322052025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10152ui_story = arg_101_1.actors_["10152ui_story"].transform.localPosition

				local var_104_0 = GameObjectTools.GetOrAddComponent(arg_101_1.actors_["10152ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_104_0 then
					var_104_0:EnableDynamicBone(false)
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["10152ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10152ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_101_1.time_ - 0) / var_104_1)
				arg_101_1.actors_["10152ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10152ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10152ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10152ui_story"].transform.position).z)
				arg_101_1.actors_["10152ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10152ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10152ui_story"].transform.localEulerAngles = arg_101_1.actors_["10152ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["10152ui_story"].transform.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				arg_101_1.actors_["10152ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10152ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10152ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10152ui_story"].transform.position).z)
				arg_101_1.actors_["10152ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10152ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10152ui_story"].transform.localEulerAngles = arg_101_1.actors_["10152ui_story"].transform.localEulerAngles

				local var_104_2 = GameObjectTools.GetOrAddComponent(arg_101_1.actors_["10152ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(true)
				end
			end

			local var_104_3 = arg_101_1.actors_["10152ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect10152ui_story == nil then
				arg_101_1.var_.characterEffect10152ui_story = var_104_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_4 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 and not isNil(var_104_3) then
				if arg_101_1.var_.characterEffect10152ui_story and not isNil(var_104_3) then
					arg_101_1.var_.characterEffect10152ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect10152ui_story then
				arg_101_1.var_.characterEffect10152ui_story.fillFlat = false
			end

			local var_104_6 = arg_101_1.actors_["404001ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect404001ui_story == nil then
				arg_101_1.var_.characterEffect404001ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 and not isNil(var_104_6) then
				if arg_101_1.var_.characterEffect404001ui_story and not isNil(var_104_6) then
					arg_101_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_101_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_7)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect404001ui_story then
				arg_101_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_101_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action4_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_104_8 = 0
			local var_104_9 = 0.375

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(322052024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 15 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 15)

				if (15 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 15)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052024", "story_v_out_322052.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_322052", "322052024", "story_v_out_322052.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_322052", "322052024", "story_v_out_322052.awb")

						arg_101_1:RecordAudio("322052024", var_104_15)
						arg_101_1:RecordAudio("322052024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322052", "322052024", "story_v_out_322052.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322052", "322052024", "story_v_out_322052.awb")
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
				actorName = "10152ui_story",
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
	Play322052025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322052025
		arg_105_1.duration_ = 5.13

		local var_105_0 = {
			zh = 5.133,
			ja = 3.333
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
				arg_105_0:Play322052026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["404001ui_story"]) and arg_105_1.var_.characterEffect404001ui_story == nil then
				arg_105_1.var_.characterEffect404001ui_story = arg_105_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["404001ui_story"]) then
				if arg_105_1.var_.characterEffect404001ui_story and not isNil(arg_105_1.actors_["404001ui_story"]) then
					arg_105_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["404001ui_story"]) and arg_105_1.var_.characterEffect404001ui_story then
				arg_105_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_108_2 = arg_105_1.actors_["10152ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect10152ui_story == nil then
				arg_105_1.var_.characterEffect10152ui_story = var_108_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_3 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.characterEffect10152ui_story and not isNil(var_108_2) then
					arg_105_1.var_.characterEffect10152ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10152ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_3)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect10152ui_story then
				arg_105_1.var_.characterEffect10152ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10152ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(322052025)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 16 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 16)

				if (16 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 16)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052025", "story_v_out_322052.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_322052", "322052025", "story_v_out_322052.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_322052", "322052025", "story_v_out_322052.awb")

						arg_105_1:RecordAudio("322052025", var_108_11)
						arg_105_1:RecordAudio("322052025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_322052", "322052025", "story_v_out_322052.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_322052", "322052025", "story_v_out_322052.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play322052026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322052026
		arg_109_1.duration_ = 2

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play322052027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10152ui_story"]) and arg_109_1.var_.characterEffect10152ui_story == nil then
				arg_109_1.var_.characterEffect10152ui_story = arg_109_1.actors_["10152ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10152ui_story"]) then
				if arg_109_1.var_.characterEffect10152ui_story and not isNil(arg_109_1.actors_["10152ui_story"]) then
					arg_109_1.var_.characterEffect10152ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10152ui_story"]) and arg_109_1.var_.characterEffect10152ui_story then
				arg_109_1.var_.characterEffect10152ui_story.fillFlat = false
			end

			local var_112_2 = arg_109_1.actors_["404001ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect404001ui_story == nil then
				arg_109_1.var_.characterEffect404001ui_story = var_112_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_3 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.characterEffect404001ui_story and not isNil(var_112_2) then
					arg_109_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_109_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_3)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect404001ui_story then
				arg_109_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_109_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action4_2")
			end

			local var_112_4 = 0
			local var_112_5 = 0.075

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(322052026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 3 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 3)

				if (3 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 3)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052026", "story_v_out_322052.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_322052", "322052026", "story_v_out_322052.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_322052", "322052026", "story_v_out_322052.awb")

						arg_109_1:RecordAudio("322052026", var_112_11)
						arg_109_1:RecordAudio("322052026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322052", "322052026", "story_v_out_322052.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322052", "322052026", "story_v_out_322052.awb")
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
	Play322052027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322052027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322052028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10152ui_story = arg_113_1.actors_["10152ui_story"].transform.localPosition

				local var_116_0 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["10152ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_0 then
					var_116_0:EnableDynamicBone(false)
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10152ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10152ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_1)
				arg_113_1.actors_["10152ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10152ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10152ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10152ui_story"].transform.position).z)
				arg_113_1.actors_["10152ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10152ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10152ui_story"].transform.localEulerAngles = arg_113_1.actors_["10152ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10152ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["10152ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10152ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10152ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10152ui_story"].transform.position).z)
				arg_113_1.actors_["10152ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10152ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10152ui_story"].transform.localEulerAngles = arg_113_1.actors_["10152ui_story"].transform.localEulerAngles

				local var_116_2 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["10152ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(true)
				end
			end

			local var_116_3 = arg_113_1.actors_["404001ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos404001ui_story = var_116_3.localPosition
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_4)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0, 100, 0)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			local var_116_5 = 0
			local var_116_6 = 0.775

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(322052027).content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 31 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_7) / 31)

				if (31 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_7) / 31)) > 0 and var_116_6 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_6, arg_113_1.talkMaxDuration)

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_5) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_5 + var_116_10 and arg_113_1.time_ < var_116_5 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10152ui_story",
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

		arg_113_1:InitPlayNodeList()
	end,
	Play322052028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322052028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322052029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.1

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

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(322052028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 44 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 44)

				if (44 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 44)) > 0 and var_120_0 < var_120_3 then
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
	Play322052029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322052029
		arg_121_1.duration_ = 3.2

		local var_121_0 = {
			zh = 3.2,
			ja = 2.6
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
				arg_121_0:Play322052030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_124_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_121_1.bgmTxt_.text ~= var_124_2 and arg_121_1.bgmTxt_.text ~= "" then
						if arg_121_1.bgmTxt2_.text ~= "" then
							arg_121_1.bgmTxt_.text = arg_121_1.bgmTxt2_.text
						end

						arg_121_1.bgmTxt2_.text = var_124_2

						arg_121_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_121_1.bgmTxt_.text = var_124_2
						arg_121_1.bgmTxt2_.text = var_124_2
					end

					if arg_121_1.bgmTimer then
						arg_121_1.bgmTimer:Stop()

						arg_121_1.bgmTimer = nil
					end

					if arg_121_1.settingData.show_music_name == 1 then
						arg_121_1.musicController:SetSelectedState("show")
						arg_121_1.musicAnimator_:Play("open", 0, 0)

						if arg_121_1.settingData.music_time ~= 0 then
							arg_121_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_121_1.settingData.music_time), function()
								if arg_121_1 == nil or isNil(arg_121_1.bgmTxt_) then
									return
								end

								arg_121_1.musicController:SetSelectedState("hide")
								arg_121_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_121_1.time_ and arg_121_1.time_ <= 1 + arg_124_0 then
				arg_121_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion01", "")
			end

			if 1.1 < arg_121_1.time_ and arg_121_1.time_ <= 1.1 + arg_124_0 then
				arg_121_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_mix", "")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:AudioAction("stop", "effect", "se_story_17", "se_story_17_fire_loop", "")
			end

			local var_124_6 = 0
			local var_124_7 = 0.225

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_8 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_8:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_121_1.dialogCg_.alpha = arg_126_0
				end))
				var_124_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_9 = arg_121_1:GetWordFromCfg(322052029)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_12 = 9 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_10) / 9)

				if (9 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_10) / 9)) > 0 and var_124_7 < var_124_12 then
					arg_121_1.talkMaxDuration = var_124_12
					var_124_6 = var_124_6 + 0.3

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052029", "story_v_out_322052.awb") ~= 0 then
					local var_124_13 = manager.audio:GetVoiceLength("story_v_out_322052", "322052029", "story_v_out_322052.awb") / 1000

					if var_124_13 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_6
					end

					if var_124_9.prefab_name ~= "" and arg_121_1.actors_[var_124_9.prefab_name] ~= nil then
						local var_124_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_9.prefab_name].transform, "story_v_out_322052", "322052029", "story_v_out_322052.awb")

						arg_121_1:RecordAudio("322052029", var_124_14)
						arg_121_1:RecordAudio("322052029", var_124_14)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322052", "322052029", "story_v_out_322052.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322052", "322052029", "story_v_out_322052.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_15 = var_124_6 + 0.3
			local var_124_16 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_16 and arg_121_1.time_ < var_124_15 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play322052030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322052030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play322052031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos404001ui_story = arg_128_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["404001ui_story"].transform.position).z)
				arg_128_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["404001ui_story"].transform.localEulerAngles = arg_128_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["404001ui_story"].transform.position).z)
				arg_128_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["404001ui_story"].transform.localEulerAngles = arg_128_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_131_1 = manager.ui.mainCamera.transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.shakeOldPos = var_131_1.localPosition
			end

			local var_131_2 = 1.79999999701977

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 then
				local var_131_3, var_131_4 = math.modf((arg_128_1.time_ - 0) / 0.066)

				var_131_1.localPosition = Vector3.New(var_131_4 * 0.13, var_131_4 * 0.13, var_131_4 * 0.13) + arg_128_1.var_.shakeOldPos
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 then
				var_131_1.localPosition = arg_128_1.var_.shakeOldPos
			end

			local var_131_5 = 0
			local var_131_6 = 1.2

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				arg_128_1.dialog_:SetActive(true)

				arg_128_1.dialogCg_.alpha = 0

				local var_131_7 = LeanTween.value(arg_128_1.dialog_, 0, 1, 0.3)

				var_131_7:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_128_1.dialogCg_.alpha = arg_132_0
				end))
				var_131_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_128_1.dialog_)
					var_131_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_128_1.duration_ = arg_128_1.duration_ + 0.3

				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(322052030).content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 48 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 48)

				if (48 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 48)) > 0 and var_131_6 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10
					var_131_5 = var_131_5 + 0.3

					if var_131_10 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_11 = var_131_5 + 0.3
			local var_131_12 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 + 0.3 <= arg_128_1.time_ and arg_128_1.time_ < var_131_11 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_11) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_11 + var_131_12 and arg_128_1.time_ < var_131_11 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play322052031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 322052031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play322052032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0.200000002980232 < arg_134_1.time_ and arg_134_1.time_ <= 0.200000002980232 + arg_137_0 then
				arg_134_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_137_0 = 1.79999999701977

			if 0.200000002980232 <= arg_134_1.time_ and arg_134_1.time_ < 0.200000002980232 + var_137_0 then
				local var_137_1, var_137_2 = math.modf((arg_134_1.time_ - 0.200000002980232) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_137_2 * 0.13, var_137_2 * 0.13, var_137_2 * 0.13) + arg_134_1.var_.shakeOldPos
			end

			if arg_134_1.time_ >= 0.200000002980232 + var_137_0 and arg_134_1.time_ < 0.200000002980232 + var_137_0 + arg_137_0 then
				manager.ui.mainCamera.transform.localPosition = arg_134_1.var_.shakeOldPos
			end

			local var_137_3 = 0
			local var_137_4 = 1.725

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_3 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_5 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(322052031).content)

				arg_134_1.text_.text = var_137_5

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 69 <= 0 and var_137_4 or var_137_4 * (utf8.len(var_137_5) / 69)

				if (69 <= 0 and var_137_4 or var_137_4 * (utf8.len(var_137_5) / 69)) > 0 and var_137_4 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_3 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_3
					end
				end

				arg_134_1.text_.text = var_137_5
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_8 = math.max(var_137_4, arg_134_1.talkMaxDuration)

			if var_137_3 <= arg_134_1.time_ and arg_134_1.time_ < var_137_3 + var_137_8 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_3) / var_137_8

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_3 + var_137_8 and arg_134_1.time_ < var_137_3 + var_137_8 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play322052032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 322052032
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play322052033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_141_0 = 1.79999999701977

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				local var_141_1, var_141_2 = math.modf((arg_138_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_141_2 * 0.13, var_141_2 * 0.13, var_141_2 * 0.13) + arg_138_1.var_.shakeOldPos
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				manager.ui.mainCamera.transform.localPosition = arg_138_1.var_.shakeOldPos
			end

			local var_141_3 = 0
			local var_141_4 = 1.5

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_3 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_5 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(322052032).content)

				arg_138_1.text_.text = var_141_5

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_7 = 60 <= 0 and var_141_4 or var_141_4 * (utf8.len(var_141_5) / 60)

				if (60 <= 0 and var_141_4 or var_141_4 * (utf8.len(var_141_5) / 60)) > 0 and var_141_4 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_3 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_3
					end
				end

				arg_138_1.text_.text = var_141_5
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_8 = math.max(var_141_4, arg_138_1.talkMaxDuration)

			if var_141_3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_3 + var_141_8 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_3) / var_141_8

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_3 + var_141_8 and arg_138_1.time_ < var_141_3 + var_141_8 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play322052033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 322052033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play322052034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_145_0 = 1.79999999701977

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 then
				local var_145_1, var_145_2 = math.modf((arg_142_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_145_2 * 0.13, var_145_2 * 0.13, var_145_2 * 0.13) + arg_142_1.var_.shakeOldPos
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 then
				manager.ui.mainCamera.transform.localPosition = arg_142_1.var_.shakeOldPos
			end

			local var_145_3 = 0
			local var_145_4 = 1.7

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_3 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_5 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(322052033).content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 68 <= 0 and var_145_4 or var_145_4 * (utf8.len(var_145_5) / 68)

				if (68 <= 0 and var_145_4 or var_145_4 * (utf8.len(var_145_5) / 68)) > 0 and var_145_4 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_3 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_3
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_4, arg_142_1.talkMaxDuration)

			if var_145_3 <= arg_142_1.time_ and arg_142_1.time_ < var_145_3 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_3) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_3 + var_145_8 and arg_142_1.time_ < var_145_3 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play322052034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 322052034
		arg_146_1.duration_ = 2

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play322052035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1284ui_story = arg_146_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1284ui_story"].transform.position).z)
				arg_146_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1284ui_story"].transform.localEulerAngles = arg_146_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_146_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1284ui_story"].transform.position).z)
				arg_146_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1284ui_story"].transform.localEulerAngles = arg_146_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1284ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1284ui_story == nil then
				arg_146_1.var_.characterEffect1284ui_story = var_149_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 and not isNil(var_149_1) then
				if arg_146_1.var_.characterEffect1284ui_story and not isNil(var_149_1) then
					arg_146_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1284ui_story then
				arg_146_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_149_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_146_1.bgmTxt_.text ~= var_149_6 and arg_146_1.bgmTxt_.text ~= "" then
						if arg_146_1.bgmTxt2_.text ~= "" then
							arg_146_1.bgmTxt_.text = arg_146_1.bgmTxt2_.text
						end

						arg_146_1.bgmTxt2_.text = var_149_6

						arg_146_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_146_1.bgmTxt_.text = var_149_6
						arg_146_1.bgmTxt2_.text = var_149_6
					end

					if arg_146_1.bgmTimer then
						arg_146_1.bgmTimer:Stop()

						arg_146_1.bgmTimer = nil
					end

					if arg_146_1.settingData.show_music_name == 1 then
						arg_146_1.musicController:SetSelectedState("show")
						arg_146_1.musicAnimator_:Play("open", 0, 0)

						if arg_146_1.settingData.music_time ~= 0 then
							arg_146_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_146_1.settingData.music_time), function()
								if arg_146_1 == nil or isNil(arg_146_1.bgmTxt_) then
									return
								end

								arg_146_1.musicController:SetSelectedState("hide")
								arg_146_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.200000002980232 < arg_146_1.time_ and arg_146_1.time_ <= 0.200000002980232 + arg_149_0 then
				arg_146_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_149_9 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if "" ~= "" then
					if arg_146_1.bgmTxt_.text ~= var_149_9 and arg_146_1.bgmTxt_.text ~= "" then
						if arg_146_1.bgmTxt2_.text ~= "" then
							arg_146_1.bgmTxt_.text = arg_146_1.bgmTxt2_.text
						end

						arg_146_1.bgmTxt2_.text = var_149_9

						arg_146_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_146_1.bgmTxt_.text = var_149_9
						arg_146_1.bgmTxt2_.text = var_149_9
					end

					if arg_146_1.bgmTimer then
						arg_146_1.bgmTimer:Stop()

						arg_146_1.bgmTimer = nil
					end

					if arg_146_1.settingData.show_music_name == 1 then
						arg_146_1.musicController:SetSelectedState("show")
						arg_146_1.musicAnimator_:Play("open", 0, 0)

						if arg_146_1.settingData.music_time ~= 0 then
							arg_146_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_146_1.settingData.music_time), function()
								if arg_146_1 == nil or isNil(arg_146_1.bgmTxt_) then
									return
								end

								arg_146_1.musicController:SetSelectedState("hide")
								arg_146_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_mix_down", "")
			end

			if 0.034000001847744 < arg_146_1.time_ and arg_146_1.time_ <= 0.034000001847744 + arg_149_0 then
				arg_146_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.21 < arg_146_1.time_ and arg_146_1.time_ <= 0.21 + arg_149_0 then
				arg_146_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "init_battle", "bgm_activity_4_5_story_serious.awb")

				local var_149_14 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_battle")

				if "" ~= "" then
					if arg_146_1.bgmTxt_.text ~= var_149_14 and arg_146_1.bgmTxt_.text ~= "" then
						if arg_146_1.bgmTxt2_.text ~= "" then
							arg_146_1.bgmTxt_.text = arg_146_1.bgmTxt2_.text
						end

						arg_146_1.bgmTxt2_.text = var_149_14

						arg_146_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_146_1.bgmTxt_.text = var_149_14
						arg_146_1.bgmTxt2_.text = var_149_14
					end

					if arg_146_1.bgmTimer then
						arg_146_1.bgmTimer:Stop()

						arg_146_1.bgmTimer = nil
					end

					if arg_146_1.settingData.show_music_name == 1 then
						arg_146_1.musicController:SetSelectedState("show")
						arg_146_1.musicAnimator_:Play("open", 0, 0)

						if arg_146_1.settingData.music_time ~= 0 then
							arg_146_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_146_1.settingData.music_time), function()
								if arg_146_1 == nil or isNil(arg_146_1.bgmTxt_) then
									return
								end

								arg_146_1.musicController:SetSelectedState("hide")
								arg_146_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_149_15 = 0
			local var_149_16 = 0.15

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_17 = arg_146_1:GetWordFromCfg(322052034)
				local var_149_18 = arg_146_1:FormatText(var_149_17.content)

				arg_146_1.text_.text = var_149_18

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_20 = 6 <= 0 and var_149_16 or var_149_16 * (utf8.len(var_149_18) / 6)

				if (6 <= 0 and var_149_16 or var_149_16 * (utf8.len(var_149_18) / 6)) > 0 and var_149_16 < var_149_20 then
					arg_146_1.talkMaxDuration = var_149_20

					if var_149_20 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_20 + var_149_15
					end
				end

				arg_146_1.text_.text = var_149_18
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052034", "story_v_out_322052.awb") ~= 0 then
					local var_149_21 = manager.audio:GetVoiceLength("story_v_out_322052", "322052034", "story_v_out_322052.awb") / 1000

					if var_149_21 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_21 + var_149_15
					end

					if var_149_17.prefab_name ~= "" and arg_146_1.actors_[var_149_17.prefab_name] ~= nil then
						local var_149_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_17.prefab_name].transform, "story_v_out_322052", "322052034", "story_v_out_322052.awb")

						arg_146_1:RecordAudio("322052034", var_149_22)
						arg_146_1:RecordAudio("322052034", var_149_22)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_322052", "322052034", "story_v_out_322052.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_322052", "322052034", "story_v_out_322052.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_23 = math.max(var_149_16, arg_146_1.talkMaxDuration)

			if var_149_15 <= arg_146_1.time_ and arg_146_1.time_ < var_149_15 + var_149_23 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_15) / var_149_23

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_15 + var_149_23 and arg_146_1.time_ < var_149_15 + var_149_23 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
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

		arg_146_1:InitPlayNodeList()
	end,
	Play322052035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322052035
		arg_153_1.duration_ = 4.6

		local var_153_0 = {
			zh = 4.6,
			ja = 4.533
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
				arg_153_0:Play322052036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos404001ui_story = arg_153_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["404001ui_story"].transform.position).z)
				arg_153_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["404001ui_story"].transform.localEulerAngles = arg_153_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_153_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["404001ui_story"].transform.position).z)
				arg_153_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["404001ui_story"].transform.localEulerAngles = arg_153_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["404001ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect404001ui_story == nil then
				arg_153_1.var_.characterEffect404001ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect404001ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect404001ui_story then
				arg_153_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_156_4 = arg_153_1.actors_["1284ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1284ui_story == nil then
				arg_153_1.var_.characterEffect1284ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_5 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 and not isNil(var_156_4) then
				if arg_153_1.var_.characterEffect1284ui_story and not isNil(var_156_4) then
					arg_153_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_5)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1284ui_story then
				arg_153_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_156_6 = 0
			local var_156_7 = 0.475

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:GetWordFromCfg(322052035)
				local var_156_9 = arg_153_1:FormatText(var_156_8.content)

				arg_153_1.text_.text = var_156_9

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 19 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 19)

				if (19 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 19)) > 0 and var_156_7 < var_156_11 then
					arg_153_1.talkMaxDuration = var_156_11

					if var_156_11 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_9
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052035", "story_v_out_322052.awb") ~= 0 then
					local var_156_12 = manager.audio:GetVoiceLength("story_v_out_322052", "322052035", "story_v_out_322052.awb") / 1000

					if var_156_12 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_12 + var_156_6
					end

					if var_156_8.prefab_name ~= "" and arg_153_1.actors_[var_156_8.prefab_name] ~= nil then
						local var_156_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_8.prefab_name].transform, "story_v_out_322052", "322052035", "story_v_out_322052.awb")

						arg_153_1:RecordAudio("322052035", var_156_13)
						arg_153_1:RecordAudio("322052035", var_156_13)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_322052", "322052035", "story_v_out_322052.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_322052", "322052035", "story_v_out_322052.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_14 and arg_153_1.time_ < var_156_6 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play322052036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 322052036
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play322052037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos404001ui_story = arg_157_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).z)
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles = arg_157_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["404001ui_story"].transform.position).z)
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["404001ui_story"].transform.localEulerAngles = arg_157_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1284ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1284ui_story = var_160_1.localPosition
			end

			local var_160_2 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 then
				var_160_1.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_2)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 then
				var_160_1.localPosition = Vector3.New(0, 100, 0)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			local var_160_3 = arg_157_1.actors_["404001ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_3) and arg_157_1.var_.characterEffect404001ui_story == nil then
				arg_157_1.var_.characterEffect404001ui_story = var_160_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_4 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 and not isNil(var_160_3) then
				if arg_157_1.var_.characterEffect404001ui_story and not isNil(var_160_3) then
					arg_157_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_157_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_4)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 and not isNil(var_160_3) and arg_157_1.var_.characterEffect404001ui_story then
				arg_157_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_157_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_160_5 = 0
			local var_160_6 = 1.1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_7 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(322052036).content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 44 <= 0 and var_160_6 or var_160_6 * (utf8.len(var_160_7) / 44)

				if (44 <= 0 and var_160_6 or var_160_6 * (utf8.len(var_160_7) / 44)) > 0 and var_160_6 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_5 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_5
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_6, arg_157_1.talkMaxDuration)

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_5) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_5 + var_160_10 and arg_157_1.time_ < var_160_5 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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
				actorName = "1284ui_story",
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
	Play322052037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 322052037
		arg_161_1.duration_ = 3.23

		local var_161_0 = {
			zh = 3.233,
			ja = 2.7
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play322052038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos404001ui_story = arg_161_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["404001ui_story"].transform.position).z)
				arg_161_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["404001ui_story"].transform.localEulerAngles = arg_161_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_161_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["404001ui_story"].transform.position).z)
				arg_161_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["404001ui_story"].transform.localEulerAngles = arg_161_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["404001ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect404001ui_story == nil then
				arg_161_1.var_.characterEffect404001ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect404001ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect404001ui_story then
				arg_161_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			local var_164_4 = 0
			local var_164_5 = 0.3

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(322052037)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 12 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 12)

				if (12 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 12)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052037", "story_v_out_322052.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_322052", "322052037", "story_v_out_322052.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_out_322052", "322052037", "story_v_out_322052.awb")

						arg_161_1:RecordAudio("322052037", var_164_11)
						arg_161_1:RecordAudio("322052037", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_322052", "322052037", "story_v_out_322052.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_322052", "322052037", "story_v_out_322052.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play322052038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 322052038
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play322052039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos404001ui_story = arg_165_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).z)
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles = arg_165_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["404001ui_story"].transform.position).z)
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["404001ui_story"].transform.localEulerAngles = arg_165_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_168_1 = 0
			local var_168_2 = 1.2

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

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(322052038).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 48 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 48)

				if (48 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 48)) > 0 and var_168_2 < var_168_5 then
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
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play322052039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 322052039
		arg_169_1.duration_ = 5.47

		local var_169_0 = {
			zh = 3.633,
			ja = 5.466
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
				arg_169_0:Play322052040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10152ui_story = arg_169_1.actors_["10152ui_story"].transform.localPosition

				local var_172_0 = GameObjectTools.GetOrAddComponent(arg_169_1.actors_["10152ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_172_0 then
					var_172_0:EnableDynamicBone(false)
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["10152ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10152ui_story, Vector3.New(0, -1.73, -5.5), (arg_169_1.time_ - 0) / var_172_1)
				arg_169_1.actors_["10152ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10152ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10152ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10152ui_story"].transform.position).z)
				arg_169_1.actors_["10152ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10152ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10152ui_story"].transform.localEulerAngles = arg_169_1.actors_["10152ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["10152ui_story"].transform.localPosition = Vector3.New(0, -1.73, -5.5)
				arg_169_1.actors_["10152ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10152ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10152ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10152ui_story"].transform.position).z)
				arg_169_1.actors_["10152ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10152ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10152ui_story"].transform.localEulerAngles = arg_169_1.actors_["10152ui_story"].transform.localEulerAngles

				local var_172_2 = GameObjectTools.GetOrAddComponent(arg_169_1.actors_["10152ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_172_2 then
					var_172_2:EnableDynamicBone(true)
				end
			end

			local var_172_3 = arg_169_1.actors_["10152ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect10152ui_story == nil then
				arg_169_1.var_.characterEffect10152ui_story = var_172_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_4 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 and not isNil(var_172_3) then
				if arg_169_1.var_.characterEffect10152ui_story and not isNil(var_172_3) then
					arg_169_1.var_.characterEffect10152ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect10152ui_story then
				arg_169_1.var_.characterEffect10152ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_172_6 = 0
			local var_172_7 = 0.3

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(322052039)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 12 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 12)

				if (12 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 12)) > 0 and var_172_7 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052039", "story_v_out_322052.awb") ~= 0 then
					local var_172_12 = manager.audio:GetVoiceLength("story_v_out_322052", "322052039", "story_v_out_322052.awb") / 1000

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_322052", "322052039", "story_v_out_322052.awb")

						arg_169_1:RecordAudio("322052039", var_172_13)
						arg_169_1:RecordAudio("322052039", var_172_13)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_322052", "322052039", "story_v_out_322052.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_322052", "322052039", "story_v_out_322052.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10152ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play322052040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 322052040
		arg_173_1.duration_ = 3.9

		local var_173_0 = {
			zh = 3.4,
			ja = 3.9
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
			arg_173_1.auto_ = false
		end

		function arg_173_1.playNext_(arg_175_0)
			arg_173_1.onStoryFinished_()
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_176_0 = 0
			local var_176_1 = 0.225

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(322052040)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 9 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 9)

				if (9 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 9)) > 0 and var_176_1 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322052", "322052040", "story_v_out_322052.awb") ~= 0 then
					local var_176_6 = manager.audio:GetVoiceLength("story_v_out_322052", "322052040", "story_v_out_322052.awb") / 1000

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end

					if var_176_2.prefab_name ~= "" and arg_173_1.actors_[var_176_2.prefab_name] ~= nil then
						local var_176_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_2.prefab_name].transform, "story_v_out_322052", "322052040", "story_v_out_322052.awb")

						arg_173_1:RecordAudio("322052040", var_176_7)
						arg_173_1:RecordAudio("322052040", var_176_7)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_322052", "322052040", "story_v_out_322052.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_322052", "322052040", "story_v_out_322052.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L15h"
	},
	voices = {
		"story_v_out_322052.awb"
	}
}
