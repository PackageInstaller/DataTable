return {
	Play319181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319181001
		arg_1_1.duration_ = 3.73

		local var_1_0 = {
			zh = 2.999999999999,
			ja = 3.73333333333333
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
				arg_1_0:Play319181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
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

			local var_4_5 = 1.03400000184774

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

			local var_4_8 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1084ui_story"].transform

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1 <= arg_1_1.time_ and arg_1_1.time_ < 1 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_1_1.time_ - 1) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1 + var_4_13 and arg_1_1.time_ < 1 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.97, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1084ui_story"]

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1 <= arg_1_1.time_ and arg_1_1.time_ < 1 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1 + var_4_15 and arg_1_1.time_ < 1 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_130", "se_story_130_hammer", "")
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 1.43333333333333
			local var_4_22 = 0.0166666666666667

			if 1.43333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_24 = arg_1_1:GetWordFromCfg(319181001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 3 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 3)

				if (3 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 3)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181001", "story_v_out_319181.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_319181", "319181001", "story_v_out_319181.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_319181", "319181001", "story_v_out_319181.awb")

						arg_1_1:RecordAudio("319181001", var_4_29)
						arg_1_1:RecordAudio("319181001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319181", "319181001", "story_v_out_319181.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319181", "319181001", "story_v_out_319181.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319181002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319181002
		arg_8_1.duration_ = 3.1

		local var_8_0 = {
			zh = 1.999999999999,
			ja = 3.1
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319181003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_130", "se_story_130_hammer", "")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_11_1 = 0
			local var_11_2 = 0.175

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:GetWordFromCfg(319181002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 7 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 7)

				if (7 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 7)) > 0 and var_11_2 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181002", "story_v_out_319181.awb") ~= 0 then
					local var_11_7 = manager.audio:GetVoiceLength("story_v_out_319181", "319181002", "story_v_out_319181.awb") / 1000

					if var_11_7 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_1
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_319181", "319181002", "story_v_out_319181.awb")

						arg_8_1:RecordAudio("319181002", var_11_8)
						arg_8_1:RecordAudio("319181002", var_11_8)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_319181", "319181002", "story_v_out_319181.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_319181", "319181002", "story_v_out_319181.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_9 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_9 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_9

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_9 and arg_8_1.time_ < var_11_1 + var_11_9 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play319181003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319181003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319181004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = arg_12_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_15_0 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 then
				arg_12_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_0)
				arg_12_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).z)
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles = arg_12_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 then
				arg_12_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).z)
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles = arg_12_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_15_1 = 0
			local var_15_2 = 1.075

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(319181003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 43 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 43)

				if (43 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 43)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play319181004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319181004
		arg_16_1.duration_ = 9.07

		local var_16_0 = {
			zh = 6.8,
			ja = 9.066
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play319181005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.bgs_.D02a == nil then
				local var_19_0 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D02a")
				var_19_0.name = "D02a"
				var_19_0.transform.parent = arg_16_1.stage_.transform
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_.D02a = var_19_0
			end

			if 1 < arg_16_1.time_ and arg_16_1.time_ <= 1 + arg_19_0 then
				local var_19_1 = arg_16_1.bgs_.D02a

				arg_16_1.bgs_.D02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_19_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_2 = var_19_1:GetComponent("SpriteRenderer")

				if var_19_2 and var_19_2.sprite then
					local var_19_3 = 2 * (var_19_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_19_1.transform.localScale = Vector3.New(var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "D02a" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_4 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_5 = 1

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_5 then
				local var_19_6 = Color.New(0, 0, 0)

				var_19_6.a = Mathf.Lerp(0, 1, (arg_16_1.time_ - var_19_4) / var_19_5)
				arg_16_1.mask_.color = var_19_6
			end

			if arg_16_1.time_ >= var_19_4 + var_19_5 and arg_16_1.time_ < var_19_4 + var_19_5 + arg_19_0 then
				local var_19_7 = Color.New(0, 0, 0)

				var_19_7.a = 1
				arg_16_1.mask_.color = var_19_7
			end

			local var_19_8 = 1

			if 1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_9 = 2

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_9 then
				local var_19_10 = Color.New(0, 0, 0)

				var_19_10.a = Mathf.Lerp(1, 0, (arg_16_1.time_ - var_19_8) / var_19_9)
				arg_16_1.mask_.color = var_19_10
			end

			if arg_16_1.time_ >= var_19_8 + var_19_9 and arg_16_1.time_ < var_19_8 + var_19_9 + arg_19_0 then
				local var_19_11 = Color.New(0, 0, 0)

				arg_16_1.mask_.enabled = false
				var_19_11.a = 0
				arg_16_1.mask_.color = var_19_11
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_19_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_14 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_14

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_14
						arg_16_1.bgmTxt2_.text = var_19_14
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_16_1.time_ and arg_16_1.time_ <= 0.233333333333333 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_19_17 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_17 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_17

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_17
						arg_16_1.bgmTxt2_.text = var_19_17
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_18 = arg_16_1.actors_["1084ui_story"]

			if 2.86666666666667 < arg_16_1.time_ and arg_16_1.time_ <= 2.86666666666667 + arg_19_0 and not isNil(var_19_18) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_19 = 0.200000002980232

			if 2.86666666666667 <= arg_16_1.time_ and arg_16_1.time_ < 2.86666666666667 + var_19_19 and not isNil(var_19_18) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_18) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 2.86666666666667 + var_19_19 and arg_16_1.time_ < 2.86666666666667 + var_19_19 + arg_19_0 and not isNil(var_19_18) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_21 = arg_16_1.actors_["1084ui_story"].transform

			if 2.86666666666667 < arg_16_1.time_ and arg_16_1.time_ <= 2.86666666666667 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_21.localPosition
			end

			local var_19_22 = 0.001

			if 2.86666666666667 <= arg_16_1.time_ and arg_16_1.time_ < 2.86666666666667 + var_19_22 then
				var_19_21.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_16_1.time_ - 2.86666666666667) / var_19_22)
				var_19_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_21.position).x, (manager.ui.mainCamera.transform.position - var_19_21.position).y, (manager.ui.mainCamera.transform.position - var_19_21.position).z)
				var_19_21.localEulerAngles.z = 0
				var_19_21.localEulerAngles.x = 0
				var_19_21.localEulerAngles = var_19_21.localEulerAngles
			end

			if arg_16_1.time_ >= 2.86666666666667 + var_19_22 and arg_16_1.time_ < 2.86666666666667 + var_19_22 + arg_19_0 then
				var_19_21.localPosition = Vector3.New(0, -0.97, -6)
				var_19_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_21.position).x, (manager.ui.mainCamera.transform.position - var_19_21.position).y, (manager.ui.mainCamera.transform.position - var_19_21.position).z)
				var_19_21.localEulerAngles.z = 0
				var_19_21.localEulerAngles.x = 0
				var_19_21.localEulerAngles = var_19_21.localEulerAngles
			end

			if 2.86666666666667 < arg_16_1.time_ and arg_16_1.time_ <= 2.86666666666667 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 2.86666666666667 < arg_16_1.time_ and arg_16_1.time_ <= 2.86666666666667 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_23 = 3
			local var_19_24 = 0.45

			if 3 < arg_16_1.time_ and arg_16_1.time_ <= var_19_23 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_25 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_25:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_16_1.dialogCg_.alpha = arg_22_0
				end))
				var_19_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_26 = arg_16_1:GetWordFromCfg(319181004)
				local var_19_27 = arg_16_1:FormatText(var_19_26.content)

				arg_16_1.text_.text = var_19_27

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_29 = 18 <= 0 and var_19_24 or var_19_24 * (utf8.len(var_19_27) / 18)

				if (18 <= 0 and var_19_24 or var_19_24 * (utf8.len(var_19_27) / 18)) > 0 and var_19_24 < var_19_29 then
					arg_16_1.talkMaxDuration = var_19_29
					var_19_23 = var_19_23 + 0.3

					if var_19_29 + var_19_23 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_29 + var_19_23
					end
				end

				arg_16_1.text_.text = var_19_27
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181004", "story_v_out_319181.awb") ~= 0 then
					local var_19_30 = manager.audio:GetVoiceLength("story_v_out_319181", "319181004", "story_v_out_319181.awb") / 1000

					if var_19_30 + var_19_23 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_30 + var_19_23
					end

					if var_19_26.prefab_name ~= "" and arg_16_1.actors_[var_19_26.prefab_name] ~= nil then
						local var_19_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_26.prefab_name].transform, "story_v_out_319181", "319181004", "story_v_out_319181.awb")

						arg_16_1:RecordAudio("319181004", var_19_31)
						arg_16_1:RecordAudio("319181004", var_19_31)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_319181", "319181004", "story_v_out_319181.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_319181", "319181004", "story_v_out_319181.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_32 = var_19_23 + 0.3
			local var_19_33 = math.max(var_19_24, arg_16_1.talkMaxDuration)

			if var_19_23 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_32 + var_19_33 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_32) / var_19_33

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_32 + var_19_33 and arg_16_1.time_ < var_19_32 + var_19_33 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333337,
				className = "StoryMoveNode",
				startTime = 2.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play319181005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319181005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play319181006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = arg_24_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) then
				if arg_24_1.var_.characterEffect1084ui_story and not isNil(arg_24_1.actors_["1084ui_story"]) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 1.325

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(319181005).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 53 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 53)

				if (53 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 53)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play319181006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 319181006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play319181007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 1.6

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(319181006).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 64 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 64)

				if (64 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 64)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play319181007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319181007
		arg_32_1.duration_ = 8.87

		local var_32_0 = {
			zh = 5.333,
			ja = 8.866
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play319181008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_35_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_32_1.stage_.transform)

				var_35_0.name = "10066ui_story"
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["10066ui_story"] = var_35_0

				local var_35_1 = var_35_0:GetComponentInChildren(typeof(CharacterEffect))

				var_35_1.enabled = true

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_1.transform, false)

				arg_32_1.var_["10066ui_story" .. "Animator"] = var_35_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_32_1.var_["10066ui_story" .. "LipSync"] = var_35_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_3 = arg_32_1.actors_["10066ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10066ui_story = var_35_3.localPosition
			end

			local var_35_4 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_32_1.time_ - 0) / var_35_4)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(0.7, -0.99, -5.83)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			local var_35_5 = arg_32_1.actors_["10066ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect10066ui_story == nil then
				arg_32_1.var_.characterEffect10066ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect10066ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect10066ui_story then
				arg_32_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_8 = arg_32_1.actors_["1084ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_8.localPosition
			end

			local var_35_9 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_9 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_32_1.time_ - 0) / var_35_9)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_9 and arg_32_1.time_ < 0 + var_35_9 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			local var_35_10 = arg_32_1.actors_["1084ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = var_35_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_11 and not isNil(var_35_10) then
				if arg_32_1.var_.characterEffect1084ui_story and not isNil(var_35_10) then
					arg_32_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_11)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_11 and arg_32_1.time_ < 0 + var_35_11 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1084ui_story then
				arg_32_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_35_12 = 0
			local var_35_13 = 0.525

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(319181007)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 21 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 21)

				if (21 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 21)) > 0 and var_35_13 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181007", "story_v_out_319181.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_319181", "319181007", "story_v_out_319181.awb") / 1000

					if var_35_18 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_12
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_319181", "319181007", "story_v_out_319181.awb")

						arg_32_1:RecordAudio("319181007", var_35_19)
						arg_32_1:RecordAudio("319181007", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_319181", "319181007", "story_v_out_319181.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_319181", "319181007", "story_v_out_319181.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_20 and arg_32_1.time_ < var_35_12 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play319181008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 319181008
		arg_36_1.duration_ = 8.1

		local var_36_0 = {
			zh = 3.766,
			ja = 8.1
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play319181009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["10066ui_story"]) and arg_36_1.var_.characterEffect10066ui_story == nil then
				arg_36_1.var_.characterEffect10066ui_story = arg_36_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["10066ui_story"]) then
				if arg_36_1.var_.characterEffect10066ui_story and not isNil(arg_36_1.actors_["10066ui_story"]) then
					arg_36_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["10066ui_story"]) and arg_36_1.var_.characterEffect10066ui_story then
				arg_36_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_39_1 = arg_36_1.actors_["1084ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 and not isNil(var_39_1) then
				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_1) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_39_4 = 0
			local var_39_5 = 0.4

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(319181008)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 16 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 16)

				if (16 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 16)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181008", "story_v_out_319181.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181008", "story_v_out_319181.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_319181", "319181008", "story_v_out_319181.awb")

						arg_36_1:RecordAudio("319181008", var_39_11)
						arg_36_1:RecordAudio("319181008", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_319181", "319181008", "story_v_out_319181.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_319181", "319181008", "story_v_out_319181.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play319181009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 319181009
		arg_40_1.duration_ = 6.8

		local var_40_0 = {
			zh = 6.8,
			ja = 4.4
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play319181010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10066ui_story"]) and arg_40_1.var_.characterEffect10066ui_story == nil then
				arg_40_1.var_.characterEffect10066ui_story = arg_40_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10066ui_story"]) then
				if arg_40_1.var_.characterEffect10066ui_story and not isNil(arg_40_1.actors_["10066ui_story"]) then
					arg_40_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10066ui_story"]) and arg_40_1.var_.characterEffect10066ui_story then
				arg_40_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1084ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_43_4 = 0
			local var_43_5 = 0.7

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(319181009)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 28 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 28)

				if (28 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 28)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181009", "story_v_out_319181.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181009", "story_v_out_319181.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_319181", "319181009", "story_v_out_319181.awb")

						arg_40_1:RecordAudio("319181009", var_43_11)
						arg_40_1:RecordAudio("319181009", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_319181", "319181009", "story_v_out_319181.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_319181", "319181009", "story_v_out_319181.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play319181010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319181010
		arg_44_1.duration_ = 3.07

		local var_44_0 = {
			zh = 3.066,
			ja = 2.833
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play319181011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.25

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:GetWordFromCfg(319181010)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 10 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 10)

				if (10 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 10)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181010", "story_v_out_319181.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_319181", "319181010", "story_v_out_319181.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_319181", "319181010", "story_v_out_319181.awb")

						arg_44_1:RecordAudio("319181010", var_47_6)
						arg_44_1:RecordAudio("319181010", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_319181", "319181010", "story_v_out_319181.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_319181", "319181010", "story_v_out_319181.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play319181011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319181011
		arg_48_1.duration_ = 8.23

		local var_48_0 = {
			zh = 6,
			ja = 8.233
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play319181012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = arg_48_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).z)
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles = arg_48_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_48_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).z)
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles = arg_48_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_51_1 = arg_48_1.actors_["1084ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_51_4 = arg_48_1.actors_["10066ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10066ui_story == nil then
				arg_48_1.var_.characterEffect10066ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_5 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 and not isNil(var_51_4) then
				if arg_48_1.var_.characterEffect10066ui_story and not isNil(var_51_4) then
					arg_48_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_5)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10066ui_story then
				arg_48_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_51_6 = 0
			local var_51_7 = 0.65

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(319181011)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 26 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 26)

				if (26 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 26)) > 0 and var_51_7 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181011", "story_v_out_319181.awb") ~= 0 then
					local var_51_12 = manager.audio:GetVoiceLength("story_v_out_319181", "319181011", "story_v_out_319181.awb") / 1000

					if var_51_12 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_6
					end

					if var_51_8.prefab_name ~= "" and arg_48_1.actors_[var_51_8.prefab_name] ~= nil then
						local var_51_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_8.prefab_name].transform, "story_v_out_319181", "319181011", "story_v_out_319181.awb")

						arg_48_1:RecordAudio("319181011", var_51_13)
						arg_48_1:RecordAudio("319181011", var_51_13)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319181", "319181011", "story_v_out_319181.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319181", "319181011", "story_v_out_319181.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play319181012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319181012
		arg_52_1.duration_ = 3.5

		local var_52_0 = {
			zh = 3.266,
			ja = 3.5
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play319181013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = arg_52_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) then
				if arg_52_1.var_.characterEffect1084ui_story and not isNil(arg_52_1.actors_["1084ui_story"]) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.325

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(319181012)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 13 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 13)

				if (13 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 13)) > 0 and var_55_2 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181012", "story_v_out_319181.awb") ~= 0 then
					local var_55_7 = manager.audio:GetVoiceLength("story_v_out_319181", "319181012", "story_v_out_319181.awb") / 1000

					if var_55_7 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_1
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_319181", "319181012", "story_v_out_319181.awb")

						arg_52_1:RecordAudio("319181012", var_55_8)
						arg_52_1:RecordAudio("319181012", var_55_8)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_319181", "319181012", "story_v_out_319181.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_319181", "319181012", "story_v_out_319181.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_9 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_9 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_9

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_9 and arg_52_1.time_ < var_55_1 + var_55_9 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play319181013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319181013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319181014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10066ui_story = arg_56_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10066ui_story"].transform.position).z)
				arg_56_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10066ui_story"].transform.localEulerAngles = arg_56_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10066ui_story"].transform.position).z)
				arg_56_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10066ui_story"].transform.localEulerAngles = arg_56_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["10066ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect10066ui_story == nil then
				arg_56_1.var_.characterEffect10066ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 and not isNil(var_59_1) then
				if arg_56_1.var_.characterEffect10066ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_2)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect10066ui_story then
				arg_56_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_59_3 = arg_56_1.actors_["1084ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_3.localPosition
			end

			local var_59_4 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				var_59_3.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_4)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				var_59_3.localPosition = Vector3.New(0, 100, 0)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			local var_59_5 = arg_56_1.actors_["1084ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_5) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_6 and not isNil(var_59_5) then
				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_5) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_6)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_6 and arg_56_1.time_ < 0 + var_59_6 + arg_59_0 and not isNil(var_59_5) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_59_7 = 0
			local var_59_8 = 1

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_9 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(319181013).content)

				arg_56_1.text_.text = var_59_9

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 40 <= 0 and var_59_8 or var_59_8 * (utf8.len(var_59_9) / 40)

				if (40 <= 0 and var_59_8 or var_59_8 * (utf8.len(var_59_9) / 40)) > 0 and var_59_8 < var_59_11 then
					arg_56_1.talkMaxDuration = var_59_11

					if var_59_11 + var_59_7 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_7
					end
				end

				arg_56_1.text_.text = var_59_9
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_8, arg_56_1.talkMaxDuration)

			if var_59_7 <= arg_56_1.time_ and arg_56_1.time_ < var_59_7 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_7) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_7 + var_59_12 and arg_56_1.time_ < var_59_7 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play319181014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319181014
		arg_60_1.duration_ = 4.63

		local var_60_0 = {
			zh = 2.8,
			ja = 4.633
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play319181015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if arg_60_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_63_0 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_60_1.stage_.transform)

				var_63_0.name = "4040ui_story"
				var_63_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["4040ui_story"] = var_63_0

				local var_63_1 = var_63_0:GetComponentInChildren(typeof(CharacterEffect))

				var_63_1.enabled = true

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end

				arg_60_1:ShowWeapon(var_63_1.transform, false)

				arg_60_1.var_["4040ui_story" .. "Animator"] = var_63_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_60_1.var_["4040ui_story" .. "Animator"].applyRootMotion = true
				arg_60_1.var_["4040ui_story" .. "LipSync"] = var_63_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_63_3 = arg_60_1.actors_["4040ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos4040ui_story = var_63_3.localPosition
			end

			local var_63_4 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				var_63_3.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_60_1.time_ - 0) / var_63_4)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				var_63_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			local var_63_5 = arg_60_1.actors_["4040ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect4040ui_story == nil then
				arg_60_1.var_.characterEffect4040ui_story = var_63_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_6 and not isNil(var_63_5) then
				if arg_60_1.var_.characterEffect4040ui_story and not isNil(var_63_5) then
					arg_60_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_6 and arg_60_1.time_ < 0 + var_63_6 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect4040ui_story then
				arg_60_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_63_8 = 0
			local var_63_9 = 0.275

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_10 = arg_60_1:GetWordFromCfg(319181014)
				local var_63_11 = arg_60_1:FormatText(var_63_10.content)

				arg_60_1.text_.text = var_63_11

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_13 = 11 <= 0 and var_63_9 or var_63_9 * (utf8.len(var_63_11) / 11)

				if (11 <= 0 and var_63_9 or var_63_9 * (utf8.len(var_63_11) / 11)) > 0 and var_63_9 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_8
					end
				end

				arg_60_1.text_.text = var_63_11
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181014", "story_v_out_319181.awb") ~= 0 then
					local var_63_14 = manager.audio:GetVoiceLength("story_v_out_319181", "319181014", "story_v_out_319181.awb") / 1000

					if var_63_14 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_8
					end

					if var_63_10.prefab_name ~= "" and arg_60_1.actors_[var_63_10.prefab_name] ~= nil then
						local var_63_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_10.prefab_name].transform, "story_v_out_319181", "319181014", "story_v_out_319181.awb")

						arg_60_1:RecordAudio("319181014", var_63_15)
						arg_60_1:RecordAudio("319181014", var_63_15)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319181", "319181014", "story_v_out_319181.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319181", "319181014", "story_v_out_319181.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_9, arg_60_1.talkMaxDuration)

			if var_63_8 <= arg_60_1.time_ and arg_60_1.time_ < var_63_8 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_8) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_8 + var_63_16 and arg_60_1.time_ < var_63_8 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play319181015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319181015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319181016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = arg_64_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).z)
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles = arg_64_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).z)
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles = arg_64_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["4040ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos4040ui_story = var_67_1.localPosition
			end

			local var_67_2 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 then
				var_67_1.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_2)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 then
				var_67_1.localPosition = Vector3.New(0, 100, 0)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			local var_67_3 = arg_64_1.actors_["4040ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_3) and arg_64_1.var_.characterEffect4040ui_story == nil then
				arg_64_1.var_.characterEffect4040ui_story = var_67_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_4 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 and not isNil(var_67_3) then
				if arg_64_1.var_.characterEffect4040ui_story and not isNil(var_67_3) then
					arg_64_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_64_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_4)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 and not isNil(var_67_3) and arg_64_1.var_.characterEffect4040ui_story then
				arg_64_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_64_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_67_5 = 0
			local var_67_6 = 0.9

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_7 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(319181015).content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 36 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_7) / 36)

				if (36 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_7) / 36)) > 0 and var_67_6 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_5 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_5
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_6, arg_64_1.talkMaxDuration)

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_5) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_5 + var_67_10 and arg_64_1.time_ < var_67_5 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play319181016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319181016
		arg_68_1.duration_ = 2.77

		local var_68_0 = {
			zh = 1.933,
			ja = 2.766
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play319181017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = arg_68_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) then
				if arg_68_1.var_.characterEffect1084ui_story and not isNil(arg_68_1.actors_["1084ui_story"]) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["1084ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_2.localPosition
			end

			local var_71_3 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 then
				var_71_2.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_68_1.time_ - 0) / var_71_3)
				var_71_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_2.position).x, (manager.ui.mainCamera.transform.position - var_71_2.position).y, (manager.ui.mainCamera.transform.position - var_71_2.position).z)
				var_71_2.localEulerAngles.z = 0
				var_71_2.localEulerAngles.x = 0
				var_71_2.localEulerAngles = var_71_2.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 then
				var_71_2.localPosition = Vector3.New(0.7, -0.97, -6)
				var_71_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_2.position).x, (manager.ui.mainCamera.transform.position - var_71_2.position).y, (manager.ui.mainCamera.transform.position - var_71_2.position).z)
				var_71_2.localEulerAngles.z = 0
				var_71_2.localEulerAngles.x = 0
				var_71_2.localEulerAngles = var_71_2.localEulerAngles
			end

			local var_71_4 = 0
			local var_71_5 = 0.225

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(319181016)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 9 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 9)

				if (9 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 9)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181016", "story_v_out_319181.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181016", "story_v_out_319181.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_319181", "319181016", "story_v_out_319181.awb")

						arg_68_1:RecordAudio("319181016", var_71_11)
						arg_68_1:RecordAudio("319181016", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319181", "319181016", "story_v_out_319181.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319181", "319181016", "story_v_out_319181.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play319181017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319181017
		arg_72_1.duration_ = 6.4

		local var_72_0 = {
			zh = 6.4,
			ja = 3.333
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play319181018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["4040ui_story"]) and arg_72_1.var_.characterEffect4040ui_story == nil then
				arg_72_1.var_.characterEffect4040ui_story = arg_72_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["4040ui_story"]) then
				if arg_72_1.var_.characterEffect4040ui_story and not isNil(arg_72_1.actors_["4040ui_story"]) then
					arg_72_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["4040ui_story"]) and arg_72_1.var_.characterEffect4040ui_story then
				arg_72_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_75_2 = arg_72_1.actors_["1084ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_3 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_2) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_3)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_75_4 = arg_72_1.actors_["4040ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos4040ui_story = var_75_4.localPosition
			end

			local var_75_5 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 then
				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_72_1.time_ - 0) / var_75_5)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			local var_75_6 = 0
			local var_75_7 = 0.75

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:GetWordFromCfg(319181017)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 30 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 30)

				if (30 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 30)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181017", "story_v_out_319181.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_319181", "319181017", "story_v_out_319181.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_319181", "319181017", "story_v_out_319181.awb")

						arg_72_1:RecordAudio("319181017", var_75_13)
						arg_72_1:RecordAudio("319181017", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_319181", "319181017", "story_v_out_319181.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_319181", "319181017", "story_v_out_319181.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play319181018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319181018
		arg_76_1.duration_ = 10.07

		local var_76_0 = {
			zh = 4.433,
			ja = 10.066
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play319181019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1084ui_story = arg_76_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).z)
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles = arg_76_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_76_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1084ui_story"].transform.position).z)
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1084ui_story"].transform.localEulerAngles = arg_76_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["1084ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1084ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1084ui_story then
				arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_4 = arg_76_1.actors_["4040ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect4040ui_story == nil then
				arg_76_1.var_.characterEffect4040ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_5 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 and not isNil(var_79_4) then
				if arg_76_1.var_.characterEffect4040ui_story and not isNil(var_79_4) then
					arg_76_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_76_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_5)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect4040ui_story then
				arg_76_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_76_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_79_6 = 0
			local var_79_7 = 0.525

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(319181018)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 21 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 21)

				if (21 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 21)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181018", "story_v_out_319181.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_319181", "319181018", "story_v_out_319181.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_319181", "319181018", "story_v_out_319181.awb")

						arg_76_1:RecordAudio("319181018", var_79_13)
						arg_76_1:RecordAudio("319181018", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319181", "319181018", "story_v_out_319181.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319181", "319181018", "story_v_out_319181.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319181019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319181019
		arg_80_1.duration_ = 6.77

		local var_80_0 = {
			zh = 5.633,
			ja = 6.766
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play319181020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = arg_80_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) then
				if arg_80_1.var_.characterEffect1084ui_story and not isNil(arg_80_1.actors_["1084ui_story"]) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_83_1 = arg_80_1.actors_["4040ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect4040ui_story == nil then
				arg_80_1.var_.characterEffect4040ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 and not isNil(var_83_1) then
				if arg_80_1.var_.characterEffect4040ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect4040ui_story then
				arg_80_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_83_4 = 0
			local var_83_5 = 0.625

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(319181019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 25 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 25)

				if (25 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 25)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181019", "story_v_out_319181.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181019", "story_v_out_319181.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_319181", "319181019", "story_v_out_319181.awb")

						arg_80_1:RecordAudio("319181019", var_83_11)
						arg_80_1:RecordAudio("319181019", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_319181", "319181019", "story_v_out_319181.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_319181", "319181019", "story_v_out_319181.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play319181020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319181020
		arg_84_1.duration_ = 3.9

		local var_84_0 = {
			zh = 1.999999999999,
			ja = 3.9
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319181021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["4040ui_story"]) and arg_84_1.var_.characterEffect4040ui_story == nil then
				arg_84_1.var_.characterEffect4040ui_story = arg_84_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["4040ui_story"]) then
				if arg_84_1.var_.characterEffect4040ui_story and not isNil(arg_84_1.actors_["4040ui_story"]) then
					arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_84_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["4040ui_story"]) and arg_84_1.var_.characterEffect4040ui_story then
				arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_84_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_87_1 = arg_84_1.actors_["1084ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 and not isNil(var_87_1) then
				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_1) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_87_4 = 0
			local var_87_5 = 0.175

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_6 = arg_84_1:GetWordFromCfg(319181020)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 7 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 7)

				if (7 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 7)) > 0 and var_87_5 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181020", "story_v_out_319181.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181020", "story_v_out_319181.awb") / 1000

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end

					if var_87_6.prefab_name ~= "" and arg_84_1.actors_[var_87_6.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_6.prefab_name].transform, "story_v_out_319181", "319181020", "story_v_out_319181.awb")

						arg_84_1:RecordAudio("319181020", var_87_11)
						arg_84_1:RecordAudio("319181020", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_319181", "319181020", "story_v_out_319181.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_319181", "319181020", "story_v_out_319181.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_12 and arg_84_1.time_ < var_87_4 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play319181021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319181021
		arg_88_1.duration_ = 6.97

		local var_88_0 = {
			zh = 3.5,
			ja = 6.966
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play319181022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["4040ui_story"]) and arg_88_1.var_.characterEffect4040ui_story == nil then
				arg_88_1.var_.characterEffect4040ui_story = arg_88_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["4040ui_story"]) then
				if arg_88_1.var_.characterEffect4040ui_story and not isNil(arg_88_1.actors_["4040ui_story"]) then
					arg_88_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["4040ui_story"]) and arg_88_1.var_.characterEffect4040ui_story then
				arg_88_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_91_2 = arg_88_1.actors_["1084ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_3 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_2) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_3)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_91_4 = 0
			local var_91_5 = 0.4

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(319181021)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 16 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 16)

				if (16 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 16)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181021", "story_v_out_319181.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181021", "story_v_out_319181.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_319181", "319181021", "story_v_out_319181.awb")

						arg_88_1:RecordAudio("319181021", var_91_11)
						arg_88_1:RecordAudio("319181021", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_319181", "319181021", "story_v_out_319181.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_319181", "319181021", "story_v_out_319181.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play319181022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319181022
		arg_92_1.duration_ = 8.37

		local var_92_0 = {
			zh = 2.8,
			ja = 8.366
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play319181023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = arg_92_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).z)
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles = arg_92_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_92_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).z)
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles = arg_92_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_95_1 = arg_92_1.actors_["1084ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_2 and not isNil(var_95_1) then
				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_2 and arg_92_1.time_ < 0 + var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_95_4 = arg_92_1.actors_["4040ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect4040ui_story == nil then
				arg_92_1.var_.characterEffect4040ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_5 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_5 and not isNil(var_95_4) then
				if arg_92_1.var_.characterEffect4040ui_story and not isNil(var_95_4) then
					arg_92_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_92_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_5)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_5 and arg_92_1.time_ < 0 + var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect4040ui_story then
				arg_92_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_92_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_95_6 = 0
			local var_95_7 = 0.3

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:GetWordFromCfg(319181022)
				local var_95_9 = arg_92_1:FormatText(var_95_8.content)

				arg_92_1.text_.text = var_95_9

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 12 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_9) / 12)

				if (12 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_9) / 12)) > 0 and var_95_7 < var_95_11 then
					arg_92_1.talkMaxDuration = var_95_11

					if var_95_11 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_9
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181022", "story_v_out_319181.awb") ~= 0 then
					local var_95_12 = manager.audio:GetVoiceLength("story_v_out_319181", "319181022", "story_v_out_319181.awb") / 1000

					if var_95_12 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_6
					end

					if var_95_8.prefab_name ~= "" and arg_92_1.actors_[var_95_8.prefab_name] ~= nil then
						local var_95_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_8.prefab_name].transform, "story_v_out_319181", "319181022", "story_v_out_319181.awb")

						arg_92_1:RecordAudio("319181022", var_95_13)
						arg_92_1:RecordAudio("319181022", var_95_13)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319181", "319181022", "story_v_out_319181.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319181", "319181022", "story_v_out_319181.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_14 and arg_92_1.time_ < var_95_6 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319181023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 319181023
		arg_96_1.duration_ = 4.8

		local var_96_0 = {
			zh = 2.6,
			ja = 4.8
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play319181024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["4040ui_story"]) and arg_96_1.var_.characterEffect4040ui_story == nil then
				arg_96_1.var_.characterEffect4040ui_story = arg_96_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["4040ui_story"]) then
				if arg_96_1.var_.characterEffect4040ui_story and not isNil(arg_96_1.actors_["4040ui_story"]) then
					arg_96_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["4040ui_story"]) and arg_96_1.var_.characterEffect4040ui_story then
				arg_96_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_99_2 = arg_96_1.actors_["1084ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_3 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.characterEffect1084ui_story and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_3)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1084ui_story then
				arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_99_4 = 0
			local var_99_5 = 0.3

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(319181023)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 12 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 12)

				if (12 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 12)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181023", "story_v_out_319181.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181023", "story_v_out_319181.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_319181", "319181023", "story_v_out_319181.awb")

						arg_96_1:RecordAudio("319181023", var_99_11)
						arg_96_1:RecordAudio("319181023", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_319181", "319181023", "story_v_out_319181.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_319181", "319181023", "story_v_out_319181.awb")
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

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play319181024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319181024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play319181025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["4040ui_story"]) and arg_100_1.var_.characterEffect4040ui_story == nil then
				arg_100_1.var_.characterEffect4040ui_story = arg_100_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["4040ui_story"]) then
				if arg_100_1.var_.characterEffect4040ui_story and not isNil(arg_100_1.actors_["4040ui_story"]) then
					arg_100_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_100_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["4040ui_story"]) and arg_100_1.var_.characterEffect4040ui_story then
				arg_100_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_100_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 1

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(319181024).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 40 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 40)

				if (40 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 40)) > 0 and var_103_2 < var_103_5 then
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
	Play319181025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319181025
		arg_104_1.duration_ = 3.57

		local var_104_0 = {
			zh = 2.8,
			ja = 3.566
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play319181026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["4040ui_story"]) and arg_104_1.var_.characterEffect4040ui_story == nil then
				arg_104_1.var_.characterEffect4040ui_story = arg_104_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["4040ui_story"]) then
				if arg_104_1.var_.characterEffect4040ui_story and not isNil(arg_104_1.actors_["4040ui_story"]) then
					arg_104_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["4040ui_story"]) and arg_104_1.var_.characterEffect4040ui_story then
				arg_104_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_107_2 = 0
			local var_107_3 = 0.25

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(319181025)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 10 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 10)

				if (10 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 10)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181025", "story_v_out_319181.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_319181", "319181025", "story_v_out_319181.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_319181", "319181025", "story_v_out_319181.awb")

						arg_104_1:RecordAudio("319181025", var_107_9)
						arg_104_1:RecordAudio("319181025", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_319181", "319181025", "story_v_out_319181.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_319181", "319181025", "story_v_out_319181.awb")
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
	Play319181026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319181026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play319181027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1084ui_story = arg_108_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).z)
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles = arg_108_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1084ui_story"].transform.position).z)
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1084ui_story"].transform.localEulerAngles = arg_108_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["1084ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1084ui_story == nil then
				arg_108_1.var_.characterEffect1084ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect1084ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_2)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1084ui_story then
				arg_108_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_111_3 = arg_108_1.actors_["4040ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos4040ui_story = var_111_3.localPosition
			end

			local var_111_4 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				var_111_3.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_4)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				var_111_3.localPosition = Vector3.New(0, 100, 0)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			local var_111_5 = arg_108_1.actors_["4040ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_5) and arg_108_1.var_.characterEffect4040ui_story == nil then
				arg_108_1.var_.characterEffect4040ui_story = var_111_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_6 and not isNil(var_111_5) then
				if arg_108_1.var_.characterEffect4040ui_story and not isNil(var_111_5) then
					arg_108_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_6)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_6 and arg_108_1.time_ < 0 + var_111_6 + arg_111_0 and not isNil(var_111_5) and arg_108_1.var_.characterEffect4040ui_story then
				arg_108_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_111_7 = 0
			local var_111_8 = 0.95

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_7 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_9 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(319181026).content)

				arg_108_1.text_.text = var_111_9

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 38 <= 0 and var_111_8 or var_111_8 * (utf8.len(var_111_9) / 38)

				if (38 <= 0 and var_111_8 or var_111_8 * (utf8.len(var_111_9) / 38)) > 0 and var_111_8 < var_111_11 then
					arg_108_1.talkMaxDuration = var_111_11

					if var_111_11 + var_111_7 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_7
					end
				end

				arg_108_1.text_.text = var_111_9
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_8, arg_108_1.talkMaxDuration)

			if var_111_7 <= arg_108_1.time_ and arg_108_1.time_ < var_111_7 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_7) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_7 + var_111_12 and arg_108_1.time_ < var_111_7 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play319181027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319181027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play319181028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 1.55

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(319181027).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 62 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 62)

				if (62 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 62)) > 0 and var_115_0 < var_115_3 then
					arg_112_1.talkMaxDuration = var_115_3

					if var_115_3 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_3 + 0
					end
				end

				arg_112_1.text_.text = var_115_1
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_4 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_4

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319181028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319181028
		arg_116_1.duration_ = 2.93

		local var_116_0 = {
			zh = 2.933,
			ja = 1.999999999999
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play319181029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos4040ui_story = arg_116_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["4040ui_story"].transform.position).z)
				arg_116_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["4040ui_story"].transform.localEulerAngles = arg_116_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_116_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["4040ui_story"].transform.position).z)
				arg_116_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["4040ui_story"].transform.localEulerAngles = arg_116_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["4040ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect4040ui_story == nil then
				arg_116_1.var_.characterEffect4040ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect4040ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect4040ui_story then
				arg_116_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_119_4 = 0
			local var_119_5 = 0.225

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(319181028)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 9 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 9)

				if (9 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 9)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181028", "story_v_out_319181.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181028", "story_v_out_319181.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_319181", "319181028", "story_v_out_319181.awb")

						arg_116_1:RecordAudio("319181028", var_119_11)
						arg_116_1:RecordAudio("319181028", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319181", "319181028", "story_v_out_319181.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319181", "319181028", "story_v_out_319181.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play319181029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319181029
		arg_120_1.duration_ = 4.8

		local var_120_0 = {
			zh = 3.1,
			ja = 4.8
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play319181030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos10066ui_story = arg_120_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_123_0 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 then
				arg_120_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_120_1.time_ - 0) / var_123_0)
				arg_120_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10066ui_story"].transform.position).z)
				arg_120_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["10066ui_story"].transform.localEulerAngles = arg_120_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 then
				arg_120_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_120_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["10066ui_story"].transform.position).z)
				arg_120_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["10066ui_story"].transform.localEulerAngles = arg_120_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_123_1 = arg_120_1.actors_["10066ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect10066ui_story == nil then
				arg_120_1.var_.characterEffect10066ui_story = var_123_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 and not isNil(var_123_1) then
				if arg_120_1.var_.characterEffect10066ui_story and not isNil(var_123_1) then
					arg_120_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect10066ui_story then
				arg_120_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_123_4 = arg_120_1.actors_["4040ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos4040ui_story = var_123_4.localPosition
			end

			local var_123_5 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_5 then
				var_123_4.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_120_1.time_ - 0) / var_123_5)
				var_123_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_4.position).x, (manager.ui.mainCamera.transform.position - var_123_4.position).y, (manager.ui.mainCamera.transform.position - var_123_4.position).z)
				var_123_4.localEulerAngles.z = 0
				var_123_4.localEulerAngles.x = 0
				var_123_4.localEulerAngles = var_123_4.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_5 and arg_120_1.time_ < 0 + var_123_5 + arg_123_0 then
				var_123_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_123_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_4.position).x, (manager.ui.mainCamera.transform.position - var_123_4.position).y, (manager.ui.mainCamera.transform.position - var_123_4.position).z)
				var_123_4.localEulerAngles.z = 0
				var_123_4.localEulerAngles.x = 0
				var_123_4.localEulerAngles = var_123_4.localEulerAngles
			end

			local var_123_6 = arg_120_1.actors_["4040ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect4040ui_story == nil then
				arg_120_1.var_.characterEffect4040ui_story = var_123_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_7 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 and not isNil(var_123_6) then
				if arg_120_1.var_.characterEffect4040ui_story and not isNil(var_123_6) then
					arg_120_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_120_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_7)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect4040ui_story then
				arg_120_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_120_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_123_8 = 0
			local var_123_9 = 0.2

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_8 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_10 = arg_120_1:GetWordFromCfg(319181029)
				local var_123_11 = arg_120_1:FormatText(var_123_10.content)

				arg_120_1.text_.text = var_123_11

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_13 = 8 <= 0 and var_123_9 or var_123_9 * (utf8.len(var_123_11) / 8)

				if (8 <= 0 and var_123_9 or var_123_9 * (utf8.len(var_123_11) / 8)) > 0 and var_123_9 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_8 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_8
					end
				end

				arg_120_1.text_.text = var_123_11
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181029", "story_v_out_319181.awb") ~= 0 then
					local var_123_14 = manager.audio:GetVoiceLength("story_v_out_319181", "319181029", "story_v_out_319181.awb") / 1000

					if var_123_14 + var_123_8 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_8
					end

					if var_123_10.prefab_name ~= "" and arg_120_1.actors_[var_123_10.prefab_name] ~= nil then
						local var_123_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_10.prefab_name].transform, "story_v_out_319181", "319181029", "story_v_out_319181.awb")

						arg_120_1:RecordAudio("319181029", var_123_15)
						arg_120_1:RecordAudio("319181029", var_123_15)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_319181", "319181029", "story_v_out_319181.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_319181", "319181029", "story_v_out_319181.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_9, arg_120_1.talkMaxDuration)

			if var_123_8 <= arg_120_1.time_ and arg_120_1.time_ < var_123_8 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_8) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_8 + var_123_16 and arg_120_1.time_ < var_123_8 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play319181030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319181030
		arg_124_1.duration_ = 7.37

		local var_124_0 = {
			zh = 4.6,
			ja = 7.366
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play319181031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["10066ui_story"]) and arg_124_1.var_.characterEffect10066ui_story == nil then
				arg_124_1.var_.characterEffect10066ui_story = arg_124_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["10066ui_story"]) then
				if arg_124_1.var_.characterEffect10066ui_story and not isNil(arg_124_1.actors_["10066ui_story"]) then
					arg_124_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10066ui_story"]) and arg_124_1.var_.characterEffect10066ui_story then
				arg_124_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_127_1 = arg_124_1.actors_["4040ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect4040ui_story == nil then
				arg_124_1.var_.characterEffect4040ui_story = var_127_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_2 and not isNil(var_127_1) then
				if arg_124_1.var_.characterEffect4040ui_story and not isNil(var_127_1) then
					arg_124_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_2 and arg_124_1.time_ < 0 + var_127_2 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect4040ui_story then
				arg_124_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_127_4 = 0
			local var_127_5 = 0.275

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(319181030)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_9 = 11 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 11)

				if (11 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 11)) > 0 and var_127_5 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181030", "story_v_out_319181.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181030", "story_v_out_319181.awb") / 1000

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end

					if var_127_6.prefab_name ~= "" and arg_124_1.actors_[var_127_6.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_6.prefab_name].transform, "story_v_out_319181", "319181030", "story_v_out_319181.awb")

						arg_124_1:RecordAudio("319181030", var_127_11)
						arg_124_1:RecordAudio("319181030", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_319181", "319181030", "story_v_out_319181.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_319181", "319181030", "story_v_out_319181.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_12 = math.max(var_127_5, arg_124_1.talkMaxDuration)

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_12 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_4) / var_127_12

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_4 + var_127_12 and arg_124_1.time_ < var_127_4 + var_127_12 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play319181031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319181031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play319181032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["4040ui_story"]) and arg_128_1.var_.characterEffect4040ui_story == nil then
				arg_128_1.var_.characterEffect4040ui_story = arg_128_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["4040ui_story"]) then
				if arg_128_1.var_.characterEffect4040ui_story and not isNil(arg_128_1.actors_["4040ui_story"]) then
					arg_128_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_128_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_0)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["4040ui_story"]) and arg_128_1.var_.characterEffect4040ui_story then
				arg_128_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_128_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action443")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_131_1 = 0
			local var_131_2 = 1.175

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(319181031).content)

				arg_128_1.text_.text = var_131_3

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 47 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 47)

				if (47 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 47)) > 0 and var_131_2 < var_131_5 then
					arg_128_1.talkMaxDuration = var_131_5

					if var_131_5 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_3
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_6 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_6 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_6

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_6 and arg_128_1.time_ < var_131_1 + var_131_6 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play319181032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319181032
		arg_132_1.duration_ = 5.5

		local var_132_0 = {
			zh = 4.2,
			ja = 5.5
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play319181033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos4040ui_story = arg_132_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["4040ui_story"].transform.position).z)
				arg_132_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["4040ui_story"].transform.localEulerAngles = arg_132_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_132_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["4040ui_story"].transform.position).z)
				arg_132_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["4040ui_story"].transform.localEulerAngles = arg_132_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_135_1 = arg_132_1.actors_["4040ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect4040ui_story == nil then
				arg_132_1.var_.characterEffect4040ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect4040ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect4040ui_story then
				arg_132_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_135_4 = 0
			local var_135_5 = 0.225

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(319181032)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 9 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 9)

				if (9 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 9)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181032", "story_v_out_319181.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181032", "story_v_out_319181.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_319181", "319181032", "story_v_out_319181.awb")

						arg_132_1:RecordAudio("319181032", var_135_11)
						arg_132_1:RecordAudio("319181032", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319181", "319181032", "story_v_out_319181.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319181", "319181032", "story_v_out_319181.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play319181033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319181033
		arg_136_1.duration_ = 4.53

		local var_136_0 = {
			zh = 2.5,
			ja = 4.533
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play319181034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos10066ui_story = arg_136_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10066ui_story"].transform.position).z)
				arg_136_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["10066ui_story"].transform.localEulerAngles = arg_136_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_136_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10066ui_story"].transform.position).z)
				arg_136_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["10066ui_story"].transform.localEulerAngles = arg_136_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["10066ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect10066ui_story == nil then
				arg_136_1.var_.characterEffect10066ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect10066ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect10066ui_story then
				arg_136_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_139_4 = arg_136_1.actors_["4040ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect4040ui_story == nil then
				arg_136_1.var_.characterEffect4040ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_5 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_5 and not isNil(var_139_4) then
				if arg_136_1.var_.characterEffect4040ui_story and not isNil(var_139_4) then
					arg_136_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_136_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_5)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_5 and arg_136_1.time_ < 0 + var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect4040ui_story then
				arg_136_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_136_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_139_6 = 0
			local var_139_7 = 0.25

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_8 = arg_136_1:GetWordFromCfg(319181033)
				local var_139_9 = arg_136_1:FormatText(var_139_8.content)

				arg_136_1.text_.text = var_139_9

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 10 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_9) / 10)

				if (10 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_9) / 10)) > 0 and var_139_7 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_9
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181033", "story_v_out_319181.awb") ~= 0 then
					local var_139_12 = manager.audio:GetVoiceLength("story_v_out_319181", "319181033", "story_v_out_319181.awb") / 1000

					if var_139_12 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_6
					end

					if var_139_8.prefab_name ~= "" and arg_136_1.actors_[var_139_8.prefab_name] ~= nil then
						local var_139_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_8.prefab_name].transform, "story_v_out_319181", "319181033", "story_v_out_319181.awb")

						arg_136_1:RecordAudio("319181033", var_139_13)
						arg_136_1:RecordAudio("319181033", var_139_13)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_319181", "319181033", "story_v_out_319181.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_319181", "319181033", "story_v_out_319181.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play319181034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319181034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play319181035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["10066ui_story"]) and arg_140_1.var_.characterEffect10066ui_story == nil then
				arg_140_1.var_.characterEffect10066ui_story = arg_140_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["10066ui_story"]) then
				if arg_140_1.var_.characterEffect10066ui_story and not isNil(arg_140_1.actors_["10066ui_story"]) then
					arg_140_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_140_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["10066ui_story"]) and arg_140_1.var_.characterEffect10066ui_story then
				arg_140_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_140_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_143_1 = arg_140_1.actors_["4040ui_story"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos4040ui_story = var_143_1.localPosition
			end

			local var_143_2 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 then
				var_143_1.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_2)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 then
				var_143_1.localPosition = Vector3.New(0, 100, 0)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			local var_143_3 = arg_140_1.actors_["10066ui_story"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos10066ui_story = var_143_3.localPosition
			end

			local var_143_4 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				var_143_3.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_4)
				var_143_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_3.position).x, (manager.ui.mainCamera.transform.position - var_143_3.position).y, (manager.ui.mainCamera.transform.position - var_143_3.position).z)
				var_143_3.localEulerAngles.z = 0
				var_143_3.localEulerAngles.x = 0
				var_143_3.localEulerAngles = var_143_3.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				var_143_3.localPosition = Vector3.New(0, 100, 0)
				var_143_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_3.position).x, (manager.ui.mainCamera.transform.position - var_143_3.position).y, (manager.ui.mainCamera.transform.position - var_143_3.position).z)
				var_143_3.localEulerAngles.z = 0
				var_143_3.localEulerAngles.x = 0
				var_143_3.localEulerAngles = var_143_3.localEulerAngles
			end

			local var_143_5 = 0
			local var_143_6 = 0.875

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_7 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(319181034).content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 35 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_7) / 35)

				if (35 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_7) / 35)) > 0 and var_143_6 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_5
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_6, arg_140_1.talkMaxDuration)

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_5) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_5 + var_143_10 and arg_140_1.time_ < var_143_5 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_140_1:InitPlayNodeList()
	end,
	Play319181035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319181035
		arg_144_1.duration_ = 3.03

		local var_144_0 = {
			zh = 2.6,
			ja = 3.033
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play319181036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if arg_144_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_147_0 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_144_1.stage_.transform)

				var_147_0.name = "10079ui_story"
				var_147_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.actors_["10079ui_story"] = var_147_0

				local var_147_1 = var_147_0:GetComponentInChildren(typeof(CharacterEffect))

				var_147_1.enabled = true

				local var_147_2 = GameObjectTools.GetOrAddComponent(var_147_0, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(false)
				end

				arg_144_1:ShowWeapon(var_147_1.transform, false)

				arg_144_1.var_["10079ui_story" .. "Animator"] = var_147_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_144_1.var_["10079ui_story" .. "Animator"].applyRootMotion = true
				arg_144_1.var_["10079ui_story" .. "LipSync"] = var_147_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_147_3 = arg_144_1.actors_["10079ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos10079ui_story = var_147_3.localPosition
			end

			local var_147_4 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				var_147_3.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_144_1.time_ - 0) / var_147_4)
				var_147_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_3.position).x, (manager.ui.mainCamera.transform.position - var_147_3.position).y, (manager.ui.mainCamera.transform.position - var_147_3.position).z)
				var_147_3.localEulerAngles.z = 0
				var_147_3.localEulerAngles.x = 0
				var_147_3.localEulerAngles = var_147_3.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				var_147_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_147_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_3.position).x, (manager.ui.mainCamera.transform.position - var_147_3.position).y, (manager.ui.mainCamera.transform.position - var_147_3.position).z)
				var_147_3.localEulerAngles.z = 0
				var_147_3.localEulerAngles.x = 0
				var_147_3.localEulerAngles = var_147_3.localEulerAngles
			end

			local var_147_5 = arg_144_1.actors_["10079ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_5) and arg_144_1.var_.characterEffect10079ui_story == nil then
				arg_144_1.var_.characterEffect10079ui_story = var_147_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_6 and not isNil(var_147_5) then
				if arg_144_1.var_.characterEffect10079ui_story and not isNil(var_147_5) then
					arg_144_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_6 and arg_144_1.time_ < 0 + var_147_6 + arg_147_0 and not isNil(var_147_5) and arg_144_1.var_.characterEffect10079ui_story then
				arg_144_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_147_8 = 0
			local var_147_9 = 0.25

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_10 = arg_144_1:GetWordFromCfg(319181035)
				local var_147_11 = arg_144_1:FormatText(var_147_10.content)

				arg_144_1.text_.text = var_147_11

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_13 = 10 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 10)

				if (10 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 10)) > 0 and var_147_9 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_11
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181035", "story_v_out_319181.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_out_319181", "319181035", "story_v_out_319181.awb") / 1000

					if var_147_14 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_8
					end

					if var_147_10.prefab_name ~= "" and arg_144_1.actors_[var_147_10.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_10.prefab_name].transform, "story_v_out_319181", "319181035", "story_v_out_319181.awb")

						arg_144_1:RecordAudio("319181035", var_147_15)
						arg_144_1:RecordAudio("319181035", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319181", "319181035", "story_v_out_319181.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319181", "319181035", "story_v_out_319181.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_16 and arg_144_1.time_ < var_147_8 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play319181036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 319181036
		arg_148_1.duration_ = 5.1

		local var_148_0 = {
			zh = 5.066,
			ja = 5.1
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play319181037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos4040ui_story = arg_148_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["4040ui_story"].transform.position).z)
				arg_148_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["4040ui_story"].transform.localEulerAngles = arg_148_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_148_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["4040ui_story"].transform.position).z)
				arg_148_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["4040ui_story"].transform.localEulerAngles = arg_148_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["4040ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect4040ui_story == nil then
				arg_148_1.var_.characterEffect4040ui_story = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect4040ui_story and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect4040ui_story then
				arg_148_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_4 = arg_148_1.actors_["10079ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos10079ui_story = var_151_4.localPosition
			end

			local var_151_5 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_5 then
				var_151_4.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_148_1.time_ - 0) / var_151_5)
				var_151_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_4.position).x, (manager.ui.mainCamera.transform.position - var_151_4.position).y, (manager.ui.mainCamera.transform.position - var_151_4.position).z)
				var_151_4.localEulerAngles.z = 0
				var_151_4.localEulerAngles.x = 0
				var_151_4.localEulerAngles = var_151_4.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_5 and arg_148_1.time_ < 0 + var_151_5 + arg_151_0 then
				var_151_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_151_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_4.position).x, (manager.ui.mainCamera.transform.position - var_151_4.position).y, (manager.ui.mainCamera.transform.position - var_151_4.position).z)
				var_151_4.localEulerAngles.z = 0
				var_151_4.localEulerAngles.x = 0
				var_151_4.localEulerAngles = var_151_4.localEulerAngles
			end

			local var_151_6 = arg_148_1.actors_["10079ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_6) and arg_148_1.var_.characterEffect10079ui_story == nil then
				arg_148_1.var_.characterEffect10079ui_story = var_151_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_7 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 and not isNil(var_151_6) then
				if arg_148_1.var_.characterEffect10079ui_story and not isNil(var_151_6) then
					arg_148_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_7)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 and not isNil(var_151_6) and arg_148_1.var_.characterEffect10079ui_story then
				arg_148_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_151_8 = 0
			local var_151_9 = 0.6

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_8 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_10 = arg_148_1:GetWordFromCfg(319181036)
				local var_151_11 = arg_148_1:FormatText(var_151_10.content)

				arg_148_1.text_.text = var_151_11

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_13 = 24 <= 0 and var_151_9 or var_151_9 * (utf8.len(var_151_11) / 24)

				if (24 <= 0 and var_151_9 or var_151_9 * (utf8.len(var_151_11) / 24)) > 0 and var_151_9 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_8
					end
				end

				arg_148_1.text_.text = var_151_11
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181036", "story_v_out_319181.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_319181", "319181036", "story_v_out_319181.awb") / 1000

					if var_151_14 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_8
					end

					if var_151_10.prefab_name ~= "" and arg_148_1.actors_[var_151_10.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_10.prefab_name].transform, "story_v_out_319181", "319181036", "story_v_out_319181.awb")

						arg_148_1:RecordAudio("319181036", var_151_15)
						arg_148_1:RecordAudio("319181036", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_319181", "319181036", "story_v_out_319181.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_319181", "319181036", "story_v_out_319181.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_9, arg_148_1.talkMaxDuration)

			if var_151_8 <= arg_148_1.time_ and arg_148_1.time_ < var_151_8 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_8) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_8 + var_151_16 and arg_148_1.time_ < var_151_8 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319181037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 319181037
		arg_152_1.duration_ = 6.1

		local var_152_0 = {
			zh = 6.1,
			ja = 5.633
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play319181038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.675

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:GetWordFromCfg(319181037)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 27 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 27)

				if (27 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 27)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181037", "story_v_out_319181.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_319181", "319181037", "story_v_out_319181.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_319181", "319181037", "story_v_out_319181.awb")

						arg_152_1:RecordAudio("319181037", var_155_6)
						arg_152_1:RecordAudio("319181037", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319181", "319181037", "story_v_out_319181.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319181", "319181037", "story_v_out_319181.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play319181038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319181038
		arg_156_1.duration_ = 2.2

		local var_156_0 = {
			zh = 2.2,
			ja = 1.999999999999
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play319181039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10079ui_story = arg_156_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10079ui_story"].transform.position).z)
				arg_156_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["10079ui_story"].transform.localEulerAngles = arg_156_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_156_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["10079ui_story"].transform.position).z)
				arg_156_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["10079ui_story"].transform.localEulerAngles = arg_156_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["10079ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect10079ui_story == nil then
				arg_156_1.var_.characterEffect10079ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect10079ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect10079ui_story then
				arg_156_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4127")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_159_4 = arg_156_1.actors_["4040ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect4040ui_story == nil then
				arg_156_1.var_.characterEffect4040ui_story = var_159_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_5 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_5 and not isNil(var_159_4) then
				if arg_156_1.var_.characterEffect4040ui_story and not isNil(var_159_4) then
					arg_156_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_156_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_5)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_5 and arg_156_1.time_ < 0 + var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect4040ui_story then
				arg_156_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_156_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_159_6 = 0
			local var_159_7 = 0.2

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:GetWordFromCfg(319181038)
				local var_159_9 = arg_156_1:FormatText(var_159_8.content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 8 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 8)

				if (8 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 8)) > 0 and var_159_7 < var_159_11 then
					arg_156_1.talkMaxDuration = var_159_11

					if var_159_11 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181038", "story_v_out_319181.awb") ~= 0 then
					local var_159_12 = manager.audio:GetVoiceLength("story_v_out_319181", "319181038", "story_v_out_319181.awb") / 1000

					if var_159_12 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_6
					end

					if var_159_8.prefab_name ~= "" and arg_156_1.actors_[var_159_8.prefab_name] ~= nil then
						local var_159_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_8.prefab_name].transform, "story_v_out_319181", "319181038", "story_v_out_319181.awb")

						arg_156_1:RecordAudio("319181038", var_159_13)
						arg_156_1:RecordAudio("319181038", var_159_13)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319181", "319181038", "story_v_out_319181.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319181", "319181038", "story_v_out_319181.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_14 and arg_156_1.time_ < var_159_6 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play319181039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319181039
		arg_160_1.duration_ = 7.43

		local var_160_0 = {
			zh = 7.433,
			ja = 6.033
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play319181040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["10079ui_story"]) and arg_160_1.var_.characterEffect10079ui_story == nil then
				arg_160_1.var_.characterEffect10079ui_story = arg_160_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["10079ui_story"]) then
				if arg_160_1.var_.characterEffect10079ui_story and not isNil(arg_160_1.actors_["10079ui_story"]) then
					arg_160_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_160_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["10079ui_story"]) and arg_160_1.var_.characterEffect10079ui_story then
				arg_160_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_160_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_163_1 = arg_160_1.actors_["4040ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_1) and arg_160_1.var_.characterEffect4040ui_story == nil then
				arg_160_1.var_.characterEffect4040ui_story = var_163_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_2 and not isNil(var_163_1) then
				if arg_160_1.var_.characterEffect4040ui_story and not isNil(var_163_1) then
					arg_160_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_2 and arg_160_1.time_ < 0 + var_163_2 + arg_163_0 and not isNil(var_163_1) and arg_160_1.var_.characterEffect4040ui_story then
				arg_160_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_163_4 = 0
			local var_163_5 = 0.825

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_6 = arg_160_1:GetWordFromCfg(319181039)
				local var_163_7 = arg_160_1:FormatText(var_163_6.content)

				arg_160_1.text_.text = var_163_7

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_9 = 33 <= 0 and var_163_5 or var_163_5 * (utf8.len(var_163_7) / 33)

				if (33 <= 0 and var_163_5 or var_163_5 * (utf8.len(var_163_7) / 33)) > 0 and var_163_5 < var_163_9 then
					arg_160_1.talkMaxDuration = var_163_9

					if var_163_9 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_4
					end
				end

				arg_160_1.text_.text = var_163_7
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181039", "story_v_out_319181.awb") ~= 0 then
					local var_163_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181039", "story_v_out_319181.awb") / 1000

					if var_163_10 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_4
					end

					if var_163_6.prefab_name ~= "" and arg_160_1.actors_[var_163_6.prefab_name] ~= nil then
						local var_163_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_6.prefab_name].transform, "story_v_out_319181", "319181039", "story_v_out_319181.awb")

						arg_160_1:RecordAudio("319181039", var_163_11)
						arg_160_1:RecordAudio("319181039", var_163_11)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319181", "319181039", "story_v_out_319181.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319181", "319181039", "story_v_out_319181.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_12 = math.max(var_163_5, arg_160_1.talkMaxDuration)

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_12 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_4) / var_163_12

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_4 + var_163_12 and arg_160_1.time_ < var_163_4 + var_163_12 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play319181040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319181040
		arg_164_1.duration_ = 4.07

		local var_164_0 = {
			zh = 4.066,
			ja = 2.6
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
			arg_164_1.auto_ = false
		end

		function arg_164_1.playNext_(arg_166_0)
			arg_164_1.onStoryFinished_()
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos4040ui_story = arg_164_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_167_0 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 then
				arg_164_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_164_1.time_ - 0) / var_167_0)
				arg_164_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["4040ui_story"].transform.position).z)
				arg_164_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["4040ui_story"].transform.localEulerAngles = arg_164_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 then
				arg_164_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_164_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["4040ui_story"].transform.position).z)
				arg_164_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["4040ui_story"].transform.localEulerAngles = arg_164_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_167_1 = arg_164_1.actors_["4040ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_1) and arg_164_1.var_.characterEffect4040ui_story == nil then
				arg_164_1.var_.characterEffect4040ui_story = var_167_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_2 and not isNil(var_167_1) then
				if arg_164_1.var_.characterEffect4040ui_story and not isNil(var_167_1) then
					arg_164_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_2 and arg_164_1.time_ < 0 + var_167_2 + arg_167_0 and not isNil(var_167_1) and arg_164_1.var_.characterEffect4040ui_story then
				arg_164_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_167_4 = 0
			local var_167_5 = 0.4

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_6 = arg_164_1:GetWordFromCfg(319181040)
				local var_167_7 = arg_164_1:FormatText(var_167_6.content)

				arg_164_1.text_.text = var_167_7

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_9 = 16 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 16)

				if (16 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 16)) > 0 and var_167_5 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_4
					end
				end

				arg_164_1.text_.text = var_167_7
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319181", "319181040", "story_v_out_319181.awb") ~= 0 then
					local var_167_10 = manager.audio:GetVoiceLength("story_v_out_319181", "319181040", "story_v_out_319181.awb") / 1000

					if var_167_10 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_4
					end

					if var_167_6.prefab_name ~= "" and arg_164_1.actors_[var_167_6.prefab_name] ~= nil then
						local var_167_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_6.prefab_name].transform, "story_v_out_319181", "319181040", "story_v_out_319181.awb")

						arg_164_1:RecordAudio("319181040", var_167_11)
						arg_164_1:RecordAudio("319181040", var_167_11)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_319181", "319181040", "story_v_out_319181.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_319181", "319181040", "story_v_out_319181.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_12 = math.max(var_167_5, arg_164_1.talkMaxDuration)

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_12 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_4) / var_167_12

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_4 + var_167_12 and arg_164_1.time_ < var_167_4 + var_167_12 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/D02a"
	},
	voices = {
		"story_v_out_319181.awb"
	}
}
