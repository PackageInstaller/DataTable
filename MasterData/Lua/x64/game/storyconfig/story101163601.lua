return {
	Play116361001 = function(arg_1_0, arg_1_1)
		arg_1_1.marker = "Mark1"
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116361001
		arg_1_1.duration_ = 22.5

		local var_1_0 = {
			zh = 18.336,
			ja = 22.503
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
			arg_1_1.marker = ""

			if arg_3_0 == 1 then
				arg_1_0:Play116361002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I07a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")
				var_4_0.name = "I07a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I07a = var_4_0
			end

			if 3.67 < arg_1_1.time_ and arg_1_1.time_ <= 3.67 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I07a

				arg_1_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I07a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, false)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)

				arg_1_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/story_101161201.usm", function(arg_5_0)
					arg_1_1.time_ = var_4_4 + 3.66000000022352

					if arg_1_1.state_ == "pause" then
						arg_1_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_6_0)
					arg_1_1.state_ = arg_6_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_5 = 3.67

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				arg_1_1.marker = ""
			end

			local var_4_6 = 3.67

			if 3.67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_7 = 0.0166666666666667

			if var_4_6 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 then
				-- block empty
			end

			local var_4_8 = 3.68666666666667

			if 3.68666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_9 = 2

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_9 then
				local var_4_10 = Color.New(0, 0, 0)

				var_4_10.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_8) / var_4_9)
				arg_1_1.mask_.color = var_4_10
			end

			if arg_1_1.time_ >= var_4_8 + var_4_9 and arg_1_1.time_ < var_4_8 + var_4_9 + arg_4_0 then
				local var_4_11 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_11.a = 0
				arg_1_1.mask_.color = var_4_11
			end

			local var_4_12 = "10032ui_story"

			if arg_1_1.actors_["10032ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10032ui_story"))) then
				local var_4_13 = Object.Instantiate(Asset.Load("Char/" .. "10032ui_story"), arg_1_1.stage_.transform)

				var_4_13.name = var_4_12
				var_4_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_12] = var_4_13

				local var_4_14 = var_4_13:GetComponentInChildren(typeof(CharacterEffect))

				var_4_14.enabled = true

				local var_4_15 = GameObjectTools.GetOrAddComponent(var_4_13, typeof(DynamicBoneHelper))

				if var_4_15 then
					var_4_15:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_14.transform, false)

				arg_1_1.var_[var_4_12 .. "Animator"] = var_4_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_12 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_12 .. "LipSync"] = var_4_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_16 = arg_1_1.actors_["10032ui_story"].transform

			if 5.68666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 5.68666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos10032ui_story = var_4_16.localPosition
			end

			local var_4_17 = 0.001

			if 5.68666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 5.68666666666667 + var_4_17 then
				var_4_16.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_1_1.time_ - 5.68666666666667) / var_4_17)
				var_4_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_16.position).x, (manager.ui.mainCamera.transform.position - var_4_16.position).y, (manager.ui.mainCamera.transform.position - var_4_16.position).z)
				var_4_16.localEulerAngles.z = 0
				var_4_16.localEulerAngles.x = 0
				var_4_16.localEulerAngles = var_4_16.localEulerAngles
			end

			if arg_1_1.time_ >= 5.68666666666667 + var_4_17 and arg_1_1.time_ < 5.68666666666667 + var_4_17 + arg_4_0 then
				var_4_16.localPosition = Vector3.New(0, -1.1, -5.9)
				var_4_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_16.position).x, (manager.ui.mainCamera.transform.position - var_4_16.position).y, (manager.ui.mainCamera.transform.position - var_4_16.position).z)
				var_4_16.localEulerAngles.z = 0
				var_4_16.localEulerAngles.x = 0
				var_4_16.localEulerAngles = var_4_16.localEulerAngles
			end

			if 5.68666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 5.68666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			if 5.68666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 5.68666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_4_18 = arg_1_1.actors_["10032ui_story"]

			if 5.68666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 5.68666666666667 + arg_4_0 and not isNil(var_4_18) and arg_1_1.var_.characterEffect10032ui_story == nil then
				arg_1_1.var_.characterEffect10032ui_story = var_4_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_19 = 0.2

			if 5.68666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 5.68666666666667 + var_4_19 and not isNil(var_4_18) then
				if arg_1_1.var_.characterEffect10032ui_story and not isNil(var_4_18) then
					arg_1_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 5.68666666666667 + var_4_19 and arg_1_1.time_ < 5.68666666666667 + var_4_19 + arg_4_0 and not isNil(var_4_18) and arg_1_1.var_.characterEffect10032ui_story then
				arg_1_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 5.67
			local var_4_25 = 1.075

			if 5.67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(116361001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 43 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 43)

				if (43 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 43)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361001", "story_v_out_116361.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_116361", "116361001", "story_v_out_116361.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_116361", "116361001", "story_v_out_116361.awb")

						arg_1_1:RecordAudio("116361001", var_4_32)
						arg_1_1:RecordAudio("116361001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116361", "116361001", "story_v_out_116361.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116361", "116361001", "story_v_out_116361.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.68666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play116361002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116361002
		arg_10_1.duration_ = 12.53

		local var_10_0 = {
			zh = 11.966,
			ja = 12.533
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116361003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos10032ui_story = arg_10_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_13_0 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_0 then
				arg_10_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_10_1.time_ - 0) / var_13_0)
				arg_10_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_10_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_10_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_10_1.actors_["10032ui_story"].transform.position).z)
				arg_10_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_10_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_10_1.actors_["10032ui_story"].transform.localEulerAngles = arg_10_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_10_1.time_ >= 0 + var_13_0 and arg_10_1.time_ < 0 + var_13_0 + arg_13_0 then
				arg_10_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_10_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_10_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_10_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_10_1.actors_["10032ui_story"].transform.position).z)
				arg_10_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_10_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_10_1.actors_["10032ui_story"].transform.localEulerAngles = arg_10_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_13_1 = arg_10_1.actors_["10032ui_story"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_1) and arg_10_1.var_.characterEffect10032ui_story == nil then
				arg_10_1.var_.characterEffect10032ui_story = var_13_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_2 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_2 and not isNil(var_13_1) then
				if arg_10_1.var_.characterEffect10032ui_story and not isNil(var_13_1) then
					arg_10_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= 0 + var_13_2 and arg_10_1.time_ < 0 + var_13_2 + arg_13_0 and not isNil(var_13_1) and arg_10_1.var_.characterEffect10032ui_story then
				arg_10_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_13_4 = 0
			local var_13_5 = 1.2

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_4 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_6 = arg_10_1:GetWordFromCfg(116361002)
				local var_13_7 = arg_10_1:FormatText(var_13_6.content)

				arg_10_1.text_.text = var_13_7

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_9 = 48 <= 0 and var_13_5 or var_13_5 * (utf8.len(var_13_7) / 48)

				if (48 <= 0 and var_13_5 or var_13_5 * (utf8.len(var_13_7) / 48)) > 0 and var_13_5 < var_13_9 then
					arg_10_1.talkMaxDuration = var_13_9

					if var_13_9 + var_13_4 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_9 + var_13_4
					end
				end

				arg_10_1.text_.text = var_13_7
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361002", "story_v_out_116361.awb") ~= 0 then
					local var_13_10 = manager.audio:GetVoiceLength("story_v_out_116361", "116361002", "story_v_out_116361.awb") / 1000

					if var_13_10 + var_13_4 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_10 + var_13_4
					end

					if var_13_6.prefab_name ~= "" and arg_10_1.actors_[var_13_6.prefab_name] ~= nil then
						local var_13_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_6.prefab_name].transform, "story_v_out_116361", "116361002", "story_v_out_116361.awb")

						arg_10_1:RecordAudio("116361002", var_13_11)
						arg_10_1:RecordAudio("116361002", var_13_11)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_116361", "116361002", "story_v_out_116361.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_116361", "116361002", "story_v_out_116361.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_12 = math.max(var_13_5, arg_10_1.talkMaxDuration)

			if var_13_4 <= arg_10_1.time_ and arg_10_1.time_ < var_13_4 + var_13_12 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_4) / var_13_12

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_4 + var_13_12 and arg_10_1.time_ < var_13_4 + var_13_12 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play116361003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116361003
		arg_14_1.duration_ = 10.7

		local var_14_0 = {
			zh = 7.1,
			ja = 10.7
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116361004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos10032ui_story = arg_14_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_17_0 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 then
				arg_14_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_14_1.time_ - 0) / var_17_0)
				arg_14_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_14_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_14_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_14_1.actors_["10032ui_story"].transform.position).z)
				arg_14_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_14_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_14_1.actors_["10032ui_story"].transform.localEulerAngles = arg_14_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 then
				arg_14_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_14_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_14_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_14_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_14_1.actors_["10032ui_story"].transform.position).z)
				arg_14_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_14_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_14_1.actors_["10032ui_story"].transform.localEulerAngles = arg_14_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_17_1 = 0
			local var_17_2 = 0.7

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_3 = arg_14_1:GetWordFromCfg(116361003)
				local var_17_4 = arg_14_1:FormatText(var_17_3.content)

				arg_14_1.text_.text = var_17_4

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_6 = 28 <= 0 and var_17_2 or var_17_2 * (utf8.len(var_17_4) / 28)

				if (28 <= 0 and var_17_2 or var_17_2 * (utf8.len(var_17_4) / 28)) > 0 and var_17_2 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_1 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_1
					end
				end

				arg_14_1.text_.text = var_17_4
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361003", "story_v_out_116361.awb") ~= 0 then
					local var_17_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361003", "story_v_out_116361.awb") / 1000

					if var_17_7 + var_17_1 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_1
					end

					if var_17_3.prefab_name ~= "" and arg_14_1.actors_[var_17_3.prefab_name] ~= nil then
						local var_17_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_3.prefab_name].transform, "story_v_out_116361", "116361003", "story_v_out_116361.awb")

						arg_14_1:RecordAudio("116361003", var_17_8)
						arg_14_1:RecordAudio("116361003", var_17_8)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_116361", "116361003", "story_v_out_116361.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_116361", "116361003", "story_v_out_116361.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_9 = math.max(var_17_2, arg_14_1.talkMaxDuration)

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_9 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_1) / var_17_9

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_1 + var_17_9 and arg_14_1.time_ < var_17_1 + var_17_9 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play116361004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116361004
		arg_18_1.duration_ = 6.63

		local var_18_0 = {
			zh = 3.733,
			ja = 6.633
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play116361005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos10032ui_story = arg_18_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_21_0 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 then
				arg_18_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_18_1.time_ - 0) / var_21_0)
				arg_18_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).z)
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles = arg_18_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 then
				arg_18_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_18_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_18_1.actors_["10032ui_story"].transform.position).z)
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_18_1.actors_["10032ui_story"].transform.localEulerAngles = arg_18_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action447")
			end

			local var_21_1 = 0
			local var_21_2 = 0.25

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_3 = arg_18_1:GetWordFromCfg(116361004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_6 = 10 <= 0 and var_21_2 or var_21_2 * (utf8.len(var_21_4) / 10)

				if (10 <= 0 and var_21_2 or var_21_2 * (utf8.len(var_21_4) / 10)) > 0 and var_21_2 < var_21_6 then
					arg_18_1.talkMaxDuration = var_21_6

					if var_21_6 + var_21_1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_1
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361004", "story_v_out_116361.awb") ~= 0 then
					local var_21_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361004", "story_v_out_116361.awb") / 1000

					if var_21_7 + var_21_1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_1
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_116361", "116361004", "story_v_out_116361.awb")

						arg_18_1:RecordAudio("116361004", var_21_8)
						arg_18_1:RecordAudio("116361004", var_21_8)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_116361", "116361004", "story_v_out_116361.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_116361", "116361004", "story_v_out_116361.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_9 = math.max(var_21_2, arg_18_1.talkMaxDuration)

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_9 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_1) / var_21_9

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_1 + var_21_9 and arg_18_1.time_ < var_21_1 + var_21_9 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play116361005 = function(arg_22_0, arg_22_1)
		arg_22_1.marker = "Mark2"
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116361005
		arg_22_1.duration_ = 12.69

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			arg_22_1.marker = ""

			if arg_24_0 == 1 then
				arg_22_0:Play116361006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if arg_22_1.bgs_.ST15 == nil then
				local var_25_0 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15")
				var_25_0.name = "ST15"
				var_25_0.transform.parent = arg_22_1.stage_.transform
				var_25_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_.ST15 = var_25_0
			end

			if 5.68666666666667 < arg_22_1.time_ and arg_22_1.time_ <= 5.68666666666667 + arg_25_0 then
				local var_25_1 = arg_22_1.bgs_.ST15

				arg_22_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_25_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_2 = var_25_1:GetComponent("SpriteRenderer")

				if var_25_2 and var_25_2.sprite then
					local var_25_3 = 2 * (var_25_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_25_1.transform.localScale = Vector3.New(var_25_3 / var_25_2.sprite.bounds.size.y < var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x and var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x or var_25_3 / var_25_2.sprite.bounds.size.y, var_25_3 / var_25_2.sprite.bounds.size.y < var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x and var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x or var_25_3 / var_25_2.sprite.bounds.size.y, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "ST15" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_4 = 5.68666666666667

			if 5.68666666666667 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_5 = 2

			if var_25_4 <= arg_22_1.time_ and arg_22_1.time_ < var_25_4 + var_25_5 then
				local var_25_6 = Color.New(0, 0, 0)

				var_25_6.a = Mathf.Lerp(1, 0, (arg_22_1.time_ - var_25_4) / var_25_5)
				arg_22_1.mask_.color = var_25_6
			end

			if arg_22_1.time_ >= var_25_4 + var_25_5 and arg_22_1.time_ < var_25_4 + var_25_5 + arg_25_0 then
				local var_25_7 = Color.New(0, 0, 0)

				arg_22_1.mask_.enabled = false
				var_25_7.a = 0
				arg_22_1.mask_.color = var_25_7
			end

			local var_25_8 = 2

			if 2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				SetActive(arg_22_1.dialog_, false)
				SetActive(arg_22_1.allBtn_.gameObject, false)
				arg_22_1.hideBtnsController_:SetSelectedIndex(1)

				arg_22_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/story_101161201.usm", function(arg_26_0)
					arg_22_1.time_ = var_25_8 + 3.66000000022352

					if arg_22_1.state_ == "pause" then
						arg_22_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_27_0)
					arg_22_1.state_ = arg_27_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_25_9 = 3.67

			if var_25_8 <= arg_22_1.time_ and arg_22_1.time_ < var_25_8 + var_25_9 then
				-- block empty
			end

			if arg_22_1.time_ >= var_25_8 + var_25_9 and arg_22_1.time_ < var_25_8 + var_25_9 + arg_25_0 then
				arg_22_1.marker = ""
			end

			local var_25_10 = 5.67

			if 5.67 < arg_22_1.time_ and arg_22_1.time_ <= var_25_10 + arg_25_0 then
				SetActive(arg_22_1.dialog_, false)
				SetActive(arg_22_1.allBtn_.gameObject, true)
				arg_22_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_22_1.isInLoopVideo = false
			end

			local var_25_11 = 0.0166666666666667

			if var_25_10 <= arg_22_1.time_ and arg_22_1.time_ < var_25_10 + var_25_11 then
				-- block empty
			end

			if arg_22_1.time_ >= var_25_10 + var_25_11 and arg_22_1.time_ < var_25_10 + var_25_11 + arg_25_0 then
				-- block empty
			end

			local var_25_12 = arg_22_1.actors_["10032ui_story"].transform

			if 1.966 < arg_22_1.time_ and arg_22_1.time_ <= 1.966 + arg_25_0 then
				arg_22_1.var_.moveOldPos10032ui_story = var_25_12.localPosition
			end

			local var_25_13 = 0.001

			if 1.966 <= arg_22_1.time_ and arg_22_1.time_ < 1.966 + var_25_13 then
				var_25_12.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10032ui_story, Vector3.New(0, 100, 0), (arg_22_1.time_ - 1.966) / var_25_13)
				var_25_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_12.position).x, (manager.ui.mainCamera.transform.position - var_25_12.position).y, (manager.ui.mainCamera.transform.position - var_25_12.position).z)
				var_25_12.localEulerAngles.z = 0
				var_25_12.localEulerAngles.x = 0
				var_25_12.localEulerAngles = var_25_12.localEulerAngles
			end

			if arg_22_1.time_ >= 1.966 + var_25_13 and arg_22_1.time_ < 1.966 + var_25_13 + arg_25_0 then
				var_25_12.localPosition = Vector3.New(0, 100, 0)
				var_25_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_12.position).x, (manager.ui.mainCamera.transform.position - var_25_12.position).y, (manager.ui.mainCamera.transform.position - var_25_12.position).z)
				var_25_12.localEulerAngles.z = 0
				var_25_12.localEulerAngles.x = 0
				var_25_12.localEulerAngles = var_25_12.localEulerAngles
			end

			if 2.034 < arg_22_1.time_ and arg_22_1.time_ <= 2.034 + arg_25_0 then
				arg_22_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_25_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_16 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_16

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_16
						arg_22_1.bgmTxt2_.text = var_25_16
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 7.68666666666667 < arg_22_1.time_ and arg_22_1.time_ <= 7.68666666666667 + arg_25_0 then
				arg_22_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_25_19 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_19 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_19

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_19
						arg_22_1.bgmTxt2_.text = var_25_19
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_25_20 = 0

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_20 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_21 = 2

			if var_25_20 <= arg_22_1.time_ and arg_22_1.time_ < var_25_20 + var_25_21 then
				local var_25_22 = Color.New(0, 0, 0)

				var_25_22.a = Mathf.Lerp(0, 1, (arg_22_1.time_ - var_25_20) / var_25_21)
				arg_22_1.mask_.color = var_25_22
			end

			if arg_22_1.time_ >= var_25_20 + var_25_21 and arg_22_1.time_ < var_25_20 + var_25_21 + arg_25_0 then
				local var_25_23 = Color.New(0, 0, 0)

				var_25_23.a = 1
				arg_22_1.mask_.color = var_25_23
			end

			local var_25_24 = 2

			if 2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_24 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_25 = 0.0166666666666667

			if var_25_24 <= arg_22_1.time_ and arg_22_1.time_ < var_25_24 + var_25_25 then
				local var_25_26 = Color.New(0, 0, 0)

				var_25_26.a = Mathf.Lerp(1, 0, (arg_22_1.time_ - var_25_24) / var_25_25)
				arg_22_1.mask_.color = var_25_26
			end

			if arg_22_1.time_ >= var_25_24 + var_25_25 and arg_22_1.time_ < var_25_24 + var_25_25 + arg_25_0 then
				local var_25_27 = Color.New(0, 0, 0)

				arg_22_1.mask_.enabled = false
				var_25_27.a = 0
				arg_22_1.mask_.color = var_25_27
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_28 = 7.68666666666667
			local var_25_29 = 0.5

			if 7.68666666666667 < arg_22_1.time_ and arg_22_1.time_ <= var_25_28 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_30 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_30:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_22_1.dialogCg_.alpha = arg_30_0
				end))
				var_25_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_31 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(116361005).content)

				arg_22_1.text_.text = var_25_31

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_33 = 20 <= 0 and var_25_29 or var_25_29 * (utf8.len(var_25_31) / 20)

				if (20 <= 0 and var_25_29 or var_25_29 * (utf8.len(var_25_31) / 20)) > 0 and var_25_29 < var_25_33 then
					arg_22_1.talkMaxDuration = var_25_33
					var_25_28 = var_25_28 + 0.3

					if var_25_33 + var_25_28 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_33 + var_25_28
					end
				end

				arg_22_1.text_.text = var_25_31
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_34 = var_25_28 + 0.3
			local var_25_35 = math.max(var_25_29, arg_22_1.talkMaxDuration)

			if var_25_28 + 0.3 <= arg_22_1.time_ and arg_22_1.time_ < var_25_34 + var_25_35 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_34) / var_25_35

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_34 + var_25_35 and arg_22_1.time_ < var_25_34 + var_25_35 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play116361006 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 116361006
		arg_32_1.duration_ = 6.03

		local var_32_0 = {
			zh = 4.933,
			ja = 6.033
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
				arg_32_0:Play116361007(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_35_0 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_32_1.stage_.transform)

				var_35_0.name = "10025ui_story"
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["10025ui_story"] = var_35_0

				local var_35_1 = var_35_0:GetComponentInChildren(typeof(CharacterEffect))

				var_35_1.enabled = true

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_1.transform, false)

				arg_32_1.var_["10025ui_story" .. "Animator"] = var_35_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_["10025ui_story" .. "Animator"].applyRootMotion = true
				arg_32_1.var_["10025ui_story" .. "LipSync"] = var_35_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_3 = arg_32_1.actors_["10025ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10025ui_story = var_35_3.localPosition
			end

			local var_35_4 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_32_1.time_ - 0) / var_35_4)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(0, -1.1, -5.9)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_35_5 = arg_32_1.actors_["10025ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect10025ui_story == nil then
				arg_32_1.var_.characterEffect10025ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect10025ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect10025ui_story then
				arg_32_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_35_8 = 0
			local var_35_9 = 0.35

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_10 = arg_32_1:GetWordFromCfg(116361006)
				local var_35_11 = arg_32_1:FormatText(var_35_10.content)

				arg_32_1.text_.text = var_35_11

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 14 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 14)

				if (14 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 14)) > 0 and var_35_9 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_11
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361006", "story_v_out_116361.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_116361", "116361006", "story_v_out_116361.awb") / 1000

					if var_35_14 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_8
					end

					if var_35_10.prefab_name ~= "" and arg_32_1.actors_[var_35_10.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_10.prefab_name].transform, "story_v_out_116361", "116361006", "story_v_out_116361.awb")

						arg_32_1:RecordAudio("116361006", var_35_15)
						arg_32_1:RecordAudio("116361006", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_116361", "116361006", "story_v_out_116361.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_116361", "116361006", "story_v_out_116361.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_16 and arg_32_1.time_ < var_35_8 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play116361007 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 116361007
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play116361008(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["10025ui_story"]) and arg_36_1.var_.characterEffect10025ui_story == nil then
				arg_36_1.var_.characterEffect10025ui_story = arg_36_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["10025ui_story"]) then
				if arg_36_1.var_.characterEffect10025ui_story and not isNil(arg_36_1.actors_["10025ui_story"]) then
					arg_36_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["10025ui_story"]) and arg_36_1.var_.characterEffect10025ui_story then
				arg_36_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 1.05

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(116361007).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 42 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 42)

				if (42 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 42)) > 0 and var_39_2 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_6 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_6 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_6

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_6 and arg_36_1.time_ < var_39_1 + var_39_6 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play116361008 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 116361008
		arg_40_1.duration_ = 3.4

		local var_40_0 = {
			zh = 3.4,
			ja = 3.2
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
				arg_40_0:Play116361009(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10025ui_story = arg_40_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_43_0 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				arg_40_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10025ui_story"].transform.position).z)
				arg_40_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["10025ui_story"].transform.localEulerAngles = arg_40_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				arg_40_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_40_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["10025ui_story"].transform.position).z)
				arg_40_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["10025ui_story"].transform.localEulerAngles = arg_40_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_2")
			end

			local var_43_1 = arg_40_1.actors_["10025ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect10025ui_story == nil then
				arg_40_1.var_.characterEffect10025ui_story = var_43_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_2 and not isNil(var_43_1) then
				if arg_40_1.var_.characterEffect10025ui_story and not isNil(var_43_1) then
					arg_40_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_2 and arg_40_1.time_ < 0 + var_43_2 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect10025ui_story then
				arg_40_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_43_4 = 0
			local var_43_5 = 0.225

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(116361008)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 9 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 9)

				if (9 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 9)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361008", "story_v_out_116361.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_116361", "116361008", "story_v_out_116361.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_116361", "116361008", "story_v_out_116361.awb")

						arg_40_1:RecordAudio("116361008", var_43_11)
						arg_40_1:RecordAudio("116361008", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_116361", "116361008", "story_v_out_116361.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_116361", "116361008", "story_v_out_116361.awb")
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

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play116361009 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 116361009
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play116361010(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["10025ui_story"]) and arg_44_1.var_.characterEffect10025ui_story == nil then
				arg_44_1.var_.characterEffect10025ui_story = arg_44_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["10025ui_story"]) then
				if arg_44_1.var_.characterEffect10025ui_story and not isNil(arg_44_1.actors_["10025ui_story"]) then
					arg_44_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["10025ui_story"]) and arg_44_1.var_.characterEffect10025ui_story then
				arg_44_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 1.475

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(116361009).content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 59 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 59)

				if (59 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 59)) > 0 and var_47_2 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_6 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_6 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_6

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_6 and arg_44_1.time_ < var_47_1 + var_47_6 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play116361010 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 116361010
		arg_48_1.duration_ = 7.6

		local var_48_0 = {
			zh = 6.966,
			ja = 7.6
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
				arg_48_0:Play116361011(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10025ui_story = arg_48_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10025ui_story"].transform.position).z)
				arg_48_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["10025ui_story"].transform.localEulerAngles = arg_48_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_48_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["10025ui_story"].transform.position).z)
				arg_48_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["10025ui_story"].transform.localEulerAngles = arg_48_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_51_1 = arg_48_1.actors_["10025ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect10025ui_story == nil then
				arg_48_1.var_.characterEffect10025ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect10025ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect10025ui_story then
				arg_48_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_51_4 = 0
			local var_51_5 = 0.575

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(116361010)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 23 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 23)

				if (23 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 23)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361010", "story_v_out_116361.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_116361", "116361010", "story_v_out_116361.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_116361", "116361010", "story_v_out_116361.awb")

						arg_48_1:RecordAudio("116361010", var_51_11)
						arg_48_1:RecordAudio("116361010", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_116361", "116361010", "story_v_out_116361.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_116361", "116361010", "story_v_out_116361.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play116361011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 116361011
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play116361012(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10025ui_story"]) and arg_52_1.var_.characterEffect10025ui_story == nil then
				arg_52_1.var_.characterEffect10025ui_story = arg_52_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10025ui_story"]) then
				if arg_52_1.var_.characterEffect10025ui_story and not isNil(arg_52_1.actors_["10025ui_story"]) then
					arg_52_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10025ui_story"]) and arg_52_1.var_.characterEffect10025ui_story then
				arg_52_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.525

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(116361011).content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 21 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 21)

				if (21 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 21)) > 0 and var_55_2 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_6 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_6 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_6

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_6 and arg_52_1.time_ < var_55_1 + var_55_6 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play116361012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 116361012
		arg_56_1.duration_ = 2.7

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play116361013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10025ui_story = arg_56_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10025ui_story"].transform.position).z)
				arg_56_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10025ui_story"].transform.localEulerAngles = arg_56_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_56_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10025ui_story"].transform.position).z)
				arg_56_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10025ui_story"].transform.localEulerAngles = arg_56_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_59_1 = arg_56_1.actors_["10025ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect10025ui_story == nil then
				arg_56_1.var_.characterEffect10025ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 and not isNil(var_59_1) then
				if arg_56_1.var_.characterEffect10025ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect10025ui_story then
				arg_56_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_59_4 = 0
			local var_59_5 = 0.075

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(116361012)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 3 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 3)

				if (3 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 3)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361012", "story_v_out_116361.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_116361", "116361012", "story_v_out_116361.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_116361", "116361012", "story_v_out_116361.awb")

						arg_56_1:RecordAudio("116361012", var_59_11)
						arg_56_1:RecordAudio("116361012", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_116361", "116361012", "story_v_out_116361.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_116361", "116361012", "story_v_out_116361.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play116361013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 116361013
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play116361014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["10025ui_story"]) and arg_60_1.var_.characterEffect10025ui_story == nil then
				arg_60_1.var_.characterEffect10025ui_story = arg_60_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["10025ui_story"]) then
				if arg_60_1.var_.characterEffect10025ui_story and not isNil(arg_60_1.actors_["10025ui_story"]) then
					arg_60_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["10025ui_story"]) and arg_60_1.var_.characterEffect10025ui_story then
				arg_60_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 0.725

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(116361013).content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 29 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 29)

				if (29 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 29)) > 0 and var_63_2 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_6 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_6 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_6

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_6 and arg_60_1.time_ < var_63_1 + var_63_6 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play116361014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 116361014
		arg_64_1.duration_ = 8.33

		local var_64_0 = {
			zh = 7.633,
			ja = 8.333
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play116361015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10025ui_story = arg_64_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10025ui_story"].transform.position).z)
				arg_64_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["10025ui_story"].transform.localEulerAngles = arg_64_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_64_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10025ui_story"].transform.position).z)
				arg_64_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["10025ui_story"].transform.localEulerAngles = arg_64_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_67_1 = arg_64_1.actors_["10025ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect10025ui_story == nil then
				arg_64_1.var_.characterEffect10025ui_story = var_67_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 and not isNil(var_67_1) then
				if arg_64_1.var_.characterEffect10025ui_story and not isNil(var_67_1) then
					arg_64_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect10025ui_story then
				arg_64_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_1")
			end

			local var_67_4 = 0
			local var_67_5 = 0.675

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(116361014)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 27 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 27)

				if (27 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 27)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361014", "story_v_out_116361.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_116361", "116361014", "story_v_out_116361.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_116361", "116361014", "story_v_out_116361.awb")

						arg_64_1:RecordAudio("116361014", var_67_11)
						arg_64_1:RecordAudio("116361014", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_116361", "116361014", "story_v_out_116361.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_116361", "116361014", "story_v_out_116361.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play116361015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 116361015
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play116361016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos10025ui_story = arg_68_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10025ui_story"].transform.position).z)
				arg_68_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["10025ui_story"].transform.localEulerAngles = arg_68_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["10025ui_story"].transform.position).z)
				arg_68_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["10025ui_story"].transform.localEulerAngles = arg_68_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_71_1 = 0
			local var_71_2 = 0.225

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(116361015).content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 9 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 9)

				if (9 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 9)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_6 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_6 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_6

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_6 and arg_68_1.time_ < var_71_1 + var_71_6 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play116361016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 116361016
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play116361017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.9

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

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(116361016).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 36 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 36)

				if (36 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 36)) > 0 and var_75_0 < var_75_3 then
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
	Play116361017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 116361017
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play116361018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.975

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(116361017).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 39 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 39)

				if (39 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 39)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play116361018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 116361018
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play116361019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.625

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(116361018).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 25 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 25)

				if (25 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 25)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play116361019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 116361019
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play116361020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.725

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(116361019).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 29 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 29)

				if (29 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 29)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play116361020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 116361020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play116361021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.575

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(116361020).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 23 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 23)

				if (23 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 23)) > 0 and var_91_0 < var_91_3 then
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
	Play116361021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 116361021
		arg_92_1.duration_ = 7

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play116361022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_0 = 2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				local var_95_1 = Color.New(1, 1, 1)

				var_95_1.a = Mathf.Lerp(1, 0, (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.mask_.color = var_95_1
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				local var_95_2 = Color.New(1, 1, 1)

				arg_92_1.mask_.enabled = false
				var_95_2.a = 0
				arg_92_1.mask_.color = var_95_2
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_16", "se_story_16_camera", "")
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_4 = 2
			local var_95_5 = 0.1

			if 2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_6 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_6:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_7 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(116361021).content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 4 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 4)

				if (4 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 4)) > 0 and var_95_5 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9
					var_95_4 = var_95_4 + 0.3

					if var_95_9 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = var_95_4 + 0.3
			local var_95_11 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 + 0.3 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_11 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_10) / var_95_11

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_10 + var_95_11 and arg_92_1.time_ < var_95_10 + var_95_11 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play116361022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 116361022
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play116361023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.15

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(116361022).content)

				arg_98_1.text_.text = var_101_1

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_3 = 6 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 6)

				if (6 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 6)) > 0 and var_101_0 < var_101_3 then
					arg_98_1.talkMaxDuration = var_101_3

					if var_101_3 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_3 + 0
					end
				end

				arg_98_1.text_.text = var_101_1
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_4 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_4

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play116361023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 116361023
		arg_102_1.duration_ = 5.57

		local var_102_0 = {
			zh = 5.566,
			ja = 4.133
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play116361024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos10025ui_story = arg_102_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).z)
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles = arg_102_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_102_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).z)
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles = arg_102_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_105_1 = arg_102_1.actors_["10025ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect10025ui_story == nil then
				arg_102_1.var_.characterEffect10025ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect10025ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect10025ui_story then
				arg_102_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_105_4 = 0
			local var_105_5 = 0.55

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(116361023)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 22 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 22)

				if (22 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 22)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361023", "story_v_out_116361.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_116361", "116361023", "story_v_out_116361.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_116361", "116361023", "story_v_out_116361.awb")

						arg_102_1:RecordAudio("116361023", var_105_11)
						arg_102_1:RecordAudio("116361023", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_116361", "116361023", "story_v_out_116361.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_116361", "116361023", "story_v_out_116361.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play116361024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 116361024
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play116361025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["10025ui_story"]) and arg_106_1.var_.characterEffect10025ui_story == nil then
				arg_106_1.var_.characterEffect10025ui_story = arg_106_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["10025ui_story"]) then
				if arg_106_1.var_.characterEffect10025ui_story and not isNil(arg_106_1.actors_["10025ui_story"]) then
					arg_106_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["10025ui_story"]) and arg_106_1.var_.characterEffect10025ui_story then
				arg_106_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_109_1 = 0
			local var_109_2 = 0.375

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(116361024).content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 15 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 15)

				if (15 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 15)) > 0 and var_109_2 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_6 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_6 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_6

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_6 and arg_106_1.time_ < var_109_1 + var_109_6 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play116361025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 116361025
		arg_110_1.duration_ = 5

		local var_110_0 = {
			zh = 2.2,
			ja = 5
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play116361026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10025ui_story = arg_110_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10025ui_story"].transform.position).z)
				arg_110_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["10025ui_story"].transform.localEulerAngles = arg_110_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_110_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10025ui_story"].transform.position).z)
				arg_110_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["10025ui_story"].transform.localEulerAngles = arg_110_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_113_1 = arg_110_1.actors_["10025ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect10025ui_story == nil then
				arg_110_1.var_.characterEffect10025ui_story = var_113_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_2 and not isNil(var_113_1) then
				if arg_110_1.var_.characterEffect10025ui_story and not isNil(var_113_1) then
					arg_110_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_2 and arg_110_1.time_ < 0 + var_113_2 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect10025ui_story then
				arg_110_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_113_4 = 0
			local var_113_5 = 0.225

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(116361025)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 9 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 9)

				if (9 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 9)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361025", "story_v_out_116361.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_116361", "116361025", "story_v_out_116361.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_116361", "116361025", "story_v_out_116361.awb")

						arg_110_1:RecordAudio("116361025", var_113_11)
						arg_110_1:RecordAudio("116361025", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_116361", "116361025", "story_v_out_116361.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_116361", "116361025", "story_v_out_116361.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play116361026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 116361026
		arg_114_1.duration_ = 7

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play116361027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if arg_114_1.bgs_.STblack == nil then
				local var_117_0 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_117_0.name = "STblack"
				var_117_0.transform.parent = arg_114_1.stage_.transform
				var_117_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_.STblack = var_117_0
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				local var_117_1 = arg_114_1.bgs_.STblack

				arg_114_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_117_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_2 = var_117_1:GetComponent("SpriteRenderer")

				if var_117_2 and var_117_2.sprite then
					local var_117_3 = 2 * (var_117_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_117_1.transform.localScale = Vector3.New(var_117_3 / var_117_2.sprite.bounds.size.y < var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x and var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x or var_117_3 / var_117_2.sprite.bounds.size.y, var_117_3 / var_117_2.sprite.bounds.size.y < var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x and var_117_3 * manager.ui.mainCameraCom_.aspect / var_117_2.sprite.bounds.size.x or var_117_3 / var_117_2.sprite.bounds.size.y, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "STblack" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_4 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_5 = 2

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_5 then
				local var_117_6 = Color.New(0, 0, 0)

				var_117_6.a = Mathf.Lerp(1, 0, (arg_114_1.time_ - var_117_4) / var_117_5)
				arg_114_1.mask_.color = var_117_6
			end

			if arg_114_1.time_ >= var_117_4 + var_117_5 and arg_114_1.time_ < var_117_4 + var_117_5 + arg_117_0 then
				local var_117_7 = Color.New(0, 0, 0)

				arg_114_1.mask_.enabled = false
				var_117_7.a = 0
				arg_114_1.mask_.color = var_117_7
			end

			local var_117_8 = arg_114_1.actors_["10025ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos10025ui_story = var_117_8.localPosition
			end

			local var_117_9 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_9 then
				var_117_8.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_9)
				var_117_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_8.position).x, (manager.ui.mainCamera.transform.position - var_117_8.position).y, (manager.ui.mainCamera.transform.position - var_117_8.position).z)
				var_117_8.localEulerAngles.z = 0
				var_117_8.localEulerAngles.x = 0
				var_117_8.localEulerAngles = var_117_8.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_9 and arg_114_1.time_ < 0 + var_117_9 + arg_117_0 then
				var_117_8.localPosition = Vector3.New(0, 100, 0)
				var_117_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_8.position).x, (manager.ui.mainCamera.transform.position - var_117_8.position).y, (manager.ui.mainCamera.transform.position - var_117_8.position).z)
				var_117_8.localEulerAngles.z = 0
				var_117_8.localEulerAngles.x = 0
				var_117_8.localEulerAngles = var_117_8.localEulerAngles
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_117_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_12 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_12

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_12
						arg_114_1.bgmTxt2_.text = var_117_12
					end

					if arg_114_1.bgmTimer then
						arg_114_1.bgmTimer:Stop()

						arg_114_1.bgmTimer = nil
					end

					if arg_114_1.settingData.show_music_name == 1 then
						arg_114_1.musicController:SetSelectedState("show")
						arg_114_1.musicAnimator_:Play("open", 0, 0)

						if arg_114_1.settingData.music_time ~= 0 then
							arg_114_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_114_1.settingData.music_time), function()
								if arg_114_1 == nil or isNil(arg_114_1.bgmTxt_) then
									return
								end

								arg_114_1.musicController:SetSelectedState("hide")
								arg_114_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.034 < arg_114_1.time_ and arg_114_1.time_ <= 0.034 + arg_117_0 then
				arg_114_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_117_15 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_15 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_15

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_15
						arg_114_1.bgmTxt2_.text = var_117_15
					end

					if arg_114_1.bgmTimer then
						arg_114_1.bgmTimer:Stop()

						arg_114_1.bgmTimer = nil
					end

					if arg_114_1.settingData.show_music_name == 1 then
						arg_114_1.musicController:SetSelectedState("show")
						arg_114_1.musicAnimator_:Play("open", 0, 0)

						if arg_114_1.settingData.music_time ~= 0 then
							arg_114_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_114_1.settingData.music_time), function()
								if arg_114_1 == nil or isNil(arg_114_1.bgmTxt_) then
									return
								end

								arg_114_1.musicController:SetSelectedState("hide")
								arg_114_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_16 = 2
			local var_117_17 = 0.175

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_18 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_18:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_114_1.dialogCg_.alpha = arg_120_0
				end))
				var_117_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_19 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(116361026).content)

				arg_114_1.text_.text = var_117_19

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_21 = 7 <= 0 and var_117_17 or var_117_17 * (utf8.len(var_117_19) / 7)

				if (7 <= 0 and var_117_17 or var_117_17 * (utf8.len(var_117_19) / 7)) > 0 and var_117_17 < var_117_21 then
					arg_114_1.talkMaxDuration = var_117_21
					var_117_16 = var_117_16 + 0.3

					if var_117_21 + var_117_16 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_21 + var_117_16
					end
				end

				arg_114_1.text_.text = var_117_19
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = var_117_16 + 0.3
			local var_117_23 = math.max(var_117_17, arg_114_1.talkMaxDuration)

			if var_117_16 + 0.3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_22 + var_117_23 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_22) / var_117_23

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_22 + var_117_23 and arg_114_1.time_ < var_117_22 + var_117_23 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play116361027 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116361027
		arg_122_1.duration_ = 7

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play116361028(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				local var_125_0 = arg_122_1.bgs_.I07a

				arg_122_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_125_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_125_1 = var_125_0:GetComponent("SpriteRenderer")

				if var_125_1 and var_125_1.sprite then
					local var_125_2 = 2 * (var_125_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_125_0.transform.localScale = Vector3.New(var_125_2 / var_125_1.sprite.bounds.size.y < var_125_2 * manager.ui.mainCameraCom_.aspect / var_125_1.sprite.bounds.size.x and var_125_2 * manager.ui.mainCameraCom_.aspect / var_125_1.sprite.bounds.size.x or var_125_2 / var_125_1.sprite.bounds.size.y, var_125_2 / var_125_1.sprite.bounds.size.y < var_125_2 * manager.ui.mainCameraCom_.aspect / var_125_1.sprite.bounds.size.x and var_125_2 * manager.ui.mainCameraCom_.aspect / var_125_1.sprite.bounds.size.x or var_125_2 / var_125_1.sprite.bounds.size.y, 0)
				end

				for iter_125_0, iter_125_1 in pairs(arg_122_1.bgs_) do
					if iter_125_0 ~= "I07a" then
						iter_125_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_125_3 = 0

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_3 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_4 = 2

			if var_125_3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_3 + var_125_4 then
				local var_125_5 = Color.New(0, 0, 0)

				var_125_5.a = Mathf.Lerp(1, 0, (arg_122_1.time_ - var_125_3) / var_125_4)
				arg_122_1.mask_.color = var_125_5
			end

			if arg_122_1.time_ >= var_125_3 + var_125_4 and arg_122_1.time_ < var_125_3 + var_125_4 + arg_125_0 then
				local var_125_6 = Color.New(0, 0, 0)

				arg_122_1.mask_.enabled = false
				var_125_6.a = 0
				arg_122_1.mask_.color = var_125_6
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_7 = 2
			local var_125_8 = 1.35

			if 2 < arg_122_1.time_ and arg_122_1.time_ <= var_125_7 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_9 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_9:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_10 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(116361027).content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_12 = 54 <= 0 and var_125_8 or var_125_8 * (utf8.len(var_125_10) / 54)

				if (54 <= 0 and var_125_8 or var_125_8 * (utf8.len(var_125_10) / 54)) > 0 and var_125_8 < var_125_12 then
					arg_122_1.talkMaxDuration = var_125_12
					var_125_7 = var_125_7 + 0.3

					if var_125_12 + var_125_7 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_12 + var_125_7
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_13 = var_125_7 + 0.3
			local var_125_14 = math.max(var_125_8, arg_122_1.talkMaxDuration)

			if var_125_7 + 0.3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_13 + var_125_14 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_13) / var_125_14

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_13 + var_125_14 and arg_122_1.time_ < var_125_13 + var_125_14 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play116361028 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 116361028
		arg_128_1.duration_ = 8.03

		local var_128_0 = {
			zh = 8.033,
			ja = 5.433
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
				arg_128_0:Play116361029(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10032ui_story = arg_128_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10032ui_story"].transform.position).z)
				arg_128_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["10032ui_story"].transform.localEulerAngles = arg_128_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_128_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10032ui_story"].transform.position).z)
				arg_128_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["10032ui_story"].transform.localEulerAngles = arg_128_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_131_1 = arg_128_1.actors_["10032ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect10032ui_story == nil then
				arg_128_1.var_.characterEffect10032ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect10032ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect10032ui_story then
				arg_128_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_131_4 = 0
			local var_131_5 = 0.625

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(116361028)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 25 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 25)

				if (25 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 25)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361028", "story_v_out_116361.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_116361", "116361028", "story_v_out_116361.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_116361", "116361028", "story_v_out_116361.awb")

						arg_128_1:RecordAudio("116361028", var_131_11)
						arg_128_1:RecordAudio("116361028", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_116361", "116361028", "story_v_out_116361.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_116361", "116361028", "story_v_out_116361.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play116361029 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 116361029
		arg_132_1.duration_ = 11

		local var_132_0 = {
			zh = 11,
			ja = 8.2
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
				arg_132_0:Play116361030(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10032ui_story = arg_132_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10032ui_story"].transform.position).z)
				arg_132_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["10032ui_story"].transform.localEulerAngles = arg_132_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_132_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["10032ui_story"].transform.position).z)
				arg_132_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["10032ui_story"].transform.localEulerAngles = arg_132_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_135_1 = 0
			local var_135_2 = 1

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(116361029)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 40 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 40)

				if (40 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 40)) > 0 and var_135_2 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361029", "story_v_out_116361.awb") ~= 0 then
					local var_135_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361029", "story_v_out_116361.awb") / 1000

					if var_135_7 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_1
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_116361", "116361029", "story_v_out_116361.awb")

						arg_132_1:RecordAudio("116361029", var_135_8)
						arg_132_1:RecordAudio("116361029", var_135_8)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_116361", "116361029", "story_v_out_116361.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_116361", "116361029", "story_v_out_116361.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_9 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_9 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_9

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_9 and arg_132_1.time_ < var_135_1 + var_135_9 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play116361030 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 116361030
		arg_136_1.duration_ = 11.17

		local var_136_0 = {
			zh = 8.633,
			ja = 11.166
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
				arg_136_0:Play116361031(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos10032ui_story = arg_136_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10032ui_story"].transform.position).z)
				arg_136_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["10032ui_story"].transform.localEulerAngles = arg_136_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_136_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10032ui_story"].transform.position).z)
				arg_136_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["10032ui_story"].transform.localEulerAngles = arg_136_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_139_1 = arg_136_1.actors_["10032ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect10032ui_story == nil then
				arg_136_1.var_.characterEffect10032ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect10032ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect10032ui_story then
				arg_136_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action442")
			end

			local var_139_4 = 0
			local var_139_5 = 0.725

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(116361030)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 29 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 29)

				if (29 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 29)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361030", "story_v_out_116361.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_116361", "116361030", "story_v_out_116361.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_116361", "116361030", "story_v_out_116361.awb")

						arg_136_1:RecordAudio("116361030", var_139_11)
						arg_136_1:RecordAudio("116361030", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_116361", "116361030", "story_v_out_116361.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_116361", "116361030", "story_v_out_116361.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play116361031 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 116361031
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play116361032(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos10032ui_story = arg_140_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10032ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["10032ui_story"].transform.position).z)
				arg_140_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["10032ui_story"].transform.localEulerAngles = arg_140_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["10032ui_story"].transform.position).z)
				arg_140_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["10032ui_story"].transform.localEulerAngles = arg_140_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			local var_143_1 = 0
			local var_143_2 = 0.725

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(116361031).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 29 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 29)

				if (29 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 29)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play116361032 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 116361032
		arg_144_1.duration_ = 5.8

		local var_144_0 = {
			zh = 4.2,
			ja = 5.8
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
				arg_144_0:Play116361033(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.375

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:GetWordFromCfg(116361032)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 15 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 15)

				if (15 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 15)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361032", "story_v_out_116361.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_116361", "116361032", "story_v_out_116361.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_116361", "116361032", "story_v_out_116361.awb")

						arg_144_1:RecordAudio("116361032", var_147_6)
						arg_144_1:RecordAudio("116361032", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_116361", "116361032", "story_v_out_116361.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_116361", "116361032", "story_v_out_116361.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play116361033 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 116361033
		arg_148_1.duration_ = 26.7

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play116361034(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if arg_148_1.bgs_.ST03_blur == nil then
				local var_151_0 = Object.Instantiate(arg_148_1.paintGo_)

				var_151_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03_blur")
				var_151_0.name = "ST03_blur"
				var_151_0.transform.parent = arg_148_1.stage_.transform
				var_151_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_.ST03_blur = var_151_0
			end

			if 5.7 < arg_148_1.time_ and arg_148_1.time_ <= 5.7 + arg_151_0 then
				local var_151_1 = arg_148_1.bgs_.ST03_blur

				arg_148_1.bgs_.ST03_blur.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_151_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_2 = var_151_1:GetComponent("SpriteRenderer")

				if var_151_2 and var_151_2.sprite then
					local var_151_3 = 2 * (var_151_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_151_1.transform.localScale = Vector3.New(var_151_3 / var_151_2.sprite.bounds.size.y < var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x and var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x or var_151_3 / var_151_2.sprite.bounds.size.y, var_151_3 / var_151_2.sprite.bounds.size.y < var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x and var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x or var_151_3 / var_151_2.sprite.bounds.size.y, 0)
				end

				for iter_151_0, iter_151_1 in pairs(arg_148_1.bgs_) do
					if iter_151_0 ~= "ST03_blur" then
						iter_151_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_4 = "I05"

			if arg_148_1.bgs_.I05 == nil then
				local var_151_5 = Object.Instantiate(arg_148_1.paintGo_)

				var_151_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_4)
				var_151_5.name = var_151_4
				var_151_5.transform.parent = arg_148_1.stage_.transform
				var_151_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_4] = var_151_5
			end

			if 12.6866666666667 < arg_148_1.time_ and arg_148_1.time_ <= 12.6866666666667 + arg_151_0 then
				local var_151_6 = arg_148_1.bgs_.I05

				arg_148_1.bgs_.I05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_151_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_7 = var_151_6:GetComponent("SpriteRenderer")

				if var_151_7 and var_151_7.sprite then
					local var_151_8 = 2 * (var_151_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_151_6.transform.localScale = Vector3.New(var_151_8 / var_151_7.sprite.bounds.size.y < var_151_8 * manager.ui.mainCameraCom_.aspect / var_151_7.sprite.bounds.size.x and var_151_8 * manager.ui.mainCameraCom_.aspect / var_151_7.sprite.bounds.size.x or var_151_8 / var_151_7.sprite.bounds.size.y, var_151_8 / var_151_7.sprite.bounds.size.y < var_151_8 * manager.ui.mainCameraCom_.aspect / var_151_7.sprite.bounds.size.x and var_151_8 * manager.ui.mainCameraCom_.aspect / var_151_7.sprite.bounds.size.x or var_151_8 / var_151_7.sprite.bounds.size.y, 0)
				end

				for iter_151_2, iter_151_3 in pairs(arg_148_1.bgs_) do
					if iter_151_2 ~= "I05" then
						iter_151_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 19.7 < arg_148_1.time_ and arg_148_1.time_ <= 19.7 + arg_151_0 then
				local var_151_9 = arg_148_1.bgs_.ST15

				arg_148_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_151_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_10 = var_151_9:GetComponent("SpriteRenderer")

				if var_151_10 and var_151_10.sprite then
					local var_151_11 = 2 * (var_151_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_151_9.transform.localScale = Vector3.New(var_151_11 / var_151_10.sprite.bounds.size.y < var_151_11 * manager.ui.mainCameraCom_.aspect / var_151_10.sprite.bounds.size.x and var_151_11 * manager.ui.mainCameraCom_.aspect / var_151_10.sprite.bounds.size.x or var_151_11 / var_151_10.sprite.bounds.size.y, var_151_11 / var_151_10.sprite.bounds.size.y < var_151_11 * manager.ui.mainCameraCom_.aspect / var_151_10.sprite.bounds.size.x and var_151_11 * manager.ui.mainCameraCom_.aspect / var_151_10.sprite.bounds.size.x or var_151_11 / var_151_10.sprite.bounds.size.y, 0)
				end

				for iter_151_4, iter_151_5 in pairs(arg_148_1.bgs_) do
					if iter_151_4 ~= "ST15" then
						iter_151_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_12 = 0

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_13 = 2

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_13 then
				local var_151_14 = Color.New(0, 0, 0)

				var_151_14.a = Mathf.Lerp(0, 1, (arg_148_1.time_ - var_151_12) / var_151_13)
				arg_148_1.mask_.color = var_151_14
			end

			if arg_148_1.time_ >= var_151_12 + var_151_13 and arg_148_1.time_ < var_151_12 + var_151_13 + arg_151_0 then
				local var_151_15 = Color.New(0, 0, 0)

				var_151_15.a = 1
				arg_148_1.mask_.color = var_151_15
			end

			local var_151_16 = 2

			if 2 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_17 = 0.0166666666666667

			if var_151_16 <= arg_148_1.time_ and arg_148_1.time_ < var_151_16 + var_151_17 then
				local var_151_18 = Color.New(0, 0, 0)

				var_151_18.a = Mathf.Lerp(1, 0, (arg_148_1.time_ - var_151_16) / var_151_17)
				arg_148_1.mask_.color = var_151_18
			end

			if arg_148_1.time_ >= var_151_16 + var_151_17 and arg_148_1.time_ < var_151_16 + var_151_17 + arg_151_0 then
				local var_151_19 = Color.New(0, 0, 0)

				arg_148_1.mask_.enabled = false
				var_151_19.a = 0
				arg_148_1.mask_.color = var_151_19
			end

			if 2 < arg_148_1.time_ and arg_148_1.time_ <= 2 + arg_151_0 then
				arg_148_1:AudioAction("play", "effect", "se_story_16", "se_story_16_whoosh", "")
			end

			local var_151_21 = 2

			if 2 < arg_148_1.time_ and arg_148_1.time_ <= var_151_21 + arg_151_0 then
				SetActive(arg_148_1.dialog_, false)
				SetActive(arg_148_1.allBtn_.gameObject, false)
				arg_148_1.hideBtnsController_:SetSelectedIndex(1)
				manager.video:Play("SofdecAsset/story/story_101161201.usm", function(arg_152_0)
					arg_148_1.time_ = var_151_21 + 3.66000000022352

					if arg_148_1.state_ == "pause" then
						arg_148_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_153_0)
					arg_148_1.state_ = arg_153_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_151_22 = 3.67

			if var_151_21 <= arg_148_1.time_ and arg_148_1.time_ < var_151_21 + var_151_22 then
				-- block empty
			end

			if arg_148_1.time_ >= var_151_21 + var_151_22 and arg_148_1.time_ < var_151_21 + var_151_22 + arg_151_0 then
				-- block empty
			end

			local var_151_23 = 5.67

			if 5.67 < arg_148_1.time_ and arg_148_1.time_ <= var_151_23 + arg_151_0 then
				SetActive(arg_148_1.dialog_, true)
				SetActive(arg_148_1.allBtn_.gameObject, true)
				arg_148_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_148_1.isInLoopVideo = false
			end

			local var_151_24 = 0.0300000000000002

			if var_151_23 <= arg_148_1.time_ and arg_148_1.time_ < var_151_23 + var_151_24 then
				-- block empty
			end

			if arg_148_1.time_ >= var_151_23 + var_151_24 and arg_148_1.time_ < var_151_23 + var_151_24 + arg_151_0 then
				-- block empty
			end

			local var_151_25 = "ST03_blur"

			if arg_148_1.bgs_.ST03_blur == nil then
				local var_151_26 = Object.Instantiate(arg_148_1.blurPaintGo_)

				var_151_26:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_25)
				var_151_26.name = var_151_25
				var_151_26.transform.parent = arg_148_1.stage_.transform
				var_151_26.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_25] = var_151_26
			end

			local var_151_27 = 5.7
			local var_151_28 = arg_148_1.bgs_[var_151_25]

			if 5.7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_27 + arg_151_0 then
				var_151_28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_151_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_29 = var_151_28:GetComponent("SpriteRenderer")

				if var_151_29 and var_151_29.sprite then
					local var_151_30 = 2 * (var_151_28.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_151_28.transform.localScale = Vector3.New(var_151_30 / var_151_29.sprite.bounds.size.y < var_151_30 * manager.ui.mainCameraCom_.aspect / var_151_29.sprite.bounds.size.x and var_151_30 * manager.ui.mainCameraCom_.aspect / var_151_29.sprite.bounds.size.x or var_151_30 / var_151_29.sprite.bounds.size.y, var_151_30 / var_151_29.sprite.bounds.size.y < var_151_30 * manager.ui.mainCameraCom_.aspect / var_151_29.sprite.bounds.size.x and var_151_30 * manager.ui.mainCameraCom_.aspect / var_151_29.sprite.bounds.size.x or var_151_30 / var_151_29.sprite.bounds.size.y, 0)
				end
			end

			local var_151_31 = 7

			if var_151_27 <= arg_148_1.time_ and arg_148_1.time_ < var_151_27 + var_151_31 then
				local var_151_32 = Color.New(1, 1, 1)

				var_151_32.a = Mathf.Lerp(0, 1, (arg_148_1.time_ - var_151_27) / var_151_31)

				var_151_28:GetComponent("SpriteRenderer").material:SetColor("_Color", var_151_32)
			end

			local var_151_33 = "I05_blur"

			if arg_148_1.bgs_.I05_blur == nil then
				local var_151_34 = Object.Instantiate(arg_148_1.blurPaintGo_)

				var_151_34:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_33)
				var_151_34.name = var_151_33
				var_151_34.transform.parent = arg_148_1.stage_.transform
				var_151_34.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_33] = var_151_34
			end

			local var_151_35 = 12.7
			local var_151_36 = arg_148_1.bgs_[var_151_33]

			if 12.7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_35 + arg_151_0 then
				var_151_36.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_151_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_37 = var_151_36:GetComponent("SpriteRenderer")

				if var_151_37 and var_151_37.sprite then
					local var_151_38 = 2 * (var_151_36.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_151_36.transform.localScale = Vector3.New(var_151_38 / var_151_37.sprite.bounds.size.y < var_151_38 * manager.ui.mainCameraCom_.aspect / var_151_37.sprite.bounds.size.x and var_151_38 * manager.ui.mainCameraCom_.aspect / var_151_37.sprite.bounds.size.x or var_151_38 / var_151_37.sprite.bounds.size.y, var_151_38 / var_151_37.sprite.bounds.size.y < var_151_38 * manager.ui.mainCameraCom_.aspect / var_151_37.sprite.bounds.size.x and var_151_38 * manager.ui.mainCameraCom_.aspect / var_151_37.sprite.bounds.size.x or var_151_38 / var_151_37.sprite.bounds.size.y, 0)
				end
			end

			local var_151_39 = 7

			if var_151_35 <= arg_148_1.time_ and arg_148_1.time_ < var_151_35 + var_151_39 then
				local var_151_40 = Color.New(1, 1, 1)

				var_151_40.a = Mathf.Lerp(0, 1, (arg_148_1.time_ - var_151_35) / var_151_39)

				var_151_36:GetComponent("SpriteRenderer").material:SetColor("_Color", var_151_40)
			end

			local var_151_41 = "ST15_blur"

			if arg_148_1.bgs_.ST15_blur == nil then
				local var_151_42 = Object.Instantiate(arg_148_1.blurPaintGo_)

				var_151_42:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_151_41)
				var_151_42.name = var_151_41
				var_151_42.transform.parent = arg_148_1.stage_.transform
				var_151_42.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_[var_151_41] = var_151_42
			end

			local var_151_43 = 19.7
			local var_151_44 = arg_148_1.bgs_[var_151_41]

			if 19.7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_43 + arg_151_0 then
				var_151_44.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_151_44.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_45 = var_151_44:GetComponent("SpriteRenderer")

				if var_151_45 and var_151_45.sprite then
					local var_151_46 = 2 * (var_151_44.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_151_44.transform.localScale = Vector3.New(var_151_46 / var_151_45.sprite.bounds.size.y < var_151_46 * manager.ui.mainCameraCom_.aspect / var_151_45.sprite.bounds.size.x and var_151_46 * manager.ui.mainCameraCom_.aspect / var_151_45.sprite.bounds.size.x or var_151_46 / var_151_45.sprite.bounds.size.y, var_151_46 / var_151_45.sprite.bounds.size.y < var_151_46 * manager.ui.mainCameraCom_.aspect / var_151_45.sprite.bounds.size.x and var_151_46 * manager.ui.mainCameraCom_.aspect / var_151_45.sprite.bounds.size.x or var_151_46 / var_151_45.sprite.bounds.size.y, 0)
				end
			end

			local var_151_47 = 7

			if var_151_43 <= arg_148_1.time_ and arg_148_1.time_ < var_151_43 + var_151_47 then
				local var_151_48 = Color.New(1, 1, 1)

				var_151_48.a = Mathf.Lerp(0, 1, (arg_148_1.time_ - var_151_43) / var_151_47)

				var_151_44:GetComponent("SpriteRenderer").material:SetColor("_Color", var_151_48)
			end

			local var_151_49 = 5.7

			if 5.7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_49 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_50 = 5

			if var_151_49 <= arg_148_1.time_ and arg_148_1.time_ < var_151_49 + var_151_50 then
				local var_151_51 = Color.New(1, 1, 1)

				var_151_51.a = Mathf.Lerp(1, 0, (arg_148_1.time_ - var_151_49) / var_151_50)
				arg_148_1.mask_.color = var_151_51
			end

			if arg_148_1.time_ >= var_151_49 + var_151_50 and arg_148_1.time_ < var_151_49 + var_151_50 + arg_151_0 then
				local var_151_52 = Color.New(1, 1, 1)

				arg_148_1.mask_.enabled = false
				var_151_52.a = 0
				arg_148_1.mask_.color = var_151_52
			end

			local var_151_53 = 12.7

			if 12.7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_53 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_54 = 5

			if var_151_53 <= arg_148_1.time_ and arg_148_1.time_ < var_151_53 + var_151_54 then
				local var_151_55 = Color.New(1, 1, 1)

				var_151_55.a = Mathf.Lerp(1, 0, (arg_148_1.time_ - var_151_53) / var_151_54)
				arg_148_1.mask_.color = var_151_55
			end

			if arg_148_1.time_ >= var_151_53 + var_151_54 and arg_148_1.time_ < var_151_53 + var_151_54 + arg_151_0 then
				local var_151_56 = Color.New(1, 1, 1)

				arg_148_1.mask_.enabled = false
				var_151_56.a = 0
				arg_148_1.mask_.color = var_151_56
			end

			local var_151_57 = 19.7

			if 19.7 < arg_148_1.time_ and arg_148_1.time_ <= var_151_57 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_58 = 5

			if var_151_57 <= arg_148_1.time_ and arg_148_1.time_ < var_151_57 + var_151_58 then
				local var_151_59 = Color.New(1, 1, 1)

				var_151_59.a = Mathf.Lerp(1, 0, (arg_148_1.time_ - var_151_57) / var_151_58)
				arg_148_1.mask_.color = var_151_59
			end

			if arg_148_1.time_ >= var_151_57 + var_151_58 and arg_148_1.time_ < var_151_57 + var_151_58 + arg_151_0 then
				local var_151_60 = Color.New(1, 1, 1)

				arg_148_1.mask_.enabled = false
				var_151_60.a = 0
				arg_148_1.mask_.color = var_151_60
			end

			if 2 < arg_148_1.time_ and arg_148_1.time_ <= 2 + arg_151_0 then
				local var_151_61 = arg_148_1.fswbg_.transform:Find("textbox/adapt/content") or arg_148_1.fswbg_.transform:Find("textbox/content")
				local var_151_62 = arg_148_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_151_63 = var_151_61:GetComponent("RectTransform")

				var_151_61:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_151_63.offsetMin = Vector2.New(0, 0)
				var_151_63.offsetMax = Vector2.New(0, 0)
			end

			if 5.67 < arg_148_1.time_ and arg_148_1.time_ <= 5.67 + arg_151_0 then
				arg_148_1.fswbg_:SetActive(true)
				arg_148_1.dialog_:SetActive(false)

				arg_148_1.fswtw_.percent = 0
				arg_148_1.fswt_.text = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(116361033).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.fswt_)

				arg_148_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_148_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_148_1.fswtw_:SetDirty()

				arg_148_1.typewritterCharCountI18N = 0

				SetActive(arg_148_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_148_1:ShowNextGo(false)
			end

			local var_151_64 = 5.70333333333333

			if 5.70333333333333 < arg_148_1.time_ and arg_148_1.time_ <= var_151_64 + arg_151_0 then
				arg_148_1.var_.oldValueTypewriter = arg_148_1.fswtw_.percent

				SetActive(arg_148_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_148_1:ShowNextGo(false)
			end

			local var_151_65 = 2
			local var_151_66 = 0.133333333333333
			local var_151_67, var_151_68 = arg_148_1:GetPercentByPara(arg_148_1:FormatText(arg_148_1:GetWordFromCfg(116361033).content), 1)

			if var_151_64 < arg_148_1.time_ and arg_148_1.time_ <= var_151_64 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				local var_151_69 = var_151_65 <= 0 and var_151_66 or var_151_66 * ((var_151_68 - arg_148_1.typewritterCharCountI18N) / var_151_65)

				if (var_151_65 <= 0 and var_151_66 or var_151_66 * ((var_151_68 - arg_148_1.typewritterCharCountI18N) / var_151_65)) > 0 and var_151_66 < var_151_69 then
					arg_148_1.talkMaxDuration = var_151_69

					if var_151_69 + var_151_64 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_69 + var_151_64
					end
				end
			end

			local var_151_70 = math.max(0.133333333333333, arg_148_1.talkMaxDuration)

			if var_151_64 <= arg_148_1.time_ and arg_148_1.time_ < var_151_64 + var_151_70 then
				arg_148_1.fswtw_.percent = Mathf.Lerp(arg_148_1.var_.oldValueTypewriter, var_151_67, (arg_148_1.time_ - var_151_64) / var_151_70)
				arg_148_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_148_1.fswtw_:SetDirty()
			end

			if arg_148_1.time_ >= var_151_64 + var_151_70 and arg_148_1.time_ < var_151_64 + var_151_70 + arg_151_0 then
				arg_148_1.fswtw_.percent = var_151_67

				arg_148_1.fswtw_:SetDirty()
				arg_148_1:ShowNextGo(true)

				arg_148_1.typewritterCharCountI18N = var_151_68
			end

			local var_151_71 = 5.67

			if 5.67 < arg_148_1.time_ and arg_148_1.time_ <= var_151_71 + arg_151_0 then
				arg_148_1.allBtn_.enabled = false
			end

			if arg_148_1.time_ >= var_151_71 + 21.03 and arg_148_1.time_ < var_151_71 + 21.03 + arg_151_0 then
				arg_148_1.allBtn_.enabled = true
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_151_74 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_148_1.bgmTxt_.text ~= var_151_74 and arg_148_1.bgmTxt_.text ~= "" then
						if arg_148_1.bgmTxt2_.text ~= "" then
							arg_148_1.bgmTxt_.text = arg_148_1.bgmTxt2_.text
						end

						arg_148_1.bgmTxt2_.text = var_151_74

						arg_148_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_148_1.bgmTxt_.text = var_151_74
						arg_148_1.bgmTxt2_.text = var_151_74
					end

					if arg_148_1.bgmTimer then
						arg_148_1.bgmTimer:Stop()

						arg_148_1.bgmTimer = nil
					end

					if arg_148_1.settingData.show_music_name == 1 then
						arg_148_1.musicController:SetSelectedState("show")
						arg_148_1.musicAnimator_:Play("open", 0, 0)

						if arg_148_1.settingData.music_time ~= 0 then
							arg_148_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_148_1.settingData.music_time), function()
								if arg_148_1 == nil or isNil(arg_148_1.bgmTxt_) then
									return
								end

								arg_148_1.musicController:SetSelectedState("hide")
								arg_148_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 5.83666666666667 < arg_148_1.time_ and arg_148_1.time_ <= 5.83666666666667 + arg_151_0 then
				arg_148_1:AudioAction("play", "music", "bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld.awb")

				local var_151_77 = manager.audio:GetAudioName("bgm_activity_1_6_story_skuld", "bgm_activity_1_6_story_skuld")

				if "" ~= "" then
					if arg_148_1.bgmTxt_.text ~= var_151_77 and arg_148_1.bgmTxt_.text ~= "" then
						if arg_148_1.bgmTxt2_.text ~= "" then
							arg_148_1.bgmTxt_.text = arg_148_1.bgmTxt2_.text
						end

						arg_148_1.bgmTxt2_.text = var_151_77

						arg_148_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_148_1.bgmTxt_.text = var_151_77
						arg_148_1.bgmTxt2_.text = var_151_77
					end

					if arg_148_1.bgmTimer then
						arg_148_1.bgmTimer:Stop()

						arg_148_1.bgmTimer = nil
					end

					if arg_148_1.settingData.show_music_name == 1 then
						arg_148_1.musicController:SetSelectedState("show")
						arg_148_1.musicAnimator_:Play("open", 0, 0)

						if arg_148_1.settingData.music_time ~= 0 then
							arg_148_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_148_1.settingData.music_time), function()
								if arg_148_1 == nil or isNil(arg_148_1.bgmTxt_) then
									return
								end

								arg_148_1.musicController:SetSelectedState("hide")
								arg_148_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play116361034 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 116361034
		arg_156_1.duration_ = 23.2

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play116361035(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:AudioAction("play", "effect", "se_story_16", "se_story_16_whoosh", "")
			end

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 then
				local var_159_1 = arg_156_1.bgs_.ST03_blur

				arg_156_1.bgs_.ST03_blur.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_2 = var_159_1:GetComponent("SpriteRenderer")

				if var_159_2 and var_159_2.sprite then
					local var_159_3 = 2 * (var_159_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_1.transform.localScale = Vector3.New(var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "ST03_blur" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 9 < arg_156_1.time_ and arg_156_1.time_ <= 9 + arg_159_0 then
				local var_159_4 = arg_156_1.bgs_.I05

				arg_156_1.bgs_.I05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_5 = var_159_4:GetComponent("SpriteRenderer")

				if var_159_5 and var_159_5.sprite then
					local var_159_6 = 2 * (var_159_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_4.transform.localScale = Vector3.New(var_159_6 / var_159_5.sprite.bounds.size.y < var_159_6 * manager.ui.mainCameraCom_.aspect / var_159_5.sprite.bounds.size.x and var_159_6 * manager.ui.mainCameraCom_.aspect / var_159_5.sprite.bounds.size.x or var_159_6 / var_159_5.sprite.bounds.size.y, var_159_6 / var_159_5.sprite.bounds.size.y < var_159_6 * manager.ui.mainCameraCom_.aspect / var_159_5.sprite.bounds.size.x and var_159_6 * manager.ui.mainCameraCom_.aspect / var_159_5.sprite.bounds.size.x or var_159_6 / var_159_5.sprite.bounds.size.y, 0)
				end

				for iter_159_2, iter_159_3 in pairs(arg_156_1.bgs_) do
					if iter_159_2 ~= "I05" then
						iter_159_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 16.2 < arg_156_1.time_ and arg_156_1.time_ <= 16.2 + arg_159_0 then
				local var_159_7 = arg_156_1.bgs_.ST15

				arg_156_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_8 = var_159_7:GetComponent("SpriteRenderer")

				if var_159_8 and var_159_8.sprite then
					local var_159_9 = 2 * (var_159_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_7.transform.localScale = Vector3.New(var_159_9 / var_159_8.sprite.bounds.size.y < var_159_9 * manager.ui.mainCameraCom_.aspect / var_159_8.sprite.bounds.size.x and var_159_9 * manager.ui.mainCameraCom_.aspect / var_159_8.sprite.bounds.size.x or var_159_9 / var_159_8.sprite.bounds.size.y, var_159_9 / var_159_8.sprite.bounds.size.y < var_159_9 * manager.ui.mainCameraCom_.aspect / var_159_8.sprite.bounds.size.x and var_159_9 * manager.ui.mainCameraCom_.aspect / var_159_8.sprite.bounds.size.x or var_159_9 / var_159_8.sprite.bounds.size.y, 0)
				end

				for iter_159_4, iter_159_5 in pairs(arg_156_1.bgs_) do
					if iter_159_4 ~= "ST15" then
						iter_159_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_10 = 0

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_11 = 2

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 then
				local var_159_12 = Color.New(0, 0, 0)

				var_159_12.a = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_10) / var_159_11)
				arg_156_1.mask_.color = var_159_12
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 then
				local var_159_13 = Color.New(0, 0, 0)

				var_159_13.a = 1
				arg_156_1.mask_.color = var_159_13
			end

			local var_159_14 = 2

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_15 = 5

			if var_159_14 <= arg_156_1.time_ and arg_156_1.time_ < var_159_14 + var_159_15 then
				local var_159_16 = Color.New(1, 1, 1)

				var_159_16.a = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_14) / var_159_15)
				arg_156_1.mask_.color = var_159_16
			end

			if arg_156_1.time_ >= var_159_14 + var_159_15 and arg_156_1.time_ < var_159_14 + var_159_15 + arg_159_0 then
				local var_159_17 = Color.New(1, 1, 1)

				arg_156_1.mask_.enabled = false
				var_159_17.a = 0
				arg_156_1.mask_.color = var_159_17
			end

			local var_159_18 = 9

			if 9 < arg_156_1.time_ and arg_156_1.time_ <= var_159_18 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_19 = 5

			if var_159_18 <= arg_156_1.time_ and arg_156_1.time_ < var_159_18 + var_159_19 then
				local var_159_20 = Color.New(1, 1, 1)

				var_159_20.a = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_18) / var_159_19)
				arg_156_1.mask_.color = var_159_20
			end

			if arg_156_1.time_ >= var_159_18 + var_159_19 and arg_156_1.time_ < var_159_18 + var_159_19 + arg_159_0 then
				local var_159_21 = Color.New(1, 1, 1)

				arg_156_1.mask_.enabled = false
				var_159_21.a = 0
				arg_156_1.mask_.color = var_159_21
			end

			local var_159_22 = 16.2

			if 16.2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_22 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_23 = 5

			if var_159_22 <= arg_156_1.time_ and arg_156_1.time_ < var_159_22 + var_159_23 then
				local var_159_24 = Color.New(1, 1, 1)

				var_159_24.a = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_22) / var_159_23)
				arg_156_1.mask_.color = var_159_24
			end

			if arg_156_1.time_ >= var_159_22 + var_159_23 and arg_156_1.time_ < var_159_22 + var_159_23 + arg_159_0 then
				local var_159_25 = Color.New(1, 1, 1)

				arg_156_1.mask_.enabled = false
				var_159_25.a = 0
				arg_156_1.mask_.color = var_159_25
			end

			local var_159_26 = "ST03_blur"

			if arg_156_1.bgs_.ST03_blur == nil then
				local var_159_27 = Object.Instantiate(arg_156_1.blurPaintGo_)

				var_159_27:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_26)
				var_159_27.name = var_159_26
				var_159_27.transform.parent = arg_156_1.stage_.transform
				var_159_27.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_26] = var_159_27
			end

			local var_159_28 = 2
			local var_159_29 = arg_156_1.bgs_[var_159_26]

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_28 + arg_159_0 then
				var_159_29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_30 = var_159_29:GetComponent("SpriteRenderer")

				if var_159_30 and var_159_30.sprite then
					local var_159_31 = 2 * (var_159_29.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_29.transform.localScale = Vector3.New(var_159_31 / var_159_30.sprite.bounds.size.y < var_159_31 * manager.ui.mainCameraCom_.aspect / var_159_30.sprite.bounds.size.x and var_159_31 * manager.ui.mainCameraCom_.aspect / var_159_30.sprite.bounds.size.x or var_159_31 / var_159_30.sprite.bounds.size.y, var_159_31 / var_159_30.sprite.bounds.size.y < var_159_31 * manager.ui.mainCameraCom_.aspect / var_159_30.sprite.bounds.size.x and var_159_31 * manager.ui.mainCameraCom_.aspect / var_159_30.sprite.bounds.size.x or var_159_31 / var_159_30.sprite.bounds.size.y, 0)
				end
			end

			local var_159_32 = 7

			if var_159_28 <= arg_156_1.time_ and arg_156_1.time_ < var_159_28 + var_159_32 then
				local var_159_33 = Color.New(1, 1, 1)

				var_159_33.a = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_28) / var_159_32)

				var_159_29:GetComponent("SpriteRenderer").material:SetColor("_Color", var_159_33)
			end

			local var_159_34 = "I05_blur"

			if arg_156_1.bgs_.I05_blur == nil then
				local var_159_35 = Object.Instantiate(arg_156_1.blurPaintGo_)

				var_159_35:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_34)
				var_159_35.name = var_159_34
				var_159_35.transform.parent = arg_156_1.stage_.transform
				var_159_35.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_34] = var_159_35
			end

			local var_159_36 = 9
			local var_159_37 = arg_156_1.bgs_[var_159_34]

			if 9 < arg_156_1.time_ and arg_156_1.time_ <= var_159_36 + arg_159_0 then
				var_159_37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_38 = var_159_37:GetComponent("SpriteRenderer")

				if var_159_38 and var_159_38.sprite then
					local var_159_39 = 2 * (var_159_37.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_37.transform.localScale = Vector3.New(var_159_39 / var_159_38.sprite.bounds.size.y < var_159_39 * manager.ui.mainCameraCom_.aspect / var_159_38.sprite.bounds.size.x and var_159_39 * manager.ui.mainCameraCom_.aspect / var_159_38.sprite.bounds.size.x or var_159_39 / var_159_38.sprite.bounds.size.y, var_159_39 / var_159_38.sprite.bounds.size.y < var_159_39 * manager.ui.mainCameraCom_.aspect / var_159_38.sprite.bounds.size.x and var_159_39 * manager.ui.mainCameraCom_.aspect / var_159_38.sprite.bounds.size.x or var_159_39 / var_159_38.sprite.bounds.size.y, 0)
				end
			end

			local var_159_40 = 7.2

			if var_159_36 <= arg_156_1.time_ and arg_156_1.time_ < var_159_36 + var_159_40 then
				local var_159_41 = Color.New(1, 1, 1)

				var_159_41.a = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_36) / var_159_40)

				var_159_37:GetComponent("SpriteRenderer").material:SetColor("_Color", var_159_41)
			end

			local var_159_42 = "ST15_blur"

			if arg_156_1.bgs_.ST15_blur == nil then
				local var_159_43 = Object.Instantiate(arg_156_1.blurPaintGo_)

				var_159_43:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_42)
				var_159_43.name = var_159_42
				var_159_43.transform.parent = arg_156_1.stage_.transform
				var_159_43.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_42] = var_159_43
			end

			local var_159_44 = 16.2
			local var_159_45 = arg_156_1.bgs_[var_159_42]

			if 16.2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_44 + arg_159_0 then
				var_159_45.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_45.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_46 = var_159_45:GetComponent("SpriteRenderer")

				if var_159_46 and var_159_46.sprite then
					local var_159_47 = 2 * (var_159_45.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_45.transform.localScale = Vector3.New(var_159_47 / var_159_46.sprite.bounds.size.y < var_159_47 * manager.ui.mainCameraCom_.aspect / var_159_46.sprite.bounds.size.x and var_159_47 * manager.ui.mainCameraCom_.aspect / var_159_46.sprite.bounds.size.x or var_159_47 / var_159_46.sprite.bounds.size.y, var_159_47 / var_159_46.sprite.bounds.size.y < var_159_47 * manager.ui.mainCameraCom_.aspect / var_159_46.sprite.bounds.size.x and var_159_47 * manager.ui.mainCameraCom_.aspect / var_159_46.sprite.bounds.size.x or var_159_47 / var_159_46.sprite.bounds.size.y, 0)
				end
			end

			local var_159_48 = 7

			if var_159_44 <= arg_156_1.time_ and arg_156_1.time_ < var_159_44 + var_159_48 then
				local var_159_49 = Color.New(1, 1, 1)

				var_159_49.a = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_44) / var_159_48)

				var_159_45:GetComponent("SpriteRenderer").material:SetColor("_Color", var_159_49)
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.fswbg_:SetActive(true)
				arg_156_1.dialog_:SetActive(false)

				arg_156_1.fswtw_.percent = 0
				arg_156_1.fswt_.text = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(116361034).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.fswt_)

				arg_156_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_156_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_156_1.fswtw_:SetDirty()

				arg_156_1.typewritterCharCountI18N = 0

				SetActive(arg_156_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_156_1:ShowNextGo(false)
			end

			local var_159_50 = 2

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_50 + arg_159_0 then
				arg_156_1.var_.oldValueTypewriter = arg_156_1.fswtw_.percent

				SetActive(arg_156_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_156_1:ShowNextGo(false)
			end

			local var_159_51 = 2
			local var_159_52 = 0.133333333333333
			local var_159_53, var_159_54 = arg_156_1:GetPercentByPara(arg_156_1:FormatText(arg_156_1:GetWordFromCfg(116361034).content), 1)

			if var_159_50 < arg_156_1.time_ and arg_156_1.time_ <= var_159_50 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				local var_159_55 = var_159_51 <= 0 and var_159_52 or var_159_52 * ((var_159_54 - arg_156_1.typewritterCharCountI18N) / var_159_51)

				if (var_159_51 <= 0 and var_159_52 or var_159_52 * ((var_159_54 - arg_156_1.typewritterCharCountI18N) / var_159_51)) > 0 and var_159_52 < var_159_55 then
					arg_156_1.talkMaxDuration = var_159_55

					if var_159_55 + var_159_50 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_55 + var_159_50
					end
				end
			end

			local var_159_56 = math.max(0.133333333333333, arg_156_1.talkMaxDuration)

			if var_159_50 <= arg_156_1.time_ and arg_156_1.time_ < var_159_50 + var_159_56 then
				arg_156_1.fswtw_.percent = Mathf.Lerp(arg_156_1.var_.oldValueTypewriter, var_159_53, (arg_156_1.time_ - var_159_50) / var_159_56)
				arg_156_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_156_1.fswtw_:SetDirty()
			end

			if arg_156_1.time_ >= var_159_50 + var_159_56 and arg_156_1.time_ < var_159_50 + var_159_56 + arg_159_0 then
				arg_156_1.fswtw_.percent = var_159_53

				arg_156_1.fswtw_:SetDirty()
				arg_156_1:ShowNextGo(true)

				arg_156_1.typewritterCharCountI18N = var_159_54
			end

			local var_159_57 = 2

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_57 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			if arg_156_1.time_ >= var_159_57 + 21.2 and arg_156_1.time_ < var_159_57 + 21.2 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play116361035 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 116361035
		arg_160_1.duration_ = 4.69

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play116361036(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if arg_160_1.bgs_.STwhite == nil then
				local var_163_0 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_163_0.name = "STwhite"
				var_163_0.transform.parent = arg_160_1.stage_.transform
				var_163_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_.STwhite = var_163_0
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				local var_163_1 = arg_160_1.bgs_.STwhite

				arg_160_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_163_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_2 = var_163_1:GetComponent("SpriteRenderer")

				if var_163_2 and var_163_2.sprite then
					local var_163_3 = 2 * (var_163_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_163_1.transform.localScale = Vector3.New(var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "STwhite" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_4 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_5 = 2

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_5 then
				local var_163_6 = Color.New(0, 0, 0)

				var_163_6.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_4) / var_163_5)
				arg_160_1.mask_.color = var_163_6
			end

			if arg_160_1.time_ >= var_163_4 + var_163_5 and arg_160_1.time_ < var_163_4 + var_163_5 + arg_163_0 then
				local var_163_7 = Color.New(0, 0, 0)

				arg_160_1.mask_.enabled = false
				var_163_7.a = 0
				arg_160_1.mask_.color = var_163_7
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.fswbg_:SetActive(true)
				arg_160_1.dialog_:SetActive(false)

				arg_160_1.fswtw_.percent = 0
				arg_160_1.fswt_.text = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(116361035).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.fswt_)

				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_160_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_160_1.fswtw_:SetDirty()

				arg_160_1.typewritterCharCountI18N = 0

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_8 = 2

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.var_.oldValueTypewriter = arg_160_1.fswtw_.percent

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_9 = 12
			local var_163_10 = 0.8
			local var_163_11, var_163_12 = arg_160_1:GetPercentByPara(arg_160_1:FormatText(arg_160_1:GetWordFromCfg(116361035).content), 1)

			if var_163_8 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				local var_163_13 = var_163_9 <= 0 and var_163_10 or var_163_10 * ((var_163_12 - arg_160_1.typewritterCharCountI18N) / var_163_9)

				if (var_163_9 <= 0 and var_163_10 or var_163_10 * ((var_163_12 - arg_160_1.typewritterCharCountI18N) / var_163_9)) > 0 and var_163_10 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_8
					end
				end
			end

			local var_163_14 = math.max(0.8, arg_160_1.talkMaxDuration)

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_14 then
				arg_160_1.fswtw_.percent = Mathf.Lerp(arg_160_1.var_.oldValueTypewriter, var_163_11, (arg_160_1.time_ - var_163_8) / var_163_14)
				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_160_1.fswtw_:SetDirty()
			end

			if arg_160_1.time_ >= var_163_8 + var_163_14 and arg_160_1.time_ < var_163_8 + var_163_14 + arg_163_0 then
				arg_160_1.fswtw_.percent = var_163_11

				arg_160_1.fswtw_:SetDirty()
				arg_160_1:ShowNextGo(true)

				arg_160_1.typewritterCharCountI18N = var_163_12
			end

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= 2 + arg_163_0 then
				local var_163_15 = arg_160_1.fswbg_.transform:Find("textbox/adapt/content") or arg_160_1.fswbg_.transform:Find("textbox/content")
				local var_163_16 = arg_160_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_163_17 = var_163_15:GetComponent("RectTransform")

				var_163_15:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_163_17.offsetMin = Vector2.New(0, 0)
				var_163_17.offsetMax = Vector2.New(0, 0)
			end

			local var_163_18 = 2
			local var_163_19 = manager.audio:GetVoiceLength("story_v_out_116361", "116361035", "story_v_out_116361.awb") / 1000

			if var_163_19 > 0 and 2.695 < var_163_19 and var_163_19 + var_163_18 > arg_160_1.duration_ then
				arg_160_1.duration_ = var_163_19 + var_163_18
			end

			if var_163_18 < arg_160_1.time_ and arg_160_1.time_ <= var_163_18 + arg_163_0 then
				arg_160_1:AudioAction("play", "voice", "story_v_out_116361", "116361035", "story_v_out_116361.awb")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_163_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_160_1.bgmTxt_.text ~= var_163_23 and arg_160_1.bgmTxt_.text ~= "" then
						if arg_160_1.bgmTxt2_.text ~= "" then
							arg_160_1.bgmTxt_.text = arg_160_1.bgmTxt2_.text
						end

						arg_160_1.bgmTxt2_.text = var_163_23

						arg_160_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_160_1.bgmTxt_.text = var_163_23
						arg_160_1.bgmTxt2_.text = var_163_23
					end

					if arg_160_1.bgmTimer then
						arg_160_1.bgmTimer:Stop()

						arg_160_1.bgmTimer = nil
					end

					if arg_160_1.settingData.show_music_name == 1 then
						arg_160_1.musicController:SetSelectedState("show")
						arg_160_1.musicAnimator_:Play("open", 0, 0)

						if arg_160_1.settingData.music_time ~= 0 then
							arg_160_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_160_1.settingData.music_time), function()
								if arg_160_1 == nil or isNil(arg_160_1.bgmTxt_) then
									return
								end

								arg_160_1.musicController:SetSelectedState("hide")
								arg_160_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play116361036 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116361036
		arg_165_1.duration_ = 5.09

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116361037(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.fswbg_:SetActive(true)
				arg_165_1.dialog_:SetActive(false)

				arg_165_1.fswtw_.percent = 0
				arg_165_1.fswt_.text = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(116361036).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.fswt_)

				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_165_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_165_1.fswtw_:SetDirty()

				arg_165_1.typewritterCharCountI18N = 0

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.var_.oldValueTypewriter = arg_165_1.fswtw_.percent

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_1 = 10
			local var_168_2 = 0.666666666666667
			local var_168_3, var_168_4 = arg_165_1:GetPercentByPara(arg_165_1:FormatText(arg_165_1:GetWordFromCfg(116361036).content), 1)

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				local var_168_5 = var_168_1 <= 0 and var_168_2 or var_168_2 * ((var_168_4 - arg_165_1.typewritterCharCountI18N) / var_168_1)

				if (var_168_1 <= 0 and var_168_2 or var_168_2 * ((var_168_4 - arg_165_1.typewritterCharCountI18N) / var_168_1)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_0
					end
				end
			end

			local var_168_6 = math.max(0.666666666666667, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_6 then
				arg_165_1.fswtw_.percent = Mathf.Lerp(arg_165_1.var_.oldValueTypewriter, var_168_3, (arg_165_1.time_ - var_168_0) / var_168_6)
				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_165_1.fswtw_:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_6 and arg_165_1.time_ < var_168_0 + var_168_6 + arg_168_0 then
				arg_165_1.fswtw_.percent = var_168_3

				arg_165_1.fswtw_:SetDirty()
				arg_165_1:ShowNextGo(true)

				arg_165_1.typewritterCharCountI18N = var_168_4
			end

			if 2 < arg_165_1.time_ and arg_165_1.time_ <= 2 + arg_168_0 then
				arg_165_1.fswbg_:SetActive(true)
				arg_165_1.dialog_:SetActive(false)

				arg_165_1.fswtw_.percent = 0
				arg_165_1.fswt_.text = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(116361036).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.fswt_)

				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_165_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_165_1.fswtw_:SetDirty()

				arg_165_1.typewritterCharCountI18N = 0

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_165_1:ShowNextGo(false)
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_7 = arg_165_1.fswbg_.transform:Find("textbox/adapt/content") or arg_165_1.fswbg_.transform:Find("textbox/content")
				local var_168_8 = arg_165_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_168_9 = var_168_7:GetComponent("RectTransform")

				var_168_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_168_9.offsetMin = Vector2.New(0, 0)
				var_168_9.offsetMax = Vector2.New(0, 0)
			end

			local var_168_10 = 0
			local var_168_11 = manager.audio:GetVoiceLength("story_v_out_116361", "116361036", "story_v_out_116361.awb") / 1000

			if var_168_11 > 0 and 3.093 < var_168_11 and var_168_11 + var_168_10 > arg_165_1.duration_ then
				arg_165_1.duration_ = var_168_11 + var_168_10
			end

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1:AudioAction("play", "voice", "story_v_out_116361", "116361036", "story_v_out_116361.awb")
			end

			local var_168_13 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			if arg_165_1.time_ >= var_168_13 + 0.683333333333333 and arg_165_1.time_ < var_168_13 + 0.683333333333333 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play116361037 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116361037
		arg_169_1.duration_ = 11.59

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116361038(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.fswbg_:SetActive(true)
				arg_169_1.dialog_:SetActive(false)

				arg_169_1.fswtw_.percent = 0
				arg_169_1.fswt_.text = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(116361037).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.fswt_)

				arg_169_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_169_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_169_1.fswtw_:SetDirty()

				arg_169_1.typewritterCharCountI18N = 0

				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_0 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.var_.oldValueTypewriter = arg_169_1.fswtw_.percent

				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_1 = 32
			local var_172_2 = 2.13333333333333
			local var_172_3, var_172_4 = arg_169_1:GetPercentByPara(arg_169_1:FormatText(arg_169_1:GetWordFromCfg(116361037).content), 1)

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				local var_172_5 = var_172_1 <= 0 and var_172_2 or var_172_2 * ((var_172_4 - arg_169_1.typewritterCharCountI18N) / var_172_1)

				if (var_172_1 <= 0 and var_172_2 or var_172_2 * ((var_172_4 - arg_169_1.typewritterCharCountI18N) / var_172_1)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_0
					end
				end
			end

			local var_172_6 = math.max(2.13333333333333, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_6 then
				arg_169_1.fswtw_.percent = Mathf.Lerp(arg_169_1.var_.oldValueTypewriter, var_172_3, (arg_169_1.time_ - var_172_0) / var_172_6)
				arg_169_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_169_1.fswtw_:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_6 and arg_169_1.time_ < var_172_0 + var_172_6 + arg_172_0 then
				arg_169_1.fswtw_.percent = var_172_3

				arg_169_1.fswtw_:SetDirty()
				arg_169_1:ShowNextGo(true)

				arg_169_1.typewritterCharCountI18N = var_172_4
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				local var_172_7 = arg_169_1.fswbg_.transform:Find("textbox/adapt/content") or arg_169_1.fswbg_.transform:Find("textbox/content")
				local var_172_8 = arg_169_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_172_9 = var_172_7:GetComponent("RectTransform")

				var_172_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_172_9.offsetMin = Vector2.New(0, 0)
				var_172_9.offsetMax = Vector2.New(0, 0)
			end

			local var_172_10 = 0
			local var_172_11 = manager.audio:GetVoiceLength("story_v_out_116361", "116361037", "story_v_out_116361.awb") / 1000

			if var_172_11 > 0 and 11.59 < var_172_11 and var_172_11 + var_172_10 > arg_169_1.duration_ then
				arg_169_1.duration_ = var_172_11 + var_172_10
			end

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1:AudioAction("play", "voice", "story_v_out_116361", "116361037", "story_v_out_116361.awb")
			end

			local var_172_13 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			if arg_169_1.time_ >= var_172_13 + 2.15 and arg_169_1.time_ < var_172_13 + 2.15 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play116361038 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116361038
		arg_173_1.duration_ = 7.74

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play116361039(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.fswbg_:SetActive(true)
				arg_173_1.dialog_:SetActive(false)

				arg_173_1.fswtw_.percent = 0
				arg_173_1.fswt_.text = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(116361038).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.fswt_)

				arg_173_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_173_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_173_1.fswtw_:SetDirty()

				arg_173_1.typewritterCharCountI18N = 0

				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_173_1:ShowNextGo(false)
			end

			local var_176_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.var_.oldValueTypewriter = arg_173_1.fswtw_.percent

				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_173_1:ShowNextGo(false)
			end

			local var_176_1 = 25
			local var_176_2 = 1.66666666666667
			local var_176_3, var_176_4 = arg_173_1:GetPercentByPara(arg_173_1:FormatText(arg_173_1:GetWordFromCfg(116361038).content), 1)

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				local var_176_5 = var_176_1 <= 0 and var_176_2 or var_176_2 * ((var_176_4 - arg_173_1.typewritterCharCountI18N) / var_176_1)

				if (var_176_1 <= 0 and var_176_2 or var_176_2 * ((var_176_4 - arg_173_1.typewritterCharCountI18N) / var_176_1)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_0
					end
				end
			end

			local var_176_6 = math.max(1.66666666666667, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_6 then
				arg_173_1.fswtw_.percent = Mathf.Lerp(arg_173_1.var_.oldValueTypewriter, var_176_3, (arg_173_1.time_ - var_176_0) / var_176_6)
				arg_173_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_173_1.fswtw_:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_6 and arg_173_1.time_ < var_176_0 + var_176_6 + arg_176_0 then
				arg_173_1.fswtw_.percent = var_176_3

				arg_173_1.fswtw_:SetDirty()
				arg_173_1:ShowNextGo(true)

				arg_173_1.typewritterCharCountI18N = var_176_4
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				local var_176_7 = arg_173_1.fswbg_.transform:Find("textbox/adapt/content") or arg_173_1.fswbg_.transform:Find("textbox/content")
				local var_176_8 = arg_173_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_176_9 = var_176_7:GetComponent("RectTransform")

				var_176_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_176_9.offsetMin = Vector2.New(0, 0)
				var_176_9.offsetMax = Vector2.New(0, 0)
			end

			local var_176_10 = 0
			local var_176_11 = manager.audio:GetVoiceLength("story_v_out_116361", "116361038", "story_v_out_116361.awb") / 1000

			if var_176_11 > 0 and 7.744 < var_176_11 and var_176_11 + var_176_10 > arg_173_1.duration_ then
				arg_173_1.duration_ = var_176_11 + var_176_10
			end

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1:AudioAction("play", "voice", "story_v_out_116361", "116361038", "story_v_out_116361.awb")
			end

			local var_176_13 = 0

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			if arg_173_1.time_ >= var_176_13 + 1.68333333333333 and arg_173_1.time_ < var_176_13 + 1.68333333333333 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play116361039 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116361039
		arg_177_1.duration_ = 9.7

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play116361040(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.fswbg_:SetActive(true)
				arg_177_1.dialog_:SetActive(false)

				arg_177_1.fswtw_.percent = 0
				arg_177_1.fswt_.text = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(116361039).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.fswt_)

				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_177_1.fswtw_:SetDirty()

				arg_177_1.typewritterCharCountI18N = 0

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.var_.oldValueTypewriter = arg_177_1.fswtw_.percent

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_1 = 31
			local var_180_2 = 2.06666666666667
			local var_180_3, var_180_4 = arg_177_1:GetPercentByPara(arg_177_1:FormatText(arg_177_1:GetWordFromCfg(116361039).content), 1)

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				local var_180_5 = var_180_1 <= 0 and var_180_2 or var_180_2 * ((var_180_4 - arg_177_1.typewritterCharCountI18N) / var_180_1)

				if (var_180_1 <= 0 and var_180_2 or var_180_2 * ((var_180_4 - arg_177_1.typewritterCharCountI18N) / var_180_1)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_0
					end
				end
			end

			local var_180_6 = math.max(2.06666666666667, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_6 then
				arg_177_1.fswtw_.percent = Mathf.Lerp(arg_177_1.var_.oldValueTypewriter, var_180_3, (arg_177_1.time_ - var_180_0) / var_180_6)
				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_177_1.fswtw_:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_6 and arg_177_1.time_ < var_180_0 + var_180_6 + arg_180_0 then
				arg_177_1.fswtw_.percent = var_180_3

				arg_177_1.fswtw_:SetDirty()
				arg_177_1:ShowNextGo(true)

				arg_177_1.typewritterCharCountI18N = var_180_4
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				local var_180_7 = arg_177_1.fswbg_.transform:Find("textbox/adapt/content") or arg_177_1.fswbg_.transform:Find("textbox/content")
				local var_180_8 = arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_180_9 = var_180_7:GetComponent("RectTransform")

				var_180_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_180_9.offsetMin = Vector2.New(0, 0)
				var_180_9.offsetMax = Vector2.New(0, 0)
			end

			local var_180_10 = 0
			local var_180_11 = manager.audio:GetVoiceLength("story_v_out_116361", "116361039", "story_v_out_116361.awb") / 1000

			if var_180_11 > 0 and 9.702 < var_180_11 and var_180_11 + var_180_10 > arg_177_1.duration_ then
				arg_177_1.duration_ = var_180_11 + var_180_10
			end

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1:AudioAction("play", "voice", "story_v_out_116361", "116361039", "story_v_out_116361.awb")
			end

			local var_180_13 = 0

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			if arg_177_1.time_ >= var_180_13 + 2.06666666666667 and arg_177_1.time_ < var_180_13 + 2.06666666666667 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play116361040 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116361040
		arg_181_1.duration_ = 14.84

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play116361041(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.fswbg_:SetActive(true)
				arg_181_1.dialog_:SetActive(false)

				arg_181_1.fswtw_.percent = 0
				arg_181_1.fswt_.text = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(116361040).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.fswt_)

				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_181_1.fswtw_:SetDirty()

				arg_181_1.typewritterCharCountI18N = 0

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.var_.oldValueTypewriter = arg_181_1.fswtw_.percent

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_1 = 49
			local var_184_2 = 3.33333333333333
			local var_184_3, var_184_4 = arg_181_1:GetPercentByPara(arg_181_1:FormatText(arg_181_1:GetWordFromCfg(116361040).content), 1)

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				local var_184_5 = var_184_1 <= 0 and var_184_2 or var_184_2 * ((var_184_4 - arg_181_1.typewritterCharCountI18N) / var_184_1)

				if (var_184_1 <= 0 and var_184_2 or var_184_2 * ((var_184_4 - arg_181_1.typewritterCharCountI18N) / var_184_1)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_0
					end
				end
			end

			local var_184_6 = math.max(3.33333333333333, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_6 then
				arg_181_1.fswtw_.percent = Mathf.Lerp(arg_181_1.var_.oldValueTypewriter, var_184_3, (arg_181_1.time_ - var_184_0) / var_184_6)
				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_181_1.fswtw_:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_6 and arg_181_1.time_ < var_184_0 + var_184_6 + arg_184_0 then
				arg_181_1.fswtw_.percent = var_184_3

				arg_181_1.fswtw_:SetDirty()
				arg_181_1:ShowNextGo(true)

				arg_181_1.typewritterCharCountI18N = var_184_4
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				local var_184_7 = arg_181_1.fswbg_.transform:Find("textbox/adapt/content") or arg_181_1.fswbg_.transform:Find("textbox/content")
				local var_184_8 = arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_184_9 = var_184_7:GetComponent("RectTransform")

				var_184_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_184_9.offsetMin = Vector2.New(0, 0)
				var_184_9.offsetMax = Vector2.New(0, 0)
			end

			local var_184_10 = 0
			local var_184_11 = manager.audio:GetVoiceLength("story_v_out_116361", "116361040", "story_v_out_116361.awb") / 1000

			if var_184_11 > 0 and 14.841 < var_184_11 and var_184_11 + var_184_10 > arg_181_1.duration_ then
				arg_181_1.duration_ = var_184_11 + var_184_10
			end

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1:AudioAction("play", "voice", "story_v_out_116361", "116361040", "story_v_out_116361.awb")
			end

			local var_184_13 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_13 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			if arg_181_1.time_ >= var_184_13 + 3.35 and arg_181_1.time_ < var_184_13 + 3.35 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play116361041 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116361041
		arg_185_1.duration_ = 5.43

		local var_185_0 = {
			zh = 5.366,
			ja = 5.433
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
				arg_185_0:Play116361042(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				local var_188_0 = arg_185_1.bgs_.I07a

				arg_185_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_188_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_1 = var_188_0:GetComponent("SpriteRenderer")

				if var_188_1 and var_188_1.sprite then
					local var_188_2 = 2 * (var_188_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_188_0.transform.localScale = Vector3.New(var_188_2 / var_188_1.sprite.bounds.size.y < var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x and var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x or var_188_2 / var_188_1.sprite.bounds.size.y, var_188_2 / var_188_1.sprite.bounds.size.y < var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x and var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x or var_188_2 / var_188_1.sprite.bounds.size.y, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "I07a" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.fswbg_:SetActive(false)
				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_185_1:ShowNextGo(false)
			end

			if 4 < arg_185_1.time_ and arg_185_1.time_ <= 4 + arg_188_0 then
				arg_185_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_188_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_185_1.bgmTxt_.text ~= var_188_5 and arg_185_1.bgmTxt_.text ~= "" then
						if arg_185_1.bgmTxt2_.text ~= "" then
							arg_185_1.bgmTxt_.text = arg_185_1.bgmTxt2_.text
						end

						arg_185_1.bgmTxt2_.text = var_188_5

						arg_185_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_185_1.bgmTxt_.text = var_188_5
						arg_185_1.bgmTxt2_.text = var_188_5
					end

					if arg_185_1.bgmTimer then
						arg_185_1.bgmTimer:Stop()

						arg_185_1.bgmTimer = nil
					end

					if arg_185_1.settingData.show_music_name == 1 then
						arg_185_1.musicController:SetSelectedState("show")
						arg_185_1.musicAnimator_:Play("open", 0, 0)

						if arg_185_1.settingData.music_time ~= 0 then
							arg_185_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_185_1.settingData.music_time), function()
								if arg_185_1 == nil or isNil(arg_185_1.bgmTxt_) then
									return
								end

								arg_185_1.musicController:SetSelectedState("hide")
								arg_185_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 4.4 < arg_185_1.time_ and arg_185_1.time_ <= 4.4 + arg_188_0 then
				arg_185_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_188_8 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_185_1.bgmTxt_.text ~= var_188_8 and arg_185_1.bgmTxt_.text ~= "" then
						if arg_185_1.bgmTxt2_.text ~= "" then
							arg_185_1.bgmTxt_.text = arg_185_1.bgmTxt2_.text
						end

						arg_185_1.bgmTxt2_.text = var_188_8

						arg_185_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_185_1.bgmTxt_.text = var_188_8
						arg_185_1.bgmTxt2_.text = var_188_8
					end

					if arg_185_1.bgmTimer then
						arg_185_1.bgmTimer:Stop()

						arg_185_1.bgmTimer = nil
					end

					if arg_185_1.settingData.show_music_name == 1 then
						arg_185_1.musicController:SetSelectedState("show")
						arg_185_1.musicAnimator_:Play("open", 0, 0)

						if arg_185_1.settingData.music_time ~= 0 then
							arg_185_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_185_1.settingData.music_time), function()
								if arg_185_1 == nil or isNil(arg_185_1.bgmTxt_) then
									return
								end

								arg_185_1.musicController:SetSelectedState("hide")
								arg_185_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_188_9 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_10 = 2

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_10 then
				local var_188_11 = Color.New(0, 0, 0)

				var_188_11.a = Mathf.Lerp(0, 1, (arg_185_1.time_ - var_188_9) / var_188_10)
				arg_185_1.mask_.color = var_188_11
			end

			if arg_185_1.time_ >= var_188_9 + var_188_10 and arg_185_1.time_ < var_188_9 + var_188_10 + arg_188_0 then
				local var_188_12 = Color.New(0, 0, 0)

				var_188_12.a = 1
				arg_185_1.mask_.color = var_188_12
			end

			local var_188_13 = 2

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_13 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_14 = 2

			if var_188_13 <= arg_185_1.time_ and arg_185_1.time_ < var_188_13 + var_188_14 then
				local var_188_15 = Color.New(0, 0, 0)

				var_188_15.a = Mathf.Lerp(1, 0, (arg_185_1.time_ - var_188_13) / var_188_14)
				arg_185_1.mask_.color = var_188_15
			end

			if arg_185_1.time_ >= var_188_13 + var_188_14 and arg_185_1.time_ < var_188_13 + var_188_14 + arg_188_0 then
				local var_188_16 = Color.New(0, 0, 0)

				arg_185_1.mask_.enabled = false
				var_188_16.a = 0
				arg_185_1.mask_.color = var_188_16
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_17 = 4
			local var_188_18 = 0.125

			if 4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_17 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_19 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_19:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_185_1.dialogCg_.alpha = arg_191_0
				end))
				var_188_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_20 = arg_185_1:GetWordFromCfg(116361041)
				local var_188_21 = arg_185_1:FormatText(var_188_20.content)

				arg_185_1.text_.text = var_188_21

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_23 = 5 <= 0 and var_188_18 or var_188_18 * (utf8.len(var_188_21) / 5)

				if (5 <= 0 and var_188_18 or var_188_18 * (utf8.len(var_188_21) / 5)) > 0 and var_188_18 < var_188_23 then
					arg_185_1.talkMaxDuration = var_188_23
					var_188_17 = var_188_17 + 0.3

					if var_188_23 + var_188_17 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_17
					end
				end

				arg_185_1.text_.text = var_188_21
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361041", "story_v_out_116361.awb") ~= 0 then
					local var_188_24 = manager.audio:GetVoiceLength("story_v_out_116361", "116361041", "story_v_out_116361.awb") / 1000

					if var_188_24 + var_188_17 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_24 + var_188_17
					end

					if var_188_20.prefab_name ~= "" and arg_185_1.actors_[var_188_20.prefab_name] ~= nil then
						local var_188_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_20.prefab_name].transform, "story_v_out_116361", "116361041", "story_v_out_116361.awb")

						arg_185_1:RecordAudio("116361041", var_188_25)
						arg_185_1:RecordAudio("116361041", var_188_25)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_116361", "116361041", "story_v_out_116361.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_116361", "116361041", "story_v_out_116361.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_26 = var_188_17 + 0.3
			local var_188_27 = math.max(var_188_18, arg_185_1.talkMaxDuration)

			if var_188_17 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_26 + var_188_27 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_26) / var_188_27

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_26 + var_188_27 and arg_185_1.time_ < var_188_26 + var_188_27 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play116361042 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116361042
		arg_193_1.duration_ = 2.07

		local var_193_0 = {
			zh = 2.066,
			ja = 0.999999999999
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play116361043(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.1

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(116361042)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 4 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 4)

				if (4 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 4)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361042", "story_v_out_116361.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_116361", "116361042", "story_v_out_116361.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_116361", "116361042", "story_v_out_116361.awb")

						arg_193_1:RecordAudio("116361042", var_196_6)
						arg_193_1:RecordAudio("116361042", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_116361", "116361042", "story_v_out_116361.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_116361", "116361042", "story_v_out_116361.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play116361043 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116361043
		arg_197_1.duration_ = 4.57

		local var_197_0 = {
			zh = 4.566,
			ja = 3.766
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
				arg_197_0:Play116361044(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.425

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(116361043)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 17 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 17)

				if (17 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 17)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361043", "story_v_out_116361.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_116361", "116361043", "story_v_out_116361.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_116361", "116361043", "story_v_out_116361.awb")

						arg_197_1:RecordAudio("116361043", var_200_6)
						arg_197_1:RecordAudio("116361043", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_116361", "116361043", "story_v_out_116361.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_116361", "116361043", "story_v_out_116361.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116361044 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 116361044
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play116361045(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.175

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(116361044).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 47 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 47)

				if (47 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 47)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play116361045 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 116361045
		arg_205_1.duration_ = 3.77

		local var_205_0 = {
			zh = 3.7,
			ja = 3.766
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
				arg_205_0:Play116361046(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.375

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:GetWordFromCfg(116361045)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 15 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 15)

				if (15 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 15)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361045", "story_v_out_116361.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_116361", "116361045", "story_v_out_116361.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_116361", "116361045", "story_v_out_116361.awb")

						arg_205_1:RecordAudio("116361045", var_208_6)
						arg_205_1:RecordAudio("116361045", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_116361", "116361045", "story_v_out_116361.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_116361", "116361045", "story_v_out_116361.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play116361046 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 116361046
		arg_209_1.duration_ = 2.53

		local var_209_0 = {
			zh = 2.533,
			ja = 2.433
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
				arg_209_0:Play116361047(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_212_0 = arg_209_1.actors_["10032ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect10032ui_story == nil then
				arg_209_1.var_.characterEffect10032ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_1 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 and not isNil(var_212_0) then
				if arg_209_1.var_.characterEffect10032ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect10032ui_story then
				arg_209_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_212_3 = arg_209_1.actors_["10032ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10032ui_story = var_212_3.localPosition
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_3.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_209_1.time_ - 0) / var_212_4)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_3.localPosition = Vector3.New(0, -1.1, -5.9)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			local var_212_5 = 0
			local var_212_6 = 0.3

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:GetWordFromCfg(116361046)
				local var_212_8 = arg_209_1:FormatText(var_212_7.content)

				arg_209_1.text_.text = var_212_8

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_10 = 12 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 12)

				if (12 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 12)) > 0 and var_212_6 < var_212_10 then
					arg_209_1.talkMaxDuration = var_212_10

					if var_212_10 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_8
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361046", "story_v_out_116361.awb") ~= 0 then
					local var_212_11 = manager.audio:GetVoiceLength("story_v_out_116361", "116361046", "story_v_out_116361.awb") / 1000

					if var_212_11 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_5
					end

					if var_212_7.prefab_name ~= "" and arg_209_1.actors_[var_212_7.prefab_name] ~= nil then
						local var_212_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_7.prefab_name].transform, "story_v_out_116361", "116361046", "story_v_out_116361.awb")

						arg_209_1:RecordAudio("116361046", var_212_12)
						arg_209_1:RecordAudio("116361046", var_212_12)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_116361", "116361046", "story_v_out_116361.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_116361", "116361046", "story_v_out_116361.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_13 = math.max(var_212_6, arg_209_1.talkMaxDuration)

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_13 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_5) / var_212_13

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_5 + var_212_13 and arg_209_1.time_ < var_212_5 + var_212_13 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play116361047 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 116361047
		arg_213_1.duration_ = 8.7

		local var_213_0 = {
			zh = 8.7,
			ja = 6.933
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
				arg_213_0:Play116361048(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10032ui_story"]) and arg_213_1.var_.characterEffect10032ui_story == nil then
				arg_213_1.var_.characterEffect10032ui_story = arg_213_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10032ui_story"]) then
				if arg_213_1.var_.characterEffect10032ui_story and not isNil(arg_213_1.actors_["10032ui_story"]) then
					arg_213_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10032ui_story"]) and arg_213_1.var_.characterEffect10032ui_story then
				arg_213_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 0.975

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(116361047)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 38 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_4) / 38)

				if (38 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_4) / 38)) > 0 and var_216_2 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361047", "story_v_out_116361.awb") ~= 0 then
					local var_216_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361047", "story_v_out_116361.awb") / 1000

					if var_216_7 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_1
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_116361", "116361047", "story_v_out_116361.awb")

						arg_213_1:RecordAudio("116361047", var_216_8)
						arg_213_1:RecordAudio("116361047", var_216_8)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_116361", "116361047", "story_v_out_116361.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_116361", "116361047", "story_v_out_116361.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_9 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_9 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_9

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_9 and arg_213_1.time_ < var_216_1 + var_216_9 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play116361048 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 116361048
		arg_217_1.duration_ = 10.37

		local var_217_0 = {
			zh = 6.9,
			ja = 10.366
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
				arg_217_0:Play116361049(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_220_0 = arg_217_1.actors_["10032ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10032ui_story == nil then
				arg_217_1.var_.characterEffect10032ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_1 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 and not isNil(var_220_0) then
				if arg_217_1.var_.characterEffect10032ui_story and not isNil(var_220_0) then
					arg_217_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10032ui_story then
				arg_217_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_220_3 = 0
			local var_220_4 = 0.65

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_5 = arg_217_1:GetWordFromCfg(116361048)
				local var_220_6 = arg_217_1:FormatText(var_220_5.content)

				arg_217_1.text_.text = var_220_6

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_8 = 26 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_6) / 26)

				if (26 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_6) / 26)) > 0 and var_220_4 < var_220_8 then
					arg_217_1.talkMaxDuration = var_220_8

					if var_220_8 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_3
					end
				end

				arg_217_1.text_.text = var_220_6
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361048", "story_v_out_116361.awb") ~= 0 then
					local var_220_9 = manager.audio:GetVoiceLength("story_v_out_116361", "116361048", "story_v_out_116361.awb") / 1000

					if var_220_9 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_3
					end

					if var_220_5.prefab_name ~= "" and arg_217_1.actors_[var_220_5.prefab_name] ~= nil then
						local var_220_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_5.prefab_name].transform, "story_v_out_116361", "116361048", "story_v_out_116361.awb")

						arg_217_1:RecordAudio("116361048", var_220_10)
						arg_217_1:RecordAudio("116361048", var_220_10)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_116361", "116361048", "story_v_out_116361.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_116361", "116361048", "story_v_out_116361.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_11 = math.max(var_220_4, arg_217_1.talkMaxDuration)

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_11 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_3) / var_220_11

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_3 + var_220_11 and arg_217_1.time_ < var_220_3 + var_220_11 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play116361049 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 116361049
		arg_221_1.duration_ = 8.57

		local var_221_0 = {
			zh = 8.566,
			ja = 7.2
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
				arg_221_0:Play116361050(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10032ui_story"]) and arg_221_1.var_.characterEffect10032ui_story == nil then
				arg_221_1.var_.characterEffect10032ui_story = arg_221_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10032ui_story"]) then
				if arg_221_1.var_.characterEffect10032ui_story and not isNil(arg_221_1.actors_["10032ui_story"]) then
					arg_221_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_0)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10032ui_story"]) and arg_221_1.var_.characterEffect10032ui_story then
				arg_221_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_224_1 = 0
			local var_224_2 = 0.775

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(116361049)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_6 = 31 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_4) / 31)

				if (31 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_4) / 31)) > 0 and var_224_2 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361049", "story_v_out_116361.awb") ~= 0 then
					local var_224_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361049", "story_v_out_116361.awb") / 1000

					if var_224_7 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_1
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_116361", "116361049", "story_v_out_116361.awb")

						arg_221_1:RecordAudio("116361049", var_224_8)
						arg_221_1:RecordAudio("116361049", var_224_8)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_116361", "116361049", "story_v_out_116361.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_116361", "116361049", "story_v_out_116361.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_9 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_9 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_9

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_9 and arg_221_1.time_ < var_224_1 + var_224_9 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play116361050 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 116361050
		arg_225_1.duration_ = 2.6

		local var_225_0 = {
			zh = 2.6,
			ja = 1.999999999999
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
				arg_225_0:Play116361051(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_228_0 = arg_225_1.actors_["10032ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect10032ui_story == nil then
				arg_225_1.var_.characterEffect10032ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_1 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 and not isNil(var_228_0) then
				if arg_225_1.var_.characterEffect10032ui_story and not isNil(var_228_0) then
					arg_225_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect10032ui_story then
				arg_225_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_228_3 = 0
			local var_228_4 = 0.275

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_5 = arg_225_1:GetWordFromCfg(116361050)
				local var_228_6 = arg_225_1:FormatText(var_228_5.content)

				arg_225_1.text_.text = var_228_6

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_8 = 11 <= 0 and var_228_4 or var_228_4 * (utf8.len(var_228_6) / 11)

				if (11 <= 0 and var_228_4 or var_228_4 * (utf8.len(var_228_6) / 11)) > 0 and var_228_4 < var_228_8 then
					arg_225_1.talkMaxDuration = var_228_8

					if var_228_8 + var_228_3 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_3
					end
				end

				arg_225_1.text_.text = var_228_6
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361050", "story_v_out_116361.awb") ~= 0 then
					local var_228_9 = manager.audio:GetVoiceLength("story_v_out_116361", "116361050", "story_v_out_116361.awb") / 1000

					if var_228_9 + var_228_3 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_3
					end

					if var_228_5.prefab_name ~= "" and arg_225_1.actors_[var_228_5.prefab_name] ~= nil then
						local var_228_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_5.prefab_name].transform, "story_v_out_116361", "116361050", "story_v_out_116361.awb")

						arg_225_1:RecordAudio("116361050", var_228_10)
						arg_225_1:RecordAudio("116361050", var_228_10)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_116361", "116361050", "story_v_out_116361.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_116361", "116361050", "story_v_out_116361.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_11 = math.max(var_228_4, arg_225_1.talkMaxDuration)

			if var_228_3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_3 + var_228_11 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_3) / var_228_11

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_3 + var_228_11 and arg_225_1.time_ < var_228_3 + var_228_11 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play116361051 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 116361051
		arg_229_1.duration_ = 7.23

		local var_229_0 = {
			zh = 3.666,
			ja = 7.233
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
				arg_229_0:Play116361052(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["10032ui_story"]) and arg_229_1.var_.characterEffect10032ui_story == nil then
				arg_229_1.var_.characterEffect10032ui_story = arg_229_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["10032ui_story"]) then
				if arg_229_1.var_.characterEffect10032ui_story and not isNil(arg_229_1.actors_["10032ui_story"]) then
					arg_229_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["10032ui_story"]) and arg_229_1.var_.characterEffect10032ui_story then
				arg_229_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 0.375

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(116361051)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_6 = 15 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_4) / 15)

				if (15 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_4) / 15)) > 0 and var_232_2 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361051", "story_v_out_116361.awb") ~= 0 then
					local var_232_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361051", "story_v_out_116361.awb") / 1000

					if var_232_7 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_1
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_116361", "116361051", "story_v_out_116361.awb")

						arg_229_1:RecordAudio("116361051", var_232_8)
						arg_229_1:RecordAudio("116361051", var_232_8)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_116361", "116361051", "story_v_out_116361.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_116361", "116361051", "story_v_out_116361.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_9 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_9 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_9

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_9 and arg_229_1.time_ < var_232_1 + var_232_9 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play116361052 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 116361052
		arg_233_1.duration_ = 9.97

		local var_233_0 = {
			zh = 7.666,
			ja = 9.966
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play116361053(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if arg_233_1.actors_["10024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10024ui_story"))) then
				local var_236_0 = Object.Instantiate(Asset.Load("Char/" .. "10024ui_story"), arg_233_1.stage_.transform)

				var_236_0.name = "10024ui_story"
				var_236_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["10024ui_story"] = var_236_0

				local var_236_1 = var_236_0:GetComponentInChildren(typeof(CharacterEffect))

				var_236_1.enabled = true

				local var_236_2 = GameObjectTools.GetOrAddComponent(var_236_0, typeof(DynamicBoneHelper))

				if var_236_2 then
					var_236_2:EnableDynamicBone(false)
				end

				arg_233_1:ShowWeapon(var_236_1.transform, false)

				arg_233_1.var_["10024ui_story" .. "Animator"] = var_236_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_233_1.var_["10024ui_story" .. "Animator"].applyRootMotion = true
				arg_233_1.var_["10024ui_story" .. "LipSync"] = var_236_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_236_3 = 0
			local var_236_4 = 0.825

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_3 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_5 = arg_233_1:GetWordFromCfg(116361052)
				local var_236_6 = arg_233_1:FormatText(var_236_5.content)

				arg_233_1.text_.text = var_236_6

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_8 = 33 <= 0 and var_236_4 or var_236_4 * (utf8.len(var_236_6) / 33)

				if (33 <= 0 and var_236_4 or var_236_4 * (utf8.len(var_236_6) / 33)) > 0 and var_236_4 < var_236_8 then
					arg_233_1.talkMaxDuration = var_236_8

					if var_236_8 + var_236_3 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_3
					end
				end

				arg_233_1.text_.text = var_236_6
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361052", "story_v_out_116361.awb") ~= 0 then
					local var_236_9 = manager.audio:GetVoiceLength("story_v_out_116361", "116361052", "story_v_out_116361.awb") / 1000

					if var_236_9 + var_236_3 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_3
					end

					if var_236_5.prefab_name ~= "" and arg_233_1.actors_[var_236_5.prefab_name] ~= nil then
						local var_236_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_5.prefab_name].transform, "story_v_out_116361", "116361052", "story_v_out_116361.awb")

						arg_233_1:RecordAudio("116361052", var_236_10)
						arg_233_1:RecordAudio("116361052", var_236_10)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_116361", "116361052", "story_v_out_116361.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_116361", "116361052", "story_v_out_116361.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_11 = math.max(var_236_4, arg_233_1.talkMaxDuration)

			if var_236_3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_3 + var_236_11 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_3) / var_236_11

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_3 + var_236_11 and arg_233_1.time_ < var_236_3 + var_236_11 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play116361053 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 116361053
		arg_237_1.duration_ = 9.57

		local var_237_0 = {
			zh = 9.566,
			ja = 6.9
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
				arg_237_0:Play116361054(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action424")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_240_0 = arg_237_1.actors_["10032ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10032ui_story == nil then
				arg_237_1.var_.characterEffect10032ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_1 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 and not isNil(var_240_0) then
				if arg_237_1.var_.characterEffect10032ui_story and not isNil(var_240_0) then
					arg_237_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10032ui_story then
				arg_237_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_240_3 = 0
			local var_240_4 = 0.85

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_3 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_5 = arg_237_1:GetWordFromCfg(116361053)
				local var_240_6 = arg_237_1:FormatText(var_240_5.content)

				arg_237_1.text_.text = var_240_6

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_8 = 34 <= 0 and var_240_4 or var_240_4 * (utf8.len(var_240_6) / 34)

				if (34 <= 0 and var_240_4 or var_240_4 * (utf8.len(var_240_6) / 34)) > 0 and var_240_4 < var_240_8 then
					arg_237_1.talkMaxDuration = var_240_8

					if var_240_8 + var_240_3 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_3
					end
				end

				arg_237_1.text_.text = var_240_6
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361053", "story_v_out_116361.awb") ~= 0 then
					local var_240_9 = manager.audio:GetVoiceLength("story_v_out_116361", "116361053", "story_v_out_116361.awb") / 1000

					if var_240_9 + var_240_3 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_3
					end

					if var_240_5.prefab_name ~= "" and arg_237_1.actors_[var_240_5.prefab_name] ~= nil then
						local var_240_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_5.prefab_name].transform, "story_v_out_116361", "116361053", "story_v_out_116361.awb")

						arg_237_1:RecordAudio("116361053", var_240_10)
						arg_237_1:RecordAudio("116361053", var_240_10)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_116361", "116361053", "story_v_out_116361.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_116361", "116361053", "story_v_out_116361.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_11 = math.max(var_240_4, arg_237_1.talkMaxDuration)

			if var_240_3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_3 + var_240_11 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_3) / var_240_11

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_3 + var_240_11 and arg_237_1.time_ < var_240_3 + var_240_11 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play116361054 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 116361054
		arg_241_1.duration_ = 13.1

		local var_241_0 = {
			zh = 10.666,
			ja = 13.1
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
				arg_241_0:Play116361055(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10032ui_story"]) and arg_241_1.var_.characterEffect10032ui_story == nil then
				arg_241_1.var_.characterEffect10032ui_story = arg_241_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10032ui_story"]) then
				if arg_241_1.var_.characterEffect10032ui_story and not isNil(arg_241_1.actors_["10032ui_story"]) then
					arg_241_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10032ui_story"]) and arg_241_1.var_.characterEffect10032ui_story then
				arg_241_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 1.075

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(116361054)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_6 = 43 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 43)

				if (43 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 43)) > 0 and var_244_2 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361054", "story_v_out_116361.awb") ~= 0 then
					local var_244_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361054", "story_v_out_116361.awb") / 1000

					if var_244_7 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_1
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_116361", "116361054", "story_v_out_116361.awb")

						arg_241_1:RecordAudio("116361054", var_244_8)
						arg_241_1:RecordAudio("116361054", var_244_8)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_116361", "116361054", "story_v_out_116361.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_116361", "116361054", "story_v_out_116361.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_9 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_9 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_9

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_9 and arg_241_1.time_ < var_244_1 + var_244_9 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play116361055 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 116361055
		arg_245_1.duration_ = 3.57

		local var_245_0 = {
			zh = 2.533,
			ja = 3.566
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
				arg_245_0:Play116361056(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.325

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:GetWordFromCfg(116361055)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 13 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 13)

				if (13 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 13)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361055", "story_v_out_116361.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_116361", "116361055", "story_v_out_116361.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_116361", "116361055", "story_v_out_116361.awb")

						arg_245_1:RecordAudio("116361055", var_248_6)
						arg_245_1:RecordAudio("116361055", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_116361", "116361055", "story_v_out_116361.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_116361", "116361055", "story_v_out_116361.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play116361056 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 116361056
		arg_249_1.duration_ = 3.47

		local var_249_0 = {
			zh = 1.999999999999,
			ja = 3.466
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
				arg_249_0:Play116361057(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_252_0 = arg_249_1.actors_["10032ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect10032ui_story == nil then
				arg_249_1.var_.characterEffect10032ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_1 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 and not isNil(var_252_0) then
				if arg_249_1.var_.characterEffect10032ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect10032ui_story then
				arg_249_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_252_3 = 0
			local var_252_4 = 0.175

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_3 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_5 = arg_249_1:GetWordFromCfg(116361056)
				local var_252_6 = arg_249_1:FormatText(var_252_5.content)

				arg_249_1.text_.text = var_252_6

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_8 = 7 <= 0 and var_252_4 or var_252_4 * (utf8.len(var_252_6) / 7)

				if (7 <= 0 and var_252_4 or var_252_4 * (utf8.len(var_252_6) / 7)) > 0 and var_252_4 < var_252_8 then
					arg_249_1.talkMaxDuration = var_252_8

					if var_252_8 + var_252_3 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_3
					end
				end

				arg_249_1.text_.text = var_252_6
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361056", "story_v_out_116361.awb") ~= 0 then
					local var_252_9 = manager.audio:GetVoiceLength("story_v_out_116361", "116361056", "story_v_out_116361.awb") / 1000

					if var_252_9 + var_252_3 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_3
					end

					if var_252_5.prefab_name ~= "" and arg_249_1.actors_[var_252_5.prefab_name] ~= nil then
						local var_252_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_5.prefab_name].transform, "story_v_out_116361", "116361056", "story_v_out_116361.awb")

						arg_249_1:RecordAudio("116361056", var_252_10)
						arg_249_1:RecordAudio("116361056", var_252_10)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_116361", "116361056", "story_v_out_116361.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_116361", "116361056", "story_v_out_116361.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_11 = math.max(var_252_4, arg_249_1.talkMaxDuration)

			if var_252_3 <= arg_249_1.time_ and arg_249_1.time_ < var_252_3 + var_252_11 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_3) / var_252_11

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_3 + var_252_11 and arg_249_1.time_ < var_252_3 + var_252_11 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play116361057 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 116361057
		arg_253_1.duration_ = 6.7

		local var_253_0 = {
			zh = 6,
			ja = 6.7
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
				arg_253_0:Play116361058(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10032ui_story"]) and arg_253_1.var_.characterEffect10032ui_story == nil then
				arg_253_1.var_.characterEffect10032ui_story = arg_253_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10032ui_story"]) then
				if arg_253_1.var_.characterEffect10032ui_story and not isNil(arg_253_1.actors_["10032ui_story"]) then
					arg_253_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10032ui_story"]) and arg_253_1.var_.characterEffect10032ui_story then
				arg_253_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.65

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(116361057)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_6 = 26 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_4) / 26)

				if (26 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_4) / 26)) > 0 and var_256_2 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361057", "story_v_out_116361.awb") ~= 0 then
					local var_256_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361057", "story_v_out_116361.awb") / 1000

					if var_256_7 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_1
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_116361", "116361057", "story_v_out_116361.awb")

						arg_253_1:RecordAudio("116361057", var_256_8)
						arg_253_1:RecordAudio("116361057", var_256_8)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_116361", "116361057", "story_v_out_116361.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_116361", "116361057", "story_v_out_116361.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_9 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_9 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_9

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_9 and arg_253_1.time_ < var_256_1 + var_256_9 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play116361058 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 116361058
		arg_257_1.duration_ = 17.7

		local var_257_0 = {
			zh = 17.7,
			ja = 12.6
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
				arg_257_0:Play116361059(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10032ui_story = arg_257_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10032ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10032ui_story"].transform.position).z)
				arg_257_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10032ui_story"].transform.localEulerAngles = arg_257_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10032ui_story"].transform.position).z)
				arg_257_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10032ui_story"].transform.localEulerAngles = arg_257_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			local var_260_1 = 0
			local var_260_2 = 1.575

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:GetWordFromCfg(116361058)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_6 = 63 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_4) / 63)

				if (63 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_4) / 63)) > 0 and var_260_2 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361058", "story_v_out_116361.awb") ~= 0 then
					local var_260_7 = manager.audio:GetVoiceLength("story_v_out_116361", "116361058", "story_v_out_116361.awb") / 1000

					if var_260_7 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_1
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_116361", "116361058", "story_v_out_116361.awb")

						arg_257_1:RecordAudio("116361058", var_260_8)
						arg_257_1:RecordAudio("116361058", var_260_8)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_116361", "116361058", "story_v_out_116361.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_116361", "116361058", "story_v_out_116361.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_9 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_9 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_9

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_9 and arg_257_1.time_ < var_260_1 + var_260_9 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
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
	Play116361059 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 116361059
		arg_261_1.duration_ = 11.9

		local var_261_0 = {
			zh = 11.9,
			ja = 4.433
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
				arg_261_0:Play116361060(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.7

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:GetWordFromCfg(116361059)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 28 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 28)

				if (28 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 28)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361059", "story_v_out_116361.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_116361", "116361059", "story_v_out_116361.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_116361", "116361059", "story_v_out_116361.awb")

						arg_261_1:RecordAudio("116361059", var_264_6)
						arg_261_1:RecordAudio("116361059", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_116361", "116361059", "story_v_out_116361.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_116361", "116361059", "story_v_out_116361.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play116361060 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 116361060
		arg_265_1.duration_ = 7.13

		local var_265_0 = {
			zh = 5.266,
			ja = 7.133
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
			arg_265_1.auto_ = false
		end

		function arg_265_1.playNext_(arg_267_0)
			arg_265_1.onStoryFinished_()
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.425

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

				local var_268_1 = arg_265_1:GetWordFromCfg(116361060)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 17 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 17)

				if (17 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 17)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116361", "116361060", "story_v_out_116361.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_116361", "116361060", "story_v_out_116361.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_116361", "116361060", "story_v_out_116361.awb")

						arg_265_1:RecordAudio("116361060", var_268_6)
						arg_265_1:RecordAudio("116361060", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_116361", "116361060", "story_v_out_116361.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_116361", "116361060", "story_v_out_116361.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"SofdecAsset/story/story_101161201.usm",
		"TextureConfig/Background/ST15",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST03_blur",
		"TextureConfig/Background/I05",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_116361.awb"
	},
	skipMarkers = {
		116361001,
		116361005
	}
}
