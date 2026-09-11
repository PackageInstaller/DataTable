return {
	Play101091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101091001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			local var_4_3 = "B06a"

			if arg_1_1.bgs_.B06a == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.B06a:GetComponent("SpriteRenderer")

				if var_4_5 then
					arg_1_1.var_.alphaOldValueB06a = var_4_5.color.a
					arg_1_1.var_.alphaMatValueB06a = var_4_5
				end

				arg_1_1.var_.alphaOldValueB06a = 0
			end

			local var_4_6 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_6 then
				if arg_1_1.var_.alphaMatValueB06a then
					arg_1_1.var_.alphaMatValueB06a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB06a, 1, (arg_1_1.time_ - 0) / var_4_6)
					arg_1_1.var_.alphaMatValueB06a.color = arg_1_1.var_.alphaMatValueB06a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_6 and arg_1_1.time_ < 0 + var_4_6 + arg_4_0 and arg_1_1.var_.alphaMatValueB06a then
				arg_1_1.var_.alphaMatValueB06a.color.a = 1
				arg_1_1.var_.alphaMatValueB06a.color = arg_1_1.var_.alphaMatValueB06a.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.B06a

				arg_1_1.bgs_.B06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = 2 * (var_4_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_7.transform.localScale = Vector3.New(var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, var_4_9 / var_4_8.sprite.bounds.size.y < var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x and var_4_9 * manager.ui.mainCameraCom_.aspect / var_4_8.sprite.bounds.size.x or var_4_9 / var_4_8.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_10 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_10 + 2 and arg_1_1.time_ < var_4_10 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 0.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(101091001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 7 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 7)

				if (7 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 7)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play101091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101091002
		arg_8_1.duration_ = 6.07

		local var_8_0 = {
			ja = 3.466,
			ko = 3.1,
			zh = 6.066,
			en = 4.7
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
				arg_8_0:Play101091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1019ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1019ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1019ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1019ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1019ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["1019ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_6.localPosition
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_6.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_8_1.time_ - 0) / var_11_7)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_6.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_11_8 = 0
			local var_11_9 = 0.45

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(101091002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 18 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 18)

				if (18 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 18)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101091", "101091002", "story_v_out_101091.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_101091", "101091002", "story_v_out_101091.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_101091", "101091002", "story_v_out_101091.awb")

						arg_8_1:RecordAudio("101091002", var_11_15)
						arg_8_1:RecordAudio("101091002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101091", "101091002", "story_v_out_101091.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101091", "101091002", "story_v_out_101091.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play101091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101091003
		arg_12_1.duration_ = 9

		local var_12_0 = {
			ja = 6.833,
			ko = 8.666,
			zh = 8.5,
			en = 9
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play101091004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1084ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1084ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1084ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1084ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_6 = arg_12_1.actors_["1019ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 and not isNil(var_15_6) then
				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_6) then
					arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_7)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect1019ui_story then
				arg_12_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_15_8 = arg_12_1.actors_["1084ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_8.localPosition
			end

			local var_15_9 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_9 then
				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_12_1.time_ - 0) / var_15_9)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_9 and arg_12_1.time_ < 0 + var_15_9 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(0.7, -0.97, -6)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_15_10 = 0
			local var_15_11 = 0.95

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(101091003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 37 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 37)

				if (37 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 37)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101091", "101091003", "story_v_out_101091.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_101091", "101091003", "story_v_out_101091.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_101091", "101091003", "story_v_out_101091.awb")

						arg_12_1:RecordAudio("101091003", var_15_17)
						arg_12_1:RecordAudio("101091003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_101091", "101091003", "story_v_out_101091.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_101091", "101091003", "story_v_out_101091.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_18 and arg_12_1.time_ < var_15_10 + var_15_18 + arg_15_0 then
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play101091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101091004
		arg_16_1.duration_ = 3.67

		local var_16_0 = {
			ja = 2.366,
			ko = 3.666,
			zh = 2.966,
			en = 3.166
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
				arg_16_0:Play101091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1011ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1011ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1011ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1011ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1011ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1011ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1011ui_story then
				arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["1084ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 and not isNil(var_19_6) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_6) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_7)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_19_8 = arg_16_1.actors_["1084ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_8.localPosition
			end

			local var_19_9 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_9 then
				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_9)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_9 and arg_16_1.time_ < 0 + var_19_9 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0, 100, 0)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			local var_19_10 = arg_16_1.actors_["1011ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1011ui_story = var_19_10.localPosition
			end

			local var_19_11 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_11 then
				var_19_10.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_16_1.time_ - 0) / var_19_11)
				var_19_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_10.position).x, (manager.ui.mainCamera.transform.position - var_19_10.position).y, (manager.ui.mainCamera.transform.position - var_19_10.position).z)
				var_19_10.localEulerAngles.z = 0
				var_19_10.localEulerAngles.x = 0
				var_19_10.localEulerAngles = var_19_10.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_11 and arg_16_1.time_ < 0 + var_19_11 + arg_19_0 then
				var_19_10.localPosition = Vector3.New(0.7, -0.71, -6)
				var_19_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_10.position).x, (manager.ui.mainCamera.transform.position - var_19_10.position).y, (manager.ui.mainCamera.transform.position - var_19_10.position).z)
				var_19_10.localEulerAngles.z = 0
				var_19_10.localEulerAngles.x = 0
				var_19_10.localEulerAngles = var_19_10.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_19_12 = 0
			local var_19_13 = 0.3

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_14 = arg_16_1:GetWordFromCfg(101091004)
				local var_19_15 = arg_16_1:FormatText(var_19_14.content)

				arg_16_1.text_.text = var_19_15

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 12 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 12)

				if (12 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 12)) > 0 and var_19_13 < var_19_17 then
					arg_16_1.talkMaxDuration = var_19_17

					if var_19_17 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_15
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101091", "101091004", "story_v_out_101091.awb") ~= 0 then
					local var_19_18 = manager.audio:GetVoiceLength("story_v_out_101091", "101091004", "story_v_out_101091.awb") / 1000

					if var_19_18 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_18 + var_19_12
					end

					if var_19_14.prefab_name ~= "" and arg_16_1.actors_[var_19_14.prefab_name] ~= nil then
						local var_19_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_14.prefab_name].transform, "story_v_out_101091", "101091004", "story_v_out_101091.awb")

						arg_16_1:RecordAudio("101091004", var_19_19)
						arg_16_1:RecordAudio("101091004", var_19_19)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101091", "101091004", "story_v_out_101091.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101091", "101091004", "story_v_out_101091.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_20 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_20 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_20

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_20 and arg_16_1.time_ < var_19_12 + var_19_20 + arg_19_0 then
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play101091005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101091005
		arg_20_1.duration_ = 9.47

		local var_20_0 = {
			ja = 7.833,
			ko = 8.666,
			zh = 9.466,
			en = 9.033
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
			arg_20_1.auto_ = false
		end

		function arg_20_1.playNext_(arg_22_0)
			arg_20_1.onStoryFinished_()
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = arg_20_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) then
				if arg_20_1.var_.characterEffect1019ui_story and not isNil(arg_20_1.actors_["1019ui_story"]) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1011ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1011ui_story == nil then
				arg_20_1.var_.characterEffect1011ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1011ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1011ui_story then
				arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_23_4 = arg_20_1.actors_["1011ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1011ui_story = var_23_4.localPosition
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_4.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_20_1.time_ - 0) / var_23_5)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_4.localPosition = Vector3.New(0.7, -0.71, -6)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			local var_23_6 = arg_20_1.actors_["1019ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_6.localPosition
			end

			local var_23_7 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_20_1.time_ - 0) / var_23_7)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_23_8 = 0
			local var_23_9 = 1.025

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:GetWordFromCfg(101091005)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 41 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 41)

				if (41 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 41)) > 0 and var_23_9 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101091", "101091005", "story_v_out_101091.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_101091", "101091005", "story_v_out_101091.awb") / 1000

					if var_23_14 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_8
					end

					if var_23_10.prefab_name ~= "" and arg_20_1.actors_[var_23_10.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_10.prefab_name].transform, "story_v_out_101091", "101091005", "story_v_out_101091.awb")

						arg_20_1:RecordAudio("101091005", var_23_15)
						arg_20_1:RecordAudio("101091005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101091", "101091005", "story_v_out_101091.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101091", "101091005", "story_v_out_101091.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_9, arg_20_1.talkMaxDuration)

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_8) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_8 + var_23_16 and arg_20_1.time_ < var_23_8 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_20_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B06a"
	},
	voices = {
		"story_v_out_101091.awb"
	}
}
