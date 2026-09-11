return {
	Play319591001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319591001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319591002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I12h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I12h")
				var_4_0.name = "I12h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I12h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I12h

				arg_1_1.bgs_.I12h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I12h" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			local var_4_11 = 2
			local var_4_12 = 0.875

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319591001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 35 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 35)

				if (35 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 35)) > 0 and var_4_12 < var_4_16 then
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
	Play319591002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319591002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319591003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.8

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(319591002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 32 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 32)

				if (32 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 32)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play319591003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319591003
		arg_12_1.duration_ = 4.77

		local var_12_0 = {
			zh = 3.999999999999,
			ja = 4.766
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
				arg_12_0:Play319591004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.bgs_.A08f == nil then
				local var_15_0 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A08f")
				var_15_0.name = "A08f"
				var_15_0.transform.parent = arg_12_1.stage_.transform
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_.A08f = var_15_0
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				local var_15_1 = arg_12_1.bgs_.A08f

				arg_12_1.bgs_.A08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_15_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_2 = var_15_1:GetComponent("SpriteRenderer")

				if var_15_2 and var_15_2.sprite then
					local var_15_3 = 2 * (var_15_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_15_1.transform.localScale = Vector3.New(var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "A08f" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_4 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_5 = 2

			if var_15_4 <= arg_12_1.time_ and arg_12_1.time_ < var_15_4 + var_15_5 then
				local var_15_6 = Color.New(0, 0, 0)

				var_15_6.a = Mathf.Lerp(0, 1, (arg_12_1.time_ - var_15_4) / var_15_5)
				arg_12_1.mask_.color = var_15_6
			end

			if arg_12_1.time_ >= var_15_4 + var_15_5 and arg_12_1.time_ < var_15_4 + var_15_5 + arg_15_0 then
				local var_15_7 = Color.New(0, 0, 0)

				var_15_7.a = 1
				arg_12_1.mask_.color = var_15_7
			end

			local var_15_8 = 2

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_9 = 2

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_9 then
				local var_15_10 = Color.New(0, 0, 0)

				var_15_10.a = Mathf.Lerp(1, 0, (arg_12_1.time_ - var_15_8) / var_15_9)
				arg_12_1.mask_.color = var_15_10
			end

			if arg_12_1.time_ >= var_15_8 + var_15_9 and arg_12_1.time_ < var_15_8 + var_15_9 + arg_15_0 then
				local var_15_11 = Color.New(0, 0, 0)

				arg_12_1.mask_.enabled = false
				var_15_11.a = 0
				arg_12_1.mask_.color = var_15_11
			end

			local var_15_12 = "4040ui_story"

			if arg_12_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_15_13 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_12_1.stage_.transform)

				var_15_13.name = var_15_12
				var_15_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_[var_15_12] = var_15_13

				local var_15_14 = var_15_13:GetComponentInChildren(typeof(CharacterEffect))

				var_15_14.enabled = true

				local var_15_15 = GameObjectTools.GetOrAddComponent(var_15_13, typeof(DynamicBoneHelper))

				if var_15_15 then
					var_15_15:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_14.transform, false)

				arg_12_1.var_[var_15_12 .. "Animator"] = var_15_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_[var_15_12 .. "Animator"].applyRootMotion = true
				arg_12_1.var_[var_15_12 .. "LipSync"] = var_15_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_16 = arg_12_1.actors_["4040ui_story"].transform

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				arg_12_1.var_.moveOldPos4040ui_story = var_15_16.localPosition
			end

			local var_15_17 = 0.001

			if 2 <= arg_12_1.time_ and arg_12_1.time_ < 2 + var_15_17 then
				var_15_16.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_12_1.time_ - 2) / var_15_17)
				var_15_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_16.position).x, (manager.ui.mainCamera.transform.position - var_15_16.position).y, (manager.ui.mainCamera.transform.position - var_15_16.position).z)
				var_15_16.localEulerAngles.z = 0
				var_15_16.localEulerAngles.x = 0
				var_15_16.localEulerAngles = var_15_16.localEulerAngles
			end

			if arg_12_1.time_ >= 2 + var_15_17 and arg_12_1.time_ < 2 + var_15_17 + arg_15_0 then
				var_15_16.localPosition = Vector3.New(0, -1.55, -5.5)
				var_15_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_16.position).x, (manager.ui.mainCamera.transform.position - var_15_16.position).y, (manager.ui.mainCamera.transform.position - var_15_16.position).z)
				var_15_16.localEulerAngles.z = 0
				var_15_16.localEulerAngles.x = 0
				var_15_16.localEulerAngles = var_15_16.localEulerAngles
			end

			local var_15_18 = arg_12_1.actors_["4040ui_story"]

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 and not isNil(var_15_18) and arg_12_1.var_.characterEffect4040ui_story == nil then
				arg_12_1.var_.characterEffect4040ui_story = var_15_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_19 = 0.200000002980232

			if 2 <= arg_12_1.time_ and arg_12_1.time_ < 2 + var_15_19 and not isNil(var_15_18) then
				if arg_12_1.var_.characterEffect4040ui_story and not isNil(var_15_18) then
					arg_12_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 2 + var_15_19 and arg_12_1.time_ < 2 + var_15_19 + arg_15_0 and not isNil(var_15_18) and arg_12_1.var_.characterEffect4040ui_story then
				arg_12_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				arg_12_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				arg_12_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_15_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_23 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_23

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_23
						arg_12_1.bgmTxt2_.text = var_15_23
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.1 < arg_12_1.time_ and arg_12_1.time_ <= 0.1 + arg_15_0 then
				arg_12_1:AudioAction("play", "music", "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space.awb")

				local var_15_26 = manager.audio:GetAudioName("bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space")

				if "" ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_26 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_26

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_26
						arg_12_1.bgmTxt2_.text = var_15_26
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_27 = 2
			local var_15_28 = 0.175

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_29 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_29:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_12_1.dialogCg_.alpha = arg_18_0
				end))
				var_15_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_30 = arg_12_1:GetWordFromCfg(319591003)
				local var_15_31 = arg_12_1:FormatText(var_15_30.content)

				arg_12_1.text_.text = var_15_31

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_33 = 7 <= 0 and var_15_28 or var_15_28 * (utf8.len(var_15_31) / 7)

				if (7 <= 0 and var_15_28 or var_15_28 * (utf8.len(var_15_31) / 7)) > 0 and var_15_28 < var_15_33 then
					arg_12_1.talkMaxDuration = var_15_33
					var_15_27 = var_15_27 + 0.3

					if var_15_33 + var_15_27 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_33 + var_15_27
					end
				end

				arg_12_1.text_.text = var_15_31
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591003", "story_v_out_319591.awb") ~= 0 then
					local var_15_34 = manager.audio:GetVoiceLength("story_v_out_319591", "319591003", "story_v_out_319591.awb") / 1000

					if var_15_34 + var_15_27 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_34 + var_15_27
					end

					if var_15_30.prefab_name ~= "" and arg_12_1.actors_[var_15_30.prefab_name] ~= nil then
						local var_15_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_30.prefab_name].transform, "story_v_out_319591", "319591003", "story_v_out_319591.awb")

						arg_12_1:RecordAudio("319591003", var_15_35)
						arg_12_1:RecordAudio("319591003", var_15_35)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_319591", "319591003", "story_v_out_319591.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_319591", "319591003", "story_v_out_319591.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_36 = var_15_27 + 0.3
			local var_15_37 = math.max(var_15_28, arg_12_1.talkMaxDuration)

			if var_15_27 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_36 + var_15_37 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_36) / var_15_37

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_36 + var_15_37 and arg_12_1.time_ < var_15_36 + var_15_37 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play319591004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 319591004
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play319591005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["4040ui_story"]) and arg_20_1.var_.characterEffect4040ui_story == nil then
				arg_20_1.var_.characterEffect4040ui_story = arg_20_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["4040ui_story"]) then
				if arg_20_1.var_.characterEffect4040ui_story and not isNil(arg_20_1.actors_["4040ui_story"]) then
					arg_20_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_20_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["4040ui_story"]) and arg_20_1.var_.characterEffect4040ui_story then
				arg_20_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_20_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 1.25

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(319591004).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 49 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 49)

				if (49 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 49)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play319591005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319591005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play319591006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.9

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(319591005).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 36 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 36)

				if (36 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 36)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play319591006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 319591006
		arg_28_1.duration_ = 2.6

		local var_28_0 = {
			zh = 2,
			ja = 2.6
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
				arg_28_0:Play319591007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["4040ui_story"]) and arg_28_1.var_.characterEffect4040ui_story == nil then
				arg_28_1.var_.characterEffect4040ui_story = arg_28_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["4040ui_story"]) then
				if arg_28_1.var_.characterEffect4040ui_story and not isNil(arg_28_1.actors_["4040ui_story"]) then
					arg_28_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["4040ui_story"]) and arg_28_1.var_.characterEffect4040ui_story then
				arg_28_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_31_2 = 0
			local var_31_3 = 0.175

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_4 = arg_28_1:GetWordFromCfg(319591006)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 7 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 7)

				if (7 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 7)) > 0 and var_31_3 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591006", "story_v_out_319591.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_319591", "319591006", "story_v_out_319591.awb") / 1000

					if var_31_8 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_2
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_out_319591", "319591006", "story_v_out_319591.awb")

						arg_28_1:RecordAudio("319591006", var_31_9)
						arg_28_1:RecordAudio("319591006", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_319591", "319591006", "story_v_out_319591.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_319591", "319591006", "story_v_out_319591.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_10 and arg_28_1.time_ < var_31_2 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play319591007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319591007
		arg_32_1.duration_ = 5.5

		local var_32_0 = {
			zh = 2.7,
			ja = 5.5
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
				arg_32_0:Play319591008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_35_0 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_32_1.stage_.transform)

				var_35_0.name = "10079ui_story"
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["10079ui_story"] = var_35_0

				local var_35_1 = var_35_0:GetComponentInChildren(typeof(CharacterEffect))

				var_35_1.enabled = true

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_1.transform, false)

				arg_32_1.var_["10079ui_story" .. "Animator"] = var_35_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_["10079ui_story" .. "Animator"].applyRootMotion = true
				arg_32_1.var_["10079ui_story" .. "LipSync"] = var_35_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_3 = arg_32_1.actors_["10079ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10079ui_story = var_35_3.localPosition
			end

			local var_35_4 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_32_1.time_ - 0) / var_35_4)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			local var_35_5 = arg_32_1.actors_["10079ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect10079ui_story == nil then
				arg_32_1.var_.characterEffect10079ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect10079ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect10079ui_story then
				arg_32_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_35_8 = arg_32_1.actors_["4040ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos4040ui_story = var_35_8.localPosition
			end

			local var_35_9 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_9 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_32_1.time_ - 0) / var_35_9)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_9 and arg_32_1.time_ < 0 + var_35_9 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			local var_35_10 = arg_32_1.actors_["4040ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect4040ui_story == nil then
				arg_32_1.var_.characterEffect4040ui_story = var_35_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_11 and not isNil(var_35_10) then
				if arg_32_1.var_.characterEffect4040ui_story and not isNil(var_35_10) then
					arg_32_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_32_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_11)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_11 and arg_32_1.time_ < 0 + var_35_11 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect4040ui_story then
				arg_32_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_32_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_35_12 = 0
			local var_35_13 = 0.225

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
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

				local var_35_14 = arg_32_1:GetWordFromCfg(319591007)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 9 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 9)

				if (9 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 9)) > 0 and var_35_13 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591007", "story_v_out_319591.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591007", "story_v_out_319591.awb") / 1000

					if var_35_18 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_12
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_319591", "319591007", "story_v_out_319591.awb")

						arg_32_1:RecordAudio("319591007", var_35_19)
						arg_32_1:RecordAudio("319591007", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_319591", "319591007", "story_v_out_319591.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_319591", "319591007", "story_v_out_319591.awb")
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
				actorName = "10079ui_story",
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

		arg_32_1:InitPlayNodeList()
	end,
	Play319591008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 319591008
		arg_36_1.duration_ = 8.9

		local var_36_0 = {
			zh = 5.633,
			ja = 8.9
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
				arg_36_0:Play319591009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["10079ui_story"]) and arg_36_1.var_.characterEffect10079ui_story == nil then
				arg_36_1.var_.characterEffect10079ui_story = arg_36_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["10079ui_story"]) then
				if arg_36_1.var_.characterEffect10079ui_story and not isNil(arg_36_1.actors_["10079ui_story"]) then
					arg_36_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["10079ui_story"]) and arg_36_1.var_.characterEffect10079ui_story then
				arg_36_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_39_1 = arg_36_1.actors_["4040ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect4040ui_story == nil then
				arg_36_1.var_.characterEffect4040ui_story = var_39_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 and not isNil(var_39_1) then
				if arg_36_1.var_.characterEffect4040ui_story and not isNil(var_39_1) then
					arg_36_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect4040ui_story then
				arg_36_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_39_4 = 0
			local var_39_5 = 0.525

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(319591008)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 21 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 21)

				if (21 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 21)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591008", "story_v_out_319591.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_319591", "319591008", "story_v_out_319591.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_319591", "319591008", "story_v_out_319591.awb")

						arg_36_1:RecordAudio("319591008", var_39_11)
						arg_36_1:RecordAudio("319591008", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_319591", "319591008", "story_v_out_319591.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_319591", "319591008", "story_v_out_319591.awb")
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
	Play319591009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 319591009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play319591010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["4040ui_story"]) and arg_40_1.var_.characterEffect4040ui_story == nil then
				arg_40_1.var_.characterEffect4040ui_story = arg_40_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["4040ui_story"]) then
				if arg_40_1.var_.characterEffect4040ui_story and not isNil(arg_40_1.actors_["4040ui_story"]) then
					arg_40_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_40_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["4040ui_story"]) and arg_40_1.var_.characterEffect4040ui_story then
				arg_40_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_40_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 0.625

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(319591009).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 25 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 25)

				if (25 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 25)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_6 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_6 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_6

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_6 and arg_40_1.time_ < var_43_1 + var_43_6 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play319591010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319591010
		arg_44_1.duration_ = 13.3

		local var_44_0 = {
			zh = 6.333,
			ja = 13.3
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
				arg_44_0:Play319591011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["10079ui_story"]) and arg_44_1.var_.characterEffect10079ui_story == nil then
				arg_44_1.var_.characterEffect10079ui_story = arg_44_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["10079ui_story"]) then
				if arg_44_1.var_.characterEffect10079ui_story and not isNil(arg_44_1.actors_["10079ui_story"]) then
					arg_44_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["10079ui_story"]) and arg_44_1.var_.characterEffect10079ui_story then
				arg_44_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_47_2 = 0
			local var_47_3 = 0.775

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(319591010)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 31 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 31)

				if (31 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 31)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591010", "story_v_out_319591.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_319591", "319591010", "story_v_out_319591.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_319591", "319591010", "story_v_out_319591.awb")

						arg_44_1:RecordAudio("319591010", var_47_9)
						arg_44_1:RecordAudio("319591010", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_319591", "319591010", "story_v_out_319591.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_319591", "319591010", "story_v_out_319591.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play319591011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319591011
		arg_48_1.duration_ = 13.27

		local var_48_0 = {
			zh = 4.066,
			ja = 13.266
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
				arg_48_0:Play319591012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos4040ui_story = arg_48_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["4040ui_story"].transform.position).z)
				arg_48_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["4040ui_story"].transform.localEulerAngles = arg_48_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_48_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["4040ui_story"].transform.position).z)
				arg_48_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["4040ui_story"].transform.localEulerAngles = arg_48_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_51_1 = arg_48_1.actors_["4040ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect4040ui_story == nil then
				arg_48_1.var_.characterEffect4040ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect4040ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect4040ui_story then
				arg_48_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_51_4 = arg_48_1.actors_["10079ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10079ui_story == nil then
				arg_48_1.var_.characterEffect10079ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_5 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 and not isNil(var_51_4) then
				if arg_48_1.var_.characterEffect10079ui_story and not isNil(var_51_4) then
					arg_48_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_5)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect10079ui_story then
				arg_48_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_51_6 = 0
			local var_51_7 = 0.525

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(319591011)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 21 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 21)

				if (21 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 21)) > 0 and var_51_7 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591011", "story_v_out_319591.awb") ~= 0 then
					local var_51_12 = manager.audio:GetVoiceLength("story_v_out_319591", "319591011", "story_v_out_319591.awb") / 1000

					if var_51_12 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_6
					end

					if var_51_8.prefab_name ~= "" and arg_48_1.actors_[var_51_8.prefab_name] ~= nil then
						local var_51_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_8.prefab_name].transform, "story_v_out_319591", "319591011", "story_v_out_319591.awb")

						arg_48_1:RecordAudio("319591011", var_51_13)
						arg_48_1:RecordAudio("319591011", var_51_13)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319591", "319591011", "story_v_out_319591.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319591", "319591011", "story_v_out_319591.awb")
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
				actorName = "4040ui_story",
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
	Play319591012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319591012
		arg_52_1.duration_ = 4.57

		local var_52_0 = {
			zh = 2.166,
			ja = 4.566
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
				arg_52_0:Play319591013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_55_0 = 0
			local var_55_1 = 0.2

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(319591012)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 8 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 8)

				if (8 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 8)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591012", "story_v_out_319591.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_319591", "319591012", "story_v_out_319591.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_319591", "319591012", "story_v_out_319591.awb")

						arg_52_1:RecordAudio("319591012", var_55_7)
						arg_52_1:RecordAudio("319591012", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_319591", "319591012", "story_v_out_319591.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_319591", "319591012", "story_v_out_319591.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play319591013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319591013
		arg_56_1.duration_ = 6.23

		local var_56_0 = {
			zh = 3.3,
			ja = 6.233
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319591014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10079ui_story = arg_56_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10079ui_story"].transform.position).z)
				arg_56_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10079ui_story"].transform.localEulerAngles = arg_56_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_56_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10079ui_story"].transform.position).z)
				arg_56_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10079ui_story"].transform.localEulerAngles = arg_56_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["10079ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect10079ui_story == nil then
				arg_56_1.var_.characterEffect10079ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 and not isNil(var_59_1) then
				if arg_56_1.var_.characterEffect10079ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect10079ui_story then
				arg_56_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_59_4 = arg_56_1.actors_["4040ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect4040ui_story == nil then
				arg_56_1.var_.characterEffect4040ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_5 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 and not isNil(var_59_4) then
				if arg_56_1.var_.characterEffect4040ui_story and not isNil(var_59_4) then
					arg_56_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_56_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_5)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect4040ui_story then
				arg_56_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_56_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_59_6 = 0
			local var_59_7 = 0.375

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_8 = arg_56_1:GetWordFromCfg(319591013)
				local var_59_9 = arg_56_1:FormatText(var_59_8.content)

				arg_56_1.text_.text = var_59_9

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 15 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 15)

				if (15 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 15)) > 0 and var_59_7 < var_59_11 then
					arg_56_1.talkMaxDuration = var_59_11

					if var_59_11 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_9
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591013", "story_v_out_319591.awb") ~= 0 then
					local var_59_12 = manager.audio:GetVoiceLength("story_v_out_319591", "319591013", "story_v_out_319591.awb") / 1000

					if var_59_12 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_6
					end

					if var_59_8.prefab_name ~= "" and arg_56_1.actors_[var_59_8.prefab_name] ~= nil then
						local var_59_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_8.prefab_name].transform, "story_v_out_319591", "319591013", "story_v_out_319591.awb")

						arg_56_1:RecordAudio("319591013", var_59_13)
						arg_56_1:RecordAudio("319591013", var_59_13)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_319591", "319591013", "story_v_out_319591.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_319591", "319591013", "story_v_out_319591.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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

		arg_56_1:InitPlayNodeList()
	end,
	Play319591014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319591014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play319591015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["10079ui_story"]) and arg_60_1.var_.characterEffect10079ui_story == nil then
				arg_60_1.var_.characterEffect10079ui_story = arg_60_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["10079ui_story"]) then
				if arg_60_1.var_.characterEffect10079ui_story and not isNil(arg_60_1.actors_["10079ui_story"]) then
					arg_60_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["10079ui_story"]) and arg_60_1.var_.characterEffect10079ui_story then
				arg_60_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_63_1 = arg_60_1.actors_["4040ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos4040ui_story = var_63_1.localPosition
			end

			local var_63_2 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 then
				var_63_1.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_2)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 then
				var_63_1.localPosition = Vector3.New(0, 100, 0)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			local var_63_3 = arg_60_1.actors_["10079ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10079ui_story = var_63_3.localPosition
			end

			local var_63_4 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				var_63_3.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_4)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				var_63_3.localPosition = Vector3.New(0, 100, 0)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			local var_63_5 = 0
			local var_63_6 = 1.325

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_7 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(319591014).content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 53 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_7) / 53)

				if (53 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_7) / 53)) > 0 and var_63_6 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_5
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_6, arg_60_1.talkMaxDuration)

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_5) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_5 + var_63_10 and arg_60_1.time_ < var_63_5 + var_63_10 + arg_63_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play319591015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319591015
		arg_64_1.duration_ = 8.57

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319591016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if arg_64_1.bgs_.STwhite == nil then
				local var_67_0 = Object.Instantiate(arg_64_1.paintGo_)

				var_67_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_67_0.name = "STwhite"
				var_67_0.transform.parent = arg_64_1.stage_.transform
				var_67_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.bgs_.STwhite = var_67_0
			end

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 then
				local var_67_1 = arg_64_1.bgs_.STwhite

				arg_64_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_67_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_2 = var_67_1:GetComponent("SpriteRenderer")

				if var_67_2 and var_67_2.sprite then
					local var_67_3 = 2 * (var_67_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_67_1.transform.localScale = Vector3.New(var_67_3 / var_67_2.sprite.bounds.size.y < var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x and var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x or var_67_3 / var_67_2.sprite.bounds.size.y, var_67_3 / var_67_2.sprite.bounds.size.y < var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x and var_67_3 * manager.ui.mainCameraCom_.aspect / var_67_2.sprite.bounds.size.x or var_67_3 / var_67_2.sprite.bounds.size.y, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "STwhite" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_4 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_5 = 2

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_5 then
				local var_67_6 = Color.New(0, 0, 0)

				var_67_6.a = Mathf.Lerp(0, 1, (arg_64_1.time_ - var_67_4) / var_67_5)
				arg_64_1.mask_.color = var_67_6
			end

			if arg_64_1.time_ >= var_67_4 + var_67_5 and arg_64_1.time_ < var_67_4 + var_67_5 + arg_67_0 then
				local var_67_7 = Color.New(0, 0, 0)

				var_67_7.a = 1
				arg_64_1.mask_.color = var_67_7
			end

			local var_67_8 = 2

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_8 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_9 = 2

			if var_67_8 <= arg_64_1.time_ and arg_64_1.time_ < var_67_8 + var_67_9 then
				local var_67_10 = Color.New(0, 0, 0)

				var_67_10.a = Mathf.Lerp(1, 0, (arg_64_1.time_ - var_67_8) / var_67_9)
				arg_64_1.mask_.color = var_67_10
			end

			if arg_64_1.time_ >= var_67_8 + var_67_9 and arg_64_1.time_ < var_67_8 + var_67_9 + arg_67_0 then
				local var_67_11 = Color.New(0, 0, 0)

				arg_64_1.mask_.enabled = false
				var_67_11.a = 0
				arg_64_1.mask_.color = var_67_11
			end

			local var_67_12 = arg_64_1.actors_["10079ui_story"].transform

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 then
				arg_64_1.var_.moveOldPos10079ui_story = var_67_12.localPosition
			end

			local var_67_13 = 0.001

			if 2 <= arg_64_1.time_ and arg_64_1.time_ < 2 + var_67_13 then
				var_67_12.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 2) / var_67_13)
				var_67_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_12.position).x, (manager.ui.mainCamera.transform.position - var_67_12.position).y, (manager.ui.mainCamera.transform.position - var_67_12.position).z)
				var_67_12.localEulerAngles.z = 0
				var_67_12.localEulerAngles.x = 0
				var_67_12.localEulerAngles = var_67_12.localEulerAngles
			end

			if arg_64_1.time_ >= 2 + var_67_13 and arg_64_1.time_ < 2 + var_67_13 + arg_67_0 then
				var_67_12.localPosition = Vector3.New(0, 100, 0)
				var_67_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_12.position).x, (manager.ui.mainCamera.transform.position - var_67_12.position).y, (manager.ui.mainCamera.transform.position - var_67_12.position).z)
				var_67_12.localEulerAngles.z = 0
				var_67_12.localEulerAngles.x = 0
				var_67_12.localEulerAngles = var_67_12.localEulerAngles
			end

			local var_67_14 = arg_64_1.actors_["10079ui_story"]

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 and not isNil(var_67_14) and arg_64_1.var_.characterEffect10079ui_story == nil then
				arg_64_1.var_.characterEffect10079ui_story = var_67_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_15 = 0.200000002980232

			if 2 <= arg_64_1.time_ and arg_64_1.time_ < 2 + var_67_15 and not isNil(var_67_14) then
				if arg_64_1.var_.characterEffect10079ui_story and not isNil(var_67_14) then
					arg_64_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 2) / var_67_15)
				end
			end

			if arg_64_1.time_ >= 2 + var_67_15 and arg_64_1.time_ < 2 + var_67_15 + arg_67_0 and not isNil(var_67_14) and arg_64_1.var_.characterEffect10079ui_story then
				arg_64_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_67_16 = arg_64_1.actors_["4040ui_story"].transform

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 then
				arg_64_1.var_.moveOldPos4040ui_story = var_67_16.localPosition
			end

			local var_67_17 = 0.001

			if 2 <= arg_64_1.time_ and arg_64_1.time_ < 2 + var_67_17 then
				var_67_16.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 2) / var_67_17)
				var_67_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_16.position).x, (manager.ui.mainCamera.transform.position - var_67_16.position).y, (manager.ui.mainCamera.transform.position - var_67_16.position).z)
				var_67_16.localEulerAngles.z = 0
				var_67_16.localEulerAngles.x = 0
				var_67_16.localEulerAngles = var_67_16.localEulerAngles
			end

			if arg_64_1.time_ >= 2 + var_67_17 and arg_64_1.time_ < 2 + var_67_17 + arg_67_0 then
				var_67_16.localPosition = Vector3.New(0, 100, 0)
				var_67_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_16.position).x, (manager.ui.mainCamera.transform.position - var_67_16.position).y, (manager.ui.mainCamera.transform.position - var_67_16.position).z)
				var_67_16.localEulerAngles.z = 0
				var_67_16.localEulerAngles.x = 0
				var_67_16.localEulerAngles = var_67_16.localEulerAngles
			end

			local var_67_18 = arg_64_1.actors_["4040ui_story"]

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 and not isNil(var_67_18) and arg_64_1.var_.characterEffect4040ui_story == nil then
				arg_64_1.var_.characterEffect4040ui_story = var_67_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_19 = 0.200000002980232

			if 2 <= arg_64_1.time_ and arg_64_1.time_ < 2 + var_67_19 and not isNil(var_67_18) then
				if arg_64_1.var_.characterEffect4040ui_story and not isNil(var_67_18) then
					arg_64_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_64_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 2) / var_67_19)
				end
			end

			if arg_64_1.time_ >= 2 + var_67_19 and arg_64_1.time_ < 2 + var_67_19 + arg_67_0 and not isNil(var_67_18) and arg_64_1.var_.characterEffect4040ui_story then
				arg_64_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_64_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_20 = 3.56666666666667
			local var_67_21 = 0.875

			if 3.56666666666667 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_22 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_22:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_23 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(319591015).content)

				arg_64_1.text_.text = var_67_23

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_25 = 35 <= 0 and var_67_21 or var_67_21 * (utf8.len(var_67_23) / 35)

				if (35 <= 0 and var_67_21 or var_67_21 * (utf8.len(var_67_23) / 35)) > 0 and var_67_21 < var_67_25 then
					arg_64_1.talkMaxDuration = var_67_25
					var_67_20 = var_67_20 + 0.3

					if var_67_25 + var_67_20 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_25 + var_67_20
					end
				end

				arg_64_1.text_.text = var_67_23
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_26 = var_67_20 + 0.3
			local var_67_27 = math.max(var_67_21, arg_64_1.talkMaxDuration)

			if var_67_20 + 0.3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_26 + var_67_27 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_26) / var_67_27

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_26 + var_67_27 and arg_64_1.time_ < var_67_26 + var_67_27 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play319591016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 319591016
		arg_70_1.duration_ = 7.13

		local var_70_0 = {
			zh = 6.7,
			ja = 7.133
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play319591017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.bgs_.I10f == nil then
				local var_73_0 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I10f")
				var_73_0.name = "I10f"
				var_73_0.transform.parent = arg_70_1.stage_.transform
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_.I10f = var_73_0
			end

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 then
				local var_73_1 = arg_70_1.bgs_.I10f

				arg_70_1.bgs_.I10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_73_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_2 = var_73_1:GetComponent("SpriteRenderer")

				if var_73_2 and var_73_2.sprite then
					local var_73_3 = 2 * (var_73_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_73_1.transform.localScale = Vector3.New(var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "I10f" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_4 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_5 = 2

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_5 then
				local var_73_6 = Color.New(0, 0, 0)

				var_73_6.a = Mathf.Lerp(0, 1, (arg_70_1.time_ - var_73_4) / var_73_5)
				arg_70_1.mask_.color = var_73_6
			end

			if arg_70_1.time_ >= var_73_4 + var_73_5 and arg_70_1.time_ < var_73_4 + var_73_5 + arg_73_0 then
				local var_73_7 = Color.New(0, 0, 0)

				var_73_7.a = 1
				arg_70_1.mask_.color = var_73_7
			end

			local var_73_8 = 2

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_9 = 2

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_9 then
				local var_73_10 = Color.New(0, 0, 0)

				var_73_10.a = Mathf.Lerp(1, 0, (arg_70_1.time_ - var_73_8) / var_73_9)
				arg_70_1.mask_.color = var_73_10
			end

			if arg_70_1.time_ >= var_73_8 + var_73_9 and arg_70_1.time_ < var_73_8 + var_73_9 + arg_73_0 then
				local var_73_11 = Color.New(0, 0, 0)

				arg_70_1.mask_.enabled = false
				var_73_11.a = 0
				arg_70_1.mask_.color = var_73_11
			end

			local var_73_12 = "1095ui_story"

			if arg_70_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_73_13 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_70_1.stage_.transform)

				var_73_13.name = var_73_12
				var_73_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_[var_73_12] = var_73_13

				local var_73_14 = var_73_13:GetComponentInChildren(typeof(CharacterEffect))

				var_73_14.enabled = true

				local var_73_15 = GameObjectTools.GetOrAddComponent(var_73_13, typeof(DynamicBoneHelper))

				if var_73_15 then
					var_73_15:EnableDynamicBone(false)
				end

				arg_70_1:ShowWeapon(var_73_14.transform, false)

				arg_70_1.var_[var_73_12 .. "Animator"] = var_73_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_70_1.var_[var_73_12 .. "Animator"].applyRootMotion = true
				arg_70_1.var_[var_73_12 .. "LipSync"] = var_73_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_73_16 = arg_70_1.actors_["1095ui_story"].transform

			if 3.86666666666667 < arg_70_1.time_ and arg_70_1.time_ <= 3.86666666666667 + arg_73_0 then
				arg_70_1.var_.moveOldPos1095ui_story = var_73_16.localPosition
			end

			local var_73_17 = 0.001

			if 3.86666666666667 <= arg_70_1.time_ and arg_70_1.time_ < 3.86666666666667 + var_73_17 then
				var_73_16.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_70_1.time_ - 3.86666666666667) / var_73_17)
				var_73_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_16.position).x, (manager.ui.mainCamera.transform.position - var_73_16.position).y, (manager.ui.mainCamera.transform.position - var_73_16.position).z)
				var_73_16.localEulerAngles.z = 0
				var_73_16.localEulerAngles.x = 0
				var_73_16.localEulerAngles = var_73_16.localEulerAngles
			end

			if arg_70_1.time_ >= 3.86666666666667 + var_73_17 and arg_70_1.time_ < 3.86666666666667 + var_73_17 + arg_73_0 then
				var_73_16.localPosition = Vector3.New(0, -0.98, -6.1)
				var_73_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_16.position).x, (manager.ui.mainCamera.transform.position - var_73_16.position).y, (manager.ui.mainCamera.transform.position - var_73_16.position).z)
				var_73_16.localEulerAngles.z = 0
				var_73_16.localEulerAngles.x = 0
				var_73_16.localEulerAngles = var_73_16.localEulerAngles
			end

			local var_73_18 = arg_70_1.actors_["1095ui_story"]

			if 3.86666666666667 < arg_70_1.time_ and arg_70_1.time_ <= 3.86666666666667 + arg_73_0 and not isNil(var_73_18) and arg_70_1.var_.characterEffect1095ui_story == nil then
				arg_70_1.var_.characterEffect1095ui_story = var_73_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_19 = 0.200000002980232

			if 3.86666666666667 <= arg_70_1.time_ and arg_70_1.time_ < 3.86666666666667 + var_73_19 and not isNil(var_73_18) then
				if arg_70_1.var_.characterEffect1095ui_story and not isNil(var_73_18) then
					arg_70_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 3.86666666666667 + var_73_19 and arg_70_1.time_ < 3.86666666666667 + var_73_19 + arg_73_0 and not isNil(var_73_18) and arg_70_1.var_.characterEffect1095ui_story then
				arg_70_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 3.86666666666667 < arg_70_1.time_ and arg_70_1.time_ <= 3.86666666666667 + arg_73_0 then
				arg_70_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 3.86666666666667 < arg_70_1.time_ and arg_70_1.time_ <= 3.86666666666667 + arg_73_0 then
				arg_70_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_21 = 4
			local var_73_22 = 0.25

			if 4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_21 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_23 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_23:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_24 = arg_70_1:GetWordFromCfg(319591016)
				local var_73_25 = arg_70_1:FormatText(var_73_24.content)

				arg_70_1.text_.text = var_73_25

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_27 = 10 <= 0 and var_73_22 or var_73_22 * (utf8.len(var_73_25) / 10)

				if (10 <= 0 and var_73_22 or var_73_22 * (utf8.len(var_73_25) / 10)) > 0 and var_73_22 < var_73_27 then
					arg_70_1.talkMaxDuration = var_73_27
					var_73_21 = var_73_21 + 0.3

					if var_73_27 + var_73_21 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_27 + var_73_21
					end
				end

				arg_70_1.text_.text = var_73_25
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591016", "story_v_out_319591.awb") ~= 0 then
					local var_73_28 = manager.audio:GetVoiceLength("story_v_out_319591", "319591016", "story_v_out_319591.awb") / 1000

					if var_73_28 + var_73_21 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_28 + var_73_21
					end

					if var_73_24.prefab_name ~= "" and arg_70_1.actors_[var_73_24.prefab_name] ~= nil then
						local var_73_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_24.prefab_name].transform, "story_v_out_319591", "319591016", "story_v_out_319591.awb")

						arg_70_1:RecordAudio("319591016", var_73_29)
						arg_70_1:RecordAudio("319591016", var_73_29)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_319591", "319591016", "story_v_out_319591.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_319591", "319591016", "story_v_out_319591.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_30 = var_73_21 + 0.3
			local var_73_31 = math.max(var_73_22, arg_70_1.talkMaxDuration)

			if var_73_21 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_30 + var_73_31 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_30) / var_73_31

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_30 + var_73_31 and arg_70_1.time_ < var_73_30 + var_73_31 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play319591017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319591017
		arg_76_1.duration_ = 3.2

		local var_76_0 = {
			zh = 1.999999999999,
			ja = 3.2
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
				arg_76_0:Play319591018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10079ui_story = arg_76_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10079ui_story"].transform.position).z)
				arg_76_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["10079ui_story"].transform.localEulerAngles = arg_76_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_76_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10079ui_story"].transform.position).z)
				arg_76_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["10079ui_story"].transform.localEulerAngles = arg_76_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["10079ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect10079ui_story == nil then
				arg_76_1.var_.characterEffect10079ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect10079ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect10079ui_story then
				arg_76_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_79_4 = arg_76_1.actors_["1095ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1095ui_story = var_79_4.localPosition
			end

			local var_79_5 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 then
				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_76_1.time_ - 0) / var_79_5)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			local var_79_6 = arg_76_1.actors_["1095ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_6) and arg_76_1.var_.characterEffect1095ui_story == nil then
				arg_76_1.var_.characterEffect1095ui_story = var_79_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_7 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 and not isNil(var_79_6) then
				if arg_76_1.var_.characterEffect1095ui_story and not isNil(var_79_6) then
					arg_76_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_7)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 and not isNil(var_79_6) and arg_76_1.var_.characterEffect1095ui_story then
				arg_76_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_79_8 = 0
			local var_79_9 = 0.125

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
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

				local var_79_10 = arg_76_1:GetWordFromCfg(319591017)
				local var_79_11 = arg_76_1:FormatText(var_79_10.content)

				arg_76_1.text_.text = var_79_11

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 5 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 5)

				if (5 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 5)) > 0 and var_79_9 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_11
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591017", "story_v_out_319591.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591017", "story_v_out_319591.awb") / 1000

					if var_79_14 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_8
					end

					if var_79_10.prefab_name ~= "" and arg_76_1.actors_[var_79_10.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_10.prefab_name].transform, "story_v_out_319591", "319591017", "story_v_out_319591.awb")

						arg_76_1:RecordAudio("319591017", var_79_15)
						arg_76_1:RecordAudio("319591017", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319591", "319591017", "story_v_out_319591.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319591", "319591017", "story_v_out_319591.awb")
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319591018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319591018
		arg_80_1.duration_ = 6.4

		local var_80_0 = {
			zh = 6.4,
			ja = 4.5
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
				arg_80_0:Play319591019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos4040ui_story = arg_80_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["4040ui_story"].transform.position).z)
				arg_80_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["4040ui_story"].transform.localEulerAngles = arg_80_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_80_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["4040ui_story"].transform.position).z)
				arg_80_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["4040ui_story"].transform.localEulerAngles = arg_80_1.actors_["4040ui_story"].transform.localEulerAngles
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

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_83_4 = arg_80_1.actors_["10079ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10079ui_story = var_83_4.localPosition
			end

			local var_83_5 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_5 then
				var_83_4.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_5)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_5 and arg_80_1.time_ < 0 + var_83_5 + arg_83_0 then
				var_83_4.localPosition = Vector3.New(0, 100, 0)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			local var_83_6 = arg_80_1.actors_["10079ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_6) and arg_80_1.var_.characterEffect10079ui_story == nil then
				arg_80_1.var_.characterEffect10079ui_story = var_83_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_7 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 and not isNil(var_83_6) then
				if arg_80_1.var_.characterEffect10079ui_story and not isNil(var_83_6) then
					arg_80_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_7)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 and not isNil(var_83_6) and arg_80_1.var_.characterEffect10079ui_story then
				arg_80_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_83_8 = arg_80_1.actors_["1095ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1095ui_story = var_83_8.localPosition
			end

			local var_83_9 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_9 then
				var_83_8.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_9)
				var_83_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_8.position).x, (manager.ui.mainCamera.transform.position - var_83_8.position).y, (manager.ui.mainCamera.transform.position - var_83_8.position).z)
				var_83_8.localEulerAngles.z = 0
				var_83_8.localEulerAngles.x = 0
				var_83_8.localEulerAngles = var_83_8.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_9 and arg_80_1.time_ < 0 + var_83_9 + arg_83_0 then
				var_83_8.localPosition = Vector3.New(0, 100, 0)
				var_83_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_8.position).x, (manager.ui.mainCamera.transform.position - var_83_8.position).y, (manager.ui.mainCamera.transform.position - var_83_8.position).z)
				var_83_8.localEulerAngles.z = 0
				var_83_8.localEulerAngles.x = 0
				var_83_8.localEulerAngles = var_83_8.localEulerAngles
			end

			local var_83_10 = arg_80_1.actors_["1095ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_10) and arg_80_1.var_.characterEffect1095ui_story == nil then
				arg_80_1.var_.characterEffect1095ui_story = var_83_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_11 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_11 and not isNil(var_83_10) then
				if arg_80_1.var_.characterEffect1095ui_story and not isNil(var_83_10) then
					arg_80_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_11)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_11 and arg_80_1.time_ < 0 + var_83_11 + arg_83_0 and not isNil(var_83_10) and arg_80_1.var_.characterEffect1095ui_story then
				arg_80_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_83_12 = 0
			local var_83_13 = 0.625

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
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

				local var_83_14 = arg_80_1:GetWordFromCfg(319591018)
				local var_83_15 = arg_80_1:FormatText(var_83_14.content)

				arg_80_1.text_.text = var_83_15

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_17 = 25 <= 0 and var_83_13 or var_83_13 * (utf8.len(var_83_15) / 25)

				if (25 <= 0 and var_83_13 or var_83_13 * (utf8.len(var_83_15) / 25)) > 0 and var_83_13 < var_83_17 then
					arg_80_1.talkMaxDuration = var_83_17

					if var_83_17 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_17 + var_83_12
					end
				end

				arg_80_1.text_.text = var_83_15
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591018", "story_v_out_319591.awb") ~= 0 then
					local var_83_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591018", "story_v_out_319591.awb") / 1000

					if var_83_18 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_12
					end

					if var_83_14.prefab_name ~= "" and arg_80_1.actors_[var_83_14.prefab_name] ~= nil then
						local var_83_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_14.prefab_name].transform, "story_v_out_319591", "319591018", "story_v_out_319591.awb")

						arg_80_1:RecordAudio("319591018", var_83_19)
						arg_80_1:RecordAudio("319591018", var_83_19)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_319591", "319591018", "story_v_out_319591.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_319591", "319591018", "story_v_out_319591.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_20 = math.max(var_83_13, arg_80_1.talkMaxDuration)

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_20 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_12) / var_83_20

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_12 + var_83_20 and arg_80_1.time_ < var_83_12 + var_83_20 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play319591019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319591019
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319591020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos4040ui_story = arg_84_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["4040ui_story"].transform.position).z)
				arg_84_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["4040ui_story"].transform.localEulerAngles = arg_84_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["4040ui_story"].transform.position).z)
				arg_84_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["4040ui_story"].transform.localEulerAngles = arg_84_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["4040ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect4040ui_story == nil then
				arg_84_1.var_.characterEffect4040ui_story = var_87_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 and not isNil(var_87_1) then
				if arg_84_1.var_.characterEffect4040ui_story and not isNil(var_87_1) then
					arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_84_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_2)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect4040ui_story then
				arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_84_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_87_3 = 0
			local var_87_4 = 1.4

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_3 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_5 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(319591019).content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 56 <= 0 and var_87_4 or var_87_4 * (utf8.len(var_87_5) / 56)

				if (56 <= 0 and var_87_4 or var_87_4 * (utf8.len(var_87_5) / 56)) > 0 and var_87_4 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_3 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_3
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_4, arg_84_1.talkMaxDuration)

			if var_87_3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_3 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_3) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_3 + var_87_8 and arg_84_1.time_ < var_87_3 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play319591020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319591020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play319591021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.275

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

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(319591020).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 51 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 51)

				if (51 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 51)) > 0 and var_91_0 < var_91_3 then
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
	Play319591021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319591021
		arg_92_1.duration_ = 5.7

		local var_92_0 = {
			zh = 5.7,
			ja = 5.6
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
				arg_92_0:Play319591022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if arg_92_1.actors_["4037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4037ui_story"))) then
				local var_95_0 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_92_1.stage_.transform)

				var_95_0.name = "4037ui_story"
				var_95_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["4037ui_story"] = var_95_0

				local var_95_1 = var_95_0:GetComponentInChildren(typeof(CharacterEffect))

				var_95_1.enabled = true

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end

				arg_92_1:ShowWeapon(var_95_1.transform, false)

				arg_92_1.var_["4037ui_story" .. "Animator"] = var_95_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_92_1.var_["4037ui_story" .. "Animator"].applyRootMotion = true
				arg_92_1.var_["4037ui_story" .. "LipSync"] = var_95_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_95_3 = arg_92_1.actors_["4037ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos4037ui_story = var_95_3.localPosition
			end

			local var_95_4 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				var_95_3.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_92_1.time_ - 0) / var_95_4)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				var_95_3.localPosition = Vector3.New(0, -1.12, -6.2)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			local var_95_5 = arg_92_1.actors_["4037ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect4037ui_story == nil then
				arg_92_1.var_.characterEffect4037ui_story = var_95_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_6 and not isNil(var_95_5) then
				if arg_92_1.var_.characterEffect4037ui_story and not isNil(var_95_5) then
					arg_92_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_6 and arg_92_1.time_ < 0 + var_95_6 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect4037ui_story then
				arg_92_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_95_8 = 0
			local var_95_9 = 0.425

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(319591021)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 17 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 17)

				if (17 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 17)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591021", "story_v_out_319591.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591021", "story_v_out_319591.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_out_319591", "319591021", "story_v_out_319591.awb")

						arg_92_1:RecordAudio("319591021", var_95_15)
						arg_92_1:RecordAudio("319591021", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319591", "319591021", "story_v_out_319591.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319591", "319591021", "story_v_out_319591.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play319591022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 319591022
		arg_96_1.duration_ = 8.43

		local var_96_0 = {
			zh = 1.3,
			ja = 8.433
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
				arg_96_0:Play319591023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if arg_96_1.actors_["10037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10037ui_story"))) then
				local var_99_0 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_96_1.stage_.transform)

				var_99_0.name = "10037ui_story"
				var_99_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["10037ui_story"] = var_99_0

				local var_99_1 = var_99_0:GetComponentInChildren(typeof(CharacterEffect))

				var_99_1.enabled = true

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_0, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end

				arg_96_1:ShowWeapon(var_99_1.transform, false)

				arg_96_1.var_["10037ui_story" .. "Animator"] = var_99_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_96_1.var_["10037ui_story" .. "Animator"].applyRootMotion = true
				arg_96_1.var_["10037ui_story" .. "LipSync"] = var_99_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_99_3 = arg_96_1.actors_["10037ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10037ui_story = var_99_3.localPosition
			end

			local var_99_4 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				var_99_3.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10037ui_story, Vector3.New(0.7, -1.13, -6.2), (arg_96_1.time_ - 0) / var_99_4)
				var_99_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_3.position).x, (manager.ui.mainCamera.transform.position - var_99_3.position).y, (manager.ui.mainCamera.transform.position - var_99_3.position).z)
				var_99_3.localEulerAngles.z = 0
				var_99_3.localEulerAngles.x = 0
				var_99_3.localEulerAngles = var_99_3.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				var_99_3.localPosition = Vector3.New(0.7, -1.13, -6.2)
				var_99_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_3.position).x, (manager.ui.mainCamera.transform.position - var_99_3.position).y, (manager.ui.mainCamera.transform.position - var_99_3.position).z)
				var_99_3.localEulerAngles.z = 0
				var_99_3.localEulerAngles.x = 0
				var_99_3.localEulerAngles = var_99_3.localEulerAngles
			end

			local var_99_5 = arg_96_1.actors_["10037ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect10037ui_story == nil then
				arg_96_1.var_.characterEffect10037ui_story = var_99_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_6 and not isNil(var_99_5) then
				if arg_96_1.var_.characterEffect10037ui_story and not isNil(var_99_5) then
					arg_96_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_6 and arg_96_1.time_ < 0 + var_99_6 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect10037ui_story then
				arg_96_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_99_8 = arg_96_1.actors_["4037ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos4037ui_story = var_99_8.localPosition
			end

			local var_99_9 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_9 then
				var_99_8.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_96_1.time_ - 0) / var_99_9)
				var_99_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_8.position).x, (manager.ui.mainCamera.transform.position - var_99_8.position).y, (manager.ui.mainCamera.transform.position - var_99_8.position).z)
				var_99_8.localEulerAngles.z = 0
				var_99_8.localEulerAngles.x = 0
				var_99_8.localEulerAngles = var_99_8.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_9 and arg_96_1.time_ < 0 + var_99_9 + arg_99_0 then
				var_99_8.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				var_99_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_8.position).x, (manager.ui.mainCamera.transform.position - var_99_8.position).y, (manager.ui.mainCamera.transform.position - var_99_8.position).z)
				var_99_8.localEulerAngles.z = 0
				var_99_8.localEulerAngles.x = 0
				var_99_8.localEulerAngles = var_99_8.localEulerAngles
			end

			local var_99_10 = arg_96_1.actors_["4037ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_10) and arg_96_1.var_.characterEffect4037ui_story == nil then
				arg_96_1.var_.characterEffect4037ui_story = var_99_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_11 and not isNil(var_99_10) then
				if arg_96_1.var_.characterEffect4037ui_story and not isNil(var_99_10) then
					arg_96_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_96_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_11)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_11 and arg_96_1.time_ < 0 + var_99_11 + arg_99_0 and not isNil(var_99_10) and arg_96_1.var_.characterEffect4037ui_story then
				arg_96_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_96_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_99_12 = 0
			local var_99_13 = 0.15

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_14 = arg_96_1:GetWordFromCfg(319591022)
				local var_99_15 = arg_96_1:FormatText(var_99_14.content)

				arg_96_1.text_.text = var_99_15

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_17 = 6 <= 0 and var_99_13 or var_99_13 * (utf8.len(var_99_15) / 6)

				if (6 <= 0 and var_99_13 or var_99_13 * (utf8.len(var_99_15) / 6)) > 0 and var_99_13 < var_99_17 then
					arg_96_1.talkMaxDuration = var_99_17

					if var_99_17 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_17 + var_99_12
					end
				end

				arg_96_1.text_.text = var_99_15
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591022", "story_v_out_319591.awb") ~= 0 then
					local var_99_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591022", "story_v_out_319591.awb") / 1000

					if var_99_18 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_12
					end

					if var_99_14.prefab_name ~= "" and arg_96_1.actors_[var_99_14.prefab_name] ~= nil then
						local var_99_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_14.prefab_name].transform, "story_v_out_319591", "319591022", "story_v_out_319591.awb")

						arg_96_1:RecordAudio("319591022", var_99_19)
						arg_96_1:RecordAudio("319591022", var_99_19)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_319591", "319591022", "story_v_out_319591.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_319591", "319591022", "story_v_out_319591.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_20 = math.max(var_99_13, arg_96_1.talkMaxDuration)

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_20 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_12) / var_99_20

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_12 + var_99_20 and arg_96_1.time_ < var_99_12 + var_99_20 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play319591023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319591023
		arg_100_1.duration_ = 7.73

		local var_100_0 = {
			zh = 2.5,
			ja = 7.733
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
				arg_100_0:Play319591024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1095ui_story = arg_100_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1095ui_story"].transform.position).z)
				arg_100_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1095ui_story"].transform.localEulerAngles = arg_100_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_100_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1095ui_story"].transform.position).z)
				arg_100_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1095ui_story"].transform.localEulerAngles = arg_100_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["1095ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1095ui_story == nil then
				arg_100_1.var_.characterEffect1095ui_story = var_103_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 and not isNil(var_103_1) then
				if arg_100_1.var_.characterEffect1095ui_story and not isNil(var_103_1) then
					arg_100_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1095ui_story then
				arg_100_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_103_4 = arg_100_1.actors_["10037ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10037ui_story = var_103_4.localPosition
			end

			local var_103_5 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_5 then
				var_103_4.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_5)
				var_103_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_4.position).x, (manager.ui.mainCamera.transform.position - var_103_4.position).y, (manager.ui.mainCamera.transform.position - var_103_4.position).z)
				var_103_4.localEulerAngles.z = 0
				var_103_4.localEulerAngles.x = 0
				var_103_4.localEulerAngles = var_103_4.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_5 and arg_100_1.time_ < 0 + var_103_5 + arg_103_0 then
				var_103_4.localPosition = Vector3.New(0, 100, 0)
				var_103_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_4.position).x, (manager.ui.mainCamera.transform.position - var_103_4.position).y, (manager.ui.mainCamera.transform.position - var_103_4.position).z)
				var_103_4.localEulerAngles.z = 0
				var_103_4.localEulerAngles.x = 0
				var_103_4.localEulerAngles = var_103_4.localEulerAngles
			end

			local var_103_6 = arg_100_1.actors_["10037ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_6) and arg_100_1.var_.characterEffect10037ui_story == nil then
				arg_100_1.var_.characterEffect10037ui_story = var_103_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_7 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 and not isNil(var_103_6) then
				if arg_100_1.var_.characterEffect10037ui_story and not isNil(var_103_6) then
					arg_100_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_7)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 and not isNil(var_103_6) and arg_100_1.var_.characterEffect10037ui_story then
				arg_100_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_103_8 = arg_100_1.actors_["4037ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos4037ui_story = var_103_8.localPosition
			end

			local var_103_9 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_9 then
				var_103_8.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_9)
				var_103_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_8.position).x, (manager.ui.mainCamera.transform.position - var_103_8.position).y, (manager.ui.mainCamera.transform.position - var_103_8.position).z)
				var_103_8.localEulerAngles.z = 0
				var_103_8.localEulerAngles.x = 0
				var_103_8.localEulerAngles = var_103_8.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_9 and arg_100_1.time_ < 0 + var_103_9 + arg_103_0 then
				var_103_8.localPosition = Vector3.New(0, 100, 0)
				var_103_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_8.position).x, (manager.ui.mainCamera.transform.position - var_103_8.position).y, (manager.ui.mainCamera.transform.position - var_103_8.position).z)
				var_103_8.localEulerAngles.z = 0
				var_103_8.localEulerAngles.x = 0
				var_103_8.localEulerAngles = var_103_8.localEulerAngles
			end

			local var_103_10 = arg_100_1.actors_["4037ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_10) and arg_100_1.var_.characterEffect4037ui_story == nil then
				arg_100_1.var_.characterEffect4037ui_story = var_103_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_11 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_11 and not isNil(var_103_10) then
				if arg_100_1.var_.characterEffect4037ui_story and not isNil(var_103_10) then
					arg_100_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_100_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_11)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_11 and arg_100_1.time_ < 0 + var_103_11 + arg_103_0 and not isNil(var_103_10) and arg_100_1.var_.characterEffect4037ui_story then
				arg_100_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_100_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_103_12 = 0
			local var_103_13 = 0.3

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_14 = arg_100_1:GetWordFromCfg(319591023)
				local var_103_15 = arg_100_1:FormatText(var_103_14.content)

				arg_100_1.text_.text = var_103_15

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_17 = 12 <= 0 and var_103_13 or var_103_13 * (utf8.len(var_103_15) / 12)

				if (12 <= 0 and var_103_13 or var_103_13 * (utf8.len(var_103_15) / 12)) > 0 and var_103_13 < var_103_17 then
					arg_100_1.talkMaxDuration = var_103_17

					if var_103_17 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_17 + var_103_12
					end
				end

				arg_100_1.text_.text = var_103_15
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591023", "story_v_out_319591.awb") ~= 0 then
					local var_103_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591023", "story_v_out_319591.awb") / 1000

					if var_103_18 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_18 + var_103_12
					end

					if var_103_14.prefab_name ~= "" and arg_100_1.actors_[var_103_14.prefab_name] ~= nil then
						local var_103_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_14.prefab_name].transform, "story_v_out_319591", "319591023", "story_v_out_319591.awb")

						arg_100_1:RecordAudio("319591023", var_103_19)
						arg_100_1:RecordAudio("319591023", var_103_19)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_319591", "319591023", "story_v_out_319591.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_319591", "319591023", "story_v_out_319591.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_20 = math.max(var_103_13, arg_100_1.talkMaxDuration)

			if var_103_12 <= arg_100_1.time_ and arg_100_1.time_ < var_103_12 + var_103_20 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_12) / var_103_20

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_12 + var_103_20 and arg_100_1.time_ < var_103_12 + var_103_20 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play319591024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319591024
		arg_104_1.duration_ = 3.63

		local var_104_0 = {
			zh = 2.166,
			ja = 3.633
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
				arg_104_0:Play319591025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos4040ui_story = arg_104_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_107_0 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 then
				arg_104_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_104_1.time_ - 0) / var_107_0)
				arg_104_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["4040ui_story"].transform.position).z)
				arg_104_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["4040ui_story"].transform.localEulerAngles = arg_104_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 then
				arg_104_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_104_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["4040ui_story"].transform.position).z)
				arg_104_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["4040ui_story"].transform.localEulerAngles = arg_104_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_107_1 = arg_104_1.actors_["4040ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect4040ui_story == nil then
				arg_104_1.var_.characterEffect4040ui_story = var_107_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_2 and not isNil(var_107_1) then
				if arg_104_1.var_.characterEffect4040ui_story and not isNil(var_107_1) then
					arg_104_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_2 and arg_104_1.time_ < 0 + var_107_2 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect4040ui_story then
				arg_104_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_107_4 = arg_104_1.actors_["1095ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1095ui_story = var_107_4.localPosition
			end

			local var_107_5 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_5 then
				var_107_4.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_104_1.time_ - 0) / var_107_5)
				var_107_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_4.position).x, (manager.ui.mainCamera.transform.position - var_107_4.position).y, (manager.ui.mainCamera.transform.position - var_107_4.position).z)
				var_107_4.localEulerAngles.z = 0
				var_107_4.localEulerAngles.x = 0
				var_107_4.localEulerAngles = var_107_4.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_5 and arg_104_1.time_ < 0 + var_107_5 + arg_107_0 then
				var_107_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_107_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_4.position).x, (manager.ui.mainCamera.transform.position - var_107_4.position).y, (manager.ui.mainCamera.transform.position - var_107_4.position).z)
				var_107_4.localEulerAngles.z = 0
				var_107_4.localEulerAngles.x = 0
				var_107_4.localEulerAngles = var_107_4.localEulerAngles
			end

			local var_107_6 = arg_104_1.actors_["1095ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_6) and arg_104_1.var_.characterEffect1095ui_story == nil then
				arg_104_1.var_.characterEffect1095ui_story = var_107_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_7 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 and not isNil(var_107_6) then
				if arg_104_1.var_.characterEffect1095ui_story and not isNil(var_107_6) then
					arg_104_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_7)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 and not isNil(var_107_6) and arg_104_1.var_.characterEffect1095ui_story then
				arg_104_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_107_8 = 0
			local var_107_9 = 0.25

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 then
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

				local var_107_10 = arg_104_1:GetWordFromCfg(319591024)
				local var_107_11 = arg_104_1:FormatText(var_107_10.content)

				arg_104_1.text_.text = var_107_11

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_13 = 10 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 10)

				if (10 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 10)) > 0 and var_107_9 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_8
					end
				end

				arg_104_1.text_.text = var_107_11
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591024", "story_v_out_319591.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591024", "story_v_out_319591.awb") / 1000

					if var_107_14 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_8
					end

					if var_107_10.prefab_name ~= "" and arg_104_1.actors_[var_107_10.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_10.prefab_name].transform, "story_v_out_319591", "319591024", "story_v_out_319591.awb")

						arg_104_1:RecordAudio("319591024", var_107_15)
						arg_104_1:RecordAudio("319591024", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_319591", "319591024", "story_v_out_319591.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_319591", "319591024", "story_v_out_319591.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_9, arg_104_1.talkMaxDuration)

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_8) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_8 + var_107_16 and arg_104_1.time_ < var_107_8 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play319591025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319591025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play319591026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["4040ui_story"]) and arg_108_1.var_.characterEffect4040ui_story == nil then
				arg_108_1.var_.characterEffect4040ui_story = arg_108_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["4040ui_story"]) then
				if arg_108_1.var_.characterEffect4040ui_story and not isNil(arg_108_1.actors_["4040ui_story"]) then
					arg_108_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["4040ui_story"]) and arg_108_1.var_.characterEffect4040ui_story then
				arg_108_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.825

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

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(319591025).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 33 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 33)

				if (33 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 33)) > 0 and var_111_2 < var_111_5 then
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
	Play319591026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319591026
		arg_112_1.duration_ = 4.8

		local var_112_0 = {
			zh = 3,
			ja = 4.8
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
				arg_112_0:Play319591027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["4040ui_story"]) and arg_112_1.var_.characterEffect4040ui_story == nil then
				arg_112_1.var_.characterEffect4040ui_story = arg_112_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["4040ui_story"]) then
				if arg_112_1.var_.characterEffect4040ui_story and not isNil(arg_112_1.actors_["4040ui_story"]) then
					arg_112_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["4040ui_story"]) and arg_112_1.var_.characterEffect4040ui_story then
				arg_112_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_115_2 = 0
			local var_115_3 = 0.325

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(319591026)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 13 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 13)

				if (13 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 13)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591026", "story_v_out_319591.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_319591", "319591026", "story_v_out_319591.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_319591", "319591026", "story_v_out_319591.awb")

						arg_112_1:RecordAudio("319591026", var_115_9)
						arg_112_1:RecordAudio("319591026", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_319591", "319591026", "story_v_out_319591.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_319591", "319591026", "story_v_out_319591.awb")
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
	Play319591027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319591027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play319591028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["4040ui_story"]) and arg_116_1.var_.characterEffect4040ui_story == nil then
				arg_116_1.var_.characterEffect4040ui_story = arg_116_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["4040ui_story"]) then
				if arg_116_1.var_.characterEffect4040ui_story and not isNil(arg_116_1.actors_["4040ui_story"]) then
					arg_116_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_116_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["4040ui_story"]) and arg_116_1.var_.characterEffect4040ui_story then
				arg_116_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_116_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_119_1 = arg_116_1.actors_["4040ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos4040ui_story = var_119_1.localPosition
			end

			local var_119_2 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 then
				var_119_1.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_2)
				var_119_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_1.position).x, (manager.ui.mainCamera.transform.position - var_119_1.position).y, (manager.ui.mainCamera.transform.position - var_119_1.position).z)
				var_119_1.localEulerAngles.z = 0
				var_119_1.localEulerAngles.x = 0
				var_119_1.localEulerAngles = var_119_1.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 then
				var_119_1.localPosition = Vector3.New(0, 100, 0)
				var_119_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_1.position).x, (manager.ui.mainCamera.transform.position - var_119_1.position).y, (manager.ui.mainCamera.transform.position - var_119_1.position).z)
				var_119_1.localEulerAngles.z = 0
				var_119_1.localEulerAngles.x = 0
				var_119_1.localEulerAngles = var_119_1.localEulerAngles
			end

			local var_119_3 = arg_116_1.actors_["1095ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1095ui_story = var_119_3.localPosition
			end

			local var_119_4 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				var_119_3.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_4)
				var_119_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_3.position).x, (manager.ui.mainCamera.transform.position - var_119_3.position).y, (manager.ui.mainCamera.transform.position - var_119_3.position).z)
				var_119_3.localEulerAngles.z = 0
				var_119_3.localEulerAngles.x = 0
				var_119_3.localEulerAngles = var_119_3.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				var_119_3.localPosition = Vector3.New(0, 100, 0)
				var_119_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_3.position).x, (manager.ui.mainCamera.transform.position - var_119_3.position).y, (manager.ui.mainCamera.transform.position - var_119_3.position).z)
				var_119_3.localEulerAngles.z = 0
				var_119_3.localEulerAngles.x = 0
				var_119_3.localEulerAngles = var_119_3.localEulerAngles
			end

			local var_119_5 = 0
			local var_119_6 = 1.3

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_7 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(319591027).content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 52 <= 0 and var_119_6 or var_119_6 * (utf8.len(var_119_7) / 52)

				if (52 <= 0 and var_119_6 or var_119_6 * (utf8.len(var_119_7) / 52)) > 0 and var_119_6 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_5
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_6, arg_116_1.talkMaxDuration)

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_5) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_5 + var_119_10 and arg_116_1.time_ < var_119_5 + var_119_10 + arg_119_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play319591028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319591028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play319591029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.75

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(319591028).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 30 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 30)

				if (30 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 30)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play319591029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319591029
		arg_124_1.duration_ = 4.53

		local var_124_0 = {
			zh = 2.533,
			ja = 4.533
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
				arg_124_0:Play319591030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.25

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:GetWordFromCfg(319591029)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 10 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 10)

				if (10 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 10)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591029", "story_v_out_319591.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_319591", "319591029", "story_v_out_319591.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_319591", "319591029", "story_v_out_319591.awb")

						arg_124_1:RecordAudio("319591029", var_127_6)
						arg_124_1:RecordAudio("319591029", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_319591", "319591029", "story_v_out_319591.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_319591", "319591029", "story_v_out_319591.awb")
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
	Play319591030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319591030
		arg_128_1.duration_ = 6.97

		local var_128_0 = {
			zh = 4.5,
			ja = 6.966
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
				arg_128_0:Play319591031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1095ui_story = arg_128_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1095ui_story"].transform.position).z)
				arg_128_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1095ui_story"].transform.localEulerAngles = arg_128_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_128_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1095ui_story"].transform.position).z)
				arg_128_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1095ui_story"].transform.localEulerAngles = arg_128_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_131_1 = arg_128_1.actors_["1095ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1095ui_story == nil then
				arg_128_1.var_.characterEffect1095ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect1095ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1095ui_story then
				arg_128_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_131_4 = 0
			local var_131_5 = 0.475

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(319591030)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 19 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 19)

				if (19 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 19)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591030", "story_v_out_319591.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_319591", "319591030", "story_v_out_319591.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_319591", "319591030", "story_v_out_319591.awb")

						arg_128_1:RecordAudio("319591030", var_131_11)
						arg_128_1:RecordAudio("319591030", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_319591", "319591030", "story_v_out_319591.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_319591", "319591030", "story_v_out_319591.awb")
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
				actorName = "1095ui_story",
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
	Play319591031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319591031
		arg_132_1.duration_ = 3.2

		local var_132_0 = {
			zh = 3.2,
			ja = 3.1
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
				arg_132_0:Play319591032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1095ui_story"]) and arg_132_1.var_.characterEffect1095ui_story == nil then
				arg_132_1.var_.characterEffect1095ui_story = arg_132_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1095ui_story"]) then
				if arg_132_1.var_.characterEffect1095ui_story and not isNil(arg_132_1.actors_["1095ui_story"]) then
					arg_132_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1095ui_story"]) and arg_132_1.var_.characterEffect1095ui_story then
				arg_132_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1095ui_story.fillRatio = 0.5
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

			local var_135_4 = arg_132_1.actors_["4040ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos4040ui_story = var_135_4.localPosition
			end

			local var_135_5 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_5 then
				var_135_4.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_132_1.time_ - 0) / var_135_5)
				var_135_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_4.position).x, (manager.ui.mainCamera.transform.position - var_135_4.position).y, (manager.ui.mainCamera.transform.position - var_135_4.position).z)
				var_135_4.localEulerAngles.z = 0
				var_135_4.localEulerAngles.x = 0
				var_135_4.localEulerAngles = var_135_4.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_5 and arg_132_1.time_ < 0 + var_135_5 + arg_135_0 then
				var_135_4.localPosition = Vector3.New(0.7, -1.55, -5.5)
				var_135_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_4.position).x, (manager.ui.mainCamera.transform.position - var_135_4.position).y, (manager.ui.mainCamera.transform.position - var_135_4.position).z)
				var_135_4.localEulerAngles.z = 0
				var_135_4.localEulerAngles.x = 0
				var_135_4.localEulerAngles = var_135_4.localEulerAngles
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_135_6 = 0
			local var_135_7 = 0.275

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
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

				local var_135_8 = arg_132_1:GetWordFromCfg(319591031)
				local var_135_9 = arg_132_1:FormatText(var_135_8.content)

				arg_132_1.text_.text = var_135_9

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 11 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_9) / 11)

				if (11 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_9) / 11)) > 0 and var_135_7 < var_135_11 then
					arg_132_1.talkMaxDuration = var_135_11

					if var_135_11 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_9
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591031", "story_v_out_319591.awb") ~= 0 then
					local var_135_12 = manager.audio:GetVoiceLength("story_v_out_319591", "319591031", "story_v_out_319591.awb") / 1000

					if var_135_12 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_6
					end

					if var_135_8.prefab_name ~= "" and arg_132_1.actors_[var_135_8.prefab_name] ~= nil then
						local var_135_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_8.prefab_name].transform, "story_v_out_319591", "319591031", "story_v_out_319591.awb")

						arg_132_1:RecordAudio("319591031", var_135_13)
						arg_132_1:RecordAudio("319591031", var_135_13)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319591", "319591031", "story_v_out_319591.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319591", "319591031", "story_v_out_319591.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_14 and arg_132_1.time_ < var_135_6 + var_135_14 + arg_135_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play319591032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319591032
		arg_136_1.duration_ = 10.3

		local var_136_0 = {
			zh = 4.1,
			ja = 10.3
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
				arg_136_0:Play319591033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_139_0 = 0
			local var_139_1 = 0.4

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_2 = arg_136_1:GetWordFromCfg(319591032)
				local var_139_3 = arg_136_1:FormatText(var_139_2.content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 16 <= 0 and var_139_1 or var_139_1 * (utf8.len(var_139_3) / 16)

				if (16 <= 0 and var_139_1 or var_139_1 * (utf8.len(var_139_3) / 16)) > 0 and var_139_1 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591032", "story_v_out_319591.awb") ~= 0 then
					local var_139_6 = manager.audio:GetVoiceLength("story_v_out_319591", "319591032", "story_v_out_319591.awb") / 1000

					if var_139_6 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_0
					end

					if var_139_2.prefab_name ~= "" and arg_136_1.actors_[var_139_2.prefab_name] ~= nil then
						local var_139_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_2.prefab_name].transform, "story_v_out_319591", "319591032", "story_v_out_319591.awb")

						arg_136_1:RecordAudio("319591032", var_139_7)
						arg_136_1:RecordAudio("319591032", var_139_7)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_319591", "319591032", "story_v_out_319591.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_319591", "319591032", "story_v_out_319591.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_8 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_8 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_8

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_8 and arg_136_1.time_ < var_139_0 + var_139_8 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play319591033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319591033
		arg_140_1.duration_ = 8.4

		local var_140_0 = {
			zh = 4.066,
			ja = 8.4
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
				arg_140_0:Play319591034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["4040ui_story"]) and arg_140_1.var_.characterEffect4040ui_story == nil then
				arg_140_1.var_.characterEffect4040ui_story = arg_140_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["4040ui_story"]) then
				if arg_140_1.var_.characterEffect4040ui_story and not isNil(arg_140_1.actors_["4040ui_story"]) then
					arg_140_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_140_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["4040ui_story"]) and arg_140_1.var_.characterEffect4040ui_story then
				arg_140_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_140_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_143_1 = arg_140_1.actors_["1095ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_1) and arg_140_1.var_.characterEffect1095ui_story == nil then
				arg_140_1.var_.characterEffect1095ui_story = var_143_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 and not isNil(var_143_1) then
				if arg_140_1.var_.characterEffect1095ui_story and not isNil(var_143_1) then
					arg_140_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 and not isNil(var_143_1) and arg_140_1.var_.characterEffect1095ui_story then
				arg_140_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_143_4 = 0
			local var_143_5 = 0.55

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_6 = arg_140_1:GetWordFromCfg(319591033)
				local var_143_7 = arg_140_1:FormatText(var_143_6.content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 22 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 22)

				if (22 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 22)) > 0 and var_143_5 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591033", "story_v_out_319591.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_319591", "319591033", "story_v_out_319591.awb") / 1000

					if var_143_10 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_4
					end

					if var_143_6.prefab_name ~= "" and arg_140_1.actors_[var_143_6.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_6.prefab_name].transform, "story_v_out_319591", "319591033", "story_v_out_319591.awb")

						arg_140_1:RecordAudio("319591033", var_143_11)
						arg_140_1:RecordAudio("319591033", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_319591", "319591033", "story_v_out_319591.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_319591", "319591033", "story_v_out_319591.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_12 = math.max(var_143_5, arg_140_1.talkMaxDuration)

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_12 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_4) / var_143_12

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_4 + var_143_12 and arg_140_1.time_ < var_143_4 + var_143_12 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play319591034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319591034
		arg_144_1.duration_ = 6.3

		local var_144_0 = {
			zh = 6.3,
			ja = 6.133
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
				arg_144_0:Play319591035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["4040ui_story"]) and arg_144_1.var_.characterEffect4040ui_story == nil then
				arg_144_1.var_.characterEffect4040ui_story = arg_144_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["4040ui_story"]) then
				if arg_144_1.var_.characterEffect4040ui_story and not isNil(arg_144_1.actors_["4040ui_story"]) then
					arg_144_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["4040ui_story"]) and arg_144_1.var_.characterEffect4040ui_story then
				arg_144_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_147_2 = arg_144_1.actors_["1095ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.characterEffect1095ui_story == nil then
				arg_144_1.var_.characterEffect1095ui_story = var_147_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_3 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.characterEffect1095ui_story and not isNil(var_147_2) then
					arg_144_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_3)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.characterEffect1095ui_story then
				arg_144_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_147_4 = 0
			local var_147_5 = 0.625

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_6 = arg_144_1:GetWordFromCfg(319591034)
				local var_147_7 = arg_144_1:FormatText(var_147_6.content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 25 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 25)

				if (25 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 25)) > 0 and var_147_5 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591034", "story_v_out_319591.awb") ~= 0 then
					local var_147_10 = manager.audio:GetVoiceLength("story_v_out_319591", "319591034", "story_v_out_319591.awb") / 1000

					if var_147_10 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_4
					end

					if var_147_6.prefab_name ~= "" and arg_144_1.actors_[var_147_6.prefab_name] ~= nil then
						local var_147_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_6.prefab_name].transform, "story_v_out_319591", "319591034", "story_v_out_319591.awb")

						arg_144_1:RecordAudio("319591034", var_147_11)
						arg_144_1:RecordAudio("319591034", var_147_11)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319591", "319591034", "story_v_out_319591.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319591", "319591034", "story_v_out_319591.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_12 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_12 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_12

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_12 and arg_144_1.time_ < var_147_4 + var_147_12 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play319591035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 319591035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play319591036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["4040ui_story"]) and arg_148_1.var_.characterEffect4040ui_story == nil then
				arg_148_1.var_.characterEffect4040ui_story = arg_148_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["4040ui_story"]) then
				if arg_148_1.var_.characterEffect4040ui_story and not isNil(arg_148_1.actors_["4040ui_story"]) then
					arg_148_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_148_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_0)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["4040ui_story"]) and arg_148_1.var_.characterEffect4040ui_story then
				arg_148_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_148_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_151_1 = arg_148_1.actors_["1095ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1095ui_story == nil then
				arg_148_1.var_.characterEffect1095ui_story = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect1095ui_story and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_2)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1095ui_story then
				arg_148_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_151_3 = 0
			local var_151_4 = 1

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_3 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_5 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(319591035).content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_7 = 40 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_5) / 40)

				if (40 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_5) / 40)) > 0 and var_151_4 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_3 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_3
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_4, arg_148_1.talkMaxDuration)

			if var_151_3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_3 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_3) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_3 + var_151_8 and arg_148_1.time_ < var_151_3 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play319591036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 319591036
		arg_152_1.duration_ = 6

		local var_152_0 = {
			zh = 3.433,
			ja = 6
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
				arg_152_0:Play319591037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["4040ui_story"]) and arg_152_1.var_.characterEffect4040ui_story == nil then
				arg_152_1.var_.characterEffect4040ui_story = arg_152_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["4040ui_story"]) then
				if arg_152_1.var_.characterEffect4040ui_story and not isNil(arg_152_1.actors_["4040ui_story"]) then
					arg_152_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["4040ui_story"]) and arg_152_1.var_.characterEffect4040ui_story then
				arg_152_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_155_2 = 0
			local var_155_3 = 0.325

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
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

				local var_155_4 = arg_152_1:GetWordFromCfg(319591036)
				local var_155_5 = arg_152_1:FormatText(var_155_4.content)

				arg_152_1.text_.text = var_155_5

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 13 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 13)

				if (13 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 13)) > 0 and var_155_3 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_5
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591036", "story_v_out_319591.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_319591", "319591036", "story_v_out_319591.awb") / 1000

					if var_155_8 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_2
					end

					if var_155_4.prefab_name ~= "" and arg_152_1.actors_[var_155_4.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_4.prefab_name].transform, "story_v_out_319591", "319591036", "story_v_out_319591.awb")

						arg_152_1:RecordAudio("319591036", var_155_9)
						arg_152_1:RecordAudio("319591036", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319591", "319591036", "story_v_out_319591.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319591", "319591036", "story_v_out_319591.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_10 and arg_152_1.time_ < var_155_2 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play319591037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319591037
		arg_156_1.duration_ = 2.6

		local var_156_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_156_0:Play319591038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1095ui_story = arg_156_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1095ui_story"].transform.position).z)
				arg_156_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1095ui_story"].transform.localEulerAngles = arg_156_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_156_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1095ui_story"].transform.position).z)
				arg_156_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1095ui_story"].transform.localEulerAngles = arg_156_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1095ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1095ui_story == nil then
				arg_156_1.var_.characterEffect1095ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1095ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1095ui_story then
				arg_156_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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
			local var_159_7 = 0.05

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:GetWordFromCfg(319591037)
				local var_159_9 = arg_156_1:FormatText(var_159_8.content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 2 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 2)

				if (2 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 2)) > 0 and var_159_7 < var_159_11 then
					arg_156_1.talkMaxDuration = var_159_11

					if var_159_11 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591037", "story_v_out_319591.awb") ~= 0 then
					local var_159_12 = manager.audio:GetVoiceLength("story_v_out_319591", "319591037", "story_v_out_319591.awb") / 1000

					if var_159_12 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_6
					end

					if var_159_8.prefab_name ~= "" and arg_156_1.actors_[var_159_8.prefab_name] ~= nil then
						local var_159_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_8.prefab_name].transform, "story_v_out_319591", "319591037", "story_v_out_319591.awb")

						arg_156_1:RecordAudio("319591037", var_159_13)
						arg_156_1:RecordAudio("319591037", var_159_13)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319591", "319591037", "story_v_out_319591.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319591", "319591037", "story_v_out_319591.awb")
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
				actorName = "1095ui_story",
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
	Play319591038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319591038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play319591039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0.5 < arg_160_1.time_ and arg_160_1.time_ <= 0.5 + arg_163_0 then
				local var_163_0 = arg_160_1.bgs_.STwhite

				arg_160_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_163_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_1 = var_163_0:GetComponent("SpriteRenderer")

				if var_163_1 and var_163_1.sprite then
					local var_163_2 = 2 * (var_163_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_163_0.transform.localScale = Vector3.New(var_163_2 / var_163_1.sprite.bounds.size.y < var_163_2 * manager.ui.mainCameraCom_.aspect / var_163_1.sprite.bounds.size.x and var_163_2 * manager.ui.mainCameraCom_.aspect / var_163_1.sprite.bounds.size.x or var_163_2 / var_163_1.sprite.bounds.size.y, var_163_2 / var_163_1.sprite.bounds.size.y < var_163_2 * manager.ui.mainCameraCom_.aspect / var_163_1.sprite.bounds.size.x and var_163_2 * manager.ui.mainCameraCom_.aspect / var_163_1.sprite.bounds.size.x or var_163_2 / var_163_1.sprite.bounds.size.y, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "STwhite" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_3 = arg_160_1.actors_["1095ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1095ui_story == nil then
				arg_160_1.var_.characterEffect1095ui_story = var_163_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_4 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 and not isNil(var_163_3) then
				if arg_160_1.var_.characterEffect1095ui_story and not isNil(var_163_3) then
					arg_160_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_4)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1095ui_story then
				arg_160_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_163_5 = arg_160_1.actors_["1095ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1095ui_story = var_163_5.localPosition
			end

			local var_163_6 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_6 then
				var_163_5.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_6)
				var_163_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_5.position).x, (manager.ui.mainCamera.transform.position - var_163_5.position).y, (manager.ui.mainCamera.transform.position - var_163_5.position).z)
				var_163_5.localEulerAngles.z = 0
				var_163_5.localEulerAngles.x = 0
				var_163_5.localEulerAngles = var_163_5.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_6 and arg_160_1.time_ < 0 + var_163_6 + arg_163_0 then
				var_163_5.localPosition = Vector3.New(0, 100, 0)
				var_163_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_5.position).x, (manager.ui.mainCamera.transform.position - var_163_5.position).y, (manager.ui.mainCamera.transform.position - var_163_5.position).z)
				var_163_5.localEulerAngles.z = 0
				var_163_5.localEulerAngles.x = 0
				var_163_5.localEulerAngles = var_163_5.localEulerAngles
			end

			local var_163_7 = arg_160_1.actors_["4040ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos4040ui_story = var_163_7.localPosition
			end

			local var_163_8 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_8 then
				var_163_7.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_8)
				var_163_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_7.position).x, (manager.ui.mainCamera.transform.position - var_163_7.position).y, (manager.ui.mainCamera.transform.position - var_163_7.position).z)
				var_163_7.localEulerAngles.z = 0
				var_163_7.localEulerAngles.x = 0
				var_163_7.localEulerAngles = var_163_7.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_8 and arg_160_1.time_ < 0 + var_163_8 + arg_163_0 then
				var_163_7.localPosition = Vector3.New(0, 100, 0)
				var_163_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_7.position).x, (manager.ui.mainCamera.transform.position - var_163_7.position).y, (manager.ui.mainCamera.transform.position - var_163_7.position).z)
				var_163_7.localEulerAngles.z = 0
				var_163_7.localEulerAngles.x = 0
				var_163_7.localEulerAngles = var_163_7.localEulerAngles
			end

			local var_163_9 = 0.5

			if 0.5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_10 = 1

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_10 then
				local var_163_11 = Color.New(1, 1, 1)

				var_163_11.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_9) / var_163_10)
				arg_160_1.mask_.color = var_163_11
			end

			if arg_160_1.time_ >= var_163_9 + var_163_10 and arg_160_1.time_ < var_163_9 + var_163_10 + arg_163_0 then
				local var_163_12 = Color.New(1, 1, 1)

				arg_160_1.mask_.enabled = false
				var_163_12.a = 0
				arg_160_1.mask_.color = var_163_12
			end

			local var_163_13 = arg_160_1.bgs_.I10f.transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPosI10f = var_163_13.localPosition
			end

			local var_163_14 = 0.5

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_14 then
				var_163_13.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPosI10f, Vector3.New(0, 1, 3), (arg_160_1.time_ - 0) / var_163_14)
			end

			if arg_160_1.time_ >= 0 + var_163_14 and arg_160_1.time_ < 0 + var_163_14 + arg_163_0 then
				var_163_13.localPosition = Vector3.New(0, 1, 3)
			end

			local var_163_15 = arg_160_1.bgs_.STwhite.transform

			if 0.5 < arg_160_1.time_ and arg_160_1.time_ <= 0.5 + arg_163_0 then
				arg_160_1.var_.moveOldPosSTwhite = var_163_15.localPosition
			end

			local var_163_16 = 0.5

			if 0.5 <= arg_160_1.time_ and arg_160_1.time_ < 0.5 + var_163_16 then
				var_163_15.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPosSTwhite, Vector3.New(0, 1, 10), (arg_160_1.time_ - 0.5) / var_163_16)
			end

			if arg_160_1.time_ >= 0.5 + var_163_16 and arg_160_1.time_ < 0.5 + var_163_16 + arg_163_0 then
				var_163_15.localPosition = Vector3.New(0, 1, 10)
			end

			if 0.5 < arg_160_1.time_ and arg_160_1.time_ <= 0.5 + arg_163_0 then
				arg_160_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_whoosh", "")
			end

			local var_163_18 = 0
			local var_163_19 = 0.8

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_18 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_20 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(319591038).content)

				arg_160_1.text_.text = var_163_20

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_22 = 32 <= 0 and var_163_19 or var_163_19 * (utf8.len(var_163_20) / 32)

				if (32 <= 0 and var_163_19 or var_163_19 * (utf8.len(var_163_20) / 32)) > 0 and var_163_19 < var_163_22 then
					arg_160_1.talkMaxDuration = var_163_22

					if var_163_22 + var_163_18 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_22 + var_163_18
					end
				end

				arg_160_1.text_.text = var_163_20
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_23 = math.max(var_163_19, arg_160_1.talkMaxDuration)

			if var_163_18 <= arg_160_1.time_ and arg_160_1.time_ < var_163_18 + var_163_23 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_18) / var_163_23

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_18 + var_163_23 and arg_160_1.time_ < var_163_18 + var_163_23 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
			},
			{
				assetPath = "",
				actorName = "I10f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play319591039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319591039
		arg_164_1.duration_ = 6

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play319591040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_whoosh", "")
			end

			local var_167_1 = 0

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_2 = 1

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = Color.New(1, 1, 1)

				var_167_3.a = Mathf.Lerp(1, 0, (arg_164_1.time_ - var_167_1) / var_167_2)
				arg_164_1.mask_.color = var_167_3
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				local var_167_4 = Color.New(1, 1, 1)

				arg_164_1.mask_.enabled = false
				var_167_4.a = 0
				arg_164_1.mask_.color = var_167_4
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				local var_167_5 = arg_164_1.bgs_.I10f

				arg_164_1.bgs_.I10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_167_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_6 = var_167_5:GetComponent("SpriteRenderer")

				if var_167_6 and var_167_6.sprite then
					local var_167_7 = 2 * (var_167_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_167_5.transform.localScale = Vector3.New(var_167_7 / var_167_6.sprite.bounds.size.y < var_167_7 * manager.ui.mainCameraCom_.aspect / var_167_6.sprite.bounds.size.x and var_167_7 * manager.ui.mainCameraCom_.aspect / var_167_6.sprite.bounds.size.x or var_167_7 / var_167_6.sprite.bounds.size.y, var_167_7 / var_167_6.sprite.bounds.size.y < var_167_7 * manager.ui.mainCameraCom_.aspect / var_167_6.sprite.bounds.size.x and var_167_7 * manager.ui.mainCameraCom_.aspect / var_167_6.sprite.bounds.size.x or var_167_7 / var_167_6.sprite.bounds.size.y, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "I10f" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_8 = 1
			local var_167_9 = 1.3

			if 1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_10 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_10:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_11 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(319591039).content)

				arg_164_1.text_.text = var_167_11

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_13 = 52 <= 0 and var_167_9 or var_167_9 * (utf8.len(var_167_11) / 52)

				if (52 <= 0 and var_167_9 or var_167_9 * (utf8.len(var_167_11) / 52)) > 0 and var_167_9 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13
					var_167_8 = var_167_8 + 0.3

					if var_167_13 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_8
					end
				end

				arg_164_1.text_.text = var_167_11
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = var_167_8 + 0.3
			local var_167_15 = math.max(var_167_9, arg_164_1.talkMaxDuration)

			if var_167_8 + 0.3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_14 + var_167_15 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_14) / var_167_15

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_14 + var_167_15 and arg_164_1.time_ < var_167_14 + var_167_15 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play319591040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 319591040
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play319591041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:AudioAction("play", "effect", "se_story_127", "se_story_127_hit", "")
			end

			local var_173_1 = 0
			local var_173_2 = 1.3

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(319591040).content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 52 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 52)

				if (52 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 52)) > 0 and var_173_2 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_6 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_6 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_6

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_6 and arg_170_1.time_ < var_173_1 + var_173_6 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play319591041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 319591041
		arg_174_1.duration_ = 1.6

		local var_174_0 = {
			zh = 1.6,
			ja = 1.433
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
				arg_174_0:Play319591042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos4037ui_story = arg_174_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_177_0 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 then
				arg_174_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_174_1.time_ - 0) / var_177_0)
				arg_174_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["4037ui_story"].transform.position).z)
				arg_174_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["4037ui_story"].transform.localEulerAngles = arg_174_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 then
				arg_174_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_174_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["4037ui_story"].transform.position).z)
				arg_174_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["4037ui_story"].transform.localEulerAngles = arg_174_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_177_1 = arg_174_1.actors_["4037ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect4037ui_story == nil then
				arg_174_1.var_.characterEffect4037ui_story = var_177_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 and not isNil(var_177_1) then
				if arg_174_1.var_.characterEffect4037ui_story and not isNil(var_177_1) then
					arg_174_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect4037ui_story then
				arg_174_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_177_4 = arg_174_1.actors_["4040ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos4040ui_story = var_177_4.localPosition
			end

			local var_177_5 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_5 then
				var_177_4.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_5)
				var_177_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_4.position).x, (manager.ui.mainCamera.transform.position - var_177_4.position).y, (manager.ui.mainCamera.transform.position - var_177_4.position).z)
				var_177_4.localEulerAngles.z = 0
				var_177_4.localEulerAngles.x = 0
				var_177_4.localEulerAngles = var_177_4.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_5 and arg_174_1.time_ < 0 + var_177_5 + arg_177_0 then
				var_177_4.localPosition = Vector3.New(0, 100, 0)
				var_177_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_4.position).x, (manager.ui.mainCamera.transform.position - var_177_4.position).y, (manager.ui.mainCamera.transform.position - var_177_4.position).z)
				var_177_4.localEulerAngles.z = 0
				var_177_4.localEulerAngles.x = 0
				var_177_4.localEulerAngles = var_177_4.localEulerAngles
			end

			local var_177_6 = arg_174_1.actors_["4040ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_6) and arg_174_1.var_.characterEffect4040ui_story == nil then
				arg_174_1.var_.characterEffect4040ui_story = var_177_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_7 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 and not isNil(var_177_6) then
				if arg_174_1.var_.characterEffect4040ui_story and not isNil(var_177_6) then
					arg_174_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_174_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_7)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 and not isNil(var_177_6) and arg_174_1.var_.characterEffect4040ui_story then
				arg_174_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_174_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_177_8 = arg_174_1.actors_["1095ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1095ui_story = var_177_8.localPosition
			end

			local var_177_9 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_9 then
				var_177_8.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_9)
				var_177_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_8.position).x, (manager.ui.mainCamera.transform.position - var_177_8.position).y, (manager.ui.mainCamera.transform.position - var_177_8.position).z)
				var_177_8.localEulerAngles.z = 0
				var_177_8.localEulerAngles.x = 0
				var_177_8.localEulerAngles = var_177_8.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_9 and arg_174_1.time_ < 0 + var_177_9 + arg_177_0 then
				var_177_8.localPosition = Vector3.New(0, 100, 0)
				var_177_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_8.position).x, (manager.ui.mainCamera.transform.position - var_177_8.position).y, (manager.ui.mainCamera.transform.position - var_177_8.position).z)
				var_177_8.localEulerAngles.z = 0
				var_177_8.localEulerAngles.x = 0
				var_177_8.localEulerAngles = var_177_8.localEulerAngles
			end

			local var_177_10 = arg_174_1.actors_["1095ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_10) and arg_174_1.var_.characterEffect1095ui_story == nil then
				arg_174_1.var_.characterEffect1095ui_story = var_177_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_11 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_11 and not isNil(var_177_10) then
				if arg_174_1.var_.characterEffect1095ui_story and not isNil(var_177_10) then
					arg_174_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_11)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_11 and arg_174_1.time_ < 0 + var_177_11 + arg_177_0 and not isNil(var_177_10) and arg_174_1.var_.characterEffect1095ui_story then
				arg_174_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_177_12 = 0
			local var_177_13 = 0.125

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_12 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_14 = arg_174_1:GetWordFromCfg(319591041)
				local var_177_15 = arg_174_1:FormatText(var_177_14.content)

				arg_174_1.text_.text = var_177_15

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_17 = 5 <= 0 and var_177_13 or var_177_13 * (utf8.len(var_177_15) / 5)

				if (5 <= 0 and var_177_13 or var_177_13 * (utf8.len(var_177_15) / 5)) > 0 and var_177_13 < var_177_17 then
					arg_174_1.talkMaxDuration = var_177_17

					if var_177_17 + var_177_12 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_17 + var_177_12
					end
				end

				arg_174_1.text_.text = var_177_15
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591041", "story_v_out_319591.awb") ~= 0 then
					local var_177_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591041", "story_v_out_319591.awb") / 1000

					if var_177_18 + var_177_12 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_18 + var_177_12
					end

					if var_177_14.prefab_name ~= "" and arg_174_1.actors_[var_177_14.prefab_name] ~= nil then
						local var_177_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_14.prefab_name].transform, "story_v_out_319591", "319591041", "story_v_out_319591.awb")

						arg_174_1:RecordAudio("319591041", var_177_19)
						arg_174_1:RecordAudio("319591041", var_177_19)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_319591", "319591041", "story_v_out_319591.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_319591", "319591041", "story_v_out_319591.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_20 = math.max(var_177_13, arg_174_1.talkMaxDuration)

			if var_177_12 <= arg_174_1.time_ and arg_174_1.time_ < var_177_12 + var_177_20 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_12) / var_177_20

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_12 + var_177_20 and arg_174_1.time_ < var_177_12 + var_177_20 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play319591042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 319591042
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play319591043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["4037ui_story"]) and arg_178_1.var_.characterEffect4037ui_story == nil then
				arg_178_1.var_.characterEffect4037ui_story = arg_178_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["4037ui_story"]) then
				if arg_178_1.var_.characterEffect4037ui_story and not isNil(arg_178_1.actors_["4037ui_story"]) then
					arg_178_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_178_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["4037ui_story"]) and arg_178_1.var_.characterEffect4037ui_story then
				arg_178_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_178_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_181_1 = 0
			local var_181_2 = 1.175

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(319591042).content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 47 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 47)

				if (47 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 47)) > 0 and var_181_2 < var_181_5 then
					arg_178_1.talkMaxDuration = var_181_5

					if var_181_5 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_6 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_6 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_6

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_6 and arg_178_1.time_ < var_181_1 + var_181_6 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play319591043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 319591043
		arg_182_1.duration_ = 2

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play319591044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10079ui_story = arg_182_1.actors_["10079ui_story"].transform.localPosition

				arg_182_1:ShowWeapon(arg_182_1.var_["10079ui_story" .. "Animator"].transform, true)
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).z)
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles = arg_182_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_182_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["10079ui_story"].transform.position).z)
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["10079ui_story"].transform.localEulerAngles = arg_182_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["10079ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect10079ui_story == nil then
				arg_182_1.var_.characterEffect10079ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect10079ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect10079ui_story then
				arg_182_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_185_4 = arg_182_1.actors_["4037ui_story"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos4037ui_story = var_185_4.localPosition
			end

			local var_185_5 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_5 then
				var_185_4.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_182_1.time_ - 0) / var_185_5)
				var_185_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_4.position).x, (manager.ui.mainCamera.transform.position - var_185_4.position).y, (manager.ui.mainCamera.transform.position - var_185_4.position).z)
				var_185_4.localEulerAngles.z = 0
				var_185_4.localEulerAngles.x = 0
				var_185_4.localEulerAngles = var_185_4.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_5 and arg_182_1.time_ < 0 + var_185_5 + arg_185_0 then
				var_185_4.localPosition = Vector3.New(0, 100, 0)
				var_185_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_185_4.position).x, (manager.ui.mainCamera.transform.position - var_185_4.position).y, (manager.ui.mainCamera.transform.position - var_185_4.position).z)
				var_185_4.localEulerAngles.z = 0
				var_185_4.localEulerAngles.x = 0
				var_185_4.localEulerAngles = var_185_4.localEulerAngles
			end

			local var_185_6 = arg_182_1.actors_["4037ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect4037ui_story == nil then
				arg_182_1.var_.characterEffect4037ui_story = var_185_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_7 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 and not isNil(var_185_6) then
				if arg_182_1.var_.characterEffect4037ui_story and not isNil(var_185_6) then
					arg_182_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_182_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_7)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect4037ui_story then
				arg_182_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_182_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_185_8 = 0
			local var_185_9 = 0.075

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_8 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_10 = arg_182_1:GetWordFromCfg(319591043)
				local var_185_11 = arg_182_1:FormatText(var_185_10.content)

				arg_182_1.text_.text = var_185_11

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_13 = 3 <= 0 and var_185_9 or var_185_9 * (utf8.len(var_185_11) / 3)

				if (3 <= 0 and var_185_9 or var_185_9 * (utf8.len(var_185_11) / 3)) > 0 and var_185_9 < var_185_13 then
					arg_182_1.talkMaxDuration = var_185_13

					if var_185_13 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_13 + var_185_8
					end
				end

				arg_182_1.text_.text = var_185_11
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591043", "story_v_out_319591.awb") ~= 0 then
					local var_185_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591043", "story_v_out_319591.awb") / 1000

					if var_185_14 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_8
					end

					if var_185_10.prefab_name ~= "" and arg_182_1.actors_[var_185_10.prefab_name] ~= nil then
						local var_185_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_10.prefab_name].transform, "story_v_out_319591", "319591043", "story_v_out_319591.awb")

						arg_182_1:RecordAudio("319591043", var_185_15)
						arg_182_1:RecordAudio("319591043", var_185_15)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_319591", "319591043", "story_v_out_319591.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_319591", "319591043", "story_v_out_319591.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_16 = math.max(var_185_9, arg_182_1.talkMaxDuration)

			if var_185_8 <= arg_182_1.time_ and arg_182_1.time_ < var_185_8 + var_185_16 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_8) / var_185_16

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_8 + var_185_16 and arg_182_1.time_ < var_185_8 + var_185_16 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play319591044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 319591044
		arg_186_1.duration_ = 2

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play319591045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1095ui_story = arg_186_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1095ui_story"].transform.position).z)
				arg_186_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1095ui_story"].transform.localEulerAngles = arg_186_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_186_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1095ui_story"].transform.position).z)
				arg_186_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1095ui_story"].transform.localEulerAngles = arg_186_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_189_1 = arg_186_1.actors_["1095ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1095ui_story == nil then
				arg_186_1.var_.characterEffect1095ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 and not isNil(var_189_1) then
				if arg_186_1.var_.characterEffect1095ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1095ui_story then
				arg_186_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_189_4 = arg_186_1.actors_["10079ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10079ui_story = var_189_4.localPosition
			end

			local var_189_5 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_5 then
				var_189_4.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_186_1.time_ - 0) / var_189_5)
				var_189_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_4.position).x, (manager.ui.mainCamera.transform.position - var_189_4.position).y, (manager.ui.mainCamera.transform.position - var_189_4.position).z)
				var_189_4.localEulerAngles.z = 0
				var_189_4.localEulerAngles.x = 0
				var_189_4.localEulerAngles = var_189_4.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_5 and arg_186_1.time_ < 0 + var_189_5 + arg_189_0 then
				var_189_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_189_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_4.position).x, (manager.ui.mainCamera.transform.position - var_189_4.position).y, (manager.ui.mainCamera.transform.position - var_189_4.position).z)
				var_189_4.localEulerAngles.z = 0
				var_189_4.localEulerAngles.x = 0
				var_189_4.localEulerAngles = var_189_4.localEulerAngles
			end

			local var_189_6 = arg_186_1.actors_["10079ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_6) and arg_186_1.var_.characterEffect10079ui_story == nil then
				arg_186_1.var_.characterEffect10079ui_story = var_189_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_7 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 and not isNil(var_189_6) then
				if arg_186_1.var_.characterEffect10079ui_story and not isNil(var_189_6) then
					arg_186_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_186_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_7)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 and not isNil(var_189_6) and arg_186_1.var_.characterEffect10079ui_story then
				arg_186_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_186_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_189_8 = 0
			local var_189_9 = 0.125

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_10 = arg_186_1:GetWordFromCfg(319591044)
				local var_189_11 = arg_186_1:FormatText(var_189_10.content)

				arg_186_1.text_.text = var_189_11

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 5 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 5)

				if (5 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 5)) > 0 and var_189_9 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_8
					end
				end

				arg_186_1.text_.text = var_189_11
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591044", "story_v_out_319591.awb") ~= 0 then
					local var_189_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591044", "story_v_out_319591.awb") / 1000

					if var_189_14 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_14 + var_189_8
					end

					if var_189_10.prefab_name ~= "" and arg_186_1.actors_[var_189_10.prefab_name] ~= nil then
						local var_189_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_10.prefab_name].transform, "story_v_out_319591", "319591044", "story_v_out_319591.awb")

						arg_186_1:RecordAudio("319591044", var_189_15)
						arg_186_1:RecordAudio("319591044", var_189_15)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_319591", "319591044", "story_v_out_319591.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_319591", "319591044", "story_v_out_319591.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_9, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_16 and arg_186_1.time_ < var_189_8 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_186_1:InitPlayNodeList()
	end,
	Play319591045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 319591045
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play319591046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1095ui_story"]) and arg_190_1.var_.characterEffect1095ui_story == nil then
				arg_190_1.var_.characterEffect1095ui_story = arg_190_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1095ui_story"]) then
				if arg_190_1.var_.characterEffect1095ui_story and not isNil(arg_190_1.actors_["1095ui_story"]) then
					arg_190_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1095ui_story"]) and arg_190_1.var_.characterEffect1095ui_story then
				arg_190_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_193_1 = arg_190_1.actors_["10079ui_story"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos10079ui_story = var_193_1.localPosition
			end

			local var_193_2 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 then
				var_193_1.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_190_1.time_ - 0) / var_193_2)
				var_193_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_1.position).x, (manager.ui.mainCamera.transform.position - var_193_1.position).y, (manager.ui.mainCamera.transform.position - var_193_1.position).z)
				var_193_1.localEulerAngles.z = 0
				var_193_1.localEulerAngles.x = 0
				var_193_1.localEulerAngles = var_193_1.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 then
				var_193_1.localPosition = Vector3.New(0, 100, 0)
				var_193_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_1.position).x, (manager.ui.mainCamera.transform.position - var_193_1.position).y, (manager.ui.mainCamera.transform.position - var_193_1.position).z)
				var_193_1.localEulerAngles.z = 0
				var_193_1.localEulerAngles.x = 0
				var_193_1.localEulerAngles = var_193_1.localEulerAngles
			end

			local var_193_3 = arg_190_1.actors_["1095ui_story"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1095ui_story = var_193_3.localPosition
			end

			local var_193_4 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				var_193_3.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_190_1.time_ - 0) / var_193_4)
				var_193_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_3.position).x, (manager.ui.mainCamera.transform.position - var_193_3.position).y, (manager.ui.mainCamera.transform.position - var_193_3.position).z)
				var_193_3.localEulerAngles.z = 0
				var_193_3.localEulerAngles.x = 0
				var_193_3.localEulerAngles = var_193_3.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				var_193_3.localPosition = Vector3.New(0, 100, 0)
				var_193_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_3.position).x, (manager.ui.mainCamera.transform.position - var_193_3.position).y, (manager.ui.mainCamera.transform.position - var_193_3.position).z)
				var_193_3.localEulerAngles.z = 0
				var_193_3.localEulerAngles.x = 0
				var_193_3.localEulerAngles = var_193_3.localEulerAngles
			end

			local var_193_5 = 0
			local var_193_6 = 1.2

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_7 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(319591045).content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 48 <= 0 and var_193_6 or var_193_6 * (utf8.len(var_193_7) / 48)

				if (48 <= 0 and var_193_6 or var_193_6 * (utf8.len(var_193_7) / 48)) > 0 and var_193_6 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_5 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_5
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_6, arg_190_1.talkMaxDuration)

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_5) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_5 + var_193_10 and arg_190_1.time_ < var_193_5 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play319591046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 319591046
		arg_194_1.duration_ = 5.83

		local var_194_0 = {
			zh = 4.4,
			ja = 5.833
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
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play319591047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos4040ui_story = arg_194_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_197_0 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 then
				arg_194_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_194_1.time_ - 0) / var_197_0)
				arg_194_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["4040ui_story"].transform.position).z)
				arg_194_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["4040ui_story"].transform.localEulerAngles = arg_194_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 then
				arg_194_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_194_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["4040ui_story"].transform.position).z)
				arg_194_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["4040ui_story"].transform.localEulerAngles = arg_194_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_197_1 = arg_194_1.actors_["4040ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect4040ui_story == nil then
				arg_194_1.var_.characterEffect4040ui_story = var_197_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_2 and not isNil(var_197_1) then
				if arg_194_1.var_.characterEffect4040ui_story and not isNil(var_197_1) then
					arg_194_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_2 and arg_194_1.time_ < 0 + var_197_2 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect4040ui_story then
				arg_194_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_197_4 = arg_194_1.actors_["1095ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1095ui_story = var_197_4.localPosition
			end

			local var_197_5 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_5 then
				var_197_4.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_194_1.time_ - 0) / var_197_5)
				var_197_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_4.position).x, (manager.ui.mainCamera.transform.position - var_197_4.position).y, (manager.ui.mainCamera.transform.position - var_197_4.position).z)
				var_197_4.localEulerAngles.z = 0
				var_197_4.localEulerAngles.x = 0
				var_197_4.localEulerAngles = var_197_4.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_5 and arg_194_1.time_ < 0 + var_197_5 + arg_197_0 then
				var_197_4.localPosition = Vector3.New(0, 100, 0)
				var_197_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_4.position).x, (manager.ui.mainCamera.transform.position - var_197_4.position).y, (manager.ui.mainCamera.transform.position - var_197_4.position).z)
				var_197_4.localEulerAngles.z = 0
				var_197_4.localEulerAngles.x = 0
				var_197_4.localEulerAngles = var_197_4.localEulerAngles
			end

			local var_197_6 = arg_194_1.actors_["1095ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1095ui_story == nil then
				arg_194_1.var_.characterEffect1095ui_story = var_197_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_7 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 and not isNil(var_197_6) then
				if arg_194_1.var_.characterEffect1095ui_story and not isNil(var_197_6) then
					arg_194_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_7)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1095ui_story then
				arg_194_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_197_8 = arg_194_1.actors_["10079ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos10079ui_story = var_197_8.localPosition
			end

			local var_197_9 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_9 then
				var_197_8.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_194_1.time_ - 0) / var_197_9)
				var_197_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_8.position).x, (manager.ui.mainCamera.transform.position - var_197_8.position).y, (manager.ui.mainCamera.transform.position - var_197_8.position).z)
				var_197_8.localEulerAngles.z = 0
				var_197_8.localEulerAngles.x = 0
				var_197_8.localEulerAngles = var_197_8.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_9 and arg_194_1.time_ < 0 + var_197_9 + arg_197_0 then
				var_197_8.localPosition = Vector3.New(0, 100, 0)
				var_197_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_8.position).x, (manager.ui.mainCamera.transform.position - var_197_8.position).y, (manager.ui.mainCamera.transform.position - var_197_8.position).z)
				var_197_8.localEulerAngles.z = 0
				var_197_8.localEulerAngles.x = 0
				var_197_8.localEulerAngles = var_197_8.localEulerAngles
			end

			local var_197_10 = arg_194_1.actors_["10079ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_10) and arg_194_1.var_.characterEffect10079ui_story == nil then
				arg_194_1.var_.characterEffect10079ui_story = var_197_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_11 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_11 and not isNil(var_197_10) then
				if arg_194_1.var_.characterEffect10079ui_story and not isNil(var_197_10) then
					arg_194_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_194_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_11)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_11 and arg_194_1.time_ < 0 + var_197_11 + arg_197_0 and not isNil(var_197_10) and arg_194_1.var_.characterEffect10079ui_story then
				arg_194_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_194_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_197_12 = 0
			local var_197_13 = 0.35

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_12 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_14 = arg_194_1:GetWordFromCfg(319591046)
				local var_197_15 = arg_194_1:FormatText(var_197_14.content)

				arg_194_1.text_.text = var_197_15

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_17 = 14 <= 0 and var_197_13 or var_197_13 * (utf8.len(var_197_15) / 14)

				if (14 <= 0 and var_197_13 or var_197_13 * (utf8.len(var_197_15) / 14)) > 0 and var_197_13 < var_197_17 then
					arg_194_1.talkMaxDuration = var_197_17

					if var_197_17 + var_197_12 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_17 + var_197_12
					end
				end

				arg_194_1.text_.text = var_197_15
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591046", "story_v_out_319591.awb") ~= 0 then
					local var_197_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591046", "story_v_out_319591.awb") / 1000

					if var_197_18 + var_197_12 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_18 + var_197_12
					end

					if var_197_14.prefab_name ~= "" and arg_194_1.actors_[var_197_14.prefab_name] ~= nil then
						local var_197_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_14.prefab_name].transform, "story_v_out_319591", "319591046", "story_v_out_319591.awb")

						arg_194_1:RecordAudio("319591046", var_197_19)
						arg_194_1:RecordAudio("319591046", var_197_19)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_319591", "319591046", "story_v_out_319591.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_319591", "319591046", "story_v_out_319591.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_20 = math.max(var_197_13, arg_194_1.talkMaxDuration)

			if var_197_12 <= arg_194_1.time_ and arg_194_1.time_ < var_197_12 + var_197_20 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_12) / var_197_20

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_12 + var_197_20 and arg_194_1.time_ < var_197_12 + var_197_20 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
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

		arg_194_1:InitPlayNodeList()
	end,
	Play319591047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 319591047
		arg_198_1.duration_ = 6

		local var_198_0 = {
			zh = 5.066,
			ja = 6
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play319591048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos10079ui_story = arg_198_1.actors_["10079ui_story"].transform.localPosition

				arg_198_1:ShowWeapon(arg_198_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10079ui_story"].transform.position).z)
				arg_198_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["10079ui_story"].transform.localEulerAngles = arg_198_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_198_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10079ui_story"].transform.position).z)
				arg_198_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["10079ui_story"].transform.localEulerAngles = arg_198_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["10079ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect10079ui_story == nil then
				arg_198_1.var_.characterEffect10079ui_story = var_201_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 and not isNil(var_201_1) then
				if arg_198_1.var_.characterEffect10079ui_story and not isNil(var_201_1) then
					arg_198_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect10079ui_story then
				arg_198_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_201_4 = arg_198_1.actors_["4040ui_story"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos4040ui_story = var_201_4.localPosition
			end

			local var_201_5 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_5 then
				var_201_4.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_198_1.time_ - 0) / var_201_5)
				var_201_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_4.position).x, (manager.ui.mainCamera.transform.position - var_201_4.position).y, (manager.ui.mainCamera.transform.position - var_201_4.position).z)
				var_201_4.localEulerAngles.z = 0
				var_201_4.localEulerAngles.x = 0
				var_201_4.localEulerAngles = var_201_4.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_5 and arg_198_1.time_ < 0 + var_201_5 + arg_201_0 then
				var_201_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_201_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_4.position).x, (manager.ui.mainCamera.transform.position - var_201_4.position).y, (manager.ui.mainCamera.transform.position - var_201_4.position).z)
				var_201_4.localEulerAngles.z = 0
				var_201_4.localEulerAngles.x = 0
				var_201_4.localEulerAngles = var_201_4.localEulerAngles
			end

			local var_201_6 = arg_198_1.actors_["4040ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect4040ui_story == nil then
				arg_198_1.var_.characterEffect4040ui_story = var_201_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_7 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 and not isNil(var_201_6) then
				if arg_198_1.var_.characterEffect4040ui_story and not isNil(var_201_6) then
					arg_198_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_198_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_7)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect4040ui_story then
				arg_198_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_198_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_201_8 = 0
			local var_201_9 = 0.675

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:GetWordFromCfg(319591047)
				local var_201_11 = arg_198_1:FormatText(var_201_10.content)

				arg_198_1.text_.text = var_201_11

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_13 = 27 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 27)

				if (27 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 27)) > 0 and var_201_9 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_8
					end
				end

				arg_198_1.text_.text = var_201_11
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591047", "story_v_out_319591.awb") ~= 0 then
					local var_201_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591047", "story_v_out_319591.awb") / 1000

					if var_201_14 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_8
					end

					if var_201_10.prefab_name ~= "" and arg_198_1.actors_[var_201_10.prefab_name] ~= nil then
						local var_201_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_10.prefab_name].transform, "story_v_out_319591", "319591047", "story_v_out_319591.awb")

						arg_198_1:RecordAudio("319591047", var_201_15)
						arg_198_1:RecordAudio("319591047", var_201_15)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_319591", "319591047", "story_v_out_319591.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_319591", "319591047", "story_v_out_319591.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_9, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_16 and arg_198_1.time_ < var_201_8 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_198_1:InitPlayNodeList()
	end,
	Play319591048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319591048
		arg_202_1.duration_ = 10.97

		local var_202_0 = {
			zh = 3.233,
			ja = 10.966
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play319591049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["10079ui_story"]) and arg_202_1.var_.characterEffect10079ui_story == nil then
				arg_202_1.var_.characterEffect10079ui_story = arg_202_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["10079ui_story"]) then
				if arg_202_1.var_.characterEffect10079ui_story and not isNil(arg_202_1.actors_["10079ui_story"]) then
					arg_202_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_202_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["10079ui_story"]) and arg_202_1.var_.characterEffect10079ui_story then
				arg_202_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_202_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_205_1 = arg_202_1.actors_["4040ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect4040ui_story == nil then
				arg_202_1.var_.characterEffect4040ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 and not isNil(var_205_1) then
				if arg_202_1.var_.characterEffect4040ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect4040ui_story then
				arg_202_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_205_4 = 0
			local var_205_5 = 0.35

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_6 = arg_202_1:GetWordFromCfg(319591048)
				local var_205_7 = arg_202_1:FormatText(var_205_6.content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_9 = 14 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 14)

				if (14 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 14)) > 0 and var_205_5 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9

					if var_205_9 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_4
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591048", "story_v_out_319591.awb") ~= 0 then
					local var_205_10 = manager.audio:GetVoiceLength("story_v_out_319591", "319591048", "story_v_out_319591.awb") / 1000

					if var_205_10 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_4
					end

					if var_205_6.prefab_name ~= "" and arg_202_1.actors_[var_205_6.prefab_name] ~= nil then
						local var_205_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_6.prefab_name].transform, "story_v_out_319591", "319591048", "story_v_out_319591.awb")

						arg_202_1:RecordAudio("319591048", var_205_11)
						arg_202_1:RecordAudio("319591048", var_205_11)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_319591", "319591048", "story_v_out_319591.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_319591", "319591048", "story_v_out_319591.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_12 = math.max(var_205_5, arg_202_1.talkMaxDuration)

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_12 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_4) / var_205_12

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_4 + var_205_12 and arg_202_1.time_ < var_205_4 + var_205_12 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play319591049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319591049
		arg_206_1.duration_ = 4.63

		local var_206_0 = {
			zh = 3.433,
			ja = 4.633
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play319591050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos10079ui_story = arg_206_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10079ui_story"].transform.position).z)
				arg_206_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["10079ui_story"].transform.localEulerAngles = arg_206_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_206_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10079ui_story"].transform.position).z)
				arg_206_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["10079ui_story"].transform.localEulerAngles = arg_206_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["10079ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect10079ui_story == nil then
				arg_206_1.var_.characterEffect10079ui_story = var_209_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 and not isNil(var_209_1) then
				if arg_206_1.var_.characterEffect10079ui_story and not isNil(var_209_1) then
					arg_206_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect10079ui_story then
				arg_206_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_209_4 = arg_206_1.actors_["4040ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_4) and arg_206_1.var_.characterEffect4040ui_story == nil then
				arg_206_1.var_.characterEffect4040ui_story = var_209_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_5 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_5 and not isNil(var_209_4) then
				if arg_206_1.var_.characterEffect4040ui_story and not isNil(var_209_4) then
					arg_206_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_206_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_5)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_5 and arg_206_1.time_ < 0 + var_209_5 + arg_209_0 and not isNil(var_209_4) and arg_206_1.var_.characterEffect4040ui_story then
				arg_206_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_206_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_209_6 = 0
			local var_209_7 = 0.425

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_6 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_8 = arg_206_1:GetWordFromCfg(319591049)
				local var_209_9 = arg_206_1:FormatText(var_209_8.content)

				arg_206_1.text_.text = var_209_9

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_11 = 17 <= 0 and var_209_7 or var_209_7 * (utf8.len(var_209_9) / 17)

				if (17 <= 0 and var_209_7 or var_209_7 * (utf8.len(var_209_9) / 17)) > 0 and var_209_7 < var_209_11 then
					arg_206_1.talkMaxDuration = var_209_11

					if var_209_11 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_11 + var_209_6
					end
				end

				arg_206_1.text_.text = var_209_9
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591049", "story_v_out_319591.awb") ~= 0 then
					local var_209_12 = manager.audio:GetVoiceLength("story_v_out_319591", "319591049", "story_v_out_319591.awb") / 1000

					if var_209_12 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_12 + var_209_6
					end

					if var_209_8.prefab_name ~= "" and arg_206_1.actors_[var_209_8.prefab_name] ~= nil then
						local var_209_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_8.prefab_name].transform, "story_v_out_319591", "319591049", "story_v_out_319591.awb")

						arg_206_1:RecordAudio("319591049", var_209_13)
						arg_206_1:RecordAudio("319591049", var_209_13)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_319591", "319591049", "story_v_out_319591.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_319591", "319591049", "story_v_out_319591.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_14 = math.max(var_209_7, arg_206_1.talkMaxDuration)

			if var_209_6 <= arg_206_1.time_ and arg_206_1.time_ < var_209_6 + var_209_14 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_6) / var_209_14

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_6 + var_209_14 and arg_206_1.time_ < var_209_6 + var_209_14 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play319591050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 319591050
		arg_210_1.duration_ = 9.93

		local var_210_0 = {
			zh = 7.3,
			ja = 9.933
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play319591051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10079ui_story"]) and arg_210_1.var_.characterEffect10079ui_story == nil then
				arg_210_1.var_.characterEffect10079ui_story = arg_210_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10079ui_story"]) then
				if arg_210_1.var_.characterEffect10079ui_story and not isNil(arg_210_1.actors_["10079ui_story"]) then
					arg_210_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_210_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_0)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10079ui_story"]) and arg_210_1.var_.characterEffect10079ui_story then
				arg_210_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_210_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_213_1 = arg_210_1.actors_["4040ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect4040ui_story == nil then
				arg_210_1.var_.characterEffect4040ui_story = var_213_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 and not isNil(var_213_1) then
				if arg_210_1.var_.characterEffect4040ui_story and not isNil(var_213_1) then
					arg_210_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect4040ui_story then
				arg_210_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_213_4 = 0
			local var_213_5 = 0.45

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(319591050)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 18 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 18)

				if (18 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 18)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591050", "story_v_out_319591.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_out_319591", "319591050", "story_v_out_319591.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_out_319591", "319591050", "story_v_out_319591.awb")

						arg_210_1:RecordAudio("319591050", var_213_11)
						arg_210_1:RecordAudio("319591050", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_319591", "319591050", "story_v_out_319591.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_319591", "319591050", "story_v_out_319591.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play319591051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 319591051
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play319591052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["4040ui_story"]) and arg_214_1.var_.characterEffect4040ui_story == nil then
				arg_214_1.var_.characterEffect4040ui_story = arg_214_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["4040ui_story"]) then
				if arg_214_1.var_.characterEffect4040ui_story and not isNil(arg_214_1.actors_["4040ui_story"]) then
					arg_214_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_214_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["4040ui_story"]) and arg_214_1.var_.characterEffect4040ui_story then
				arg_214_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_214_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.975

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(319591051).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 39 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 39)

				if (39 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 39)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play319591052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 319591052
		arg_218_1.duration_ = 5.47

		local var_218_0 = {
			zh = 5.466,
			ja = 4.9
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play319591053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1095ui_story = arg_218_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1095ui_story"].transform.position).z)
				arg_218_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1095ui_story"].transform.localEulerAngles = arg_218_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_218_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1095ui_story"].transform.position).z)
				arg_218_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1095ui_story"].transform.localEulerAngles = arg_218_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_221_1 = arg_218_1.actors_["1095ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1095ui_story == nil then
				arg_218_1.var_.characterEffect1095ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_2 and not isNil(var_221_1) then
				if arg_218_1.var_.characterEffect1095ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_2 and arg_218_1.time_ < 0 + var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1095ui_story then
				arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_221_4 = arg_218_1.actors_["10079ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10079ui_story = var_221_4.localPosition
			end

			local var_221_5 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_5 then
				var_221_4.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_5)
				var_221_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_4.position).x, (manager.ui.mainCamera.transform.position - var_221_4.position).y, (manager.ui.mainCamera.transform.position - var_221_4.position).z)
				var_221_4.localEulerAngles.z = 0
				var_221_4.localEulerAngles.x = 0
				var_221_4.localEulerAngles = var_221_4.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_5 and arg_218_1.time_ < 0 + var_221_5 + arg_221_0 then
				var_221_4.localPosition = Vector3.New(0, 100, 0)
				var_221_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_4.position).x, (manager.ui.mainCamera.transform.position - var_221_4.position).y, (manager.ui.mainCamera.transform.position - var_221_4.position).z)
				var_221_4.localEulerAngles.z = 0
				var_221_4.localEulerAngles.x = 0
				var_221_4.localEulerAngles = var_221_4.localEulerAngles
			end

			local var_221_6 = arg_218_1.actors_["10079ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_6) and arg_218_1.var_.characterEffect10079ui_story == nil then
				arg_218_1.var_.characterEffect10079ui_story = var_221_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_7 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 and not isNil(var_221_6) then
				if arg_218_1.var_.characterEffect10079ui_story and not isNil(var_221_6) then
					arg_218_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_7)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 and not isNil(var_221_6) and arg_218_1.var_.characterEffect10079ui_story then
				arg_218_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_221_8 = arg_218_1.actors_["4040ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos4040ui_story = var_221_8.localPosition
			end

			local var_221_9 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_9 then
				var_221_8.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_9)
				var_221_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_8.position).x, (manager.ui.mainCamera.transform.position - var_221_8.position).y, (manager.ui.mainCamera.transform.position - var_221_8.position).z)
				var_221_8.localEulerAngles.z = 0
				var_221_8.localEulerAngles.x = 0
				var_221_8.localEulerAngles = var_221_8.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_9 and arg_218_1.time_ < 0 + var_221_9 + arg_221_0 then
				var_221_8.localPosition = Vector3.New(0, 100, 0)
				var_221_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_8.position).x, (manager.ui.mainCamera.transform.position - var_221_8.position).y, (manager.ui.mainCamera.transform.position - var_221_8.position).z)
				var_221_8.localEulerAngles.z = 0
				var_221_8.localEulerAngles.x = 0
				var_221_8.localEulerAngles = var_221_8.localEulerAngles
			end

			local var_221_10 = arg_218_1.actors_["4040ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_10) and arg_218_1.var_.characterEffect4040ui_story == nil then
				arg_218_1.var_.characterEffect4040ui_story = var_221_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_11 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_11 and not isNil(var_221_10) then
				if arg_218_1.var_.characterEffect4040ui_story and not isNil(var_221_10) then
					arg_218_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_218_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_11)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_11 and arg_218_1.time_ < 0 + var_221_11 + arg_221_0 and not isNil(var_221_10) and arg_218_1.var_.characterEffect4040ui_story then
				arg_218_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_218_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_221_12 = 0
			local var_221_13 = 0.6

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_14 = arg_218_1:GetWordFromCfg(319591052)
				local var_221_15 = arg_218_1:FormatText(var_221_14.content)

				arg_218_1.text_.text = var_221_15

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_17 = 24 <= 0 and var_221_13 or var_221_13 * (utf8.len(var_221_15) / 24)

				if (24 <= 0 and var_221_13 or var_221_13 * (utf8.len(var_221_15) / 24)) > 0 and var_221_13 < var_221_17 then
					arg_218_1.talkMaxDuration = var_221_17

					if var_221_17 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_17 + var_221_12
					end
				end

				arg_218_1.text_.text = var_221_15
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591052", "story_v_out_319591.awb") ~= 0 then
					local var_221_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591052", "story_v_out_319591.awb") / 1000

					if var_221_18 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_18 + var_221_12
					end

					if var_221_14.prefab_name ~= "" and arg_218_1.actors_[var_221_14.prefab_name] ~= nil then
						local var_221_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_14.prefab_name].transform, "story_v_out_319591", "319591052", "story_v_out_319591.awb")

						arg_218_1:RecordAudio("319591052", var_221_19)
						arg_218_1:RecordAudio("319591052", var_221_19)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_319591", "319591052", "story_v_out_319591.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_319591", "319591052", "story_v_out_319591.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_20 = math.max(var_221_13, arg_218_1.talkMaxDuration)

			if var_221_12 <= arg_218_1.time_ and arg_218_1.time_ < var_221_12 + var_221_20 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_12) / var_221_20

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_12 + var_221_20 and arg_218_1.time_ < var_221_12 + var_221_20 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_218_1:InitPlayNodeList()
	end,
	Play319591053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 319591053
		arg_222_1.duration_ = 13.17

		local var_222_0 = {
			zh = 10.3,
			ja = 13.166
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play319591054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos4037ui_story = arg_222_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["4037ui_story"].transform.position).z)
				arg_222_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["4037ui_story"].transform.localEulerAngles = arg_222_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_222_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["4037ui_story"].transform.position).z)
				arg_222_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["4037ui_story"].transform.localEulerAngles = arg_222_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["4037ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect4037ui_story == nil then
				arg_222_1.var_.characterEffect4037ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect4037ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect4037ui_story then
				arg_222_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_225_4 = arg_222_1.actors_["1095ui_story"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1095ui_story = var_225_4.localPosition
			end

			local var_225_5 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_5 then
				var_225_4.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_222_1.time_ - 0) / var_225_5)
				var_225_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_4.position).x, (manager.ui.mainCamera.transform.position - var_225_4.position).y, (manager.ui.mainCamera.transform.position - var_225_4.position).z)
				var_225_4.localEulerAngles.z = 0
				var_225_4.localEulerAngles.x = 0
				var_225_4.localEulerAngles = var_225_4.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_5 and arg_222_1.time_ < 0 + var_225_5 + arg_225_0 then
				var_225_4.localPosition = Vector3.New(0, 100, 0)
				var_225_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_4.position).x, (manager.ui.mainCamera.transform.position - var_225_4.position).y, (manager.ui.mainCamera.transform.position - var_225_4.position).z)
				var_225_4.localEulerAngles.z = 0
				var_225_4.localEulerAngles.x = 0
				var_225_4.localEulerAngles = var_225_4.localEulerAngles
			end

			local var_225_6 = arg_222_1.actors_["1095ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_6) and arg_222_1.var_.characterEffect1095ui_story == nil then
				arg_222_1.var_.characterEffect1095ui_story = var_225_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_7 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 and not isNil(var_225_6) then
				if arg_222_1.var_.characterEffect1095ui_story and not isNil(var_225_6) then
					arg_222_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_7)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 and not isNil(var_225_6) and arg_222_1.var_.characterEffect1095ui_story then
				arg_222_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_225_8 = 0
			local var_225_9 = 0.95

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_8 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_10 = arg_222_1:GetWordFromCfg(319591053)
				local var_225_11 = arg_222_1:FormatText(var_225_10.content)

				arg_222_1.text_.text = var_225_11

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_13 = 38 <= 0 and var_225_9 or var_225_9 * (utf8.len(var_225_11) / 38)

				if (38 <= 0 and var_225_9 or var_225_9 * (utf8.len(var_225_11) / 38)) > 0 and var_225_9 < var_225_13 then
					arg_222_1.talkMaxDuration = var_225_13

					if var_225_13 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_8
					end
				end

				arg_222_1.text_.text = var_225_11
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591053", "story_v_out_319591.awb") ~= 0 then
					local var_225_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591053", "story_v_out_319591.awb") / 1000

					if var_225_14 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_14 + var_225_8
					end

					if var_225_10.prefab_name ~= "" and arg_222_1.actors_[var_225_10.prefab_name] ~= nil then
						local var_225_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_10.prefab_name].transform, "story_v_out_319591", "319591053", "story_v_out_319591.awb")

						arg_222_1:RecordAudio("319591053", var_225_15)
						arg_222_1:RecordAudio("319591053", var_225_15)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_319591", "319591053", "story_v_out_319591.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_319591", "319591053", "story_v_out_319591.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_16 = math.max(var_225_9, arg_222_1.talkMaxDuration)

			if var_225_8 <= arg_222_1.time_ and arg_222_1.time_ < var_225_8 + var_225_16 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_8) / var_225_16

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_8 + var_225_16 and arg_222_1.time_ < var_225_8 + var_225_16 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play319591054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 319591054
		arg_226_1.duration_ = 4.07

		local var_226_0 = {
			zh = 1.8,
			ja = 4.066
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play319591055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["4037ui_story"]) and arg_226_1.var_.characterEffect4037ui_story == nil then
				arg_226_1.var_.characterEffect4037ui_story = arg_226_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["4037ui_story"]) then
				if arg_226_1.var_.characterEffect4037ui_story and not isNil(arg_226_1.actors_["4037ui_story"]) then
					arg_226_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_226_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["4037ui_story"]) and arg_226_1.var_.characterEffect4037ui_story then
				arg_226_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_226_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.15

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:GetWordFromCfg(319591054)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_6 = 6 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_4) / 6)

				if (6 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_4) / 6)) > 0 and var_229_2 < var_229_6 then
					arg_226_1.talkMaxDuration = var_229_6

					if var_229_6 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591054", "story_v_out_319591.awb") ~= 0 then
					local var_229_7 = manager.audio:GetVoiceLength("story_v_out_319591", "319591054", "story_v_out_319591.awb") / 1000

					if var_229_7 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_1
					end

					if var_229_3.prefab_name ~= "" and arg_226_1.actors_[var_229_3.prefab_name] ~= nil then
						local var_229_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_3.prefab_name].transform, "story_v_out_319591", "319591054", "story_v_out_319591.awb")

						arg_226_1:RecordAudio("319591054", var_229_8)
						arg_226_1:RecordAudio("319591054", var_229_8)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_319591", "319591054", "story_v_out_319591.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_319591", "319591054", "story_v_out_319591.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_9 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_9 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_9

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_9 and arg_226_1.time_ < var_229_1 + var_229_9 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play319591055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 319591055
		arg_230_1.duration_ = 4.8

		local var_230_0 = {
			zh = 2.633,
			ja = 4.8
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play319591056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1095ui_story = arg_230_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1095ui_story"].transform.position).z)
				arg_230_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1095ui_story"].transform.localEulerAngles = arg_230_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_230_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1095ui_story"].transform.position).z)
				arg_230_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1095ui_story"].transform.localEulerAngles = arg_230_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["1095ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1095ui_story == nil then
				arg_230_1.var_.characterEffect1095ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 and not isNil(var_233_1) then
				if arg_230_1.var_.characterEffect1095ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1095ui_story then
				arg_230_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_233_4 = arg_230_1.actors_["4037ui_story"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos4037ui_story = var_233_4.localPosition
			end

			local var_233_5 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_5 then
				var_233_4.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_5)
				var_233_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_4.position).x, (manager.ui.mainCamera.transform.position - var_233_4.position).y, (manager.ui.mainCamera.transform.position - var_233_4.position).z)
				var_233_4.localEulerAngles.z = 0
				var_233_4.localEulerAngles.x = 0
				var_233_4.localEulerAngles = var_233_4.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_5 and arg_230_1.time_ < 0 + var_233_5 + arg_233_0 then
				var_233_4.localPosition = Vector3.New(0, 100, 0)
				var_233_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_4.position).x, (manager.ui.mainCamera.transform.position - var_233_4.position).y, (manager.ui.mainCamera.transform.position - var_233_4.position).z)
				var_233_4.localEulerAngles.z = 0
				var_233_4.localEulerAngles.x = 0
				var_233_4.localEulerAngles = var_233_4.localEulerAngles
			end

			local var_233_6 = arg_230_1.actors_["4037ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_6) and arg_230_1.var_.characterEffect4037ui_story == nil then
				arg_230_1.var_.characterEffect4037ui_story = var_233_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_7 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 and not isNil(var_233_6) then
				if arg_230_1.var_.characterEffect4037ui_story and not isNil(var_233_6) then
					arg_230_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_230_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_7)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 and not isNil(var_233_6) and arg_230_1.var_.characterEffect4037ui_story then
				arg_230_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_230_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_233_8 = 0
			local var_233_9 = 0.375

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_10 = arg_230_1:GetWordFromCfg(319591055)
				local var_233_11 = arg_230_1:FormatText(var_233_10.content)

				arg_230_1.text_.text = var_233_11

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_13 = 15 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_11) / 15)

				if (15 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_11) / 15)) > 0 and var_233_9 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_11
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591055", "story_v_out_319591.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591055", "story_v_out_319591.awb") / 1000

					if var_233_14 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_8
					end

					if var_233_10.prefab_name ~= "" and arg_230_1.actors_[var_233_10.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_10.prefab_name].transform, "story_v_out_319591", "319591055", "story_v_out_319591.awb")

						arg_230_1:RecordAudio("319591055", var_233_15)
						arg_230_1:RecordAudio("319591055", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319591", "319591055", "story_v_out_319591.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319591", "319591055", "story_v_out_319591.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_8) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_8 + var_233_16 and arg_230_1.time_ < var_233_8 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play319591056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319591056
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play319591057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1095ui_story"]) and arg_234_1.var_.characterEffect1095ui_story == nil then
				arg_234_1.var_.characterEffect1095ui_story = arg_234_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1095ui_story"]) then
				if arg_234_1.var_.characterEffect1095ui_story and not isNil(arg_234_1.actors_["1095ui_story"]) then
					arg_234_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_0)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1095ui_story"]) and arg_234_1.var_.characterEffect1095ui_story then
				arg_234_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_237_1 = 0
			local var_237_2 = 1.55

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_3 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(319591056).content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 63 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 63)

				if (63 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 63)) > 0 and var_237_2 < var_237_5 then
					arg_234_1.talkMaxDuration = var_237_5

					if var_237_5 + var_237_1 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + var_237_1
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_6 = math.max(var_237_2, arg_234_1.talkMaxDuration)

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_6 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_1) / var_237_6

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_1 + var_237_6 and arg_234_1.time_ < var_237_1 + var_237_6 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play319591057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 319591057
		arg_238_1.duration_ = 10.73

		local var_238_0 = {
			zh = 5.8,
			ja = 10.733
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play319591058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos4037ui_story = arg_238_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 then
				arg_238_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_238_1.time_ - 0) / var_241_0)
				arg_238_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["4037ui_story"].transform.position).z)
				arg_238_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["4037ui_story"].transform.localEulerAngles = arg_238_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_238_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["4037ui_story"].transform.position).z)
				arg_238_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["4037ui_story"].transform.localEulerAngles = arg_238_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_241_1 = arg_238_1.actors_["4037ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect4037ui_story == nil then
				arg_238_1.var_.characterEffect4037ui_story = var_241_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_2 and not isNil(var_241_1) then
				if arg_238_1.var_.characterEffect4037ui_story and not isNil(var_241_1) then
					arg_238_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_2 and arg_238_1.time_ < 0 + var_241_2 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect4037ui_story then
				arg_238_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_241_4 = arg_238_1.actors_["1095ui_story"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1095ui_story = var_241_4.localPosition
			end

			local var_241_5 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_5 then
				var_241_4.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_5)
				var_241_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_4.position).x, (manager.ui.mainCamera.transform.position - var_241_4.position).y, (manager.ui.mainCamera.transform.position - var_241_4.position).z)
				var_241_4.localEulerAngles.z = 0
				var_241_4.localEulerAngles.x = 0
				var_241_4.localEulerAngles = var_241_4.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_5 and arg_238_1.time_ < 0 + var_241_5 + arg_241_0 then
				var_241_4.localPosition = Vector3.New(0, 100, 0)
				var_241_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_4.position).x, (manager.ui.mainCamera.transform.position - var_241_4.position).y, (manager.ui.mainCamera.transform.position - var_241_4.position).z)
				var_241_4.localEulerAngles.z = 0
				var_241_4.localEulerAngles.x = 0
				var_241_4.localEulerAngles = var_241_4.localEulerAngles
			end

			local var_241_6 = arg_238_1.actors_["1095ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_6) and arg_238_1.var_.characterEffect1095ui_story == nil then
				arg_238_1.var_.characterEffect1095ui_story = var_241_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_7 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 and not isNil(var_241_6) then
				if arg_238_1.var_.characterEffect1095ui_story and not isNil(var_241_6) then
					arg_238_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_7)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 and not isNil(var_241_6) and arg_238_1.var_.characterEffect1095ui_story then
				arg_238_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_241_8 = 0
			local var_241_9 = 0.65

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_10 = arg_238_1:GetWordFromCfg(319591057)
				local var_241_11 = arg_238_1:FormatText(var_241_10.content)

				arg_238_1.text_.text = var_241_11

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_13 = 26 <= 0 and var_241_9 or var_241_9 * (utf8.len(var_241_11) / 26)

				if (26 <= 0 and var_241_9 or var_241_9 * (utf8.len(var_241_11) / 26)) > 0 and var_241_9 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_8 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_8
					end
				end

				arg_238_1.text_.text = var_241_11
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591057", "story_v_out_319591.awb") ~= 0 then
					local var_241_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591057", "story_v_out_319591.awb") / 1000

					if var_241_14 + var_241_8 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_14 + var_241_8
					end

					if var_241_10.prefab_name ~= "" and arg_238_1.actors_[var_241_10.prefab_name] ~= nil then
						local var_241_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_10.prefab_name].transform, "story_v_out_319591", "319591057", "story_v_out_319591.awb")

						arg_238_1:RecordAudio("319591057", var_241_15)
						arg_238_1:RecordAudio("319591057", var_241_15)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_319591", "319591057", "story_v_out_319591.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_319591", "319591057", "story_v_out_319591.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_16 = math.max(var_241_9, arg_238_1.talkMaxDuration)

			if var_241_8 <= arg_238_1.time_ and arg_238_1.time_ < var_241_8 + var_241_16 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_8) / var_241_16

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_8 + var_241_16 and arg_238_1.time_ < var_241_8 + var_241_16 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play319591058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 319591058
		arg_242_1.duration_ = 7.4

		local var_242_0 = {
			zh = 2.7,
			ja = 7.4
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play319591059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1095ui_story = arg_242_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).z)
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles = arg_242_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_242_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1095ui_story"].transform.position).z)
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1095ui_story"].transform.localEulerAngles = arg_242_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["1095ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1095ui_story == nil then
				arg_242_1.var_.characterEffect1095ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect1095ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1095ui_story then
				arg_242_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_245_4 = arg_242_1.actors_["4037ui_story"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos4037ui_story = var_245_4.localPosition
			end

			local var_245_5 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_5 then
				var_245_4.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 0) / var_245_5)
				var_245_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_4.position).x, (manager.ui.mainCamera.transform.position - var_245_4.position).y, (manager.ui.mainCamera.transform.position - var_245_4.position).z)
				var_245_4.localEulerAngles.z = 0
				var_245_4.localEulerAngles.x = 0
				var_245_4.localEulerAngles = var_245_4.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_5 and arg_242_1.time_ < 0 + var_245_5 + arg_245_0 then
				var_245_4.localPosition = Vector3.New(0, 100, 0)
				var_245_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_4.position).x, (manager.ui.mainCamera.transform.position - var_245_4.position).y, (manager.ui.mainCamera.transform.position - var_245_4.position).z)
				var_245_4.localEulerAngles.z = 0
				var_245_4.localEulerAngles.x = 0
				var_245_4.localEulerAngles = var_245_4.localEulerAngles
			end

			local var_245_6 = arg_242_1.actors_["4037ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_6) and arg_242_1.var_.characterEffect4037ui_story == nil then
				arg_242_1.var_.characterEffect4037ui_story = var_245_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_7 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 and not isNil(var_245_6) then
				if arg_242_1.var_.characterEffect4037ui_story and not isNil(var_245_6) then
					arg_242_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_242_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_7)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 and not isNil(var_245_6) and arg_242_1.var_.characterEffect4037ui_story then
				arg_242_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_242_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_245_8 = 0
			local var_245_9 = 0.425

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_10 = arg_242_1:GetWordFromCfg(319591058)
				local var_245_11 = arg_242_1:FormatText(var_245_10.content)

				arg_242_1.text_.text = var_245_11

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_13 = 17 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 17)

				if (17 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 17)) > 0 and var_245_9 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_8
					end
				end

				arg_242_1.text_.text = var_245_11
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591058", "story_v_out_319591.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591058", "story_v_out_319591.awb") / 1000

					if var_245_14 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_8
					end

					if var_245_10.prefab_name ~= "" and arg_242_1.actors_[var_245_10.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_10.prefab_name].transform, "story_v_out_319591", "319591058", "story_v_out_319591.awb")

						arg_242_1:RecordAudio("319591058", var_245_15)
						arg_242_1:RecordAudio("319591058", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_319591", "319591058", "story_v_out_319591.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_319591", "319591058", "story_v_out_319591.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_16 = math.max(var_245_9, arg_242_1.talkMaxDuration)

			if var_245_8 <= arg_242_1.time_ and arg_242_1.time_ < var_245_8 + var_245_16 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_8) / var_245_16

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_8 + var_245_16 and arg_242_1.time_ < var_245_8 + var_245_16 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play319591059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 319591059
		arg_246_1.duration_ = 3.53

		local var_246_0 = {
			zh = 3.533,
			ja = 2.233
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play319591060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos4037ui_story = arg_246_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_249_0 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 then
				arg_246_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_246_1.time_ - 0) / var_249_0)
				arg_246_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["4037ui_story"].transform.position).z)
				arg_246_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["4037ui_story"].transform.localEulerAngles = arg_246_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 then
				arg_246_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_246_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["4037ui_story"].transform.position).z)
				arg_246_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["4037ui_story"].transform.localEulerAngles = arg_246_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_249_1 = arg_246_1.actors_["4037ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect4037ui_story == nil then
				arg_246_1.var_.characterEffect4037ui_story = var_249_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_2 and not isNil(var_249_1) then
				if arg_246_1.var_.characterEffect4037ui_story and not isNil(var_249_1) then
					arg_246_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_2 and arg_246_1.time_ < 0 + var_249_2 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect4037ui_story then
				arg_246_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_249_4 = arg_246_1.actors_["1095ui_story"].transform

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1095ui_story = var_249_4.localPosition
			end

			local var_249_5 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_5 then
				var_249_4.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_246_1.time_ - 0) / var_249_5)
				var_249_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_249_4.position).x, (manager.ui.mainCamera.transform.position - var_249_4.position).y, (manager.ui.mainCamera.transform.position - var_249_4.position).z)
				var_249_4.localEulerAngles.z = 0
				var_249_4.localEulerAngles.x = 0
				var_249_4.localEulerAngles = var_249_4.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_5 and arg_246_1.time_ < 0 + var_249_5 + arg_249_0 then
				var_249_4.localPosition = Vector3.New(0, 100, 0)
				var_249_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_249_4.position).x, (manager.ui.mainCamera.transform.position - var_249_4.position).y, (manager.ui.mainCamera.transform.position - var_249_4.position).z)
				var_249_4.localEulerAngles.z = 0
				var_249_4.localEulerAngles.x = 0
				var_249_4.localEulerAngles = var_249_4.localEulerAngles
			end

			local var_249_6 = arg_246_1.actors_["1095ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_6) and arg_246_1.var_.characterEffect1095ui_story == nil then
				arg_246_1.var_.characterEffect1095ui_story = var_249_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_7 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 and not isNil(var_249_6) then
				if arg_246_1.var_.characterEffect1095ui_story and not isNil(var_249_6) then
					arg_246_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_7)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 and not isNil(var_249_6) and arg_246_1.var_.characterEffect1095ui_story then
				arg_246_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_249_8 = 0
			local var_249_9 = 0.25

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_8 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_10 = arg_246_1:GetWordFromCfg(319591059)
				local var_249_11 = arg_246_1:FormatText(var_249_10.content)

				arg_246_1.text_.text = var_249_11

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_13 = 10 <= 0 and var_249_9 or var_249_9 * (utf8.len(var_249_11) / 10)

				if (10 <= 0 and var_249_9 or var_249_9 * (utf8.len(var_249_11) / 10)) > 0 and var_249_9 < var_249_13 then
					arg_246_1.talkMaxDuration = var_249_13

					if var_249_13 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_13 + var_249_8
					end
				end

				arg_246_1.text_.text = var_249_11
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591059", "story_v_out_319591.awb") ~= 0 then
					local var_249_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591059", "story_v_out_319591.awb") / 1000

					if var_249_14 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_14 + var_249_8
					end

					if var_249_10.prefab_name ~= "" and arg_246_1.actors_[var_249_10.prefab_name] ~= nil then
						local var_249_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_10.prefab_name].transform, "story_v_out_319591", "319591059", "story_v_out_319591.awb")

						arg_246_1:RecordAudio("319591059", var_249_15)
						arg_246_1:RecordAudio("319591059", var_249_15)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_319591", "319591059", "story_v_out_319591.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_319591", "319591059", "story_v_out_319591.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_16 = math.max(var_249_9, arg_246_1.talkMaxDuration)

			if var_249_8 <= arg_246_1.time_ and arg_246_1.time_ < var_249_8 + var_249_16 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_8) / var_249_16

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_8 + var_249_16 and arg_246_1.time_ < var_249_8 + var_249_16 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play319591060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 319591060
		arg_250_1.duration_ = 12.13

		local var_250_0 = {
			zh = 8.6,
			ja = 12.133
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play319591061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1095ui_story = arg_250_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_253_0 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				arg_250_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).z)
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles = arg_250_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				arg_250_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_250_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1095ui_story"].transform.position).z)
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1095ui_story"].transform.localEulerAngles = arg_250_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_253_1 = arg_250_1.actors_["1095ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1095ui_story == nil then
				arg_250_1.var_.characterEffect1095ui_story = var_253_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_2 and not isNil(var_253_1) then
				if arg_250_1.var_.characterEffect1095ui_story and not isNil(var_253_1) then
					arg_250_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_2 and arg_250_1.time_ < 0 + var_253_2 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1095ui_story then
				arg_250_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_253_4 = arg_250_1.actors_["4037ui_story"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos4037ui_story = var_253_4.localPosition
			end

			local var_253_5 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_5 then
				var_253_4.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_5)
				var_253_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_4.position).x, (manager.ui.mainCamera.transform.position - var_253_4.position).y, (manager.ui.mainCamera.transform.position - var_253_4.position).z)
				var_253_4.localEulerAngles.z = 0
				var_253_4.localEulerAngles.x = 0
				var_253_4.localEulerAngles = var_253_4.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_5 and arg_250_1.time_ < 0 + var_253_5 + arg_253_0 then
				var_253_4.localPosition = Vector3.New(0, 100, 0)
				var_253_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_4.position).x, (manager.ui.mainCamera.transform.position - var_253_4.position).y, (manager.ui.mainCamera.transform.position - var_253_4.position).z)
				var_253_4.localEulerAngles.z = 0
				var_253_4.localEulerAngles.x = 0
				var_253_4.localEulerAngles = var_253_4.localEulerAngles
			end

			local var_253_6 = arg_250_1.actors_["4037ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_6) and arg_250_1.var_.characterEffect4037ui_story == nil then
				arg_250_1.var_.characterEffect4037ui_story = var_253_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_7 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 and not isNil(var_253_6) then
				if arg_250_1.var_.characterEffect4037ui_story and not isNil(var_253_6) then
					arg_250_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_250_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_7)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 and not isNil(var_253_6) and arg_250_1.var_.characterEffect4037ui_story then
				arg_250_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_250_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_253_8 = 0
			local var_253_9 = 1.05

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_10 = arg_250_1:GetWordFromCfg(319591060)
				local var_253_11 = arg_250_1:FormatText(var_253_10.content)

				arg_250_1.text_.text = var_253_11

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_13 = 42 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_11) / 42)

				if (42 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_11) / 42)) > 0 and var_253_9 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_8 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_8
					end
				end

				arg_250_1.text_.text = var_253_11
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591060", "story_v_out_319591.awb") ~= 0 then
					local var_253_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591060", "story_v_out_319591.awb") / 1000

					if var_253_14 + var_253_8 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_14 + var_253_8
					end

					if var_253_10.prefab_name ~= "" and arg_250_1.actors_[var_253_10.prefab_name] ~= nil then
						local var_253_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_10.prefab_name].transform, "story_v_out_319591", "319591060", "story_v_out_319591.awb")

						arg_250_1:RecordAudio("319591060", var_253_15)
						arg_250_1:RecordAudio("319591060", var_253_15)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_319591", "319591060", "story_v_out_319591.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_319591", "319591060", "story_v_out_319591.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_16 = math.max(var_253_9, arg_250_1.talkMaxDuration)

			if var_253_8 <= arg_250_1.time_ and arg_250_1.time_ < var_253_8 + var_253_16 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_8) / var_253_16

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_8 + var_253_16 and arg_250_1.time_ < var_253_8 + var_253_16 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play319591061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 319591061
		arg_254_1.duration_ = 9.4

		local var_254_0 = {
			zh = 7.666,
			ja = 9.4
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play319591062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos4037ui_story = arg_254_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["4037ui_story"].transform.position).z)
				arg_254_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["4037ui_story"].transform.localEulerAngles = arg_254_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_254_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["4037ui_story"].transform.position).z)
				arg_254_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["4037ui_story"].transform.localEulerAngles = arg_254_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_257_1 = arg_254_1.actors_["4037ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect4037ui_story == nil then
				arg_254_1.var_.characterEffect4037ui_story = var_257_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 and not isNil(var_257_1) then
				if arg_254_1.var_.characterEffect4037ui_story and not isNil(var_257_1) then
					arg_254_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect4037ui_story then
				arg_254_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037actionlink/4037action423")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_257_4 = arg_254_1.actors_["1095ui_story"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1095ui_story = var_257_4.localPosition
			end

			local var_257_5 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_5 then
				var_257_4.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_254_1.time_ - 0) / var_257_5)
				var_257_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_4.position).x, (manager.ui.mainCamera.transform.position - var_257_4.position).y, (manager.ui.mainCamera.transform.position - var_257_4.position).z)
				var_257_4.localEulerAngles.z = 0
				var_257_4.localEulerAngles.x = 0
				var_257_4.localEulerAngles = var_257_4.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_5 and arg_254_1.time_ < 0 + var_257_5 + arg_257_0 then
				var_257_4.localPosition = Vector3.New(0, 100, 0)
				var_257_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_4.position).x, (manager.ui.mainCamera.transform.position - var_257_4.position).y, (manager.ui.mainCamera.transform.position - var_257_4.position).z)
				var_257_4.localEulerAngles.z = 0
				var_257_4.localEulerAngles.x = 0
				var_257_4.localEulerAngles = var_257_4.localEulerAngles
			end

			local var_257_6 = arg_254_1.actors_["1095ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_6) and arg_254_1.var_.characterEffect1095ui_story == nil then
				arg_254_1.var_.characterEffect1095ui_story = var_257_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_7 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 and not isNil(var_257_6) then
				if arg_254_1.var_.characterEffect1095ui_story and not isNil(var_257_6) then
					arg_254_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_7)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 and not isNil(var_257_6) and arg_254_1.var_.characterEffect1095ui_story then
				arg_254_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_257_8 = 0
			local var_257_9 = 0.825

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_8 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_10 = arg_254_1:GetWordFromCfg(319591061)
				local var_257_11 = arg_254_1:FormatText(var_257_10.content)

				arg_254_1.text_.text = var_257_11

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_13 = 33 <= 0 and var_257_9 or var_257_9 * (utf8.len(var_257_11) / 33)

				if (33 <= 0 and var_257_9 or var_257_9 * (utf8.len(var_257_11) / 33)) > 0 and var_257_9 < var_257_13 then
					arg_254_1.talkMaxDuration = var_257_13

					if var_257_13 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_8
					end
				end

				arg_254_1.text_.text = var_257_11
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591061", "story_v_out_319591.awb") ~= 0 then
					local var_257_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591061", "story_v_out_319591.awb") / 1000

					if var_257_14 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_14 + var_257_8
					end

					if var_257_10.prefab_name ~= "" and arg_254_1.actors_[var_257_10.prefab_name] ~= nil then
						local var_257_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_10.prefab_name].transform, "story_v_out_319591", "319591061", "story_v_out_319591.awb")

						arg_254_1:RecordAudio("319591061", var_257_15)
						arg_254_1:RecordAudio("319591061", var_257_15)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_319591", "319591061", "story_v_out_319591.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_319591", "319591061", "story_v_out_319591.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_16 = math.max(var_257_9, arg_254_1.talkMaxDuration)

			if var_257_8 <= arg_254_1.time_ and arg_254_1.time_ < var_257_8 + var_257_16 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_8) / var_257_16

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_8 + var_257_16 and arg_254_1.time_ < var_257_8 + var_257_16 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play319591062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 319591062
		arg_258_1.duration_ = 11.9

		local var_258_0 = {
			zh = 7.7,
			ja = 11.9
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play319591063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.675

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:GetWordFromCfg(319591062)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 27 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 27)

				if (27 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 27)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591062", "story_v_out_319591.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_out_319591", "319591062", "story_v_out_319591.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_out_319591", "319591062", "story_v_out_319591.awb")

						arg_258_1:RecordAudio("319591062", var_261_6)
						arg_258_1:RecordAudio("319591062", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_319591", "319591062", "story_v_out_319591.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_319591", "319591062", "story_v_out_319591.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play319591063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 319591063
		arg_262_1.duration_ = 15.2

		local var_262_0 = {
			zh = 8.733,
			ja = 15.2
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play319591064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1095ui_story = arg_262_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_265_0 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 then
				arg_262_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_262_1.time_ - 0) / var_265_0)
				arg_262_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1095ui_story"].transform.position).z)
				arg_262_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1095ui_story"].transform.localEulerAngles = arg_262_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 then
				arg_262_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_262_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1095ui_story"].transform.position).z)
				arg_262_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1095ui_story"].transform.localEulerAngles = arg_262_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_265_1 = arg_262_1.actors_["1095ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect1095ui_story == nil then
				arg_262_1.var_.characterEffect1095ui_story = var_265_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_2 and not isNil(var_265_1) then
				if arg_262_1.var_.characterEffect1095ui_story and not isNil(var_265_1) then
					arg_262_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_2 and arg_262_1.time_ < 0 + var_265_2 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect1095ui_story then
				arg_262_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_265_4 = arg_262_1.actors_["4037ui_story"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos4037ui_story = var_265_4.localPosition
			end

			local var_265_5 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_5 then
				var_265_4.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_262_1.time_ - 0) / var_265_5)
				var_265_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_4.position).x, (manager.ui.mainCamera.transform.position - var_265_4.position).y, (manager.ui.mainCamera.transform.position - var_265_4.position).z)
				var_265_4.localEulerAngles.z = 0
				var_265_4.localEulerAngles.x = 0
				var_265_4.localEulerAngles = var_265_4.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_5 and arg_262_1.time_ < 0 + var_265_5 + arg_265_0 then
				var_265_4.localPosition = Vector3.New(0, 100, 0)
				var_265_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_4.position).x, (manager.ui.mainCamera.transform.position - var_265_4.position).y, (manager.ui.mainCamera.transform.position - var_265_4.position).z)
				var_265_4.localEulerAngles.z = 0
				var_265_4.localEulerAngles.x = 0
				var_265_4.localEulerAngles = var_265_4.localEulerAngles
			end

			local var_265_6 = arg_262_1.actors_["4037ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_6) and arg_262_1.var_.characterEffect4037ui_story == nil then
				arg_262_1.var_.characterEffect4037ui_story = var_265_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_7 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 and not isNil(var_265_6) then
				if arg_262_1.var_.characterEffect4037ui_story and not isNil(var_265_6) then
					arg_262_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_262_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_7)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 and not isNil(var_265_6) and arg_262_1.var_.characterEffect4037ui_story then
				arg_262_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_262_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_265_8 = 0
			local var_265_9 = 0.875

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_8 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_10 = arg_262_1:GetWordFromCfg(319591063)
				local var_265_11 = arg_262_1:FormatText(var_265_10.content)

				arg_262_1.text_.text = var_265_11

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_13 = 35 <= 0 and var_265_9 or var_265_9 * (utf8.len(var_265_11) / 35)

				if (35 <= 0 and var_265_9 or var_265_9 * (utf8.len(var_265_11) / 35)) > 0 and var_265_9 < var_265_13 then
					arg_262_1.talkMaxDuration = var_265_13

					if var_265_13 + var_265_8 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_13 + var_265_8
					end
				end

				arg_262_1.text_.text = var_265_11
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591063", "story_v_out_319591.awb") ~= 0 then
					local var_265_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591063", "story_v_out_319591.awb") / 1000

					if var_265_14 + var_265_8 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_14 + var_265_8
					end

					if var_265_10.prefab_name ~= "" and arg_262_1.actors_[var_265_10.prefab_name] ~= nil then
						local var_265_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_10.prefab_name].transform, "story_v_out_319591", "319591063", "story_v_out_319591.awb")

						arg_262_1:RecordAudio("319591063", var_265_15)
						arg_262_1:RecordAudio("319591063", var_265_15)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_319591", "319591063", "story_v_out_319591.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_319591", "319591063", "story_v_out_319591.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_16 = math.max(var_265_9, arg_262_1.talkMaxDuration)

			if var_265_8 <= arg_262_1.time_ and arg_262_1.time_ < var_265_8 + var_265_16 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_8) / var_265_16

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_8 + var_265_16 and arg_262_1.time_ < var_265_8 + var_265_16 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play319591064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 319591064
		arg_266_1.duration_ = 3.07

		local var_266_0 = {
			zh = 2.333,
			ja = 3.066
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play319591065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos4037ui_story = arg_266_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["4037ui_story"].transform.position).z)
				arg_266_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["4037ui_story"].transform.localEulerAngles = arg_266_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_266_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["4037ui_story"].transform.position).z)
				arg_266_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["4037ui_story"].transform.localEulerAngles = arg_266_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_269_1 = arg_266_1.actors_["4037ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect4037ui_story == nil then
				arg_266_1.var_.characterEffect4037ui_story = var_269_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 and not isNil(var_269_1) then
				if arg_266_1.var_.characterEffect4037ui_story and not isNil(var_269_1) then
					arg_266_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect4037ui_story then
				arg_266_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_2")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_269_4 = arg_266_1.actors_["1095ui_story"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1095ui_story = var_269_4.localPosition
			end

			local var_269_5 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_5 then
				var_269_4.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_5)
				var_269_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_4.position).x, (manager.ui.mainCamera.transform.position - var_269_4.position).y, (manager.ui.mainCamera.transform.position - var_269_4.position).z)
				var_269_4.localEulerAngles.z = 0
				var_269_4.localEulerAngles.x = 0
				var_269_4.localEulerAngles = var_269_4.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_5 and arg_266_1.time_ < 0 + var_269_5 + arg_269_0 then
				var_269_4.localPosition = Vector3.New(0, 100, 0)
				var_269_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_4.position).x, (manager.ui.mainCamera.transform.position - var_269_4.position).y, (manager.ui.mainCamera.transform.position - var_269_4.position).z)
				var_269_4.localEulerAngles.z = 0
				var_269_4.localEulerAngles.x = 0
				var_269_4.localEulerAngles = var_269_4.localEulerAngles
			end

			local var_269_6 = arg_266_1.actors_["1095ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_6) and arg_266_1.var_.characterEffect1095ui_story == nil then
				arg_266_1.var_.characterEffect1095ui_story = var_269_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_7 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 and not isNil(var_269_6) then
				if arg_266_1.var_.characterEffect1095ui_story and not isNil(var_269_6) then
					arg_266_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_7)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 and not isNil(var_269_6) and arg_266_1.var_.characterEffect1095ui_story then
				arg_266_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_269_8 = 0
			local var_269_9 = 0.25

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_8 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_10 = arg_266_1:GetWordFromCfg(319591064)
				local var_269_11 = arg_266_1:FormatText(var_269_10.content)

				arg_266_1.text_.text = var_269_11

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_13 = 10 <= 0 and var_269_9 or var_269_9 * (utf8.len(var_269_11) / 10)

				if (10 <= 0 and var_269_9 or var_269_9 * (utf8.len(var_269_11) / 10)) > 0 and var_269_9 < var_269_13 then
					arg_266_1.talkMaxDuration = var_269_13

					if var_269_13 + var_269_8 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_13 + var_269_8
					end
				end

				arg_266_1.text_.text = var_269_11
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591064", "story_v_out_319591.awb") ~= 0 then
					local var_269_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591064", "story_v_out_319591.awb") / 1000

					if var_269_14 + var_269_8 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_14 + var_269_8
					end

					if var_269_10.prefab_name ~= "" and arg_266_1.actors_[var_269_10.prefab_name] ~= nil then
						local var_269_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_10.prefab_name].transform, "story_v_out_319591", "319591064", "story_v_out_319591.awb")

						arg_266_1:RecordAudio("319591064", var_269_15)
						arg_266_1:RecordAudio("319591064", var_269_15)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_319591", "319591064", "story_v_out_319591.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_319591", "319591064", "story_v_out_319591.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_16 = math.max(var_269_9, arg_266_1.talkMaxDuration)

			if var_269_8 <= arg_266_1.time_ and arg_266_1.time_ < var_269_8 + var_269_16 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_8) / var_269_16

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_8 + var_269_16 and arg_266_1.time_ < var_269_8 + var_269_16 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play319591065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 319591065
		arg_270_1.duration_ = 6.3

		local var_270_0 = {
			zh = 2.866,
			ja = 6.3
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play319591066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1095ui_story = arg_270_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_273_0 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				arg_270_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).z)
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles = arg_270_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				arg_270_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_270_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).z)
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles = arg_270_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_273_1 = arg_270_1.actors_["1095ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1095ui_story == nil then
				arg_270_1.var_.characterEffect1095ui_story = var_273_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_2 and not isNil(var_273_1) then
				if arg_270_1.var_.characterEffect1095ui_story and not isNil(var_273_1) then
					arg_270_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_2 and arg_270_1.time_ < 0 + var_273_2 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1095ui_story then
				arg_270_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_273_4 = arg_270_1.actors_["4037ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos4037ui_story = var_273_4.localPosition
			end

			local var_273_5 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_5 then
				var_273_4.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_270_1.time_ - 0) / var_273_5)
				var_273_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_4.position).x, (manager.ui.mainCamera.transform.position - var_273_4.position).y, (manager.ui.mainCamera.transform.position - var_273_4.position).z)
				var_273_4.localEulerAngles.z = 0
				var_273_4.localEulerAngles.x = 0
				var_273_4.localEulerAngles = var_273_4.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_5 and arg_270_1.time_ < 0 + var_273_5 + arg_273_0 then
				var_273_4.localPosition = Vector3.New(0, 100, 0)
				var_273_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_4.position).x, (manager.ui.mainCamera.transform.position - var_273_4.position).y, (manager.ui.mainCamera.transform.position - var_273_4.position).z)
				var_273_4.localEulerAngles.z = 0
				var_273_4.localEulerAngles.x = 0
				var_273_4.localEulerAngles = var_273_4.localEulerAngles
			end

			local var_273_6 = arg_270_1.actors_["4037ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_6) and arg_270_1.var_.characterEffect4037ui_story == nil then
				arg_270_1.var_.characterEffect4037ui_story = var_273_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_7 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 and not isNil(var_273_6) then
				if arg_270_1.var_.characterEffect4037ui_story and not isNil(var_273_6) then
					arg_270_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_270_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_7)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 and not isNil(var_273_6) and arg_270_1.var_.characterEffect4037ui_story then
				arg_270_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_270_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_273_8 = 0
			local var_273_9 = 0.275

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_10 = arg_270_1:GetWordFromCfg(319591065)
				local var_273_11 = arg_270_1:FormatText(var_273_10.content)

				arg_270_1.text_.text = var_273_11

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_13 = 11 <= 0 and var_273_9 or var_273_9 * (utf8.len(var_273_11) / 11)

				if (11 <= 0 and var_273_9 or var_273_9 * (utf8.len(var_273_11) / 11)) > 0 and var_273_9 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_8
					end
				end

				arg_270_1.text_.text = var_273_11
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591065", "story_v_out_319591.awb") ~= 0 then
					local var_273_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591065", "story_v_out_319591.awb") / 1000

					if var_273_14 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_14 + var_273_8
					end

					if var_273_10.prefab_name ~= "" and arg_270_1.actors_[var_273_10.prefab_name] ~= nil then
						local var_273_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_10.prefab_name].transform, "story_v_out_319591", "319591065", "story_v_out_319591.awb")

						arg_270_1:RecordAudio("319591065", var_273_15)
						arg_270_1:RecordAudio("319591065", var_273_15)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_319591", "319591065", "story_v_out_319591.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_319591", "319591065", "story_v_out_319591.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_9, arg_270_1.talkMaxDuration)

			if var_273_8 <= arg_270_1.time_ and arg_270_1.time_ < var_273_8 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_8) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_8 + var_273_16 and arg_270_1.time_ < var_273_8 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play319591066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319591066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play319591067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos4037ui_story = arg_274_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["4037ui_story"].transform.position).z)
				arg_274_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["4037ui_story"].transform.localEulerAngles = arg_274_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["4037ui_story"].transform.position).z)
				arg_274_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["4037ui_story"].transform.localEulerAngles = arg_274_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_277_1 = arg_274_1.actors_["1095ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect1095ui_story == nil then
				arg_274_1.var_.characterEffect1095ui_story = var_277_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_2 and not isNil(var_277_1) then
				if arg_274_1.var_.characterEffect1095ui_story and not isNil(var_277_1) then
					arg_274_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_2)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_2 and arg_274_1.time_ < 0 + var_277_2 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect1095ui_story then
				arg_274_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_277_3 = 0
			local var_277_4 = 0.725

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_3 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_5 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(319591066).content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 29 <= 0 and var_277_4 or var_277_4 * (utf8.len(var_277_5) / 29)

				if (29 <= 0 and var_277_4 or var_277_4 * (utf8.len(var_277_5) / 29)) > 0 and var_277_4 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_3 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_3
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_4, arg_274_1.talkMaxDuration)

			if var_277_3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_3 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_3) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_3 + var_277_8 and arg_274_1.time_ < var_277_3 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play319591067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319591067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play319591068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 1.15

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(319591067).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 46 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 46)

				if (46 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 46)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play319591068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 319591068
		arg_282_1.duration_ = 2.53

		local var_282_0 = {
			zh = 1.7,
			ja = 2.533
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play319591069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1095ui_story = arg_282_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_285_0 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				arg_282_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).z)
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles = arg_282_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				arg_282_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_282_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1095ui_story"].transform.position).z)
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1095ui_story"].transform.localEulerAngles = arg_282_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_285_1 = arg_282_1.actors_["1095ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect1095ui_story == nil then
				arg_282_1.var_.characterEffect1095ui_story = var_285_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_2 and not isNil(var_285_1) then
				if arg_282_1.var_.characterEffect1095ui_story and not isNil(var_285_1) then
					arg_282_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_2 and arg_282_1.time_ < 0 + var_285_2 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect1095ui_story then
				arg_282_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_285_4 = 0
			local var_285_5 = 0.2

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_6 = arg_282_1:GetWordFromCfg(319591068)
				local var_285_7 = arg_282_1:FormatText(var_285_6.content)

				arg_282_1.text_.text = var_285_7

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_9 = 8 <= 0 and var_285_5 or var_285_5 * (utf8.len(var_285_7) / 8)

				if (8 <= 0 and var_285_5 or var_285_5 * (utf8.len(var_285_7) / 8)) > 0 and var_285_5 < var_285_9 then
					arg_282_1.talkMaxDuration = var_285_9

					if var_285_9 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_9 + var_285_4
					end
				end

				arg_282_1.text_.text = var_285_7
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591068", "story_v_out_319591.awb") ~= 0 then
					local var_285_10 = manager.audio:GetVoiceLength("story_v_out_319591", "319591068", "story_v_out_319591.awb") / 1000

					if var_285_10 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_4
					end

					if var_285_6.prefab_name ~= "" and arg_282_1.actors_[var_285_6.prefab_name] ~= nil then
						local var_285_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_6.prefab_name].transform, "story_v_out_319591", "319591068", "story_v_out_319591.awb")

						arg_282_1:RecordAudio("319591068", var_285_11)
						arg_282_1:RecordAudio("319591068", var_285_11)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_319591", "319591068", "story_v_out_319591.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_319591", "319591068", "story_v_out_319591.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_12 = math.max(var_285_5, arg_282_1.talkMaxDuration)

			if var_285_4 <= arg_282_1.time_ and arg_282_1.time_ < var_285_4 + var_285_12 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_4) / var_285_12

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_4 + var_285_12 and arg_282_1.time_ < var_285_4 + var_285_12 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play319591069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 319591069
		arg_286_1.duration_ = 4.53

		local var_286_0 = {
			zh = 3.6,
			ja = 4.533
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play319591070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1095ui_story"]) and arg_286_1.var_.characterEffect1095ui_story == nil then
				arg_286_1.var_.characterEffect1095ui_story = arg_286_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1095ui_story"]) then
				if arg_286_1.var_.characterEffect1095ui_story and not isNil(arg_286_1.actors_["1095ui_story"]) then
					arg_286_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_0)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1095ui_story"]) and arg_286_1.var_.characterEffect1095ui_story then
				arg_286_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_289_1 = 0
			local var_289_2 = 0.5

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(319591069)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_6 = 20 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_4) / 20)

				if (20 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_4) / 20)) > 0 and var_289_2 < var_289_6 then
					arg_286_1.talkMaxDuration = var_289_6

					if var_289_6 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_6 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591069", "story_v_out_319591.awb") ~= 0 then
					local var_289_7 = manager.audio:GetVoiceLength("story_v_out_319591", "319591069", "story_v_out_319591.awb") / 1000

					if var_289_7 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_1
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_out_319591", "319591069", "story_v_out_319591.awb")

						arg_286_1:RecordAudio("319591069", var_289_8)
						arg_286_1:RecordAudio("319591069", var_289_8)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_319591", "319591069", "story_v_out_319591.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_319591", "319591069", "story_v_out_319591.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_9 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_9 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_1) / var_289_9

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_1 + var_289_9 and arg_286_1.time_ < var_289_1 + var_289_9 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play319591070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 319591070
		arg_290_1.duration_ = 1.17

		local var_290_0 = {
			zh = 0.999999999999,
			ja = 1.166
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play319591071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1095ui_story"]) and arg_290_1.var_.characterEffect1095ui_story == nil then
				arg_290_1.var_.characterEffect1095ui_story = arg_290_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1095ui_story"]) then
				if arg_290_1.var_.characterEffect1095ui_story and not isNil(arg_290_1.actors_["1095ui_story"]) then
					arg_290_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1095ui_story"]) and arg_290_1.var_.characterEffect1095ui_story then
				arg_290_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_293_2 = 0
			local var_293_3 = 0.075

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_4 = arg_290_1:GetWordFromCfg(319591070)
				local var_293_5 = arg_290_1:FormatText(var_293_4.content)

				arg_290_1.text_.text = var_293_5

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_7 = 3 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_5) / 3)

				if (3 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_5) / 3)) > 0 and var_293_3 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_5
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591070", "story_v_out_319591.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_319591", "319591070", "story_v_out_319591.awb") / 1000

					if var_293_8 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_2
					end

					if var_293_4.prefab_name ~= "" and arg_290_1.actors_[var_293_4.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_4.prefab_name].transform, "story_v_out_319591", "319591070", "story_v_out_319591.awb")

						arg_290_1:RecordAudio("319591070", var_293_9)
						arg_290_1:RecordAudio("319591070", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_319591", "319591070", "story_v_out_319591.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_319591", "319591070", "story_v_out_319591.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_10 and arg_290_1.time_ < var_293_2 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play319591071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319591071
		arg_294_1.duration_ = 8.67

		local var_294_0 = {
			zh = 6.3,
			ja = 8.666
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319591072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos4037ui_story = arg_294_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_297_0 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				arg_294_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_294_1.time_ - 0) / var_297_0)
				arg_294_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["4037ui_story"].transform.position).z)
				arg_294_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["4037ui_story"].transform.localEulerAngles = arg_294_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_294_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["4037ui_story"].transform.position).z)
				arg_294_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["4037ui_story"].transform.localEulerAngles = arg_294_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_297_1 = arg_294_1.actors_["4037ui_story"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_1) and arg_294_1.var_.characterEffect4037ui_story == nil then
				arg_294_1.var_.characterEffect4037ui_story = var_297_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_2 and not isNil(var_297_1) then
				if arg_294_1.var_.characterEffect4037ui_story and not isNil(var_297_1) then
					arg_294_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_2 and arg_294_1.time_ < 0 + var_297_2 + arg_297_0 and not isNil(var_297_1) and arg_294_1.var_.characterEffect4037ui_story then
				arg_294_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_297_4 = arg_294_1.actors_["1095ui_story"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1095ui_story = var_297_4.localPosition
			end

			local var_297_5 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_5 then
				var_297_4.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_294_1.time_ - 0) / var_297_5)
				var_297_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_4.position).x, (manager.ui.mainCamera.transform.position - var_297_4.position).y, (manager.ui.mainCamera.transform.position - var_297_4.position).z)
				var_297_4.localEulerAngles.z = 0
				var_297_4.localEulerAngles.x = 0
				var_297_4.localEulerAngles = var_297_4.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_5 and arg_294_1.time_ < 0 + var_297_5 + arg_297_0 then
				var_297_4.localPosition = Vector3.New(0, 100, 0)
				var_297_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_4.position).x, (manager.ui.mainCamera.transform.position - var_297_4.position).y, (manager.ui.mainCamera.transform.position - var_297_4.position).z)
				var_297_4.localEulerAngles.z = 0
				var_297_4.localEulerAngles.x = 0
				var_297_4.localEulerAngles = var_297_4.localEulerAngles
			end

			local var_297_6 = arg_294_1.actors_["1095ui_story"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_6) and arg_294_1.var_.characterEffect1095ui_story == nil then
				arg_294_1.var_.characterEffect1095ui_story = var_297_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_7 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 and not isNil(var_297_6) then
				if arg_294_1.var_.characterEffect1095ui_story and not isNil(var_297_6) then
					arg_294_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_7)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 and not isNil(var_297_6) and arg_294_1.var_.characterEffect1095ui_story then
				arg_294_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_297_8 = 0
			local var_297_9 = 0.525

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_10 = arg_294_1:GetWordFromCfg(319591071)
				local var_297_11 = arg_294_1:FormatText(var_297_10.content)

				arg_294_1.text_.text = var_297_11

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_13 = 21 <= 0 and var_297_9 or var_297_9 * (utf8.len(var_297_11) / 21)

				if (21 <= 0 and var_297_9 or var_297_9 * (utf8.len(var_297_11) / 21)) > 0 and var_297_9 < var_297_13 then
					arg_294_1.talkMaxDuration = var_297_13

					if var_297_13 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_13 + var_297_8
					end
				end

				arg_294_1.text_.text = var_297_11
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591071", "story_v_out_319591.awb") ~= 0 then
					local var_297_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591071", "story_v_out_319591.awb") / 1000

					if var_297_14 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_14 + var_297_8
					end

					if var_297_10.prefab_name ~= "" and arg_294_1.actors_[var_297_10.prefab_name] ~= nil then
						local var_297_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_10.prefab_name].transform, "story_v_out_319591", "319591071", "story_v_out_319591.awb")

						arg_294_1:RecordAudio("319591071", var_297_15)
						arg_294_1:RecordAudio("319591071", var_297_15)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_319591", "319591071", "story_v_out_319591.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_319591", "319591071", "story_v_out_319591.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_16 = math.max(var_297_9, arg_294_1.talkMaxDuration)

			if var_297_8 <= arg_294_1.time_ and arg_294_1.time_ < var_297_8 + var_297_16 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_8) / var_297_16

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_8 + var_297_16 and arg_294_1.time_ < var_297_8 + var_297_16 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play319591072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319591072
		arg_298_1.duration_ = 7.43

		local var_298_0 = {
			zh = 2.866,
			ja = 7.433
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play319591073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos4040ui_story = arg_298_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_301_0 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 then
				arg_298_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_298_1.time_ - 0) / var_301_0)
				arg_298_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["4040ui_story"].transform.position).z)
				arg_298_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["4040ui_story"].transform.localEulerAngles = arg_298_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 then
				arg_298_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_298_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["4040ui_story"].transform.position).z)
				arg_298_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["4040ui_story"].transform.localEulerAngles = arg_298_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_301_1 = arg_298_1.actors_["4040ui_story"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_1) and arg_298_1.var_.characterEffect4040ui_story == nil then
				arg_298_1.var_.characterEffect4040ui_story = var_301_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_2 and not isNil(var_301_1) then
				if arg_298_1.var_.characterEffect4040ui_story and not isNil(var_301_1) then
					arg_298_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= 0 + var_301_2 and arg_298_1.time_ < 0 + var_301_2 + arg_301_0 and not isNil(var_301_1) and arg_298_1.var_.characterEffect4040ui_story then
				arg_298_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_301_4 = arg_298_1.actors_["4037ui_story"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos4037ui_story = var_301_4.localPosition
			end

			local var_301_5 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_5 then
				var_301_4.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 0) / var_301_5)
				var_301_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_4.position).x, (manager.ui.mainCamera.transform.position - var_301_4.position).y, (manager.ui.mainCamera.transform.position - var_301_4.position).z)
				var_301_4.localEulerAngles.z = 0
				var_301_4.localEulerAngles.x = 0
				var_301_4.localEulerAngles = var_301_4.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_5 and arg_298_1.time_ < 0 + var_301_5 + arg_301_0 then
				var_301_4.localPosition = Vector3.New(0, 100, 0)
				var_301_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_4.position).x, (manager.ui.mainCamera.transform.position - var_301_4.position).y, (manager.ui.mainCamera.transform.position - var_301_4.position).z)
				var_301_4.localEulerAngles.z = 0
				var_301_4.localEulerAngles.x = 0
				var_301_4.localEulerAngles = var_301_4.localEulerAngles
			end

			local var_301_6 = arg_298_1.actors_["4037ui_story"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_6) and arg_298_1.var_.characterEffect4037ui_story == nil then
				arg_298_1.var_.characterEffect4037ui_story = var_301_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_7 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_7 and not isNil(var_301_6) then
				if arg_298_1.var_.characterEffect4037ui_story and not isNil(var_301_6) then
					arg_298_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_298_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_298_1.time_ - 0) / var_301_7)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_7 and arg_298_1.time_ < 0 + var_301_7 + arg_301_0 and not isNil(var_301_6) and arg_298_1.var_.characterEffect4037ui_story then
				arg_298_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_298_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_301_8 = 0
			local var_301_9 = 0.2

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_8 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_10 = arg_298_1:GetWordFromCfg(319591072)
				local var_301_11 = arg_298_1:FormatText(var_301_10.content)

				arg_298_1.text_.text = var_301_11

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_13 = 8 <= 0 and var_301_9 or var_301_9 * (utf8.len(var_301_11) / 8)

				if (8 <= 0 and var_301_9 or var_301_9 * (utf8.len(var_301_11) / 8)) > 0 and var_301_9 < var_301_13 then
					arg_298_1.talkMaxDuration = var_301_13

					if var_301_13 + var_301_8 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_13 + var_301_8
					end
				end

				arg_298_1.text_.text = var_301_11
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591072", "story_v_out_319591.awb") ~= 0 then
					local var_301_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591072", "story_v_out_319591.awb") / 1000

					if var_301_14 + var_301_8 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_14 + var_301_8
					end

					if var_301_10.prefab_name ~= "" and arg_298_1.actors_[var_301_10.prefab_name] ~= nil then
						local var_301_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_10.prefab_name].transform, "story_v_out_319591", "319591072", "story_v_out_319591.awb")

						arg_298_1:RecordAudio("319591072", var_301_15)
						arg_298_1:RecordAudio("319591072", var_301_15)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_319591", "319591072", "story_v_out_319591.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_319591", "319591072", "story_v_out_319591.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_16 = math.max(var_301_9, arg_298_1.talkMaxDuration)

			if var_301_8 <= arg_298_1.time_ and arg_298_1.time_ < var_301_8 + var_301_16 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_8) / var_301_16

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_8 + var_301_16 and arg_298_1.time_ < var_301_8 + var_301_16 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play319591073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319591073
		arg_302_1.duration_ = 6.4

		local var_302_0 = {
			zh = 4.566,
			ja = 6.4
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play319591074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1095ui_story = arg_302_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_305_0 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 then
				arg_302_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_302_1.time_ - 0) / var_305_0)
				arg_302_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1095ui_story"].transform.position).z)
				arg_302_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1095ui_story"].transform.localEulerAngles = arg_302_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 then
				arg_302_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_302_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1095ui_story"].transform.position).z)
				arg_302_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1095ui_story"].transform.localEulerAngles = arg_302_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_305_1 = arg_302_1.actors_["1095ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1095ui_story == nil then
				arg_302_1.var_.characterEffect1095ui_story = var_305_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_2 and not isNil(var_305_1) then
				if arg_302_1.var_.characterEffect1095ui_story and not isNil(var_305_1) then
					arg_302_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_2 and arg_302_1.time_ < 0 + var_305_2 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1095ui_story then
				arg_302_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_305_4 = arg_302_1.actors_["4040ui_story"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos4040ui_story = var_305_4.localPosition
			end

			local var_305_5 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_5 then
				var_305_4.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_302_1.time_ - 0) / var_305_5)
				var_305_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_4.position).x, (manager.ui.mainCamera.transform.position - var_305_4.position).y, (manager.ui.mainCamera.transform.position - var_305_4.position).z)
				var_305_4.localEulerAngles.z = 0
				var_305_4.localEulerAngles.x = 0
				var_305_4.localEulerAngles = var_305_4.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_5 and arg_302_1.time_ < 0 + var_305_5 + arg_305_0 then
				var_305_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_305_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_4.position).x, (manager.ui.mainCamera.transform.position - var_305_4.position).y, (manager.ui.mainCamera.transform.position - var_305_4.position).z)
				var_305_4.localEulerAngles.z = 0
				var_305_4.localEulerAngles.x = 0
				var_305_4.localEulerAngles = var_305_4.localEulerAngles
			end

			local var_305_6 = arg_302_1.actors_["4040ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_6) and arg_302_1.var_.characterEffect4040ui_story == nil then
				arg_302_1.var_.characterEffect4040ui_story = var_305_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_7 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_7 and not isNil(var_305_6) then
				if arg_302_1.var_.characterEffect4040ui_story and not isNil(var_305_6) then
					arg_302_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_302_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_302_1.time_ - 0) / var_305_7)
				end
			end

			if arg_302_1.time_ >= 0 + var_305_7 and arg_302_1.time_ < 0 + var_305_7 + arg_305_0 and not isNil(var_305_6) and arg_302_1.var_.characterEffect4040ui_story then
				arg_302_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_302_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_305_8 = 0
			local var_305_9 = 0.375

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_8 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_10 = arg_302_1:GetWordFromCfg(319591073)
				local var_305_11 = arg_302_1:FormatText(var_305_10.content)

				arg_302_1.text_.text = var_305_11

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_13 = 15 <= 0 and var_305_9 or var_305_9 * (utf8.len(var_305_11) / 15)

				if (15 <= 0 and var_305_9 or var_305_9 * (utf8.len(var_305_11) / 15)) > 0 and var_305_9 < var_305_13 then
					arg_302_1.talkMaxDuration = var_305_13

					if var_305_13 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_8
					end
				end

				arg_302_1.text_.text = var_305_11
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591073", "story_v_out_319591.awb") ~= 0 then
					local var_305_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591073", "story_v_out_319591.awb") / 1000

					if var_305_14 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_14 + var_305_8
					end

					if var_305_10.prefab_name ~= "" and arg_302_1.actors_[var_305_10.prefab_name] ~= nil then
						local var_305_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_10.prefab_name].transform, "story_v_out_319591", "319591073", "story_v_out_319591.awb")

						arg_302_1:RecordAudio("319591073", var_305_15)
						arg_302_1:RecordAudio("319591073", var_305_15)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_319591", "319591073", "story_v_out_319591.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_319591", "319591073", "story_v_out_319591.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_16 = math.max(var_305_9, arg_302_1.talkMaxDuration)

			if var_305_8 <= arg_302_1.time_ and arg_302_1.time_ < var_305_8 + var_305_16 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_8) / var_305_16

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_8 + var_305_16 and arg_302_1.time_ < var_305_8 + var_305_16 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_302_1:InitPlayNodeList()
	end,
	Play319591074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 319591074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play319591075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1095ui_story = arg_306_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_309_0 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 then
				arg_306_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_306_1.time_ - 0) / var_309_0)
				arg_306_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1095ui_story"].transform.position).z)
				arg_306_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["1095ui_story"].transform.localEulerAngles = arg_306_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 then
				arg_306_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_306_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1095ui_story"].transform.position).z)
				arg_306_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["1095ui_story"].transform.localEulerAngles = arg_306_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_309_1 = arg_306_1.actors_["1095ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_1) and arg_306_1.var_.characterEffect1095ui_story == nil then
				arg_306_1.var_.characterEffect1095ui_story = var_309_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_2 and not isNil(var_309_1) then
				if arg_306_1.var_.characterEffect1095ui_story and not isNil(var_309_1) then
					arg_306_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_2)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_2 and arg_306_1.time_ < 0 + var_309_2 + arg_309_0 and not isNil(var_309_1) and arg_306_1.var_.characterEffect1095ui_story then
				arg_306_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_309_3 = arg_306_1.actors_["4040ui_story"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos4040ui_story = var_309_3.localPosition
			end

			local var_309_4 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				var_309_3.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_306_1.time_ - 0) / var_309_4)
				var_309_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_3.position).x, (manager.ui.mainCamera.transform.position - var_309_3.position).y, (manager.ui.mainCamera.transform.position - var_309_3.position).z)
				var_309_3.localEulerAngles.z = 0
				var_309_3.localEulerAngles.x = 0
				var_309_3.localEulerAngles = var_309_3.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				var_309_3.localPosition = Vector3.New(0, 100, 0)
				var_309_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_3.position).x, (manager.ui.mainCamera.transform.position - var_309_3.position).y, (manager.ui.mainCamera.transform.position - var_309_3.position).z)
				var_309_3.localEulerAngles.z = 0
				var_309_3.localEulerAngles.x = 0
				var_309_3.localEulerAngles = var_309_3.localEulerAngles
			end

			local var_309_5 = arg_306_1.actors_["4040ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_5) and arg_306_1.var_.characterEffect4040ui_story == nil then
				arg_306_1.var_.characterEffect4040ui_story = var_309_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_6 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_6 and not isNil(var_309_5) then
				if arg_306_1.var_.characterEffect4040ui_story and not isNil(var_309_5) then
					arg_306_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_306_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_6)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_6 and arg_306_1.time_ < 0 + var_309_6 + arg_309_0 and not isNil(var_309_5) and arg_306_1.var_.characterEffect4040ui_story then
				arg_306_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_306_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_309_7 = 0
			local var_309_8 = 1.35

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_7 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_9 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(319591074).content)

				arg_306_1.text_.text = var_309_9

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_11 = 54 <= 0 and var_309_8 or var_309_8 * (utf8.len(var_309_9) / 54)

				if (54 <= 0 and var_309_8 or var_309_8 * (utf8.len(var_309_9) / 54)) > 0 and var_309_8 < var_309_11 then
					arg_306_1.talkMaxDuration = var_309_11

					if var_309_11 + var_309_7 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_11 + var_309_7
					end
				end

				arg_306_1.text_.text = var_309_9
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_12 = math.max(var_309_8, arg_306_1.talkMaxDuration)

			if var_309_7 <= arg_306_1.time_ and arg_306_1.time_ < var_309_7 + var_309_12 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_7) / var_309_12

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_7 + var_309_12 and arg_306_1.time_ < var_309_7 + var_309_12 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_306_1:InitPlayNodeList()
	end,
	Play319591075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 319591075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play319591076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 1.05

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_1 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(319591075).content)

				arg_310_1.text_.text = var_313_1

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_3 = 42 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 42)

				if (42 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 42)) > 0 and var_313_0 < var_313_3 then
					arg_310_1.talkMaxDuration = var_313_3

					if var_313_3 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_3 + 0
					end
				end

				arg_310_1.text_.text = var_313_1
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_4 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_4

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play319591076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 319591076
		arg_314_1.duration_ = 3.23

		local var_314_0 = {
			zh = 2.5,
			ja = 3.233
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play319591077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos10079ui_story = arg_314_1.actors_["10079ui_story"].transform.localPosition

				arg_314_1:ShowWeapon(arg_314_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_317_0 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 then
				arg_314_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_314_1.time_ - 0) / var_317_0)
				arg_314_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10079ui_story"].transform.position).z)
				arg_314_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["10079ui_story"].transform.localEulerAngles = arg_314_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 then
				arg_314_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_314_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10079ui_story"].transform.position).z)
				arg_314_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["10079ui_story"].transform.localEulerAngles = arg_314_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_317_1 = arg_314_1.actors_["10079ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect10079ui_story == nil then
				arg_314_1.var_.characterEffect10079ui_story = var_317_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_2 and not isNil(var_317_1) then
				if arg_314_1.var_.characterEffect10079ui_story and not isNil(var_317_1) then
					arg_314_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_2 and arg_314_1.time_ < 0 + var_317_2 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect10079ui_story then
				arg_314_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_317_4 = 0
			local var_317_5 = 0.3

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_6 = arg_314_1:GetWordFromCfg(319591076)
				local var_317_7 = arg_314_1:FormatText(var_317_6.content)

				arg_314_1.text_.text = var_317_7

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_9 = 12 <= 0 and var_317_5 or var_317_5 * (utf8.len(var_317_7) / 12)

				if (12 <= 0 and var_317_5 or var_317_5 * (utf8.len(var_317_7) / 12)) > 0 and var_317_5 < var_317_9 then
					arg_314_1.talkMaxDuration = var_317_9

					if var_317_9 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_4
					end
				end

				arg_314_1.text_.text = var_317_7
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591076", "story_v_out_319591.awb") ~= 0 then
					local var_317_10 = manager.audio:GetVoiceLength("story_v_out_319591", "319591076", "story_v_out_319591.awb") / 1000

					if var_317_10 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_4
					end

					if var_317_6.prefab_name ~= "" and arg_314_1.actors_[var_317_6.prefab_name] ~= nil then
						local var_317_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_6.prefab_name].transform, "story_v_out_319591", "319591076", "story_v_out_319591.awb")

						arg_314_1:RecordAudio("319591076", var_317_11)
						arg_314_1:RecordAudio("319591076", var_317_11)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_319591", "319591076", "story_v_out_319591.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_319591", "319591076", "story_v_out_319591.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_12 = math.max(var_317_5, arg_314_1.talkMaxDuration)

			if var_317_4 <= arg_314_1.time_ and arg_314_1.time_ < var_317_4 + var_317_12 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_4) / var_317_12

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_4 + var_317_12 and arg_314_1.time_ < var_317_4 + var_317_12 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
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

		arg_314_1:InitPlayNodeList()
	end,
	Play319591077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 319591077
		arg_318_1.duration_ = 7.83

		local var_318_0 = {
			zh = 5.433,
			ja = 7.833
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play319591078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos10079ui_story = arg_318_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_321_0 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 then
				arg_318_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_318_1.time_ - 0) / var_321_0)
				arg_318_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["10079ui_story"].transform.position).z)
				arg_318_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["10079ui_story"].transform.localEulerAngles = arg_318_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 then
				arg_318_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_318_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["10079ui_story"].transform.position).z)
				arg_318_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["10079ui_story"].transform.localEulerAngles = arg_318_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_321_1 = arg_318_1.actors_["10079ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect10079ui_story == nil then
				arg_318_1.var_.characterEffect10079ui_story = var_321_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_2 and not isNil(var_321_1) then
				if arg_318_1.var_.characterEffect10079ui_story and not isNil(var_321_1) then
					arg_318_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_318_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_2)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_2 and arg_318_1.time_ < 0 + var_321_2 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect10079ui_story then
				arg_318_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_318_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_321_3 = arg_318_1.actors_["4040ui_story"].transform

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos4040ui_story = var_321_3.localPosition
			end

			local var_321_4 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				var_321_3.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_318_1.time_ - 0) / var_321_4)
				var_321_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_3.position).x, (manager.ui.mainCamera.transform.position - var_321_3.position).y, (manager.ui.mainCamera.transform.position - var_321_3.position).z)
				var_321_3.localEulerAngles.z = 0
				var_321_3.localEulerAngles.x = 0
				var_321_3.localEulerAngles = var_321_3.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				var_321_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_321_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_3.position).x, (manager.ui.mainCamera.transform.position - var_321_3.position).y, (manager.ui.mainCamera.transform.position - var_321_3.position).z)
				var_321_3.localEulerAngles.z = 0
				var_321_3.localEulerAngles.x = 0
				var_321_3.localEulerAngles = var_321_3.localEulerAngles
			end

			local var_321_5 = arg_318_1.actors_["4040ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_5) and arg_318_1.var_.characterEffect4040ui_story == nil then
				arg_318_1.var_.characterEffect4040ui_story = var_321_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_6 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_6 and not isNil(var_321_5) then
				if arg_318_1.var_.characterEffect4040ui_story and not isNil(var_321_5) then
					arg_318_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_6 and arg_318_1.time_ < 0 + var_321_6 + arg_321_0 and not isNil(var_321_5) and arg_318_1.var_.characterEffect4040ui_story then
				arg_318_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_321_8 = 0
			local var_321_9 = 0.475

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_8 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_10 = arg_318_1:GetWordFromCfg(319591077)
				local var_321_11 = arg_318_1:FormatText(var_321_10.content)

				arg_318_1.text_.text = var_321_11

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_13 = 19 <= 0 and var_321_9 or var_321_9 * (utf8.len(var_321_11) / 19)

				if (19 <= 0 and var_321_9 or var_321_9 * (utf8.len(var_321_11) / 19)) > 0 and var_321_9 < var_321_13 then
					arg_318_1.talkMaxDuration = var_321_13

					if var_321_13 + var_321_8 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_13 + var_321_8
					end
				end

				arg_318_1.text_.text = var_321_11
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591077", "story_v_out_319591.awb") ~= 0 then
					local var_321_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591077", "story_v_out_319591.awb") / 1000

					if var_321_14 + var_321_8 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_14 + var_321_8
					end

					if var_321_10.prefab_name ~= "" and arg_318_1.actors_[var_321_10.prefab_name] ~= nil then
						local var_321_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_10.prefab_name].transform, "story_v_out_319591", "319591077", "story_v_out_319591.awb")

						arg_318_1:RecordAudio("319591077", var_321_15)
						arg_318_1:RecordAudio("319591077", var_321_15)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_319591", "319591077", "story_v_out_319591.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_319591", "319591077", "story_v_out_319591.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_16 = math.max(var_321_9, arg_318_1.talkMaxDuration)

			if var_321_8 <= arg_318_1.time_ and arg_318_1.time_ < var_321_8 + var_321_16 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_8) / var_321_16

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_8 + var_321_16 and arg_318_1.time_ < var_321_8 + var_321_16 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_318_1:InitPlayNodeList()
	end,
	Play319591078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 319591078
		arg_322_1.duration_ = 6.1

		local var_322_0 = {
			zh = 4.066,
			ja = 6.1
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play319591079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos1095ui_story = arg_322_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_325_0 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 then
				arg_322_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_322_1.time_ - 0) / var_325_0)
				arg_322_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1095ui_story"].transform.position).z)
				arg_322_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["1095ui_story"].transform.localEulerAngles = arg_322_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 then
				arg_322_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_322_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1095ui_story"].transform.position).z)
				arg_322_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["1095ui_story"].transform.localEulerAngles = arg_322_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_325_1 = arg_322_1.actors_["1095ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_1) and arg_322_1.var_.characterEffect1095ui_story == nil then
				arg_322_1.var_.characterEffect1095ui_story = var_325_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_2 and not isNil(var_325_1) then
				if arg_322_1.var_.characterEffect1095ui_story and not isNil(var_325_1) then
					arg_322_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_2 and arg_322_1.time_ < 0 + var_325_2 + arg_325_0 and not isNil(var_325_1) and arg_322_1.var_.characterEffect1095ui_story then
				arg_322_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_325_4 = arg_322_1.actors_["4040ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_4) and arg_322_1.var_.characterEffect4040ui_story == nil then
				arg_322_1.var_.characterEffect4040ui_story = var_325_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_5 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_5 and not isNil(var_325_4) then
				if arg_322_1.var_.characterEffect4040ui_story and not isNil(var_325_4) then
					arg_322_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_322_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_5)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_5 and arg_322_1.time_ < 0 + var_325_5 + arg_325_0 and not isNil(var_325_4) and arg_322_1.var_.characterEffect4040ui_story then
				arg_322_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_322_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_325_6 = arg_322_1.actors_["4040ui_story"].transform

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos4040ui_story = var_325_6.localPosition
			end

			local var_325_7 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				var_325_6.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_322_1.time_ - 0) / var_325_7)
				var_325_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_325_6.position).x, (manager.ui.mainCamera.transform.position - var_325_6.position).y, (manager.ui.mainCamera.transform.position - var_325_6.position).z)
				var_325_6.localEulerAngles.z = 0
				var_325_6.localEulerAngles.x = 0
				var_325_6.localEulerAngles = var_325_6.localEulerAngles
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				var_325_6.localPosition = Vector3.New(0, 100, 0)
				var_325_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_325_6.position).x, (manager.ui.mainCamera.transform.position - var_325_6.position).y, (manager.ui.mainCamera.transform.position - var_325_6.position).z)
				var_325_6.localEulerAngles.z = 0
				var_325_6.localEulerAngles.x = 0
				var_325_6.localEulerAngles = var_325_6.localEulerAngles
			end

			local var_325_8 = 0
			local var_325_9 = 0.4

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_8 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_10 = arg_322_1:GetWordFromCfg(319591078)
				local var_325_11 = arg_322_1:FormatText(var_325_10.content)

				arg_322_1.text_.text = var_325_11

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_13 = 16 <= 0 and var_325_9 or var_325_9 * (utf8.len(var_325_11) / 16)

				if (16 <= 0 and var_325_9 or var_325_9 * (utf8.len(var_325_11) / 16)) > 0 and var_325_9 < var_325_13 then
					arg_322_1.talkMaxDuration = var_325_13

					if var_325_13 + var_325_8 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_13 + var_325_8
					end
				end

				arg_322_1.text_.text = var_325_11
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591078", "story_v_out_319591.awb") ~= 0 then
					local var_325_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591078", "story_v_out_319591.awb") / 1000

					if var_325_14 + var_325_8 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_14 + var_325_8
					end

					if var_325_10.prefab_name ~= "" and arg_322_1.actors_[var_325_10.prefab_name] ~= nil then
						local var_325_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_10.prefab_name].transform, "story_v_out_319591", "319591078", "story_v_out_319591.awb")

						arg_322_1:RecordAudio("319591078", var_325_15)
						arg_322_1:RecordAudio("319591078", var_325_15)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_319591", "319591078", "story_v_out_319591.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_319591", "319591078", "story_v_out_319591.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_16 = math.max(var_325_9, arg_322_1.talkMaxDuration)

			if var_325_8 <= arg_322_1.time_ and arg_322_1.time_ < var_325_8 + var_325_16 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_8) / var_325_16

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_8 + var_325_16 and arg_322_1.time_ < var_325_8 + var_325_16 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_322_1:InitPlayNodeList()
	end,
	Play319591079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 319591079
		arg_326_1.duration_ = 5.63

		local var_326_0 = {
			zh = 5.266,
			ja = 5.633
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play319591080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos4040ui_story = arg_326_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_329_0 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				arg_326_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["4040ui_story"].transform.position).z)
				arg_326_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["4040ui_story"].transform.localEulerAngles = arg_326_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				arg_326_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_326_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["4040ui_story"].transform.position).z)
				arg_326_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["4040ui_story"].transform.localEulerAngles = arg_326_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_329_1 = arg_326_1.actors_["4040ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect4040ui_story == nil then
				arg_326_1.var_.characterEffect4040ui_story = var_329_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_2 and not isNil(var_329_1) then
				if arg_326_1.var_.characterEffect4040ui_story and not isNil(var_329_1) then
					arg_326_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_2 and arg_326_1.time_ < 0 + var_329_2 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect4040ui_story then
				arg_326_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_329_4 = arg_326_1.actors_["1095ui_story"].transform

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos1095ui_story = var_329_4.localPosition
			end

			local var_329_5 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_5 then
				var_329_4.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_326_1.time_ - 0) / var_329_5)
				var_329_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_4.position).x, (manager.ui.mainCamera.transform.position - var_329_4.position).y, (manager.ui.mainCamera.transform.position - var_329_4.position).z)
				var_329_4.localEulerAngles.z = 0
				var_329_4.localEulerAngles.x = 0
				var_329_4.localEulerAngles = var_329_4.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_5 and arg_326_1.time_ < 0 + var_329_5 + arg_329_0 then
				var_329_4.localPosition = Vector3.New(0, 100, 0)
				var_329_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_4.position).x, (manager.ui.mainCamera.transform.position - var_329_4.position).y, (manager.ui.mainCamera.transform.position - var_329_4.position).z)
				var_329_4.localEulerAngles.z = 0
				var_329_4.localEulerAngles.x = 0
				var_329_4.localEulerAngles = var_329_4.localEulerAngles
			end

			local var_329_6 = arg_326_1.actors_["1095ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_6) and arg_326_1.var_.characterEffect1095ui_story == nil then
				arg_326_1.var_.characterEffect1095ui_story = var_329_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_7 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 and not isNil(var_329_6) then
				if arg_326_1.var_.characterEffect1095ui_story and not isNil(var_329_6) then
					arg_326_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_7)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 and not isNil(var_329_6) and arg_326_1.var_.characterEffect1095ui_story then
				arg_326_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_329_8 = 0
			local var_329_9 = 0.3

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_8 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_10 = arg_326_1:GetWordFromCfg(319591079)
				local var_329_11 = arg_326_1:FormatText(var_329_10.content)

				arg_326_1.text_.text = var_329_11

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_13 = 12 <= 0 and var_329_9 or var_329_9 * (utf8.len(var_329_11) / 12)

				if (12 <= 0 and var_329_9 or var_329_9 * (utf8.len(var_329_11) / 12)) > 0 and var_329_9 < var_329_13 then
					arg_326_1.talkMaxDuration = var_329_13

					if var_329_13 + var_329_8 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_13 + var_329_8
					end
				end

				arg_326_1.text_.text = var_329_11
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319591", "319591079", "story_v_out_319591.awb") ~= 0 then
					local var_329_14 = manager.audio:GetVoiceLength("story_v_out_319591", "319591079", "story_v_out_319591.awb") / 1000

					if var_329_14 + var_329_8 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_14 + var_329_8
					end

					if var_329_10.prefab_name ~= "" and arg_326_1.actors_[var_329_10.prefab_name] ~= nil then
						local var_329_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_10.prefab_name].transform, "story_v_out_319591", "319591079", "story_v_out_319591.awb")

						arg_326_1:RecordAudio("319591079", var_329_15)
						arg_326_1:RecordAudio("319591079", var_329_15)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_319591", "319591079", "story_v_out_319591.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_319591", "319591079", "story_v_out_319591.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_16 = math.max(var_329_9, arg_326_1.talkMaxDuration)

			if var_329_8 <= arg_326_1.time_ and arg_326_1.time_ < var_329_8 + var_329_16 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_8) / var_329_16

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_8 + var_329_16 and arg_326_1.time_ < var_329_8 + var_329_16 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play319591080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 319591080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play319591081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["4040ui_story"]) and arg_330_1.var_.characterEffect4040ui_story == nil then
				arg_330_1.var_.characterEffect4040ui_story = arg_330_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["4040ui_story"]) then
				if arg_330_1.var_.characterEffect4040ui_story and not isNil(arg_330_1.actors_["4040ui_story"]) then
					arg_330_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_330_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["4040ui_story"]) and arg_330_1.var_.characterEffect4040ui_story then
				arg_330_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_330_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_333_1 = 0
			local var_333_2 = 0.775

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(319591080).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 31 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 31)

				if (31 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 31)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play319591081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 319591081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play319591082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos4040ui_story = arg_334_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_337_0 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 then
				arg_334_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_334_1.time_ - 0) / var_337_0)
				arg_334_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["4040ui_story"].transform.position).z)
				arg_334_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["4040ui_story"].transform.localEulerAngles = arg_334_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 then
				arg_334_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["4040ui_story"].transform.position).z)
				arg_334_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["4040ui_story"].transform.localEulerAngles = arg_334_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_337_1 = manager.ui.mainCamera.transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.shakeOldPos = var_337_1.localPosition
			end

			local var_337_2 = 0.6

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_2 then
				local var_337_3, var_337_4 = math.modf((arg_334_1.time_ - 0) / 0.066)

				var_337_1.localPosition = Vector3.New(var_337_4 * 0.13, var_337_4 * 0.13, var_337_4 * 0.13) + arg_334_1.var_.shakeOldPos
			end

			if arg_334_1.time_ >= 0 + var_337_2 and arg_334_1.time_ < 0 + var_337_2 + arg_337_0 then
				var_337_1.localPosition = arg_334_1.var_.shakeOldPos
			end

			local var_337_5 = 0

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.allBtn_.enabled = false
			end

			if arg_334_1.time_ >= var_337_5 + 0.6 and arg_334_1.time_ < var_337_5 + 0.6 + arg_337_0 then
				arg_334_1.allBtn_.enabled = true
			end

			local var_337_6 = 0
			local var_337_7 = 1

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_8 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(319591081).content)

				arg_334_1.text_.text = var_337_8

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_10 = 40 <= 0 and var_337_7 or var_337_7 * (utf8.len(var_337_8) / 40)

				if (40 <= 0 and var_337_7 or var_337_7 * (utf8.len(var_337_8) / 40)) > 0 and var_337_7 < var_337_10 then
					arg_334_1.talkMaxDuration = var_337_10

					if var_337_10 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_10 + var_337_6
					end
				end

				arg_334_1.text_.text = var_337_8
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_11 = math.max(var_337_7, arg_334_1.talkMaxDuration)

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_11 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_6) / var_337_11

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_6 + var_337_11 and arg_334_1.time_ < var_337_6 + var_337_11 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play319591082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 319591082
		arg_338_1.duration_ = 2.83

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play319591083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if arg_338_1.bgs_.STblack == nil then
				local var_341_0 = Object.Instantiate(arg_338_1.paintGo_)

				var_341_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_341_0.name = "STblack"
				var_341_0.transform.parent = arg_338_1.stage_.transform
				var_341_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_338_1.bgs_.STblack = var_341_0
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				local var_341_1 = arg_338_1.bgs_.STblack

				arg_338_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_341_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_341_2 = var_341_1:GetComponent("SpriteRenderer")

				if var_341_2 and var_341_2.sprite then
					local var_341_3 = 2 * (var_341_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_341_1.transform.localScale = Vector3.New(var_341_3 / var_341_2.sprite.bounds.size.y < var_341_3 * manager.ui.mainCameraCom_.aspect / var_341_2.sprite.bounds.size.x and var_341_3 * manager.ui.mainCameraCom_.aspect / var_341_2.sprite.bounds.size.x or var_341_3 / var_341_2.sprite.bounds.size.y, var_341_3 / var_341_2.sprite.bounds.size.y < var_341_3 * manager.ui.mainCameraCom_.aspect / var_341_2.sprite.bounds.size.x and var_341_3 * manager.ui.mainCameraCom_.aspect / var_341_2.sprite.bounds.size.x or var_341_3 / var_341_2.sprite.bounds.size.y, 0)
				end

				for iter_341_0, iter_341_1 in pairs(arg_338_1.bgs_) do
					if iter_341_0 ~= "STblack" then
						iter_341_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				local var_341_4 = arg_338_1.fswbg_.transform:Find("textbox/adapt/content") or arg_338_1.fswbg_.transform:Find("textbox/content")
				local var_341_5 = arg_338_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_341_6 = var_341_4:GetComponent("RectTransform")

				var_341_4:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_341_6.offsetMin = Vector2.New(0, 0)
				var_341_6.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.fswbg_:SetActive(true)
				arg_338_1.dialog_:SetActive(false)

				arg_338_1.fswtw_.percent = 0
				arg_338_1.fswt_.text = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(319591082).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.fswt_)

				arg_338_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_338_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_338_1.fswtw_:SetDirty()

				arg_338_1.typewritterCharCountI18N = 0

				SetActive(arg_338_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_338_1:ShowNextGo(false)
			end

			local var_341_7 = 0.366666666666667

			if 0.366666666666667 < arg_338_1.time_ and arg_338_1.time_ <= var_341_7 + arg_341_0 then
				arg_338_1.var_.oldValueTypewriter = arg_338_1.fswtw_.percent

				SetActive(arg_338_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_338_1:ShowNextGo(false)
			end

			local var_341_8 = 12
			local var_341_9 = 0.8
			local var_341_10, var_341_11 = arg_338_1:GetPercentByPara(arg_338_1:FormatText(arg_338_1:GetWordFromCfg(319591082).content), 1)

			if var_341_7 < arg_338_1.time_ and arg_338_1.time_ <= var_341_7 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0

				local var_341_12 = var_341_8 <= 0 and var_341_9 or var_341_9 * ((var_341_11 - arg_338_1.typewritterCharCountI18N) / var_341_8)

				if (var_341_8 <= 0 and var_341_9 or var_341_9 * ((var_341_11 - arg_338_1.typewritterCharCountI18N) / var_341_8)) > 0 and var_341_9 < var_341_12 then
					arg_338_1.talkMaxDuration = var_341_12

					if var_341_12 + var_341_7 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_12 + var_341_7
					end
				end
			end

			local var_341_13 = math.max(0.8, arg_338_1.talkMaxDuration)

			if var_341_7 <= arg_338_1.time_ and arg_338_1.time_ < var_341_7 + var_341_13 then
				arg_338_1.fswtw_.percent = Mathf.Lerp(arg_338_1.var_.oldValueTypewriter, var_341_10, (arg_338_1.time_ - var_341_7) / var_341_13)
				arg_338_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_338_1.fswtw_:SetDirty()
			end

			if arg_338_1.time_ >= var_341_7 + var_341_13 and arg_338_1.time_ < var_341_7 + var_341_13 + arg_341_0 then
				arg_338_1.fswtw_.percent = var_341_10

				arg_338_1.fswtw_:SetDirty()
				arg_338_1:ShowNextGo(true)

				arg_338_1.typewritterCharCountI18N = var_341_11
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.cswbg_:SetActive(true)

				local var_341_14 = arg_338_1.cswt_:GetComponent("RectTransform")

				arg_338_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_341_14.offsetMin = Vector2.New(410, 330)
				var_341_14.offsetMax = Vector2.New(-400, -175)
				arg_338_1.cswt_.text = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(419031).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.cswt_)

				arg_338_1.cswt_.fontSize = 180
				arg_338_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_338_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_338_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_341_15 = arg_338_1.actors_["4040ui_story"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos4040ui_story = var_341_15.localPosition
			end

			local var_341_16 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_16 then
				var_341_15.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_338_1.time_ - 0) / var_341_16)
				var_341_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_15.position).x, (manager.ui.mainCamera.transform.position - var_341_15.position).y, (manager.ui.mainCamera.transform.position - var_341_15.position).z)
				var_341_15.localEulerAngles.z = 0
				var_341_15.localEulerAngles.x = 0
				var_341_15.localEulerAngles = var_341_15.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_16 and arg_338_1.time_ < 0 + var_341_16 + arg_341_0 then
				var_341_15.localPosition = Vector3.New(0, 100, 0)
				var_341_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_15.position).x, (manager.ui.mainCamera.transform.position - var_341_15.position).y, (manager.ui.mainCamera.transform.position - var_341_15.position).z)
				var_341_15.localEulerAngles.z = 0
				var_341_15.localEulerAngles.x = 0
				var_341_15.localEulerAngles = var_341_15.localEulerAngles
			end

			local var_341_17 = 0.366666666666667
			local var_341_18 = manager.audio:GetVoiceLength("story_v_out_319591", "319591082", "story_v_out_319591.awb") / 1000

			if var_341_18 > 0 and 2.466 < var_341_18 and var_341_18 + var_341_17 > arg_338_1.duration_ then
				arg_338_1.duration_ = var_341_18 + var_341_17
			end

			if var_341_17 < arg_338_1.time_ and arg_338_1.time_ <= var_341_17 + arg_341_0 then
				arg_338_1:AudioAction("play", "voice", "story_v_out_319591", "319591082", "story_v_out_319591.awb")
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play319591083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 319591083
		arg_342_1.duration_ = 1

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
			arg_342_1.auto_ = false
		end

		function arg_342_1.playNext_(arg_344_0)
			arg_342_1.onStoryFinished_()
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.fswbg_:SetActive(true)
				arg_342_1.dialog_:SetActive(false)

				arg_342_1.fswtw_.percent = 0
				arg_342_1.fswt_.text = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(319591083).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.fswt_)

				arg_342_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_342_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_342_1.fswtw_:SetDirty()

				arg_342_1.typewritterCharCountI18N = 0

				SetActive(arg_342_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_342_1:ShowNextGo(false)
			end

			local var_345_0 = 0.2

			if 0.2 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.var_.oldValueTypewriter = arg_342_1.fswtw_.percent

				SetActive(arg_342_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_342_1:ShowNextGo(false)
			end

			local var_345_1 = 10
			local var_345_2 = 0.666666666666667
			local var_345_3, var_345_4 = arg_342_1:GetPercentByPara(arg_342_1:FormatText(arg_342_1:GetWordFromCfg(319591083).content), 1)

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0

				local var_345_5 = var_345_1 <= 0 and var_345_2 or var_345_2 * ((var_345_4 - arg_342_1.typewritterCharCountI18N) / var_345_1)

				if (var_345_1 <= 0 and var_345_2 or var_345_2 * ((var_345_4 - arg_342_1.typewritterCharCountI18N) / var_345_1)) > 0 and var_345_2 < var_345_5 then
					arg_342_1.talkMaxDuration = var_345_5

					if var_345_5 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + var_345_0
					end
				end
			end

			local var_345_6 = math.max(0.666666666666667, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_6 then
				arg_342_1.fswtw_.percent = Mathf.Lerp(arg_342_1.var_.oldValueTypewriter, var_345_3, (arg_342_1.time_ - var_345_0) / var_345_6)
				arg_342_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_342_1.fswtw_:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_6 and arg_342_1.time_ < var_345_0 + var_345_6 + arg_345_0 then
				arg_342_1.fswtw_.percent = var_345_3

				arg_342_1.fswtw_:SetDirty()
				arg_342_1:ShowNextGo(true)

				arg_342_1.typewritterCharCountI18N = var_345_4
			end

			local var_345_7 = 0.2
			local var_345_8 = manager.audio:GetVoiceLength("story_v_out_319591", "319591083", "story_v_out_319591.awb") / 1000

			if var_345_8 > 0 and 0.266666666666667 < var_345_8 and var_345_8 + var_345_7 > arg_342_1.duration_ then
				arg_342_1.duration_ = var_345_8 + var_345_7
			end

			if var_345_7 < arg_342_1.time_ and arg_342_1.time_ <= var_345_7 + arg_345_0 then
				arg_342_1:AudioAction("play", "voice", "story_v_out_319591", "319591083", "story_v_out_319591.awb")
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I12h",
		"TextureConfig/Background/A08f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/I10f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319591.awb"
	}
}
