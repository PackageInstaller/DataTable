return {
	Play109011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109011001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play109011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

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

			local var_4_3 = 0
			local var_4_4 = 0.575

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_5 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_5:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_6 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(109011001).content)

				arg_1_1.text_.text = var_4_6

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_8 = 23 <= 0 and var_4_4 or var_4_4 * (utf8.len(var_4_6) / 23)

				if (23 <= 0 and var_4_4 or var_4_4 * (utf8.len(var_4_6) / 23)) > 0 and var_4_4 < var_4_8 then
					arg_1_1.talkMaxDuration = var_4_8
					var_4_3 = var_4_3 + 0.3

					if var_4_8 + var_4_3 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_8 + var_4_3
					end
				end

				arg_1_1.text_.text = var_4_6
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_9 = var_4_3 + 0.3
			local var_4_10 = math.max(var_4_4, arg_1_1.talkMaxDuration)

			if var_4_3 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_10 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_9) / var_4_10

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_9 + var_4_10 and arg_1_1.time_ < var_4_9 + var_4_10 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play109011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109011002
		arg_8_1.duration_ = 10.3

		local var_8_0 = {
			ja = 8,
			ko = 9.833,
			zh = 10.266,
			en = 10.3
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
				arg_8_0:Play109011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.bgs_.C05b == nil then
				local var_11_0 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C05b")
				var_11_0.name = "C05b"
				var_11_0.transform.parent = arg_8_1.stage_.transform
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_.C05b = var_11_0
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				local var_11_1 = arg_8_1.bgs_.C05b

				arg_8_1.bgs_.C05b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_11_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_2 = var_11_1:GetComponent("SpriteRenderer")

				if var_11_2 and var_11_2.sprite then
					local var_11_3 = 2 * (var_11_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_11_1.transform.localScale = Vector3.New(var_11_3 / var_11_2.sprite.bounds.size.y < var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x and var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x or var_11_3 / var_11_2.sprite.bounds.size.y, var_11_3 / var_11_2.sprite.bounds.size.y < var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x and var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x or var_11_3 / var_11_2.sprite.bounds.size.y, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "C05b" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				local var_11_4 = arg_8_1.bgs_.C05b:GetComponent("SpriteRenderer")

				if var_11_4 then
					arg_8_1.var_.alphaOldValueC05b = var_11_4.color.a
					arg_8_1.var_.alphaMatValueC05b = var_11_4
				end

				arg_8_1.var_.alphaOldValueC05b = 0
			end

			local var_11_5 = 1.5

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_5 then
				if arg_8_1.var_.alphaMatValueC05b then
					arg_8_1.var_.alphaMatValueC05b.color.a = Mathf.Lerp(arg_8_1.var_.alphaOldValueC05b, 1, (arg_8_1.time_ - 0) / var_11_5)
					arg_8_1.var_.alphaMatValueC05b.color = arg_8_1.var_.alphaMatValueC05b.color
				end
			end

			if arg_8_1.time_ >= 0 + var_11_5 and arg_8_1.time_ < 0 + var_11_5 + arg_11_0 and arg_8_1.var_.alphaMatValueC05b then
				arg_8_1.var_.alphaMatValueC05b.color.a = 1
				arg_8_1.var_.alphaMatValueC05b.color = arg_8_1.var_.alphaMatValueC05b.color
			end

			local var_11_6 = "1084ui_story"

			if arg_8_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_11_7 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

				var_11_7.name = var_11_6
				var_11_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_[var_11_6] = var_11_7

				local var_11_8 = var_11_7:GetComponentInChildren(typeof(CharacterEffect))

				var_11_8.enabled = true

				local var_11_9 = GameObjectTools.GetOrAddComponent(var_11_7, typeof(DynamicBoneHelper))

				if var_11_9 then
					var_11_9:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_8.transform, false)

				arg_8_1.var_[var_11_6 .. "Animator"] = var_11_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_[var_11_6 .. "Animator"].applyRootMotion = true
				arg_8_1.var_[var_11_6 .. "LipSync"] = var_11_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_10 = arg_8_1.actors_["1084ui_story"]

			if 1.8 < arg_8_1.time_ and arg_8_1.time_ <= 1.8 + arg_11_0 and not isNil(var_11_10) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.2

			if 1.8 <= arg_8_1.time_ and arg_8_1.time_ < 1.8 + var_11_11 and not isNil(var_11_10) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_10) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 1.8 + var_11_11 and arg_8_1.time_ < 1.8 + var_11_11 + arg_11_0 and not isNil(var_11_10) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_13 = arg_8_1.actors_["1084ui_story"].transform

			if 1.8 < arg_8_1.time_ and arg_8_1.time_ <= 1.8 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_13.localPosition
			end

			local var_11_14 = 0.001

			if 1.8 <= arg_8_1.time_ and arg_8_1.time_ < 1.8 + var_11_14 then
				var_11_13.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_8_1.time_ - 1.8) / var_11_14)
				var_11_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_13.position).x, (manager.ui.mainCamera.transform.position - var_11_13.position).y, (manager.ui.mainCamera.transform.position - var_11_13.position).z)
				var_11_13.localEulerAngles.z = 0
				var_11_13.localEulerAngles.x = 0
				var_11_13.localEulerAngles = var_11_13.localEulerAngles
			end

			if arg_8_1.time_ >= 1.8 + var_11_14 and arg_8_1.time_ < 1.8 + var_11_14 + arg_11_0 then
				var_11_13.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_11_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_13.position).x, (manager.ui.mainCamera.transform.position - var_11_13.position).y, (manager.ui.mainCamera.transform.position - var_11_13.position).z)
				var_11_13.localEulerAngles.z = 0
				var_11_13.localEulerAngles.x = 0
				var_11_13.localEulerAngles = var_11_13.localEulerAngles
			end

			if 1.8 < arg_8_1.time_ and arg_8_1.time_ <= 1.8 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 1.8 < arg_8_1.time_ and arg_8_1.time_ <= 1.8 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_15 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			if arg_8_1.time_ >= var_11_15 + 2 and arg_8_1.time_ < var_11_15 + 2 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end

			local var_11_16 = 2
			local var_11_17 = 0.725

			if 2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
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

				local var_11_18 = arg_8_1:GetWordFromCfg(109011002)
				local var_11_19 = arg_8_1:FormatText(var_11_18.content)

				arg_8_1.text_.text = var_11_19

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_21 = 29 <= 0 and var_11_17 or var_11_17 * (utf8.len(var_11_19) / 29)

				if (29 <= 0 and var_11_17 or var_11_17 * (utf8.len(var_11_19) / 29)) > 0 and var_11_17 < var_11_21 then
					arg_8_1.talkMaxDuration = var_11_21

					if var_11_21 + var_11_16 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_21 + var_11_16
					end
				end

				arg_8_1.text_.text = var_11_19
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011002", "story_v_out_109011.awb") ~= 0 then
					local var_11_22 = manager.audio:GetVoiceLength("story_v_out_109011", "109011002", "story_v_out_109011.awb") / 1000

					if var_11_22 + var_11_16 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_22 + var_11_16
					end

					if var_11_18.prefab_name ~= "" and arg_8_1.actors_[var_11_18.prefab_name] ~= nil then
						local var_11_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_18.prefab_name].transform, "story_v_out_109011", "109011002", "story_v_out_109011.awb")

						arg_8_1:RecordAudio("109011002", var_11_23)
						arg_8_1:RecordAudio("109011002", var_11_23)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_109011", "109011002", "story_v_out_109011.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_109011", "109011002", "story_v_out_109011.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_24 = math.max(var_11_17, arg_8_1.talkMaxDuration)

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_24 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_16) / var_11_24

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_16 + var_11_24 and arg_8_1.time_ < var_11_16 + var_11_24 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play109011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109011003
		arg_12_1.duration_ = 5.6

		local var_12_0 = {
			ja = 3.533,
			ko = 5.033,
			zh = 5.6,
			en = 4.533
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
				arg_12_0:Play109011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1038ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1038ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1038ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1038ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1038ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1038ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["1038ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1038ui_story == nil then
				arg_12_1.var_.characterEffect1038ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1038ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1038ui_story then
				arg_12_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_15_8 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_8) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_9 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_9 and not isNil(var_15_8) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_8) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_9)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_9 and arg_12_1.time_ < 0 + var_15_9 + arg_15_0 and not isNil(var_15_8) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_15_10 = 0
			local var_15_11 = 0.55

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(109011003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 22 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 22)

				if (22 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 22)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011003", "story_v_out_109011.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_109011", "109011003", "story_v_out_109011.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_109011", "109011003", "story_v_out_109011.awb")

						arg_12_1:RecordAudio("109011003", var_15_17)
						arg_12_1:RecordAudio("109011003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109011", "109011003", "story_v_out_109011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109011", "109011003", "story_v_out_109011.awb")
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play109011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109011004
		arg_16_1.duration_ = 11.43

		local var_16_0 = {
			ja = 10.166,
			ko = 8.9,
			zh = 8.2,
			en = 11.433
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
				arg_16_0:Play109011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1038ui_story"]) and arg_16_1.var_.characterEffect1038ui_story == nil then
				arg_16_1.var_.characterEffect1038ui_story = arg_16_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1038ui_story"]) then
				if arg_16_1.var_.characterEffect1038ui_story and not isNil(arg_16_1.actors_["1038ui_story"]) then
					arg_16_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1038ui_story"]) and arg_16_1.var_.characterEffect1038ui_story then
				arg_16_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_19_1 = arg_16_1.actors_["1084ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 and not isNil(var_19_1) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_1) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_2)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_19_3 = 0
			local var_19_4 = 1

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_5 = arg_16_1:GetWordFromCfg(109011004)
				local var_19_6 = arg_16_1:FormatText(var_19_5.content)

				arg_16_1.text_.text = var_19_6

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_8 = 40 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_6) / 40)

				if (40 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_6) / 40)) > 0 and var_19_4 < var_19_8 then
					arg_16_1.talkMaxDuration = var_19_8

					if var_19_8 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_3
					end
				end

				arg_16_1.text_.text = var_19_6
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011004", "story_v_out_109011.awb") ~= 0 then
					local var_19_9 = manager.audio:GetVoiceLength("story_v_out_109011", "109011004", "story_v_out_109011.awb") / 1000

					if var_19_9 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_3
					end

					if var_19_5.prefab_name ~= "" and arg_16_1.actors_[var_19_5.prefab_name] ~= nil then
						local var_19_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_5.prefab_name].transform, "story_v_out_109011", "109011004", "story_v_out_109011.awb")

						arg_16_1:RecordAudio("109011004", var_19_10)
						arg_16_1:RecordAudio("109011004", var_19_10)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109011", "109011004", "story_v_out_109011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109011", "109011004", "story_v_out_109011.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_4, arg_16_1.talkMaxDuration)

			if var_19_3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_3 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_3) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_3 + var_19_11 and arg_16_1.time_ < var_19_3 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play109011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109011005
		arg_20_1.duration_ = 4.6

		local var_20_0 = {
			ja = 3.466,
			ko = 2.833,
			zh = 2.866,
			en = 4.6
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
				arg_20_0:Play109011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_23_0 = 0
			local var_23_1 = 0.25

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_2 = arg_20_1:GetWordFromCfg(109011005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 10 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 10)

				if (10 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 10)) > 0 and var_23_1 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011005", "story_v_out_109011.awb") ~= 0 then
					local var_23_6 = manager.audio:GetVoiceLength("story_v_out_109011", "109011005", "story_v_out_109011.awb") / 1000

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end

					if var_23_2.prefab_name ~= "" and arg_20_1.actors_[var_23_2.prefab_name] ~= nil then
						local var_23_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_2.prefab_name].transform, "story_v_out_109011", "109011005", "story_v_out_109011.awb")

						arg_20_1:RecordAudio("109011005", var_23_7)
						arg_20_1:RecordAudio("109011005", var_23_7)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_109011", "109011005", "story_v_out_109011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_109011", "109011005", "story_v_out_109011.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play109011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109011006
		arg_24_1.duration_ = 5.27

		local var_24_0 = {
			ja = 3.1,
			ko = 3.066,
			zh = 3.966,
			en = 5.266
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
				arg_24_0:Play109011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1038ui_story"]) and arg_24_1.var_.characterEffect1038ui_story == nil then
				arg_24_1.var_.characterEffect1038ui_story = arg_24_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1038ui_story"]) then
				if arg_24_1.var_.characterEffect1038ui_story and not isNil(arg_24_1.actors_["1038ui_story"]) then
					arg_24_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1038ui_story"]) and arg_24_1.var_.characterEffect1038ui_story then
				arg_24_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action435")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_27_2 = 0
			local var_27_3 = 0.35

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(109011006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 14 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 14)

				if (14 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 14)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011006", "story_v_out_109011.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_109011", "109011006", "story_v_out_109011.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_109011", "109011006", "story_v_out_109011.awb")

						arg_24_1:RecordAudio("109011006", var_27_9)
						arg_24_1:RecordAudio("109011006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109011", "109011006", "story_v_out_109011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109011", "109011006", "story_v_out_109011.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_10 and arg_24_1.time_ < var_27_2 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play109011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109011007
		arg_28_1.duration_ = 4.87

		local var_28_0 = {
			ja = 4.1,
			ko = 3.433,
			zh = 4.866,
			en = 4.733
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
				arg_28_0:Play109011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1084ui_story"]) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = arg_28_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1084ui_story"]) then
				if arg_28_1.var_.characterEffect1084ui_story and not isNil(arg_28_1.actors_["1084ui_story"]) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1084ui_story"]) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["1038ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1038ui_story == nil then
				arg_28_1.var_.characterEffect1038ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1038ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1038ui_story then
				arg_28_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_31_4 = 0
			local var_31_5 = 0.625

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(109011007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 25 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 25)

				if (25 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 25)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011007", "story_v_out_109011.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_109011", "109011007", "story_v_out_109011.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_109011", "109011007", "story_v_out_109011.awb")

						arg_28_1:RecordAudio("109011007", var_31_11)
						arg_28_1:RecordAudio("109011007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109011", "109011007", "story_v_out_109011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109011", "109011007", "story_v_out_109011.awb")
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
	Play109011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109011008
		arg_32_1.duration_ = 6.9

		local var_32_0 = {
			ja = 5.666,
			ko = 6.2,
			zh = 5.566,
			en = 6.9
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
				arg_32_0:Play109011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_35_0 = 0
			local var_35_1 = 0.725

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(109011008)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 29 <= 0 and var_35_1 or var_35_1 * (utf8.len(var_35_3) / 29)

				if (29 <= 0 and var_35_1 or var_35_1 * (utf8.len(var_35_3) / 29)) > 0 and var_35_1 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011008", "story_v_out_109011.awb") ~= 0 then
					local var_35_6 = manager.audio:GetVoiceLength("story_v_out_109011", "109011008", "story_v_out_109011.awb") / 1000

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end

					if var_35_2.prefab_name ~= "" and arg_32_1.actors_[var_35_2.prefab_name] ~= nil then
						local var_35_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_2.prefab_name].transform, "story_v_out_109011", "109011008", "story_v_out_109011.awb")

						arg_32_1:RecordAudio("109011008", var_35_7)
						arg_32_1:RecordAudio("109011008", var_35_7)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_109011", "109011008", "story_v_out_109011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_109011", "109011008", "story_v_out_109011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_8 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_8 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_8

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_8 and arg_32_1.time_ < var_35_0 + var_35_8 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play109011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109011009
		arg_36_1.duration_ = 6.67

		local var_36_0 = {
			ja = 6.533,
			ko = 4.566,
			zh = 4.466,
			en = 6.666
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
				arg_36_0:Play109011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = arg_36_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).z)
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles = arg_36_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1084ui_story"].transform.position).z)
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1084ui_story"].transform.localEulerAngles = arg_36_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_39_1 = "1099ui_story"

			if arg_36_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_36_1.stage_.transform)

				var_39_2.name = var_39_1
				var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_[var_39_1] = var_39_2

				local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

				var_39_3.enabled = true

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_3.transform, false)

				arg_36_1.var_[var_39_1 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_[var_39_1 .. "Animator"].applyRootMotion = true
				arg_36_1.var_[var_39_1 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_5 = arg_36_1.actors_["1099ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1099ui_story = var_39_5.localPosition
			end

			local var_39_6 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 then
				var_39_5.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1099ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_36_1.time_ - 0) / var_39_6)
				var_39_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_5.position).x, (manager.ui.mainCamera.transform.position - var_39_5.position).y, (manager.ui.mainCamera.transform.position - var_39_5.position).z)
				var_39_5.localEulerAngles.z = 0
				var_39_5.localEulerAngles.x = 0
				var_39_5.localEulerAngles = var_39_5.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 then
				var_39_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_39_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_5.position).x, (manager.ui.mainCamera.transform.position - var_39_5.position).y, (manager.ui.mainCamera.transform.position - var_39_5.position).z)
				var_39_5.localEulerAngles.z = 0
				var_39_5.localEulerAngles.x = 0
				var_39_5.localEulerAngles = var_39_5.localEulerAngles
			end

			local var_39_7 = arg_36_1.actors_["1099ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect1099ui_story == nil then
				arg_36_1.var_.characterEffect1099ui_story = var_39_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_8 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_8 and not isNil(var_39_7) then
				if arg_36_1.var_.characterEffect1099ui_story and not isNil(var_39_7) then
					arg_36_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_8 and arg_36_1.time_ < 0 + var_39_8 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect1099ui_story then
				arg_36_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_39_10 = 0
			local var_39_11 = 0.575

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_12 = arg_36_1:GetWordFromCfg(109011009)
				local var_39_13 = arg_36_1:FormatText(var_39_12.content)

				arg_36_1.text_.text = var_39_13

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 22 <= 0 and var_39_11 or var_39_11 * (utf8.len(var_39_13) / 22)

				if (22 <= 0 and var_39_11 or var_39_11 * (utf8.len(var_39_13) / 22)) > 0 and var_39_11 < var_39_15 then
					arg_36_1.talkMaxDuration = var_39_15

					if var_39_15 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_15 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_13
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011009", "story_v_out_109011.awb") ~= 0 then
					local var_39_16 = manager.audio:GetVoiceLength("story_v_out_109011", "109011009", "story_v_out_109011.awb") / 1000

					if var_39_16 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_16 + var_39_10
					end

					if var_39_12.prefab_name ~= "" and arg_36_1.actors_[var_39_12.prefab_name] ~= nil then
						local var_39_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_12.prefab_name].transform, "story_v_out_109011", "109011009", "story_v_out_109011.awb")

						arg_36_1:RecordAudio("109011009", var_39_17)
						arg_36_1:RecordAudio("109011009", var_39_17)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109011", "109011009", "story_v_out_109011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109011", "109011009", "story_v_out_109011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_18 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_18 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_18

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_18 and arg_36_1.time_ < var_39_10 + var_39_18 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play109011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109011010
		arg_40_1.duration_ = 2

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play109011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1038ui_story"]) and arg_40_1.var_.characterEffect1038ui_story == nil then
				arg_40_1.var_.characterEffect1038ui_story = arg_40_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1038ui_story"]) then
				if arg_40_1.var_.characterEffect1038ui_story and not isNil(arg_40_1.actors_["1038ui_story"]) then
					arg_40_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1038ui_story"]) and arg_40_1.var_.characterEffect1038ui_story then
				arg_40_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1099ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1099ui_story == nil then
				arg_40_1.var_.characterEffect1099ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1099ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1099ui_story then
				arg_40_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_43_4 = 0
			local var_43_5 = 0.2

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(109011010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 8 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 8)

				if (8 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 8)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011010", "story_v_out_109011.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_109011", "109011010", "story_v_out_109011.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_109011", "109011010", "story_v_out_109011.awb")

						arg_40_1:RecordAudio("109011010", var_43_11)
						arg_40_1:RecordAudio("109011010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109011", "109011010", "story_v_out_109011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109011", "109011010", "story_v_out_109011.awb")
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
	Play109011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109011011
		arg_44_1.duration_ = 16.07

		local var_44_0 = {
			ja = 7.966,
			ko = 16.066,
			zh = 12.166,
			en = 12.433
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
				arg_44_0:Play109011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1038ui_story"]) and arg_44_1.var_.characterEffect1038ui_story == nil then
				arg_44_1.var_.characterEffect1038ui_story = arg_44_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1038ui_story"]) then
				if arg_44_1.var_.characterEffect1038ui_story and not isNil(arg_44_1.actors_["1038ui_story"]) then
					arg_44_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1038ui_story"]) and arg_44_1.var_.characterEffect1038ui_story then
				arg_44_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_47_1 = arg_44_1.actors_["1099ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1099ui_story == nil then
				arg_44_1.var_.characterEffect1099ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect1099ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1099ui_story then
				arg_44_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_2")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_47_4 = 0
			local var_47_5 = 1.675

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(109011011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 67 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 67)

				if (67 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 67)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011011", "story_v_out_109011.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_109011", "109011011", "story_v_out_109011.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_109011", "109011011", "story_v_out_109011.awb")

						arg_44_1:RecordAudio("109011011", var_47_11)
						arg_44_1:RecordAudio("109011011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_109011", "109011011", "story_v_out_109011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_109011", "109011011", "story_v_out_109011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play109011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109011012
		arg_48_1.duration_ = 6.17

		local var_48_0 = {
			ja = 6.166,
			ko = 4.233,
			zh = 4.166,
			en = 5.066
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
			arg_48_1.auto_ = false
		end

		function arg_48_1.playNext_(arg_50_0)
			arg_48_1.onStoryFinished_()
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_51_0 = 0
			local var_51_1 = 0.65

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(109011012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 26 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 26)

				if (26 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 26)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109011", "109011012", "story_v_out_109011.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_out_109011", "109011012", "story_v_out_109011.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_out_109011", "109011012", "story_v_out_109011.awb")

						arg_48_1:RecordAudio("109011012", var_51_7)
						arg_48_1:RecordAudio("109011012", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_109011", "109011012", "story_v_out_109011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_109011", "109011012", "story_v_out_109011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C05b"
	},
	voices = {
		"story_v_out_109011.awb"
	}
}
