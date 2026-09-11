return {
	Play322012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322012001
		arg_1_1.duration_ = 4.9

		local var_1_0 = {
			zh = 3.8,
			ja = 4.9
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
				arg_1_0:Play322012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST73a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73a")
				var_4_0.name = "ST73a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST73a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST73a

				arg_1_1.bgs_.ST73a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST73a" then
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

			local var_4_9 = "1061ui_story"

			if arg_1_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1061ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1061ui_story = var_4_13.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1061ui_story" .. "Animator"].transform, false)
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.18, -6.15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1061ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1061ui_story == nil then
				arg_1_1.var_.characterEffect1061ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1061ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1061ui_story then
				arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference")

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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2
			local var_4_26 = 0.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(322012001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 7 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 7)

				if (7 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 7)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012001", "story_v_out_322012.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_322012", "322012001", "story_v_out_322012.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_322012", "322012001", "story_v_out_322012.awb")

						arg_1_1:RecordAudio("322012001", var_4_33)
						arg_1_1:RecordAudio("322012001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322012", "322012001", "story_v_out_322012.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322012", "322012001", "story_v_out_322012.awb")
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
				actorName = "1061ui_story",
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
	Play322012002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322012002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322012003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1061ui_story = arg_9_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).z)
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles = arg_9_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1061ui_story"].transform.position).z)
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1061ui_story"].transform.localEulerAngles = arg_9_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_12_1 = 0
			local var_12_2 = 1.225

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(322012002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 49 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 49)

				if (49 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 49)) > 0 and var_12_2 < var_12_5 then
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

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play322012003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322012003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play322012004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.2

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(322012003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 48 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 48)

				if (48 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 48)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play322012004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322012004
		arg_17_1.duration_ = 7.4

		local var_17_0 = {
			zh = 2.8,
			ja = 7.4
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
				arg_17_0:Play322012005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061ui_story = arg_17_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1061ui_story"].transform.position).z)
				arg_17_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1061ui_story"].transform.localEulerAngles = arg_17_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_17_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1061ui_story"].transform.position).z)
				arg_17_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1061ui_story"].transform.localEulerAngles = arg_17_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1061ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1061ui_story == nil then
				arg_17_1.var_.characterEffect1061ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1061ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1061ui_story then
				arg_17_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_20_4 = 0
			local var_20_5 = 0.35

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(322012004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 14 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 14)

				if (14 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 14)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012004", "story_v_out_322012.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012004", "story_v_out_322012.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_322012", "322012004", "story_v_out_322012.awb")

						arg_17_1:RecordAudio("322012004", var_20_11)
						arg_17_1:RecordAudio("322012004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322012", "322012004", "story_v_out_322012.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322012", "322012004", "story_v_out_322012.awb")
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
				actorName = "1061ui_story",
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
	Play322012005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322012005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322012006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1061ui_story"]) and arg_21_1.var_.characterEffect1061ui_story == nil then
				arg_21_1.var_.characterEffect1061ui_story = arg_21_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1061ui_story"]) then
				if arg_21_1.var_.characterEffect1061ui_story and not isNil(arg_21_1.actors_["1061ui_story"]) then
					arg_21_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1061ui_story"]) and arg_21_1.var_.characterEffect1061ui_story then
				arg_21_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.25

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

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(322012005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 10 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 10)

				if (10 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 10)) > 0 and var_24_2 < var_24_5 then
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
	Play322012006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322012006
		arg_25_1.duration_ = 7.63

		local var_25_0 = {
			zh = 5,
			ja = 7.633
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
				arg_25_0:Play322012007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1061ui_story"]) and arg_25_1.var_.characterEffect1061ui_story == nil then
				arg_25_1.var_.characterEffect1061ui_story = arg_25_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1061ui_story"]) then
				if arg_25_1.var_.characterEffect1061ui_story and not isNil(arg_25_1.actors_["1061ui_story"]) then
					arg_25_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1061ui_story"]) and arg_25_1.var_.characterEffect1061ui_story then
				arg_25_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_2 = 0
			local var_28_3 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(322012006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 22 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 22)

				if (22 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 22)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012006", "story_v_out_322012.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_322012", "322012006", "story_v_out_322012.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_322012", "322012006", "story_v_out_322012.awb")

						arg_25_1:RecordAudio("322012006", var_28_9)
						arg_25_1:RecordAudio("322012006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322012", "322012006", "story_v_out_322012.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322012", "322012006", "story_v_out_322012.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play322012007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322012007
		arg_29_1.duration_ = 16.9

		local var_29_0 = {
			zh = 12.6,
			ja = 16.9
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
				arg_29_0:Play322012008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "10104ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["10104ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["10104ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["10104ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["10104ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10104ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0.99, -1.12, -5.99)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["1061ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1061ui_story = var_32_5.localPosition
			end

			local var_32_6 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 then
				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_29_1.time_ - 0) / var_32_6)
				var_32_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_5.position).x, (manager.ui.mainCamera.transform.position - var_32_5.position).y, (manager.ui.mainCamera.transform.position - var_32_5.position).z)
				var_32_5.localEulerAngles.z = 0
				var_32_5.localEulerAngles.x = 0
				var_32_5.localEulerAngles = var_32_5.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_32_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_5.position).x, (manager.ui.mainCamera.transform.position - var_32_5.position).y, (manager.ui.mainCamera.transform.position - var_32_5.position).z)
				var_32_5.localEulerAngles.z = 0
				var_32_5.localEulerAngles.x = 0
				var_32_5.localEulerAngles = var_32_5.localEulerAngles
			end

			local var_32_7 = arg_29_1.actors_["10104ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect10104ui_story == nil then
				arg_29_1.var_.characterEffect10104ui_story = var_32_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_8 and not isNil(var_32_7) then
				if arg_29_1.var_.characterEffect10104ui_story and not isNil(var_32_7) then
					arg_29_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_8 and arg_29_1.time_ < 0 + var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect10104ui_story then
				arg_29_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_32_10 = arg_29_1.actors_["1061ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect1061ui_story == nil then
				arg_29_1.var_.characterEffect1061ui_story = var_32_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_11 and not isNil(var_32_10) then
				if arg_29_1.var_.characterEffect1061ui_story and not isNil(var_32_10) then
					arg_29_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_11)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_11 and arg_29_1.time_ < 0 + var_32_11 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect1061ui_story then
				arg_29_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_12 = 0
			local var_32_13 = 1.55

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(322012007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 62 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_15) / 62)

				if (62 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_15) / 62)) > 0 and var_32_13 < var_32_17 then
					arg_29_1.talkMaxDuration = var_32_17

					if var_32_17 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012007", "story_v_out_322012.awb") ~= 0 then
					local var_32_18 = manager.audio:GetVoiceLength("story_v_out_322012", "322012007", "story_v_out_322012.awb") / 1000

					if var_32_18 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_12
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_322012", "322012007", "story_v_out_322012.awb")

						arg_29_1:RecordAudio("322012007", var_32_19)
						arg_29_1:RecordAudio("322012007", var_32_19)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322012", "322012007", "story_v_out_322012.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322012", "322012007", "story_v_out_322012.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_20 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_20 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_20

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_20 and arg_29_1.time_ < var_32_12 + var_32_20 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play322012008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322012008
		arg_33_1.duration_ = 20.47

		local var_33_0 = {
			zh = 10.566,
			ja = 20.466
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
				arg_33_0:Play322012009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_0 = 0
			local var_36_1 = 1.4

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(322012008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 56 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 56)

				if (56 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 56)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012008", "story_v_out_322012.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_out_322012", "322012008", "story_v_out_322012.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_out_322012", "322012008", "story_v_out_322012.awb")

						arg_33_1:RecordAudio("322012008", var_36_7)
						arg_33_1:RecordAudio("322012008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322012", "322012008", "story_v_out_322012.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322012", "322012008", "story_v_out_322012.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322012009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322012009
		arg_37_1.duration_ = 5.33

		local var_37_0 = {
			zh = 3.8,
			ja = 5.333
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play322012010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1061ui_story = arg_37_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1061ui_story"].transform.position).z)
				arg_37_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1061ui_story"].transform.localEulerAngles = arg_37_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_37_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1061ui_story"].transform.position).z)
				arg_37_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1061ui_story"].transform.localEulerAngles = arg_37_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1061ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1061ui_story == nil then
				arg_37_1.var_.characterEffect1061ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1061ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1061ui_story then
				arg_37_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_4 = arg_37_1.actors_["10104ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10104ui_story = var_40_4.localPosition
			end

			local var_40_5 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 then
				var_40_4.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_5)
				var_40_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_4.position).x, (manager.ui.mainCamera.transform.position - var_40_4.position).y, (manager.ui.mainCamera.transform.position - var_40_4.position).z)
				var_40_4.localEulerAngles.z = 0
				var_40_4.localEulerAngles.x = 0
				var_40_4.localEulerAngles = var_40_4.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 then
				var_40_4.localPosition = Vector3.New(0, 100, 0)
				var_40_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_4.position).x, (manager.ui.mainCamera.transform.position - var_40_4.position).y, (manager.ui.mainCamera.transform.position - var_40_4.position).z)
				var_40_4.localEulerAngles.z = 0
				var_40_4.localEulerAngles.x = 0
				var_40_4.localEulerAngles = var_40_4.localEulerAngles
			end

			local var_40_6 = 0
			local var_40_7 = 0.525

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(322012009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 21 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 21)

				if (21 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 21)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012009", "story_v_out_322012.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_322012", "322012009", "story_v_out_322012.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_322012", "322012009", "story_v_out_322012.awb")

						arg_37_1:RecordAudio("322012009", var_40_13)
						arg_37_1:RecordAudio("322012009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322012", "322012009", "story_v_out_322012.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322012", "322012009", "story_v_out_322012.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play322012010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322012010
		arg_41_1.duration_ = 11.27

		local var_41_0 = {
			zh = 8.8,
			ja = 11.266
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
				arg_41_0:Play322012011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_44_0 = 0
			local var_44_1 = 0.775

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(322012010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 31 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 31)

				if (31 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 31)) > 0 and var_44_1 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012010", "story_v_out_322012.awb") ~= 0 then
					local var_44_6 = manager.audio:GetVoiceLength("story_v_out_322012", "322012010", "story_v_out_322012.awb") / 1000

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end

					if var_44_2.prefab_name ~= "" and arg_41_1.actors_[var_44_2.prefab_name] ~= nil then
						local var_44_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_2.prefab_name].transform, "story_v_out_322012", "322012010", "story_v_out_322012.awb")

						arg_41_1:RecordAudio("322012010", var_44_7)
						arg_41_1:RecordAudio("322012010", var_44_7)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322012", "322012010", "story_v_out_322012.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322012", "322012010", "story_v_out_322012.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322012011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322012011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322012012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1061ui_story = arg_45_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1061ui_story"].transform.position).z)
				arg_45_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1061ui_story"].transform.localEulerAngles = arg_45_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1061ui_story"].transform.position).z)
				arg_45_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1061ui_story"].transform.localEulerAngles = arg_45_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["10104ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10104ui_story = var_48_1.localPosition
			end

			local var_48_2 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 then
				var_48_1.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_2)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = Vector3.New(0, 100, 0)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			local var_48_3 = 0
			local var_48_4 = 1.175

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(322012011).content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 47 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 47)

				if (47 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 47)) > 0 and var_48_4 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_3
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_4, arg_45_1.talkMaxDuration)

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_3) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_3 + var_48_8 and arg_45_1.time_ < var_48_3 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322012012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322012012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322012013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.725

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

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(322012012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 69 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 69)

				if (69 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 69)) > 0 and var_52_0 < var_52_3 then
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
	Play322012013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322012013
		arg_53_1.duration_ = 14.2

		local var_53_0 = {
			zh = 12.032999999999,
			ja = 14.199999999999
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
				arg_53_0:Play322012014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.bgs_.L14f == nil then
				local var_56_0 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L14f")
				var_56_0.name = "L14f"
				var_56_0.transform.parent = arg_53_1.stage_.transform
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_.L14f = var_56_0
			end

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= 2 + arg_56_0 then
				local var_56_1 = arg_53_1.bgs_.L14f

				arg_53_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_56_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_2 = var_56_1:GetComponent("SpriteRenderer")

				if var_56_2 and var_56_2.sprite then
					local var_56_3 = 2 * (var_56_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_56_1.transform.localScale = Vector3.New(var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "L14f" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_4 = 3.999999999999

			if 3.999999999999 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
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

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_56_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_53_1.bgmTxt_.text ~= var_56_15 and arg_53_1.bgmTxt_.text ~= "" then
						if arg_53_1.bgmTxt2_.text ~= "" then
							arg_53_1.bgmTxt_.text = arg_53_1.bgmTxt2_.text
						end

						arg_53_1.bgmTxt2_.text = var_56_15

						arg_53_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_53_1.bgmTxt_.text = var_56_15
						arg_53_1.bgmTxt2_.text = var_56_15
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

			if 0.4 < arg_53_1.time_ and arg_53_1.time_ <= 0.4 + arg_56_0 then
				arg_53_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_56_18 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

				if "" ~= "" then
					if arg_53_1.bgmTxt_.text ~= var_56_18 and arg_53_1.bgmTxt_.text ~= "" then
						if arg_53_1.bgmTxt2_.text ~= "" then
							arg_53_1.bgmTxt_.text = arg_53_1.bgmTxt2_.text
						end

						arg_53_1.bgmTxt2_.text = var_56_18

						arg_53_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_53_1.bgmTxt_.text = var_56_18
						arg_53_1.bgmTxt2_.text = var_56_18
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

			if 0.1 < arg_53_1.time_ and arg_53_1.time_ <= 0.1 + arg_56_0 then
				arg_53_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.56666666666667 < arg_53_1.time_ and arg_53_1.time_ <= 1.56666666666667 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_21 = 3.999999999999
			local var_56_22 = 0.95

			if 3.999999999999 < arg_53_1.time_ and arg_53_1.time_ <= var_56_21 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_23 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_23:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_53_1.dialogCg_.alpha = arg_59_0
				end))
				var_56_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_24 = arg_53_1:GetWordFromCfg(322012013)
				local var_56_25 = arg_53_1:FormatText(var_56_24.content)

				arg_53_1.text_.text = var_56_25

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_27 = 38 <= 0 and var_56_22 or var_56_22 * (utf8.len(var_56_25) / 38)

				if (38 <= 0 and var_56_22 or var_56_22 * (utf8.len(var_56_25) / 38)) > 0 and var_56_22 < var_56_27 then
					arg_53_1.talkMaxDuration = var_56_27
					var_56_21 = var_56_21 + 0.3

					if var_56_27 + var_56_21 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_27 + var_56_21
					end
				end

				arg_53_1.text_.text = var_56_25
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012013", "story_v_out_322012.awb") ~= 0 then
					local var_56_28 = manager.audio:GetVoiceLength("story_v_out_322012", "322012013", "story_v_out_322012.awb") / 1000

					if var_56_28 + var_56_21 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_28 + var_56_21
					end

					if var_56_24.prefab_name ~= "" and arg_53_1.actors_[var_56_24.prefab_name] ~= nil then
						local var_56_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_24.prefab_name].transform, "story_v_out_322012", "322012013", "story_v_out_322012.awb")

						arg_53_1:RecordAudio("322012013", var_56_29)
						arg_53_1:RecordAudio("322012013", var_56_29)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322012", "322012013", "story_v_out_322012.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322012", "322012013", "story_v_out_322012.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_30 = var_56_21 + 0.3
			local var_56_31 = math.max(var_56_22, arg_53_1.talkMaxDuration)

			if var_56_21 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_30 + var_56_31 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_30) / var_56_31

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_30 + var_56_31 and arg_53_1.time_ < var_56_30 + var_56_31 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322012014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322012014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play322012015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(322012014).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 44 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 44)

				if (44 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 44)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play322012015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322012015
		arg_65_1.duration_ = 11.93

		local var_65_0 = {
			zh = 7.333,
			ja = 11.933
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
				arg_65_0:Play322012016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(322012015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 40 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 40)

				if (40 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 40)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012015", "story_v_out_322012.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_322012", "322012015", "story_v_out_322012.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_322012", "322012015", "story_v_out_322012.awb")

						arg_65_1:RecordAudio("322012015", var_68_6)
						arg_65_1:RecordAudio("322012015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322012", "322012015", "story_v_out_322012.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322012", "322012015", "story_v_out_322012.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play322012016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322012016
		arg_69_1.duration_ = 10.77

		local var_69_0 = {
			zh = 7.833,
			ja = 10.766
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
				arg_69_0:Play322012017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.025

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(322012016)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 41 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 41)

				if (41 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 41)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012016", "story_v_out_322012.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_322012", "322012016", "story_v_out_322012.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_322012", "322012016", "story_v_out_322012.awb")

						arg_69_1:RecordAudio("322012016", var_72_6)
						arg_69_1:RecordAudio("322012016", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322012", "322012016", "story_v_out_322012.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322012", "322012016", "story_v_out_322012.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play322012017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322012017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play322012018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0.1 < arg_73_1.time_ and arg_73_1.time_ <= 0.1 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_145", "se_story_145_footstep", "")
			end

			local var_76_1 = 0
			local var_76_2 = 1.3

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

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(322012017).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 52 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 52)

				if (52 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 52)) > 0 and var_76_2 < var_76_5 then
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
	Play322012018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322012018
		arg_77_1.duration_ = 13.1

		local var_77_0 = {
			zh = 13.1000000029802,
			ja = 11.9330000029802
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
				arg_77_0:Play322012019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.bgs_.L15 == nil then
				local var_80_0 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15")
				var_80_0.name = "L15"
				var_80_0.transform.parent = arg_77_1.stage_.transform
				var_80_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_.L15 = var_80_0
			end

			if 2.00000000298023 < arg_77_1.time_ and arg_77_1.time_ <= 2.00000000298023 + arg_80_0 then
				local var_80_1 = arg_77_1.bgs_.L15

				arg_77_1.bgs_.L15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_80_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_2 = var_80_1:GetComponent("SpriteRenderer")

				if var_80_2 and var_80_2.sprite then
					local var_80_3 = 2 * (var_80_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_80_1.transform.localScale = Vector3.New(var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "L15" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_4 = 3.999999999999

			if 3.999999999999 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			if arg_77_1.time_ >= var_80_4 + 0.3 and arg_77_1.time_ < var_80_4 + 0.3 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			local var_80_5 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_6 = 2

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 then
				local var_80_7 = Color.New(0, 0, 0)

				var_80_7.a = Mathf.Lerp(0, 1, (arg_77_1.time_ - var_80_5) / var_80_6)
				arg_77_1.mask_.color = var_80_7
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 then
				local var_80_8 = Color.New(0, 0, 0)

				var_80_8.a = 1
				arg_77_1.mask_.color = var_80_8
			end

			local var_80_9 = 2

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_10 = 2

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 then
				local var_80_11 = Color.New(0, 0, 0)

				var_80_11.a = Mathf.Lerp(1, 0, (arg_77_1.time_ - var_80_9) / var_80_10)
				arg_77_1.mask_.color = var_80_11
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 then
				local var_80_12 = Color.New(0, 0, 0)

				arg_77_1.mask_.enabled = false
				var_80_12.a = 0
				arg_77_1.mask_.color = var_80_12
			end

			local var_80_13 = "1156ui_story"

			if arg_77_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_80_14 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_77_1.stage_.transform)

				var_80_14.name = var_80_13
				var_80_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_[var_80_13] = var_80_14

				local var_80_15 = var_80_14:GetComponentInChildren(typeof(CharacterEffect))

				var_80_15.enabled = true

				local var_80_16 = GameObjectTools.GetOrAddComponent(var_80_14, typeof(DynamicBoneHelper))

				if var_80_16 then
					var_80_16:EnableDynamicBone(false)
				end

				arg_77_1:ShowWeapon(var_80_15.transform, false)

				arg_77_1.var_[var_80_13 .. "Animator"] = var_80_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_77_1.var_[var_80_13 .. "Animator"].applyRootMotion = true
				arg_77_1.var_[var_80_13 .. "LipSync"] = var_80_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_80_17 = arg_77_1.actors_["1156ui_story"].transform

			if 3.8 < arg_77_1.time_ and arg_77_1.time_ <= 3.8 + arg_80_0 then
				arg_77_1.var_.moveOldPos1156ui_story = var_80_17.localPosition

				arg_77_1:ShowWeapon(arg_77_1.var_["1156ui_story" .. "Animator"].transform, false)
			end

			local var_80_18 = 0.001

			if 3.8 <= arg_77_1.time_ and arg_77_1.time_ < 3.8 + var_80_18 then
				var_80_17.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_77_1.time_ - 3.8) / var_80_18)
				var_80_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_17.position).x, (manager.ui.mainCamera.transform.position - var_80_17.position).y, (manager.ui.mainCamera.transform.position - var_80_17.position).z)
				var_80_17.localEulerAngles.z = 0
				var_80_17.localEulerAngles.x = 0
				var_80_17.localEulerAngles = var_80_17.localEulerAngles
			end

			if arg_77_1.time_ >= 3.8 + var_80_18 and arg_77_1.time_ < 3.8 + var_80_18 + arg_80_0 then
				var_80_17.localPosition = Vector3.New(0, -1.1, -6.18)
				var_80_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_17.position).x, (manager.ui.mainCamera.transform.position - var_80_17.position).y, (manager.ui.mainCamera.transform.position - var_80_17.position).z)
				var_80_17.localEulerAngles.z = 0
				var_80_17.localEulerAngles.x = 0
				var_80_17.localEulerAngles = var_80_17.localEulerAngles
			end

			local var_80_19 = arg_77_1.actors_["1156ui_story"]

			if 3.8 < arg_77_1.time_ and arg_77_1.time_ <= 3.8 + arg_80_0 and not isNil(var_80_19) and arg_77_1.var_.characterEffect1156ui_story == nil then
				arg_77_1.var_.characterEffect1156ui_story = var_80_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_20 = 0.200000002980232

			if 3.8 <= arg_77_1.time_ and arg_77_1.time_ < 3.8 + var_80_20 and not isNil(var_80_19) then
				if arg_77_1.var_.characterEffect1156ui_story and not isNil(var_80_19) then
					arg_77_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 3.8 + var_80_20 and arg_77_1.time_ < 3.8 + var_80_20 + arg_80_0 and not isNil(var_80_19) and arg_77_1.var_.characterEffect1156ui_story then
				arg_77_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 3.8 < arg_77_1.time_ and arg_77_1.time_ <= 3.8 + arg_80_0 then
				arg_77_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 3.8 < arg_77_1.time_ and arg_77_1.time_ <= 3.8 + arg_80_0 then
				arg_77_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_22 = 4.00000000298023
			local var_80_23 = 0.825

			if 4.00000000298023 < arg_77_1.time_ and arg_77_1.time_ <= var_80_22 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_24 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_24:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_25 = arg_77_1:GetWordFromCfg(322012018)
				local var_80_26 = arg_77_1:FormatText(var_80_25.content)

				arg_77_1.text_.text = var_80_26

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_28 = 33 <= 0 and var_80_23 or var_80_23 * (utf8.len(var_80_26) / 33)

				if (33 <= 0 and var_80_23 or var_80_23 * (utf8.len(var_80_26) / 33)) > 0 and var_80_23 < var_80_28 then
					arg_77_1.talkMaxDuration = var_80_28
					var_80_22 = var_80_22 + 0.3

					if var_80_28 + var_80_22 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_28 + var_80_22
					end
				end

				arg_77_1.text_.text = var_80_26
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012018", "story_v_out_322012.awb") ~= 0 then
					local var_80_29 = manager.audio:GetVoiceLength("story_v_out_322012", "322012018", "story_v_out_322012.awb") / 1000

					if var_80_29 + var_80_22 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_29 + var_80_22
					end

					if var_80_25.prefab_name ~= "" and arg_77_1.actors_[var_80_25.prefab_name] ~= nil then
						local var_80_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_25.prefab_name].transform, "story_v_out_322012", "322012018", "story_v_out_322012.awb")

						arg_77_1:RecordAudio("322012018", var_80_30)
						arg_77_1:RecordAudio("322012018", var_80_30)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322012", "322012018", "story_v_out_322012.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322012", "322012018", "story_v_out_322012.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_31 = var_80_22 + 0.3
			local var_80_32 = math.max(var_80_23, arg_77_1.talkMaxDuration)

			if var_80_22 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_31 + var_80_32 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_31) / var_80_32

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_31 + var_80_32 and arg_77_1.time_ < var_80_31 + var_80_32 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play322012019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322012019
		arg_83_1.duration_ = 13.37

		local var_83_0 = {
			zh = 10.6,
			ja = 13.366
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
				arg_83_0:Play322012020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action7_1")
			end

			local var_86_0 = 0
			local var_86_1 = 1.225

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(322012019)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 49 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 49)

				if (49 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 49)) > 0 and var_86_1 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012019", "story_v_out_322012.awb") ~= 0 then
					local var_86_6 = manager.audio:GetVoiceLength("story_v_out_322012", "322012019", "story_v_out_322012.awb") / 1000

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end

					if var_86_2.prefab_name ~= "" and arg_83_1.actors_[var_86_2.prefab_name] ~= nil then
						local var_86_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_2.prefab_name].transform, "story_v_out_322012", "322012019", "story_v_out_322012.awb")

						arg_83_1:RecordAudio("322012019", var_86_7)
						arg_83_1:RecordAudio("322012019", var_86_7)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322012", "322012019", "story_v_out_322012.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322012", "322012019", "story_v_out_322012.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_8 and arg_83_1.time_ < var_86_0 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play322012020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322012020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play322012021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1156ui_story = arg_87_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).z)
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles = arg_87_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).z)
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles = arg_87_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_90_1 = 0
			local var_90_2 = 0.85

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(322012020).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 34 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 34)

				if (34 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 34)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play322012021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322012021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play322012022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1.3

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(322012021).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 52 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 52)

				if (52 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 52)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play322012022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 322012022
		arg_95_1.duration_ = 14.3

		local var_95_0 = {
			zh = 11.833,
			ja = 14.3
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play322012023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1156ui_story = arg_95_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1156ui_story"].transform.position).z)
				arg_95_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1156ui_story"].transform.localEulerAngles = arg_95_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_95_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1156ui_story"].transform.position).z)
				arg_95_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1156ui_story"].transform.localEulerAngles = arg_95_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1156ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1156ui_story == nil then
				arg_95_1.var_.characterEffect1156ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1156ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1156ui_story then
				arg_95_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_98_4 = 0
			local var_98_5 = 1.325

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(322012022)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 53 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 53)

				if (53 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 53)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012022", "story_v_out_322012.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012022", "story_v_out_322012.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_322012", "322012022", "story_v_out_322012.awb")

						arg_95_1:RecordAudio("322012022", var_98_11)
						arg_95_1:RecordAudio("322012022", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_322012", "322012022", "story_v_out_322012.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_322012", "322012022", "story_v_out_322012.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play322012023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 322012023
		arg_99_1.duration_ = 11

		local var_99_0 = {
			zh = 9.866,
			ja = 11
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play322012024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(322012023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 40 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 40)

				if (40 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 40)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012023", "story_v_out_322012.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_322012", "322012023", "story_v_out_322012.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_322012", "322012023", "story_v_out_322012.awb")

						arg_99_1:RecordAudio("322012023", var_102_6)
						arg_99_1:RecordAudio("322012023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_322012", "322012023", "story_v_out_322012.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_322012", "322012023", "story_v_out_322012.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play322012024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 322012024
		arg_103_1.duration_ = 8.07

		local var_103_0 = {
			zh = 7.53300000298023,
			ja = 8.06600000298023
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play322012025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 2 < arg_103_1.time_ and arg_103_1.time_ <= 2 + arg_106_0 then
				local var_106_0 = arg_103_1.bgs_.L14f

				arg_103_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_106_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_1 = var_106_0:GetComponent("SpriteRenderer")

				if var_106_1 and var_106_1.sprite then
					local var_106_2 = 2 * (var_106_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_106_0.transform.localScale = Vector3.New(var_106_2 / var_106_1.sprite.bounds.size.y < var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x and var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x or var_106_2 / var_106_1.sprite.bounds.size.y, var_106_2 / var_106_1.sprite.bounds.size.y < var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x and var_106_2 * manager.ui.mainCameraCom_.aspect / var_106_1.sprite.bounds.size.x or var_106_2 / var_106_1.sprite.bounds.size.y, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "L14f" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_3 = 4.00000000298023

			if 4.00000000298023 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			if arg_103_1.time_ >= var_106_3 + 0.3 and arg_103_1.time_ < var_106_3 + 0.3 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			local var_106_4 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_5 = 2

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_5 then
				local var_106_6 = Color.New(0, 0, 0)

				var_106_6.a = Mathf.Lerp(0, 1, (arg_103_1.time_ - var_106_4) / var_106_5)
				arg_103_1.mask_.color = var_106_6
			end

			if arg_103_1.time_ >= var_106_4 + var_106_5 and arg_103_1.time_ < var_106_4 + var_106_5 + arg_106_0 then
				local var_106_7 = Color.New(0, 0, 0)

				var_106_7.a = 1
				arg_103_1.mask_.color = var_106_7
			end

			local var_106_8 = 2

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_9 = 2

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_9 then
				local var_106_10 = Color.New(0, 0, 0)

				var_106_10.a = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_8) / var_106_9)
				arg_103_1.mask_.color = var_106_10
			end

			if arg_103_1.time_ >= var_106_8 + var_106_9 and arg_103_1.time_ < var_106_8 + var_106_9 + arg_106_0 then
				local var_106_11 = Color.New(0, 0, 0)

				arg_103_1.mask_.enabled = false
				var_106_11.a = 0
				arg_103_1.mask_.color = var_106_11
			end

			local var_106_12 = "1085ui_story"

			if arg_103_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_106_13 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_103_1.stage_.transform)

				var_106_13.name = var_106_12
				var_106_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.actors_[var_106_12] = var_106_13

				local var_106_14 = var_106_13:GetComponentInChildren(typeof(CharacterEffect))

				var_106_14.enabled = true

				local var_106_15 = GameObjectTools.GetOrAddComponent(var_106_13, typeof(DynamicBoneHelper))

				if var_106_15 then
					var_106_15:EnableDynamicBone(false)
				end

				arg_103_1:ShowWeapon(var_106_14.transform, false)

				arg_103_1.var_[var_106_12 .. "Animator"] = var_106_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_103_1.var_[var_106_12 .. "Animator"].applyRootMotion = true
				arg_103_1.var_[var_106_12 .. "LipSync"] = var_106_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_106_16 = arg_103_1.actors_["1085ui_story"].transform

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1.var_.moveOldPos1085ui_story = var_106_16.localPosition
			end

			local var_106_17 = 0.001

			if 3.8 <= arg_103_1.time_ and arg_103_1.time_ < 3.8 + var_106_17 then
				var_106_16.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_103_1.time_ - 3.8) / var_106_17)
				var_106_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_16.position).x, (manager.ui.mainCamera.transform.position - var_106_16.position).y, (manager.ui.mainCamera.transform.position - var_106_16.position).z)
				var_106_16.localEulerAngles.z = 0
				var_106_16.localEulerAngles.x = 0
				var_106_16.localEulerAngles = var_106_16.localEulerAngles
			end

			if arg_103_1.time_ >= 3.8 + var_106_17 and arg_103_1.time_ < 3.8 + var_106_17 + arg_106_0 then
				var_106_16.localPosition = Vector3.New(0, -1.01, -5.83)
				var_106_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_16.position).x, (manager.ui.mainCamera.transform.position - var_106_16.position).y, (manager.ui.mainCamera.transform.position - var_106_16.position).z)
				var_106_16.localEulerAngles.z = 0
				var_106_16.localEulerAngles.x = 0
				var_106_16.localEulerAngles = var_106_16.localEulerAngles
			end

			local var_106_18 = arg_103_1.actors_["1085ui_story"]

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 and not isNil(var_106_18) and arg_103_1.var_.characterEffect1085ui_story == nil then
				arg_103_1.var_.characterEffect1085ui_story = var_106_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_19 = 0.200000002980232

			if 3.8 <= arg_103_1.time_ and arg_103_1.time_ < 3.8 + var_106_19 and not isNil(var_106_18) then
				if arg_103_1.var_.characterEffect1085ui_story and not isNil(var_106_18) then
					arg_103_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 3.8 + var_106_19 and arg_103_1.time_ < 3.8 + var_106_19 + arg_106_0 and not isNil(var_106_18) and arg_103_1.var_.characterEffect1085ui_story then
				arg_103_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_106_21 = arg_103_1.actors_["1156ui_story"].transform

			if 1.96599999815226 < arg_103_1.time_ and arg_103_1.time_ <= 1.96599999815226 + arg_106_0 then
				arg_103_1.var_.moveOldPos1156ui_story = var_106_21.localPosition
			end

			local var_106_22 = 0.001

			if 1.96599999815226 <= arg_103_1.time_ and arg_103_1.time_ < 1.96599999815226 + var_106_22 then
				var_106_21.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_103_1.time_ - 1.96599999815226) / var_106_22)
				var_106_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_21.position).x, (manager.ui.mainCamera.transform.position - var_106_21.position).y, (manager.ui.mainCamera.transform.position - var_106_21.position).z)
				var_106_21.localEulerAngles.z = 0
				var_106_21.localEulerAngles.x = 0
				var_106_21.localEulerAngles = var_106_21.localEulerAngles
			end

			if arg_103_1.time_ >= 1.96599999815226 + var_106_22 and arg_103_1.time_ < 1.96599999815226 + var_106_22 + arg_106_0 then
				var_106_21.localPosition = Vector3.New(0, 100, 0)
				var_106_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_21.position).x, (manager.ui.mainCamera.transform.position - var_106_21.position).y, (manager.ui.mainCamera.transform.position - var_106_21.position).z)
				var_106_21.localEulerAngles.z = 0
				var_106_21.localEulerAngles.x = 0
				var_106_21.localEulerAngles = var_106_21.localEulerAngles
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_23 = 4.00000000298023
			local var_106_24 = 0.325

			if 4.00000000298023 < arg_103_1.time_ and arg_103_1.time_ <= var_106_23 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_25 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_25:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_26 = arg_103_1:GetWordFromCfg(322012024)
				local var_106_27 = arg_103_1:FormatText(var_106_26.content)

				arg_103_1.text_.text = var_106_27

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_29 = 13 <= 0 and var_106_24 or var_106_24 * (utf8.len(var_106_27) / 13)

				if (13 <= 0 and var_106_24 or var_106_24 * (utf8.len(var_106_27) / 13)) > 0 and var_106_24 < var_106_29 then
					arg_103_1.talkMaxDuration = var_106_29
					var_106_23 = var_106_23 + 0.3

					if var_106_29 + var_106_23 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_29 + var_106_23
					end
				end

				arg_103_1.text_.text = var_106_27
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012024", "story_v_out_322012.awb") ~= 0 then
					local var_106_30 = manager.audio:GetVoiceLength("story_v_out_322012", "322012024", "story_v_out_322012.awb") / 1000

					if var_106_30 + var_106_23 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_30 + var_106_23
					end

					if var_106_26.prefab_name ~= "" and arg_103_1.actors_[var_106_26.prefab_name] ~= nil then
						local var_106_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_26.prefab_name].transform, "story_v_out_322012", "322012024", "story_v_out_322012.awb")

						arg_103_1:RecordAudio("322012024", var_106_31)
						arg_103_1:RecordAudio("322012024", var_106_31)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_322012", "322012024", "story_v_out_322012.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_322012", "322012024", "story_v_out_322012.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_32 = var_106_23 + 0.3
			local var_106_33 = math.max(var_106_24, arg_103_1.talkMaxDuration)

			if var_106_23 + 0.3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_32 + var_106_33 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_32) / var_106_33

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_32 + var_106_33 and arg_103_1.time_ < var_106_32 + var_106_33 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play322012025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322012025
		arg_109_1.duration_ = 3.83

		local var_109_0 = {
			zh = 3.833,
			ja = 3.766
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
				arg_109_0:Play322012026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1085ui_story"]) and arg_109_1.var_.characterEffect1085ui_story == nil then
				arg_109_1.var_.characterEffect1085ui_story = arg_109_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1085ui_story"]) then
				if arg_109_1.var_.characterEffect1085ui_story and not isNil(arg_109_1.actors_["1085ui_story"]) then
					arg_109_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1085ui_story"]) and arg_109_1.var_.characterEffect1085ui_story then
				arg_109_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.475

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(322012025)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 19 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 19)

				if (19 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 19)) > 0 and var_112_2 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012025", "story_v_out_322012.awb") ~= 0 then
					local var_112_7 = manager.audio:GetVoiceLength("story_v_out_322012", "322012025", "story_v_out_322012.awb") / 1000

					if var_112_7 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_1
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_322012", "322012025", "story_v_out_322012.awb")

						arg_109_1:RecordAudio("322012025", var_112_8)
						arg_109_1:RecordAudio("322012025", var_112_8)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322012", "322012025", "story_v_out_322012.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322012", "322012025", "story_v_out_322012.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_9 and arg_109_1.time_ < var_112_1 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play322012026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322012026
		arg_113_1.duration_ = 5.73

		local var_113_0 = {
			zh = 4,
			ja = 5.733
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
				arg_113_0:Play322012027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if arg_113_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_116_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_113_1.stage_.transform)

				var_116_0.name = "404001ui_story"
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["404001ui_story"] = var_116_0

				local var_116_1 = var_116_0:GetComponentInChildren(typeof(CharacterEffect))

				var_116_1.enabled = true

				local var_116_2 = GameObjectTools.GetOrAddComponent(var_116_0, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(false)
				end

				arg_113_1:ShowWeapon(var_116_1.transform, false)

				arg_113_1.var_["404001ui_story" .. "Animator"] = var_116_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_113_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_113_1.var_["404001ui_story" .. "LipSync"] = var_116_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_116_3 = arg_113_1.actors_["404001ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos404001ui_story = var_116_3.localPosition
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_113_1.time_ - 0) / var_116_4)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0.8, -1.55, -5.5)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			local var_116_5 = arg_113_1.actors_["1085ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1085ui_story = var_116_5.localPosition
			end

			local var_116_6 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 then
				var_116_5.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1085ui_story, Vector3.New(-0.75, -1.01, -5.83), (arg_113_1.time_ - 0) / var_116_6)
				var_116_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_5.position).x, (manager.ui.mainCamera.transform.position - var_116_5.position).y, (manager.ui.mainCamera.transform.position - var_116_5.position).z)
				var_116_5.localEulerAngles.z = 0
				var_116_5.localEulerAngles.x = 0
				var_116_5.localEulerAngles = var_116_5.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 then
				var_116_5.localPosition = Vector3.New(-0.75, -1.01, -5.83)
				var_116_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_5.position).x, (manager.ui.mainCamera.transform.position - var_116_5.position).y, (manager.ui.mainCamera.transform.position - var_116_5.position).z)
				var_116_5.localEulerAngles.z = 0
				var_116_5.localEulerAngles.x = 0
				var_116_5.localEulerAngles = var_116_5.localEulerAngles
			end

			local var_116_7 = arg_113_1.actors_["404001ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.characterEffect404001ui_story == nil then
				arg_113_1.var_.characterEffect404001ui_story = var_116_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_8 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_8 and not isNil(var_116_7) then
				if arg_113_1.var_.characterEffect404001ui_story and not isNil(var_116_7) then
					arg_113_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_8 and arg_113_1.time_ < 0 + var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.characterEffect404001ui_story then
				arg_113_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_116_10 = 0
			local var_116_11 = 0.45

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_12 = arg_113_1:GetWordFromCfg(322012026)
				local var_116_13 = arg_113_1:FormatText(var_116_12.content)

				arg_113_1.text_.text = var_116_13

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_15 = 18 <= 0 and var_116_11 or var_116_11 * (utf8.len(var_116_13) / 18)

				if (18 <= 0 and var_116_11 or var_116_11 * (utf8.len(var_116_13) / 18)) > 0 and var_116_11 < var_116_15 then
					arg_113_1.talkMaxDuration = var_116_15

					if var_116_15 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_15 + var_116_10
					end
				end

				arg_113_1.text_.text = var_116_13
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012026", "story_v_out_322012.awb") ~= 0 then
					local var_116_16 = manager.audio:GetVoiceLength("story_v_out_322012", "322012026", "story_v_out_322012.awb") / 1000

					if var_116_16 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_16 + var_116_10
					end

					if var_116_12.prefab_name ~= "" and arg_113_1.actors_[var_116_12.prefab_name] ~= nil then
						local var_116_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_12.prefab_name].transform, "story_v_out_322012", "322012026", "story_v_out_322012.awb")

						arg_113_1:RecordAudio("322012026", var_116_17)
						arg_113_1:RecordAudio("322012026", var_116_17)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_322012", "322012026", "story_v_out_322012.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_322012", "322012026", "story_v_out_322012.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_18 = math.max(var_116_11, arg_113_1.talkMaxDuration)

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_18 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_10) / var_116_18

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_10 + var_116_18 and arg_113_1.time_ < var_116_10 + var_116_18 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
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
	Play322012027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322012027
		arg_117_1.duration_ = 6

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322012028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_9000

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos404001ui_story = arg_117_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["404001ui_story"].transform.position).z)
				arg_117_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["404001ui_story"].transform.localEulerAngles = arg_117_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["404001ui_story"].transform.position).z)
				arg_117_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["404001ui_story"].transform.localEulerAngles = arg_117_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1085ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1085ui_story = var_120_1.localPosition
			end

			local var_120_2 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 then
				var_120_1.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_2)
				var_120_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_1.position).x, (manager.ui.mainCamera.transform.position - var_120_1.position).y, (manager.ui.mainCamera.transform.position - var_120_1.position).z)
				var_120_1.localEulerAngles.z = 0
				var_120_1.localEulerAngles.x = 0
				var_120_1.localEulerAngles = var_120_1.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 then
				var_120_1.localPosition = Vector3.New(0, 100, 0)
				var_120_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_1.position).x, (manager.ui.mainCamera.transform.position - var_120_1.position).y, (manager.ui.mainCamera.transform.position - var_120_1.position).z)
				var_120_1.localEulerAngles.z = 0
				var_120_1.localEulerAngles.x = 0
				var_120_1.localEulerAngles = var_120_1.localEulerAngles
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_truck06", "")
			end

			if 0.233333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 0.233333333333333 + arg_120_0 then
				local var_120_4 = arg_117_1.var_.effect12028

				if not arg_117_1.var_.effect12028 then
					var_120_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_120_4.name = "12028"
					arg_117_1.var_.effect12028 = var_120_4
				else
					var_120_4.transform:SetParent(var_120_9000)
				end

				var_120_4.transform.localPosition = Vector3.New(0, 0, -3.86)
				var_120_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_120_6 = arg_117_1.bgs_.L14f.transform

			if 0.233333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 0.233333333333333 + arg_120_0 then
				arg_117_1.var_.moveOldPosL14f = var_120_6.localPosition
			end

			local var_120_7 = 0.001

			if 0.233333333333333 <= arg_117_1.time_ and arg_117_1.time_ < 0.233333333333333 + var_120_7 then
				var_120_6.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPosL14f, Vector3.New(0, 1, 10), (arg_117_1.time_ - 0.233333333333333) / var_120_7)
			end

			if arg_117_1.time_ >= 0.233333333333333 + var_120_7 and arg_117_1.time_ < 0.233333333333333 + var_120_7 + arg_120_0 then
				var_120_6.localPosition = Vector3.New(0, 1, 10)
			end

			local var_120_8 = arg_117_1.bgs_.L14f.transform

			if 0.267333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 0.267333333333333 + arg_120_0 then
				arg_117_1.var_.moveOldPosL14f = var_120_8.localPosition
			end

			local var_120_9 = 0.466

			if 0.267333333333333 <= arg_117_1.time_ and arg_117_1.time_ < 0.267333333333333 + var_120_9 then
				var_120_8.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPosL14f, Vector3.New(0, 1, 8.5), (arg_117_1.time_ - 0.267333333333333) / var_120_9)
			end

			if arg_117_1.time_ >= 0.267333333333333 + var_120_9 and arg_117_1.time_ < 0.267333333333333 + var_120_9 + arg_120_0 then
				var_120_8.localPosition = Vector3.New(0, 1, 8.5)
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_10 = 1
			local var_120_11 = 1.775

			if 1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_12 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_12:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_13 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(322012027).content)

				arg_117_1.text_.text = var_120_13

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_15 = 71 <= 0 and var_120_11 or var_120_11 * (utf8.len(var_120_13) / 71)

				if (71 <= 0 and var_120_11 or var_120_11 * (utf8.len(var_120_13) / 71)) > 0 and var_120_11 < var_120_15 then
					arg_117_1.talkMaxDuration = var_120_15
					var_120_10 = var_120_10 + 0.3

					if var_120_15 + var_120_10 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_15 + var_120_10
					end
				end

				arg_117_1.text_.text = var_120_13
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = var_120_10 + 0.3
			local var_120_17 = math.max(var_120_11, arg_117_1.talkMaxDuration)

			if var_120_10 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_16) / var_120_17

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "L14f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.233333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "L14f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.466,
				className = "StoryMoveNode",
				startTime = 0.267333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play322012028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322012028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play322012029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				if arg_123_1.var_.effect12028 then
					Object.Destroy(arg_123_1.var_.effect12028)

					arg_123_1.var_.effect12028 = nil
				end
			end

			local var_126_1 = 0
			local var_126_2 = 1.425

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(322012028).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 57 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 57)

				if (57 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 57)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play322012029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322012029
		arg_127_1.duration_ = 8.1

		local var_127_0 = {
			zh = 5.7,
			ja = 8.1
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play322012030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_130_0 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_127_1.stage_.transform)

				var_130_0.name = "1043ui_story"
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["1043ui_story"] = var_130_0

				local var_130_1 = var_130_0:GetComponentInChildren(typeof(CharacterEffect))

				var_130_1.enabled = true

				local var_130_2 = GameObjectTools.GetOrAddComponent(var_130_0, typeof(DynamicBoneHelper))

				if var_130_2 then
					var_130_2:EnableDynamicBone(false)
				end

				arg_127_1:ShowWeapon(var_130_1.transform, false)

				arg_127_1.var_["1043ui_story" .. "Animator"] = var_130_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_127_1.var_["1043ui_story" .. "Animator"].applyRootMotion = true
				arg_127_1.var_["1043ui_story" .. "LipSync"] = var_130_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_130_3 = arg_127_1.actors_["1043ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1043ui_story = var_130_3.localPosition
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_3.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_127_1.time_ - 0) / var_130_4)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_3.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			local var_130_5 = arg_127_1.actors_["1043ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect1043ui_story == nil then
				arg_127_1.var_.characterEffect1043ui_story = var_130_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_6 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_6 and not isNil(var_130_5) then
				if arg_127_1.var_.characterEffect1043ui_story and not isNil(var_130_5) then
					arg_127_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_6 and arg_127_1.time_ < 0 + var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect1043ui_story then
				arg_127_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_130_8 = 0
			local var_130_9 = 0.65

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_10 = arg_127_1:GetWordFromCfg(322012029)
				local var_130_11 = arg_127_1:FormatText(var_130_10.content)

				arg_127_1.text_.text = var_130_11

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 26 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 26)

				if (26 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 26)) > 0 and var_130_9 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_11
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012029", "story_v_out_322012.awb") ~= 0 then
					local var_130_14 = manager.audio:GetVoiceLength("story_v_out_322012", "322012029", "story_v_out_322012.awb") / 1000

					if var_130_14 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_8
					end

					if var_130_10.prefab_name ~= "" and arg_127_1.actors_[var_130_10.prefab_name] ~= nil then
						local var_130_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_10.prefab_name].transform, "story_v_out_322012", "322012029", "story_v_out_322012.awb")

						arg_127_1:RecordAudio("322012029", var_130_15)
						arg_127_1:RecordAudio("322012029", var_130_15)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_322012", "322012029", "story_v_out_322012.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_322012", "322012029", "story_v_out_322012.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_16 = math.max(var_130_9, arg_127_1.talkMaxDuration)

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_16 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_8) / var_130_16

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_8 + var_130_16 and arg_127_1.time_ < var_130_8 + var_130_16 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play322012030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322012030
		arg_131_1.duration_ = 6.5

		local var_131_0 = {
			zh = 5.433,
			ja = 6.5
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play322012031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1043ui_story"]) and arg_131_1.var_.characterEffect1043ui_story == nil then
				arg_131_1.var_.characterEffect1043ui_story = arg_131_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1043ui_story"]) then
				if arg_131_1.var_.characterEffect1043ui_story and not isNil(arg_131_1.actors_["1043ui_story"]) then
					arg_131_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1043ui_story"]) and arg_131_1.var_.characterEffect1043ui_story then
				arg_131_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 0.775

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(322012030)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_6 = 31 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_4) / 31)

				if (31 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_4) / 31)) > 0 and var_134_2 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012030", "story_v_out_322012.awb") ~= 0 then
					local var_134_7 = manager.audio:GetVoiceLength("story_v_out_322012", "322012030", "story_v_out_322012.awb") / 1000

					if var_134_7 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_1
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_322012", "322012030", "story_v_out_322012.awb")

						arg_131_1:RecordAudio("322012030", var_134_8)
						arg_131_1:RecordAudio("322012030", var_134_8)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_322012", "322012030", "story_v_out_322012.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_322012", "322012030", "story_v_out_322012.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_9 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_9 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_9

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_9 and arg_131_1.time_ < var_134_1 + var_134_9 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play322012031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322012031
		arg_135_1.duration_ = 9.93

		local var_135_0 = {
			zh = 8.033,
			ja = 9.933
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play322012032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos404001ui_story = arg_135_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["404001ui_story"].transform.position).z)
				arg_135_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["404001ui_story"].transform.localEulerAngles = arg_135_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_135_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["404001ui_story"].transform.position).z)
				arg_135_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["404001ui_story"].transform.localEulerAngles = arg_135_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1043ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1043ui_story = var_138_1.localPosition
			end

			local var_138_2 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 then
				var_138_1.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1043ui_story, Vector3.New(-0.92, -1.01, -5.73), (arg_135_1.time_ - 0) / var_138_2)
				var_138_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_1.position).x, (manager.ui.mainCamera.transform.position - var_138_1.position).y, (manager.ui.mainCamera.transform.position - var_138_1.position).z)
				var_138_1.localEulerAngles.z = 0
				var_138_1.localEulerAngles.x = 0
				var_138_1.localEulerAngles = var_138_1.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 then
				var_138_1.localPosition = Vector3.New(-0.92, -1.01, -5.73)
				var_138_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_1.position).x, (manager.ui.mainCamera.transform.position - var_138_1.position).y, (manager.ui.mainCamera.transform.position - var_138_1.position).z)
				var_138_1.localEulerAngles.z = 0
				var_138_1.localEulerAngles.x = 0
				var_138_1.localEulerAngles = var_138_1.localEulerAngles
			end

			local var_138_3 = arg_135_1.actors_["404001ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_3) and arg_135_1.var_.characterEffect404001ui_story == nil then
				arg_135_1.var_.characterEffect404001ui_story = var_138_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_4 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 and not isNil(var_138_3) then
				if arg_135_1.var_.characterEffect404001ui_story and not isNil(var_138_3) then
					arg_135_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 and not isNil(var_138_3) and arg_135_1.var_.characterEffect404001ui_story then
				arg_135_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_138_6 = 0
			local var_138_7 = 0.9

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_8 = arg_135_1:GetWordFromCfg(322012031)
				local var_138_9 = arg_135_1:FormatText(var_138_8.content)

				arg_135_1.text_.text = var_138_9

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 36 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_9) / 36)

				if (36 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_9) / 36)) > 0 and var_138_7 < var_138_11 then
					arg_135_1.talkMaxDuration = var_138_11

					if var_138_11 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_9
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012031", "story_v_out_322012.awb") ~= 0 then
					local var_138_12 = manager.audio:GetVoiceLength("story_v_out_322012", "322012031", "story_v_out_322012.awb") / 1000

					if var_138_12 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_6
					end

					if var_138_8.prefab_name ~= "" and arg_135_1.actors_[var_138_8.prefab_name] ~= nil then
						local var_138_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_8.prefab_name].transform, "story_v_out_322012", "322012031", "story_v_out_322012.awb")

						arg_135_1:RecordAudio("322012031", var_138_13)
						arg_135_1:RecordAudio("322012031", var_138_13)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_322012", "322012031", "story_v_out_322012.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_322012", "322012031", "story_v_out_322012.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_14 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_14 and arg_135_1.time_ < var_138_6 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play322012032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322012032
		arg_139_1.duration_ = 1.27

		local var_139_0 = {
			zh = 1,
			ja = 1.266
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
				arg_139_0:Play322012033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["404001ui_story"]) and arg_139_1.var_.characterEffect404001ui_story == nil then
				arg_139_1.var_.characterEffect404001ui_story = arg_139_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["404001ui_story"]) then
				if arg_139_1.var_.characterEffect404001ui_story and not isNil(arg_139_1.actors_["404001ui_story"]) then
					arg_139_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_139_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["404001ui_story"]) and arg_139_1.var_.characterEffect404001ui_story then
				arg_139_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_139_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.200000002980232

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(322012032)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 3 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 3)

				if (3 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 3)) > 0 and var_142_2 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012032", "story_v_out_322012.awb") ~= 0 then
					local var_142_7 = manager.audio:GetVoiceLength("story_v_out_322012", "322012032", "story_v_out_322012.awb") / 1000

					if var_142_7 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_1
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_322012", "322012032", "story_v_out_322012.awb")

						arg_139_1:RecordAudio("322012032", var_142_8)
						arg_139_1:RecordAudio("322012032", var_142_8)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_322012", "322012032", "story_v_out_322012.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_322012", "322012032", "story_v_out_322012.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_9 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_9 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_9

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_9 and arg_139_1.time_ < var_142_1 + var_142_9 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play322012033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322012033
		arg_143_1.duration_ = 2.3

		local var_143_0 = {
			zh = 2.3,
			ja = 2.2
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
				arg_143_0:Play322012034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["404001ui_story"]) and arg_143_1.var_.characterEffect404001ui_story == nil then
				arg_143_1.var_.characterEffect404001ui_story = arg_143_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["404001ui_story"]) then
				if arg_143_1.var_.characterEffect404001ui_story and not isNil(arg_143_1.actors_["404001ui_story"]) then
					arg_143_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["404001ui_story"]) and arg_143_1.var_.characterEffect404001ui_story then
				arg_143_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_146_2 = 0
			local var_146_3 = 0.225

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(322012033)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 9 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 9)

				if (9 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 9)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012033", "story_v_out_322012.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_322012", "322012033", "story_v_out_322012.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_322012", "322012033", "story_v_out_322012.awb")

						arg_143_1:RecordAudio("322012033", var_146_9)
						arg_143_1:RecordAudio("322012033", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_322012", "322012033", "story_v_out_322012.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_322012", "322012033", "story_v_out_322012.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play322012034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 322012034
		arg_147_1.duration_ = 3.57

		local var_147_0 = {
			zh = 3.1,
			ja = 3.566
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
				arg_147_0:Play322012035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1085ui_story = arg_147_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1085ui_story"].transform.position).z)
				arg_147_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1085ui_story"].transform.localEulerAngles = arg_147_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_147_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1085ui_story"].transform.position).z)
				arg_147_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1085ui_story"].transform.localEulerAngles = arg_147_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1043ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1043ui_story = var_150_1.localPosition
			end

			local var_150_2 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 then
				var_150_1.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1043ui_story, Vector3.New(-0.92, -1.01, -5.73), (arg_147_1.time_ - 0) / var_150_2)
				var_150_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_1.position).x, (manager.ui.mainCamera.transform.position - var_150_1.position).y, (manager.ui.mainCamera.transform.position - var_150_1.position).z)
				var_150_1.localEulerAngles.z = 0
				var_150_1.localEulerAngles.x = 0
				var_150_1.localEulerAngles = var_150_1.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 then
				var_150_1.localPosition = Vector3.New(-0.92, -1.01, -5.73)
				var_150_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_1.position).x, (manager.ui.mainCamera.transform.position - var_150_1.position).y, (manager.ui.mainCamera.transform.position - var_150_1.position).z)
				var_150_1.localEulerAngles.z = 0
				var_150_1.localEulerAngles.x = 0
				var_150_1.localEulerAngles = var_150_1.localEulerAngles
			end

			local var_150_3 = arg_147_1.actors_["1085ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_3) and arg_147_1.var_.characterEffect1085ui_story == nil then
				arg_147_1.var_.characterEffect1085ui_story = var_150_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_4 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 and not isNil(var_150_3) then
				if arg_147_1.var_.characterEffect1085ui_story and not isNil(var_150_3) then
					arg_147_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 and not isNil(var_150_3) and arg_147_1.var_.characterEffect1085ui_story then
				arg_147_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_150_6 = arg_147_1.actors_["404001ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect404001ui_story == nil then
				arg_147_1.var_.characterEffect404001ui_story = var_150_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_7 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 and not isNil(var_150_6) then
				if arg_147_1.var_.characterEffect404001ui_story and not isNil(var_150_6) then
					arg_147_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_147_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_7)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect404001ui_story then
				arg_147_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_147_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_150_8 = arg_147_1.actors_["404001ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos404001ui_story = var_150_8.localPosition
			end

			local var_150_9 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_9 then
				var_150_8.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_9)
				var_150_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_8.position).x, (manager.ui.mainCamera.transform.position - var_150_8.position).y, (manager.ui.mainCamera.transform.position - var_150_8.position).z)
				var_150_8.localEulerAngles.z = 0
				var_150_8.localEulerAngles.x = 0
				var_150_8.localEulerAngles = var_150_8.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_9 and arg_147_1.time_ < 0 + var_150_9 + arg_150_0 then
				var_150_8.localPosition = Vector3.New(0, 100, 0)
				var_150_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_8.position).x, (manager.ui.mainCamera.transform.position - var_150_8.position).y, (manager.ui.mainCamera.transform.position - var_150_8.position).z)
				var_150_8.localEulerAngles.z = 0
				var_150_8.localEulerAngles.x = 0
				var_150_8.localEulerAngles = var_150_8.localEulerAngles
			end

			local var_150_10 = 0
			local var_150_11 = 0.25

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_12 = arg_147_1:GetWordFromCfg(322012034)
				local var_150_13 = arg_147_1:FormatText(var_150_12.content)

				arg_147_1.text_.text = var_150_13

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_15 = 10 <= 0 and var_150_11 or var_150_11 * (utf8.len(var_150_13) / 10)

				if (10 <= 0 and var_150_11 or var_150_11 * (utf8.len(var_150_13) / 10)) > 0 and var_150_11 < var_150_15 then
					arg_147_1.talkMaxDuration = var_150_15

					if var_150_15 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_15 + var_150_10
					end
				end

				arg_147_1.text_.text = var_150_13
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012034", "story_v_out_322012.awb") ~= 0 then
					local var_150_16 = manager.audio:GetVoiceLength("story_v_out_322012", "322012034", "story_v_out_322012.awb") / 1000

					if var_150_16 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_10
					end

					if var_150_12.prefab_name ~= "" and arg_147_1.actors_[var_150_12.prefab_name] ~= nil then
						local var_150_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_12.prefab_name].transform, "story_v_out_322012", "322012034", "story_v_out_322012.awb")

						arg_147_1:RecordAudio("322012034", var_150_17)
						arg_147_1:RecordAudio("322012034", var_150_17)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_322012", "322012034", "story_v_out_322012.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_322012", "322012034", "story_v_out_322012.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_18 = math.max(var_150_11, arg_147_1.talkMaxDuration)

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_18 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_10) / var_150_18

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_10 + var_150_18 and arg_147_1.time_ < var_150_10 + var_150_18 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
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

		arg_147_1:InitPlayNodeList()
	end,
	Play322012035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 322012035
		arg_151_1.duration_ = 1.17

		local var_151_0 = {
			zh = 0.999999999999,
			ja = 1.166
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
				arg_151_0:Play322012036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1085ui_story"]) and arg_151_1.var_.characterEffect1085ui_story == nil then
				arg_151_1.var_.characterEffect1085ui_story = arg_151_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1085ui_story"]) then
				if arg_151_1.var_.characterEffect1085ui_story and not isNil(arg_151_1.actors_["1085ui_story"]) then
					arg_151_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1085ui_story"]) and arg_151_1.var_.characterEffect1085ui_story then
				arg_151_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.05

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:GetWordFromCfg(322012035)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 2 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_4) / 2)

				if (2 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_4) / 2)) > 0 and var_154_2 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012035", "story_v_out_322012.awb") ~= 0 then
					local var_154_7 = manager.audio:GetVoiceLength("story_v_out_322012", "322012035", "story_v_out_322012.awb") / 1000

					if var_154_7 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_1
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_322012", "322012035", "story_v_out_322012.awb")

						arg_151_1:RecordAudio("322012035", var_154_8)
						arg_151_1:RecordAudio("322012035", var_154_8)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_322012", "322012035", "story_v_out_322012.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_322012", "322012035", "story_v_out_322012.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_9 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_9 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_9

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_9 and arg_151_1.time_ < var_154_1 + var_154_9 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play322012036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322012036
		arg_155_1.duration_ = 5.87

		local var_155_0 = {
			zh = 3.4,
			ja = 5.866
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
				arg_155_0:Play322012037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1043ui_story"]) and arg_155_1.var_.characterEffect1043ui_story == nil then
				arg_155_1.var_.characterEffect1043ui_story = arg_155_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1043ui_story"]) then
				if arg_155_1.var_.characterEffect1043ui_story and not isNil(arg_155_1.actors_["1043ui_story"]) then
					arg_155_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1043ui_story"]) and arg_155_1.var_.characterEffect1043ui_story then
				arg_155_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_2 = 0
			local var_158_3 = 0.375

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(322012036)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 15 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 15)

				if (15 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 15)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012036", "story_v_out_322012.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_322012", "322012036", "story_v_out_322012.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_322012", "322012036", "story_v_out_322012.awb")

						arg_155_1:RecordAudio("322012036", var_158_9)
						arg_155_1:RecordAudio("322012036", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_322012", "322012036", "story_v_out_322012.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_322012", "322012036", "story_v_out_322012.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play322012037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322012037
		arg_159_1.duration_ = 8.8

		local var_159_0 = {
			zh = 8.8,
			ja = 7.866
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
				arg_159_0:Play322012038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_162_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_2 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_2

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_2
						arg_159_1.bgmTxt2_.text = var_162_2
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_162_3 = 0
			local var_162_4 = 1.025

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_5 = arg_159_1:GetWordFromCfg(322012037)
				local var_162_6 = arg_159_1:FormatText(var_162_5.content)

				arg_159_1.text_.text = var_162_6

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_8 = 41 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_6) / 41)

				if (41 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_6) / 41)) > 0 and var_162_4 < var_162_8 then
					arg_159_1.talkMaxDuration = var_162_8

					if var_162_8 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_3
					end
				end

				arg_159_1.text_.text = var_162_6
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012037", "story_v_out_322012.awb") ~= 0 then
					local var_162_9 = manager.audio:GetVoiceLength("story_v_out_322012", "322012037", "story_v_out_322012.awb") / 1000

					if var_162_9 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_3
					end

					if var_162_5.prefab_name ~= "" and arg_159_1.actors_[var_162_5.prefab_name] ~= nil then
						local var_162_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_5.prefab_name].transform, "story_v_out_322012", "322012037", "story_v_out_322012.awb")

						arg_159_1:RecordAudio("322012037", var_162_10)
						arg_159_1:RecordAudio("322012037", var_162_10)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_322012", "322012037", "story_v_out_322012.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_322012", "322012037", "story_v_out_322012.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_11 = math.max(var_162_4, arg_159_1.talkMaxDuration)

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_11 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_3) / var_162_11

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_3 + var_162_11 and arg_159_1.time_ < var_162_3 + var_162_11 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play322012038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322012038
		arg_164_1.duration_ = 6.9

		local var_164_0 = {
			zh = 6.9,
			ja = 6.866
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
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play322012039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 2 < arg_164_1.time_ and arg_164_1.time_ <= 2 + arg_167_0 then
				local var_167_0 = arg_164_1.bgs_.ST73a

				arg_164_1.bgs_.ST73a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_167_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_1 = var_167_0:GetComponent("SpriteRenderer")

				if var_167_1 and var_167_1.sprite then
					local var_167_2 = 2 * (var_167_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_167_0.transform.localScale = Vector3.New(var_167_2 / var_167_1.sprite.bounds.size.y < var_167_2 * manager.ui.mainCameraCom_.aspect / var_167_1.sprite.bounds.size.x and var_167_2 * manager.ui.mainCameraCom_.aspect / var_167_1.sprite.bounds.size.x or var_167_2 / var_167_1.sprite.bounds.size.y, var_167_2 / var_167_1.sprite.bounds.size.y < var_167_2 * manager.ui.mainCameraCom_.aspect / var_167_1.sprite.bounds.size.x and var_167_2 * manager.ui.mainCameraCom_.aspect / var_167_1.sprite.bounds.size.x or var_167_2 / var_167_1.sprite.bounds.size.y, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "ST73a" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_3 = 4

			if 4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_3 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			if arg_164_1.time_ >= var_167_3 + 0.3 and arg_164_1.time_ < var_167_3 + 0.3 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			local var_167_4 = 0

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_5 = 2

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_5 then
				local var_167_6 = Color.New(0, 0, 0)

				var_167_6.a = Mathf.Lerp(0, 1, (arg_164_1.time_ - var_167_4) / var_167_5)
				arg_164_1.mask_.color = var_167_6
			end

			if arg_164_1.time_ >= var_167_4 + var_167_5 and arg_164_1.time_ < var_167_4 + var_167_5 + arg_167_0 then
				local var_167_7 = Color.New(0, 0, 0)

				var_167_7.a = 1
				arg_164_1.mask_.color = var_167_7
			end

			local var_167_8 = 2

			if 2 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_9 = 2

			if var_167_8 <= arg_164_1.time_ and arg_164_1.time_ < var_167_8 + var_167_9 then
				local var_167_10 = Color.New(0, 0, 0)

				var_167_10.a = Mathf.Lerp(1, 0, (arg_164_1.time_ - var_167_8) / var_167_9)
				arg_164_1.mask_.color = var_167_10
			end

			if arg_164_1.time_ >= var_167_8 + var_167_9 and arg_164_1.time_ < var_167_8 + var_167_9 + arg_167_0 then
				local var_167_11 = Color.New(0, 0, 0)

				arg_164_1.mask_.enabled = false
				var_167_11.a = 0
				arg_164_1.mask_.color = var_167_11
			end

			local var_167_12 = arg_164_1.actors_["1061ui_story"].transform

			if 3.8 < arg_164_1.time_ and arg_164_1.time_ <= 3.8 + arg_167_0 then
				arg_164_1.var_.moveOldPos1061ui_story = var_167_12.localPosition
			end

			local var_167_13 = 0.001

			if 3.8 <= arg_164_1.time_ and arg_164_1.time_ < 3.8 + var_167_13 then
				var_167_12.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_164_1.time_ - 3.8) / var_167_13)
				var_167_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_12.position).x, (manager.ui.mainCamera.transform.position - var_167_12.position).y, (manager.ui.mainCamera.transform.position - var_167_12.position).z)
				var_167_12.localEulerAngles.z = 0
				var_167_12.localEulerAngles.x = 0
				var_167_12.localEulerAngles = var_167_12.localEulerAngles
			end

			if arg_164_1.time_ >= 3.8 + var_167_13 and arg_164_1.time_ < 3.8 + var_167_13 + arg_167_0 then
				var_167_12.localPosition = Vector3.New(0, -1.18, -6.15)
				var_167_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_12.position).x, (manager.ui.mainCamera.transform.position - var_167_12.position).y, (manager.ui.mainCamera.transform.position - var_167_12.position).z)
				var_167_12.localEulerAngles.z = 0
				var_167_12.localEulerAngles.x = 0
				var_167_12.localEulerAngles = var_167_12.localEulerAngles
			end

			local var_167_14 = arg_164_1.actors_["1043ui_story"].transform

			if 1.96599999815226 < arg_164_1.time_ and arg_164_1.time_ <= 1.96599999815226 + arg_167_0 then
				arg_164_1.var_.moveOldPos1043ui_story = var_167_14.localPosition
			end

			local var_167_15 = 0.001

			if 1.96599999815226 <= arg_164_1.time_ and arg_164_1.time_ < 1.96599999815226 + var_167_15 then
				var_167_14.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 1.96599999815226) / var_167_15)
				var_167_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_14.position).x, (manager.ui.mainCamera.transform.position - var_167_14.position).y, (manager.ui.mainCamera.transform.position - var_167_14.position).z)
				var_167_14.localEulerAngles.z = 0
				var_167_14.localEulerAngles.x = 0
				var_167_14.localEulerAngles = var_167_14.localEulerAngles
			end

			if arg_164_1.time_ >= 1.96599999815226 + var_167_15 and arg_164_1.time_ < 1.96599999815226 + var_167_15 + arg_167_0 then
				var_167_14.localPosition = Vector3.New(0, 100, 0)
				var_167_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_14.position).x, (manager.ui.mainCamera.transform.position - var_167_14.position).y, (manager.ui.mainCamera.transform.position - var_167_14.position).z)
				var_167_14.localEulerAngles.z = 0
				var_167_14.localEulerAngles.x = 0
				var_167_14.localEulerAngles = var_167_14.localEulerAngles
			end

			local var_167_16 = arg_164_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_164_1.time_ and arg_164_1.time_ <= 1.96599999815226 + arg_167_0 then
				arg_164_1.var_.moveOldPos1085ui_story = var_167_16.localPosition
			end

			local var_167_17 = 0.001

			if 1.96599999815226 <= arg_164_1.time_ and arg_164_1.time_ < 1.96599999815226 + var_167_17 then
				var_167_16.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 1.96599999815226) / var_167_17)
				var_167_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_16.position).x, (manager.ui.mainCamera.transform.position - var_167_16.position).y, (manager.ui.mainCamera.transform.position - var_167_16.position).z)
				var_167_16.localEulerAngles.z = 0
				var_167_16.localEulerAngles.x = 0
				var_167_16.localEulerAngles = var_167_16.localEulerAngles
			end

			if arg_164_1.time_ >= 1.96599999815226 + var_167_17 and arg_164_1.time_ < 1.96599999815226 + var_167_17 + arg_167_0 then
				var_167_16.localPosition = Vector3.New(0, 100, 0)
				var_167_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_16.position).x, (manager.ui.mainCamera.transform.position - var_167_16.position).y, (manager.ui.mainCamera.transform.position - var_167_16.position).z)
				var_167_16.localEulerAngles.z = 0
				var_167_16.localEulerAngles.x = 0
				var_167_16.localEulerAngles = var_167_16.localEulerAngles
			end

			local var_167_18 = arg_164_1.actors_["1061ui_story"]

			if 3.8 < arg_164_1.time_ and arg_164_1.time_ <= 3.8 + arg_167_0 and not isNil(var_167_18) and arg_164_1.var_.characterEffect1061ui_story == nil then
				arg_164_1.var_.characterEffect1061ui_story = var_167_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_19 = 0.200000002980232

			if 3.8 <= arg_164_1.time_ and arg_164_1.time_ < 3.8 + var_167_19 and not isNil(var_167_18) then
				if arg_164_1.var_.characterEffect1061ui_story and not isNil(var_167_18) then
					arg_164_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 3.8 + var_167_19 and arg_164_1.time_ < 3.8 + var_167_19 + arg_167_0 and not isNil(var_167_18) and arg_164_1.var_.characterEffect1061ui_story then
				arg_164_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 3.8 < arg_164_1.time_ and arg_164_1.time_ <= 3.8 + arg_167_0 then
				arg_164_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 3.8 < arg_164_1.time_ and arg_164_1.time_ <= 3.8 + arg_167_0 then
				arg_164_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_167_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_164_1.bgmTxt_.text ~= var_167_23 and arg_164_1.bgmTxt_.text ~= "" then
						if arg_164_1.bgmTxt2_.text ~= "" then
							arg_164_1.bgmTxt_.text = arg_164_1.bgmTxt2_.text
						end

						arg_164_1.bgmTxt2_.text = var_167_23

						arg_164_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_164_1.bgmTxt_.text = var_167_23
						arg_164_1.bgmTxt2_.text = var_167_23
					end

					if arg_164_1.bgmTimer then
						arg_164_1.bgmTimer:Stop()

						arg_164_1.bgmTimer = nil
					end

					if arg_164_1.settingData.show_music_name == 1 then
						arg_164_1.musicController:SetSelectedState("show")
						arg_164_1.musicAnimator_:Play("open", 0, 0)

						if arg_164_1.settingData.music_time ~= 0 then
							arg_164_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_164_1.settingData.music_time), function()
								if arg_164_1 == nil or isNil(arg_164_1.bgmTxt_) then
									return
								end

								arg_164_1.musicController:SetSelectedState("hide")
								arg_164_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_164_1.time_ and arg_164_1.time_ <= 0.433333333333333 + arg_167_0 then
				arg_164_1:AudioAction("play", "music", "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference.awb")

				local var_167_26 = manager.audio:GetAudioName("bgm_activity_4_5_story_conference", "bgm_activity_4_5_story_conference")

				if "" ~= "" then
					if arg_164_1.bgmTxt_.text ~= var_167_26 and arg_164_1.bgmTxt_.text ~= "" then
						if arg_164_1.bgmTxt2_.text ~= "" then
							arg_164_1.bgmTxt_.text = arg_164_1.bgmTxt2_.text
						end

						arg_164_1.bgmTxt2_.text = var_167_26

						arg_164_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_164_1.bgmTxt_.text = var_167_26
						arg_164_1.bgmTxt2_.text = var_167_26
					end

					if arg_164_1.bgmTimer then
						arg_164_1.bgmTimer:Stop()

						arg_164_1.bgmTimer = nil
					end

					if arg_164_1.settingData.show_music_name == 1 then
						arg_164_1.musicController:SetSelectedState("show")
						arg_164_1.musicAnimator_:Play("open", 0, 0)

						if arg_164_1.settingData.music_time ~= 0 then
							arg_164_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_164_1.settingData.music_time), function()
								if arg_164_1 == nil or isNil(arg_164_1.bgmTxt_) then
									return
								end

								arg_164_1.musicController:SetSelectedState("hide")
								arg_164_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.1 < arg_164_1.time_ and arg_164_1.time_ <= 0.1 + arg_167_0 then
				arg_164_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 1.56666666666667 < arg_164_1.time_ and arg_164_1.time_ <= 1.56666666666667 + arg_167_0 then
				arg_164_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_29 = 4
			local var_167_30 = 0.275

			if 4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_29 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_31 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_31:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_164_1.dialogCg_.alpha = arg_170_0
				end))
				var_167_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_32 = arg_164_1:GetWordFromCfg(322012038)
				local var_167_33 = arg_164_1:FormatText(var_167_32.content)

				arg_164_1.text_.text = var_167_33

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_35 = 11 <= 0 and var_167_30 or var_167_30 * (utf8.len(var_167_33) / 11)

				if (11 <= 0 and var_167_30 or var_167_30 * (utf8.len(var_167_33) / 11)) > 0 and var_167_30 < var_167_35 then
					arg_164_1.talkMaxDuration = var_167_35
					var_167_29 = var_167_29 + 0.3

					if var_167_35 + var_167_29 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_35 + var_167_29
					end
				end

				arg_164_1.text_.text = var_167_33
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012038", "story_v_out_322012.awb") ~= 0 then
					local var_167_36 = manager.audio:GetVoiceLength("story_v_out_322012", "322012038", "story_v_out_322012.awb") / 1000

					if var_167_36 + var_167_29 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_36 + var_167_29
					end

					if var_167_32.prefab_name ~= "" and arg_164_1.actors_[var_167_32.prefab_name] ~= nil then
						local var_167_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_32.prefab_name].transform, "story_v_out_322012", "322012038", "story_v_out_322012.awb")

						arg_164_1:RecordAudio("322012038", var_167_37)
						arg_164_1:RecordAudio("322012038", var_167_37)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_322012", "322012038", "story_v_out_322012.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_322012", "322012038", "story_v_out_322012.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_38 = var_167_29 + 0.3
			local var_167_39 = math.max(var_167_30, arg_164_1.talkMaxDuration)

			if var_167_29 + 0.3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_38 + var_167_39 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_38) / var_167_39

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_38 + var_167_39 and arg_164_1.time_ < var_167_38 + var_167_39 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play322012039 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 322012039
		arg_172_1.duration_ = 14.83

		local var_172_0 = {
			zh = 9.466,
			ja = 14.833
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play322012040(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 1.2

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:GetWordFromCfg(322012039)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 48 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 48)

				if (48 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 48)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012039", "story_v_out_322012.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_322012", "322012039", "story_v_out_322012.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_322012", "322012039", "story_v_out_322012.awb")

						arg_172_1:RecordAudio("322012039", var_175_6)
						arg_172_1:RecordAudio("322012039", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_322012", "322012039", "story_v_out_322012.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_322012", "322012039", "story_v_out_322012.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play322012040 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 322012040
		arg_176_1.duration_ = 16.4

		local var_176_0 = {
			zh = 11.433,
			ja = 16.4
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play322012041(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1061ui_story = arg_176_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_179_0 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 then
				arg_176_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_176_1.time_ - 0) / var_179_0)
				arg_176_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).z)
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles = arg_176_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 then
				arg_176_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_176_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1061ui_story"].transform.position).z)
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1061ui_story"].transform.localEulerAngles = arg_176_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_1 = 0
			local var_179_2 = 1.325

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_3 = arg_176_1:GetWordFromCfg(322012040)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_6 = 53 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_4) / 53)

				if (53 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_4) / 53)) > 0 and var_179_2 < var_179_6 then
					arg_176_1.talkMaxDuration = var_179_6

					if var_179_6 + var_179_1 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_6 + var_179_1
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012040", "story_v_out_322012.awb") ~= 0 then
					local var_179_7 = manager.audio:GetVoiceLength("story_v_out_322012", "322012040", "story_v_out_322012.awb") / 1000

					if var_179_7 + var_179_1 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_1
					end

					if var_179_3.prefab_name ~= "" and arg_176_1.actors_[var_179_3.prefab_name] ~= nil then
						local var_179_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_3.prefab_name].transform, "story_v_out_322012", "322012040", "story_v_out_322012.awb")

						arg_176_1:RecordAudio("322012040", var_179_8)
						arg_176_1:RecordAudio("322012040", var_179_8)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_322012", "322012040", "story_v_out_322012.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_322012", "322012040", "story_v_out_322012.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_9 = math.max(var_179_2, arg_176_1.talkMaxDuration)

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_9 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_1) / var_179_9

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_1 + var_179_9 and arg_176_1.time_ < var_179_1 + var_179_9 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play322012041 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 322012041
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play322012042(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1061ui_story"]) and arg_180_1.var_.characterEffect1061ui_story == nil then
				arg_180_1.var_.characterEffect1061ui_story = arg_180_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1061ui_story"]) then
				if arg_180_1.var_.characterEffect1061ui_story and not isNil(arg_180_1.actors_["1061ui_story"]) then
					arg_180_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1061ui_story"]) and arg_180_1.var_.characterEffect1061ui_story then
				arg_180_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_183_1 = 0
			local var_183_2 = 1.075

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_3 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(322012041).content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 43 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 43)

				if (43 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 43)) > 0 and var_183_2 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_6 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_6 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_6

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_6 and arg_180_1.time_ < var_183_1 + var_183_6 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play322012042 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 322012042
		arg_184_1.duration_ = 10.57

		local var_184_0 = {
			zh = 9.8,
			ja = 10.566
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play322012043(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1061ui_story"]) and arg_184_1.var_.characterEffect1061ui_story == nil then
				arg_184_1.var_.characterEffect1061ui_story = arg_184_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1061ui_story"]) then
				if arg_184_1.var_.characterEffect1061ui_story and not isNil(arg_184_1.actors_["1061ui_story"]) then
					arg_184_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1061ui_story"]) and arg_184_1.var_.characterEffect1061ui_story then
				arg_184_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_187_2 = 0
			local var_187_3 = 0.8

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(322012042)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 32 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 32)

				if (32 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 32)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012042", "story_v_out_322012.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_322012", "322012042", "story_v_out_322012.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_out_322012", "322012042", "story_v_out_322012.awb")

						arg_184_1:RecordAudio("322012042", var_187_9)
						arg_184_1:RecordAudio("322012042", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_322012", "322012042", "story_v_out_322012.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_322012", "322012042", "story_v_out_322012.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play322012043 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 322012043
		arg_188_1.duration_ = 6.93

		local var_188_0 = {
			zh = 4.966,
			ja = 6.933
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play322012044(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if arg_188_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_191_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_188_1.stage_.transform)

				var_191_0.name = "1211ui_story"
				var_191_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.actors_["1211ui_story"] = var_191_0

				local var_191_1 = var_191_0:GetComponentInChildren(typeof(CharacterEffect))

				var_191_1.enabled = true

				local var_191_2 = GameObjectTools.GetOrAddComponent(var_191_0, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(false)
				end

				arg_188_1:ShowWeapon(var_191_1.transform, false)

				arg_188_1.var_["1211ui_story" .. "Animator"] = var_191_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_188_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_188_1.var_["1211ui_story" .. "LipSync"] = var_191_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_191_3 = arg_188_1.actors_["1211ui_story"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1211ui_story = var_191_3.localPosition

				arg_188_1:ShowWeapon(arg_188_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_191_4 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				var_191_3.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_188_1.time_ - 0) / var_191_4)
				var_191_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_3.position).x, (manager.ui.mainCamera.transform.position - var_191_3.position).y, (manager.ui.mainCamera.transform.position - var_191_3.position).z)
				var_191_3.localEulerAngles.z = 0
				var_191_3.localEulerAngles.x = 0
				var_191_3.localEulerAngles = var_191_3.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				var_191_3.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_191_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_3.position).x, (manager.ui.mainCamera.transform.position - var_191_3.position).y, (manager.ui.mainCamera.transform.position - var_191_3.position).z)
				var_191_3.localEulerAngles.z = 0
				var_191_3.localEulerAngles.x = 0
				var_191_3.localEulerAngles = var_191_3.localEulerAngles
			end

			local var_191_5 = arg_188_1.actors_["1061ui_story"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1061ui_story = var_191_5.localPosition

				arg_188_1:ShowWeapon(arg_188_1.var_["1061ui_story" .. "Animator"].transform, false)
			end

			local var_191_6 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_6 then
				var_191_5.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_188_1.time_ - 0) / var_191_6)
				var_191_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_5.position).x, (manager.ui.mainCamera.transform.position - var_191_5.position).y, (manager.ui.mainCamera.transform.position - var_191_5.position).z)
				var_191_5.localEulerAngles.z = 0
				var_191_5.localEulerAngles.x = 0
				var_191_5.localEulerAngles = var_191_5.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_6 and arg_188_1.time_ < 0 + var_191_6 + arg_191_0 then
				var_191_5.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_191_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_5.position).x, (manager.ui.mainCamera.transform.position - var_191_5.position).y, (manager.ui.mainCamera.transform.position - var_191_5.position).z)
				var_191_5.localEulerAngles.z = 0
				var_191_5.localEulerAngles.x = 0
				var_191_5.localEulerAngles = var_191_5.localEulerAngles
			end

			local var_191_7 = arg_188_1.actors_["1211ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_7) and arg_188_1.var_.characterEffect1211ui_story == nil then
				arg_188_1.var_.characterEffect1211ui_story = var_191_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_8 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_8 and not isNil(var_191_7) then
				if arg_188_1.var_.characterEffect1211ui_story and not isNil(var_191_7) then
					arg_188_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_8 and arg_188_1.time_ < 0 + var_191_8 + arg_191_0 and not isNil(var_191_7) and arg_188_1.var_.characterEffect1211ui_story then
				arg_188_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_191_10 = arg_188_1.actors_["1061ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_10) and arg_188_1.var_.characterEffect1061ui_story == nil then
				arg_188_1.var_.characterEffect1061ui_story = var_191_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_11 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_11 and not isNil(var_191_10) then
				if arg_188_1.var_.characterEffect1061ui_story and not isNil(var_191_10) then
					arg_188_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_11)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_11 and arg_188_1.time_ < 0 + var_191_11 + arg_191_0 and not isNil(var_191_10) and arg_188_1.var_.characterEffect1061ui_story then
				arg_188_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_191_12 = 0
			local var_191_13 = 0.625

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_12 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_14 = arg_188_1:GetWordFromCfg(322012043)
				local var_191_15 = arg_188_1:FormatText(var_191_14.content)

				arg_188_1.text_.text = var_191_15

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_17 = 25 <= 0 and var_191_13 or var_191_13 * (utf8.len(var_191_15) / 25)

				if (25 <= 0 and var_191_13 or var_191_13 * (utf8.len(var_191_15) / 25)) > 0 and var_191_13 < var_191_17 then
					arg_188_1.talkMaxDuration = var_191_17

					if var_191_17 + var_191_12 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_17 + var_191_12
					end
				end

				arg_188_1.text_.text = var_191_15
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012043", "story_v_out_322012.awb") ~= 0 then
					local var_191_18 = manager.audio:GetVoiceLength("story_v_out_322012", "322012043", "story_v_out_322012.awb") / 1000

					if var_191_18 + var_191_12 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_18 + var_191_12
					end

					if var_191_14.prefab_name ~= "" and arg_188_1.actors_[var_191_14.prefab_name] ~= nil then
						local var_191_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_14.prefab_name].transform, "story_v_out_322012", "322012043", "story_v_out_322012.awb")

						arg_188_1:RecordAudio("322012043", var_191_19)
						arg_188_1:RecordAudio("322012043", var_191_19)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_322012", "322012043", "story_v_out_322012.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_322012", "322012043", "story_v_out_322012.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_20 = math.max(var_191_13, arg_188_1.talkMaxDuration)

			if var_191_12 <= arg_188_1.time_ and arg_188_1.time_ < var_191_12 + var_191_20 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_12) / var_191_20

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_12 + var_191_20 and arg_188_1.time_ < var_191_12 + var_191_20 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play322012044 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 322012044
		arg_192_1.duration_ = 3.6

		local var_192_0 = {
			zh = 3.1,
			ja = 3.6
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play322012045(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10104ui_story = arg_192_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_195_0 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 then
				arg_192_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_192_1.time_ - 0) / var_195_0)
				arg_192_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10104ui_story"].transform.position).z)
				arg_192_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["10104ui_story"].transform.localEulerAngles = arg_192_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 then
				arg_192_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_192_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10104ui_story"].transform.position).z)
				arg_192_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["10104ui_story"].transform.localEulerAngles = arg_192_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_195_1 = arg_192_1.actors_["1211ui_story"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1211ui_story = var_195_1.localPosition
			end

			local var_195_2 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_2 then
				var_195_1.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_2)
				var_195_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_1.position).x, (manager.ui.mainCamera.transform.position - var_195_1.position).y, (manager.ui.mainCamera.transform.position - var_195_1.position).z)
				var_195_1.localEulerAngles.z = 0
				var_195_1.localEulerAngles.x = 0
				var_195_1.localEulerAngles = var_195_1.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_2 and arg_192_1.time_ < 0 + var_195_2 + arg_195_0 then
				var_195_1.localPosition = Vector3.New(0, 100, 0)
				var_195_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_1.position).x, (manager.ui.mainCamera.transform.position - var_195_1.position).y, (manager.ui.mainCamera.transform.position - var_195_1.position).z)
				var_195_1.localEulerAngles.z = 0
				var_195_1.localEulerAngles.x = 0
				var_195_1.localEulerAngles = var_195_1.localEulerAngles
			end

			local var_195_3 = arg_192_1.actors_["10104ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_3) and arg_192_1.var_.characterEffect10104ui_story == nil then
				arg_192_1.var_.characterEffect10104ui_story = var_195_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_4 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 and not isNil(var_195_3) then
				if arg_192_1.var_.characterEffect10104ui_story and not isNil(var_195_3) then
					arg_192_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 and not isNil(var_195_3) and arg_192_1.var_.characterEffect10104ui_story then
				arg_192_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_195_6 = arg_192_1.actors_["1211ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_6) and arg_192_1.var_.characterEffect1211ui_story == nil then
				arg_192_1.var_.characterEffect1211ui_story = var_195_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_7 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 and not isNil(var_195_6) then
				if arg_192_1.var_.characterEffect1211ui_story and not isNil(var_195_6) then
					arg_192_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_7)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 and not isNil(var_195_6) and arg_192_1.var_.characterEffect1211ui_story then
				arg_192_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_195_8 = 0
			local var_195_9 = 0.375

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_10 = arg_192_1:GetWordFromCfg(322012044)
				local var_195_11 = arg_192_1:FormatText(var_195_10.content)

				arg_192_1.text_.text = var_195_11

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_13 = 15 <= 0 and var_195_9 or var_195_9 * (utf8.len(var_195_11) / 15)

				if (15 <= 0 and var_195_9 or var_195_9 * (utf8.len(var_195_11) / 15)) > 0 and var_195_9 < var_195_13 then
					arg_192_1.talkMaxDuration = var_195_13

					if var_195_13 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_8
					end
				end

				arg_192_1.text_.text = var_195_11
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012044", "story_v_out_322012.awb") ~= 0 then
					local var_195_14 = manager.audio:GetVoiceLength("story_v_out_322012", "322012044", "story_v_out_322012.awb") / 1000

					if var_195_14 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_14 + var_195_8
					end

					if var_195_10.prefab_name ~= "" and arg_192_1.actors_[var_195_10.prefab_name] ~= nil then
						local var_195_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_10.prefab_name].transform, "story_v_out_322012", "322012044", "story_v_out_322012.awb")

						arg_192_1:RecordAudio("322012044", var_195_15)
						arg_192_1:RecordAudio("322012044", var_195_15)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_322012", "322012044", "story_v_out_322012.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_322012", "322012044", "story_v_out_322012.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_16 = math.max(var_195_9, arg_192_1.talkMaxDuration)

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_16 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_8) / var_195_16

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_8 + var_195_16 and arg_192_1.time_ < var_195_8 + var_195_16 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play322012045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 322012045
		arg_196_1.duration_ = 17.03

		local var_196_0 = {
			zh = 11.033,
			ja = 17.033
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play322012046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1061ui_story"]) and arg_196_1.var_.characterEffect1061ui_story == nil then
				arg_196_1.var_.characterEffect1061ui_story = arg_196_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1061ui_story"]) then
				if arg_196_1.var_.characterEffect1061ui_story and not isNil(arg_196_1.actors_["1061ui_story"]) then
					arg_196_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1061ui_story"]) and arg_196_1.var_.characterEffect1061ui_story then
				arg_196_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_199_2 = arg_196_1.actors_["10104ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect10104ui_story == nil then
				arg_196_1.var_.characterEffect10104ui_story = var_199_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_3 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.characterEffect10104ui_story and not isNil(var_199_2) then
					arg_196_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_196_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_3)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect10104ui_story then
				arg_196_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_196_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_199_4 = 0
			local var_199_5 = 1.25

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_6 = arg_196_1:GetWordFromCfg(322012045)
				local var_199_7 = arg_196_1:FormatText(var_199_6.content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 50 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 50)

				if (50 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 50)) > 0 and var_199_5 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_4
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012045", "story_v_out_322012.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012045", "story_v_out_322012.awb") / 1000

					if var_199_10 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_4
					end

					if var_199_6.prefab_name ~= "" and arg_196_1.actors_[var_199_6.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_6.prefab_name].transform, "story_v_out_322012", "322012045", "story_v_out_322012.awb")

						arg_196_1:RecordAudio("322012045", var_199_11)
						arg_196_1:RecordAudio("322012045", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_322012", "322012045", "story_v_out_322012.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_322012", "322012045", "story_v_out_322012.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_5, arg_196_1.talkMaxDuration)

			if var_199_4 <= arg_196_1.time_ and arg_196_1.time_ < var_199_4 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_4) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_4 + var_199_12 and arg_196_1.time_ < var_199_4 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play322012046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 322012046
		arg_200_1.duration_ = 10.53

		local var_200_0 = {
			zh = 8.833,
			ja = 10.533
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play322012047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 1.05

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:GetWordFromCfg(322012046)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 42 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 42)

				if (42 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 42)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012046", "story_v_out_322012.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_322012", "322012046", "story_v_out_322012.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_322012", "322012046", "story_v_out_322012.awb")

						arg_200_1:RecordAudio("322012046", var_203_6)
						arg_200_1:RecordAudio("322012046", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_322012", "322012046", "story_v_out_322012.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_322012", "322012046", "story_v_out_322012.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play322012047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 322012047
		arg_204_1.duration_ = 3.33

		local var_204_0 = {
			zh = 2.5,
			ja = 3.333
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play322012048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["10104ui_story"]) and arg_204_1.var_.characterEffect10104ui_story == nil then
				arg_204_1.var_.characterEffect10104ui_story = arg_204_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["10104ui_story"]) then
				if arg_204_1.var_.characterEffect10104ui_story and not isNil(arg_204_1.actors_["10104ui_story"]) then
					arg_204_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["10104ui_story"]) and arg_204_1.var_.characterEffect10104ui_story then
				arg_204_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_207_2 = arg_204_1.actors_["1061ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect1061ui_story == nil then
				arg_204_1.var_.characterEffect1061ui_story = var_207_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_3 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.characterEffect1061ui_story and not isNil(var_207_2) then
					arg_204_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_3)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect1061ui_story then
				arg_204_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_207_4 = 0
			local var_207_5 = 0.2

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_6 = arg_204_1:GetWordFromCfg(322012047)
				local var_207_7 = arg_204_1:FormatText(var_207_6.content)

				arg_204_1.text_.text = var_207_7

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 8 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 8)

				if (8 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 8)) > 0 and var_207_5 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_4
					end
				end

				arg_204_1.text_.text = var_207_7
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012047", "story_v_out_322012.awb") ~= 0 then
					local var_207_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012047", "story_v_out_322012.awb") / 1000

					if var_207_10 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_4
					end

					if var_207_6.prefab_name ~= "" and arg_204_1.actors_[var_207_6.prefab_name] ~= nil then
						local var_207_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_6.prefab_name].transform, "story_v_out_322012", "322012047", "story_v_out_322012.awb")

						arg_204_1:RecordAudio("322012047", var_207_11)
						arg_204_1:RecordAudio("322012047", var_207_11)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_322012", "322012047", "story_v_out_322012.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_322012", "322012047", "story_v_out_322012.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_12 = math.max(var_207_5, arg_204_1.talkMaxDuration)

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_12 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_4) / var_207_12

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_4 + var_207_12 and arg_204_1.time_ < var_207_4 + var_207_12 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play322012048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 322012048
		arg_208_1.duration_ = 10.5

		local var_208_0 = {
			zh = 6.733,
			ja = 10.5
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play322012049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1061ui_story"]) and arg_208_1.var_.characterEffect1061ui_story == nil then
				arg_208_1.var_.characterEffect1061ui_story = arg_208_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1061ui_story"]) then
				if arg_208_1.var_.characterEffect1061ui_story and not isNil(arg_208_1.actors_["1061ui_story"]) then
					arg_208_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1061ui_story"]) and arg_208_1.var_.characterEffect1061ui_story then
				arg_208_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_211_2 = arg_208_1.actors_["10104ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.characterEffect10104ui_story == nil then
				arg_208_1.var_.characterEffect10104ui_story = var_211_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_3 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_3 and not isNil(var_211_2) then
				if arg_208_1.var_.characterEffect10104ui_story and not isNil(var_211_2) then
					arg_208_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_3)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_3 and arg_208_1.time_ < 0 + var_211_3 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.characterEffect10104ui_story then
				arg_208_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_211_4 = 0
			local var_211_5 = 0.575

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_6 = arg_208_1:GetWordFromCfg(322012048)
				local var_211_7 = arg_208_1:FormatText(var_211_6.content)

				arg_208_1.text_.text = var_211_7

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_9 = 23 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 23)

				if (23 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_7) / 23)) > 0 and var_211_5 < var_211_9 then
					arg_208_1.talkMaxDuration = var_211_9

					if var_211_9 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_9 + var_211_4
					end
				end

				arg_208_1.text_.text = var_211_7
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012048", "story_v_out_322012.awb") ~= 0 then
					local var_211_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012048", "story_v_out_322012.awb") / 1000

					if var_211_10 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_4
					end

					if var_211_6.prefab_name ~= "" and arg_208_1.actors_[var_211_6.prefab_name] ~= nil then
						local var_211_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_6.prefab_name].transform, "story_v_out_322012", "322012048", "story_v_out_322012.awb")

						arg_208_1:RecordAudio("322012048", var_211_11)
						arg_208_1:RecordAudio("322012048", var_211_11)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_322012", "322012048", "story_v_out_322012.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_322012", "322012048", "story_v_out_322012.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_12 = math.max(var_211_5, arg_208_1.talkMaxDuration)

			if var_211_4 <= arg_208_1.time_ and arg_208_1.time_ < var_211_4 + var_211_12 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_4) / var_211_12

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_4 + var_211_12 and arg_208_1.time_ < var_211_4 + var_211_12 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play322012049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 322012049
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play322012050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1061ui_story = arg_212_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1061ui_story"].transform.position).z)
				arg_212_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1061ui_story"].transform.localEulerAngles = arg_212_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1061ui_story"].transform.position).z)
				arg_212_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1061ui_story"].transform.localEulerAngles = arg_212_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_215_1 = arg_212_1.actors_["10104ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos10104ui_story = var_215_1.localPosition
			end

			local var_215_2 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_2 then
				var_215_1.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_2)
				var_215_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_1.position).x, (manager.ui.mainCamera.transform.position - var_215_1.position).y, (manager.ui.mainCamera.transform.position - var_215_1.position).z)
				var_215_1.localEulerAngles.z = 0
				var_215_1.localEulerAngles.x = 0
				var_215_1.localEulerAngles = var_215_1.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_2 and arg_212_1.time_ < 0 + var_215_2 + arg_215_0 then
				var_215_1.localPosition = Vector3.New(0, 100, 0)
				var_215_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_1.position).x, (manager.ui.mainCamera.transform.position - var_215_1.position).y, (manager.ui.mainCamera.transform.position - var_215_1.position).z)
				var_215_1.localEulerAngles.z = 0
				var_215_1.localEulerAngles.x = 0
				var_215_1.localEulerAngles = var_215_1.localEulerAngles
			end

			local var_215_3 = 0
			local var_215_4 = 0.925

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_3 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_5 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(322012049).content)

				arg_212_1.text_.text = var_215_5

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_7 = 37 <= 0 and var_215_4 or var_215_4 * (utf8.len(var_215_5) / 37)

				if (37 <= 0 and var_215_4 or var_215_4 * (utf8.len(var_215_5) / 37)) > 0 and var_215_4 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_3 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_3
					end
				end

				arg_212_1.text_.text = var_215_5
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_8 = math.max(var_215_4, arg_212_1.talkMaxDuration)

			if var_215_3 <= arg_212_1.time_ and arg_212_1.time_ < var_215_3 + var_215_8 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_3) / var_215_8

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_3 + var_215_8 and arg_212_1.time_ < var_215_3 + var_215_8 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play322012050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 322012050
		arg_216_1.duration_ = 2.8

		local var_216_0 = {
			zh = 2.8,
			ja = 2.666
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play322012051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1211ui_story = arg_216_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1211ui_story"].transform.position).z)
				arg_216_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1211ui_story"].transform.localEulerAngles = arg_216_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_216_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1211ui_story"].transform.position).z)
				arg_216_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1211ui_story"].transform.localEulerAngles = arg_216_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_219_1 = arg_216_1.actors_["1211ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1211ui_story == nil then
				arg_216_1.var_.characterEffect1211ui_story = var_219_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_2 and not isNil(var_219_1) then
				if arg_216_1.var_.characterEffect1211ui_story and not isNil(var_219_1) then
					arg_216_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_2 and arg_216_1.time_ < 0 + var_219_2 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1211ui_story then
				arg_216_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_219_4 = 0
			local var_219_5 = 0.3

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_6 = arg_216_1:GetWordFromCfg(322012050)
				local var_219_7 = arg_216_1:FormatText(var_219_6.content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_9 = 12 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 12)

				if (12 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 12)) > 0 and var_219_5 < var_219_9 then
					arg_216_1.talkMaxDuration = var_219_9

					if var_219_9 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_4
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012050", "story_v_out_322012.awb") ~= 0 then
					local var_219_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012050", "story_v_out_322012.awb") / 1000

					if var_219_10 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_10 + var_219_4
					end

					if var_219_6.prefab_name ~= "" and arg_216_1.actors_[var_219_6.prefab_name] ~= nil then
						local var_219_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_6.prefab_name].transform, "story_v_out_322012", "322012050", "story_v_out_322012.awb")

						arg_216_1:RecordAudio("322012050", var_219_11)
						arg_216_1:RecordAudio("322012050", var_219_11)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_322012", "322012050", "story_v_out_322012.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_322012", "322012050", "story_v_out_322012.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_12 = math.max(var_219_5, arg_216_1.talkMaxDuration)

			if var_219_4 <= arg_216_1.time_ and arg_216_1.time_ < var_219_4 + var_219_12 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_4) / var_219_12

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_4 + var_219_12 and arg_216_1.time_ < var_219_4 + var_219_12 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play322012051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 322012051
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play322012052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1211ui_story = arg_220_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1211ui_story"].transform.position).z)
				arg_220_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1211ui_story"].transform.localEulerAngles = arg_220_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_220_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1211ui_story"].transform.position).z)
				arg_220_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1211ui_story"].transform.localEulerAngles = arg_220_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_223_1 = 0
			local var_223_2 = 0.575

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_3 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(322012051).content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 21 <= 0 and var_223_2 or var_223_2 * (utf8.len(var_223_3) / 21)

				if (21 <= 0 and var_223_2 or var_223_2 * (utf8.len(var_223_3) / 21)) > 0 and var_223_2 < var_223_5 then
					arg_220_1.talkMaxDuration = var_223_5

					if var_223_5 + var_223_1 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + var_223_1
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_6 = math.max(var_223_2, arg_220_1.talkMaxDuration)

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_6 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_1) / var_223_6

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_1 + var_223_6 and arg_220_1.time_ < var_223_1 + var_223_6 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play322012052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 322012052
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play322012053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 1.6

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_1 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(322012052).content)

				arg_224_1.text_.text = var_227_1

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_3 = 64 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 64)

				if (64 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 64)) > 0 and var_227_0 < var_227_3 then
					arg_224_1.talkMaxDuration = var_227_3

					if var_227_3 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_3 + 0
					end
				end

				arg_224_1.text_.text = var_227_1
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_4 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_4

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play322012053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 322012053
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play322012054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 1.075

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_1 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(322012053).content)

				arg_228_1.text_.text = var_231_1

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_3 = 43 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 43)

				if (43 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 43)) > 0 and var_231_0 < var_231_3 then
					arg_228_1.talkMaxDuration = var_231_3

					if var_231_3 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_3 + 0
					end
				end

				arg_228_1.text_.text = var_231_1
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_4 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_4

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play322012054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 322012054
		arg_232_1.duration_ = 13.2

		local var_232_0 = {
			zh = 8.8,
			ja = 13.2
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play322012055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1061ui_story = arg_232_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1061ui_story"].transform.position).z)
				arg_232_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1061ui_story"].transform.localEulerAngles = arg_232_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_232_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1061ui_story"].transform.position).z)
				arg_232_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1061ui_story"].transform.localEulerAngles = arg_232_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["1061ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1061ui_story == nil then
				arg_232_1.var_.characterEffect1061ui_story = var_235_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_2 and not isNil(var_235_1) then
				if arg_232_1.var_.characterEffect1061ui_story and not isNil(var_235_1) then
					arg_232_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_2 and arg_232_1.time_ < 0 + var_235_2 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1061ui_story then
				arg_232_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_235_4 = 0
			local var_235_5 = 1.1

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_6 = arg_232_1:GetWordFromCfg(322012054)
				local var_235_7 = arg_232_1:FormatText(var_235_6.content)

				arg_232_1.text_.text = var_235_7

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_9 = 44 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 44)

				if (44 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 44)) > 0 and var_235_5 < var_235_9 then
					arg_232_1.talkMaxDuration = var_235_9

					if var_235_9 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_4
					end
				end

				arg_232_1.text_.text = var_235_7
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012054", "story_v_out_322012.awb") ~= 0 then
					local var_235_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012054", "story_v_out_322012.awb") / 1000

					if var_235_10 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_4
					end

					if var_235_6.prefab_name ~= "" and arg_232_1.actors_[var_235_6.prefab_name] ~= nil then
						local var_235_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_6.prefab_name].transform, "story_v_out_322012", "322012054", "story_v_out_322012.awb")

						arg_232_1:RecordAudio("322012054", var_235_11)
						arg_232_1:RecordAudio("322012054", var_235_11)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_322012", "322012054", "story_v_out_322012.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_322012", "322012054", "story_v_out_322012.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_12 = math.max(var_235_5, arg_232_1.talkMaxDuration)

			if var_235_4 <= arg_232_1.time_ and arg_232_1.time_ < var_235_4 + var_235_12 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_4) / var_235_12

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_4 + var_235_12 and arg_232_1.time_ < var_235_4 + var_235_12 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play322012055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 322012055
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play322012056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1061ui_story = arg_236_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1061ui_story"].transform.position).z)
				arg_236_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1061ui_story"].transform.localEulerAngles = arg_236_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1061ui_story"].transform.position).z)
				arg_236_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1061ui_story"].transform.localEulerAngles = arg_236_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_239_1 = 0
			local var_239_2 = 1.325

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_3 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(322012055).content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 53 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 53)

				if (53 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 53)) > 0 and var_239_2 < var_239_5 then
					arg_236_1.talkMaxDuration = var_239_5

					if var_239_5 + var_239_1 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + var_239_1
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_6 = math.max(var_239_2, arg_236_1.talkMaxDuration)

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_6 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_1) / var_239_6

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_1 + var_239_6 and arg_236_1.time_ < var_239_1 + var_239_6 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play322012056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 322012056
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play322012057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.5

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(322012056).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 20 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 20)

				if (20 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 20)) > 0 and var_243_0 < var_243_3 then
					arg_240_1.talkMaxDuration = var_243_3

					if var_243_3 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_3 + 0
					end
				end

				arg_240_1.text_.text = var_243_1
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_4 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_4

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play322012057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 322012057
		arg_244_1.duration_ = 4.27

		local var_244_0 = {
			zh = 2.933,
			ja = 4.266
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play322012058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1061ui_story = arg_244_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1061ui_story"].transform.position).z)
				arg_244_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1061ui_story"].transform.localEulerAngles = arg_244_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_244_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1061ui_story"].transform.position).z)
				arg_244_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1061ui_story"].transform.localEulerAngles = arg_244_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["1061ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1061ui_story == nil then
				arg_244_1.var_.characterEffect1061ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.characterEffect1061ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1061ui_story then
				arg_244_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_247_4 = 0
			local var_247_5 = 0.4

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_6 = arg_244_1:GetWordFromCfg(322012057)
				local var_247_7 = arg_244_1:FormatText(var_247_6.content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 16 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 16)

				if (16 <= 0 and var_247_5 or var_247_5 * (utf8.len(var_247_7) / 16)) > 0 and var_247_5 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_4
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012057", "story_v_out_322012.awb") ~= 0 then
					local var_247_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012057", "story_v_out_322012.awb") / 1000

					if var_247_10 + var_247_4 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_4
					end

					if var_247_6.prefab_name ~= "" and arg_244_1.actors_[var_247_6.prefab_name] ~= nil then
						local var_247_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_6.prefab_name].transform, "story_v_out_322012", "322012057", "story_v_out_322012.awb")

						arg_244_1:RecordAudio("322012057", var_247_11)
						arg_244_1:RecordAudio("322012057", var_247_11)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_322012", "322012057", "story_v_out_322012.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_322012", "322012057", "story_v_out_322012.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_12 = math.max(var_247_5, arg_244_1.talkMaxDuration)

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_12 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_4) / var_247_12

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_4 + var_247_12 and arg_244_1.time_ < var_247_4 + var_247_12 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play322012058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 322012058
		arg_248_1.duration_ = 15.03

		local var_248_0 = {
			zh = 10.733,
			ja = 15.033
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play322012059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_251_0 = 0
			local var_251_1 = 1.15

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_2 = arg_248_1:GetWordFromCfg(322012058)
				local var_251_3 = arg_248_1:FormatText(var_251_2.content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 46 <= 0 and var_251_1 or var_251_1 * (utf8.len(var_251_3) / 46)

				if (46 <= 0 and var_251_1 or var_251_1 * (utf8.len(var_251_3) / 46)) > 0 and var_251_1 < var_251_5 then
					arg_248_1.talkMaxDuration = var_251_5

					if var_251_5 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012058", "story_v_out_322012.awb") ~= 0 then
					local var_251_6 = manager.audio:GetVoiceLength("story_v_out_322012", "322012058", "story_v_out_322012.awb") / 1000

					if var_251_6 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_6 + var_251_0
					end

					if var_251_2.prefab_name ~= "" and arg_248_1.actors_[var_251_2.prefab_name] ~= nil then
						local var_251_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_2.prefab_name].transform, "story_v_out_322012", "322012058", "story_v_out_322012.awb")

						arg_248_1:RecordAudio("322012058", var_251_7)
						arg_248_1:RecordAudio("322012058", var_251_7)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_322012", "322012058", "story_v_out_322012.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_322012", "322012058", "story_v_out_322012.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_8 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_8 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_8

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_8 and arg_248_1.time_ < var_251_0 + var_251_8 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play322012059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 322012059
		arg_252_1.duration_ = 12.3

		local var_252_0 = {
			zh = 6.9,
			ja = 12.3
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play322012060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10104ui_story = arg_252_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_255_0 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				arg_252_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10104ui_story"].transform.position).z)
				arg_252_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10104ui_story"].transform.localEulerAngles = arg_252_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				arg_252_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_252_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10104ui_story"].transform.position).z)
				arg_252_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10104ui_story"].transform.localEulerAngles = arg_252_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_255_1 = arg_252_1.actors_["1061ui_story"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1061ui_story = var_255_1.localPosition
			end

			local var_255_2 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_2 then
				var_255_1.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_252_1.time_ - 0) / var_255_2)
				var_255_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_1.position).x, (manager.ui.mainCamera.transform.position - var_255_1.position).y, (manager.ui.mainCamera.transform.position - var_255_1.position).z)
				var_255_1.localEulerAngles.z = 0
				var_255_1.localEulerAngles.x = 0
				var_255_1.localEulerAngles = var_255_1.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_2 and arg_252_1.time_ < 0 + var_255_2 + arg_255_0 then
				var_255_1.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_255_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_1.position).x, (manager.ui.mainCamera.transform.position - var_255_1.position).y, (manager.ui.mainCamera.transform.position - var_255_1.position).z)
				var_255_1.localEulerAngles.z = 0
				var_255_1.localEulerAngles.x = 0
				var_255_1.localEulerAngles = var_255_1.localEulerAngles
			end

			local var_255_3 = arg_252_1.actors_["10104ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect10104ui_story == nil then
				arg_252_1.var_.characterEffect10104ui_story = var_255_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_4 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 and not isNil(var_255_3) then
				if arg_252_1.var_.characterEffect10104ui_story and not isNil(var_255_3) then
					arg_252_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect10104ui_story then
				arg_252_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_255_6 = arg_252_1.actors_["1061ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_6) and arg_252_1.var_.characterEffect1061ui_story == nil then
				arg_252_1.var_.characterEffect1061ui_story = var_255_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_7 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 and not isNil(var_255_6) then
				if arg_252_1.var_.characterEffect1061ui_story and not isNil(var_255_6) then
					arg_252_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_7)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 and not isNil(var_255_6) and arg_252_1.var_.characterEffect1061ui_story then
				arg_252_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_255_8 = 0
			local var_255_9 = 0.825

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_10 = arg_252_1:GetWordFromCfg(322012059)
				local var_255_11 = arg_252_1:FormatText(var_255_10.content)

				arg_252_1.text_.text = var_255_11

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_13 = 33 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 33)

				if (33 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 33)) > 0 and var_255_9 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_8
					end
				end

				arg_252_1.text_.text = var_255_11
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012059", "story_v_out_322012.awb") ~= 0 then
					local var_255_14 = manager.audio:GetVoiceLength("story_v_out_322012", "322012059", "story_v_out_322012.awb") / 1000

					if var_255_14 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_14 + var_255_8
					end

					if var_255_10.prefab_name ~= "" and arg_252_1.actors_[var_255_10.prefab_name] ~= nil then
						local var_255_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_10.prefab_name].transform, "story_v_out_322012", "322012059", "story_v_out_322012.awb")

						arg_252_1:RecordAudio("322012059", var_255_15)
						arg_252_1:RecordAudio("322012059", var_255_15)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_322012", "322012059", "story_v_out_322012.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_322012", "322012059", "story_v_out_322012.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_16 = math.max(var_255_9, arg_252_1.talkMaxDuration)

			if var_255_8 <= arg_252_1.time_ and arg_252_1.time_ < var_255_8 + var_255_16 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_8) / var_255_16

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_8 + var_255_16 and arg_252_1.time_ < var_255_8 + var_255_16 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play322012060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 322012060
		arg_256_1.duration_ = 2.07

		local var_256_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play322012061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1061ui_story"]) and arg_256_1.var_.characterEffect1061ui_story == nil then
				arg_256_1.var_.characterEffect1061ui_story = arg_256_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1061ui_story"]) then
				if arg_256_1.var_.characterEffect1061ui_story and not isNil(arg_256_1.actors_["1061ui_story"]) then
					arg_256_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1061ui_story"]) and arg_256_1.var_.characterEffect1061ui_story then
				arg_256_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_259_2 = arg_256_1.actors_["10104ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.characterEffect10104ui_story == nil then
				arg_256_1.var_.characterEffect10104ui_story = var_259_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_3 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_3 and not isNil(var_259_2) then
				if arg_256_1.var_.characterEffect10104ui_story and not isNil(var_259_2) then
					arg_256_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_256_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_3)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_3 and arg_256_1.time_ < 0 + var_259_3 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.characterEffect10104ui_story then
				arg_256_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_256_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_259_4 = 0
			local var_259_5 = 0.125

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:GetWordFromCfg(322012060)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_9 = 5 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 5)

				if (5 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 5)) > 0 and var_259_5 < var_259_9 then
					arg_256_1.talkMaxDuration = var_259_9

					if var_259_9 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_9 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012060", "story_v_out_322012.awb") ~= 0 then
					local var_259_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012060", "story_v_out_322012.awb") / 1000

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end

					if var_259_6.prefab_name ~= "" and arg_256_1.actors_[var_259_6.prefab_name] ~= nil then
						local var_259_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_6.prefab_name].transform, "story_v_out_322012", "322012060", "story_v_out_322012.awb")

						arg_256_1:RecordAudio("322012060", var_259_11)
						arg_256_1:RecordAudio("322012060", var_259_11)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_322012", "322012060", "story_v_out_322012.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_322012", "322012060", "story_v_out_322012.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_12 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_12 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_12

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_12 and arg_256_1.time_ < var_259_4 + var_259_12 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play322012061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 322012061
		arg_260_1.duration_ = 8.5

		local var_260_0 = {
			zh = 6.933,
			ja = 8.5
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play322012062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if arg_260_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_263_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_260_1.stage_.transform)

				var_263_0.name = "1284ui_story"
				var_263_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.actors_["1284ui_story"] = var_263_0

				local var_263_1 = var_263_0:GetComponentInChildren(typeof(CharacterEffect))

				var_263_1.enabled = true

				local var_263_2 = GameObjectTools.GetOrAddComponent(var_263_0, typeof(DynamicBoneHelper))

				if var_263_2 then
					var_263_2:EnableDynamicBone(false)
				end

				arg_260_1:ShowWeapon(var_263_1.transform, false)

				arg_260_1.var_["1284ui_story" .. "Animator"] = var_263_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_260_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_260_1.var_["1284ui_story" .. "LipSync"] = var_263_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_263_3 = arg_260_1.actors_["1284ui_story"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1284ui_story = var_263_3.localPosition

				arg_260_1:ShowWeapon(arg_260_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_263_4 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				var_263_3.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_260_1.time_ - 0) / var_263_4)
				var_263_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_3.position).x, (manager.ui.mainCamera.transform.position - var_263_3.position).y, (manager.ui.mainCamera.transform.position - var_263_3.position).z)
				var_263_3.localEulerAngles.z = 0
				var_263_3.localEulerAngles.x = 0
				var_263_3.localEulerAngles = var_263_3.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				var_263_3.localPosition = Vector3.New(0.7, -0.985, -6.22)
				var_263_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_3.position).x, (manager.ui.mainCamera.transform.position - var_263_3.position).y, (manager.ui.mainCamera.transform.position - var_263_3.position).z)
				var_263_3.localEulerAngles.z = 0
				var_263_3.localEulerAngles.x = 0
				var_263_3.localEulerAngles = var_263_3.localEulerAngles
			end

			local var_263_5 = arg_260_1.actors_["10104ui_story"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10104ui_story = var_263_5.localPosition
			end

			local var_263_6 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_6 then
				var_263_5.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_260_1.time_ - 0) / var_263_6)
				var_263_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_5.position).x, (manager.ui.mainCamera.transform.position - var_263_5.position).y, (manager.ui.mainCamera.transform.position - var_263_5.position).z)
				var_263_5.localEulerAngles.z = 0
				var_263_5.localEulerAngles.x = 0
				var_263_5.localEulerAngles = var_263_5.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_6 and arg_260_1.time_ < 0 + var_263_6 + arg_263_0 then
				var_263_5.localPosition = Vector3.New(0, 100, 0)
				var_263_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_5.position).x, (manager.ui.mainCamera.transform.position - var_263_5.position).y, (manager.ui.mainCamera.transform.position - var_263_5.position).z)
				var_263_5.localEulerAngles.z = 0
				var_263_5.localEulerAngles.x = 0
				var_263_5.localEulerAngles = var_263_5.localEulerAngles
			end

			local var_263_7 = arg_260_1.actors_["1284ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_7) and arg_260_1.var_.characterEffect1284ui_story == nil then
				arg_260_1.var_.characterEffect1284ui_story = var_263_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_8 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_8 and not isNil(var_263_7) then
				if arg_260_1.var_.characterEffect1284ui_story and not isNil(var_263_7) then
					arg_260_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_8 and arg_260_1.time_ < 0 + var_263_8 + arg_263_0 and not isNil(var_263_7) and arg_260_1.var_.characterEffect1284ui_story then
				arg_260_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_263_10 = arg_260_1.actors_["1061ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_10) and arg_260_1.var_.characterEffect1061ui_story == nil then
				arg_260_1.var_.characterEffect1061ui_story = var_263_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_11 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_11 and not isNil(var_263_10) then
				if arg_260_1.var_.characterEffect1061ui_story and not isNil(var_263_10) then
					arg_260_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_11)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_11 and arg_260_1.time_ < 0 + var_263_11 + arg_263_0 and not isNil(var_263_10) and arg_260_1.var_.characterEffect1061ui_story then
				arg_260_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_263_12 = 0
			local var_263_13 = 0.85

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_12 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_14 = arg_260_1:GetWordFromCfg(322012061)
				local var_263_15 = arg_260_1:FormatText(var_263_14.content)

				arg_260_1.text_.text = var_263_15

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_17 = 34 <= 0 and var_263_13 or var_263_13 * (utf8.len(var_263_15) / 34)

				if (34 <= 0 and var_263_13 or var_263_13 * (utf8.len(var_263_15) / 34)) > 0 and var_263_13 < var_263_17 then
					arg_260_1.talkMaxDuration = var_263_17

					if var_263_17 + var_263_12 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_17 + var_263_12
					end
				end

				arg_260_1.text_.text = var_263_15
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012061", "story_v_out_322012.awb") ~= 0 then
					local var_263_18 = manager.audio:GetVoiceLength("story_v_out_322012", "322012061", "story_v_out_322012.awb") / 1000

					if var_263_18 + var_263_12 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_18 + var_263_12
					end

					if var_263_14.prefab_name ~= "" and arg_260_1.actors_[var_263_14.prefab_name] ~= nil then
						local var_263_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_14.prefab_name].transform, "story_v_out_322012", "322012061", "story_v_out_322012.awb")

						arg_260_1:RecordAudio("322012061", var_263_19)
						arg_260_1:RecordAudio("322012061", var_263_19)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_322012", "322012061", "story_v_out_322012.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_322012", "322012061", "story_v_out_322012.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_20 = math.max(var_263_13, arg_260_1.talkMaxDuration)

			if var_263_12 <= arg_260_1.time_ and arg_260_1.time_ < var_263_12 + var_263_20 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_12) / var_263_20

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_12 + var_263_20 and arg_260_1.time_ < var_263_12 + var_263_20 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play322012062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 322012062
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play322012063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1284ui_story = arg_264_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_267_0 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 then
				arg_264_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_264_1.time_ - 0) / var_267_0)
				arg_264_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1284ui_story"].transform.position).z)
				arg_264_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1284ui_story"].transform.localEulerAngles = arg_264_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 then
				arg_264_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_264_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1284ui_story"].transform.position).z)
				arg_264_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1284ui_story"].transform.localEulerAngles = arg_264_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_267_1 = arg_264_1.actors_["1061ui_story"].transform

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1061ui_story = var_267_1.localPosition
			end

			local var_267_2 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_2 then
				var_267_1.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_264_1.time_ - 0) / var_267_2)
				var_267_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_1.position).x, (manager.ui.mainCamera.transform.position - var_267_1.position).y, (manager.ui.mainCamera.transform.position - var_267_1.position).z)
				var_267_1.localEulerAngles.z = 0
				var_267_1.localEulerAngles.x = 0
				var_267_1.localEulerAngles = var_267_1.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_2 and arg_264_1.time_ < 0 + var_267_2 + arg_267_0 then
				var_267_1.localPosition = Vector3.New(0, 100, 0)
				var_267_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_267_1.position).x, (manager.ui.mainCamera.transform.position - var_267_1.position).y, (manager.ui.mainCamera.transform.position - var_267_1.position).z)
				var_267_1.localEulerAngles.z = 0
				var_267_1.localEulerAngles.x = 0
				var_267_1.localEulerAngles = var_267_1.localEulerAngles
			end

			local var_267_3 = 0
			local var_267_4 = 0.65

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_3 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_5 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(322012062).content)

				arg_264_1.text_.text = var_267_5

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_7 = 26 <= 0 and var_267_4 or var_267_4 * (utf8.len(var_267_5) / 26)

				if (26 <= 0 and var_267_4 or var_267_4 * (utf8.len(var_267_5) / 26)) > 0 and var_267_4 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_3 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_3
					end
				end

				arg_264_1.text_.text = var_267_5
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_8 = math.max(var_267_4, arg_264_1.talkMaxDuration)

			if var_267_3 <= arg_264_1.time_ and arg_264_1.time_ < var_267_3 + var_267_8 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_3) / var_267_8

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_3 + var_267_8 and arg_264_1.time_ < var_267_3 + var_267_8 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play322012063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 322012063
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play322012064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_271_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_268_1.bgmTxt_.text ~= var_271_2 and arg_268_1.bgmTxt_.text ~= "" then
						if arg_268_1.bgmTxt2_.text ~= "" then
							arg_268_1.bgmTxt_.text = arg_268_1.bgmTxt2_.text
						end

						arg_268_1.bgmTxt2_.text = var_271_2

						arg_268_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_268_1.bgmTxt_.text = var_271_2
						arg_268_1.bgmTxt2_.text = var_271_2
					end

					if arg_268_1.bgmTimer then
						arg_268_1.bgmTimer:Stop()

						arg_268_1.bgmTimer = nil
					end

					if arg_268_1.settingData.show_music_name == 1 then
						arg_268_1.musicController:SetSelectedState("show")
						arg_268_1.musicAnimator_:Play("open", 0, 0)

						if arg_268_1.settingData.music_time ~= 0 then
							arg_268_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_268_1.settingData.music_time), function()
								if arg_268_1 == nil or isNil(arg_268_1.bgmTxt_) then
									return
								end

								arg_268_1.musicController:SetSelectedState("hide")
								arg_268_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_271_3 = 0
			local var_271_4 = 1.225

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_3 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_5 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(322012063).content)

				arg_268_1.text_.text = var_271_5

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_7 = 49 <= 0 and var_271_4 or var_271_4 * (utf8.len(var_271_5) / 49)

				if (49 <= 0 and var_271_4 or var_271_4 * (utf8.len(var_271_5) / 49)) > 0 and var_271_4 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_3 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_3
					end
				end

				arg_268_1.text_.text = var_271_5
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_8 = math.max(var_271_4, arg_268_1.talkMaxDuration)

			if var_271_3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_3 + var_271_8 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_3) / var_271_8

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_3 + var_271_8 and arg_268_1.time_ < var_271_3 + var_271_8 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play322012064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322012064
		arg_273_1.duration_ = 3.1

		local var_273_0 = {
			zh = 3,
			ja = 3.1
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
				arg_273_0:Play322012065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10104ui_story = arg_273_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).z)
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles = arg_273_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				arg_273_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).z)
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles = arg_273_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["10104ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10104ui_story == nil then
				arg_273_1.var_.characterEffect10104ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect10104ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10104ui_story then
				arg_273_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_276_4 = 0
			local var_276_5 = 0.3

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(322012064)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 12 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 12)

				if (12 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 12)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012064", "story_v_out_322012.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012064", "story_v_out_322012.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_322012", "322012064", "story_v_out_322012.awb")

						arg_273_1:RecordAudio("322012064", var_276_11)
						arg_273_1:RecordAudio("322012064", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322012", "322012064", "story_v_out_322012.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322012", "322012064", "story_v_out_322012.awb")
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
				actorName = "10104ui_story",
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
	Play322012065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322012065
		arg_277_1.duration_ = 2.2

		local var_277_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_277_0:Play322012066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1284ui_story = arg_277_1.actors_["1284ui_story"].transform.localPosition

				arg_277_1:ShowWeapon(arg_277_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1284ui_story"].transform.position).z)
				arg_277_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1284ui_story"].transform.localEulerAngles = arg_277_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_277_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1284ui_story"].transform.position).z)
				arg_277_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1284ui_story"].transform.localEulerAngles = arg_277_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["1284ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1284ui_story == nil then
				arg_277_1.var_.characterEffect1284ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1284ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1284ui_story then
				arg_277_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_280_4 = arg_277_1.actors_["10104ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect10104ui_story == nil then
				arg_277_1.var_.characterEffect10104ui_story = var_280_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_5 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_5 and not isNil(var_280_4) then
				if arg_277_1.var_.characterEffect10104ui_story and not isNil(var_280_4) then
					arg_277_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_5)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_5 and arg_277_1.time_ < 0 + var_280_5 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect10104ui_story then
				arg_277_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_6 = 0
			local var_280_7 = 0.075

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_8 = arg_277_1:GetWordFromCfg(322012065)
				local var_280_9 = arg_277_1:FormatText(var_280_8.content)

				arg_277_1.text_.text = var_280_9

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 3 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 3)

				if (3 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 3)) > 0 and var_280_7 < var_280_11 then
					arg_277_1.talkMaxDuration = var_280_11

					if var_280_11 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_9
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012065", "story_v_out_322012.awb") ~= 0 then
					local var_280_12 = manager.audio:GetVoiceLength("story_v_out_322012", "322012065", "story_v_out_322012.awb") / 1000

					if var_280_12 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_12 + var_280_6
					end

					if var_280_8.prefab_name ~= "" and arg_277_1.actors_[var_280_8.prefab_name] ~= nil then
						local var_280_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_8.prefab_name].transform, "story_v_out_322012", "322012065", "story_v_out_322012.awb")

						arg_277_1:RecordAudio("322012065", var_280_13)
						arg_277_1:RecordAudio("322012065", var_280_13)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322012", "322012065", "story_v_out_322012.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322012", "322012065", "story_v_out_322012.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_14 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_14 and arg_277_1.time_ < var_280_6 + var_280_14 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
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

		arg_277_1:InitPlayNodeList()
	end,
	Play322012066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322012066
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322012067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10104ui_story = arg_281_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10104ui_story"].transform.position).z)
				arg_281_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10104ui_story"].transform.localEulerAngles = arg_281_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10104ui_story"].transform.position).z)
				arg_281_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10104ui_story"].transform.localEulerAngles = arg_281_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1284ui_story"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1284ui_story = var_284_1.localPosition
			end

			local var_284_2 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 then
				var_284_1.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_2)
				var_284_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_1.position).x, (manager.ui.mainCamera.transform.position - var_284_1.position).y, (manager.ui.mainCamera.transform.position - var_284_1.position).z)
				var_284_1.localEulerAngles.z = 0
				var_284_1.localEulerAngles.x = 0
				var_284_1.localEulerAngles = var_284_1.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 then
				var_284_1.localPosition = Vector3.New(0, 100, 0)
				var_284_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_1.position).x, (manager.ui.mainCamera.transform.position - var_284_1.position).y, (manager.ui.mainCamera.transform.position - var_284_1.position).z)
				var_284_1.localEulerAngles.z = 0
				var_284_1.localEulerAngles.x = 0
				var_284_1.localEulerAngles = var_284_1.localEulerAngles
			end

			local var_284_3 = 0
			local var_284_4 = 1.175

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_3 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_5 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(322012066).content)

				arg_281_1.text_.text = var_284_5

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 47 <= 0 and var_284_4 or var_284_4 * (utf8.len(var_284_5) / 47)

				if (47 <= 0 and var_284_4 or var_284_4 * (utf8.len(var_284_5) / 47)) > 0 and var_284_4 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_3 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_3
					end
				end

				arg_281_1.text_.text = var_284_5
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_4, arg_281_1.talkMaxDuration)

			if var_284_3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_3 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_3) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_3 + var_284_8 and arg_281_1.time_ < var_284_3 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_281_1:InitPlayNodeList()
	end,
	Play322012067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322012067
		arg_285_1.duration_ = 3.4

		local var_285_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322012068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10104ui_story = arg_285_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10104ui_story"].transform.position).z)
				arg_285_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10104ui_story"].transform.localEulerAngles = arg_285_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_285_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10104ui_story"].transform.position).z)
				arg_285_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10104ui_story"].transform.localEulerAngles = arg_285_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["10104ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect10104ui_story == nil then
				arg_285_1.var_.characterEffect10104ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect10104ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect10104ui_story then
				arg_285_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_288_4 = 0
			local var_288_5 = 0.2

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(322012067)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 8 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 8)

				if (8 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 8)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012067", "story_v_out_322012.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_322012", "322012067", "story_v_out_322012.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_322012", "322012067", "story_v_out_322012.awb")

						arg_285_1:RecordAudio("322012067", var_288_11)
						arg_285_1:RecordAudio("322012067", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322012", "322012067", "story_v_out_322012.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322012", "322012067", "story_v_out_322012.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play322012068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322012068
		arg_289_1.duration_ = 9.83

		local var_289_0 = {
			zh = 8.1,
			ja = 9.833
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
			arg_289_1.auto_ = false
		end

		function arg_289_1.playNext_(arg_291_0)
			arg_289_1.onStoryFinished_()
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.875

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(322012068)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 35 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 35)

				if (35 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 35)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322012", "322012068", "story_v_out_322012.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_322012", "322012068", "story_v_out_322012.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_322012", "322012068", "story_v_out_322012.awb")

						arg_289_1:RecordAudio("322012068", var_292_6)
						arg_289_1:RecordAudio("322012068", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322012", "322012068", "story_v_out_322012.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322012", "322012068", "story_v_out_322012.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST73a",
		"TextureConfig/Background/L14f",
		"TextureConfig/Background/L15"
	},
	voices = {
		"story_v_out_322012.awb"
	}
}
