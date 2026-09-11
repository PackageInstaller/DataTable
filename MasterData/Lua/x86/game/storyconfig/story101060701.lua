return {
	Play106071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play106071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST10 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_4_0.name = "ST10"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST10 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST10:GetComponent("SpriteRenderer")

				if var_4_1 then
					arg_1_1.var_.alphaOldValueST10 = var_4_1.color.a
					arg_1_1.var_.alphaMatValueST10 = var_4_1
				end

				arg_1_1.var_.alphaOldValueST10 = 0
			end

			local var_4_2 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_2 then
				if arg_1_1.var_.alphaMatValueST10 then
					arg_1_1.var_.alphaMatValueST10.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueST10, 1, (arg_1_1.time_ - 0) / var_4_2)
					arg_1_1.var_.alphaMatValueST10.color = arg_1_1.var_.alphaMatValueST10.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_2 and arg_1_1.time_ < 0 + var_4_2 + arg_4_0 and arg_1_1.var_.alphaMatValueST10 then
				arg_1_1.var_.alphaMatValueST10.color.a = 1
				arg_1_1.var_.alphaMatValueST10.color = arg_1_1.var_.alphaMatValueST10.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_3 = arg_1_1.bgs_.ST10

				arg_1_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_4 = var_4_3:GetComponent("SpriteRenderer")

				if var_4_4 and var_4_4.sprite then
					local var_4_5 = 2 * (var_4_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_3.transform.localScale = Vector3.New(var_4_5 / var_4_4.sprite.bounds.size.y < var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x and var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x or var_4_5 / var_4_4.sprite.bounds.size.y, var_4_5 / var_4_4.sprite.bounds.size.y < var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x and var_4_5 * manager.ui.mainCameraCom_.aspect / var_4_4.sprite.bounds.size.x or var_4_5 / var_4_4.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST10" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_8 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_9 + 1.5 and arg_1_1.time_ < var_4_9 + 1.5 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_10 = 2
			local var_4_11 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_13 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(106071001).content)

				arg_1_1.text_.text = var_4_13

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_15 = 11 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 11)

				if (11 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 11)) > 0 and var_4_11 < var_4_15 then
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
	Play106071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106071002
		arg_8_1.duration_ = 4.5

		local var_8_0 = {
			ja = 4.333,
			ko = 4.5,
			zh = 3.066,
			en = 1.999999999999
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
				arg_8_0:Play106071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1026ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1026ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1026ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1026ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1026ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1026ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1026ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1026ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1026ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1026ui_story == nil then
				arg_8_1.var_.characterEffect1026ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1026ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1026ui_story then
				arg_8_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action4_1")
			end

			local var_11_6 = arg_8_1.actors_["1026ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1026ui_story = var_11_6.localPosition
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_6.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1026ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_8_1.time_ - 0) / var_11_7)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_6.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			local var_11_8 = "1099ui_story"

			if arg_8_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_11_9 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_8_1.stage_.transform)

				var_11_9.name = var_11_8
				var_11_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_[var_11_8] = var_11_9

				local var_11_10 = var_11_9:GetComponentInChildren(typeof(CharacterEffect))

				var_11_10.enabled = true

				local var_11_11 = GameObjectTools.GetOrAddComponent(var_11_9, typeof(DynamicBoneHelper))

				if var_11_11 then
					var_11_11:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_10.transform, false)

				arg_8_1.var_[var_11_8 .. "Animator"] = var_11_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_[var_11_8 .. "Animator"].applyRootMotion = true
				arg_8_1.var_[var_11_8 .. "LipSync"] = var_11_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_11_12 = 0.2
			local var_11_13 = 0.15

			if 0.2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_14 = arg_8_1:GetWordFromCfg(106071002)
				local var_11_15 = arg_8_1:FormatText(var_11_14.content)

				arg_8_1.text_.text = var_11_15

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_17 = 6 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_15) / 6)

				if (6 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_15) / 6)) > 0 and var_11_13 < var_11_17 then
					arg_8_1.talkMaxDuration = var_11_17

					if var_11_17 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_17 + var_11_12
					end
				end

				arg_8_1.text_.text = var_11_15
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071002", "story_v_out_106071.awb") ~= 0 then
					local var_11_18 = manager.audio:GetVoiceLength("story_v_out_106071", "106071002", "story_v_out_106071.awb") / 1000

					if var_11_18 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_18 + var_11_12
					end

					if var_11_14.prefab_name ~= "" and arg_8_1.actors_[var_11_14.prefab_name] ~= nil then
						local var_11_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_14.prefab_name].transform, "story_v_out_106071", "106071002", "story_v_out_106071.awb")

						arg_8_1:RecordAudio("106071002", var_11_19)
						arg_8_1:RecordAudio("106071002", var_11_19)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_106071", "106071002", "story_v_out_106071.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_106071", "106071002", "story_v_out_106071.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_20 = math.max(var_11_13, arg_8_1.talkMaxDuration)

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_20 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_12) / var_11_20

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_12 + var_11_20 and arg_8_1.time_ < var_11_12 + var_11_20 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
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
	Play106071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106071003
		arg_12_1.duration_ = 1.4

		local var_12_0 = {
			ja = 1.066,
			ko = 0.999999999999,
			zh = 1.4,
			en = 0.999999999999
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
				arg_12_0:Play106071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1099ui_story"]) and arg_12_1.var_.characterEffect1099ui_story == nil then
				arg_12_1.var_.characterEffect1099ui_story = arg_12_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1099ui_story"]) then
				if arg_12_1.var_.characterEffect1099ui_story and not isNil(arg_12_1.actors_["1099ui_story"]) then
					arg_12_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1099ui_story"]) and arg_12_1.var_.characterEffect1099ui_story then
				arg_12_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_15_2 = arg_12_1.actors_["1026ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect1026ui_story == nil then
				arg_12_1.var_.characterEffect1026ui_story = var_15_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_3 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 and not isNil(var_15_2) then
				if arg_12_1.var_.characterEffect1026ui_story and not isNil(var_15_2) then
					arg_12_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_3)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.characterEffect1026ui_story then
				arg_12_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_15_4 = arg_12_1.actors_["1099ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1099ui_story = var_15_4.localPosition
			end

			local var_15_5 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_5 then
				var_15_4.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_12_1.time_ - 0) / var_15_5)
				var_15_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_4.position).x, (manager.ui.mainCamera.transform.position - var_15_4.position).y, (manager.ui.mainCamera.transform.position - var_15_4.position).z)
				var_15_4.localEulerAngles.z = 0
				var_15_4.localEulerAngles.x = 0
				var_15_4.localEulerAngles = var_15_4.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_5 and arg_12_1.time_ < 0 + var_15_5 + arg_15_0 then
				var_15_4.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_15_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_4.position).x, (manager.ui.mainCamera.transform.position - var_15_4.position).y, (manager.ui.mainCamera.transform.position - var_15_4.position).z)
				var_15_4.localEulerAngles.z = 0
				var_15_4.localEulerAngles.x = 0
				var_15_4.localEulerAngles = var_15_4.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_15_6 = 0
			local var_15_7 = 0.05

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:GetWordFromCfg(106071003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 2 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 2)

				if (2 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 2)) > 0 and var_15_7 < var_15_11 then
					arg_12_1.talkMaxDuration = var_15_11

					if var_15_11 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_11 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071003", "story_v_out_106071.awb") ~= 0 then
					local var_15_12 = manager.audio:GetVoiceLength("story_v_out_106071", "106071003", "story_v_out_106071.awb") / 1000

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end

					if var_15_8.prefab_name ~= "" and arg_12_1.actors_[var_15_8.prefab_name] ~= nil then
						local var_15_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_8.prefab_name].transform, "story_v_out_106071", "106071003", "story_v_out_106071.awb")

						arg_12_1:RecordAudio("106071003", var_15_13)
						arg_12_1:RecordAudio("106071003", var_15_13)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_106071", "106071003", "story_v_out_106071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_106071", "106071003", "story_v_out_106071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
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
	Play106071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106071004
		arg_16_1.duration_ = 5.77

		local var_16_0 = {
			ja = 3.933,
			ko = 3.433,
			zh = 5.766,
			en = 5.5
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
				arg_16_0:Play106071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1026ui_story"]) and arg_16_1.var_.characterEffect1026ui_story == nil then
				arg_16_1.var_.characterEffect1026ui_story = arg_16_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1026ui_story"]) then
				if arg_16_1.var_.characterEffect1026ui_story and not isNil(arg_16_1.actors_["1026ui_story"]) then
					arg_16_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1026ui_story"]) and arg_16_1.var_.characterEffect1026ui_story then
				arg_16_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_19_2 = arg_16_1.actors_["1099ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect1099ui_story == nil then
				arg_16_1.var_.characterEffect1099ui_story = var_19_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_3 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.characterEffect1099ui_story and not isNil(var_19_2) then
					arg_16_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_3)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect1099ui_story then
				arg_16_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action4_2")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_19_4 = 0
			local var_19_5 = 0.525

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_6 = arg_16_1:GetWordFromCfg(106071004)
				local var_19_7 = arg_16_1:FormatText(var_19_6.content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 21 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 21)

				if (21 <= 0 and var_19_5 or var_19_5 * (utf8.len(var_19_7) / 21)) > 0 and var_19_5 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071004", "story_v_out_106071.awb") ~= 0 then
					local var_19_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071004", "story_v_out_106071.awb") / 1000

					if var_19_10 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_4
					end

					if var_19_6.prefab_name ~= "" and arg_16_1.actors_[var_19_6.prefab_name] ~= nil then
						local var_19_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_6.prefab_name].transform, "story_v_out_106071", "106071004", "story_v_out_106071.awb")

						arg_16_1:RecordAudio("106071004", var_19_11)
						arg_16_1:RecordAudio("106071004", var_19_11)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_106071", "106071004", "story_v_out_106071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_106071", "106071004", "story_v_out_106071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_12 and arg_16_1.time_ < var_19_4 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play106071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106071005
		arg_20_1.duration_ = 2.17

		local var_20_0 = {
			ja = 1.366,
			ko = 1,
			zh = 2.166,
			en = 1.4
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
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play106071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1099ui_story"]) and arg_20_1.var_.characterEffect1099ui_story == nil then
				arg_20_1.var_.characterEffect1099ui_story = arg_20_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1099ui_story"]) then
				if arg_20_1.var_.characterEffect1099ui_story and not isNil(arg_20_1.actors_["1099ui_story"]) then
					arg_20_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1099ui_story"]) and arg_20_1.var_.characterEffect1099ui_story then
				arg_20_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1026ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1026ui_story == nil then
				arg_20_1.var_.characterEffect1026ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1026ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1026ui_story then
				arg_20_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_23_4 = 0
			local var_23_5 = 0.1

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(106071005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 4 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 4)

				if (4 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 4)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071005", "story_v_out_106071.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071005", "story_v_out_106071.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_106071", "106071005", "story_v_out_106071.awb")

						arg_20_1:RecordAudio("106071005", var_23_11)
						arg_20_1:RecordAudio("106071005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106071", "106071005", "story_v_out_106071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106071", "106071005", "story_v_out_106071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_12 and arg_20_1.time_ < var_23_4 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play106071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106071006
		arg_24_1.duration_ = 8.6

		local var_24_0 = {
			ja = 8.6,
			ko = 1.999999999999,
			zh = 2.633,
			en = 1.999999999999
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play106071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action434")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_27_0 = 0
			local var_27_1 = 0.25

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(106071006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 10 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 10)

				if (10 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 10)) > 0 and var_27_1 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071006", "story_v_out_106071.awb") ~= 0 then
					local var_27_6 = manager.audio:GetVoiceLength("story_v_out_106071", "106071006", "story_v_out_106071.awb") / 1000

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end

					if var_27_2.prefab_name ~= "" and arg_24_1.actors_[var_27_2.prefab_name] ~= nil then
						local var_27_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_2.prefab_name].transform, "story_v_out_106071", "106071006", "story_v_out_106071.awb")

						arg_24_1:RecordAudio("106071006", var_27_7)
						arg_24_1:RecordAudio("106071006", var_27_7)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_106071", "106071006", "story_v_out_106071.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_106071", "106071006", "story_v_out_106071.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play106071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106071007
		arg_28_1.duration_ = 4.6

		local var_28_0 = {
			ja = 3.033,
			ko = 4.6,
			zh = 3,
			en = 2.8
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play106071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1026ui_story"]) and arg_28_1.var_.characterEffect1026ui_story == nil then
				arg_28_1.var_.characterEffect1026ui_story = arg_28_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1026ui_story"]) then
				if arg_28_1.var_.characterEffect1026ui_story and not isNil(arg_28_1.actors_["1026ui_story"]) then
					arg_28_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1026ui_story"]) and arg_28_1.var_.characterEffect1026ui_story then
				arg_28_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["1099ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1099ui_story == nil then
				arg_28_1.var_.characterEffect1099ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1099ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1099ui_story then
				arg_28_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action6_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_31_4 = 0
			local var_31_5 = 0.25

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(106071007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 10 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 10)

				if (10 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 10)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071007", "story_v_out_106071.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071007", "story_v_out_106071.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_106071", "106071007", "story_v_out_106071.awb")

						arg_28_1:RecordAudio("106071007", var_31_11)
						arg_28_1:RecordAudio("106071007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_106071", "106071007", "story_v_out_106071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_106071", "106071007", "story_v_out_106071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play106071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106071008
		arg_32_1.duration_ = 10.97

		local var_32_0 = {
			ja = 10.966,
			ko = 7.033,
			zh = 9.166,
			en = 9.566
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
				arg_32_0:Play106071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1099ui_story"]) and arg_32_1.var_.characterEffect1099ui_story == nil then
				arg_32_1.var_.characterEffect1099ui_story = arg_32_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1099ui_story"]) then
				if arg_32_1.var_.characterEffect1099ui_story and not isNil(arg_32_1.actors_["1099ui_story"]) then
					arg_32_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1099ui_story"]) and arg_32_1.var_.characterEffect1099ui_story then
				arg_32_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["1026ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1026ui_story == nil then
				arg_32_1.var_.characterEffect1026ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect1026ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1026ui_story then
				arg_32_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_35_4 = 0
			local var_35_5 = 0.975

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(106071008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 39 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 39)

				if (39 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 39)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071008", "story_v_out_106071.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071008", "story_v_out_106071.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_106071", "106071008", "story_v_out_106071.awb")

						arg_32_1:RecordAudio("106071008", var_35_11)
						arg_32_1:RecordAudio("106071008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_106071", "106071008", "story_v_out_106071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_106071", "106071008", "story_v_out_106071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play106071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106071009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play106071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1099ui_story"]) and arg_36_1.var_.characterEffect1099ui_story == nil then
				arg_36_1.var_.characterEffect1099ui_story = arg_36_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1099ui_story"]) then
				if arg_36_1.var_.characterEffect1099ui_story and not isNil(arg_36_1.actors_["1099ui_story"]) then
					arg_36_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1099ui_story"]) and arg_36_1.var_.characterEffect1099ui_story then
				arg_36_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_39_1 = arg_36_1.actors_["1099ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1099ui_story = var_39_1.localPosition
			end

			local var_39_2 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 then
				var_39_1.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_2)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 then
				var_39_1.localPosition = Vector3.New(0, 100, 0)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			local var_39_3 = arg_36_1.actors_["1026ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1026ui_story = var_39_3.localPosition
			end

			local var_39_4 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_4)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0, 100, 0)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_6", "se_story_6_draw_knife", "")
			end

			if 0.266666666666667 < arg_36_1.time_ and arg_36_1.time_ <= 0.266666666666667 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_6", "se_story_6_purple_lightning", "")
			end

			if 0.4 < arg_36_1.time_ and arg_36_1.time_ <= 0.4 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_6", "se_story_6_purple_lightning_loop", "")
			end

			local var_39_8 = 0
			local var_39_9 = 0.75

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(106071009).content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_12 = 30 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_10) / 30)

				if (30 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_10) / 30)) > 0 and var_39_9 < var_39_12 then
					arg_36_1.talkMaxDuration = var_39_12

					if var_39_12 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_13 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_13 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_13

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_13 and arg_36_1.time_ < var_39_8 + var_39_13 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play106071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106071010
		arg_40_1.duration_ = 9

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play106071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_0 = 2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				local var_43_1 = Color.New(0, 0, 0)

				var_43_1.a = Mathf.Lerp(0, 1, (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.mask_.color = var_43_1
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				local var_43_2 = Color.New(0, 0, 0)

				var_43_2.a = 1
				arg_40_1.mask_.color = var_43_2
			end

			local var_43_3 = 2

			if 2 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_4 = 2

			if var_43_3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_3 + var_43_4 then
				local var_43_5 = Color.New(0, 0, 0)

				var_43_5.a = Mathf.Lerp(1, 0, (arg_40_1.time_ - var_43_3) / var_43_4)
				arg_40_1.mask_.color = var_43_5
			end

			if arg_40_1.time_ >= var_43_3 + var_43_4 and arg_40_1.time_ < var_43_3 + var_43_4 + arg_43_0 then
				local var_43_6 = Color.New(0, 0, 0)

				arg_40_1.mask_.enabled = false
				var_43_6.a = 0
				arg_40_1.mask_.color = var_43_6
			end

			local var_43_7 = "S0610"

			if arg_40_1.bgs_.S0610 == nil then
				local var_43_8 = Object.Instantiate(arg_40_1.paintGo_)

				var_43_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_43_7)
				var_43_8.name = var_43_7
				var_43_8.transform.parent = arg_40_1.stage_.transform
				var_43_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.bgs_[var_43_7] = var_43_8
			end

			if 2 < arg_40_1.time_ and arg_40_1.time_ <= 2 + arg_43_0 then
				local var_43_9 = arg_40_1.bgs_.S0610

				arg_40_1.bgs_.S0610.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_43_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_43_10 = var_43_9:GetComponent("SpriteRenderer")

				if var_43_10 and var_43_10.sprite then
					local var_43_11 = 2 * (var_43_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_43_9.transform.localScale = Vector3.New(var_43_11 / var_43_10.sprite.bounds.size.y < var_43_11 * manager.ui.mainCameraCom_.aspect / var_43_10.sprite.bounds.size.x and var_43_11 * manager.ui.mainCameraCom_.aspect / var_43_10.sprite.bounds.size.x or var_43_11 / var_43_10.sprite.bounds.size.y, var_43_11 / var_43_10.sprite.bounds.size.y < var_43_11 * manager.ui.mainCameraCom_.aspect / var_43_10.sprite.bounds.size.x and var_43_11 * manager.ui.mainCameraCom_.aspect / var_43_10.sprite.bounds.size.x or var_43_11 / var_43_10.sprite.bounds.size.y, 0)
				end

				for iter_43_0, iter_43_1 in pairs(arg_40_1.bgs_) do
					if iter_43_0 ~= "S0610" then
						iter_43_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_12 = 4
			local var_43_13 = 1.375

			if 4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_14 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_14:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(106071010).content)

				arg_40_1.text_.text = var_43_15

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 55 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 55)

				if (55 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 55)) > 0 and var_43_13 < var_43_17 then
					arg_40_1.talkMaxDuration = var_43_17
					var_43_12 = var_43_12 + 0.3

					if var_43_17 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_15
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_18 = var_43_12 + 0.3
			local var_43_19 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 + 0.3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_18 + var_43_19 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_18) / var_43_19

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_18 + var_43_19 and arg_40_1.time_ < var_43_18 + var_43_19 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play106071011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 106071011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play106071012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:AudioAction("stop", "effect", "se_story_6", "se_story_6_purple_lightning_loop", "")
			end

			local var_49_1 = 0
			local var_49_2 = 0.425

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(106071011).content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 17 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 17)

				if (17 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 17)) > 0 and var_49_2 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_6 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_6 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_6

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_6 and arg_46_1.time_ < var_49_1 + var_49_6 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play106071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 106071012
		arg_50_1.duration_ = 9.7

		local var_50_0 = {
			ja = 9.7,
			ko = 7.833,
			zh = 7.766,
			en = 8.366
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play106071013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.925

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_1 = arg_50_1:GetWordFromCfg(106071012)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 37 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 37)

				if (37 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 37)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071012", "story_v_out_106071.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_106071", "106071012", "story_v_out_106071.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_106071", "106071012", "story_v_out_106071.awb")

						arg_50_1:RecordAudio("106071012", var_53_6)
						arg_50_1:RecordAudio("106071012", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_106071", "106071012", "story_v_out_106071.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_106071", "106071012", "story_v_out_106071.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play106071013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 106071013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play106071014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.625

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(106071013).content)

				arg_54_1.text_.text = var_57_1

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_3 = 25 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 25)

				if (25 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 25)) > 0 and var_57_0 < var_57_3 then
					arg_54_1.talkMaxDuration = var_57_3

					if var_57_3 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_3 + 0
					end
				end

				arg_54_1.text_.text = var_57_1
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_4 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_4

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play106071014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 106071014
		arg_58_1.duration_ = 8.73

		local var_58_0 = {
			ja = 8.7,
			ko = 7.866,
			zh = 8.733,
			en = 8.666
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play106071015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 1.05

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:GetWordFromCfg(106071014)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 42 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 42)

				if (42 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 42)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071014", "story_v_out_106071.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_106071", "106071014", "story_v_out_106071.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_106071", "106071014", "story_v_out_106071.awb")

						arg_58_1:RecordAudio("106071014", var_61_6)
						arg_58_1:RecordAudio("106071014", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_106071", "106071014", "story_v_out_106071.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_106071", "106071014", "story_v_out_106071.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play106071015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 106071015
		arg_62_1.duration_ = 9.4

		local var_62_0 = {
			ja = 7.9,
			ko = 5.066,
			zh = 5.833,
			en = 9.4
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play106071016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.675

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:GetWordFromCfg(106071015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 27 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 27)

				if (27 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 27)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071015", "story_v_out_106071.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_106071", "106071015", "story_v_out_106071.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_106071", "106071015", "story_v_out_106071.awb")

						arg_62_1:RecordAudio("106071015", var_65_6)
						arg_62_1:RecordAudio("106071015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_106071", "106071015", "story_v_out_106071.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_106071", "106071015", "story_v_out_106071.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play106071016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 106071016
		arg_66_1.duration_ = 6.2

		local var_66_0 = {
			ja = 5.999999999999,
			ko = 5.999999999999,
			zh = 5.999999999999,
			en = 6.2
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play106071017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 4 < arg_66_1.time_ and arg_66_1.time_ <= 4 + arg_69_0 and not isNil(arg_66_1.actors_["1099ui_story"]) and arg_66_1.var_.characterEffect1099ui_story == nil then
				arg_66_1.var_.characterEffect1099ui_story = arg_66_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 4 <= arg_66_1.time_ and arg_66_1.time_ < 4 + var_69_0 and not isNil(arg_66_1.actors_["1099ui_story"]) then
				if arg_66_1.var_.characterEffect1099ui_story and not isNil(arg_66_1.actors_["1099ui_story"]) then
					arg_66_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 4 + var_69_0 and arg_66_1.time_ < 4 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1099ui_story"]) and arg_66_1.var_.characterEffect1099ui_story then
				arg_66_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_69_2 = arg_66_1.actors_["1026ui_story"]

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= 4 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect1026ui_story == nil then
				arg_66_1.var_.characterEffect1026ui_story = var_69_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_3 = 0.1

			if 4 <= arg_66_1.time_ and arg_66_1.time_ < 4 + var_69_3 and not isNil(var_69_2) then
				if arg_66_1.var_.characterEffect1026ui_story and not isNil(var_69_2) then
					arg_66_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 4) / var_69_3)
				end
			end

			if arg_66_1.time_ >= 4 + var_69_3 and arg_66_1.time_ < 4 + var_69_3 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect1026ui_story then
				arg_66_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_69_4 = arg_66_1.actors_["1026ui_story"].transform

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= 4 + arg_69_0 then
				arg_66_1.var_.moveOldPos1026ui_story = var_69_4.localPosition
			end

			local var_69_5 = 0.001

			if 4 <= arg_66_1.time_ and arg_66_1.time_ < 4 + var_69_5 then
				var_69_4.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1026ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_66_1.time_ - 4) / var_69_5)
				var_69_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_4.position).x, (manager.ui.mainCamera.transform.position - var_69_4.position).y, (manager.ui.mainCamera.transform.position - var_69_4.position).z)
				var_69_4.localEulerAngles.z = 0
				var_69_4.localEulerAngles.x = 0
				var_69_4.localEulerAngles = var_69_4.localEulerAngles
			end

			if arg_66_1.time_ >= 4 + var_69_5 and arg_66_1.time_ < 4 + var_69_5 + arg_69_0 then
				var_69_4.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_69_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_4.position).x, (manager.ui.mainCamera.transform.position - var_69_4.position).y, (manager.ui.mainCamera.transform.position - var_69_4.position).z)
				var_69_4.localEulerAngles.z = 0
				var_69_4.localEulerAngles.x = 0
				var_69_4.localEulerAngles = var_69_4.localEulerAngles
			end

			local var_69_6 = arg_66_1.actors_["1099ui_story"].transform

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= 4 + arg_69_0 then
				arg_66_1.var_.moveOldPos1099ui_story = var_69_6.localPosition
			end

			local var_69_7 = 0.001

			if 4 <= arg_66_1.time_ and arg_66_1.time_ < 4 + var_69_7 then
				var_69_6.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_66_1.time_ - 4) / var_69_7)
				var_69_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_6.position).x, (manager.ui.mainCamera.transform.position - var_69_6.position).y, (manager.ui.mainCamera.transform.position - var_69_6.position).z)
				var_69_6.localEulerAngles.z = 0
				var_69_6.localEulerAngles.x = 0
				var_69_6.localEulerAngles = var_69_6.localEulerAngles
			end

			if arg_66_1.time_ >= 4 + var_69_7 and arg_66_1.time_ < 4 + var_69_7 + arg_69_0 then
				var_69_6.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_69_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_6.position).x, (manager.ui.mainCamera.transform.position - var_69_6.position).y, (manager.ui.mainCamera.transform.position - var_69_6.position).z)
				var_69_6.localEulerAngles.z = 0
				var_69_6.localEulerAngles.x = 0
				var_69_6.localEulerAngles = var_69_6.localEulerAngles
			end

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= 4 + arg_69_0 then
				arg_66_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= 4 + arg_69_0 then
				arg_66_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_69_8 = 0

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_9 = 2

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_9 then
				local var_69_10 = Color.New(0, 0, 0)

				var_69_10.a = Mathf.Lerp(0, 1, (arg_66_1.time_ - var_69_8) / var_69_9)
				arg_66_1.mask_.color = var_69_10
			end

			if arg_66_1.time_ >= var_69_8 + var_69_9 and arg_66_1.time_ < var_69_8 + var_69_9 + arg_69_0 then
				local var_69_11 = Color.New(0, 0, 0)

				var_69_11.a = 1
				arg_66_1.mask_.color = var_69_11
			end

			local var_69_12 = 2

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_13 = 2

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_13 then
				local var_69_14 = Color.New(0, 0, 0)

				var_69_14.a = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_12) / var_69_13)
				arg_66_1.mask_.color = var_69_14
			end

			if arg_66_1.time_ >= var_69_12 + var_69_13 and arg_66_1.time_ < var_69_12 + var_69_13 + arg_69_0 then
				local var_69_15 = Color.New(0, 0, 0)

				arg_66_1.mask_.enabled = false
				var_69_15.a = 0
				arg_66_1.mask_.color = var_69_15
			end

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= 2 + arg_69_0 then
				local var_69_16 = arg_66_1.bgs_.ST10

				arg_66_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_69_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_17 = var_69_16:GetComponent("SpriteRenderer")

				if var_69_17 and var_69_17.sprite then
					local var_69_18 = 2 * (var_69_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_69_16.transform.localScale = Vector3.New(var_69_18 / var_69_17.sprite.bounds.size.y < var_69_18 * manager.ui.mainCameraCom_.aspect / var_69_17.sprite.bounds.size.x and var_69_18 * manager.ui.mainCameraCom_.aspect / var_69_17.sprite.bounds.size.x or var_69_18 / var_69_17.sprite.bounds.size.y, var_69_18 / var_69_17.sprite.bounds.size.y < var_69_18 * manager.ui.mainCameraCom_.aspect / var_69_17.sprite.bounds.size.x and var_69_18 * manager.ui.mainCameraCom_.aspect / var_69_17.sprite.bounds.size.x or var_69_18 / var_69_17.sprite.bounds.size.y, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST10" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_19 = 4
			local var_69_20 = 0.225

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_19 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_21 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_21:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_22 = arg_66_1:GetWordFromCfg(106071016)
				local var_69_23 = arg_66_1:FormatText(var_69_22.content)

				arg_66_1.text_.text = var_69_23

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_25 = 9 <= 0 and var_69_20 or var_69_20 * (utf8.len(var_69_23) / 9)

				if (9 <= 0 and var_69_20 or var_69_20 * (utf8.len(var_69_23) / 9)) > 0 and var_69_20 < var_69_25 then
					arg_66_1.talkMaxDuration = var_69_25
					var_69_19 = var_69_19 + 0.3

					if var_69_25 + var_69_19 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_25 + var_69_19
					end
				end

				arg_66_1.text_.text = var_69_23
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071016", "story_v_out_106071.awb") ~= 0 then
					local var_69_26 = manager.audio:GetVoiceLength("story_v_out_106071", "106071016", "story_v_out_106071.awb") / 1000

					if var_69_26 + var_69_19 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_26 + var_69_19
					end

					if var_69_22.prefab_name ~= "" and arg_66_1.actors_[var_69_22.prefab_name] ~= nil then
						local var_69_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_22.prefab_name].transform, "story_v_out_106071", "106071016", "story_v_out_106071.awb")

						arg_66_1:RecordAudio("106071016", var_69_27)
						arg_66_1:RecordAudio("106071016", var_69_27)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_106071", "106071016", "story_v_out_106071.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_106071", "106071016", "story_v_out_106071.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_28 = var_69_19 + 0.3
			local var_69_29 = math.max(var_69_20, arg_66_1.talkMaxDuration)

			if var_69_19 + 0.3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_28 + var_69_29 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_28) / var_69_29

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_28 + var_69_29 and arg_66_1.time_ < var_69_28 + var_69_29 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0330000000000004,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play106071017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 106071017
		arg_72_1.duration_ = 5.53

		local var_72_0 = {
			ja = 4.166,
			ko = 4.8,
			zh = 4.866,
			en = 5.533
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
				arg_72_0:Play106071018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1026ui_story"]) and arg_72_1.var_.characterEffect1026ui_story == nil then
				arg_72_1.var_.characterEffect1026ui_story = arg_72_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1026ui_story"]) then
				if arg_72_1.var_.characterEffect1026ui_story and not isNil(arg_72_1.actors_["1026ui_story"]) then
					arg_72_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1026ui_story"]) and arg_72_1.var_.characterEffect1026ui_story then
				arg_72_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_75_2 = arg_72_1.actors_["1099ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1099ui_story == nil then
				arg_72_1.var_.characterEffect1099ui_story = var_75_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_3 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.characterEffect1099ui_story and not isNil(var_75_2) then
					arg_72_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_3)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1099ui_story then
				arg_72_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026actionlink/1026action465")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_75_4 = 0
			local var_75_5 = 0.45

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_6 = arg_72_1:GetWordFromCfg(106071017)
				local var_75_7 = arg_72_1:FormatText(var_75_6.content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 18 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 18)

				if (18 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 18)) > 0 and var_75_5 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_4
					end
				end

				arg_72_1.text_.text = var_75_7
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071017", "story_v_out_106071.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071017", "story_v_out_106071.awb") / 1000

					if var_75_10 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_4
					end

					if var_75_6.prefab_name ~= "" and arg_72_1.actors_[var_75_6.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_6.prefab_name].transform, "story_v_out_106071", "106071017", "story_v_out_106071.awb")

						arg_72_1:RecordAudio("106071017", var_75_11)
						arg_72_1:RecordAudio("106071017", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_106071", "106071017", "story_v_out_106071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_106071", "106071017", "story_v_out_106071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_5, arg_72_1.talkMaxDuration)

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_4) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_4 + var_75_12 and arg_72_1.time_ < var_75_4 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play106071018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 106071018
		arg_76_1.duration_ = 4.67

		local var_76_0 = {
			ja = 4.666,
			ko = 3.733,
			zh = 3.966,
			en = 3.433
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
				arg_76_0:Play106071019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1099ui_story"]) and arg_76_1.var_.characterEffect1099ui_story == nil then
				arg_76_1.var_.characterEffect1099ui_story = arg_76_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1099ui_story"]) then
				if arg_76_1.var_.characterEffect1099ui_story and not isNil(arg_76_1.actors_["1099ui_story"]) then
					arg_76_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1099ui_story"]) and arg_76_1.var_.characterEffect1099ui_story then
				arg_76_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["1026ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1026ui_story == nil then
				arg_76_1.var_.characterEffect1026ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect1026ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1026ui_story then
				arg_76_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_79_4 = 0
			local var_79_5 = 0.475

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(106071018)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 19 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 19)

				if (19 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 19)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071018", "story_v_out_106071.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071018", "story_v_out_106071.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_106071", "106071018", "story_v_out_106071.awb")

						arg_76_1:RecordAudio("106071018", var_79_11)
						arg_76_1:RecordAudio("106071018", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_106071", "106071018", "story_v_out_106071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_106071", "106071018", "story_v_out_106071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play106071019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 106071019
		arg_80_1.duration_ = 9.77

		local var_80_0 = {
			ja = 9.766,
			ko = 7.333,
			zh = 6.4,
			en = 7.766
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
				arg_80_0:Play106071020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1026ui_story"]) and arg_80_1.var_.characterEffect1026ui_story == nil then
				arg_80_1.var_.characterEffect1026ui_story = arg_80_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1026ui_story"]) then
				if arg_80_1.var_.characterEffect1026ui_story and not isNil(arg_80_1.actors_["1026ui_story"]) then
					arg_80_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1026ui_story"]) and arg_80_1.var_.characterEffect1026ui_story then
				arg_80_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["1099ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1099ui_story == nil then
				arg_80_1.var_.characterEffect1099ui_story = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_3 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.characterEffect1099ui_story and not isNil(var_83_2) then
					arg_80_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_3)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1099ui_story then
				arg_80_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action5_2")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026actionlink/1026action454")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_83_4 = 0
			local var_83_5 = 1.075

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(106071019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 34 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 34)

				if (34 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 34)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071019", "story_v_out_106071.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071019", "story_v_out_106071.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_106071", "106071019", "story_v_out_106071.awb")

						arg_80_1:RecordAudio("106071019", var_83_11)
						arg_80_1:RecordAudio("106071019", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_106071", "106071019", "story_v_out_106071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_106071", "106071019", "story_v_out_106071.awb")
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
	Play106071020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 106071020
		arg_84_1.duration_ = 4.33

		local var_84_0 = {
			ja = 3.2,
			ko = 3.266,
			zh = 3.833,
			en = 4.333
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
				arg_84_0:Play106071021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_87_0 = 0
			local var_87_1 = 0.45

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_2 = arg_84_1:GetWordFromCfg(106071020)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 18 <= 0 and var_87_1 or var_87_1 * (utf8.len(var_87_3) / 18)

				if (18 <= 0 and var_87_1 or var_87_1 * (utf8.len(var_87_3) / 18)) > 0 and var_87_1 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071020", "story_v_out_106071.awb") ~= 0 then
					local var_87_6 = manager.audio:GetVoiceLength("story_v_out_106071", "106071020", "story_v_out_106071.awb") / 1000

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end

					if var_87_2.prefab_name ~= "" and arg_84_1.actors_[var_87_2.prefab_name] ~= nil then
						local var_87_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_2.prefab_name].transform, "story_v_out_106071", "106071020", "story_v_out_106071.awb")

						arg_84_1:RecordAudio("106071020", var_87_7)
						arg_84_1:RecordAudio("106071020", var_87_7)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_106071", "106071020", "story_v_out_106071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_106071", "106071020", "story_v_out_106071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_8 and arg_84_1.time_ < var_87_0 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play106071021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 106071021
		arg_88_1.duration_ = 8.37

		local var_88_0 = {
			ja = 8.1,
			ko = 8.366,
			zh = 7.433,
			en = 6.733
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
				arg_88_0:Play106071022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action4_2")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_91_0 = 0
			local var_91_1 = 0.925

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_2 = arg_88_1:GetWordFromCfg(106071021)
				local var_91_3 = arg_88_1:FormatText(var_91_2.content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 36 <= 0 and var_91_1 or var_91_1 * (utf8.len(var_91_3) / 36)

				if (36 <= 0 and var_91_1 or var_91_1 * (utf8.len(var_91_3) / 36)) > 0 and var_91_1 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071021", "story_v_out_106071.awb") ~= 0 then
					local var_91_6 = manager.audio:GetVoiceLength("story_v_out_106071", "106071021", "story_v_out_106071.awb") / 1000

					if var_91_6 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_0
					end

					if var_91_2.prefab_name ~= "" and arg_88_1.actors_[var_91_2.prefab_name] ~= nil then
						local var_91_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_2.prefab_name].transform, "story_v_out_106071", "106071021", "story_v_out_106071.awb")

						arg_88_1:RecordAudio("106071021", var_91_7)
						arg_88_1:RecordAudio("106071021", var_91_7)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_106071", "106071021", "story_v_out_106071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_106071", "106071021", "story_v_out_106071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_8 and arg_88_1.time_ < var_91_0 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play106071022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 106071022
		arg_92_1.duration_ = 5.6

		local var_92_0 = {
			ja = 5.2,
			ko = 5.166,
			zh = 4.7,
			en = 5.6
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
				arg_92_0:Play106071023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1099ui_story"]) and arg_92_1.var_.characterEffect1099ui_story == nil then
				arg_92_1.var_.characterEffect1099ui_story = arg_92_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1099ui_story"]) then
				if arg_92_1.var_.characterEffect1099ui_story and not isNil(arg_92_1.actors_["1099ui_story"]) then
					arg_92_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1099ui_story"]) and arg_92_1.var_.characterEffect1099ui_story then
				arg_92_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_95_2 = arg_92_1.actors_["1026ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1026ui_story == nil then
				arg_92_1.var_.characterEffect1026ui_story = var_95_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.characterEffect1026ui_story and not isNil(var_95_2) then
					arg_92_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_3)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1026ui_story then
				arg_92_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_95_4 = 0
			local var_95_5 = 0.675

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_6 = arg_92_1:GetWordFromCfg(106071022)
				local var_95_7 = arg_92_1:FormatText(var_95_6.content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 27 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 27)

				if (27 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 27)) > 0 and var_95_5 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071022", "story_v_out_106071.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071022", "story_v_out_106071.awb") / 1000

					if var_95_10 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_4
					end

					if var_95_6.prefab_name ~= "" and arg_92_1.actors_[var_95_6.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_6.prefab_name].transform, "story_v_out_106071", "106071022", "story_v_out_106071.awb")

						arg_92_1:RecordAudio("106071022", var_95_11)
						arg_92_1:RecordAudio("106071022", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_106071", "106071022", "story_v_out_106071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_106071", "106071022", "story_v_out_106071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_12 and arg_92_1.time_ < var_95_4 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play106071023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 106071023
		arg_96_1.duration_ = 4.07

		local var_96_0 = {
			ja = 4.066,
			ko = 2.566,
			zh = 2.433,
			en = 2.6
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
				arg_96_0:Play106071024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1026ui_story"]) and arg_96_1.var_.characterEffect1026ui_story == nil then
				arg_96_1.var_.characterEffect1026ui_story = arg_96_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1026ui_story"]) then
				if arg_96_1.var_.characterEffect1026ui_story and not isNil(arg_96_1.actors_["1026ui_story"]) then
					arg_96_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1026ui_story"]) and arg_96_1.var_.characterEffect1026ui_story then
				arg_96_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_99_2 = arg_96_1.actors_["1099ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1099ui_story == nil then
				arg_96_1.var_.characterEffect1099ui_story = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_3 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.characterEffect1099ui_story and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_3)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1099ui_story then
				arg_96_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action6_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_99_4 = 0
			local var_99_5 = 0.175

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(106071023)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 7 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 7)

				if (7 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 7)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071023", "story_v_out_106071.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071023", "story_v_out_106071.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_106071", "106071023", "story_v_out_106071.awb")

						arg_96_1:RecordAudio("106071023", var_99_11)
						arg_96_1:RecordAudio("106071023", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_106071", "106071023", "story_v_out_106071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_106071", "106071023", "story_v_out_106071.awb")
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
	Play106071024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 106071024
		arg_100_1.duration_ = 3.3

		local var_100_0 = {
			ja = 3.266,
			ko = 1.266,
			zh = 1.4,
			en = 3.3
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play106071025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1099ui_story"]) and arg_100_1.var_.characterEffect1099ui_story == nil then
				arg_100_1.var_.characterEffect1099ui_story = arg_100_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1099ui_story"]) then
				if arg_100_1.var_.characterEffect1099ui_story and not isNil(arg_100_1.actors_["1099ui_story"]) then
					arg_100_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1099ui_story"]) and arg_100_1.var_.characterEffect1099ui_story then
				arg_100_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.actors_["1026ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1026ui_story == nil then
				arg_100_1.var_.characterEffect1026ui_story = var_103_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_3 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.characterEffect1026ui_story and not isNil(var_103_2) then
					arg_100_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_3)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1026ui_story then
				arg_100_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_103_4 = 0
			local var_103_5 = 0.125

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(106071024)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 5 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 5)

				if (5 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 5)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071024", "story_v_out_106071.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071024", "story_v_out_106071.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_106071", "106071024", "story_v_out_106071.awb")

						arg_100_1:RecordAudio("106071024", var_103_11)
						arg_100_1:RecordAudio("106071024", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_106071", "106071024", "story_v_out_106071.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_106071", "106071024", "story_v_out_106071.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_12 and arg_100_1.time_ < var_103_4 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play106071025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 106071025
		arg_104_1.duration_ = 9.33

		local var_104_0 = {
			ja = 8.433,
			ko = 9.066,
			zh = 8.4,
			en = 9.333
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
				arg_104_0:Play106071026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1026ui_story"]) and arg_104_1.var_.characterEffect1026ui_story == nil then
				arg_104_1.var_.characterEffect1026ui_story = arg_104_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1026ui_story"]) then
				if arg_104_1.var_.characterEffect1026ui_story and not isNil(arg_104_1.actors_["1026ui_story"]) then
					arg_104_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1026ui_story"]) and arg_104_1.var_.characterEffect1026ui_story then
				arg_104_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_107_2 = arg_104_1.actors_["1099ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1099ui_story == nil then
				arg_104_1.var_.characterEffect1099ui_story = var_107_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_3 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.characterEffect1099ui_story and not isNil(var_107_2) then
					arg_104_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_3)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1099ui_story then
				arg_104_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_107_4 = 0
			local var_107_5 = 0.925

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(106071025)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 36 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 36)

				if (36 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 36)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071025", "story_v_out_106071.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071025", "story_v_out_106071.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_106071", "106071025", "story_v_out_106071.awb")

						arg_104_1:RecordAudio("106071025", var_107_11)
						arg_104_1:RecordAudio("106071025", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_106071", "106071025", "story_v_out_106071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_106071", "106071025", "story_v_out_106071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_12 and arg_104_1.time_ < var_107_4 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play106071026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 106071026
		arg_108_1.duration_ = 9.17

		local var_108_0 = {
			ja = 8.5,
			ko = 7.4,
			zh = 6.2,
			en = 9.166
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play106071027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1099ui_story"]) and arg_108_1.var_.characterEffect1099ui_story == nil then
				arg_108_1.var_.characterEffect1099ui_story = arg_108_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1099ui_story"]) then
				if arg_108_1.var_.characterEffect1099ui_story and not isNil(arg_108_1.actors_["1099ui_story"]) then
					arg_108_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1099ui_story"]) and arg_108_1.var_.characterEffect1099ui_story then
				arg_108_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_111_2 = arg_108_1.actors_["1026ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect1026ui_story == nil then
				arg_108_1.var_.characterEffect1026ui_story = var_111_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_3 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.characterEffect1026ui_story and not isNil(var_111_2) then
					arg_108_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_3)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect1026ui_story then
				arg_108_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_111_4 = 0
			local var_111_5 = 0.775

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(106071026)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 31 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 31)

				if (31 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 31)) > 0 and var_111_5 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071026", "story_v_out_106071.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071026", "story_v_out_106071.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_106071", "106071026", "story_v_out_106071.awb")

						arg_108_1:RecordAudio("106071026", var_111_11)
						arg_108_1:RecordAudio("106071026", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_106071", "106071026", "story_v_out_106071.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_106071", "106071026", "story_v_out_106071.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_12 and arg_108_1.time_ < var_111_4 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play106071027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 106071027
		arg_112_1.duration_ = 4.8

		local var_112_0 = {
			ja = 4.8,
			ko = 1.3,
			zh = 1.8,
			en = 3.1
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play106071028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1026ui_story"]) and arg_112_1.var_.characterEffect1026ui_story == nil then
				arg_112_1.var_.characterEffect1026ui_story = arg_112_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1026ui_story"]) then
				if arg_112_1.var_.characterEffect1026ui_story and not isNil(arg_112_1.actors_["1026ui_story"]) then
					arg_112_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1026ui_story"]) and arg_112_1.var_.characterEffect1026ui_story then
				arg_112_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_115_2 = arg_112_1.actors_["1099ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1099ui_story == nil then
				arg_112_1.var_.characterEffect1099ui_story = var_115_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_3 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.characterEffect1099ui_story and not isNil(var_115_2) then
					arg_112_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_3)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1099ui_story then
				arg_112_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_115_4 = 0
			local var_115_5 = 0.2

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(106071027)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 8 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 8)

				if (8 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 8)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071027", "story_v_out_106071.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071027", "story_v_out_106071.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_106071", "106071027", "story_v_out_106071.awb")

						arg_112_1:RecordAudio("106071027", var_115_11)
						arg_112_1:RecordAudio("106071027", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_106071", "106071027", "story_v_out_106071.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_106071", "106071027", "story_v_out_106071.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play106071028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 106071028
		arg_116_1.duration_ = 9.77

		local var_116_0 = {
			ja = 4,
			ko = 7.733,
			zh = 9.766,
			en = 8.6
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
				arg_116_0:Play106071029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1099ui_story"]) and arg_116_1.var_.characterEffect1099ui_story == nil then
				arg_116_1.var_.characterEffect1099ui_story = arg_116_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1099ui_story"]) then
				if arg_116_1.var_.characterEffect1099ui_story and not isNil(arg_116_1.actors_["1099ui_story"]) then
					arg_116_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1099ui_story"]) and arg_116_1.var_.characterEffect1099ui_story then
				arg_116_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_119_2 = arg_116_1.actors_["1026ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1026ui_story == nil then
				arg_116_1.var_.characterEffect1026ui_story = var_119_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_3 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.characterEffect1026ui_story and not isNil(var_119_2) then
					arg_116_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_3)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1026ui_story then
				arg_116_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action464")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_119_4 = 0
			local var_119_5 = 0.95

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(106071028)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 38 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 38)

				if (38 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 38)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071028", "story_v_out_106071.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071028", "story_v_out_106071.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_106071", "106071028", "story_v_out_106071.awb")

						arg_116_1:RecordAudio("106071028", var_119_11)
						arg_116_1:RecordAudio("106071028", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_106071", "106071028", "story_v_out_106071.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_106071", "106071028", "story_v_out_106071.awb")
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

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play106071029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 106071029
		arg_120_1.duration_ = 11.03

		local var_120_0 = {
			ja = 10.633,
			ko = 7.5,
			zh = 11.033,
			en = 7.8
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
				arg_120_0:Play106071030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1026ui_story"]) and arg_120_1.var_.characterEffect1026ui_story == nil then
				arg_120_1.var_.characterEffect1026ui_story = arg_120_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1026ui_story"]) then
				if arg_120_1.var_.characterEffect1026ui_story and not isNil(arg_120_1.actors_["1026ui_story"]) then
					arg_120_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1026ui_story"]) and arg_120_1.var_.characterEffect1026ui_story then
				arg_120_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_123_2 = arg_120_1.actors_["1099ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1099ui_story == nil then
				arg_120_1.var_.characterEffect1099ui_story = var_123_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_3 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.characterEffect1099ui_story and not isNil(var_123_2) then
					arg_120_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_3)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1099ui_story then
				arg_120_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_123_4 = 0
			local var_123_5 = 1.1

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(106071029)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 44 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 44)

				if (44 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 44)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071029", "story_v_out_106071.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071029", "story_v_out_106071.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_106071", "106071029", "story_v_out_106071.awb")

						arg_120_1:RecordAudio("106071029", var_123_11)
						arg_120_1:RecordAudio("106071029", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_106071", "106071029", "story_v_out_106071.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_106071", "106071029", "story_v_out_106071.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_12 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_12 and arg_120_1.time_ < var_123_4 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play106071030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 106071030
		arg_124_1.duration_ = 1.83

		local var_124_0 = {
			ja = 1.466,
			ko = 0.999999999999,
			zh = 1.833,
			en = 0.999999999999
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
				arg_124_0:Play106071031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1099ui_story"]) and arg_124_1.var_.characterEffect1099ui_story == nil then
				arg_124_1.var_.characterEffect1099ui_story = arg_124_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.1

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1099ui_story"]) then
				if arg_124_1.var_.characterEffect1099ui_story and not isNil(arg_124_1.actors_["1099ui_story"]) then
					arg_124_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1099ui_story"]) and arg_124_1.var_.characterEffect1099ui_story then
				arg_124_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_127_2 = arg_124_1.actors_["1026ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect1026ui_story == nil then
				arg_124_1.var_.characterEffect1026ui_story = var_127_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_3 = 0.1

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.characterEffect1026ui_story and not isNil(var_127_2) then
					arg_124_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_3)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect1026ui_story then
				arg_124_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_127_4 = 0
			local var_127_5 = 0.05

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(106071030)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_9 = 2 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 2)

				if (2 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 2)) > 0 and var_127_5 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071030", "story_v_out_106071.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071030", "story_v_out_106071.awb") / 1000

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end

					if var_127_6.prefab_name ~= "" and arg_124_1.actors_[var_127_6.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_6.prefab_name].transform, "story_v_out_106071", "106071030", "story_v_out_106071.awb")

						arg_124_1:RecordAudio("106071030", var_127_11)
						arg_124_1:RecordAudio("106071030", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_106071", "106071030", "story_v_out_106071.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_106071", "106071030", "story_v_out_106071.awb")
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
	Play106071031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 106071031
		arg_128_1.duration_ = 9.6

		local var_128_0 = {
			ja = 9.6,
			ko = 6.4,
			zh = 7.933,
			en = 7.533
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play106071032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_131_0 = 0
			local var_131_1 = 0.8

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_2 = arg_128_1:GetWordFromCfg(106071031)
				local var_131_3 = arg_128_1:FormatText(var_131_2.content)

				arg_128_1.text_.text = var_131_3

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 32 <= 0 and var_131_1 or var_131_1 * (utf8.len(var_131_3) / 32)

				if (32 <= 0 and var_131_1 or var_131_1 * (utf8.len(var_131_3) / 32)) > 0 and var_131_1 < var_131_5 then
					arg_128_1.talkMaxDuration = var_131_5

					if var_131_5 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_3
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071031", "story_v_out_106071.awb") ~= 0 then
					local var_131_6 = manager.audio:GetVoiceLength("story_v_out_106071", "106071031", "story_v_out_106071.awb") / 1000

					if var_131_6 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_6 + var_131_0
					end

					if var_131_2.prefab_name ~= "" and arg_128_1.actors_[var_131_2.prefab_name] ~= nil then
						local var_131_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_2.prefab_name].transform, "story_v_out_106071", "106071031", "story_v_out_106071.awb")

						arg_128_1:RecordAudio("106071031", var_131_7)
						arg_128_1:RecordAudio("106071031", var_131_7)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_106071", "106071031", "story_v_out_106071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_106071", "106071031", "story_v_out_106071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_8 and arg_128_1.time_ < var_131_0 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play106071032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 106071032
		arg_132_1.duration_ = 4.9

		local var_132_0 = {
			ja = 4.9,
			ko = 3.1,
			zh = 3.566,
			en = 2.266
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
				arg_132_0:Play106071033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1026ui_story"]) and arg_132_1.var_.characterEffect1026ui_story == nil then
				arg_132_1.var_.characterEffect1026ui_story = arg_132_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.1

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1026ui_story"]) then
				if arg_132_1.var_.characterEffect1026ui_story and not isNil(arg_132_1.actors_["1026ui_story"]) then
					arg_132_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1026ui_story"]) and arg_132_1.var_.characterEffect1026ui_story then
				arg_132_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_135_2 = arg_132_1.actors_["1099ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1099ui_story == nil then
				arg_132_1.var_.characterEffect1099ui_story = var_135_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_3 = 0.1

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.characterEffect1099ui_story and not isNil(var_135_2) then
					arg_132_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_3)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1099ui_story then
				arg_132_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_135_4 = 0
			local var_135_5 = 0.3

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(106071032)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 12 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 12)

				if (12 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 12)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071032", "story_v_out_106071.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071032", "story_v_out_106071.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_106071", "106071032", "story_v_out_106071.awb")

						arg_132_1:RecordAudio("106071032", var_135_11)
						arg_132_1:RecordAudio("106071032", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_106071", "106071032", "story_v_out_106071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_106071", "106071032", "story_v_out_106071.awb")
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

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play106071033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 106071033
		arg_136_1.duration_ = 5.83

		local var_136_0 = {
			ja = 5.066,
			ko = 3.133,
			zh = 3.533,
			en = 5.833
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
				arg_136_0:Play106071034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1026ui_story"]) and arg_136_1.var_.characterEffect1026ui_story == nil then
				arg_136_1.var_.characterEffect1026ui_story = arg_136_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.1

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1026ui_story"]) then
				if arg_136_1.var_.characterEffect1026ui_story and not isNil(arg_136_1.actors_["1026ui_story"]) then
					arg_136_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1026ui_story"]) and arg_136_1.var_.characterEffect1026ui_story then
				arg_136_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_139_1 = arg_136_1.actors_["1026ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1026ui_story = var_139_1.localPosition
			end

			local var_139_2 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 then
				var_139_1.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_2)
				var_139_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_1.position).x, (manager.ui.mainCamera.transform.position - var_139_1.position).y, (manager.ui.mainCamera.transform.position - var_139_1.position).z)
				var_139_1.localEulerAngles.z = 0
				var_139_1.localEulerAngles.x = 0
				var_139_1.localEulerAngles = var_139_1.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 then
				var_139_1.localPosition = Vector3.New(0, 100, 0)
				var_139_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_1.position).x, (manager.ui.mainCamera.transform.position - var_139_1.position).y, (manager.ui.mainCamera.transform.position - var_139_1.position).z)
				var_139_1.localEulerAngles.z = 0
				var_139_1.localEulerAngles.x = 0
				var_139_1.localEulerAngles = var_139_1.localEulerAngles
			end

			local var_139_3 = arg_136_1.actors_["1099ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1099ui_story = var_139_3.localPosition
			end

			local var_139_4 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				var_139_3.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_4)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				var_139_3.localPosition = Vector3.New(0, 100, 0)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			local var_139_5 = 0
			local var_139_6 = 0.35

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[85].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6062")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_7 = arg_136_1:GetWordFromCfg(106071033)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 14 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 14)

				if (14 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 14)) > 0 and var_139_6 < var_139_10 then
					arg_136_1.talkMaxDuration = var_139_10

					if var_139_10 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_5
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071033", "story_v_out_106071.awb") ~= 0 then
					local var_139_11 = manager.audio:GetVoiceLength("story_v_out_106071", "106071033", "story_v_out_106071.awb") / 1000

					if var_139_11 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_5
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_106071", "106071033", "story_v_out_106071.awb")

						arg_136_1:RecordAudio("106071033", var_139_12)
						arg_136_1:RecordAudio("106071033", var_139_12)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_106071", "106071033", "story_v_out_106071.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_106071", "106071033", "story_v_out_106071.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_13 = math.max(var_139_6, arg_136_1.talkMaxDuration)

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_13 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_5) / var_139_13

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_5 + var_139_13 and arg_136_1.time_ < var_139_5 + var_139_13 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play106071034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 106071034
		arg_140_1.duration_ = 11.4

		local var_140_0 = {
			ja = 7.266,
			ko = 11.4,
			zh = 8.4,
			en = 8.666
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play106071035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			local var_143_0 = 0
			local var_143_1 = 0.975

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[85].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6062")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_2 = arg_140_1:GetWordFromCfg(106071034)
				local var_143_3 = arg_140_1:FormatText(var_143_2.content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 39 <= 0 and var_143_1 or var_143_1 * (utf8.len(var_143_3) / 39)

				if (39 <= 0 and var_143_1 or var_143_1 * (utf8.len(var_143_3) / 39)) > 0 and var_143_1 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071034", "story_v_out_106071.awb") ~= 0 then
					local var_143_6 = manager.audio:GetVoiceLength("story_v_out_106071", "106071034", "story_v_out_106071.awb") / 1000

					if var_143_6 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_0
					end

					if var_143_2.prefab_name ~= "" and arg_140_1.actors_[var_143_2.prefab_name] ~= nil then
						local var_143_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_2.prefab_name].transform, "story_v_out_106071", "106071034", "story_v_out_106071.awb")

						arg_140_1:RecordAudio("106071034", var_143_7)
						arg_140_1:RecordAudio("106071034", var_143_7)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_106071", "106071034", "story_v_out_106071.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_106071", "106071034", "story_v_out_106071.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_8 and arg_140_1.time_ < var_143_0 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play106071035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 106071035
		arg_144_1.duration_ = 3.4

		local var_144_0 = {
			ja = 3.4,
			ko = 2.4,
			zh = 2.8,
			en = 3.166
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
				arg_144_0:Play106071036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1026ui_story"]) and arg_144_1.var_.characterEffect1026ui_story == nil then
				arg_144_1.var_.characterEffect1026ui_story = arg_144_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.1

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1026ui_story"]) then
				if arg_144_1.var_.characterEffect1026ui_story and not isNil(arg_144_1.actors_["1026ui_story"]) then
					arg_144_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1026ui_story"]) and arg_144_1.var_.characterEffect1026ui_story then
				arg_144_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_147_2 = arg_144_1.actors_["1026ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1026ui_story = var_147_2.localPosition
			end

			local var_147_3 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 then
				var_147_2.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1026ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_144_1.time_ - 0) / var_147_3)
				var_147_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_2.position).x, (manager.ui.mainCamera.transform.position - var_147_2.position).y, (manager.ui.mainCamera.transform.position - var_147_2.position).z)
				var_147_2.localEulerAngles.z = 0
				var_147_2.localEulerAngles.x = 0
				var_147_2.localEulerAngles = var_147_2.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 then
				var_147_2.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_147_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_2.position).x, (manager.ui.mainCamera.transform.position - var_147_2.position).y, (manager.ui.mainCamera.transform.position - var_147_2.position).z)
				var_147_2.localEulerAngles.z = 0
				var_147_2.localEulerAngles.x = 0
				var_147_2.localEulerAngles = var_147_2.localEulerAngles
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action5_1")
			end

			local var_147_4 = arg_144_1.actors_["1099ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1099ui_story = var_147_4.localPosition
			end

			local var_147_5 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_5 then
				var_147_4.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_144_1.time_ - 0) / var_147_5)
				var_147_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_4.position).x, (manager.ui.mainCamera.transform.position - var_147_4.position).y, (manager.ui.mainCamera.transform.position - var_147_4.position).z)
				var_147_4.localEulerAngles.z = 0
				var_147_4.localEulerAngles.x = 0
				var_147_4.localEulerAngles = var_147_4.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_5 and arg_144_1.time_ < 0 + var_147_5 + arg_147_0 then
				var_147_4.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_147_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_4.position).x, (manager.ui.mainCamera.transform.position - var_147_4.position).y, (manager.ui.mainCamera.transform.position - var_147_4.position).z)
				var_147_4.localEulerAngles.z = 0
				var_147_4.localEulerAngles.x = 0
				var_147_4.localEulerAngles = var_147_4.localEulerAngles
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_147_6 = 0
			local var_147_7 = 0.35

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_8 = arg_144_1:GetWordFromCfg(106071035)
				local var_147_9 = arg_144_1:FormatText(var_147_8.content)

				arg_144_1.text_.text = var_147_9

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 14 <= 0 and var_147_7 or var_147_7 * (utf8.len(var_147_9) / 14)

				if (14 <= 0 and var_147_7 or var_147_7 * (utf8.len(var_147_9) / 14)) > 0 and var_147_7 < var_147_11 then
					arg_144_1.talkMaxDuration = var_147_11

					if var_147_11 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_11 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_9
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071035", "story_v_out_106071.awb") ~= 0 then
					local var_147_12 = manager.audio:GetVoiceLength("story_v_out_106071", "106071035", "story_v_out_106071.awb") / 1000

					if var_147_12 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_6
					end

					if var_147_8.prefab_name ~= "" and arg_144_1.actors_[var_147_8.prefab_name] ~= nil then
						local var_147_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_8.prefab_name].transform, "story_v_out_106071", "106071035", "story_v_out_106071.awb")

						arg_144_1:RecordAudio("106071035", var_147_13)
						arg_144_1:RecordAudio("106071035", var_147_13)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_106071", "106071035", "story_v_out_106071.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_106071", "106071035", "story_v_out_106071.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_14 and arg_144_1.time_ < var_147_6 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play106071036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 106071036
		arg_148_1.duration_ = 2.13

		local var_148_0 = {
			ja = 1.2,
			ko = 0.999999999999,
			zh = 2.033,
			en = 2.133
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
				arg_148_0:Play106071037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1099ui_story"]) and arg_148_1.var_.characterEffect1099ui_story == nil then
				arg_148_1.var_.characterEffect1099ui_story = arg_148_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.1

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1099ui_story"]) then
				if arg_148_1.var_.characterEffect1099ui_story and not isNil(arg_148_1.actors_["1099ui_story"]) then
					arg_148_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1099ui_story"]) and arg_148_1.var_.characterEffect1099ui_story then
				arg_148_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_151_2 = arg_148_1.actors_["1026ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect1026ui_story == nil then
				arg_148_1.var_.characterEffect1026ui_story = var_151_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_3 = 0.1

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 and not isNil(var_151_2) then
				if arg_148_1.var_.characterEffect1026ui_story and not isNil(var_151_2) then
					arg_148_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_3)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect1026ui_story then
				arg_148_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_151_4 = 0
			local var_151_5 = 0.075

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_6 = arg_148_1:GetWordFromCfg(106071036)
				local var_151_7 = arg_148_1:FormatText(var_151_6.content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 3 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 3)

				if (3 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 3)) > 0 and var_151_5 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_4
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071036", "story_v_out_106071.awb") ~= 0 then
					local var_151_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071036", "story_v_out_106071.awb") / 1000

					if var_151_10 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_4
					end

					if var_151_6.prefab_name ~= "" and arg_148_1.actors_[var_151_6.prefab_name] ~= nil then
						local var_151_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_6.prefab_name].transform, "story_v_out_106071", "106071036", "story_v_out_106071.awb")

						arg_148_1:RecordAudio("106071036", var_151_11)
						arg_148_1:RecordAudio("106071036", var_151_11)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_106071", "106071036", "story_v_out_106071.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_106071", "106071036", "story_v_out_106071.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_5, arg_148_1.talkMaxDuration)

			if var_151_4 <= arg_148_1.time_ and arg_148_1.time_ < var_151_4 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_4) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_4 + var_151_12 and arg_148_1.time_ < var_151_4 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play106071037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 106071037
		arg_152_1.duration_ = 6.23

		local var_152_0 = {
			ja = 3.933,
			ko = 4.833,
			zh = 6.233,
			en = 4.666
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
				arg_152_0:Play106071038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1026ui_story"]) and arg_152_1.var_.characterEffect1026ui_story == nil then
				arg_152_1.var_.characterEffect1026ui_story = arg_152_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.1

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1026ui_story"]) then
				if arg_152_1.var_.characterEffect1026ui_story and not isNil(arg_152_1.actors_["1026ui_story"]) then
					arg_152_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1026ui_story"]) and arg_152_1.var_.characterEffect1026ui_story then
				arg_152_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_155_2 = arg_152_1.actors_["1099ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.characterEffect1099ui_story == nil then
				arg_152_1.var_.characterEffect1099ui_story = var_155_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_3 = 0.1

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 and not isNil(var_155_2) then
				if arg_152_1.var_.characterEffect1099ui_story and not isNil(var_155_2) then
					arg_152_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_3)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.characterEffect1099ui_story then
				arg_152_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/story1026/story1026action/1026action4_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1026ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_155_4 = 0
			local var_155_5 = 0.6

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[83].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(106071037)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 24 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 24)

				if (24 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 24)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071037", "story_v_out_106071.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071037", "story_v_out_106071.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_106071", "106071037", "story_v_out_106071.awb")

						arg_152_1:RecordAudio("106071037", var_155_11)
						arg_152_1:RecordAudio("106071037", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_106071", "106071037", "story_v_out_106071.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_106071", "106071037", "story_v_out_106071.awb")
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

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play106071038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 106071038
		arg_156_1.duration_ = 7

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play106071039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 and not isNil(arg_156_1.actors_["1026ui_story"]) and arg_156_1.var_.characterEffect1026ui_story == nil then
				arg_156_1.var_.characterEffect1026ui_story = arg_156_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.1

			if 2 <= arg_156_1.time_ and arg_156_1.time_ < 2 + var_159_0 and not isNil(arg_156_1.actors_["1026ui_story"]) then
				if arg_156_1.var_.characterEffect1026ui_story and not isNil(arg_156_1.actors_["1026ui_story"]) then
					arg_156_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 2) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 2 + var_159_0 and arg_156_1.time_ < 2 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1026ui_story"]) and arg_156_1.var_.characterEffect1026ui_story then
				arg_156_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				local var_159_1 = arg_156_1.bgs_.ST10:GetComponent("SpriteRenderer")

				if var_159_1 then
					arg_156_1.var_.alphaOldValueST10 = var_159_1.color.a
					arg_156_1.var_.alphaMatValueST10 = var_159_1
				end

				arg_156_1.var_.alphaOldValueST10 = 1
			end

			local var_159_2 = 1.5

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 then
				if arg_156_1.var_.alphaMatValueST10 then
					arg_156_1.var_.alphaMatValueST10.color.a = Mathf.Lerp(arg_156_1.var_.alphaOldValueST10, 0, (arg_156_1.time_ - 0) / var_159_2)
					arg_156_1.var_.alphaMatValueST10.color = arg_156_1.var_.alphaMatValueST10.color
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and arg_156_1.var_.alphaMatValueST10 then
				arg_156_1.var_.alphaMatValueST10.color.a = 0
				arg_156_1.var_.alphaMatValueST10.color = arg_156_1.var_.alphaMatValueST10.color
			end

			local var_159_3 = arg_156_1.bgs_.ST10.transform

			if 1.5 < arg_156_1.time_ and arg_156_1.time_ <= 1.5 + arg_159_0 then
				arg_156_1.var_.moveOldPosST10 = var_159_3.localPosition
			end

			local var_159_4 = 0.001

			if 1.5 <= arg_156_1.time_ and arg_156_1.time_ < 1.5 + var_159_4 then
				var_159_3.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPosST10, Vector3.New(0, -100, 10), (arg_156_1.time_ - 1.5) / var_159_4)
			end

			if arg_156_1.time_ >= 1.5 + var_159_4 and arg_156_1.time_ < 1.5 + var_159_4 + arg_159_0 then
				var_159_3.localPosition = Vector3.New(0, -100, 10)
			end

			local var_159_5 = "A00"

			if arg_156_1.bgs_.A00 == nil then
				local var_159_6 = Object.Instantiate(arg_156_1.paintGo_)

				var_159_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_5)
				var_159_6.name = var_159_5
				var_159_6.transform.parent = arg_156_1.stage_.transform
				var_159_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_5] = var_159_6
			end

			if 1.5 < arg_156_1.time_ and arg_156_1.time_ <= 1.5 + arg_159_0 then
				local var_159_7 = arg_156_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_159_7 then
					arg_156_1.var_.alphaOldValueA00 = var_159_7.color.a
					arg_156_1.var_.alphaMatValueA00 = var_159_7
				end

				arg_156_1.var_.alphaOldValueA00 = 0
			end

			local var_159_8 = 1.5

			if 1.5 <= arg_156_1.time_ and arg_156_1.time_ < 1.5 + var_159_8 then
				if arg_156_1.var_.alphaMatValueA00 then
					arg_156_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_156_1.var_.alphaOldValueA00, 1, (arg_156_1.time_ - 1.5) / var_159_8)
					arg_156_1.var_.alphaMatValueA00.color = arg_156_1.var_.alphaMatValueA00.color
				end
			end

			if arg_156_1.time_ >= 1.5 + var_159_8 and arg_156_1.time_ < 1.5 + var_159_8 + arg_159_0 and arg_156_1.var_.alphaMatValueA00 then
				arg_156_1.var_.alphaMatValueA00.color.a = 1
				arg_156_1.var_.alphaMatValueA00.color = arg_156_1.var_.alphaMatValueA00.color
			end

			if 1.5 < arg_156_1.time_ and arg_156_1.time_ <= 1.5 + arg_159_0 then
				local var_159_9 = arg_156_1.bgs_.A00

				arg_156_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_10 = var_159_9:GetComponent("SpriteRenderer")

				if var_159_10 and var_159_10.sprite then
					local var_159_11 = 2 * (var_159_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_9.transform.localScale = Vector3.New(var_159_11 / var_159_10.sprite.bounds.size.y < var_159_11 * manager.ui.mainCameraCom_.aspect / var_159_10.sprite.bounds.size.x and var_159_11 * manager.ui.mainCameraCom_.aspect / var_159_10.sprite.bounds.size.x or var_159_11 / var_159_10.sprite.bounds.size.y, var_159_11 / var_159_10.sprite.bounds.size.y < var_159_11 * manager.ui.mainCameraCom_.aspect / var_159_10.sprite.bounds.size.x and var_159_11 * manager.ui.mainCameraCom_.aspect / var_159_10.sprite.bounds.size.x or var_159_11 / var_159_10.sprite.bounds.size.y, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "A00" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_12 = arg_156_1.actors_["1099ui_story"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1099ui_story = var_159_12.localPosition
			end

			local var_159_13 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_13 then
				var_159_12.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_13)
				var_159_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_12.position).x, (manager.ui.mainCamera.transform.position - var_159_12.position).y, (manager.ui.mainCamera.transform.position - var_159_12.position).z)
				var_159_12.localEulerAngles.z = 0
				var_159_12.localEulerAngles.x = 0
				var_159_12.localEulerAngles = var_159_12.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_13 and arg_156_1.time_ < 0 + var_159_13 + arg_159_0 then
				var_159_12.localPosition = Vector3.New(0, 100, 0)
				var_159_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_12.position).x, (manager.ui.mainCamera.transform.position - var_159_12.position).y, (manager.ui.mainCamera.transform.position - var_159_12.position).z)
				var_159_12.localEulerAngles.z = 0
				var_159_12.localEulerAngles.x = 0
				var_159_12.localEulerAngles = var_159_12.localEulerAngles
			end

			local var_159_14 = arg_156_1.actors_["1026ui_story"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1026ui_story = var_159_14.localPosition
			end

			local var_159_15 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_15 then
				var_159_14.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1026ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_15)
				var_159_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_14.position).x, (manager.ui.mainCamera.transform.position - var_159_14.position).y, (manager.ui.mainCamera.transform.position - var_159_14.position).z)
				var_159_14.localEulerAngles.z = 0
				var_159_14.localEulerAngles.x = 0
				var_159_14.localEulerAngles = var_159_14.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_15 and arg_156_1.time_ < 0 + var_159_15 + arg_159_0 then
				var_159_14.localPosition = Vector3.New(0, 100, 0)
				var_159_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_14.position).x, (manager.ui.mainCamera.transform.position - var_159_14.position).y, (manager.ui.mainCamera.transform.position - var_159_14.position).z)
				var_159_14.localEulerAngles.z = 0
				var_159_14.localEulerAngles.x = 0
				var_159_14.localEulerAngles = var_159_14.localEulerAngles
			end

			local var_159_16 = 0

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			if arg_156_1.time_ >= var_159_16 + 2 and arg_156_1.time_ < var_159_16 + 2 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_17 = 2
			local var_159_18 = 0.2

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_17 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_19 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_19:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_156_1.dialogCg_.alpha = arg_160_0
				end))
				var_159_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_20 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(106071038).content)

				arg_156_1.text_.text = var_159_20

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_22 = 8 <= 0 and var_159_18 or var_159_18 * (utf8.len(var_159_20) / 8)

				if (8 <= 0 and var_159_18 or var_159_18 * (utf8.len(var_159_20) / 8)) > 0 and var_159_18 < var_159_22 then
					arg_156_1.talkMaxDuration = var_159_22
					var_159_17 = var_159_17 + 0.3

					if var_159_22 + var_159_17 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_17
					end
				end

				arg_156_1.text_.text = var_159_20
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_23 = var_159_17 + 0.3
			local var_159_24 = math.max(var_159_18, arg_156_1.talkMaxDuration)

			if var_159_17 + 0.3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_23 + var_159_24 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_23) / var_159_24

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_23 + var_159_24 and arg_156_1.time_ < var_159_23 + var_159_24 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST10",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1026ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play106071039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 106071039
		arg_162_1.duration_ = 3.6

		local var_162_0 = {
			ja = 3.6,
			ko = 3.566,
			zh = 3.366,
			en = 3.466
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
				arg_162_0:Play106071040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.4

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_1 = arg_162_1:GetWordFromCfg(106071039)
				local var_165_2 = arg_162_1:FormatText(var_165_1.content)

				arg_162_1.text_.text = var_165_2

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 16 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 16)

				if (16 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 16)) > 0 and var_165_0 < var_165_4 then
					arg_162_1.talkMaxDuration = var_165_4

					if var_165_4 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_4 + 0
					end
				end

				arg_162_1.text_.text = var_165_2
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071039", "story_v_out_106071.awb") ~= 0 then
					local var_165_5 = manager.audio:GetVoiceLength("story_v_out_106071", "106071039", "story_v_out_106071.awb") / 1000

					if var_165_5 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + 0
					end

					if var_165_1.prefab_name ~= "" and arg_162_1.actors_[var_165_1.prefab_name] ~= nil then
						local var_165_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_1.prefab_name].transform, "story_v_out_106071", "106071039", "story_v_out_106071.awb")

						arg_162_1:RecordAudio("106071039", var_165_6)
						arg_162_1:RecordAudio("106071039", var_165_6)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_106071", "106071039", "story_v_out_106071.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_106071", "106071039", "story_v_out_106071.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play106071040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 106071040
		arg_166_1.duration_ = 4.6

		local var_166_0 = {
			ja = 4.166,
			ko = 2.333,
			zh = 1.999999999999,
			en = 4.6
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play106071041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1099ui_story"]) and arg_166_1.var_.characterEffect1099ui_story == nil then
				arg_166_1.var_.characterEffect1099ui_story = arg_166_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.1

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1099ui_story"]) then
				if arg_166_1.var_.characterEffect1099ui_story and not isNil(arg_166_1.actors_["1099ui_story"]) then
					arg_166_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1099ui_story"]) and arg_166_1.var_.characterEffect1099ui_story then
				arg_166_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_169_2 = arg_166_1.actors_["1099ui_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1099ui_story = var_169_2.localPosition
			end

			local var_169_3 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 then
				var_169_2.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_166_1.time_ - 0) / var_169_3)
				var_169_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_2.position).x, (manager.ui.mainCamera.transform.position - var_169_2.position).y, (manager.ui.mainCamera.transform.position - var_169_2.position).z)
				var_169_2.localEulerAngles.z = 0
				var_169_2.localEulerAngles.x = 0
				var_169_2.localEulerAngles = var_169_2.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 then
				var_169_2.localPosition = Vector3.New(0, -1.08, -5.9)
				var_169_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_2.position).x, (manager.ui.mainCamera.transform.position - var_169_2.position).y, (manager.ui.mainCamera.transform.position - var_169_2.position).z)
				var_169_2.localEulerAngles.z = 0
				var_169_2.localEulerAngles.x = 0
				var_169_2.localEulerAngles = var_169_2.localEulerAngles
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_169_4 = 0
			local var_169_5 = 0.275

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_6 = arg_166_1:GetWordFromCfg(106071040)
				local var_169_7 = arg_166_1:FormatText(var_169_6.content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 11 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 11)

				if (11 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 11)) > 0 and var_169_5 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_4
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071040", "story_v_out_106071.awb") ~= 0 then
					local var_169_10 = manager.audio:GetVoiceLength("story_v_out_106071", "106071040", "story_v_out_106071.awb") / 1000

					if var_169_10 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_4
					end

					if var_169_6.prefab_name ~= "" and arg_166_1.actors_[var_169_6.prefab_name] ~= nil then
						local var_169_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_6.prefab_name].transform, "story_v_out_106071", "106071040", "story_v_out_106071.awb")

						arg_166_1:RecordAudio("106071040", var_169_11)
						arg_166_1:RecordAudio("106071040", var_169_11)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_106071", "106071040", "story_v_out_106071.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_106071", "106071040", "story_v_out_106071.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_12 = math.max(var_169_5, arg_166_1.talkMaxDuration)

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_12 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_4) / var_169_12

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_4 + var_169_12 and arg_166_1.time_ < var_169_4 + var_169_12 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play106071041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 106071041
		arg_170_1.duration_ = 10.5

		local var_170_0 = {
			ja = 10.5,
			ko = 9.866,
			zh = 8.066,
			en = 9.633
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
				arg_170_0:Play106071042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1099ui_story"]) and arg_170_1.var_.characterEffect1099ui_story == nil then
				arg_170_1.var_.characterEffect1099ui_story = arg_170_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.1

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1099ui_story"]) then
				if arg_170_1.var_.characterEffect1099ui_story and not isNil(arg_170_1.actors_["1099ui_story"]) then
					arg_170_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_0)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1099ui_story"]) and arg_170_1.var_.characterEffect1099ui_story then
				arg_170_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_173_1 = 0
			local var_173_2 = 0.925

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:GetWordFromCfg(106071041)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_6 = 37 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_4) / 37)

				if (37 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_4) / 37)) > 0 and var_173_2 < var_173_6 then
					arg_170_1.talkMaxDuration = var_173_6

					if var_173_6 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071041", "story_v_out_106071.awb") ~= 0 then
					local var_173_7 = manager.audio:GetVoiceLength("story_v_out_106071", "106071041", "story_v_out_106071.awb") / 1000

					if var_173_7 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_1
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_out_106071", "106071041", "story_v_out_106071.awb")

						arg_170_1:RecordAudio("106071041", var_173_8)
						arg_170_1:RecordAudio("106071041", var_173_8)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_106071", "106071041", "story_v_out_106071.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_106071", "106071041", "story_v_out_106071.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_9 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_9 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_9

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_9 and arg_170_1.time_ < var_173_1 + var_173_9 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play106071042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 106071042
		arg_174_1.duration_ = 1.97

		local var_174_0 = {
			ja = 1.766,
			ko = 1.6,
			zh = 1.733,
			en = 1.966
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play106071043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1099ui_story"]) and arg_174_1.var_.characterEffect1099ui_story == nil then
				arg_174_1.var_.characterEffect1099ui_story = arg_174_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.1

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1099ui_story"]) then
				if arg_174_1.var_.characterEffect1099ui_story and not isNil(arg_174_1.actors_["1099ui_story"]) then
					arg_174_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1099ui_story"]) and arg_174_1.var_.characterEffect1099ui_story then
				arg_174_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_177_2 = 0
			local var_177_3 = 0.25

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_2 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_4 = arg_174_1:GetWordFromCfg(106071042)
				local var_177_5 = arg_174_1:FormatText(var_177_4.content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 10 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 10)

				if (10 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 10)) > 0 and var_177_3 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_2
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071042", "story_v_out_106071.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_106071", "106071042", "story_v_out_106071.awb") / 1000

					if var_177_8 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_2
					end

					if var_177_4.prefab_name ~= "" and arg_174_1.actors_[var_177_4.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_4.prefab_name].transform, "story_v_out_106071", "106071042", "story_v_out_106071.awb")

						arg_174_1:RecordAudio("106071042", var_177_9)
						arg_174_1:RecordAudio("106071042", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_106071", "106071042", "story_v_out_106071.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_106071", "106071042", "story_v_out_106071.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_3, arg_174_1.talkMaxDuration)

			if var_177_2 <= arg_174_1.time_ and arg_174_1.time_ < var_177_2 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_2) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_2 + var_177_10 and arg_174_1.time_ < var_177_2 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play106071043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 106071043
		arg_178_1.duration_ = 8.13

		local var_178_0 = {
			ja = 6.633,
			ko = 5.1,
			zh = 7.066,
			en = 8.133
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play106071044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1099ui_story"]) and arg_178_1.var_.characterEffect1099ui_story == nil then
				arg_178_1.var_.characterEffect1099ui_story = arg_178_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.1

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1099ui_story"]) then
				if arg_178_1.var_.characterEffect1099ui_story and not isNil(arg_178_1.actors_["1099ui_story"]) then
					arg_178_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1099ui_story"]) and arg_178_1.var_.characterEffect1099ui_story then
				arg_178_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_181_1 = 0
			local var_181_2 = 0.8

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(106071043)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_6 = 32 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_4) / 32)

				if (32 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_4) / 32)) > 0 and var_181_2 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071043", "story_v_out_106071.awb") ~= 0 then
					local var_181_7 = manager.audio:GetVoiceLength("story_v_out_106071", "106071043", "story_v_out_106071.awb") / 1000

					if var_181_7 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_1
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_106071", "106071043", "story_v_out_106071.awb")

						arg_178_1:RecordAudio("106071043", var_181_8)
						arg_178_1:RecordAudio("106071043", var_181_8)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_106071", "106071043", "story_v_out_106071.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_106071", "106071043", "story_v_out_106071.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_9 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_9 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_9

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_9 and arg_178_1.time_ < var_181_1 + var_181_9 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play106071044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 106071044
		arg_182_1.duration_ = 2.27

		local var_182_0 = {
			ja = 2.266,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_182_0:Play106071045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1099ui_story"]) and arg_182_1.var_.characterEffect1099ui_story == nil then
				arg_182_1.var_.characterEffect1099ui_story = arg_182_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.1

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1099ui_story"]) then
				if arg_182_1.var_.characterEffect1099ui_story and not isNil(arg_182_1.actors_["1099ui_story"]) then
					arg_182_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1099ui_story"]) and arg_182_1.var_.characterEffect1099ui_story then
				arg_182_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action456")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_185_2 = 0
			local var_185_3 = 0.225

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:GetWordFromCfg(106071044)
				local var_185_5 = arg_182_1:FormatText(var_185_4.content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 9 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 9)

				if (9 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 9)) > 0 and var_185_3 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071044", "story_v_out_106071.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_106071", "106071044", "story_v_out_106071.awb") / 1000

					if var_185_8 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_2
					end

					if var_185_4.prefab_name ~= "" and arg_182_1.actors_[var_185_4.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_4.prefab_name].transform, "story_v_out_106071", "106071044", "story_v_out_106071.awb")

						arg_182_1:RecordAudio("106071044", var_185_9)
						arg_182_1:RecordAudio("106071044", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_106071", "106071044", "story_v_out_106071.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_106071", "106071044", "story_v_out_106071.awb")
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
	Play106071045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 106071045
		arg_186_1.duration_ = 5.37

		local var_186_0 = {
			ja = 3.466,
			ko = 4.533,
			zh = 3.8,
			en = 5.366
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
				arg_186_0:Play106071046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1099ui_story"]) and arg_186_1.var_.characterEffect1099ui_story == nil then
				arg_186_1.var_.characterEffect1099ui_story = arg_186_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.1

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1099ui_story"]) then
				if arg_186_1.var_.characterEffect1099ui_story and not isNil(arg_186_1.actors_["1099ui_story"]) then
					arg_186_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1099ui_story"]) and arg_186_1.var_.characterEffect1099ui_story then
				arg_186_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_189_1 = 0
			local var_189_2 = 0.425

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(106071045)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_6 = 17 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_4) / 17)

				if (17 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_4) / 17)) > 0 and var_189_2 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_1
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071045", "story_v_out_106071.awb") ~= 0 then
					local var_189_7 = manager.audio:GetVoiceLength("story_v_out_106071", "106071045", "story_v_out_106071.awb") / 1000

					if var_189_7 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_1
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_out_106071", "106071045", "story_v_out_106071.awb")

						arg_186_1:RecordAudio("106071045", var_189_8)
						arg_186_1:RecordAudio("106071045", var_189_8)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_106071", "106071045", "story_v_out_106071.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_106071", "106071045", "story_v_out_106071.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_9 = math.max(var_189_2, arg_186_1.talkMaxDuration)

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_9 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_1) / var_189_9

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_1 + var_189_9 and arg_186_1.time_ < var_189_1 + var_189_9 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play106071046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 106071046
		arg_190_1.duration_ = 7.43

		local var_190_0 = {
			ja = 4.066,
			ko = 5.866,
			zh = 7.366,
			en = 7.433
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play106071047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1099ui_story"]) and arg_190_1.var_.characterEffect1099ui_story == nil then
				arg_190_1.var_.characterEffect1099ui_story = arg_190_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.1

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1099ui_story"]) then
				if arg_190_1.var_.characterEffect1099ui_story and not isNil(arg_190_1.actors_["1099ui_story"]) then
					arg_190_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1099ui_story"]) and arg_190_1.var_.characterEffect1099ui_story then
				arg_190_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_193_2 = 0
			local var_193_3 = 1.025

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_4 = arg_190_1:GetWordFromCfg(106071046)
				local var_193_5 = arg_190_1:FormatText(var_193_4.content)

				arg_190_1.text_.text = var_193_5

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_7 = 41 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 41)

				if (41 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 41)) > 0 and var_193_3 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_2
					end
				end

				arg_190_1.text_.text = var_193_5
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071046", "story_v_out_106071.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_106071", "106071046", "story_v_out_106071.awb") / 1000

					if var_193_8 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_2
					end

					if var_193_4.prefab_name ~= "" and arg_190_1.actors_[var_193_4.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_4.prefab_name].transform, "story_v_out_106071", "106071046", "story_v_out_106071.awb")

						arg_190_1:RecordAudio("106071046", var_193_9)
						arg_190_1:RecordAudio("106071046", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_106071", "106071046", "story_v_out_106071.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_106071", "106071046", "story_v_out_106071.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_3, arg_190_1.talkMaxDuration)

			if var_193_2 <= arg_190_1.time_ and arg_190_1.time_ < var_193_2 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_2) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_2 + var_193_10 and arg_190_1.time_ < var_193_2 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play106071047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 106071047
		arg_194_1.duration_ = 3.5

		local var_194_0 = {
			ja = 3.5,
			ko = 3.366,
			zh = 3,
			en = 2.6
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
			arg_194_1.auto_ = false
		end

		function arg_194_1.playNext_(arg_196_0)
			arg_194_1.onStoryFinished_()
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_197_0 = 0
			local var_197_1 = 0.3

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_2 = arg_194_1:GetWordFromCfg(106071047)
				local var_197_3 = arg_194_1:FormatText(var_197_2.content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 12 <= 0 and var_197_1 or var_197_1 * (utf8.len(var_197_3) / 12)

				if (12 <= 0 and var_197_1 or var_197_1 * (utf8.len(var_197_3) / 12)) > 0 and var_197_1 < var_197_5 then
					arg_194_1.talkMaxDuration = var_197_5

					if var_197_5 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_3
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106071", "106071047", "story_v_out_106071.awb") ~= 0 then
					local var_197_6 = manager.audio:GetVoiceLength("story_v_out_106071", "106071047", "story_v_out_106071.awb") / 1000

					if var_197_6 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_6 + var_197_0
					end

					if var_197_2.prefab_name ~= "" and arg_194_1.actors_[var_197_2.prefab_name] ~= nil then
						local var_197_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_2.prefab_name].transform, "story_v_out_106071", "106071047", "story_v_out_106071.awb")

						arg_194_1:RecordAudio("106071047", var_197_7)
						arg_194_1:RecordAudio("106071047", var_197_7)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_106071", "106071047", "story_v_out_106071.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_106071", "106071047", "story_v_out_106071.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_8 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_8 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_8

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_8 and arg_194_1.time_ < var_197_0 + var_197_8 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/S0610",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_106071.awb"
	}
}
